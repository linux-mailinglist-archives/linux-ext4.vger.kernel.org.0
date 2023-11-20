Return-Path: <linux-ext4+bounces-36-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B30F7F0E17
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Nov 2023 09:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C96AAB217C8
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Nov 2023 08:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D55F514;
	Mon, 20 Nov 2023 08:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TljkDptX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94A979D9
	for <linux-ext4@vger.kernel.org>; Mon, 20 Nov 2023 08:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35AE8C433CC
	for <linux-ext4@vger.kernel.org>; Mon, 20 Nov 2023 08:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700470094;
	bh=p1RMvuU+UvCwXrO9STuUXf7BGcCJsFd5oNpuxwsXmI8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TljkDptXhFr0aPi/V9m++mfnKwSTHjO5JNdI5LuzUzinr/AMRMoe7KajqL6ja+Rqu
	 jBUl5peQdxHVD6cUbvvJQVQi2rjmajDdbxSYOLjs8eljg3e0MUVlvCqM40rGV5ix0x
	 G2DuH1DsbBpm85AwCaTEFCNFIwX87lrKkfGaN7Vi8+MhK2yQFsBxsrhRBzqkKXHsey
	 40MtVGswKhxQxiaC1p82KfSVs/6txDeByiOjsgKzKdxEECbMHZ4cefnfymsmD4exWE
	 p4njeZQgSPnoNg5xH6enXrqqQ1OoK6rHK4oC0N/KI+iyzlaToMM/pQ2QMAo8u6OFGK
	 lYGKMiBat8oJA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 19DA8C53BD5; Mon, 20 Nov 2023 08:48:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Mon, 20 Nov 2023 08:48:13 +0000
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
Message-ID: <bug-217965-13602-ckTQoXJlud@https.bugzilla.kernel.org/>
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

--- Comment #43 from Eyal Lebedinsky (bugzilla@eyal.emu.id.au) ---
Thanks Ojaswin,

The mount option did the trick, things are drastically faster now.
I am now finishing the actual copy that I was unable to complete.

The reason I ask about the raid is that it writes so slowly that I wonder i=
f it
is just the looping thread or maybe there is something more.
The large difference between what the array reports compared to what the
members show (in iostat -x) is beyond what I expected as the array write
amplification.

I will keep watching this thread.

Regards,
  Eyal

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

