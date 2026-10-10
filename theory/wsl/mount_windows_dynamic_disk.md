# Mount a Windows dynamic USB disk read-only in WSL2

This guide connects a USB hard drive to WSL, assembles its Windows dynamic-disk (LDM) volume, and mounts the NTFS filesystem **read-only**.

The commands below use device and volume identifiers. Recheck the USB bus ID and Linux disk name each time you reconnect the drive; do not assume they will always be the same values.

## 1. Install usbipd-win

Run in Windows PowerShell:

```pwsh
# VPN OFF
WinGet install --id dorssel.usbipd-win
```

If `usbipd` is not found afterward, reopen PowerShell.

The installer normally creates a Windows Firewall rule named `usbipd`, allowing local subnets to reach the service. You should not need to add another rule unless the connection is blocked.

## 2. Find the USB device

Run in PowerShell:

```pwsh
usbipd list
```

Find USB storage adapter:

```text
VID:PID     DEVICE
152d:0583   Запоминающее USB-устройство SCSI (UAS)
```

Note its `BUSID`. In example:

```text
2-3
```

Close any Windows applications using the drive before attaching it to WSL. While attached to WSL, the device is unavailable to Windows.

## 3. Share the device with usbipd

Open PowerShell **as Administrator**:

```pwsh
usbipd bind --busid 2-3
usbipd list
```

`bind` registers the device as shared with usbipd so that a USB/IP client, including WSL, can attach to it. It does not mount the disk or attach it to Linux. Administrator privileges are required for this step; check `usbipd list` afterward to confirm that the device is shared.

Do not rely on the command printing a particular success message.

## 4. Attach the device to WSL

Keep an Ubuntu/WSL terminal open, then run in PowerShell:

```pwsh
usbipd attach --wsl --busid 2-3
usbipd list
```

Attaching does not require an elevated PowerShell session. The device becomes available to WSL 2 distributions.

If attachment succeeds, continue to step 5.

### If attachment fails with a firewall warning

For example:

```text
usbipd: warning: A firewall appears to be blocking the connection;
ensure TCP port 3240 is allowed.
WSL usbip: error: tcp connect
usbipd: error: Failed to attach device with busid '2-3'.
```

USB/IP uses TCP port `3240`. Inspect the existing rule first, from an administrator PowerShell session:

```pwsh
Get-NetFirewallRule -DisplayName "usbipd*" |
    Format-Table DisplayName, Enabled, Direction, Action
```

If necessary, add an inbound rule scoped to the local subnet rather than allowing connections from every address:

```pwsh
New-NetFirewallRule `
    -DisplayName "Allow usbipd WSL" `
    -Direction Inbound `
    -LocalPort 3240 `
    -Protocol TCP `
    -RemoteAddress LocalSubnet `
    -Action Allow
```

Then retry:

```pwsh
usbipd attach --wsl --busid 2-3
```

A third-party firewall or VPN can also interfere. If permitted by network policy, temporarily disconnect the VPN to test; do not disable the entire firewall. The usbipd project documents cases where another firewall blocked the connection despite the installed Windows rule.

Do not use this command as a routine fix:

```pwsh
# Broad WSL firewall change - not a targeted usbipd rule:
Set-NetFirewallHyperVVMSetting `
    -Name '{40E0AC32-46A5-438A-A0B2-2B479E8F2E90}' `
    -DefaultInboundAction Allow
```

It changes the default inbound policy for WSL's Hyper-V firewall, not just access to usbipd. Microsoft documents it for allowing inbound connections to WSL; it is not equivalent to opening the Windows-host USB/IP service on TCP `3240`.

## 5. Install the Linux tools

Run inside Ubuntu/WSL:

```bash
# VPN OFF
sudo apt update
sudo apt install ldmtool ntfs-3g
```

`ldmtool` reads Windows dynamic-disk metadata and creates Linux device-mapper devices for its volumes. Creating a mapping does not create or format a new Windows volume, and `ldmtool` does not modify the LDM metadata itself.

