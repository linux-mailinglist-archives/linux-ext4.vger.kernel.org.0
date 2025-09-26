Return-Path: <linux-ext4+bounces-10437-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A826FBA5376
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Sep 2025 23:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CF011C04AD3
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Sep 2025 21:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26F029A310;
	Fri, 26 Sep 2025 21:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnRrOQNc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44657262FE5
	for <linux-ext4@vger.kernel.org>; Fri, 26 Sep 2025 21:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758922200; cv=none; b=sAUfzoVZwVS5EWHsSvqNNXsCxbDYniovbtJDQxA1rN7HDwCBXja09iIEky5NQeDaJxkoHJTLJSY6IORUreNsbm+uGp/y44ETTACevvK5A08FgCSVbzBw2OMS1O82EogWtPakMRxwzE851l7tSYdETHWdY3jOtv8fB79419A80QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758922200; c=relaxed/simple;
	bh=XjyzAhJGNgbnCTpF6Q06ehDUiUnI1Qq9zKdsVE4FoLE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uNGYnnYrqUD+DlHuOgQwkTXd9r0KH6rkYf7gmO/XWuloGsRrmM1Idip8GQyoXMXOuPBeSP+WdlhMtGBrNSSo5Zc2IW9qxjaeastLKzmgpjRcixx6RewOJM21YUZHFo89TO921nsW4gtLbpxoCKgt4r8F+zmYvBnJwAC6s36pebU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnRrOQNc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFB5FC113CF
	for <linux-ext4@vger.kernel.org>; Fri, 26 Sep 2025 21:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758922199;
	bh=XjyzAhJGNgbnCTpF6Q06ehDUiUnI1Qq9zKdsVE4FoLE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XnRrOQNcEurbE7qigYcr2UEc0W0gCG3Wsa1k2pOc+2ucQjsPW4p1zaPfpVEU3ky9b
	 jVNNlbhnfVMi/hE22nf4KpFBJvkLxvOQwKIUasLLtt714VujpOMcpAuB5S7if+AAFx
	 mEOm/yDsGE9rwnDKWIrYT1IIftGv4nzv5+NMHY8716EXNbP0KxuoTdtLI98PtS3NPQ
	 rZOYvYeO8t4j4MWL0cmtsWPgPFIAsfhpfp0vFt081iIwHdzHmvGpN2uT9vStq+8uM6
	 WUosQ+GJoN7a6k6VhSZdJgY/17AsS9oSwlZ7Wn4mqARMc4UwDu8WUNUYfygbbXsIzU
	 ydcO/wDgJE1vg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BEB4CC53BBF; Fri, 26 Sep 2025 21:29:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220594] Online defragmentation has broken in 6.16
Date: Fri, 26 Sep 2025 21:29:59 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220594-13602-5QZ8wQkkBV@https.bugzilla.kernel.org/>
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

--- Comment #6 from Theodore Tso (tytso@mit.edu) ---
The reproducer file system which Artem sent me doesn't fail for me on both =
6.16
and 6.17-rc4.   So it maybe something which is specific to Artem's kernel or
hardwaare configuration.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

