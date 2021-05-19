Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C36D3883E4
	for <lists+linux-ext4@lfdr.de>; Wed, 19 May 2021 02:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244387AbhESAqC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 May 2021 20:46:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239167AbhESAqC (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 18 May 2021 20:46:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4D2F46135D
        for <linux-ext4@vger.kernel.org>; Wed, 19 May 2021 00:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621385083;
        bh=CAxkZsyn+PWnqO+Fm1lNTJEIMmjeB8E9iQr00J5Wt1A=;
        h=From:To:Subject:Date:From;
        b=Si2DYBbdPE1yxLQoRhasaIsMSxs+QkojHxNcUMt9cdmVi/9nqU+OKmzozWzpwK9dq
         uFJwIXM2lV7zVbboF+fOt6oZaEAjrPZfDiu2arE4Lxp04TCtjvR31Dx3b0IR8eghYq
         QoQZJKusVOf4BLgaCLLnEQYTTTOOymOW1zINrnMmMJcz09moL6tESwB8cQ6z9Jyj3t
         H4Jhex8JSZhSTCQjBNdKwlUObpu/kmWZTEHLWj/E1pOxTdyHaLT0wMOIM5m4easNnx
         oWYVcrV9SYnC26gZT/QJQnEgNwU2nsDCncOchbsBMIKsXDQY2MWTy31NwvQ94AS/a3
         x6rLZz/76mCGg==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 3E2C661249; Wed, 19 May 2021 00:44:43 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 213137] New: NVMe device file system corruption immediately
 after mkfs
Date:   Wed, 19 May 2021 00:44:42 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: btmckee9@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-213137-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213137

            Bug ID: 213137
           Summary: NVMe device file system corruption immediately after
                    mkfs
           Product: File System
           Version: 2.5
    Kernel Version: 5.11.21
          Hardware: ARM
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: btmckee9@gmail.com
        Regression: No

When upgrading from 5.11.0 to 5.12.X or 5.11.21 there was an issue that cro=
pped
up with an ext4 partition on an NVMe drive. The drive crashed with an error=
 on
a boot up with the later kernels. I have subsequently gone back to 5.11 on =
the
ARMv7 and it works fine.

For the following keep in mind that nvme0n1p1 is the correct partition.

The following is the kernel panic I received from 5.11.21:

[    2.764492] EXT4-fs error (device nvme0n1p1): ext4_get_journal_inode:522=
7:
inode #8: comm swapper/0: iget: checksum invalid
[    2.774712]  mmcblk0: p1 p2 p3
[    2.775694] EXT4-fs (nvme0n1p1): no journal found
[    2.791532] exFAT-fs (nvme0n1p1): invalid boot record signature
[    2.797446] exFAT-fs (nvme0n1p1): failed to read boot sector
[    2.803118] exFAT-fs (nvme0n1p1): failed to recognize exfat type
[    2.809739] List of all partitions:
[    2.813229] 0100            8192 ram0=20
[    2.813238]  (driver?)
[    2.819324] 0101            8192 ram1=20
[    2.819332]  (driver?)
[    2.825465] 103:00000  244198584 nvme0n1=20
[    2.825475]  (driver?)
[    2.831830]   103:00001  244194304 nvme0n1p1
41a7d0bc-dd30-544f-8854-7939357a793d
[    2.831840]=20
[    2.840788] b300         7847936 mmcblk0=20
[    2.840797]  driver: mmcblk
[    2.847572]   b301         1024000 mmcblk0p1 a2b2f070-01
[    2.847581]=20
[    2.854374]   b302         1843200 mmcblk0p2 a2b2f070-02
[    2.854382]=20
[    2.861169]   b303           10240 mmcblk0p3 a2b2f070-03
[    2.861177]=20
[    2.867950] No filesystem could mount root, tried:=20
[    2.867955]  ext3
[    2.872821]  ext4
[    2.874740]  ext2
[    2.876658]  vfat
[    2.878576]  exfat
[    2.880504]  ntfs
[    2.882510]=20
[    2.885912] Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(259,1)



After booting mmc, I ran e2fsck:

threads /mnt # e2fsck /dev/sdb=20=20
e2fsck 1.46.2 (28-Feb-2021)=20
ext2fs_open2: Bad magic number in super-block=20
e2fsck: Superblock invalid, trying backup blocks...=20
e2fsck: Bad magic number in super-block while trying to open /dev/sdb=20
The superblock could not be read or does not describe a valid ext2/ext3/ext=
4=20
filesystem. If the device is valid and it really contains an ext2/ext3/ext4=
=20
filesystem (and not swap or ufs or something else), then the superblock=20
is corrupt, and you might try running e2fsck with an alternate superblock:=
=20
   e2fsck -b 8193 <device>=20
 or=20
   e2fsck -b 32768 <device>=20
