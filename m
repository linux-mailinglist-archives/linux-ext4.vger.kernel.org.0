Return-Path: <linux-ext4+bounces-12218-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05464CAB3CB
	for <lists+linux-ext4@lfdr.de>; Sun, 07 Dec 2025 12:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C70C305059E
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Dec 2025 11:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B727A273805;
	Sun,  7 Dec 2025 11:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHrZNJxG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5752C24A076
	for <linux-ext4@vger.kernel.org>; Sun,  7 Dec 2025 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765106025; cv=none; b=Vjge7gwO2e7dlK+xwHXuTydzyTVXjlbRoiZYKsSGDOKc33LIfAFBiUS+OmyGTe1L/BXN2G9ShlGoUe62cbkZurhY10vb8hAvGtsjcIFIhqbBbHibZtF8vCkADvWiRwfEM0Ns5HCWNF604FCE+vsU63siOEr+h9D40wHd6d6IA6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765106025; c=relaxed/simple;
	bh=c9Cm8Ph3jUia32YkR6bjlvtHis3HpiD/orJ19vuyVmo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OE5J8jkILpiIP0OAlFFVgwPh1JzRE5HefBR/Hvrn1cRrNCPkkQRkFL7kuubNjtkIOdtXRmbBnbzqjJFIQp0qmvl+hh0JtEcoCyEnpCnyG27N49R15PzWumSXB+fh6OPi8DdJ7uAPBPgUHFxxmGopSlvgM6uUfX8Z4JrherV2Vds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHrZNJxG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1031C19421
	for <linux-ext4@vger.kernel.org>; Sun,  7 Dec 2025 11:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765106024;
	bh=c9Cm8Ph3jUia32YkR6bjlvtHis3HpiD/orJ19vuyVmo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cHrZNJxGqP6Jk5vllVNXi8Hmq1cflWhzxfRZjXh6l6Q/5hW0xoenJVUVK/eNaxalE
	 65UK0s20fSnE85v1Gb1auIXYJKPKslQGykDzMrQfUCXZ1LxxC1v7qd3AzawgofBl7D
	 1NZyGHpWM9IlF3tXRRDGO7dj7hdHKRYQZOUu7TXreDHMrz90Xt1divzKpDKz24jENI
	 vikXVbi+mtDhoBCk2LyIvlP7BgrpmR6Emr/a57bm3507ELRWNdSG1V5Z9nEpMiJE6M
	 YgE50VdlEqMhrsydhfCbcLM9mEbFY/vjUez9s2HOhw9oSKVTqdw4CAZTbvTscC5lEM
	 dFwdxGyleX4eQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C37DFC41612; Sun,  7 Dec 2025 11:13:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220842] dmesg flooded with ext4 backtraces when underlying USB
 device chokes
Date: Sun, 07 Dec 2025 11:13:44 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220842-13602-ElDC2TcU2t@https.bugzilla.kernel.org/>
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

--- Comment #3 from Deweloper (deweloper@wp.pl) ---
This message and tons of call traces overflowing dmesg buffer make me think
there is some software bug in ext4 fs driver:

<2>[ 5451.308209] EXT4-fs (sdb1): This should not happen!! Data will be lost

What should not happen?
Some invalid internal state?
Or an external event out of control of the software, like disappearing block
device, what is normal/expected?
In other words, is all of this noise just a way to say that a mounted devic=
e is
lost?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

