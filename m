Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1405C5B2C21
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Sep 2022 04:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiIICeH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 22:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiIICeG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 22:34:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9F7A8CF6
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 19:34:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 868BBB81EEA
        for <linux-ext4@vger.kernel.org>; Fri,  9 Sep 2022 02:34:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AC10C433C1
        for <linux-ext4@vger.kernel.org>; Fri,  9 Sep 2022 02:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662690842;
        bh=WkqzHdaruX0FpGHx3kH3b5fFlp/63caVOztCGJWZr2Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QF8psSSGe99kVSDq0l0YGiwZAbwuFyY3GqIMYNt4gqt9lOocVf1wURenRqskfrT7o
         J/JO9zOlkzno626z2EzXCwvYM4dtju/yHyudRwKgu/W9zJSoKvBWvJlIk0/7ruJZcU
         6F6UQGmND2nv3WpAyrOCGsc/mZvPlvJNs733esUdZraxXuirrdUeoKJHLX/5zBCXRp
         c4UQ45iyD1jzLrRyg1OGur/9iAWOMLc9pBdPkoJpOcixXhe13L0tQ0ZuY0tb5CxBit
         JbPnQTCcdud70WYVXiP3VETxxtY/iT3c3S6UtNZJM7Y+RKOwEb2anPkpsvAxKEr8C8
         YZ1893R298RJw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 115F0C433E7; Fri,  9 Sep 2022 02:34:02 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216466] ext4: dir corruption when ext4_dx_add_entry() fails
Date:   Fri, 09 Sep 2022 02:34:01 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chengzhihao1@huawei.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216466-13602-8A3g7Va5Z3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216466-13602@https.bugzilla.kernel.org/>
References: <bug-216466-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216466

--- Comment #1 from Zhihao Cheng (chengzhihao1@huawei.com) ---
Reproducer:
1. Apply diff and compile kernel
2. ./test.sh=EF=BC=8CStop machine after seeing kernel message "wait shutdow=
n"
3. reboot=EF=BC=8Cfsck -fa /dev/sdb
fsck from util-linux 2.38
/dev/sdb: recovering journal
/dev/sdb: Inode 12, end of extent exceeds allowed value
        (logical block 128, physical block 3819, len 1)


/dev/sdb: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.
        (i.e., without -a or -p options)
4. fsck -fn /dev/sdb
fsck from util-linux 2.38
e2fsck 1.43.4 (31-Jan-2017)
Pass 1: Checking inodes, blocks, and sizes
Inode 12, end of extent exceeds allowed value
        (logical block 128, physical block 3819, len 1)
Clear? no

Inode 12, i_blocks is 262, should be 260.  Fix? no

Pass 2: Checking directory structure
Problem in HTREE directory inode 12 (/dir): bad block number 128.
Clear HTree index? no

Problem in HTREE directory inode 12: block #2 has invalid depth (2)
Problem in HTREE directory inode 12: block #2 has bad max hash
Problem in HTREE directory inode 12: block #2 not referenced

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
