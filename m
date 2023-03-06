Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777CA6AC7F4
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Mar 2023 17:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjCFQa3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Mar 2023 11:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCFQa2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Mar 2023 11:30:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212262B630
        for <linux-ext4@vger.kernel.org>; Mon,  6 Mar 2023 08:29:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF1C8B80EF3
        for <linux-ext4@vger.kernel.org>; Mon,  6 Mar 2023 16:05:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81A46C433A0
        for <linux-ext4@vger.kernel.org>; Mon,  6 Mar 2023 16:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678118734;
        bh=7I2OfeWS/sVRI1Ygkkx4TgkzepCtEt+OBWAq+mEq/7M=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AmIda0Bd9pv+YXUoQqMoR8JTUDumCQQbsY1ukfe1CPN5xO18JTQ3R+ZSX3vcmPFe0
         OkysQcUOFka0z5G2QpvZ4X8ETK3K7ua70nqdt98vSiCWt8iIIV00BX0at2Tq8kqUPT
         qSACgsCc5X9XEevxUH7qftyk4JccQkDMxbzjqLI/bd1EGbWonAm/Yee4qtflg0oeir
         x6kDBFFNYyfdoGLq55oDOFkvt6718eG14xjNSOGq4wuh47IVIJYB7iLUVev4qhToTT
         wHpS9t64lGpqeZttqPSAxewhWKOuVvWYExo9RI522eIi2qUYxmApICNLjSKkiyAI7G
         Ot6M2YELdEUmQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 6C3C1C43145; Mon,  6 Mar 2023 16:05:34 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217145] Feature request: I need very long directory and file
 names
Date:   Mon, 06 Mar 2023 16:05:34 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kernel@nerdbynature.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217145-13602-RhtaZGKGz4@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217145-13602@https.bugzilla.kernel.org/>
References: <bug-217145-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217145

--- Comment #3 from Christian Kujau (kernel@nerdbynature.de) ---
"video file name is a story"...interesting setup :-) But as you already fou=
nd
in your Askubuntu forum: "The problem is the common Linux file systems only
support up to 255 characters filename lengths". This is explained in more
detail in the following SE answers:

> To what extent does Linux support file names longer than 255 bytes?
> https://unix.stackexchange.com/a/619646

> Is there a reasonble way to increase the file name limitation of 255 byte=
s?
> https://unix.stackexchange.com/a/619492

So, this would not be a feature request of Ext4 (or any other Linux file
system) but of the Linux VFS, but I don't think that will be easliy impleme=
nted
in the near future. Your best bet would be to change your workflow and use
shorter file names.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