/dev/sdb contains `DOS/MBR boot sector; partition 1 : ID=3D0x83, start-CHS
(0x0,32,33), end-CHS (0x199,250,33), startsector 2048, 500101120 sectors,
extended=20
partition table (last)' data

I was not able to repair this at all. I even blanked the partition table and
created a new partition and as soon as it was made, it failed mount and then
fsck. I tried ext4 and ext2:

root@cyclone5:/mnt# mount /dev/nvme0n1p1 /mnt/gentoo
[  811.671376] EXT4-fs error (device nvme0n1p1): ext4_get_journal_inode:522=
7:
inode #8: comm mount: iget: bad extra_isize 51821 (inode size 256)
[  811.684101] EXT4-fs (nvme0n1p1): no journal found
mount: /mnt/gentoo: wrong fs type, bad option, bad superblock on
/dev/nvme0n1p1, missing codepage or helper program, or other error.
root@cyclone5:/mnt# fsck.ext4 /dev/nvme0n1p1
e2fsck 1.45.3 (14-Jul-2019)
/dev/nvme0n1p1 contains a file system with errors, check forced.
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/nvme0n1p1: 11/15630336 files (0.0% non-contiguous), 1258688/62514766
blocks
root@cyclone5:/mnt# fsck.ext4 /dev/nvme0n1p1
e2fsck 1.45.3 (14-Jul-2019)
/dev/nvme0n1p1: clean, 11/15630336 files, 1258688/62514766 blocks
root@cyclone5:/mnt# mount /dev/nvme0n1p1 /mnt/gentoo
[  868.054311] EXT4-fs error (device nvme0n1p1): ext4_get_journal_inode:522=
7:
inode #8: comm mount: iget: bad extra_isize 51821 (inode size 256)
[  868.067073] EXT4-fs (nvme0n1p1): no journal found
mount: /mnt/gentoo: wrong fs type, bad option, bad superblock on
/dev/nvme0n1p1, missing codepage or helper program, or other error.
root@cyclone5:/mnt# fsck.ext4 /dev/nvme0n1p1=20=20=20=20=20=20=20=20
e2fsck 1.45.3 (14-Jul-2019)
/dev/nvme0n1p1 contains a file system with errors, check forced.
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/nvme0n1p1: 11/15630336 files (0.0% non-contiguous), 1258688/62514766
blocks
root@cyclone5:/mnt# fsck.ext4 /dev/nvme0n1p1
e2fsck 1.45.3 (14-Jul-2019)
/dev/nvme0n1p1: clean, 11/15630336 files, 1258688/62514766 blocks
root@cyclone5:/mnt# mkfs.ext2 /dev/nvme0n1p1=20
mke2fs 1.45.3 (14-Jul-2019)
/dev/nvme0n1p1 contains a ext4 file system
        created on Tue May 18 23:21:23 2021
Proceed anyway? (y,N) y
Discarding device blocks: done=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
Creating filesystem with 62514766 4k blocks and 15630336 inodes
Filesystem UUID: 0e5ae116-2982-4ad5-b178-2099b6bda7f2
Superblock backups stored on blocks:=20
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654=
208,=20
        4096000, 7962624, 11239424, 20480000, 23887872

Allocating group tables: done=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
Writing inode tables: done=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20
Writing superblocks and filesystem accounting information: done=20=20=20=20=
=20

root@cyclone5:/mnt# mount /dev/nvme0n1p1 /mnt/gentoo
[  926.309614] EXT2-fs (nvme0n1p1): error: can't find an ext2 filesystem on=
 dev
nvme0n1p1.
mount: /mnt/gentoo: wrong fs type, bad option, bad superblock on
/dev/nvme0n1p1, missing codepage or helper program, or other error.
root@cyclone5:/mnt# fsck.ext2 /dev/nvme0n1p1=20=20=20=20=20=20=20=20=20
e2fsck 1.45.3 (14-Jul-2019)
/dev/nvme0n1p1: clean, 11/15630336 files, 996093/62514766 blocks
root@cyclone5:/mnt# uname -a
Linux cyclone5 5.11.21-wtec #1 SMP Mon May 17 16:36:49 PDT 2021 armv7l
GNU/Linux
root@cyclone5:/mnt# halt

I'm having a similar problem (but maybe not related) with a jmicron USB to =
PCIe
controller on my x86-64 laptop. It seems to have the same problem creating
usable partitions on the NVMe. I have not verified that I can get it to work
with an older kernel. I'll have to hand install and build it as I have alre=
ady
removed the old version of the kernel from my Gentoo install.

I have many x86-64 machines running 5.12.4 with ext4 partitions on nvme and=
 I'm
a little nervous and thinking I might want to go back for a while.

Perhaps someone broke backward compatibility on the filesystem driver?

I have to dig into this because I can't ship embedded hardware with nvme is=
sues
and I don't like limiting myself to old kernels, so I thought I'd come here=
 and
ask for advice. Keep in mind I'm a hardware engineer, so be nice and I'll l=
et
you borrow my soldering iron from time to time.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
