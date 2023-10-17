Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD87F7CC0E5
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Oct 2023 12:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbjJQKpd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Oct 2023 06:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbjJQKpc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Oct 2023 06:45:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C136BB0
        for <linux-ext4@vger.kernel.org>; Tue, 17 Oct 2023 03:45:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D9F6C433CB
        for <linux-ext4@vger.kernel.org>; Tue, 17 Oct 2023 10:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697539530;
        bh=LPsTEBcBhvHiqMXbon6xoZQZJ46T8W1pcet4m8HsNbs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=i7VPnYokx+E8tI1/dXkhy9w0Tbh6AHMZY3SYJmHHMlCTVHvEHmQJLXvF7DxKXZQje
         ms9E+vkA/4TtucFekUEnKz8xbOGDR4y+l7fSBT1J8jBdhKhlH0EVCRXuEwe2wfUqE/
         j3dNQsZ79uYN2PWFBp5xTNsLEa+rnG7O0IR+KQre3Mbje/eqzl9E/J6X9sSphk0TbZ
         l2c/wBykXUvVbdqB2o5V8JqDBOtoTSAbX46ax8ekWn6rAYe6XfmxY6mnXFe7TJAH13
         b3vWq1RHuuoiij9q3ErrE6xzzFBV5/o0sigt3+xAWlD5Vqpo4EHfuBdVjX0JLwnqxR
         SeltnqekbDtYA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 22DB4C53BD3; Tue, 17 Oct 2023 10:45:30 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date:   Tue, 17 Oct 2023 10:45:29 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: glandvador@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217965-13602-A9FNXbUyFf@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217965-13602@https.bugzilla.kernel.org/>
References: <bug-217965-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,WEIRD_PORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217965

Eduard Kohler (glandvador@yahoo.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |glandvador@yahoo.com

--- Comment #15 from Eduard Kohler (glandvador@yahoo.com) ---
I encounter the same issue on a stock fedora 37 kernel
# uname -a
Linux xxx.net 6.4.16-100.fc37.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Sep 13 18:2=
2:38
UTC 2023 x86_64 x86_64 x86_64 GNU/Linux

The issue seems to be present also on brtfs partitions, as mentioned in
https://bugzilla.redhat.com/show_bug.cgi?id=3D2242391

In my case, I have an EXT4 partition over an mdadm raid 1 array of two HDD.

# mdadm --misc --detail /dev/md0
/dev/md0:
           Version : 1.2
     Creation Time : Sun Feb 24 21:40:33 2013
        Raid Level : raid1
        Array Size : 3906118928 (3.64 TiB 4.00 TB)
     Used Dev Size : 3906118928 (3.64 TiB 4.00 TB)
      Raid Devices : 2
     Total Devices : 2
       Persistence : Superblock is persistent

       Update Time : Tue Oct 17 12:05:22 2023
             State : clean
    Active Devices : 2
   Working Devices : 2
    Failed Devices : 0
     Spare Devices : 0

Consistency Policy : resync

              Name : xxx.net:0  (local to host xxx.net)
              UUID : 25070e74:b2ac1695:46ee20f9:7e8d1e05
            Events : 402440

    Number   Major   Minor   RaidDevice State
       3       8       17        0      active sync   /dev/sdb1
       2       8       33        1      active sync   /dev/sdc1

dumpe2fs -h /dev/md0p1
dumpe2fs 1.46.5 (30-Dec-2021)
Filesystem volume name:   <none>
Last mounted on:          /home
Filesystem UUID:          4df09a03-d8ef-4cef-a64d-cefde4823fc2
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode dir_index filet=
ype
needs_recovery extent flex_bg sparse_super large_file huge_file uninit_bg
dir_nlink extra_isize
Filesystem flags:         signed_directory_hash
Default mount options:    user_xattr acl
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              244137984
Block count:              976529232
Reserved block count:     48826457
Overhead clusters:        15373546
Free blocks:              545717412
Free inodes:              243040909
First block:              0
Block size:               4096
Fragment size:            4096
Reserved GDT blocks:      791
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         8192
Inode blocks per group:   512
RAID stride:              32745
Flex block group size:    16
Filesystem created:       Sun Feb 24 22:13:52 2013
Last mount time:          Mon Oct 16 21:06:57 2023
Last write time:          Mon Oct 16 21:06:57 2023
Mount count:              6
Maximum mount count:      -1
Last checked:             Sat Oct  7 16:27:02 2023
Check interval:           0 (<none>)
Lifetime writes:          238 GB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               256
Required extra isize:     28
Desired extra isize:      28
Journal inode:            8
First orphan inode:       13509593
Default directory hash:   half_md4
Directory Hash Seed:      af37e79f-0457-4318-9c5d-840dc2f60bce
Journal backup:           inode blocks
Journal features:         journal_incompat_revoke
Total journal size:       128M
Total journal blocks:     32768
Max transaction length:   32768
Fast commit length:       0
Journal sequence:         0x003bc716
Journal start:            1

# df /dev/md0p1
Filesystem      1K-blocks       Used  Available Use% Mounted on
/dev/md0p1     3844622744 1661757340 1987543192  46% /home

# mount |grep md0
/dev/md0p1 on /home type ext4 (rw,relatime,seclabel,stripe=3D32745)

In order to trig the 100% CPU on one core, a simple=20
# for i in {0001..0200}; echo "some text" > "file_${i}.txt"
is enough. This will bring the kworker/flush at 100 % for around 90 seconds.
This time is dependent of the number of created files. Trying to delete the=
se
files is more or less impossible.

On the same setup I have a small SSD used for system installation. The same
test doesn't bring the kworker/flush behaviour.

# dumpe2fs -h /dev/sda3
dumpe2fs 1.46.5 (30-Dec-2021)
Filesystem volume name:   <none>
Last mounted on:          /
Filesystem UUID:          589968d6-2283-4903-8699-1b23f5c341a5
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode dir_index filet=
ype
needs_recovery extent flex_bg sparse_super large_file huge_file uninit_bg
dir_nlink extra_isize
Filesystem flags:         signed_directory_hash
Default mount options:    user_xattr acl
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              848640
Block count:              3390208
Reserved block count:     169510
Free blocks:              1823000
Free inodes:              735742
First block:              0
Block size:               4096
Fragment size:            4096
Reserved GDT blocks:      827
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         8160
Inode blocks per group:   510
Flex block group size:    16
Filesystem created:       Sun Apr  6 00:00:12 2014
Last mount time:          Mon Oct 16 21:06:53 2023
Last write time:          Mon Oct 16 21:06:47 2023
Mount count:              437
Maximum mount count:      -1
Last checked:             Sun Apr  6 00:00:12 2014
Check interval:           0 (<none>)
Lifetime writes:          1791 GB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               256
Required extra isize:     28
Desired extra isize:      28
Journal inode:            8
First orphan inode:       130778
Default directory hash:   half_md4
Directory Hash Seed:      7d17214b-9585-4370-8c06-4236e449fa7f
Journal backup:           inode blocks
Journal features:         journal_incompat_revoke
Total journal size:       128M
Total journal blocks:     32768
Max transaction length:   32768
Fast commit length:       0
Journal sequence:         0x0114205c
Journal start:            8194

# mount |grep sda3
/dev/sda3 on / type ext4 (rw,noatime,seclabel)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
