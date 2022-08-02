Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B49D5876E3
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Aug 2022 07:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbiHBFtw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Aug 2022 01:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbiHBFtv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Aug 2022 01:49:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212D51A815
        for <linux-ext4@vger.kernel.org>; Mon,  1 Aug 2022 22:49:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C27D61242
        for <linux-ext4@vger.kernel.org>; Tue,  2 Aug 2022 05:49:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3F8EC433C1
        for <linux-ext4@vger.kernel.org>; Tue,  2 Aug 2022 05:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659419389;
        bh=+nzH+ux3H0jTT5rAtsaP0+49eGs6Q9jhvNANDCMdbwA=;
        h=From:To:Subject:Date:From;
        b=sGxCH7/m5BMEoEupWfklBS/IW4I9p5VPRullFoO45UFXH6T52Hxw5r7a1HiCmF2J9
         KNEnkq6v2jxREWya0FmKqVeoSZPzgkcqwfhR4syVuvkZwU6mLyP58iXQlDSkuQMPml
         J1S3/Css0qI5y1BXUGjwcGvdpSeGqO0SzvKBbxhCbVeXchfnx5vZCtWo8EHqEFGlKN
         DXc/pEkx7F7Kr4I+DUvh+RBfEG1Nt5p3o/7GbcFS5oj4pRy4M7r+T1Sf1gMzadJ/fm
         As9cu0xxHXreIKCAJXhF4K7gPfI8d+DS7HPMRsKH6nswEeLCXxQhtD/cGmY02ETR6h
         BSthu27561D9A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D2D7FC433E7; Tue,  2 Aug 2022 05:49:49 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216317] New: "ext4: lblock 0 mapped to illegal pblock" after
 upgrading to 5.19.0
Date:   Tue, 02 Aug 2022 05:49:49 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: gerbilsoft@gerbilsoft.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216317-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216317

            Bug ID: 216317
           Summary: "ext4: lblock 0 mapped to illegal pblock" after
                    upgrading to 5.19.0
           Product: File System
           Version: 2.5
    Kernel Version: 5.19.0
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: gerbilsoft@gerbilsoft.com
        Regression: No

On upgrading to kernel 5.19.0, I hit a bunch of warnings and inaccessible
files. Attempting to access e.g. /etc/alsa/conf.d/51-pulseaudio-probe.conf
(symlink to ../../../usr/share/alsa/alsa.conf.d/51-pulseaudio-probe.conf)
resulted in a "Structure needs cleaning" error. Checking dmesg shows the
following:

Aug 02 01:10:43 [kernel] [   12.037708] EXT4-fs error (device dm-2):
ext4_map_blocks:599: inode #14680223: block 774843950: comm alsactl: lblock=
 0
mapped to illegal pblock 774843950 (length 1)
Aug 02 01:10:43 [kernel] [   12.039070] EXT4-fs error (device dm-2):
ext4_map_blocks:599: inode #14680223: block 774843950: comm alsactl: lblock=
 0
mapped to illegal pblock 774843950 (length 1)
Aug 02 01:10:43 [kernel] [   12.041453] EXT4-fs error (device dm-2):
ext4_map_blocks:599: inode #14680223: block 774843950: comm alsactl: lblock=
 0
mapped to illegal pblock 774843950 (length 1)
Aug 02 01:10:43 [kernel] [   12.043086] EXT4-fs error (device dm-2):
ext4_map_blocks:599: inode #14680223: block 774843950: comm alsactl: lblock=
 0
mapped to illegal pblock 774843950 (length 1)
Aug 02 01:10:43 [kernel] [   12.045207] EXT4-fs error (device dm-2):
ext4_map_blocks:599: inode #14680223: block 774843950: comm alsactl: lblock=
 0
mapped to illegal pblock 774843950 (length 1)

Lots of other files were also showing the same issue. Reverting to 5.18.10 =
(and
running fsck) fixed it with no noticeable corruption.

Rootfs is ext4, using LVM-on-LUKS. (/dev/sda2 is a LUKS volume that contain=
s an
LVM physical volume.) I have inline data turned on; the symlink is 60 bytes=
, so
it could be an inline data issue, but other symlinks in /etc/alsa/conf.d/
weren't showing the problem.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
