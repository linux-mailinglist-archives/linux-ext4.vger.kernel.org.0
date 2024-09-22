Return-Path: <linux-ext4+bounces-4263-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D500497E2F0
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Sep 2024 20:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AA151F2116B
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Sep 2024 18:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895C245026;
	Sun, 22 Sep 2024 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHsIM+xK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298872CCAA
	for <linux-ext4@vger.kernel.org>; Sun, 22 Sep 2024 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727031574; cv=none; b=QdqSy63wpAhyYvKDk3ouOWb/kla5CTfIFdsyoev+uNjUvFHxhxqbKdwd42p0nBOqih6h2ZSC3Mb2+VY9yoB1JDTgbkGSxACWMg/fyKUtJV9zcYdC9xoEjPcNUwSPdXjjZRHCoWMjIhymYSm8tOpgwgX+GD/6nnTwD04olHPcVuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727031574; c=relaxed/simple;
	bh=RfS0RaeXBfnaGfazWVzJW7tM7lhjv8iL/57t5GT2kx8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PfaB3phb47qTH233kBIeaHVqHSnqA1FS53IyIv/KNl1ZVHx2y2v8rxwN4w2PMBPTarlrfqvNNg4jKi3qezZGxlGuU829zG9yMCkBO9JMGQ+tSNN9+wPmEtj3dpqG66zCStmPpGimBhLXxSw+wZqBl8W9Zw5DSDIrzAmvm3+2bBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHsIM+xK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5D9FC4CECE
	for <linux-ext4@vger.kernel.org>; Sun, 22 Sep 2024 18:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727031573;
	bh=RfS0RaeXBfnaGfazWVzJW7tM7lhjv8iL/57t5GT2kx8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FHsIM+xKzDK/UTT4BwDQJM59+i5j0AxVWnzZgMjG4AQZjsV1XdrTMWrwE4pHZJhRi
	 AIRPTMwtDwVxRZzuS6tg9b9xrMSdv6kSc5xBTakGFrvuLDc9rr4AhEl2SgnNsHU07S
	 WaSVqb23VTX+XphP1VwwJJxuxq2kNDf9lONuU2kXCUqwE775VVvo7nqpkQR2KZ1jgB
	 oC2WKQo9YWnAbvkZSnlqZSLShuwayT+ilO1INhPR7Mpi7RGmfaSCEuuR0lKfiyezP6
	 rj0Bg80zgH566jEowXK54l+uh/lz/IF8FWaY5lBpM9FLY8qIKlB6Fwwrd9MEP7mhmo
	 udERnNm+1axbw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B0B9FC53BBF; Sun, 22 Sep 2024 18:59:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219300] ext4 corrupts data on a specific pendrive
Date: Sun, 22 Sep 2024 18:59:33 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219300-13602-UiH24YZ5WS@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219300-13602@https.bugzilla.kernel.org/>
References: <bug-219300-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219300

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |aros@gmx.com

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
Note that this operation will destroy all your data and in your case that w=
ould
be=20

`/dev/sdb`

Please triple check before running the command to avoid data loss.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

