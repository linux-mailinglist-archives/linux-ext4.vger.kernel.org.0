Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA94C1522E2
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Feb 2020 00:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbgBDXOL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Tue, 4 Feb 2020 18:14:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:42028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbgBDXOK (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 4 Feb 2020 18:14:10 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 206419] New: online resize + fstrim -> bad block checksum
Date:   Tue, 04 Feb 2020 23:14:09 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bugzilla.kernel.org@plan9.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-206419-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=206419

            Bug ID: 206419
           Summary: online resize + fstrim -> bad block checksum
           Product: File System
           Version: 2.5
    Kernel Version: 5.4.15
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: bugzilla.kernel.org@plan9.de
        Regression: No

I enlarged an encrypted lvm ext4 partition from ~100 to 160gb. Afterwards, I
ran fstrim and got a "Bad message" error. I ran it again and got a "bad block
bitmap checksum".

In detail:

I ran e2fsck -n /dev/mapper/xmnt-db while mounted, which showed some bitmap
differences but no other errors.

I then ran resize2fs /dev/mapper/xmnt-db:

   resize2fs 1.44.5 (15-Dec-2018)
   Filesystem at /dev/mapper/xmnt-db is mounted on /db; on-line resizing
required
   old_desc_blocks = 13, new_desc_blocks = 19
   The filesystem on /dev/mapper/xmnt-db is now 39321600 (4k) blocks long.

kernel messages:

   [524855.273199] EXT4-fs (dm-24): resizing filesystem from 26214400 to
39321600 blocks
   [524855.273202] EXT4-fs (dm-24): Converting file system to meta_bg
   [524855.516896] EXT4-fs (dm-24): resized filesystem to 39321600

I then immediately ran fstrim on the filesystem and got:

   fstrim: /db: FITRIM ioctl failed: Bad message

Which struck me as quite odd :) After looking around a bit I re-ran fstrim and
got message:

   fstrim: /db: FITRIM ioctl failed: Structure needs cleaning

And this kernel message:

   [524880.940693] EXT4-fs error (device dm-24):
ext4_validate_block_bitmap:376: comm fstrim: bg 63: bad block bitmap checksum

And lo and behold, e2fsck -n now also complains in addition to bitmap
differences:

   Block bitmap differences: Group 63 block bitmap does not match checksum.
IGNORED.

The filesystem was (probably) formatted like this:

   mke2fs -t ext4 -b 4096 -E
lazy_itable_init=0,lazy_journal_init=0,packed_meta_blocks=1 -N 65536 -L DB -O
extents,filetype,dir_index,^flex_bg,^has_journal,^resize_inode,sparse_super,^uninit_bg
-v

And it is force-checked on every mount (the last of which was 6 days before).

My assumption is that ext4 will not immediately destrroy my data and, on the
next possible point in time, will unmount and e2fsck the filesystem. I do not
require assistance (or any feedback :), but I also might not be able to debug
this much further, so feel free to just close if not helpful.

tune2fs -l output:

tune2fs 1.44.5 (15-Dec-2018)
Filesystem volume name:   DB
Last mounted on:          /db
Filesystem UUID:          2f3e32c4-8150-46bc-8139-cb9a1e67d55e
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      ext_attr dir_index filetype meta_bg extent 64bit
sparse_super large_file huge_file dir_nlink extra_isize metadata_csum
Filesystem flags:         signed_directory_hash 
Default mount options:    user_xattr acl
Filesystem state:         not clean with errors
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              115200
Block count:              39321600
Reserved block count:     1835048
Free blocks:              20843524
Free inodes:              114673
First block:              0
Block size:               4096
Fragment size:            4096
Group descriptor size:    64
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         96
Inode blocks per group:   6
First meta block group:   13
Filesystem created:       Fri Nov 30 20:35:51 2018
Last mount time:          Wed Jan 29 22:08:01 2020
Last write time:          Tue Feb  4 23:53:37 2020
Mount count:              1
Maximum mount count:      -1
Last checked:             Wed Jan 29 22:08:00 2020
Check interval:           0 (<none>)
Lifetime writes:          1121 GB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               256
Required extra isize:     32
Desired extra isize:      32
Default directory hash:   half_md4
Directory Hash Seed:      06460dbe-b67f-4c81-9293-53599ec2349e
FS Error count:           1
First error time:         Tue Feb  4 23:53:37 2020
First error function:     ext4_validate_block_bitmap
First error line #:       376
First error inode #:      0
First error block #:      0
Last error time:          Tue Feb  4 23:53:37 2020
Last error function:      ext4_validate_block_bitmap
Last error line #:        376
Last error inode #:       0
Last error block #:       0
Checksum type:            crc32c
Checksum:                 0x17079f52

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
