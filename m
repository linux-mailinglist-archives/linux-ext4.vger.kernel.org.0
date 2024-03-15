Return-Path: <linux-ext4+bounces-1658-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C898C87CB21
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Mar 2024 11:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A6DD1F2109A
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Mar 2024 10:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF351805E;
	Fri, 15 Mar 2024 10:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gujpGdfa"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E7E18AEA
	for <linux-ext4@vger.kernel.org>; Fri, 15 Mar 2024 10:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710497230; cv=none; b=KmOyYtbHntSdY+Isn1dUIl0cD2U6+YORBe778bt+e3/DYo8Eys/45hD4pVj6AggZlqBraMW04MkT617QDhuJr8n124tI39a0x6dIKbfB09CR4IzwhXZo0Fy2zs+gZ94rLxc3YLsYn7uNm01OreroGzT47pFWZkE+xyeF+xUQWAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710497230; c=relaxed/simple;
	bh=HJ8Kbd0Cx1arE03Ize/6wbfh8OjZIz1KaMSZ/r2hQMw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JkGKBHqSHQuXjmRI1hFoQmOiUbsKy52u+I9dum+ccPEZtHQqcaBxxJxgp1AhJXM1vxTeScxhh9GCQyoZD3V1Yv/eqIzFsgJNbCMg07fLfAIAbVo9LgWJB+aJIC16BlzRWf4zIZP7X2eYK6m5iyw6/tucbTzdfU3ju0Dpgnp99FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gujpGdfa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3544C43399
	for <linux-ext4@vger.kernel.org>; Fri, 15 Mar 2024 10:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710497229;
	bh=HJ8Kbd0Cx1arE03Ize/6wbfh8OjZIz1KaMSZ/r2hQMw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gujpGdfao/syV+bdV6W1bE6c2P1JmCAEC6mb6GcvUGlk0dU1J2jsxRrgj3DPfE9/y
	 vMZzn3/n27hsglKZ0rfZB2+2vxyhFtt3r0Vnqi4CHqZl30tMHR++2tVUNGRaCtSqvZ
	 IimRu0PLIVyucmuv7NsGybOcGIjO6YxiTQJhkCyfwsSGraH98VZV8nTOceXDpvbh53
	 hgr4y1w958S0Kql5busojFMsaPpYKSzoNPz0/cwKa58JI8AqsmLOIrvBA7AMJOr8wd
	 KcPX2rApSGCcpa8eclUFUM65cKTfYEkzd7ny7zfqFVUAvmbzGhrNYPohY6wJJGD+15
	 OSFsjvyCJNnnQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 97B8CC53BD4; Fri, 15 Mar 2024 10:07:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218601] Regression - dd if=/dev/zero of=/zero causes
 shift-out-of-bounds &&  NULL pointer dereference, address: 0000000000000003
Date: Fri, 15 Mar 2024 10:07:09 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218601-13602-wZIagHw17u@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218601-13602@https.bugzilla.kernel.org/>
References: <bug-218601-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218601

--- Comment #3 from Artem S. Tashkinov (aros@gmx.com) ---
Did you actually bisect?

The commit you've provided doesn't look like it might have caused the issue:

https://github.com/torvalds/linux/commit/326e1c208f3f24d14b93f910b8ae32c949=
23d22c

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

