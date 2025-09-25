Return-Path: <linux-ext4+bounces-10429-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30245BA10EA
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Sep 2025 20:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6EE2B4E141A
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Sep 2025 18:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEA331A56B;
	Thu, 25 Sep 2025 18:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKgA3uMq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2364A944
	for <linux-ext4@vger.kernel.org>; Thu, 25 Sep 2025 18:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758825870; cv=none; b=tuDP5I0ql36QuOK1XZHA6/SwNkPH+89b61y+4bQw+rQIzPGcjrtR9C/J8C+xMK7KVAFWu+UfIJ3c6sBWIx4PerJ/HrxtFk3+16Xj/gUFHyWteOesKngEavR2aI11itcg6zlWZjiLYKr4J3X+w7WQVmq5Tht9ygxJxa7o7/xw8ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758825870; c=relaxed/simple;
	bh=71dGzPAgS557ylZpvkMdraC8oWaRtDan+8I/JtgUREI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XLFMuA0ebd3k0wkybhSmNGKt7sw0H+fYySZuAm3/KjKWMnpv5Njvu/RN8JKwKkeva0WpHP0v2AWz+n4L8H5CjAy2G93/uVFzk/R6/LRo8G70vSLcxpQq6mgKL84axlzEtTaat53k9/rPCXmDnXa05Q2PF2mnhR6mRp3cIp2a2dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKgA3uMq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E1FCC113D0
	for <linux-ext4@vger.kernel.org>; Thu, 25 Sep 2025 18:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758825870;
	bh=71dGzPAgS557ylZpvkMdraC8oWaRtDan+8I/JtgUREI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fKgA3uMq+ZLBdDAFSmWRJIjADKpByUSgyhw3UY0ZemfQNk4TkUbST2cDzoQUMMihs
	 hf4BKsMopF64zt2e/+j4Ju1ChFG4SxcXabylmpghlXb9WpA3VYAQ/vD6JhTDahr+ft
	 kQc4vsA+pw+W1gyX0UY8y+66A+4CxLUYVrgIce14i82rNrcaj3prbk3nxWeFhOhZFl
	 OR90Zz77Kbf4jCqGnjbdLvR0gfbPS2b+oUY3bHiN7Z8k2U7Zm9QghAKNU3sKOhzUey
	 EITfIOuMb/bNsGwLPwgxxPXspBMG6BfMHmfm+N6+nccA/mM3xJLigeH1Y+Kqr3jrvg
	 M82kYd54Elonw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5058CC53BBF; Thu, 25 Sep 2025 18:44:30 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220594] Online defragmentation has broken in 6.16
Date: Thu, 25 Sep 2025 18:44:30 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-220594-13602-bPvIaF6M2n@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220594-13602@https.bugzilla.kernel.org/>
References: <bug-220594-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220594

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|RESOLVED                    |REOPENED
         Resolution|UNREPRODUCIBLE              |---

--- Comment #4 from Artem S. Tashkinov (aros@gmx.com) ---
I can upload a couple of ext4 images for you to repro the bug.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