## 6. Identify the physical disk

Inside WSL:

```bash
lsblk -o NAME,SIZE,MODEL,FSTYPE,RO,MOUNTPOINTS
```

Example showed:

```text
sde      1.8T WDC WD20EZRZ-00Z5HB0
└─sde1   1.8T
```

For the following commands, the external disk is `/dev/sde`.

Verify the size, model, and mount points before continuing. Do not use the WSL system disk, and stop if any partition on the target disk is already mounted.

## 7. Mark the disk read-only

Using the disk and partition names verified above:

```bash
sudo blockdev --setro /dev/sde
sudo blockdev --setro /dev/sde1
```

Check the result:

```bash
lsblk -o NAME,SIZE,RO,MOUNTPOINTS /dev/sde
```

Both entries should show `1` in the `RO` column.

## 8. Inspect the Windows dynamic-disk metadata

Scan the disk:

```bash
sudo ldmtool scan /dev/sde
```

Result:

```json
[
  "626ed8b0-390c-11f1-aeda-047c16801bda"
]
```

Inspect that disk group:

```bash
sudo ldmtool show diskgroup 626ed8b0-390c-11f1-aeda-047c16801bda
```

Result:

```json
{
  "name": "DESKTOP-BIP2PJ4-Dg0",
  "guid": "626ed8b0-390c-11f1-aeda-047c16801bda",
  "volumes": ["Volume1"],
  "disks": ["Disk1"]
}
```

Inspect the volume:

```bash
sudo ldmtool show volume \
  626ed8b0-390c-11f1-aeda-047c16801bda Volume1
```

Result identifies `Volume1` as `spanned`, with two extents:

```json
{
  "name": "Volume1",
  "guid": "0145ea72-0000-0000-0000-602200000000",
  "type": "spanned",
  "size": 3907020800,
  "chunk-size": 0,
  "hint": "D:",
  "partitions": ["Disk1-01", "Disk1-02"]
}
```

In output, the disk group lists one disk, `Disk1`, and both extent names reference it. Do not interpret the two listed extents as necessarily meaning two physical disks.

## 9. Create the Linux volume mapping

```bash
sudo ldmtool create volume \
  626ed8b0-390c-11f1-aeda-047c16801bda Volume1
```

Expected output for disk:

```json
[
  "ldm_vol_DESKTOP-BIP2PJ4-Dg0_Volume1"
]
```

This exposes the assembled volume at:

```text
/dev/mapper/ldm_vol_DESKTOP-BIP2PJ4-Dg0_Volume1
```

Mount the mapped volume, not `/dev/sde1` directly: the mapper assembles the volume according to its LDM metadata.

As an additional safeguard, mark the mapped device read-only too:

```bash
sudo blockdev --setro \
  /dev/mapper/ldm_vol_DESKTOP-BIP2PJ4-Dg0_Volume1
```

## 10. Mount and browse the files

Create the mount point and mount the volume read-only:

```bash
sudo mkdir -p /mnt/hdd

sudo mount -t ntfs-3g -o ro \
  /dev/mapper/ldm_vol_DESKTOP-BIP2PJ4-Dg0_Volume1 \
  /mnt/hdd
```

Check the mount and list its contents:

```bash
findmnt /mnt/hdd
ls -la /mnt/hdd
```

Open the folder in Windows Explorer:

```bash
cd /mnt/hdd
explorer.exe .
```

If mounting fails, stop and inspect the error rather than formatting, initializing, or running repair commands on the disk.

## 11. Unmount and detach

Close Explorer windows and applications accessing the mounted folder.

Inside WSL, leave the mount directory and unmount it:

```bash
cd ~
sudo umount /mnt/hdd
```

If unmounting reports that the target is busy, close the remaining users of the folder and retry. Do not detach the USB device while the filesystem is still mounted.

After unmounting succeeds, run in Windows PowerShell:

```pwsh
usbipd detach --busid 2-3
```

Detaching returns the USB device to Windows. It does not undo the sharing configuration established by `bind`.
