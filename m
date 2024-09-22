Return-Path: <linux-ext4+bounces-4261-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F62797E258
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Sep 2024 17:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 126131F21265
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Sep 2024 15:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D05DF60;
	Sun, 22 Sep 2024 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGWo9jA0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861AD63D
	for <linux-ext4@vger.kernel.org>; Sun, 22 Sep 2024 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727020069; cv=none; b=ZiWSwjCAdANA1WpdAQM8A4xnJ1XLgcrEYC8gm9L/kMIJk8khYNF3usocpVsKkD5jn4heMuRTbOaV3N2xewotDxQ7FiaZrsFhIXCkXIRwdeJYCDVRuA/IYWHulT3lQLNkjmB+nC8Ln5v7vBX3QGDWGHb4phW7gAZOI+gZrglBye4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727020069; c=relaxed/simple;
	bh=InVN4vFcE6Sow6tmxxyh4Rw5ZxodKTwUiX9SeS7pa4E=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SUsnQogkt3og8Nzj0XoLOF/6aAHNW7ejwi/utFSqCTgneHYssE1bghIRzc9ESy9+NMULkOD2W6rLCdNKWreG9GE0G/ZPec2WThdSsBQ6S2H+hT1VWJQ+3sQI2A0IDxOO68EcuopkwXzMyN9PHnF7UqTcKzY0F9hSQ1RnP0zQ5J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGWo9jA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D144C4CECE
	for <linux-ext4@vger.kernel.org>; Sun, 22 Sep 2024 15:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727020069;
	bh=InVN4vFcE6Sow6tmxxyh4Rw5ZxodKTwUiX9SeS7pa4E=;
	h=From:To:Subject:Date:From;
	b=nGWo9jA0n99IdRUcQb6Wknr9q+IXjhcAm7utKPdsmLd7EHo5u16bl/sIa7OpPwkxE
	 YtIhKFTtQ5x9KLnjNrOfpm/7gQX7NhAS9v4gbSQJnqQ+h/AHecx/oKXHJC2qMva6ea
	 PNSqEy1wRoHBuW/V9cg3j0EoyC08kSqXdf1t4zgy7z93xY8Unq/Jcv9D9Hr3MmtOus
	 8Q3uMEjerE8kxxS2m1l1if4cCiWhdEPFYgxYViJn09anrOXQBr8tBuPPYXu757g8YT
	 pE0IA+Y1tQf+/a6e3r7ZtCT2YNGAjF9GDq8DIbtqOB5XZwTy6Vbt906VEcL3S133gJ
	 rXRziY7RUb5DQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id F118AC53BC5; Sun, 22 Sep 2024 15:47:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219300] New: ext4 corrupts data on a specific pendrive
Date: Sun, 22 Sep 2024 15:47:48 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: linuxnormaluser@proton.me
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219300-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D219300

            Bug ID: 219300
           Summary: ext4 corrupts data on a specific pendrive
           Product: File System
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: linuxnormaluser@proton.me
        Regression: No

Hi, copying data to a specific pendrive with the ext4 file system does not =
work
correctly, i.e. the data is damaged after copying. My observations lead me =
to
believe that this is caused by some bug in the Linux kernel. Below I will l=
ist
all relevant observations.

Steps to reproduce:
1. Create an ext4 filesystem using any kernel >=3D5 (<5 not tested) on a sp=
ecific
pendrive model. Pendrive: Intenso Speed Line, idVendor=3D346d, idProduct=3D=
5678,
31.5 GB/29.3GiB=20
2. Copy at least a few GB of data in the form of several files to the menti=
oned
pendrive. E.g. at least five files of 1 GB each.
3. Compare the checksums of the files on the host and on the flash drive.
4. At least some files are inconsistent. If not, then unmount and remount t=
he
file system or restart your computer and check the checksums again.

Counterexample:
1. Do the same as above, this time with the ntfs instead of ext4.
2. All files are always consistent.

