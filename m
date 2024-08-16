Return-Path: <linux-ext4+bounces-3750-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC3395520D
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Aug 2024 22:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958B4286BB7
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Aug 2024 20:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D3C1BD034;
	Fri, 16 Aug 2024 20:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCU8tFDU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7AB44374
	for <linux-ext4@vger.kernel.org>; Fri, 16 Aug 2024 20:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723841467; cv=none; b=UuAQqWwwER6x0ynZAsUerRCLzKWVGXYzMQBRUKre+hs+EJV88uANSPXppLgryJvY5YbZT9Z2pCVWxuZnWmqqfR7iajiHr4uvlXbX4jGuR2FncGQYrYK77kQrK+ZTXTg1QjRlyAc4352/ubssWypJ9JjYCuO6w4EjK7ebsStAIbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723841467; c=relaxed/simple;
	bh=zuYNEnA7az2cdHyb+lJR6c8V3tliSbGz7Vwq0aGbX5Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QjJWwZIw2B2qLUO47KeNAU9dBze6A/HPPpUTejz6HOcuYqGyigMOfqht9A3wDoEl9FuuCIBKbtqnrHKC9vw/cjW4nZa8TYNA+HVIzk0KNY0pOuMSh2SHKPUQLidAeLXNyJHe3kZggYreY6qnonUPdYG7JyXGtjXnJ1qq4o5Bm98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCU8tFDU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 089CEC4AF0D
	for <linux-ext4@vger.kernel.org>; Fri, 16 Aug 2024 20:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723841467;
	bh=zuYNEnA7az2cdHyb+lJR6c8V3tliSbGz7Vwq0aGbX5Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sCU8tFDU6b4Kx6BBCjBLtKEu2Edten4ul+7FQPkLXEMtPDTiymCJ3V7xPv1b0+6WA
	 7hyxtW6/m36pD/it/E9HqMAn6SagXqByvL/FV5WcNws+qKa+7Mldztpykcsmzs7V0B
	 ArCSQuzq0QFnZ5QTVpxwPYaeD5be4z8U6A43uqiH+nYFDYgtZ12sZf1NJHPD32QkiC
	 htCtgMB7AcSg/4wzM7BDt1NCzFZMV1kmJNSdIsRR2WOmkzBTsD0t/rNOO3IQg7aLfj
	 xyyxzQJD59A44cyyZzXjeQ/RmZ+DILW/T+fU5tuhRrboldZYSV7ScFGLQBY6kUoQJ/
	 nkMpeM/q8vTFA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id F259EC53BA7; Fri, 16 Aug 2024 20:51:06 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219166] ext4 hang when setting echo noop >
 /sys/block/sda/queue/scheduler
Date: Fri, 16 Aug 2024 20:51:06 +0000
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
Message-ID: <bug-219166-13602-3umHlsK7F6@https.bugzilla.kernel.org/>
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

--- Comment #4 from Richard W.M. Jones (rjones@redhat.com) ---
I've got a job running now:

# while true; do echo noop > /sys/block/sda/queue/scheduler 2>/dev/null ; d=
one

and fio doing some random writes on an XFS filesystem on sda1.

Baremetal, kernel 6.11.0-0.rc3.20240814git6b0f8db921ab.32.fc42.x86_64.

I'll leave that going overnight to see what happens.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

