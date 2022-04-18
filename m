Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACE1504B25
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Apr 2022 05:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbiDRDHg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 17 Apr 2022 23:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235931AbiDRDH2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 17 Apr 2022 23:07:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552F81E2
        for <linux-ext4@vger.kernel.org>; Sun, 17 Apr 2022 20:04:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1B4060F4B
        for <linux-ext4@vger.kernel.org>; Mon, 18 Apr 2022 03:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30034C385A4
        for <linux-ext4@vger.kernel.org>; Mon, 18 Apr 2022 03:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650251085;
        bh=AJIGWWmbvWRRmfwaieT3YP/diQX6t60581BogSkyQkA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SlVqK6rEN1Sg26iq+sUVppbknu+CivMVNluCiRDVs5Cy9D2ln0RwrKSm5uvEWPAzc
         409Ojb/3Bp/K6asA1P8+aURMhf6kuWkUJexleh4X6o7YowyFk9jrbtYM4jSzmNKXoI
         I7PT6eN6TSn9CcfKNWr0faKjh5obSd5ZhvwwvxjteP2G+Dw3CuN19OKXoOaxDCNZrm
         EWAallA56IVQ5KQHBaIUL5LDohmuUnSoHzk2PBRkyBx468UVFABrDcq8HSugDCjkv7
         te79rNXIo1w8Hyr2EN8kr0EIWvY0/gS836sM7Lkbsu5leI19BSK6XPDshRU5efEYAY
         9BshtlHRE5Usg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 16593C05FD5; Mon, 18 Apr 2022 03:04:45 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 205641] kernel BUG at fs/buffer.c:3382!
Date:   Mon, 18 Apr 2022 03:04:44 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mailoflg21@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-205641-13602-jrKY1qEO5c@https.bugzilla.kernel.org/>
In-Reply-To: <bug-205641-13602@https.bugzilla.kernel.org/>
References: <bug-205641-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D205641

Gang Li (mailoflg21@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |mailoflg21@gmail.com

--- Comment #1 from Gang Li (mailoflg21@gmail.com) ---
Hi! May I ask where is the fix patch?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
