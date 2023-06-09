Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0C2729793
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Jun 2023 12:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238795AbjFIKyB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Jun 2023 06:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjFIKyB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Jun 2023 06:54:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37F5C3
        for <linux-ext4@vger.kernel.org>; Fri,  9 Jun 2023 03:53:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FDEB656D2
        for <linux-ext4@vger.kernel.org>; Fri,  9 Jun 2023 10:53:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05E56C4339C
        for <linux-ext4@vger.kernel.org>; Fri,  9 Jun 2023 10:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686308039;
        bh=ybSCO2PmbvAygRbJoYpy6kvytpeZCFcnlz/vpQFzIFA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=IvvH6jXtI3NATZ1ti4XqXsaq6f4RKXoRCg1CyBR8B1r3sa8gMAbzC2t7HKHqpuzLC
         zcvvOJmElyWoxdx5a/3BCiZmircrL6QItlZHd6tHFKrsyW8L0ne7VHU/ptMONL5FqX
         0NJGj/qAKpPokfwF4KhKmi4Ped8eb0/YBsXnrQnIYKVz1deZV9pShQnGpydKpl5NSa
         OAFK2QbFIk5WL6cuH3j+y7NQEtl4sp8T+WBg3k7H8mguY8mBqjkhv3Ua1fEg5jAkM9
         wV4u3YCB9dLM9hNgcwDGCf8PYLaVuHI/vtaUsvIgilYZMSuLCOqobI/XpIebBLzkjS
         IOm9g7mn3iO6A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E0879C43141; Fri,  9 Jun 2023 10:53:58 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217529] Remounting ext4 filesystem from ro to rw fails when
 quotas are enabled
Date:   Fri, 09 Jun 2023 10:53:58 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bagasdotme@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217529-13602-dBAEnQmAUg@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217529-13602@https.bugzilla.kernel.org/>
References: <bug-217529-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217529

Bagas Sanjaya (bagasdotme@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bagasdotme@gmail.com

--- Comment #1 from Bagas Sanjaya (bagasdotme@gmail.com) ---
(In reply to Nikolas Kraetzschmar from comment #0)
> Description
>=20
> Since commit a44be64, remounting a read-only ext4 filesystem to become
> read-write fails when quotas are enabled. The mount syscall returns -EROFS
> and outputs the following in dmesg:
>=20
> ```
> EXT4-fs warning (device loop0): ext4_enable_quotas:7028: Failed to enable
> quota tracking (type=3D0, err=3D-30, ino=3D3). Please run e2fsck
> ```
>=20
>=20
> Root cause
>=20
> The problem can be traced back to the changes introduced in commit a44be6=
4.
> It appears that the issue arises because the SB_RDONLY bit of the s_flags
> field is now only cleared after executing the ext4_enable_quotas function.
> However, the vfs_setup_quota_inode function, called by ext4_enable_quotas,
> checks whether this bit is set (fs/quota/dquot.c:2331):
>=20
> ```
> if (IS_RDONLY(inode))
>       return -EROFS;
> ```
>=20
> This condition therefore always triggers the -EROFS fail condition.
>=20
>=20
> Steps to Reproduce
>=20
> The bug can be reproduced by executing the following script on a current
> mainline kernel with defconfig:
>=20
> ```
> #!/bin/bash
>=20
> set -ex
>=20
> truncate -s 1G /tmp/img
> mkfs.ext4 /tmp/img
> tune2fs -Q usrquota,grpquota,prjquota /tmp/img
> losetup /dev/loop0 /tmp/img
> mount -o ro /dev/loop0 /mnt
> mount -o remount,rw /mnt
> ```
>=20
> Executing the script results in the following output:
>=20
> ```
> + truncate -s 1G /tmp/img
> + mkfs.ext4 /tmp/img
> mke2fs 1.47.0 (5-Feb-2023)
> Discarding device blocks: done
> Creating filesystem with 262144 4k blocks and 65536 inodes
> Filesystem UUID: b96a3da2-043f-11ee-b6f0-47c69db05231
> Superblock backups stored on blocks:
>       32768, 98304, 163840, 229376
>=20
> Allocating group tables: done
> Writing inode tables: done
> Creating journal (8192 blocks): done
> Writing superblocks and filesystem accounting information: done
>=20
> + tune2fs -Q usrquota,grpquota,prjquota /tmp/img
> tune2fs 1.47.0 (5-Feb-2023)
> + losetup /dev/loop0 /tmp/img
> [    6.766763] loop0: detected capacity change from 0 to 2097152
> + mount -o ro /dev/loop0 /mnt
> [    6.791561] EXT4-fs (loop0): mounted filesystem
> b96a3da2-043f-11ee-b6f0-47c69db05231 ro with ordered data mode. Quota mod=
e:
> journalled.
> + mount -o remount,rw /mnt
> [    6.805546] EXT4-fs warning (device loop0): ext4_enable_quotas:7028:
> Failed to enable quota tracking (type=3D0, err=3D-30, ino=3D3). Please ru=
n e2fsck
> to fix.
> mount: /mnt: cannot remount /dev/loop0 read-write, is write-protected.
>        dmesg(1) may have more information after failed mount system call.
> ```

Ted had recently sent out the proposed fixes ([1] and [2]). Please test.

[1]: https://lore.kernel.org/linux-ext4/20230608141805.1434230-1-tytso@mit.=
edu/
[2]: https://lore.kernel.org/linux-ext4/20230608141805.1434230-2-tytso@mit.=
edu/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
