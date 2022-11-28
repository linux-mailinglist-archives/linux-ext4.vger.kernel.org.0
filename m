Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A3C639E8D
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Nov 2022 02:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiK1BA5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 27 Nov 2022 20:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiK1BAz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 27 Nov 2022 20:00:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66A310B5E
        for <linux-ext4@vger.kernel.org>; Sun, 27 Nov 2022 17:00:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69681B80C75
        for <linux-ext4@vger.kernel.org>; Mon, 28 Nov 2022 01:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 216B9C433D7
        for <linux-ext4@vger.kernel.org>; Mon, 28 Nov 2022 01:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669597252;
        bh=8jGqSS/0xrey8fe021vsAglCKhiVO7W73rui3Ke5tXk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nxY5NVN9MngEnfUdNRzeNUNTCxjhe0ElR0ez1ZDy/j0l4qbCljNK5QjfrRjkeOclq
         dmbT5NeNc+sCvTvGWkerLCdnhX0zIRHuMn2td5UmhmSqhh3vX6WHhRK5kIyf6yKIfN
         kyqdmYs8jYIKUYhiWtbRcGm2Dd0s99oaW2GeAxg+9XPGCSQUh/sJ22lmZH0dYFBQSy
         J3OegkCt9cB2J4fgQKlNamrfPxBk/GEwP0Fozi5DCf10jcqz4LVWXOWNXeOyaOHuM7
         4PFJyXBn/7nS32o9U1lWdjdF0pF4vaBH8zDVj9z/EOtkSqIytigt6qnrA4kf2RtYrh
         NPidZagI3LYxw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0870DC433E7; Mon, 28 Nov 2022 01:00:52 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216714] Issue with file system image created with mke2fs
 parameter -E offset
Date:   Mon, 28 Nov 2022 01:00:51 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tmahmud@iastate.edu
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216714-13602-hV3Z64V8mP@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216714-13602@https.bugzilla.kernel.org/>
References: <bug-216714-13602@https.bugzilla.kernel.org/>
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

--- Comment #2 from tmahmud@iastate.edu ---
Hi Lukas,

Thank you for your reply. It makes sense to me now. I tried using the offset
parameter with losetup and it works for me.=20

I have another question related to this. Is there any way to find out the
offset after creating the file system image? For example, after creating the
image with mke2fs, I again have to provide the offset to losetup. Is there =
any
tool or utility that tells us the offset value after creating the file syst=
em
image? It would be very helpful if you could help me regarding this.

Thank you again for your time.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
