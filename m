Return-Path: <linux-ext4+bounces-10602-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 073FBBB62AB
	for <lists+linux-ext4@lfdr.de>; Fri, 03 Oct 2025 09:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F3A19E81D7
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Oct 2025 07:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CD223D7D0;
	Fri,  3 Oct 2025 07:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXL0Kaq1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F832045B5
	for <linux-ext4@vger.kernel.org>; Fri,  3 Oct 2025 07:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759476535; cv=none; b=LYZmF1ZAb55PyhFh1fpwXYH43hwfZR9KFJKZvkLTPRfNoItHjqJZq++k9OqdCTGxtH9H9U47Sk//G08fRbxK71dIiiH4yl9psd9SD1GWlsNWSa7foG2gru0qNf3cxuuzVlx+Gzfl9+UvxJpashQMJYkqPR8AiW1EHyHVwSTn7xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759476535; c=relaxed/simple;
	bh=WG3WC4HOLSGjpx49I+8a8Kx0AcnvfHcUhZwc1KSZw5I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OPhEdpytWZ4gd5Qx3V8BQB3Xjz6t+/YfqzOLN/M1UjLqo4VeuAtFE/88rpcBTcfBRWZKvChghyNKS6hIC0KJv7ZueFLG19v6pW5TEpi8ZT5/Qu1RwKR5eMevN4s8LYUA+IWZKW4HBFtzuKsCwv5DPDrr06xp+kAetR19UrPeEw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXL0Kaq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AC4EC4CEF7
	for <linux-ext4@vger.kernel.org>; Fri,  3 Oct 2025 07:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759476535;
	bh=WG3WC4HOLSGjpx49I+8a8Kx0AcnvfHcUhZwc1KSZw5I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MXL0Kaq1Ls3vHltkun2ibSgfX90dvvgXot12IQSgsycT8R4bFVdfYbxyOX/eh29/A
	 Hr6gTPg1GgplgxXOHa4imrkRWOyak3EQVvAIsYabo3e2FH3tXrVPqaeOOqM1KSa6ZD
	 bCPdFgrXTefohhr8RAIRKti+O7sQaUBJu4T1+IseFlw0iC9865ZbgvuiUrAKHAlTCq
	 W0V5RvZaHK2rs5rws02Ajo42VccXhvv+DrE78co70TjdZ8GnpLLcq+/U9B/EDetjH9
	 oh22VPwX7yyGVrXB3kaxK0pqs16WMUg+YcrxS4c0lBPsTFXZW45d9CSkO7oxWEYcUr
	 3ezAe+dblPDMA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 04059C41614; Fri,  3 Oct 2025 07:28:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220623] Possible deadlock, system hangs on suspend
Date: Fri, 03 Oct 2025 07:28:54 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: athul.krishna.kr@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-220623-13602-4pOF79UcWP@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220623-13602@https.bugzilla.kernel.org/>
References: <bug-220623-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220623

Athul Krishna K R (athul.krishna.kr@protonmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.16.8

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

