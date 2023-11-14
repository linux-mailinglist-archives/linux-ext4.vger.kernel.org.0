Return-Path: <linux-ext4+bounces-13-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B8D7EAE0F
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Nov 2023 11:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45FAB1C20A7E
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Nov 2023 10:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752641946D;
	Tue, 14 Nov 2023 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCl8/fx7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFB119448
	for <linux-ext4@vger.kernel.org>; Tue, 14 Nov 2023 10:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74A6FC433CB
	for <linux-ext4@vger.kernel.org>; Tue, 14 Nov 2023 10:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699957785;
	bh=3JEtLXyya9pfd0DUD8PALCRcLKdw4vI5pep7P7K+qBQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QCl8/fx7obbftTy+U133OgdjdjCYFYl0s/Pa3QzY8Tfr+akNSXpZcZkl+eTjMtNP2
	 jtYBf16AHcNpBoypMeoC/vnFrk3qw3Gvtb3rY+mP/BOGdo+y0ifRnNZUtTMViwsqvq
	 zkwHJWqnxILNJwfpPFTO42p2G9Tr6Qfu9Dl2p2y46m60F0K1OtKzFhmuEY5HS+0Isn
	 qlCYx69cT40GEWO4ugmlRahd9R4D8mj+SKr/zhOMegqp+Eu5M6ITAZmXC/KXLxcgn1
	 aKfVAoeTi+qV9gRhx614+uZqaHSiU3bHX6Frn2GYXvfwwM1aUgLaXr0+5jv6x7Hthw
	 hCCLv5/3zsXVA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 60B2BC53BD0; Tue, 14 Nov 2023 10:29:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Tue, 14 Nov 2023 10:29:44 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rouven.matthias.mueller@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217965-13602-rv7NWSXR1g@https.bugzilla.kernel.org/>
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

Rouven (rouven.matthias.mueller@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |rouven.matthias.mueller@gma
                   |                            |il.com

--- Comment #23 from Rouven (rouven.matthias.mueller@gmail.com) ---
My oppinion on this is as follows.

a.) this openwrt runs on what? kernel 6.5 would not run well on a older
embedded processor.

b.) the controller chip of the hdd might be the problem, if not damaged the
driver of the controller does not have all the functions the new kernel ver=
sion
has. if the controller is not damaged try to install the newest BIOS for th=
at
controller, and may be you need a updated driver.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

