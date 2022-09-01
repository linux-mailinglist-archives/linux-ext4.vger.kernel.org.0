Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C0D5A9258
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Sep 2022 10:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiIAIre (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Sep 2022 04:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbiIAIrd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Sep 2022 04:47:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B961314FA
        for <linux-ext4@vger.kernel.org>; Thu,  1 Sep 2022 01:47:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44FE9B82509
        for <linux-ext4@vger.kernel.org>; Thu,  1 Sep 2022 08:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAAC3C433D7
        for <linux-ext4@vger.kernel.org>; Thu,  1 Sep 2022 08:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662022050;
        bh=BfwmHrODAsOcLOqwXrx1CsFVxJkvIdtekybYBa9WkeQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GiLjttfhSDIBZri9mM9zcz/N19lCQMWGqssV0C6pnJnliki/16hJVo0/Kvg8Rq4l7
         B4UfBF4MBQ1DiTZkB5xpQ10B7XQvGDC4aCnVif3M0wWW389DJq3NDYAAEA+YTk42v4
         Mvvkzfh97fcSdGZp1TDiph4pWGpk4B8i3HhYAuMnGJ4Q8sRkC41pWbysusvz7Q2tQo
         j1pNDKwpsNig3h58wwEJ90IBx/UtR5MmoEz/Q+Uofg1Dnhk73rHWiGldkCB1jZyM1q
         aHZbqw6HZfwnQRA/frOpLYL5pVpzHjMc+RzAuXCbt5YYDpI1Mlj6xEPhYw+N8Fn97d
         IRqXCGJNw1Thw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id CFBF0C433E7; Thu,  1 Sep 2022 08:47:29 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216430] mdtest may pause for 5-10 mins on ext4
Date:   Thu, 01 Sep 2022 08:47:29 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216430-13602-BfP4PoqR5Q@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216430-13602@https.bugzilla.kernel.org/>
References: <bug-216430-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216430

The Linux kernel's regression tracker (Thorsten Leemhuis) (regressions@leem=
huis.info) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |regressions@leemhuis.info

--- Comment #2 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
(In reply to JunChao Sun from comment #0)

> Any thoughts or hints about this? Let me known if any information is
> required. Thanks!

So earlier 5.10.y versions worked? Which was the latest one that worked?
Ideally  you would use "git bisect" to find the exact change made this prob=
lem
appear.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
