Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64465305D0
	for <lists+linux-ext4@lfdr.de>; Sun, 22 May 2022 22:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbiEVUS7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 22 May 2022 16:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345215AbiEVUS6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 22 May 2022 16:18:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30122369E5
        for <linux-ext4@vger.kernel.org>; Sun, 22 May 2022 13:18:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE63960E9E
        for <linux-ext4@vger.kernel.org>; Sun, 22 May 2022 20:18:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11089C385B8
        for <linux-ext4@vger.kernel.org>; Sun, 22 May 2022 20:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653250737;
        bh=aIJqfAC3NsJQpxYGDGJsOqVraljRgwqDOgL1ipcrTF8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=h78uXpXjmpDeNEv4ew23jl2vMZHRpEirm72yA9lvLK20S5yXOTdaiXXy9to+8fkMh
         zq2UWtQ1N2zlKjJvjuO38GMYdoo7Dc6MpU/8qYm3T6rpGvKPyj+HQDllxb86wyzjjm
         Eh8SX0g4DTY9adEBA57GkAOwpKybokM3HQhhVcrADHnKN20vTjiQPbNlcBpSlx4Fwp
         5499QvPxMyXr7wqYmI7aIjGXdd7871C26VGLo4XjMvK2QW0EooCdXjbs14IpV07hFj
         ivqOigeXHU1LgyIlv68bJ856M3r7/78IgIJfc/4WiGElmWllMy4S7fSIj1J/A2pO4R
         9RSxrdgjDhZxw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E68D3C05FD2; Sun, 22 May 2022 20:18:56 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216012] Data loss on VirtualBox VMs
Date:   Sun, 22 May 2022 20:18:56 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aathan_kernel@memeplex.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-216012-13602-n4vY5CsOj7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216012-13602@https.bugzilla.kernel.org/>
References: <bug-216012-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216012

AA (aathan_kernel@memeplex.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|RESOLVED                    |REOPENED
         Resolution|ANSWERED                    |---

--- Comment #2 from AA (aathan_kernel@memeplex.com) ---

I provided the information I had. You're not talking to a complete noob, Ar=
tem.
If this issue was deterministically reproducible, you can be assured I'd ha=
ve
provided the steps to reproduce it and any additional details.

There is some multi-factor problem going on here, and frankly, I don't even
know where to start in order to determine the cause! This is a linux virtual
machine hosted by virtualbox on mac os x.

Since the error is reported by ext4-fs, and I did not immediately find other
errors reported, I reported the ext4-fs errors to ext4.

One possibility is that this occurs when the os x system is under relatively
high load. Under 5x kernel versions on this VB host I have also seen some
occasional CPU X stuck for 22s messages. However these messages have not be=
en
correlated with the ext4 errors.

If anyone has knowledge as to the conditions that can cause this ext4 error
message, I will try to dig deeper next time it happens. The combination of
factors seems to point to core issues in the VirtualBox drivers and/or
virtualization interfaces but I'm just not sure. Maybe the virtual block de=
vice
driver bubbles up a timeout of some kind as an unrecoverable write to ext4 =
via
whatever kernel interface is being used to write fs blocks???

If you still feel ubuntu is the right place to chase down the issue I'll go
there. I've not gotten any traction from reporting the CPU stuck issue to
Oracle.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
