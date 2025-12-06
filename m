Return-Path: <linux-ext4+bounces-12216-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B72BCAAA20
	for <lists+linux-ext4@lfdr.de>; Sat, 06 Dec 2025 17:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AB01E30110C4
	for <lists+linux-ext4@lfdr.de>; Sat,  6 Dec 2025 16:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F53B2FFDE1;
	Sat,  6 Dec 2025 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHuvIdyW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB83B258CD0
	for <linux-ext4@vger.kernel.org>; Sat,  6 Dec 2025 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765038302; cv=none; b=KqLEghuqFNR4zgxXsSiMFwjrspwIv3RKWeAL7AyXsyedrXYWHnSHcXjwTlgN0fGh8AOKOxWJRv/Cw6thVzZVFBQhhpNzBnwiR+ZlcY7o/8SdWUlHY1mEqJEwDVev2LYMZyKTFA/fWm3skGnG90F0uV928Pm3kQG3whZh+htPTg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765038302; c=relaxed/simple;
	bh=M6236bmOILrh6e2T40n/HcdPyHLox/XwNaM5L33ftj8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T4+kPkP3Ot5L3qkf7z7sxTvMUCewDBZwpnEH78D0/HqTGqhwe8dslkrVzMFuucnNJfvcXNybZO3Tqg1khjlV0hBpzkM4BJFvLFOE8q21vnq14TCbOPQvYRD083ngJhK5dSdYMddQk09W1REjTnQEAtaCa6fPHzRPntG9LZ64r6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHuvIdyW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FFCAC116B1
	for <linux-ext4@vger.kernel.org>; Sat,  6 Dec 2025 16:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765038302;
	bh=M6236bmOILrh6e2T40n/HcdPyHLox/XwNaM5L33ftj8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kHuvIdyWRGTRIpk8SKWdFCRMX56Sn0r42Ldtn6m3UIN013gqG/xkh8Mw/nsuIK7O6
	 Oykixvhp/FqL1+NXLQs13yftrLxBIPPyhynbvyK5Mh6kMYAyj+v0sPGQl/kdN+nefv
	 tohIhIWqrUkewTdGxREi7pmu4yjUDtTMlHBv9PZdKFvrxgcgn4UpWh0Go62xsnrg8H
	 jFFCMKmDZJ6jbnb7o97ucOIT5JrSptwtWGTiI12MaHhZgFxwslg+V+m5/xtmHptBco
	 /yGFFvTl9PdGmtdY8v2zOZodeDzOk/la3D/KAZyIEW5QpT1ePy9TWFFq6NlG3VW0W4
	 MFpPjAIjmjGLw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 83A45C53BBF; Sat,  6 Dec 2025 16:25:02 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220842] dmesg flooded with ext4 backtraces when underlying USB
 device chokes
Date: Sat, 06 Dec 2025 16:25:02 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-220842-13602-TogSmx8avA@https.bugzilla.kernel.org/>
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

--- Comment #1 from Deweloper (deweloper@wp.pl) ---
Created attachment 309008
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D309008&action=3Dedit
Messages from before 1st call trace

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

