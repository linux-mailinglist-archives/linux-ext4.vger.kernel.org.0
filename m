Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1507487AE
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Jul 2023 17:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjGEPTM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Jul 2023 11:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjGEPTM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Jul 2023 11:19:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D40711B
        for <linux-ext4@vger.kernel.org>; Wed,  5 Jul 2023 08:19:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F08CE615D9
        for <linux-ext4@vger.kernel.org>; Wed,  5 Jul 2023 15:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5ACCBC433C8
        for <linux-ext4@vger.kernel.org>; Wed,  5 Jul 2023 15:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688570350;
        bh=SQtxoqdIbG1jfl20kWTIYEIGksUDu9Qwd+pmC+iMSbs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BNGn8yltsaWW0VSfcf5RCxxdUqJXCGV2q0k/TtYuZ+mekudehSg1F5PywcWSMdfa4
         xx3/dFgSmvVtkdvnSI4WcxNEXnCdc+BxUvLUAGK9Ipdecue+C70SH5Hl7pk1fNZDg9
         7JxbxcsGrgvtFFcm//kw8HvkuVZMAULQ5MJjKbjOmzkSmKkvyQYJD6s0qVbey2KYsU
         sCygeAH2y+Mqh0SWO+DX6+xoPnGsUsB51t2TpGMSTnqRK6Fs7JzHo6MDrHsEvJQSpH
         tdPzrl47zocspXC1eo2zeI7m67D55mVb8t6A+T94BmQwue+bwjRYFvB6cEj1fpOj2z
         K24chhidhzB+Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4B477C53BC6; Wed,  5 Jul 2023 15:19:10 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217633] the insertion of disk  to  DVD make bad remout /dev/sda
Date:   Wed, 05 Jul 2023 15:19:10 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-217633-13602-YXGYUBwZsR@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217633-13602@https.bugzilla.kernel.org/>
References: <bug-217633-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217633

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |INVALID

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
