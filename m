Return-Path: <linux-ext4+bounces-9-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE8B7EA622
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Nov 2023 23:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 934A1280F60
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Nov 2023 22:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C9D250F7;
	Mon, 13 Nov 2023 22:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcmpC3MA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7644F156C7
	for <linux-ext4@vger.kernel.org>; Mon, 13 Nov 2023 22:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE1B2C433CB
	for <linux-ext4@vger.kernel.org>; Mon, 13 Nov 2023 22:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699915607;
	bh=JC1OND4QKQhUzZmEMHUfcGyF2H2Yd32lN8oblUkiU1Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PcmpC3MAa/455J/VXOuG02LzeGMjWDxEDetsmcZfTTWD7cjEUBKnmKe0CyrJgOktI
	 MHf4bT/9jd5HSjK5pdoKod9frUILM9EiZ9ZkyUFc5I6Dd4C9zidKSUkIURHw7Bs9Au
	 Mu0/Rz7GQjOVAaQhbZMIxl4We7JXwjW1bPnqGxvVLv6JBfvgw692Fw7sEgJ99m5mNx
	 lcBfRo3FxYdqf37F2y3uJ5Dk5LZInAUS/JKavZRD6alPvHk0tHfQBtJ/qdvT4QQxeN
	 28/B/2NhgKFvhKM2HROkqCEbbo1uXXb57OtV9ALP5lWTizwqW1PqcRrxzfgXERZXvI
	 CIanIUbdxbjwQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C6D70C53BC6; Mon, 13 Nov 2023 22:46:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Mon, 13 Nov 2023 22:46:47 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217965-13602-b9S6ApC00E@https.bugzilla.kernel.org/>
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

Eyal Lebedinsky (bugzilla@eyal.emu.id.au) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bugzilla@eyal.emu.id.au

--- Comment #19 from Eyal Lebedinsky (bugzilla@eyal.emu.id.au) ---
I seem to have a similar issue, on a PC with raid6, which was discussed here
   https://marc.info/?l=3Dlinux-raid&m=3D169922587226984
which ended up pointing me here.

My impression is that it is not a fedora (I am on f38) specific issue so he=
re
is the correct place to post.

I see no progress for 4 weeks, is there any update? It looks like people we=
re
getting close to understanding the cause, maybe even to a solution.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

