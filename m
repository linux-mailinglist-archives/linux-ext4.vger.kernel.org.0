Return-Path: <linux-ext4+bounces-9823-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65603B45835
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Sep 2025 14:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E35B1C282AA
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Sep 2025 12:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366FE350D5D;
	Fri,  5 Sep 2025 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEvjO+35"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C852B350D50
	for <linux-ext4@vger.kernel.org>; Fri,  5 Sep 2025 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757076751; cv=none; b=N3cn14ck/CD3TkswjAZA4UeoNXwzqDKn7mlfKdLBXjhHWH9QrNkWXThv8jFail5THjjywk6Gpaf5ABsUpLNyRdE/CgIc7Kp643l6LEkGOF+opATyF+K2DeeJCVyJTk7CUz2z2Jf9k9Y5c3NXMU8cM7kt+OrgVRl95j1q48Mk8r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757076751; c=relaxed/simple;
	bh=tiQxFIEZtcv5GSmuPruvLG0X3eg/M1bjc1Q/HdmCGDM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TO6HfgJ8uMDn+sWf1KIHQSr8ZMtECfQrZRxCxs+6Q5qtmgiciLVMu8BwlPgWeqbm2iObLxsWo+bsQZEpJqXdpJAKyjEeU4TZPk5scwgVzrNsJXRnHAuQS7WqqcW5o6WLCgBADv+rsizC+CyVKigsp4Dt4i23rKMXMQ0kuEv7k0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEvjO+35; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A3FBC4CEF7
	for <linux-ext4@vger.kernel.org>; Fri,  5 Sep 2025 12:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757076751;
	bh=tiQxFIEZtcv5GSmuPruvLG0X3eg/M1bjc1Q/HdmCGDM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LEvjO+35kso9t7MHeEWSyqMfv78BZn+KQUtsxQJrIlOOTMcY8kOMBhMyn54dEfd2v
	 i7R6/8Wxk19B0FEPC/52jBJV8HWefBE1WDeGEov1Ls7FLAp7UhMY9PQDKq53gaEfQP
	 7uv7uRdC3q0cpiGo1Wb21mlanI81dkTNPkOrKr/vSrojWpuNh05IBmAs8JORHCQt5a
	 woh9fvyHaslPmLP2RTD1wvknkLLKTpC4lOg5tdLuafHOS20ygu4W+/gVDzxKgVCf0G
	 FV/nv55wpkNJ9CZ/Wa0TxDPTUhoMQK6C3YrYpcT2rqreAZ6bDUGaAo/E/SZ2pXDx88
	 aSOfQdraBRsCQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 35B31C41614; Fri,  5 Sep 2025 12:52:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220535] ext4 __jbd2_log_wait_for_space soft lockup and CPU
 stuck for 134s
Date: Fri, 05 Sep 2025 12:52:31 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: waxihus@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220535-13602-yF4ESQmOBe@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220535-13602@https.bugzilla.kernel.org/>
References: <bug-220535-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220535

--- Comment #3 from waxihus@gmail.com ---
We can reproduce this issue on linux-5.15.y and linux-6.4.0, and it may als=
o be
present in the latest mainline kernel.=20
What specific information should be collected after the issue has been
reproduced?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

