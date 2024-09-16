Return-Path: <linux-ext4+bounces-4189-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8629B97A563
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2024 17:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E7E1F21292
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2024 15:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E493015749A;
	Mon, 16 Sep 2024 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAulW5sO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA381BC41
	for <linux-ext4@vger.kernel.org>; Mon, 16 Sep 2024 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726500902; cv=none; b=MxsuIXj/gFpctrEW9GRhxvv66/Do8UAySHEMXpSYbHSJ0xU2/kECpvPPSVnQllBOiaKwLDJA1lWjpO6S0sLQ328sUaeh/50SQxgSVyvQFPfLv1sgwF/bghzsHi4zndECk9xN78uAIa1AzO+ITbdCJmjm3i+3hCakh4W2RHwfReY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726500902; c=relaxed/simple;
	bh=gmhgF1P9PgTGzBSOXO2dvfZ6XZYxpQR/wgCaBfJCCRw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=be24++fxkGTRPIre5MXoeJQD95iU28ArmnRG2exYDmzOC5ybfyL5MLAbhG7UZ1c2x4MXXu2Xa6SbD5J9SVNRSTzPKfGhta49YE24x2HxTmGD+X2/epde9jLsNX3IZhbvcT4TZDSzc61zhi0wC8ddOYfkdq25drBd+f30LA6yFoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAulW5sO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04DAEC4CEC5
	for <linux-ext4@vger.kernel.org>; Mon, 16 Sep 2024 15:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726500902;
	bh=gmhgF1P9PgTGzBSOXO2dvfZ6XZYxpQR/wgCaBfJCCRw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HAulW5sOcjO48bSczfYI6iWi/Gtg9SxM9NCn+T8OYFKt1Ai9fMiBnTMq6aqHwDbYc
	 NIPCqqSYqGua1YhWhLi9FpThjpPvvqYbQYhAdWWJ0eDxIAuf827KIthtCtnhI0y4kb
	 42ur7I/EEQiJ4m0NBFJ9SZAkrqikDyy7XoO5aE+okL6i0epKR43K4uwje+K2ZsS+LK
	 qiswT6P4DJtBkS0ySkT3+REKyn4roe1hPDS8KHjRP6IJX7qX8+uCvNsb6lvhNsyBEb
	 z/t3CJSIyw0BQmL0qJ7W4Tgv2ImxCMFG27Zt9KVJbsEkHvUg+zyUOpzOGM3l5E/SCS
	 ln+H08NC43VjQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EB067C53BB8; Mon, 16 Sep 2024 15:35:01 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219283] kernel regression with ext4 and ea_inode mount flags
 and exercising xattrs (between Linux 6.8 and 6.11)
Date: Mon, 16 Sep 2024 15:35:01 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: colin.i.king@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219283-13602-lihj8whTtJ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219283-13602@https.bugzilla.kernel.org/>
References: <bug-219283-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219283

--- Comment #2 from Colin Ian King (colin.i.king@gmail.com) ---
Seems to occur on 6.10 but not 6.9, so it's a 6.10 regression.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