My observations:
- The problem occurs every time I copy at least a few GB of data.
- The problem occurs on various Linux operating systems (gentoo kernel 6.6.=
47,
6.6.38, arch kernel 5.x, arch kernel 6.10.7, ubuntu 24.04 LTS kernel
6.8.0-41-generic). So I assume that the problem has been present for a long
time and probably also in the latest version.
- I notice a difference between older kernels and version 6.10.7 (arch linu=
x).
In the case of 6.10.7, the problem does not occur immediately, but only aft=
er
remounting the files or restarting the computer.
- I verify the data using crc32 or sha256 checksum.
- I tested on two different machines.
- The host has been tested by memtest. There were no errors.
- The problem concerns a specific pendrive model. I have two physical pendr=
ives
of the exact same model and both of them have this problem. Other models, e=
ven
from the same manufacturer, do not cause the problem. Models that cause the
problem: Intenso Speed Line, idVendor=3D346d, idProduct=3D5678, 31.5 GB/29.=
3GiB=20
- The problem is not because I unmounted the device incorrectly or removed =
the
pendrive too quickly.=20
- Below is an example of dmesg output.
- Typically, only the data gets corrupted when copied. However, sometimes t=
he
entire file system crashes. Below is an example from dmesg.
- The problem occurs in both USB 2 and USB 3 slots.
- Corrupt data is not the same every time. I.e. by copying the data twice, I
get two different checksums on the flash drive. The number of corrupted fil=
es
also varies.
- One might assume that the problem is the poor quality of the pendrive mod=
el,
but the problem does not occur at all on ntfs. Ntfs always works fine. Both=
 on
Windows and various Linux distributions.
- Copying to ntfs takes a short time. ext4 is over 10 times slower than ntfs
for this model.
- f2fs also corrupted the data, while extFAT did not. However, I have not
tested these file systems extensively.
- I looked for help on gentoo forum, but they were unable to help me there.
There is a discussion on this topic in the link below, but I have summarized
everything important here. https://forums.gentoo.org/viewtopic-t-1170536.ht=
ml

It seems that ntfs can handle this hardware correctly, but ext4 has some
problem.=20


Sample dmesg output during data corruption:=20
[20904.194233] usb 2-4: new high-speed USB device number 3 using xhci_hcd
[20904.322059] usb 2-4: New USB device found, idVendor=3D346d, idProduct=3D=
5678,
bcdDevice=3D 2.00
[20904.322076] usb 2-4: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D3
[20904.322083] usb 2-4: Product: Intenso Speed Line
[20904.322090] usb 2-4: Manufacturer: Intenso
[20904.322094] usb 2-4: SerialNumber: FC<replaced...>
[20904.323170] usb-storage 2-4:1.0: USB Mass Storage device detected
[20904.323543] scsi host6: usb-storage 2-4:1.0
[20905.374792] scsi 6:0:0:0: Direct-Access     Intenso  Speed Line       2.=
00
PQ: 0 ANSI: 4
[20905.375139] sd 6:0:0:0: Attached scsi generic sg1 type 0
[20905.376508] sd 6:0:0:0: [sdb] 61440000 512-byte logical blocks: (31.5
GB/29.3 GiB)
[20905.376780] sd 6:0:0:0: [sdb] Write Protect is off
[20905.376786] sd 6:0:0:0: [sdb] Mode Sense: 03 00 00 00
[20905.376921] sd 6:0:0:0: [sdb] No Caching mode page found
[20905.376924] sd 6:0:0:0: [sdb] Assuming drive cache: write through
[20905.389018]  sdb: sdb1
[20905.389331] sd 6:0:0:0: [sdb] Attached SCSI removable disk
[20931.947073]  sdb: sdb1
[20931.969695]  sdb: sdb1
[20977.720825] EXT4-fs (sdb1): mounted filesystem
28b0a704-e5b8-4dee-aab5-316b73b481a4 r/w with ordered data mode. Quota mode:
none.
[21159.649524] usb 2-4: reset high-speed USB device number 3 using xhci_hcd
[21165.264260] usb 2-4: device descriptor read/64, error -110
[21329.633511] usb 2-4: reset high-speed USB device number 3 using xhci_hcd
[21335.248339] usb 2-4: device descriptor read/64, error -110
[21506.786497] usb 2-4: reset high-speed USB device number 3 using xhci_hcd
[21512.400341] usb 2-4: device descriptor read/64, error -110
[21858.529543] usb 2-4: reset high-speed USB device number 3 using xhci_hcd
[21864.144299] usb 2-4: device descriptor read/64, error -110
[22010.598453] usb 2-4: reset high-speed USB device number 3 using xhci_hcd
[22016.209332] usb 2-4: device descriptor read/64, error -110
[22402.785528] usb 2-4: reset high-speed USB device number 3 using xhci_hcd
[22408.400301] usb 2-4: device descriptor read/64, error -110
[22542.562424] usb 2-4: reset high-speed USB device number 3 using xhci_hcd
[22548.176319] usb 2-4: device descriptor read/64, error -110
[22658.273592] usb 2-4: reset high-speed USB device number 3 using xhci_hcd
[22663.888296] usb 2-4: device descriptor read/64, error -110
...
[23482.082529] usb 2-4: reset high-speed USB device number 3 using xhci_hcd
[23487.697333] usb 2-4: device descriptor read/64, error -110
[23776.993521] usb 2-4: reset high-speed USB device number 3 using xhci_hcd
[23782.608362] usb 2-4: device descriptor read/64, error -110


