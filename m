Return-Path: <linux-ext4+bounces-12215-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 82491CAA73A
	for <lists+linux-ext4@lfdr.de>; Sat, 06 Dec 2025 14:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67A7E300A28C
	for <lists+linux-ext4@lfdr.de>; Sat,  6 Dec 2025 13:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3F32FB085;
	Sat,  6 Dec 2025 13:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjAXN+lb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C95C2F1FEE
	for <linux-ext4@vger.kernel.org>; Sat,  6 Dec 2025 13:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765028197; cv=none; b=gUF8UKGZY0IkamUhWMTdoisYvJrqTRXlrRa+zlWjjQEUL2t+k7ajLxj1R6zrlZJ6sheVYb840HS7z39CCrJS8bC1xVjbuXrI4yRMls5MjnQFaAhirGF5dpiQOQjCwVrUWcQMqw4//5CkO+Mz4yNcjvZT0tAL+D7uEQv+luwqKfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765028197; c=relaxed/simple;
	bh=JUbsAN/n+ivGUxseJyZL3Lbpoo68mZfoOa2lY6gZaZA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rC8OMmZsluerACVQToYDS3L7IWXv3wfsrmUpOQrOQ4aG/Zh8mwfYT/6PwTRI7b1cGZNYu54LPP0yyEUONHP1GmcK81Y/ePIJnDbSp/v3qFMx8iKA1etdyO8TBgLCTyO/8z707BeL2p3OHLyCOwNcWCtpyiGUQPshCyw+sfcu5jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjAXN+lb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8ACCC4CEF5
	for <linux-ext4@vger.kernel.org>; Sat,  6 Dec 2025 13:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765028196;
	bh=JUbsAN/n+ivGUxseJyZL3Lbpoo68mZfoOa2lY6gZaZA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fjAXN+lblZ2QDXgj/z2/feVTACsJAmYq/qIDTt2tb5NSBEGOd4BGqrkOV3nKERRNm
	 yTGiqrcpXUiR2QjHZ2ZwvuQe2gA+jJq0oTnQ8y7K8hSdEmF3WdTcdNZKvATctrTQ6Q
	 /ZZQeAnHzR+UnTwk29BWbKD0JrRWkcyLfQvevIvBzoTSyFsQgJsJqrHaMCPf8Xmx+X
	 Jba5xamXMg41Xbl1ktM2zbINY1aGzsxl86ngFW5kcUwL+FshIEp5BLuLtZYeFbcrlo
	 uk35wf9xo0Aozl33EnpxDe4DQXd/dkwfwEer/6XQOCANvTvRA5yM8tmsheb+GBqfKc
	 XL7Hp5oWBNpgg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B1A62C433E1; Sat,  6 Dec 2025 13:36:35 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220842] dmesg flooded with ext4 backtraces when underlying USB
 device chokes
Date: Sat, 06 Dec 2025 13:36:35 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: deweloper@wp.pl
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-220842-13602-a1EedLQCIQ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220842-13602@https.bugzilla.kernel.org/>
References: <bug-220842-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220842

Deweloper (deweloper@wp.pl) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.17.10 SMP

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

