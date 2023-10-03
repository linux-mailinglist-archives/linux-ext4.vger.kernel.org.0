Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581FD7B61ED
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Oct 2023 09:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239216AbjJCHAl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Oct 2023 03:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239313AbjJCHA3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Oct 2023 03:00:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74459CDE
        for <linux-ext4@vger.kernel.org>; Mon,  2 Oct 2023 23:59:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D17A2C433C7
        for <linux-ext4@vger.kernel.org>; Tue,  3 Oct 2023 06:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696316231;
        bh=2enFLGGwHUXHiEquc8FYpDAYNi37oMWzR/dETStK2m4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=pOzB+QGEizS8Bpqaa3wuFDbrrGzjINdBAQoOVOUm+4VI7Ab2eIU1isS38SEi7Ys+Q
         k0LKtnWEENGDOJZ6K0WYMtsTseOIgY0vh+OwXq7BsGSxOm6sZCTCJFYbXHokJQiYp6
         q5rLCT7NyiPSAARi+/NVLu/jjkW9QC0c0OfIAXALS57bOOfnNLBhagiUNTlOl1IZV4
         +8zV4Uk3BaOIDri21os8QVHGrYFjTAjPRdyNc0yoJiXfqgVREsyonPCOo5OTbr0NzF
         K+fiRMgoUQa6jQ/NVEVNrT3gq+Dl86ca19lnX5GJAMsWBD6wku+0RYVGg8JquzXfxS
         wgHTUSIq0DEnw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id BC001C53BCD; Tue,  3 Oct 2023 06:57:11 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date:   Tue, 03 Oct 2023 06:57:11 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: iivanich@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217965-13602-BhEiwrGoly@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217965-13602@https.bugzilla.kernel.org/>
References: <bug-217965-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217965

--- Comment #6 from Ivan Ivanich (iivanich@gmail.com) ---
Hi Ojaswin,
1. Actually I'm not passing stripe option in my fstab, seems it's added
automatically. Could you please clarify how I can get rid of it?

corresponding fstab entry

UUID=3D3bd82ee7-f08a-4a23-8e50-2df3786b0858       /mnt/sdb2       ext4=20=
=20=20=20=20=20=20=20=20=20=20
defaults,user_xattr   0 2

2. The issue is reproducible/visible 100% of times when building openwrt on=
 the
kernels >=3D6.5 including 6.6.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
