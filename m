Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0976431EC5A
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Feb 2021 17:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbhBRQfN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Feb 2021 11:35:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:53964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233061AbhBRM6L (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 18 Feb 2021 07:58:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id ADC3364ED0
        for <linux-ext4@vger.kernel.org>; Thu, 18 Feb 2021 12:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613653040;
        bh=qgmtcDjZc8vUq+jpvaesDWxlBuSX8g76jdKgm5E3MPg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JO5p0VOdsRZChbERNHPxQBvDA44TsA7txBp79WaSBnggPHcFKuLn0o++GeLKPGFoX
         Cizz6fMWztfn9WDJ8Lu4tKcaQBzrlKj2acDHS6blP7G+JLb9yhQH0Rmnasnk7oa9I1
         3VFjDfQuzApn4MGV6KQNWpBlDC7S15PkinIpiyePPc+Eea5locaaBo9DRS3hBEg///
         i+z7vJqZRMGO2O0yygdwU64KZ0xKfb5l2euXJMUyu7b1m9AEnaBngm8eC3Tfup7qBq
         x3gDNxy5pkvLICaleIsEzo/QA2L8TaK0qrXCCUfMeZyQ1qvUfP47JOQZSFYEllsIO5
         iF+2GfEp7OmTg==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 995AB6530A; Thu, 18 Feb 2021 12:57:20 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 210185] kernel BUG at fs/ext4/page-io.c:126!
Date:   Thu, 18 Feb 2021 12:57:20 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gernot.poerner@web.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-210185-13602-3c3hwTLqdB@https.bugzilla.kernel.org/>
In-Reply-To: <bug-210185-13602@https.bugzilla.kernel.org/>
References: <bug-210185-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D210185

--- Comment #15 from gpo (gernot.poerner@web.de) ---
Ok, quick update here, we built a vanilla 5.10.16 and ran that for a couple=
 of
days and it didn't occur again, so it seems to be fixed, at least for our
problem.

We will test with the official Debian 5.10 which now also was released but =
I'm
very optimistic it's fixed.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
