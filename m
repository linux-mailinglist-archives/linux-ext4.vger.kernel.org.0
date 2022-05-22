Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3190653012A
	for <lists+linux-ext4@lfdr.de>; Sun, 22 May 2022 08:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbiEVGE2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 22 May 2022 02:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiEVGE1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 22 May 2022 02:04:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CABC30567
        for <linux-ext4@vger.kernel.org>; Sat, 21 May 2022 23:04:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0BF43B80ADE
        for <linux-ext4@vger.kernel.org>; Sun, 22 May 2022 06:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AEF5C34116
        for <linux-ext4@vger.kernel.org>; Sun, 22 May 2022 06:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653199463;
        bh=A9LMa0aoOToVU6sAuwsGsteZ5SkDQCo4jMom2AKxrdE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VWwygcItL/ZsuNlnn5aa6ShiqabZ90tkwf/l7iN0WAyCniNQYhP6pAJJCGLDacKBy
         YXmVvv+f1vXs++neh8WqIwxNQgMkHhR0IKXNxVSJvTLiiHBnAe/81Q0o+rEvR9FuUJ
         TW1r+UsmhINPFp9AmMckocHJsfQRkT2XimG22WXSDeCwzYXKFBCHmNKEBQKRK8EmuX
         zo3MhBpPl2rvstBjKzL2Nd/oqW/u6+f0T29MFIy3sseV/ko+YngJ6EHU1KE9pAOO9u
         GBGIBmRNqJQ9fuJl5oLpglXTfdzRSny+uMjK1fgGlsULKTr/8jADx+cAI8r7mFMGkD
         fq0ujZTHGCuRw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 5F41ECC13B0; Sun, 22 May 2022 06:04:23 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216012] Data loss on VirtualBox VMs
Date:   Sun, 22 May 2022 06:04:23 +0000
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
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-216012-13602-CgXTBm2LdI@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216012-13602@https.bugzilla.kernel.org/>
References: <bug-216012-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216012

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |ANSWERED

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
There's zero info as to how it's all happening. If you need help you need to
let people understand how it can be reproduced.

Lastly, you're using the Ubuntu kernel and bugs against it need to be repor=
ted
here: https://bugs.launchpad.net/ubuntu

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
