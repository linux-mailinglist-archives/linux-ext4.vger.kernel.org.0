Return-Path: <linux-ext4+bounces-3804-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9EE958B67
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 17:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E0A3B24D9A
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 15:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D4319413F;
	Tue, 20 Aug 2024 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUj7N3q+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC261940B3
	for <linux-ext4@vger.kernel.org>; Tue, 20 Aug 2024 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167993; cv=none; b=TbRHS9IL0QS6JhsELq0TEso8GpMRR/a/H5I7u0SU4h+eCDJ6XRuUCb1+LoDU7ihxBCX4NUpnz+GOHd92B8Du7QJRFrW5It5bf3sWQD7aBV1w/ElkusLoDKeNZoIODp9pGCeNjrH52rGpbEMrTfTVhOJkk3uvvuc7MoRweIIDrN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167993; c=relaxed/simple;
	bh=hYN5MquIx/Vl7ek00+wLuUYEl2z33+03xbDhed17b7M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YvAQR2ascGCJ8P8y13yftKRPHXxl9luEuuHGzr646sdYOL9YjfxAvv8o7QWO1KcgXv6uP0EELpFx7vK1cidRuWfcK6U+6Z338rBPJJ390XUcFbahE982e/CHTUjAUp0A7HXX6twS9nR58Mk7Qm7o3d2LutuM/jRE5D1Vce7lA2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUj7N3q+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1EA7C4AF10
	for <linux-ext4@vger.kernel.org>; Tue, 20 Aug 2024 15:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724167992;
	bh=hYN5MquIx/Vl7ek00+wLuUYEl2z33+03xbDhed17b7M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sUj7N3q+ZAngceqwsgbJwZDYY28uJcWu4QYrwsSXQ9hC8iCik9dsYwzxFTfDxDBq9
	 BexWi39T+F5tvnXraQBaQ6keXcEFEIArZKG5s72y93JrnM3t9toLuhgMySxPf9FtBH
	 c0nLboZCXGXpZHteNwGT+HpFsr7HZ7ZoD7y5lLD9BPJUprBpK8i1oWIYhf/MeRuAjb
	 bFvn7M6K75Zhr9IUmuree54jxN/d2grjg2X89clMQEicLrVWWnGhBywlF8OSVQz3Sl
	 FZlqmDat2NgU9xP6VUSGCbGzmpvL7JsM1Bno87q2Lv0vZ7oMzsYmsua1x35nYW4ues
	 +9ND0T7pLQEWw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9FCECC53BB7; Tue, 20 Aug 2024 15:33:12 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219166] ext4 hang when setting echo noop >
 /sys/block/sda/queue/scheduler
Date: Tue, 20 Aug 2024 15:33:12 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rjones@redhat.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219166-13602-qeBGZzNcyL@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219166-13602@https.bugzilla.kernel.org/>
References: <bug-219166-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219166

--- Comment #10 from Richard W.M. Jones (rjones@redhat.com) ---
Just to close this one out ...

I couldn't reproduce this issue when I compiled the kernel myself, even tho=
ugh
I was using the exact same .config as Fedora uses, the same tag, building i=
t on
Fedora 40, and Fedora itself does not have any significant downstream patch=
es.=20
There were a few differences, for example I'm probably using a slightly
different version of gcc/binutils than the Fedora kernel builders.

So being unable to reproduce it in a self-compiled kernel, I cannot bisect =
it.

We have worked around the problem, so that's basically as far as I want to =
take
this bug.  Feel free to close it if you want.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

