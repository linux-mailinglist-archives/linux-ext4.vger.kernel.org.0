Return-Path: <linux-ext4+bounces-11-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 507D67EAA9D
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Nov 2023 07:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 644AD1C208D4
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Nov 2023 06:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A0B8F59;
	Tue, 14 Nov 2023 06:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAPcJkqc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C858612A
	for <linux-ext4@vger.kernel.org>; Tue, 14 Nov 2023 06:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88A11C433CC
	for <linux-ext4@vger.kernel.org>; Tue, 14 Nov 2023 06:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699944426;
	bh=MJMd++cFiV68v0mcAr7FtuBQT9k/RCw6d/h4YFD5LWg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QAPcJkqciCFu9XE/AuOiBINJgDGQfuVkiZB7BzjMk+H0ecfAFuHQ2eNRTnIE+aAHH
	 hfAUD3yanjDeBjkmxNjpmC8UMF23yvdhwJiiUn9S7IZoY/TAQ3QD0GRKo8WQBZdoP4
	 0UrDgNWpe07AEnLM5+jBDe3IrvbAhAYfMy7OzIAZ1sEGsuOemieVyNFSJB4GbmxrBh
	 6kn4ywInqk3A/9rU/XGrLhXEed0xEq8ZdMMJ1eWJ5aUgWL9IB5G37c4ifFt0y67o9f
	 UJYCxn3KWKZqjaSn3lKSgfsoFd8lLeg4YYTpEG4i1HC43iw0TmicFc88phBOP/M0WX
	 y0AF4DTqnUcYw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 71FC4C53BD0; Tue, 14 Nov 2023 06:47:06 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Tue, 14 Nov 2023 06:47:06 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bugzilla@eyal.emu.id.au
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217965-13602-Dfai3w4ASl@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217965-13602@https.bugzilla.kernel.org/>
References: <bug-217965-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D217965

--- Comment #21 from Eyal Lebedinsky (bugzilla@eyal.emu.id.au) ---
Hi Ojaswin,

Thanks for the info.

This is a 24x7 server, so rebooting often is not something I would consider.

However, if a specific kernel is of interest, which I can install from the
fedora repositories, then I could probably be able to give it a test.

I will give 6.4.15 a try though.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

