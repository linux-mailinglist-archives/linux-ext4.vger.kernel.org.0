Return-Path: <linux-ext4+bounces-3356-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BC99394C4
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Jul 2024 22:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D53D51F21CE8
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Jul 2024 20:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591C623746;
	Mon, 22 Jul 2024 20:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuGz/7Je"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D689E1DFEF
	for <linux-ext4@vger.kernel.org>; Mon, 22 Jul 2024 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721680298; cv=none; b=jTSiEnnp6lwQBxy7yd63CaJ5Bqb+CtWIkHvIzmdNgHx22DaRQFfLr063nkJnDPc2kt6Pue50ptmsBI55Ja7ko222bYnAgKE1jmC+ixUz3DIJ9zyGCndHIpWjxQSXD5ZtgCLVI7os/2S3gtw4hdZ+fyyEGO9T12Te737qngWDu/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721680298; c=relaxed/simple;
	bh=Hs5xVDKdF1b+xNN+PV2HN+BIkEWLA4iwb0TypYRB+GU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MNMk6boEFefK5LdLGs3PVc98khIe+buCsfdRleEpEA0SUc6/S5Z+usLxqK3NrU/UQzk9pCGfZlVkWhzE2Nb8u0F7aupM03+6XCX7Z/ddghbe7Ynfn16THd4itFHQj2eByFmB/arOoGkGicnpMwFzrNv84zOHZU/RwVXJO7fbKyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuGz/7Je; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51365C4AF0B
	for <linux-ext4@vger.kernel.org>; Mon, 22 Jul 2024 20:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721680298;
	bh=Hs5xVDKdF1b+xNN+PV2HN+BIkEWLA4iwb0TypYRB+GU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GuGz/7JeQLVuS+gu/womuTOAjvaTXTw9wRakbFeo8OQGu5UQhKzj+zyEdOXg/oXEw
	 Jx22BILrWChPiLi04jnZPGVD2rhYWUtt7nTo4Vbyi+GcCzdXuHQVtvcmkjma/9WAsE
	 hFlPcGqdYYnYbxKJs44NquaY0WNH2iyBUqWn9a6GF+m4MRpyz1MmP7y/UL2Bx6FRKI
	 Ek904Q9y/3HMmUvA7k3jtu6KK/iPyJ+//czwgKyK5pa75yr47Dif80v7xjghKBnn1c
	 Smor3/jfBa81jh5fSJXArF8JW34TRwgbopPw8m7sjGa0EElLWnb+aYvKwrf2tzP48O
	 2n6GNHk32HNrg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3B2B4C53BBF; Mon, 22 Jul 2024 20:31:38 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219072] After updating to kernel 6.10.0, one of my Western
 Digital HDD stopped working
Date: Mon, 22 Jul 2024 20:31:38 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_file_loc
Message-ID: <bug-219072-13602-SeT54kWeai@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219072-13602@https.bugzilla.kernel.org/>
References: <bug-219072-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219072

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                URL|                            |https://lkml2.uits.iu.edu/h
                   |                            |ypermail/linux/kernel/2405.
                   |                            |2/06434.html

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

