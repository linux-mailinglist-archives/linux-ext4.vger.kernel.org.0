Return-Path: <linux-ext4+bounces-12221-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6334CAB649
	for <lists+linux-ext4@lfdr.de>; Sun, 07 Dec 2025 15:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 256CE300957D
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Dec 2025 14:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A73F2F0676;
	Sun,  7 Dec 2025 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUZdtOwK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3F52F0C6F
	for <linux-ext4@vger.kernel.org>; Sun,  7 Dec 2025 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765119267; cv=none; b=RaCjjP9Xf4t+aHnnHI5hFomLm8MZF3hLoR93VB8e0TAb7GxsyT6KznfBPn3MxJ+25nlthiNXFN/CZ4GKLab1dfrI63vquZYSGsvF70PjugJjvmOLC4u4XoSY9VlPjuAhuYLxiYVwZ3Q2ZzPRMj/zCJPZDFcHyr4vYmFzXWNc/0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765119267; c=relaxed/simple;
	bh=N888dbyFt97vHc/V8gWhI72D6De9UjeRPhyOVFfVL74=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fce2pwCXvMdx1MWcoXEgNYq8/TpTEhgKP8Z4qAjquoEZs02lZSlwWLhgZY315JYE757X+9F1dIgMvz2bcgBtbLgke6BBRu2mXPLZ4c4V9ktF3/edJPJfwlGYVsq0kBWFwGxuH3JYRy4Y5RMN6OsxvT3vfBHKzmwWo6hMfr3E03M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUZdtOwK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 404BFC113D0
	for <linux-ext4@vger.kernel.org>; Sun,  7 Dec 2025 14:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765119266;
	bh=N888dbyFt97vHc/V8gWhI72D6De9UjeRPhyOVFfVL74=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZUZdtOwKH9iPouTfW5GF43ypujbe9IMIaxgWS/boYMzLNgPscnHEwI4ZYfFALwGub
	 ravDQz7A1wol29g6th3E3nwNPdhAHaYK7UIH4MqsJudbAlkchArYYcWVJ8rWKFq4iZ
	 WBuGNRkW5ZZrZ5WvoXZlTRMwofw3xBE0MX8F2fDGAQZMvPjDXhqnMKTPzFKe+xpOM1
	 VDzQA9b4GFZjH+H/Y6dQu93tI26z9aa9BkkpbFqe6ccIUl8E85HtRLMsJo0av42xF5
	 vXDT9iPVcDIqc2z4aMiZ7LkT/GC/BoAK6l0Ers2NXv93JeBkZTFBfe21PEQEukJndd
	 TkS1dZqWrd0TA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 39DD8C41612; Sun,  7 Dec 2025 14:54:26 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220842] dmesg flooded with ext4 backtraces when underlying USB
 device chokes
Date: Sun, 07 Dec 2025 14:54:26 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220842-13602-aMTfI0qpFs@https.bugzilla.kernel.org/>
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

--- Comment #5 from Artem S. Tashkinov (aros@gmx.com) ---
Ted, maybe it's actually worth implementing this feature in the block layer=
? To
notify filesystems that the device has gone for good?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

