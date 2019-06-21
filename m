Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 448AD4E0A4
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jun 2019 08:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfFUGva convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Fri, 21 Jun 2019 02:51:30 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:40692 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725911AbfFUGva (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 21 Jun 2019 02:51:30 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 2B3AD284D2
        for <linux-ext4@vger.kernel.org>; Fri, 21 Jun 2019 06:51:29 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 1F91728A32; Fri, 21 Jun 2019 06:51:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
        pdx-wl-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS autolearn=unavailable version=3.3.1
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 203943] New: ext4 corruption after RAID6 degraded; e2fsck skips
 block checks and fails
Date:   Fri, 21 Jun 2019 06:51:27 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yann@ormanns.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-203943-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=203943

            Bug ID: 203943
           Summary: ext4 corruption after RAID6 degraded; e2fsck skips
                    block checks and fails
           Product: File System
           Version: 2.5
    Kernel Version: 4.19.52-gentoo
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: yann@ormanns.net
        Regression: No

I use a 24TB SW-RAID6 with 10 3TB HDDs. This array contains a dmcrypt
container, which contains a ext4 FS [1].
One of the disks had errors and got kicked out of the array. Before I was able
to replace it, the ext4 FS began to throw errors like these:

EXT4-fs error (device dm-1): ext4_find_dest_de:1802: inode #3833864: block
61343924: comm nfsd: bad entry in directory: rec_len % 4 != 0 - offset=1000,
inode=2620025549, rec_len=30675, name_len=223, size=4096
EXT4-fs error (device dm-1): ext4_lookup:1577: inode #172824586: comm
tvh:tasklet: iget: bad extra_isize 13022 (inode size 256)
EXT4-fs error (device dm-1): htree_dirblock_to_tree:1010: inode #7372807: block
117967811: comm tar: bad entry in directory: rec_len % 4 != 0 - offset=104440,
inode=1855122647, rec_len=12017, name_len=209, size=4096 

I then used e2fsck to check the FS for errors, but it only created dozens of
the following output lines:
German original: "Block %$b von Inode %$i steht in Konflikt mit kritischen
Metadaten, Blockprüfungen werden übersprungen."
Translated: "Inode %$i block %$b conflicts with critical metadata, skipping
block checks." 
It also filled up my RAM, so I added ~100G of swap space. After scanning for a
few days, the e2fsck process died.

Afterwards I was able to replace the disk, re-scan the FS with e2fsck and after
2 hours, the ext4 FS was clean again.

To understand the problem, I set one of the disks faulty, and suddenly the ext4
errors occurred again. I added a spare disk, resynced the array, but e2fsck is
unable to fix the errors, and only throws "Inode %$i block %$b conflicts with
critical metadata, skipping block checks." while using more and more RAM.

Used software versions:
Kernel 4.19.52-gentoo
e2fsprogs-1.44.5
mdadm-4.1

Please let me know, if I should provide additional information.

Kind regards,
Yann

########################################## additional information

#e2fsck -c /dev/mapper/share 
e2fsck 1.44.5 (15-Dec-2018)
badblocks: ungültige letzter Block - 5860269055
/dev/mapper/share: Updating bad block inode.
Durchgang 1: Inodes, Blöcke und Größen werden geprüft
Block %$b von Inode %$i steht in Konflikt mit kritischen Metadaten,
Blockprüfungen werden übersprungen.
[...]
Block %$b von Inode %$i steht in Konflikt mit kritischen Metadaten,
Blockprüfungen werden übersprungen.
Signal (6) SIGABRT si_code=SI_TKILL 
e2fsck(+0x33469)[0x55ec4942a469]
/lib64/libc.so.6(+0x39770)[0x7f562449f770]
/lib64/libc.so.6(gsignal+0x10b)[0x7f562449f6ab]
/lib64/libc.so.6(abort+0x123)[0x7f5624488539]
/lib64/libext2fs.so.2(+0x18af5)[0x7f5624ac3af5]
e2fsck(+0x18c30)[0x55ec4940fc30]
/lib64/libext2fs.so.2(+0x1a1ec)[0x7f5624ac51ec]
/lib64/libext2fs.so.2(+0x1a589)[0x7f5624ac5589]
/lib64/libext2fs.so.2(+0x1b04b)[0x7f5624ac604b]
e2fsck(+0x1978c)[0x55ec4941078c]
e2fsck(+0x1b0f6)[0x55ec494120f6]
e2fsck(+0x1b1dc)[0x55ec494121dc]
/lib64/libext2fs.so.2(ext2fs_get_next_inode_full+0x8e)[0x7f5624adc53e]
e2fsck(e2fsck_pass1+0xa12)[0x55ec49412d22]
e2fsck(e2fsck_run+0x6a)[0x55ec4940b54a]
e2fsck(main+0xefd)[0x55ec4940703d]
/lib64/libc.so.6(__libc_start_main+0xeb)[0x7f5624489e6b]
e2fsck(_start+0x2a)[0x55ec494092ea]

---------------------------------------------------------------------

#tune2fs -l /dev/mapper/share
tune2fs 1.44.5 (15-Dec-2018)
Filesystem volume name:   <none>
Last mounted on:          /home/share
Filesystem UUID:          c5f0559d-e3bd-473f-abc0-7c42b3115897
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      ext_attr dir_index filetype extent 64bit flex_bg
sparse_super large_file huge_file uninit_bg dir_nlink extra_isize
Filesystem flags:         signed_directory_hash 
Default mount options:    user_xattr acl
Filesystem state:         clean with errors
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              366268416
Block count:              5860269056
Reserved block count:     0
Free blocks:              755383351
Free inodes:              363816793
First block:              0
Block size:               4096
Fragment size:            4096
Group descriptor size:    64
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         2048
Inode blocks per group:   128
RAID stride:              128
RAID stripe width:        1024
Flex block group size:    16
Filesystem created:       Sat Mar 17 14:36:16 2018
Last mount time:          Fri Jun 21 05:25:34 2019
Last write time:          Fri Jun 21 05:30:27 2019
Mount count:              3
Maximum mount count:      -1
Last checked:             Thu Jun 20 08:55:17 2019
Check interval:           0 (<none>)
Lifetime writes:          139 GB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               256
Required extra isize:     28
Desired extra isize:      28
Default directory hash:   half_md4
Directory Hash Seed:      4c37872e-3207-4ff4-8939-a428feaeb49f
Journal backup:           inode blocks
FS Error count:           20776
First error time:         Thu Jun 20 14:18:47 2019
First error function:     ext4_lookup
First error line #:       1577
First error inode #:      172824586
First error block #:      0
Last error time:          Fri Jun 21 05:53:24 2019
Last error function:      ext4_lookup
Last error line #:        1577
Last error inode #:       172824586
Last error block #:       0

---------------------------------------------------------------------

#cat /proc/mdstat
Personalities : [raid0] [raid1] [raid10] [raid6] [raid5] [raid4] [multipath]
[faulty] 
md2 : active raid6 sde[0] sdc[9] sdb[8] sdj[7] sdi[6] sda[11] sdd[10] sdh[3]
sdg[2] sdf[1]
      23441080320 blocks super 1.2 level 6, 512k chunk, algorithm 2 [10/10]
[UUUUUUUUUU]
      bitmap: 0/22 pages [0KB], 65536KB chunk

md1 : active raid1 sdk2[0] sdl2[2]
      52396032 blocks super 1.2 [2/2] [UU]

md0 : active raid1 sdk1[0] sdl1[2]
      511680 blocks super 1.2 [2/2] [UU]

unused devices: <none>

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
