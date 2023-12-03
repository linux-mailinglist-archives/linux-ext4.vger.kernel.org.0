Return-Path: <linux-ext4+bounces-275-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C13C80217B
	for <lists+linux-ext4@lfdr.de>; Sun,  3 Dec 2023 08:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D07D2B20A9F
	for <lists+linux-ext4@lfdr.de>; Sun,  3 Dec 2023 07:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5852028F1;
	Sun,  3 Dec 2023 07:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJTzTdAr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D310C258C
	for <linux-ext4@vger.kernel.org>; Sun,  3 Dec 2023 07:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50F75C433CB
	for <linux-ext4@vger.kernel.org>; Sun,  3 Dec 2023 07:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701588831;
	bh=0fuF1i7Uu38J0z8t2ARXO+FmVfl0+hr05y8pJ6IUbQk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mJTzTdAr2MzndBqRtosAn+QfSxvfelh9V2w7aVT3GWFjpip5J99YMO26SmeEYQ7FP
	 QLXx79TQe61RMFJevp922H3xf2E6KCsKWXDLU4hMvdabslzjavFNDVufhthUIH6Vu5
	 gIFwspOb5/9sH/ojnqas4BUATEOwDJpdr3ukf8eNBvxQ5zya3VmGFK80pLgy1suWaQ
	 8J/2OYHcd0wT8QotG0qczFRQcL5sPGRUTJfYnpm/fVhrxwEOsIhPUzkCs96UHCsKFP
	 eUkMBZN+H3bwxvveCYCv7BG0sFGiOtqzuwlMEdXG9yAmIMzCk3KlGkdOEEcJqYW4LQ
	 5D3puUmfVfu2w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3ACB8C53BD3; Sun,  3 Dec 2023 07:33:51 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Sun, 03 Dec 2023 07:33:50 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ojaswin.mujoo@ibm.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217965-13602-Id6IUgcbFr@https.bugzilla.kernel.org/>
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

--- Comment #45 from Ojaswin Mujoo (ojaswin.mujoo@ibm.com) ---
Hi Eduard,

Sure, I'm on vacation this week. Before that I found some time to try and
replicate this in a simulated environment, will be sending a patch once I'm
back.

Regards
Ojaswin

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

