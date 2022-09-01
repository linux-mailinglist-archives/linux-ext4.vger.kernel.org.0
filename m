Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A659D5A925F
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Sep 2022 10:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbiIAItK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Sep 2022 04:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbiIAItJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Sep 2022 04:49:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F59131DFD
        for <linux-ext4@vger.kernel.org>; Thu,  1 Sep 2022 01:49:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 043D061E0E
        for <linux-ext4@vger.kernel.org>; Thu,  1 Sep 2022 08:49:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B77AC433D7
        for <linux-ext4@vger.kernel.org>; Thu,  1 Sep 2022 08:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662022147;
        bh=28SxVPK1X711ExS+lwthS8qqNREWovFIAq4ElFMC0bc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=X7jzTy7yV8pGULE/2LUfkiT2g5z3jCuhMS1XcXFujXc4NoLzwlkrMjucp5FPxsPFf
         C9ZstXhR5hjhFomhKfYwfW9Zy+RastkfN88VyPl+ZKlT3F9ej58XBESPK1JeEOgQcZ
         nsvydZWYXG3mzp0vkblxnt2MJljslUfgSQsqhEWrUQBcP9ro1H5ea1Qy6q/X1sprC8
         q93tXYivBRjDQV0p6Kvle/0xCLKNT+M6X0Ej5ST4YmsHZBp5/M5c5N3DHZgwKyUv60
         EtjQrYzcBJV+mErQiUw2Ymz5YKqrhxoP4nurkZlY2wnc7kqyi3SeiUgB4seni1h636
         r44t+3c7FCVcQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 5C8EDC433E7; Thu,  1 Sep 2022 08:49:07 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216430] mdtest may pause for 5-10 mins on ext4
Date:   Thu, 01 Sep 2022 08:49:07 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216430-13602-Cns7gr6Rx7@https.bugzilla.kernel.org/>
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

--- Comment #3 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
btw, a "dmesg" output right after the problem appeared would likely be help=
ful

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
