Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1492741228
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jun 2023 15:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjF1NTq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Jun 2023 09:19:46 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:35900 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjF1NTp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Jun 2023 09:19:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDDC56131F
        for <linux-ext4@vger.kernel.org>; Wed, 28 Jun 2023 13:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60CBBC433C8
        for <linux-ext4@vger.kernel.org>; Wed, 28 Jun 2023 13:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687958384;
        bh=0WpyhQz2oJYlAziVwJKgVVZ6MSmkjNOIntagJxczR4o=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nAHCar77Q5XsXRCts8U3DJOvuxipZEOp9CBW7OINlpRim9PX4XTO1xsEIOOhajsea
         SukAurPP3BIwaw49TJcY04wWVY6xHY755/3qybRaiKSS50U3DSPeBeiSDS0QrI4pfO
         IgYkTO8ymf2hCPpaf/P2ZfiDWFdqzzEFOBDDyFBtcWDNOLIah5nRMrGsQz4ESOJhRe
         0pGVcqOUoZbZJ7ieMpXfwaWWKTDooSKuhs3mFozG6CEqkjqQEmqePNQyABAAOwG5DD
         lv+DIbK2/2daEmWqaATazD/rh7WGFvroNwBzeXPmSvy0mPAomVPWVoKq6JnXxEr5n6
         C3qXVRz1KugUQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 512F5C53BC6; Wed, 28 Jun 2023 13:19:44 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217605] unttached inode after power cut with orphan file
 feature enabled
Date:   Wed, 28 Jun 2023 13:19:44 +0000
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
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217605-13602-rkNLihvqrQ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217605-13602@https.bugzilla.kernel.org/>
References: <bug-217605-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217605

--- Comment #1 from Zhihao Cheng (chengzhihao1@huawei.com) ---
reproducer:
1. ./test.sh
[   73.704796] inject err for ino 13 creation
[   73.705523] wait commit journal
[   75.741472] commit trans
[   76.550550] reboot: Restarting system

2. mount /dev/sda temp
   umount temp
[   82.683096] orphan replay: reserve 13

3. fsck.ext4 -fn /dev/sda
e2fsck 1.47.0 (5-Feb-2023)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Unattached zero-length inode 13.  Clear? no

Unattached inode 13
Connect to /lost+found? no

Pass 5: Checking group summary information

/dev/sda: ********** WARNING: Filesystem still has errors **********

/dev/sda: 13/25584 files (0.0% non-contiguous), 12113/102400 block

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
