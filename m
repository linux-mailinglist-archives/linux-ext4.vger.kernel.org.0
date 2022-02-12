Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7FD4B3447
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Feb 2022 11:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbiBLKnX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 12 Feb 2022 05:43:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiBLKnW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 12 Feb 2022 05:43:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9962655A
        for <linux-ext4@vger.kernel.org>; Sat, 12 Feb 2022 02:43:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E557B802C8
        for <linux-ext4@vger.kernel.org>; Sat, 12 Feb 2022 10:43:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 230BEC340E7
        for <linux-ext4@vger.kernel.org>; Sat, 12 Feb 2022 10:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644662596;
        bh=ZZbklas3wdfyVjwifCSnK+tLQHL9DNxNcVwNUo4q9T4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hWzCzLQC4aLWGue+fbZIy+x+aR8UG/0v210NinnnUB9sXSE79TyPezODZmg9K8/Rk
         GQTqTnzl74w9SDqdRrfTFb95tcP7cbdksS5ZJn61y7F1y0l+qddbDRlALIjcG+Blnz
         J9jZVwYXKO1sQgw1tnri49hYm8PUlF4EdRMi0+bXawnNuSVQssJpaCWnJsxTbK2D6p
         53S0N2Jdep1uRCKSavHuzUgAslFPVlncp7pocAUyZ/g+8Vsi4Pl7uCnMhIRfUdLeGA
         wksXYypRw7a/F03fSqFrHgACD57dcgA4xMBCa/h9UFWgkzjvrPe4W+QMsonNA6cLzK
         uQOv++/WkzDuw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0E612C05FD2; Sat, 12 Feb 2022 10:43:16 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 213137] NVMe device file system corruption immediately after
 mkfs
Date:   Sat, 12 Feb 2022 10:43:15 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: btmckee9@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INSUFFICIENT_DATA
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-213137-13602-mtXZGTpxbl@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213137-13602@https.bugzilla.kernel.org/>
References: <bug-213137-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D213137

Brian T. McKee (btmckee9@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |INSUFFICIENT_DATA

--- Comment #1 from Brian T. McKee (btmckee9@gmail.com) ---
This ticket can be closed. I think the issue is better explained in ticket:=
=20

https://bugzilla.kernel.org/show_bug.cgi?id=3D215595

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
