Return-Path: <linux-ext4+bounces-2540-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237D78C7927
	for <lists+linux-ext4@lfdr.de>; Thu, 16 May 2024 17:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE9EC282DFA
	for <lists+linux-ext4@lfdr.de>; Thu, 16 May 2024 15:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1705B14B959;
	Thu, 16 May 2024 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RscTPa5f"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903531E491
	for <linux-ext4@vger.kernel.org>; Thu, 16 May 2024 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715872782; cv=none; b=RHicVIdvqWYprCUvRdixePpkgYBdQl7OfMAIuMooX7dg5T6wOGAZ+GM+RkYPvs0WazCHM7xHtPhny82CC8ZS0fQKw2Pzupqoe0KM48s2ZsI1mbvUzLbSzD+IS3CnpHgwKo7cvmmAlGG5JHtUnX5x1Lm8ka5N8Dod2t5Cb1jX3K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715872782; c=relaxed/simple;
	bh=9KnFwU6KjIcbzRVA1x6EHDLpQiWstRIFOEkoKdl+rSY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sPWid9MX15suy0IRr2cfZoXO2E34jH5zStGwEL0aPhISluEZ77gYP0olN/bNn+j8ulfAua7wJYwP0fla/0xU0D0PJFEiE+yaPNQ/CwqIKE9I8+4RiG+q6OFrZHZ6WjaHkB1ngFmNGSykWRIgYbd17cdXoJxhDdtgLFFZ3ZQkDD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RscTPa5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14C8BC32786
	for <linux-ext4@vger.kernel.org>; Thu, 16 May 2024 15:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715872782;
	bh=9KnFwU6KjIcbzRVA1x6EHDLpQiWstRIFOEkoKdl+rSY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RscTPa5fIxXrbEC9LZ1mbkEeeT2HEy1eYK03b9f9ZKDiDWM+DZy8IrJVXuy8pGrTc
	 i+BzC7czfU7JinyGZMRsOgJau9DglvDI8fqjFHgwboHqr0YOqmLdlVQDKCqMjeBdaN
	 9L+Ae/yz+UeWtFnMZB+m8boJkFHA3sf5ZqeUm9JpGonHYIBHpUGxH5DR1AzSj6dC1m
	 esHxkXxLz1+9u/bGyNKBmTHQk2ioQ2wDt0oKhMKhbWbcdPu9kYogowkphEZzjS2EC2
	 QHTVUmWFzP3tx/i/pQviR898GgVx7TtfL0YSw+q1HJi6F5eZ4m2bLghFOXohCEg5H0
	 NNo3I6WCbSxNg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 01ABAC53B7F; Thu, 16 May 2024 15:19:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218850] Unexpected failure when write to a file with two file
 descriptor
Date: Thu, 16 May 2024 15:19:41 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: zhangchi_seg@smail.nju.edu.cn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218850-13602-Kwofmqo3xY@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218850-13602@https.bugzilla.kernel.org/>
References: <bug-218850-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218850

--- Comment #1 from Chi (zhangchi_seg@smail.nju.edu.cn) ---
So sorry, The mount function call should be `mount("/dev/loop0", "/root/mnt=
",
"ext4", 0, "");`

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

