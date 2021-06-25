Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7563B4430
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Jun 2021 15:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhFYNQF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Jun 2021 09:16:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230151AbhFYNQF (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 25 Jun 2021 09:16:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id AD0F56195F
        for <linux-ext4@vger.kernel.org>; Fri, 25 Jun 2021 13:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624626824;
        bh=Kqn0sHGFNirGC5Gc8wyUzra2q8vmfnkw9ZBwWxr05wY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=iwaEDrwD3Ji2fMDNwxtXgCUJw77w+fJL/Xk6mcsyUnZ8cqjvfZyo1m6NYXm73pjSP
         Vi5K99KcyyygzBIT2eRx2aGGwbwvSImYnjL2sOIKDb5b8REz4Vv0JfrsswB1GHrojY
         kLeX18JX3seJwc+W4PI6Tp6RIOFMxqoHgYTJ+q3J0xoV/2kZ6PrSz4eK7jHAh1Yakl
         Ep+pdYnwcTyStaBU1Iq7gdpYy2Rl1dcnhCAPi9ElvwRnt6wkxV5KN+QidG32HHZTKX
         17XiKp7pOrj/RdL+mhsMLKpW+JxxQh//9u+iHKozU35l5p+qMeF39NYksIqnFckCTU
         TDM/w8Y42zTSw==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 9CFA9610D0; Fri, 25 Jun 2021 13:13:44 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 213539] KASAN: use-after-free Write in ext4_put_super
Date:   Fri, 25 Jun 2021 13:13:44 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: 6201613047@stu.jiangnan.edu.cn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-213539-13602-gyhf58LBId@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213539-13602@https.bugzilla.kernel.org/>
References: <bug-213539-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213539

--- Comment #3 from 6201613047@stu.jiangnan.edu.cn ---
Created attachment 297611
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D297611&action=3Dedit
kernel config

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
