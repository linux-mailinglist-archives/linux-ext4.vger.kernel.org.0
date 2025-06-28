Return-Path: <linux-ext4+bounces-8690-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF82AEC5F2
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Jun 2025 10:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6728A6E0DDF
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Jun 2025 08:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5625222578;
	Sat, 28 Jun 2025 08:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoGfF2h/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7C415A856
	for <linux-ext4@vger.kernel.org>; Sat, 28 Jun 2025 08:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751101075; cv=none; b=dE15lo0dC4KMSsWw1Ev/I8jOkMd5x79jUhosYDlEXPKZEx0eXD/qCjThJqLqPT0RMr31z5cTJxv1Ckq5STLjxnPnduUeCt6X5LM4JOI4XtbHnRO8E39D77gBRYULCPjTHLZn93Uldp4PQJNWnLjD7H5XngsJQT/1B1WOKLKnp9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751101075; c=relaxed/simple;
	bh=pjWI7VgiGykI5Zha5u1DMj6v0WdYo48ap9bQMpk6vfs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jPGFQVyH8mRO2fWnaf56QSpcWEL0HK6pjFgrzkqQO0EtF3T09CFxywYw2iMxXS191RSV+ZJGC55N2YSX+fzlffWxnHbM3UCC7NeoAcJxZiNN14n7Cy4zdCAW6QO7ra4thXVZh5RUOj4KsDB/ae05tMzZt1+W+C5fh/zaP6WqSvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoGfF2h/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1BF8C4CEEF
	for <linux-ext4@vger.kernel.org>; Sat, 28 Jun 2025 08:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751101074;
	bh=pjWI7VgiGykI5Zha5u1DMj6v0WdYo48ap9bQMpk6vfs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KoGfF2h/KtVMWmho3Q2m9vw2ZX06LXIpLvi5apJcFWTOXVuVBeG6nelpBDMtz00av
	 RWIxO51k9DR6t2zQdxKrtRlQTb9pFW03xM2h9l2nFuhgAxznQ8zORc9b5tCv1ApQOX
	 RXQRzP7iKAgCFLsezK0MJuh3tm7a0EFlVSG/vcFWPpH265gqW6uBRu0lGj78A2WYSN
	 yqWHAwLl4Y1fWvK9OWRCXb8hNJuTfGjQ7P7nPGyoU3NKIe62Zow8IzDWNq6HRFHP97
	 Of4malSYAFV9zTccIje7Go0C8//srfEZQ6JqAWYsXG+WnXQHYLuuTR694wVrlHrJwh
	 ck6Mq621R89Pg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C4781C3279F; Sat, 28 Jun 2025 08:57:54 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220288] A typo Leads to loss of all data on disk
Date: Sat, 28 Jun 2025 08:57:54 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: martin.vahi@softf1.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220288-13602-fmDkGYFquR@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220288-13602@https.bugzilla.kernel.org/>
References: <bug-220288-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220288

--- Comment #3 from Martin Vahi (martin.vahi@softf1.com) ---
One more line of thought: are there any use cases for ext4 file system, whe=
re
the file system is not at some partition? Like, is there any use case for
giving the fsck.ext4 a device name in stead of a partition name?

Thank You for reading my comment.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

