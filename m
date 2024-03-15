Return-Path: <linux-ext4+bounces-1667-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F181D87D25F
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Mar 2024 18:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6D7281B4A
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Mar 2024 17:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E1554BF0;
	Fri, 15 Mar 2024 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhtorOrP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5D04CB3D
	for <linux-ext4@vger.kernel.org>; Fri, 15 Mar 2024 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710522183; cv=none; b=gU2DxUs/xf0h1Wm9nx4e9Kk7hzhWydhqTXluFsCAjc1p/SOv41PIv7iVrYCAeVITuWfNwuep4etDT9OruzAfNX7rP4tkvKeNXAV2uEUqbskIVHkqK+lsDqvc60CPxbWm4UUvOLVqz+GPIMtnoJXfi8cbstGn0QRDMaxsXaF2rYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710522183; c=relaxed/simple;
	bh=Rb3TCwrpmr+hUdwHE6pqIxXQs7JyH2MdhQSX88E8l2Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e6Hi/TSs0MdLK2yY9rKubekFU4xcSOjHN0MYSIbXGfpaluWzE4iqNyF/60UN/qk2kOS/uU7+hAH1sRhlmXQxQrX7fiMUYNMpkva8Zhag+fiCNkCTn7fsZXgYFYZkR2DWfZNT40R+ucYa4iUNnBSvrOxzYXvOLUcHunctHpZww9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhtorOrP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2926C433B1
	for <linux-ext4@vger.kernel.org>; Fri, 15 Mar 2024 17:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710522182;
	bh=Rb3TCwrpmr+hUdwHE6pqIxXQs7JyH2MdhQSX88E8l2Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PhtorOrPpyHu+F7rGXMCmwlDHjUd89f7BJGyJqzbxyMi0IPYh+ggVgZndVyNk2Moc
	 qxdHJ/mZIpDI55GwYKjn5je+hAtElBgEkmiq9R3atV89WtIoKOyPy9iELZvCyTHVqC
	 u+4ccfS7Jg56DJZZZPiiihgMXcwfmnQPGRSKUYVWr/ev3KrhPOh+Uybl1P0z53L/oR
	 AoB0PHxmCvNjkSG6CXlm1gc4s0+UkQtbmdttmB7xjgzCkTc9T27GXgJH4yNLGF/WW1
	 8GcO9jzEIUstr/VdrmDRafluOwEbjrBa4HBuHJbUSlSuCn82NJD6X/vQJa8ikOlwQX
	 nxn3Ekz+9XESQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 922F3C53BD3; Fri, 15 Mar 2024 17:03:02 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 205197] kernel BUG at fs/ext4/extents_status.c:884
Date: Fri, 15 Mar 2024 17:03:02 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-205197-13602-xnbhL3qtU7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-205197-13602@https.bugzilla.kernel.org/>
References: <bug-205197-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D205197

--- Comment #8 from Theodore Tso (tytso@mit.edu) ---
One of the things I'd recommend doing is to grabbing a compressed raw e2ima=
ge
dump.   See the e2image man page for the the -r or the -Q option.   It's not
hard to build e2image for Android.  At one point I had added support for
building e2image in the AOSP build files (although this might be before the
AOSP build system has gotten updated, so it might require making some minor
work on your side; still, it's really not hard to build an AOSP image with
e2image and debugfs enabled, and if you're trying to do file system debuggi=
ng
on Android, this is a Really Good idea.)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

