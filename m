Return-Path: <linux-ext4+bounces-1703-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 123C1880B67
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Mar 2024 07:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C8D61C20886
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Mar 2024 06:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D825ED0;
	Wed, 20 Mar 2024 06:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9pjvrxn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D0311C83
	for <linux-ext4@vger.kernel.org>; Wed, 20 Mar 2024 06:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710917179; cv=none; b=u769XQ9CbgApwkWLS+LzbPbpnlthG5hMcwVMeebSMNN7lnQsvHUlXqa1+UQGwAgq8Dqcukm661ePuLANTbqwi/7/BK56jCJR2vI2ezEYoWXaUg9uAdoYRu7bw27fAlqoPZTkknEYUcbCvdn9z149nSQkzAjmcM8/u+IYFVPhQAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710917179; c=relaxed/simple;
	bh=FdLkF9W2z+c2deWmpcP9zltz11lhTjPyLY7zZ2vOvzs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PHZ0c5Sgry91WiLzBqlV6Y1ECb+3n/NRopFYu959iJbMJXPRNl1anKHA+oDcTUww1wXNRztu2eVIt9xx48xXJpBXO4ZrDnHwl9s1HUq7L5GZ9mdrsG+cA5o2lNQAzBD+76nv/5QqKyz31Wpggo5tLQNoSTeR/Ir+Uqgc5z0cUJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9pjvrxn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07D28C433B1
	for <linux-ext4@vger.kernel.org>; Wed, 20 Mar 2024 06:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710917179;
	bh=FdLkF9W2z+c2deWmpcP9zltz11lhTjPyLY7zZ2vOvzs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=K9pjvrxno6Pl2V73UgKnaje9pYV3IliqGDYx1CMwvMnlTYkHRIAWx/ngFxJ4Jvp+A
	 ATXsod8UDoq6xlG5vgIImaeh7IqqT2OXQoO3kmfxsMqb38O2ncHdw590C/kGHvVk6I
	 PR+FkUzxiboN99MmYm/nRUlm7aBz8DcaabchRI9btR1X/gApp+hdHjaWNJUBDpzE6T
	 /ynU4gbPt2hK3Z0DD9iVU/MnlSBiDCvCuNnsZXLnlpBg2++4y2y/sj8IY/IFpa1mkh
	 gfW2c8RHr+Wu4z5FWUC0JYuCspD+PuTQaIoTcWWZdflQ6fBDJOyp8a5SAFJeD1ydKB
	 0GOFOwSimKjsw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id F37C7C53BD4; Wed, 20 Mar 2024 06:46:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Wed, 20 Mar 2024 06:46:18 +0000
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
Message-ID: <bug-217965-13602-yqpMPovzMR@https.bugzilla.kernel.org/>
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

--- Comment #70 from Ojaswin Mujoo (ojaswin.mujoo@ibm.com) ---
Hi Eyal,

My bad, seems like the patch landed in 6.8-rc1 as seen here [1].

[1] https://lore.kernel.org/linux-ext4/20240110203521.GA1013681@mit.edu/

Regards,
ojaswin

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

