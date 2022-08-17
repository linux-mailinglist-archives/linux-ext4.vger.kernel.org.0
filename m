Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B50C597277
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Aug 2022 17:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240627AbiHQPAI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 17 Aug 2022 11:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240677AbiHQO7m (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 17 Aug 2022 10:59:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61C29D118
        for <linux-ext4@vger.kernel.org>; Wed, 17 Aug 2022 07:59:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04261B81E0A
        for <linux-ext4@vger.kernel.org>; Wed, 17 Aug 2022 14:59:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A55EBC43470
        for <linux-ext4@vger.kernel.org>; Wed, 17 Aug 2022 14:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660748362;
        bh=JC7UWo+0qKj/w7NGTwR9zMemi3VfpLG/q7VP0f35TZE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=b1DFWeae/dMq6zdVl7DUB2W8YpxW7RoUuYJvqRZxPZwucjPhrxgEML/w20rZJGyQj
         nLRAfhNEBI2IVRPjulbvhEJd5a+LMmWGHan/2/roxjT4kVsZweEOmbdzlvhwLCo1WR
         tEfxwZAxlPYCw919oLxNTF7SFVp9UKFb0hMq8DTpVNCfRxvVC7FfCGH621fDqFK9ai
         WJUd/koeu2k6YxbK16lPjHpb85CnIF4fQcolRut9npAO+MbDatkvgTbusmKjusgE7C
         wx4CH80U4qPUTRs6duq3bmkE31VHoiqTkrKAsocFs9QBJdtw4ZR5Rp5YdcJkzF4hYz
         TuHO7oZ3ufPTQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 8E876C433E9; Wed, 17 Aug 2022 14:59:22 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216317] "ext4: lblock 0 mapped to illegal pblock" after
 upgrading to 5.19.0
Date:   Wed, 17 Aug 2022 14:59:22 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-216317-13602-ou5Cn2FHVd@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216317-13602@https.bugzilla.kernel.org/>
References: <bug-216317-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216317

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #4 from Artem S. Tashkinov (aros@gmx.com) ---
This must be fixed in just released 5.19.2.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