Another sample dmesg output during data corruption:=20
[31547.744532] usb 4-4: new SuperSpeed USB device number 2 using xhci_hcd
[31547.757338] usb 4-4: LPM exit latency is zeroed, disabling LPM.
[31547.758379] usb 4-4: New USB device found, idVendor=3D346d, idProduct=3D=
5678,
bcdDevice=3D 2.00
[31547.758390] usb 4-4: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D3
[31547.758394] usb 4-4: Product: Intenso Speed Line
[31547.758398] usb 4-4: Manufacturer: Intenso
[31547.758401] usb 4-4: SerialNumber: FC<replaced...>
[31547.759224] usb-storage 4-4:1.0: USB Mass Storage device detected
[31547.759634] scsi host6: usb-storage 4-4:1.0
[31548.766861] scsi 6:0:0:0: Direct-Access     Intenso  Speed Line       2.=
00
PQ: 0 ANSI: 4
[31548.767176] sd 6:0:0:0: Attached scsi generic sg1 type 0
[31548.768220] sd 6:0:0:0: [sdb] 61440000 512-byte logical blocks: (31.5
GB/29.3 GiB)
[31548.768375] sd 6:0:0:0: [sdb] Write Protect is off
[31548.768380] sd 6:0:0:0: [sdb] Mode Sense: 03 00 00 00
[31548.768503] sd 6:0:0:0: [sdb] No Caching mode page found
[31548.768507] sd 6:0:0:0: [sdb] Assuming drive cache: write through
[31548.777093] Alternate GPT is invalid, using primary GPT.
[31548.777106]  sdb: sdb1
[31548.777407] sd 6:0:0:0: [sdb] Attached SCSI removable disk
[31562.696274]  sdb: sdb1
[33457.510450]  sdb: sdb1
[33457.532279]  sdb: sdb1
[33555.769208] EXT4-fs (sdb1): mounted filesystem
6660ff4e-c384-405c-be0e-86737a393344 r/w with ordered data mode. Quota mode:
none.
[33986.273861] usb 4-4: reset SuperSpeed USB device number 2 using xhci_hcd
[33987.553302] usb 4-4: LPM exit latency is zeroed, disabling LPM.
[34132.705880] usb 4-4: reset SuperSpeed USB device number 2 using xhci_hcd
[34133.691058] usb 4-4: LPM exit latency is zeroed, disabling LPM.
[34734.306884] usb 4-4: reset SuperSpeed USB device number 2 using xhci_hcd
[34735.012621] usb 4-4: LPM exit latency is zeroed, disabling LPM.
[34769.121882] usb 4-4: reset SuperSpeed USB device number 2 using xhci_hcd
[34769.838692] usb 4-4: LPM exit latency is zeroed, disabling LPM.
[35411.681919] usb 4-4: reset SuperSpeed USB device number 2 using xhci_hcd
[35411.771220] usb 4-4: LPM exit latency is zeroed, disabling LPM.
[35447.009831] usb 4-4: reset SuperSpeed USB device number 2 using xhci_hcd
[35447.944211] usb 4-4: LPM exit latency is zeroed, disabling LPM.


