Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DBA3000B8
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jan 2021 11:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbhAVKvf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Fri, 22 Jan 2021 05:51:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:50788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727242AbhAVKtz (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 22 Jan 2021 05:49:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id C1CF4230F9
        for <linux-ext4@vger.kernel.org>; Fri, 22 Jan 2021 10:49:13 +0000 (UTC)
Received: by pdx-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id B4F1D81649; Fri, 22 Jan 2021 10:49:13 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 211315] New: [aarch64][xfstests/ext3 generic/472] swapon:
 Invalid argument
Date:   Fri, 22 Jan 2021 10:49:13 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext3@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext3
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: neolorry+bugzilla.kernel.org@googlemail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext3@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-211315-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=211315

            Bug ID: 211315
           Summary: [aarch64][xfstests/ext3 generic/472] swapon: Invalid
                    argument
           Product: File System
           Version: 2.5
    Kernel Version: 5.11.0-0.rc4.20210120git45dfb8a5659a.131.eln108.aarch6
                    4
          Hardware: ARM
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext3
          Assignee: fs_ext3@kernel-bugs.osdl.org
          Reporter: neolorry+bugzilla.kernel.org@googlemail.com
        Regression: No

xfstests generic/472 fails on ext3 on the latest kernel
(kernel-5.11.0-0.rc4.20210120git45dfb8a5659a.131.eln108.aarch64 from
https://koji.fedoraproject.org/koji/buildinfo?buildID=1671933). This only
happens on aarch64 and ext3 with 2048 block size. I can reproduce it on
kernel-4.18 based RHEL-8 kernel as well.

log
```
# ./check -d -T generic/472
FSTYP         -- ext3
PLATFORM      -- Linux/aarch64 15-vm-16
5.11.0-0.rc4.20210120git45dfb8a5659a.131.eln108.aarch64 #1 SMP Wed Jan 20
23:39:54 UTC 2021
MKFS_OPTIONS  -- -b 2048 /dev/vda3
MOUNT_OPTIONS -- -o rw,relatime,seclabel -o context=system_u:object_r:root_t:s0
/dev/vda3 /scratch

generic/472 103s ...    [05:31:22]QA output created by 472
regular swap
too long swap
tiny swap
swapon: Invalid argument
 [05:32:15]- output mismatch (see
/tmp/tmp.6xoJizCZKc/repo_xfstests/results//generic/472.out.bad)
    --- tests/generic/472.out   2021-01-22 01:31:23.045484313 -0500
    +++ /tmp/tmp.6xoJizCZKc/repo_xfstests/results//generic/472.out.bad 
2021-01-22 05:32:15.217684365 -0500
    @@ -2,3 +2,4 @@
     regular swap
     too long swap
     tiny swap
    +swapon: Invalid argument
    ...
    (Run 'diff -u /tmp/tmp.6xoJizCZKc/repo_xfstests/tests/generic/472.out
/tmp/tmp.6xoJizCZKc/repo_xfstests/results//generic/472.out.bad'  to see the
entire diff)
Ran: generic/472
Failures: generic/472
Failed 1 of 1 tests
```

472.full
```
# cat /tmp/tmp.6xoJizCZKc/repo_xfstests/results//generic/472.full
Creating filesystem with 5767168 2k blocks and 720896 inodes
Filesystem UUID: 97619060-f6ec-4ed0-8984-01b4aefe86f8
Superblock backups stored on blocks: 
        16384, 49152, 81920, 114688, 147456, 409600, 442368, 802816, 1327104, 
        2048000, 3981312, 5619712

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (32768 blocks): done
Writing superblocks and filesystem accounting information: done   

regular swap
/usr/bin/chattr: Operation not supported while setting flags on /scratch/swap
wrote 2097152/2097152 bytes at offset 0
2 MiB, 512 ops; 0.1898 sec (10.534 MiB/sec and 2696.7097 ops/sec)
too long swap
/usr/bin/chattr: Operation not supported while setting flags on /scratch/swap
wrote 2097155/2097155 bytes at offset 0
2 MiB, 513 ops; 0.1231 sec (16.241 MiB/sec and 4165.7531 ops/sec)
tiny swap
/usr/bin/chattr: Operation not supported while setting flags on /scratch/swap
wrote 196608/196608 bytes at offset 0
192 KiB, 48 ops; 0.0130 sec (14.338 MiB/sec and 3670.5666 ops/sec)
swapoff: /scratch/swap: swapoff failed: Invalid argument
```

xfstests local.config
```
FSTYP="ext3"
TEST_DIR="/test"
TEST_DEV="/dev/vda4"
SCRATCH_MNT="/scratch"
SCRATCH_DEV="/dev/vda3"
LOGWRITES_MNT="/logwrites"
LOGWRITES_DEV="/dev/vda6"
MKFS_OPTIONS="-b 2048"
MOUNT_OPTIONS="-o rw,relatime,seclabel"
TEST_FS_MOUNT_OPTS="-o rw,relatime,seclabel"
```

64k page size
```
# getconf PAGESIZE
65536
```

fdisk -l
```
# fdisk -l /dev/vda
Disk /dev/vda: 100 GiB, 107374182400 bytes, 209715200 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
```

xfstests version
```
# git rev-parse HEAD
4767884aff19e042ee3be51c88cf2c27a111707e
# cat .git/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[remote "origin"]
        url = git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
        remote = origin
        merge = refs/heads/master
```

e2fsprogs version
```
# rpm -q e2fsprogs
e2fsprogs-1.45.6-1.el8.aarch64
```

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.
