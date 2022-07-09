Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE8756CB48
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Jul 2022 21:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiGITrX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 9 Jul 2022 15:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGITrX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 9 Jul 2022 15:47:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804182A966
        for <linux-ext4@vger.kernel.org>; Sat,  9 Jul 2022 12:47:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC0FB60FC0
        for <linux-ext4@vger.kernel.org>; Sat,  9 Jul 2022 19:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 536D5C3411E
        for <linux-ext4@vger.kernel.org>; Sat,  9 Jul 2022 19:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657396041;
        bh=j0Cnf1Ova654etU4kTeH0wZGlIPgpw/n0mtvEs2ZaNE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dajihicV7hf3p5P1DZEXAgk636V8UEphszQHqflrcWMGDlZNN1w3bOU5oo+afzWuF
         Lohg3oOgDBhEuzfVfA0cHl1+Ml7kg/rySRVZEOg+Qt+adNO5ja7jH/Z10LLSdZ5017
         LGxtTqPhioJIOCe06G45wIDrh7U1QJ1XrXM5O63k+dwjHyN552Y7i0sIKAiQRBmVwl
         /Uk2h1FI1iRyaLcunC40avS67umHYpR7tzQEz82WhI41zxP2q+5E6pMOYtjXT68Gxa
         pu4PoB8Ar1mAHjSFIzF+0bSzulSXMio5sxLTx1blKnPuyWWT+hsebzP5IHNMfQkh5G
         FqR77e1EpNdbw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3A045CC13B8; Sat,  9 Jul 2022 19:47:21 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216229] Same content in two different files - strange problem,
 unsure if caused by kernel housekeeping
Date:   Sat, 09 Jul 2022 19:47:20 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext2@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: joerg.sigle@jsigle.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext2@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-216229-13602-gjODfGtalG@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216229-13602@https.bugzilla.kernel.org/>
References: <bug-216229-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216229

Joerg M. Sigle (joerg.sigle@jsigle.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |INVALID

--- Comment #1 from Joerg M. Sigle (joerg.sigle@jsigle.com) ---
Found a resolution outside the kernel - content was copied later on through
some symlinks. Sorry for the trouble.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