Sample console/dmesg output when the entire filesystem is corrupted:
cp: error writing '<replaced...>': Input/output error=20
cp: cannot create regular file '<replaced...>': Read-only file system=20
cp: cannot create regular file '<replaced...>': Read-only file system=20
cp: cannot create regular file '<replaced...>': Read-only file system=20

...=20

[ 8202.825924] EXT4-fs (sdb1): mounted filesystem
84c42b25-807a-494f-a8de-bbb280c21d38 r/w with ordered data mode. Quota mode:
none.=20
[ 8207.481253] EXT4-fs error (device sdb1): ext4_validate_block_bitmap:421:
comm ext4lazyinit: bg 176: bad block bitmap checksum=20
[ 8228.651866] EXT4-fs (sdb1): unmounting filesystem
84c42b25-807a-494f-a8de-bbb280c21d38.=20
[ 8237.434827] EXT4-fs (sdb1): warning: mounting fs with errors, running e2=
fsck
is recommended=20
[ 8237.435636] EXT4-fs (sdb1): mounted filesystem
84c42b25-807a-494f-a8de-bbb280c21d38 r/w with ordered data mode. Quota mode:
none.=20
[ 8238.993344] EXT4-fs error (device sdb1): ext4_validate_block_bitmap:421:
comm ext4lazyinit: bg 176: bad block bitmap checksum=20

...=20

[ 8557.663116] EXT4-fs (sdb1): error count since last fsck: 3=20
[ 8557.663137] EXT4-fs (sdb1): initial error at time 1725382598:
ext4_validate_block_bitmap:421=20
[ 8557.663148] EXT4-fs (sdb1): last error at time 1725383358:
ext4_validate_block_bitmap:421=20

...=20

