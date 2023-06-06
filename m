Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCD27246BF
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jun 2023 16:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238325AbjFFOtD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jun 2023 10:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238462AbjFFOsv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jun 2023 10:48:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162E42139
        for <linux-ext4@vger.kernel.org>; Tue,  6 Jun 2023 07:47:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 711656294C
        for <linux-ext4@vger.kernel.org>; Tue,  6 Jun 2023 14:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C795FC433EF
        for <linux-ext4@vger.kernel.org>; Tue,  6 Jun 2023 14:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686062849;
        bh=RilMUtqWMuSawKrA3p1OaXrhtA+9bl2O/mHp3ktAy0g=;
        h=From:To:Subject:Date:From;
        b=lWnDAa0TCoyJfmg3f6WZOCVApYyR9yHK/JaorpwPWHAwX3BvFoIi5VYXVm/GFX8q4
         mAVArvVRfV1LfKtupyRDuQtR8hNgmn/3hoa9/Zhjj5C3kUCUgMC5q7oh6fEfPFfru0
         mXxMdM8nqBPoDCbyRBNQcwKCUO+kxntjBNlhIByU30GVMjzB6yWmHAaaMOOZPThSIw
         /1dbGM9YN43yNXXaBPKEY2GtFQ0g2DqoW1gIJgi0LgzwmaTnNk0y/ShRGUa2kGB7LE
         xpMKQ6yFCQiOHZdS7EsFBkNOFr2uZ9T6xAYwf+/e1rRTi7MMYKTajV7UWDdHsgLadY
         p8y8QEhKvhl/w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id B0124C43143; Tue,  6 Jun 2023 14:47:29 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217529] New: Remounting ext4 filesystem from ro to rw fails
 when quotas are enabled
Date:   Tue, 06 Jun 2023 14:47:29 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nikolas.kraetzschmar@sap.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-217529-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217529

            Bug ID: 217529
           Summary: Remounting ext4 filesystem from ro to rw fails when
                    quotas are enabled
           Product: File System
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: nikolas.kraetzschmar@sap.com
        Regression: No

Description

Since commit a44be64, remounting a read-only ext4 filesystem to become
read-write fails when quotas are enabled. The mount syscall returns -EROFS =
and
outputs the following in dmesg:

```
EXT4-fs warning (device loop0): ext4_enable_quotas:7028: Failed to enable q=
uota
tracking (type=3D0, err=3D-30, ino=3D3). Please run e2fsck
```


Root cause

The problem can be traced back to the changes introduced in commit a44be64.=
 It
appears that the issue arises because the SB_RDONLY bit of the s_flags fiel=
d is
now only cleared after executing the ext4_enable_quotas function. However, =
the
vfs_setup_quota_inode function, called by ext4_enable_quotas, checks whether
this bit is set (fs/quota/dquot.c:2331):

```
if (IS_RDONLY(inode))
        return -EROFS;
```

This condition therefore always triggers the -EROFS fail condition.


Steps to Reproduce

The bug can be reproduced by executing the following script on a current
mainline kernel with defconfig:

```
#!/bin/bash

set -ex

truncate -s 1G /tmp/img
mkfs.ext4 /tmp/img
tune2fs -Q usrquota,grpquota,prjquota /tmp/img
losetup /dev/loop0 /tmp/img
mount -o ro /dev/loop0 /mnt
mount -o remount,rw /mnt
```

Executing the script results in the following output:

```
+ truncate -s 1G /tmp/img
+ mkfs.ext4 /tmp/img
mke2fs 1.47.0 (5-Feb-2023)
Discarding device blocks: done
Creating filesystem with 262144 4k blocks and 65536 inodes
Filesystem UUID: b96a3da2-043f-11ee-b6f0-47c69db05231
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376

Allocating group tables: done
Writing inode tables: done
Creating journal (8192 blocks): done
Writing superblocks and filesystem accounting information: done

+ tune2fs -Q usrquota,grpquota,prjquota /tmp/img
tune2fs 1.47.0 (5-Feb-2023)
+ losetup /dev/loop0 /tmp/img
[    6.766763] loop0: detected capacity change from 0 to 2097152
+ mount -o ro /dev/loop0 /mnt
[    6.791561] EXT4-fs (loop0): mounted filesystem
b96a3da2-043f-11ee-b6f0-47c69db05231 ro with ordered data mode. Quota mode:
journalled.
+ mount -o remount,rw /mnt
[    6.805546] EXT4-fs warning (device loop0): ext4_enable_quotas:7028: Fai=
led
to enable quota tracking (type=3D0, err=3D-30, ino=3D3). Please run e2fsck =
to fix.
mount: /mnt: cannot remount /dev/loop0 read-write, is write-protected.
       dmesg(1) may have more information after failed mount system call.
```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
