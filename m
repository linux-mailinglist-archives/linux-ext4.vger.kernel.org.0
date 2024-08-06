Return-Path: <linux-ext4+bounces-3648-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37097949811
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Aug 2024 21:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E401D280ECC
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Aug 2024 19:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8DD80BFF;
	Tue,  6 Aug 2024 19:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahJfpOTV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9951A12C499
	for <linux-ext4@vger.kernel.org>; Tue,  6 Aug 2024 19:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722971650; cv=none; b=XGvuOcybamYXalykCKBgslbpWEeL9wTqFj004+2uTItNRHczc/Cb7JjdPyMcTmXW12cK0iucaajo1Xp7n+/coM+sVp4KGMVtru9OrPAofXf3v53xzlwKhV+Ov8DEgP3HBTssKc2VsWTlFn3Ka6OHV9kRevlt2FMUlPY1VuMEZBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722971650; c=relaxed/simple;
	bh=0CK2z0KOIjT76NTsmmHITqF+jk9qb8+5P9vj4AF0wFY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iowyleMs5GDJKnWCxdzP+DyD/hegMvG3Pd/6xFLGn2UkDeggMjxsFxBgTHf712uhoyVmNBakyy/P4XcuEmYwQcXdYu0AIdV/zDoyVg5zXlUNp1EwueVpzATTRPNRHqQf+dBgZCnoZTh9YtBnv0GiLTt/0TdofxeiG4p5b690f6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahJfpOTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23162C4AF0C
	for <linux-ext4@vger.kernel.org>; Tue,  6 Aug 2024 19:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722971650;
	bh=0CK2z0KOIjT76NTsmmHITqF+jk9qb8+5P9vj4AF0wFY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ahJfpOTVCXZjnjRUHMc7nHI7qTnNGP2YG83lKntrGZERqaP/hPi30wOu8tvlCCMQn
	 vOU8OUexnsNaODjvc/3ejlol8Qzud2AJXSTalSjoWqQWfDopaBhXnIp5qQ2JcCLYXj
	 LSwDUC4ix2fw/dcP81sfAuXgs9MvZHYI8zFf8cKJWyRnnXS0ua2ieJiERwbp+D695I
	 KydW9REgr3EI5WIwxu99UOnqKgY9J+BsxH+E5I7FBCfYEx5vSjGptGX0B/mBhPm+yk
	 PzHPS6XwM9wnNF22GjzI5Fdopn1/+hJLgVdoSDze+is+uGLa1K4XZfKMeHhd1CmCEr
	 dhczZthqXAPKg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 09BB6C53B7F; Tue,  6 Aug 2024 19:14:10 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219132] Redundant "re-mounted ro" message
Date: Tue, 06 Aug 2024 19:14:09 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219132-13602-oJZDP6Jc3n@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219132-13602@https.bugzilla.kernel.org/>
References: <bug-219132-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219132

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
I guess hiding this message might break someone's workflow, so let's do it
better:

EXT4-fs (nvme0n1p3): Ignoring the RO remount request, there's nothing to do.

or something like that.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

