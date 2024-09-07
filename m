Return-Path: <linux-ext4+bounces-4085-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CB49701D4
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Sep 2024 13:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F3AE1F22CBB
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Sep 2024 11:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16708155CBD;
	Sat,  7 Sep 2024 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="illY4jnl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEAF208D7
	for <linux-ext4@vger.kernel.org>; Sat,  7 Sep 2024 11:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725707411; cv=none; b=Nb0duPAIf8Sbn7IrUYLbpbuuW2dXe048Rw8GGKC4FEBY8weDBcChaxLKWrg9PQBebfZyyDA3gF6W6iqneDtIxHd0SKAKOnIFJUY3YPU3baaJ2ArbVzHDs/beS2q8UWoJwnsdnB3m7QYFXtBUGRMzNOYzHAUoahovzCUcJOYwUTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725707411; c=relaxed/simple;
	bh=ZJXjEKXgSq/KKrrXxdJg17q+4NPxpIkMUTb5CqZtTAA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NhhRqJwPU9MLE5MHoFvZXFZe4/Fik9rP+FWiAfH4roLD4vBgps4tkIOOJZnWwpQYgEzsqrcWxwVl/Fxf/U3c4v07bT04AGyj/QNmS/QHvn2iO4qnKkz6xG1nzev0VPzd1A0uYDdDL7pSbmheVFBzK0sTvwEprD/TsoGtfNaUBmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=illY4jnl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E2A5C4CEC6
	for <linux-ext4@vger.kernel.org>; Sat,  7 Sep 2024 11:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725707411;
	bh=ZJXjEKXgSq/KKrrXxdJg17q+4NPxpIkMUTb5CqZtTAA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=illY4jnlmItqd4FMqoxbgS79D+biXm54sI1tCvIVOx5Qxce+CqbTS4boZpNGOeieK
	 5+KBU3XNEaHkPEde0krmrteXSiyB1pm0PdxDpR2RofOxNH4Cqxjqa0r1X8fkhlOBiX
	 IKMtrWEFV4zhpPLkxaisL9+J0uni/HUPkaAHtDRwZ0h37wh1ZQltxmRUeaJplof9j9
	 qNMQU45Y0VG9yzUxkw67kknmt5szjFJYde66KbE+VaKMaTWmSXtp3an7/RQjjublYX
	 yFFs5dxsnJ3qXzZUevKO6pv4Mf6uY4MdlkmRC0+5mEYqLsF2MO3ZxuWAIa1Mn1y9pK
	 bVr7S1Oan08sA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2623BC53BC4; Sat,  7 Sep 2024 11:10:11 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219166] occasional block layer hang when setting 'echo noop >
 /sys/block/sda/queue/scheduler'
Date: Sat, 07 Sep 2024 11:10:10 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: Block Layer
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rjones@redhat.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-219166-13602-NFA12d9GQT@https.bugzilla.kernel.org/>
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

Richard W.M. Jones (rjones@redhat.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.11.0

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

