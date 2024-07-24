Return-Path: <linux-ext4+bounces-3415-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D55793AFFC
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 12:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E4C31C228A6
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 10:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7814156665;
	Wed, 24 Jul 2024 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNhKQOj2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2E35695
	for <linux-ext4@vger.kernel.org>; Wed, 24 Jul 2024 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721818297; cv=none; b=kuQ3pog2IGxGFRp34F9LmdL2A/YdNtQ1VCi9MFZpItO0dC02zSTofpgJ4afN9KbYWplcGNH7JrFTi+TPssqAvPQGBpgCLWEFQ+px59I8zesMRnNNblkQ8K/HGhQdQyWqXE7lRMG816v8hhfJ/y3ItU1HNG3r3uaSmv1OYRukTIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721818297; c=relaxed/simple;
	bh=sgVP29LlvzI54Zdv8HZTp1meieLGJX+wnttIan5mlgI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C7KqvQA/IVQnHEmm0DbMeVqQ+H1/dMD7YH+qnv1vXvf4+2syy9sjos2gOqd6WFjxNYWCR5/gUEtkkLVIYyvL6sULcvYtp2cEwF6Imhe9W5iEwt04TerSxbfunRvhFz1kJRz09cxRt78OB6ziCDcvvT3gpbkQXxO7OgxBuPCKv6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNhKQOj2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9A1BC4AF0F
	for <linux-ext4@vger.kernel.org>; Wed, 24 Jul 2024 10:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721818296;
	bh=sgVP29LlvzI54Zdv8HZTp1meieLGJX+wnttIan5mlgI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RNhKQOj2jfqnWQXVJqYQxFcyJOl9+2mA9o0WVoh/BC4TjTofhp2LhBGHFD1akTV/g
	 uh87K1psOy2HynlJYvvJHRUqV8Pd0noVs0wmhg4LZIhk5NjTcnB8MYrazGvIHGsFzT
	 QbojAlvNigmkcKhoHugVOZfOOzUKxHZrlD/mllxWmLFR3DrJ0vUN6DZYlfv+oX3t3c
	 0Tv/cdKWNzs2yhWsUsliM1IFNzcN6v1Yg79F9GZWYKR56XWn2SCr1803d1M/li/n22
	 rMHstxfp25449ABNtK6q2vV1wGNwXinclliXSlolLaQ3jLwXr78X+EK3D6XefzM5lO
	 Gt+YWjfoplZmA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D3261C53B50; Wed, 24 Jul 2024 10:51:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219072] After updating to kernel 6.10.0, one of my Western
 Digital HDD stopped working
Date: Wed, 24 Jul 2024 10:51:36 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: PATCH_ALREADY_AVAILABLE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219072-13602-06OI9bjNne@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219072-13602@https.bugzilla.kernel.org/>
References: <bug-219072-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219072

--- Comment #7 from Artem S. Tashkinov (aros@gmx.com) ---
Kernel 6.10.1 will include the fix.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

