Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965905353D4
	for <lists+linux-ext4@lfdr.de>; Thu, 26 May 2022 21:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345741AbiEZTSd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 May 2022 15:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237614AbiEZTSd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 May 2022 15:18:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6262980C
        for <linux-ext4@vger.kernel.org>; Thu, 26 May 2022 12:18:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB0EAB82176
        for <linux-ext4@vger.kernel.org>; Thu, 26 May 2022 19:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DC4AC385A9
        for <linux-ext4@vger.kernel.org>; Thu, 26 May 2022 19:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653592709;
        bh=NwtGes3C7HAuXVxPfof02qcVCeSCh8tEidjkY+vw9wc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fhpFtkXZE0sYKa7iNF4gifurikAHPHN6EYB1XqtBvQlxcJdYnR8O8hajdSpziBFts
         I70q+971UXryx6DI0swzzhebTEjKpDA8ZPpxWFgLZJL92peWEpuD0xbQ4EXraqIRG/
         XxTdVNPjf5REY0pXm1gTLugkVyCm8bNTML3SgR5yiDJOztZas41aWkaOzu+Prd5cYQ
         mHDfmc4Ts9CX9PvugyfqLP6RZZDCPSHUbKcermMgZuZ/LjhnwPrmngE0D9AUGZe2rA
         uYFSluD8peP9nqsWA5Xh7gQpgMvzwEZOvt8BTPXntXtqcnJzh++R7TtxmIzQ2FynIQ
         A8EodjxoTDsMg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 74FC5CC13B2; Thu, 26 May 2022 19:18:29 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 215879] EXT4-fs error - __ext4_find_entry:1612: inode #2: comm
 systemd: reading directory lblock 0
Date:   Thu, 26 May 2022 19:18:29 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: vladimir@acm.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215879-13602-xVqErl5Rqg@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215879-13602@https.bugzilla.kernel.org/>
References: <bug-215879-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215879

Vladimir G. Ivanovic (vladimir@acm.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |vladimir@acm.org

--- Comment #4 from Vladimir G. Ivanovic (vladimir@acm.org) ---
I am getting the same error as sander44 (the OP) reported except the name of
the program generating the error is different.

EXT4-fs error (device sdb1): __ext4_find_entry:1612: inode #2: comm vorta:
reading directory lblock 0

The behavior of the Samsung 1TB SDXC card is predictable. It works for
minutes/hour, then throws the above error. This particular SD card is used =
for
borg backup which occur every 15 minutes (and also every 3 hours).

My (temporary) workaround is to unmount the SD card, run e2fsck, then re-mo=
unt
the card.

I'm suspicious of this being exclusively a hardware error because it is alw=
ays
the same error at the same spot. Might it be an unexpected call or unexpect=
ed
function arguments? (I have no knowledge of ext4 internals, so it's likely =
I'm
talking nonsense.)

I'm happy to provide more detail or even roll my own kernel to provide
debugging symbols. (I'm using Arch 5.15.43-1-lts, but the error is independ=
ent
of what kernel I'm using.)

=E2=80=94 Vladimir

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
