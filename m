Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAB9631764
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Nov 2022 00:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiKTXl4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 20 Nov 2022 18:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKTXl4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 20 Nov 2022 18:41:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F5A15804
        for <linux-ext4@vger.kernel.org>; Sun, 20 Nov 2022 15:41:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00F2DB80BEB
        for <linux-ext4@vger.kernel.org>; Sun, 20 Nov 2022 23:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC2C1C433C1
        for <linux-ext4@vger.kernel.org>; Sun, 20 Nov 2022 23:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668987712;
        bh=whEiX5Zi0KNzz8NfDKKFjWb3jCaco7ZEA85eBO2Y7wU=;
        h=From:To:Subject:Date:From;
        b=YPY8h5zRV79Bqb7lXm8VGbj2br5+N3D/NZZFlE/79uqmPycMA0ix4Ax7KGJ5W2ncu
         Ii4qnojMjGwRAxmT6uDYZgnFXUSflXrFcDfgzqGFAMynGhhnIVdHxNnjFMZpTo9nsv
         9HwvF7kfoYi2PVCLqZc+5kmqgRNKvSRki50CVcNgbH0pAdQl1bZUEgzQg3nImgu0vO
         agle2H8u1kq6mF7c7Zj2I8KNne8rlLv5/G1GNX0kZmtisPN+pJapOA6NjXt3Y3/58R
         QFnCnjwbVjclUNUODf1vH28G45hLC9W5cfayGOlcsa9dJuY5PRXjZKQECBEqph9ydo
         +YsMMXTwAPyCQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 9CF04C433E7; Sun, 20 Nov 2022 23:41:52 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216714] New: Issue with file system image created with mke2fs
 parameter -E offset
Date:   Sun, 20 Nov 2022 23:41:52 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tmahmud@iastate.edu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216714-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216714

            Bug ID: 216714
           Summary: Issue with file system image created with mke2fs
                    parameter -E offset
           Product: File System
           Version: 2.5
    Kernel Version: Linux 5.4.0-131-generic
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: tmahmud@iastate.edu
        Regression: No

Overview:
We encountered an issue while using e2fsck to check the file system image
created with the command =E2=80=9Cmke2fs -t ext4 -E offset=3D10=E2=80=9D.
The issue was observed in e2fsprogs 1.46.5 and 1.45.6.=20

According to the manpage of mke2fs, the parameter =E2=80=9C-E offset=E2=80=
=9D  is used to
create the file system at an offset from the beginning of the device or fil=
e.
This can be useful when creating disk images for virtual machines. No range=
 is
specified for this parameter.=20

Below are the steps to reproduce:

truncate -s 500M image
mke2fs -t ext4 -E offset=3D10 image 500M
e2fsck -yf image

mke2fs output log:
mke2fs 1.46.5 (30-Dec-2021)
Discarding device blocks: done=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
Creating filesystem with 512000 1k blocks and 128016 inodes
Filesystem UUID: 6154bed2-c92b-45fe-b6db-97192ae46155
Superblock backups stored on blocks:=20
        8193, 24577, 40961, 57345, 73729, 204801, 221185, 401409

Allocating group tables: done=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
Writing inode tables: done=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20
Creating journal (8192 blocks): done
Writing superblocks and filesystem accounting information: done


e2fsck output log:
e2fsck 1.46.5 (30-Dec-2021)
ext2fs_open2: Bad magic number in super-block
e2fsck: Superblock invalid, trying backup blocks...
e2fsck: Bad magic number in super-block while trying to open image

The superblock could not be read or does not describe a valid ext2/ext3/ext4
filesystem.  If the device is valid and it really contains an ext2/ext3/ext4
filesystem (and not swap or ufs or something else), then the superblock
is corrupt, and you might try running e2fsck with an alternate superblock:
    e2fsck -b 8193 <device>
 or
    e2fsck -b 32768 <device>

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
