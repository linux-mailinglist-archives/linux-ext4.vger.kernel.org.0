Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72F5741227
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jun 2023 15:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjF1NUe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Jun 2023 09:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjF1NUd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Jun 2023 09:20:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989141705
        for <linux-ext4@vger.kernel.org>; Wed, 28 Jun 2023 06:20:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E0B46131A
        for <linux-ext4@vger.kernel.org>; Wed, 28 Jun 2023 13:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96712C433C9
        for <linux-ext4@vger.kernel.org>; Wed, 28 Jun 2023 13:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687958431;
        bh=w/BKxEulecA5yOiuE2gpo8Oy4HZHAaZamkgk9h0yavc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YnHSTDEkCbfGCXNSlPhGMgeOvlYm8LNH2aVxfiswVz3b4C6DfoJH7ZbquAyoaitoi
         wBkCv8ly7+7s4RO9VDMPX3G4cPCiFdfP9k7INuZMQOIljUbyk5Q8c4BTJa2TVRILu/
         UkghkILWA9GTDuIRiEArJUprYS9+fW5baAiDT/0BTXj75z9zN4RQwZa8xlFzbxP43q
         Vl3pQ6ZyKfa70NfZTqgcPIms5v773t+Q9YoE0USI2R8y2KS/XoUYHALsS8LXDA8cao
         +fRJeAXrcKksIXrpkZnKkj5mKXobAsO33LtHIXzhZZeA9i9yth9l00Kk4WublI5kXm
         VcOOe4bi1p++w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 862FDC53BD0; Wed, 28 Jun 2023 13:20:31 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217605] unttached inode after power cut with orphan file
 feature enabled
Date:   Wed, 28 Jun 2023 13:20:31 +0000
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
Message-ID: <bug-217605-13602-7HW7rl0nTR@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217605-13602@https.bugzilla.kernel.org/>
References: <bug-217605-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217605

--- Comment #4 from Zhihao Cheng (chengzhihao1@huawei.com) ---
(In reply to Zhihao Cheng from comment #1)

Apply diff first of all

> reproducer:
> 1. ./test.sh
> [   73.704796] inject err for ino 13 creation
> [   73.705523] wait commit journal
> [   75.741472] commit trans
> [   76.550550] reboot: Restarting system
>=20
> 2. mount /dev/sda temp
>    umount temp
> [   82.683096] orphan replay: reserve 13
>=20
> 3. fsck.ext4 -fn /dev/sda
> e2fsck 1.47.0 (5-Feb-2023)
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> Pass 4: Checking reference counts
> Unattached zero-length inode 13.  Clear? no
>=20
> Unattached inode 13
> Connect to /lost+found? no
>=20
> Pass 5: Checking group summary information
>=20
> /dev/sda: ********** WARNING: Filesystem still has errors **********
>=20
> /dev/sda: 13/25584 files (0.0% non-contiguous), 12113/102400 block

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
