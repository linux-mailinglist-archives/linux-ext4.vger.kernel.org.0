Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FA64E5F2B
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Mar 2022 08:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237660AbiCXHPU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Mar 2022 03:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347345AbiCXHPT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Mar 2022 03:15:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDB317AAA
        for <linux-ext4@vger.kernel.org>; Thu, 24 Mar 2022 00:13:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5BF30B821BE
        for <linux-ext4@vger.kernel.org>; Thu, 24 Mar 2022 07:13:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18F40C340F2
        for <linux-ext4@vger.kernel.org>; Thu, 24 Mar 2022 07:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648106025;
        bh=MJ0Ru+gWXixjCeE8i01yXtl0JrScudm/541FzRe4vAc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JlZ1GOQb/aSXj44CObEeho8irJfkLK77+IfM3M4B4KrVbYlgyCA5pqX0MGbHETaZw
         LmFz+LdlDtgPrAn54jO3l1HPo7/E0SyS0x51iAhPXRH9v5PvEUbC0b6IcDEvWyZPzZ
         AD5LKiEB0nAeTM/iFgcABcZko08umi5eBtAl+9jiJkxYaYhEaXzEJrrTgH9Lw3N3vS
         9IpD4MumTEjhapLkKGQsoS4zUVv7NY++lxP/b+Yb5tg4NwY+hRT+pdaZM2ln3RHwDK
         +w9U6z90uQYoTyIUJSciJvKcXTSWVpT3umpoW33dxuii/AjwrsLoBSHXJ5zQeANqoz
         eIQLQPSwFLO6w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id DFC6FC05FCE; Thu, 24 Mar 2022 07:13:44 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 215712] kernel deadlocks while mounting the image
Date:   Thu, 24 Mar 2022 07:13:43 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yanming@tju.edu.cn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215712-13602-jxnamfi1e7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215712-13602@https.bugzilla.kernel.org/>
References: <bug-215712-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215712

--- Comment #4 from bughunter (yanming@tju.edu.cn) ---
I modified an original image by replacing the value of its metadata and
recalculating the checksum value, unfortunately I did not record the
modification process. The corresponding source image before modification is
provided at
(https://drive.google.com/file/d/10Pf8E4OwHH7UDVhP3-mxhQuyijvHO3lE/view?usp=
=3Dsharing).
Hope you have a way to compare the difference between these two images.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
