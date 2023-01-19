Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC61674BCB
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Jan 2023 06:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjATFIO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Jan 2023 00:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjATFHu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Jan 2023 00:07:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBC57DF87
        for <linux-ext4@vger.kernel.org>; Thu, 19 Jan 2023 20:55:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 235FBB82739
        for <linux-ext4@vger.kernel.org>; Thu, 19 Jan 2023 20:36:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE2DBC433D2
        for <linux-ext4@vger.kernel.org>; Thu, 19 Jan 2023 20:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674160562;
        bh=1kMxjYTYkKBRx0tltmCtmov/N+2rbwcyfLjG8KgdTXU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gw9hjP2S88ftYmnZ12JZsc7qBJ48dfgvMphvEqhI+uhUI+MnUV8XdreeKZfzEXcmD
         VW2IJe7HE4ZmGZBUdYPX99U6Q+BMkOgXz5QfEqwnSHHQPOPb/Sl6v14fYr6+1mVzy2
         QgQWwlXA7acVj0RylC3pW5sgM8es4Rd+m8BlFiwuaSGAC2RbxrRQnyeItfvAR5vNs2
         HNZcTZy7Fq7vyML4ncmBRAoYvqbfq/js5MQPaSuQohNsweiz79rKK4HIKSVflRsplK
         Tt63KCHcgLGF05NBL+QVlf2Gk71RY1/jKLpiJonBMnWjJs7cbsdCsOI4W4Z9GlDWkf
         goc+foM+paZXQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A3D41C43143; Thu, 19 Jan 2023 20:36:02 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216953] BUG: kernel NULL pointer dereference, address:
 0000000000000008
Date:   Thu, 19 Jan 2023 20:36:02 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gjunk2@sapience.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216953-13602-1GJ7vmrWtN@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216953-13602@https.bugzilla.kernel.org/>
References: <bug-216953-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216953

--- Comment #6 from Gene (gjunk2@sapience.com) ---
Thanks Ted - sorry to not have a reproducer - this is the only machine that=
 had
a problem and just the once (so far!)

I have a second machine running same kernel also with mdadm RAID 6 setup wi=
th
ext4 - but no problems on that one as of now.

The other item of note, perhaps, is the compiler used was gcc 12.2.1 - earl=
ier
kernels used 12.2.0. Build started on fresh base (git -fddx).

Thanks again and sorry for pointing this down the wrong road.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
