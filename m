Return-Path: <linux-ext4+bounces-579-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5185F820186
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Dec 2023 22:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82F891C2134C
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Dec 2023 21:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656DC14291;
	Fri, 29 Dec 2023 21:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F21oXg/W"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0E214A92
	for <linux-ext4@vger.kernel.org>; Fri, 29 Dec 2023 21:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CDB1C433CC
	for <linux-ext4@vger.kernel.org>; Fri, 29 Dec 2023 21:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703883957;
	bh=39HaQlLhVNJSmmRxf3SfulMH1K8OYe4nQci+H5XJeNo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=F21oXg/W+ipdZXSJqNfXsHwIq2UTHAD7yEhhg1/xs0wrS7A9HKoBtdH0Z+bpDBaJT
	 nX9n4roIE+bJcEdU8buOsHqqoMv6G1Q1rUK1AgC58FY7NXXmF0ERmjhw6R/dYDSZV8
	 APAfWIe6tQSaH0VOGOG2dum8Rrx49w1d12egbNA1ZLsY9IwUlXwvOFzaXYpYmkHC8g
	 HcYyTGRq38EC3P7P7XQuMGK8vD1x9Qrgx7nExYwfh/xZVg1mZ4LKNFwy6zTE3677yH
	 tAVXXWPi8fhXs11S1JsjFizLA02BDiLeF8dOKEEYqQa67NDpwApEhLSfT3GHSJ2GVj
	 9VtP6KnKbJVjQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 48BCBC53BD4; Fri, 29 Dec 2023 21:05:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Fri, 29 Dec 2023 21:05:56 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: matthew4196@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217965-13602-1VtZ2o5BpL@https.bugzilla.kernel.org/>
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

--- Comment #54 from Matthew Stapleton (matthew4196@gmail.com) ---
(In reply to Ojaswin Mujoo from comment #46)
> Hello,
>=20
> I've posted a patch that, as per my understanding of the issue, should be
> able to fix the halt in kernels above 6.5
>=20
> As I was not able to completely replicate the issue, I relied on the prob=
es
> and other logs collected to root cause this, so I'd really appreciate if =
the
> folks here can help test this on their setups where the issue was being
> observed.
>=20
> Link to patch:
> https://lore.kernel.org/linux-ext4/cover.1702455010.git.ojaswin@linux.ibm.
> com/T/#t
>=20
> Regards,
> ojaswin

It looks like that patch has fixed the problem for my system.  Thanks.  I s=
till
haven't checked if disabling CR1_5 from
7e170922f06bf46effa7c57f6035fc463d6edc7e also resolves the problem, although
I'm still planning to try that out as well.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