[11843.298598] usb 2-2: reset high-speed USB device number 2 using xhci_hcd=
=20
[11844.103802] usb 2-2: device firmware changed=20
[11844.103922] usb 2-2: USB disconnect, device number 2=20
[11844.111282] device offline error, dev sdb, sector 60278752 op 0x1:(WRITE)
flags 0x0 phys_seg 1 prio class 2=20
[11844.111301] EXT4-fs warning (device sdb1): ext4_end_bio:343: I/O error 17
writing to inode 20 starting block 7534844)=20
[11844.111331] device offline error, dev sdb, sector 60286976 op 0x1:(WRITE)
flags 0x4000 phys_seg 2 prio class 2=20
[11844.111377] device offline error, dev sdb, sector 60287216 op 0x1:(WRITE)
flags 0x4000 phys_seg 2 prio class 2=20
[11844.111399] device offline error, dev sdb, sector 60287456 op 0x1:(WRITE)
flags 0x4000 phys_seg 3 prio class 2=20
[11844.111425] device offline error, dev sdb, sector 60287696 op 0x1:(WRITE)
flags 0x4000 phys_seg 2 prio class 2=20
[11844.111434] device offline error, dev sdb, sector 60287936 op 0x1:(WRITE)
flags 0x4000 phys_seg 3 prio class 2=20
[11844.111450] device offline error, dev sdb, sector 60288176 op 0x1:(WRITE)
flags 0x4000 phys_seg 2 prio class 2=20
[11844.111460] device offline error, dev sdb, sector 29749456 op 0x1:(WRITE)
flags 0x9800 phys_seg 10 prio class 2=20
[11844.111492] device offline error, dev sdb, sector 60288416 op 0x1:(WRITE)
flags 0x4000 phys_seg 3 prio class 2=20
[11844.111504] Aborting journal on device sdb1-8.=20
[11844.111509] device offline error, dev sdb, sector 60288656 op 0x1:(WRITE)
flags 0x4000 phys_seg 2 prio class 2=20
[11844.111522] Buffer I/O error on dev sdb1, logical block 3702784, lost sy=
nc
page write=20
[11844.111521] EXT4-fs error (device sdb1) in ext4_reserve_inode_write:5787:
Journal has aborted=20
[11844.111523] EXT4-fs error (device sdb1) in ext4_reserve_inode_write:5787:
Journal has aborted=20
[11844.111534] EXT4-fs error (device sdb1):
ext4_convert_unwritten_extents:4849: inode #20: comm kworker/u16:2:
mark_inode_dirty error=20
[11844.111539] EXT4-fs error (device sdb1): ext4_dirty_inode:5991: inode #2=
1:
comm cp: mark_inode_dirty error=20
[11844.111543] JBD2: I/O error when updating journal superblock for sdb1-8.=
=20
[11844.111545] EXT4-fs error (device sdb1) in
ext4_convert_unwritten_io_end_vec:4888: Journal has aborted=20
[11844.111551] EXT4-fs error (device sdb1) in ext4_dirty_inode:5992: Journal
has aborted=20
[11844.111553] EXT4-fs (sdb1): failed to convert unwritten extents to writt=
en
extents -- potential data loss!=C2=A0 (inode 20, error -30)=20
[11844.111565] Buffer I/O error on device sdb1, logical block 7533568=20
[11844.111574] Buffer I/O error on device sdb1, logical block 7533569=20
[11844.111577] Buffer I/O error on device sdb1, logical block 7533570=20
[11844.111580] Buffer I/O error on device sdb1, logical block 7533571=20
[11844.111583] Buffer I/O error on device sdb1, logical block 7533572=20
[11844.111586] Buffer I/O error on device sdb1, logical block 7533573=20
[11844.111588] Buffer I/O error on device sdb1, logical block 7533574=20
[11844.111591] Buffer I/O error on device sdb1, logical block 7533575=20
[11844.111594] Buffer I/O error on device sdb1, logical block 7533576=20
[11844.111596] Buffer I/O error on device sdb1, logical block 7533577=20
[11844.111757] EXT4-fs error (device sdb1): ext4_journal_check_start:84: co=
mm
kworker/u16:1: Detected aborted journal=20
[11844.111788] EXT4-fs warning (device sdb1): ext4_end_bio:343: I/O error 17
writing to inode 21 starting block 7536892)=20
[11844.111807] Buffer I/O error on dev sdb1, logical block 0, lost sync page
write=20
[11844.111816] EXT4-fs (sdb1): I/O error while writing superblock=20
[11844.111819] EXT4-fs (sdb1): Remounting filesystem read-only=20
[11844.111822] EXT4-fs (sdb1): ext4_do_writepages: jbd2_start: 1024 pages, =
ino
13; err -30=20
[11844.112653] Buffer I/O error on dev sdb1, logical block 0, lost sync page
write=20
[11844.112670] EXT4-fs (sdb1): I/O error while writing superblock=20
[11845.532320] usb 2-2: new high-speed USB device number 3 using xhci_hcd=20
[11845.659894] usb 2-2: New USB device found, idVendor=3Dffff, idProduct=3D=
5678,
bcdDevice=3D 2.00=20
[11845.659906] usb 2-2: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D3=20
[11845.659910] usb 2-2: Product: =E4=8D=86=E3=88=B3=E3=94=B6=20
[11845.659913] usb 2-2: Manufacturer: =E6=A5=86=E7=8D=B2t=E6=A1=A3=E7=81=A9=
=20
[11845.659917] usb 2-2: SerialNumber: 012345678901=20
[11845.661033] usb-storage 2-2:1.0: USB Mass Storage device detected=20
[11845.661414] scsi host7: usb-storage 2-2:1.0=20
[11867.362604] usb 2-2: reset high-speed USB device number 3 using xhci_hcd

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

