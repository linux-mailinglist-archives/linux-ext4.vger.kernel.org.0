Return-Path: <linux-ext4+bounces-12220-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D4ECAB51D
	for <lists+linux-ext4@lfdr.de>; Sun, 07 Dec 2025 14:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D35A30562E8
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Dec 2025 13:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92ECE2522A7;
	Sun,  7 Dec 2025 13:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VC9TWRO+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33673EACD
	for <linux-ext4@vger.kernel.org>; Sun,  7 Dec 2025 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765112872; cv=none; b=uLVKEEKAu4fOjlCEcZQS1sYclLaO/QC3b2obLZswkuwB8BxJDNQ8jYHRFQPlJUsyQoo8tHvK8CAC2tNAX7/L39XwPSW2wzfEN5OK7tXJf6hmboMCXQoZ7Y3kXMZ2qfzfwzWE/7gXCZiHG/DGYLAYOaHSVxMb0MRnVfBPOdsv5/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765112872; c=relaxed/simple;
	bh=cQ02/bcLz1f74TL6tiGOhzRl8G/PBmnNZSkrJoMk3Jw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m48WZ336FrY3lmV7fsfNp3w3vVlhLkYo14DYeQoNUpuEdPZshx1g6tXOJSAfeUwL8bROO9byH1gF30s2QOsaiO5Y/F3ngjSx6+z414iP8BPvZXgCFS+ilopVZeB3sw86d9R7orW1jRDKXnpZGE9/0r+igHWZhW7T+VxoLbJY5e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VC9TWRO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC3EFC116B1
	for <linux-ext4@vger.kernel.org>; Sun,  7 Dec 2025 13:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765112871;
	bh=cQ02/bcLz1f74TL6tiGOhzRl8G/PBmnNZSkrJoMk3Jw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VC9TWRO+oXArIeYuc5+ISVsw+0XiPcBHgg8kAXkn+p3hJiTRexMvxJJgo4DF/b6mC
	 NCdDD+wXSSaiCs5Jh1bFxNn7YYSzsz2tfPeugoqBgeqNH8XQKhnZkQzDvjaSPbcNYF
	 f/QkUGdQeSe+PKwA0wtAGHlt8wfLIrag+GWz1dbDv+hVL4xPG6Kvyb2hAI6nxlSRQK
	 VngD2/g0ptNvxwmmV+w7eTGebe8p6nLPuFiK3v4a5oq9F/YZ1KueoaLJt8uTnPHzx/
	 y1cng+W1pfOWH/uA5VHoRD+WHKNeQMJTNwoNgoPy79V4aeZrAe4/lQrd1i5oo3C/dD
	 k51Y+SEcTQZSg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9F792C41614; Sun,  7 Dec 2025 13:07:51 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220842] dmesg flooded with ext4 backtraces when underlying USB
 device chokes
Date: Sun, 07 Dec 2025 13:07:51 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-220842-13602-o2PcksivjR@https.bugzilla.kernel.org/>
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

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |INVALID

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

