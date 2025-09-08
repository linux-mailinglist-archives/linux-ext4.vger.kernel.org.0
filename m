Return-Path: <linux-ext4+bounces-9846-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09937B48EED
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Sep 2025 15:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12FD41890C89
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Sep 2025 13:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6506930ACF6;
	Mon,  8 Sep 2025 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTQV0FV4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064A62288E3
	for <linux-ext4@vger.kernel.org>; Mon,  8 Sep 2025 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757337102; cv=none; b=DnSOMOwykFYLnjA+16hlmq18B8IQtJa/NLOsMHlaaXF6ej99a59YWdLodZRorv/rqlkA9a7Vk2pkCMu8hnHs8SHwjhvSvtFfJDUFvlY2vv0Icom8QwE3LuKwjACYd81OLwoQVanUrYWw//u5FT+gn/dIfkMYy+2CQ8EcFG5ditI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757337102; c=relaxed/simple;
	bh=1ShDq26MoERe0lF3nEG6tJf9gMtVnF9MDBNPgQcynPU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W8XpiToiyrwFHZeCQndsq8Qqw0WJEmpUDIh6EZxwosBwd6XVKxqzgzoaHTrgpT7dctNy0KPuZyZSsmR7QlNBgiyVbr3Wq6F3GI6daKXE1d+nxlfg8Sa2WMytwRRR34y94CeHKSmk8nmfbS5ecNY30y2N4M3MybNj76ioOjGLUgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTQV0FV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79A1AC4CEF8
	for <linux-ext4@vger.kernel.org>; Mon,  8 Sep 2025 13:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757337101;
	bh=1ShDq26MoERe0lF3nEG6tJf9gMtVnF9MDBNPgQcynPU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gTQV0FV4Td7yhJbyfNlCAlieWrxHQ9o7Fx3xbMb2PkcodpyFhrYy9T4Lwaa0YIYw6
	 zq6ljC2Bp/XmNWhEA5Vrr+OwDVgZFdq5dAb06MVsVddih6qrr07aWTRlTVRgIzfD2Z
	 EOVmMSX80SwE1mN126FFKiaMjfNtSRxxvSMZJbrN+/FDR0CVCe6ISlQZlLtHIn7ZJX
	 rc3oWu17EEazyxFOTYBA8Hwr9UavMkEl36bXgqa02z5HbkhFVPeQdtwI1p/XXldk3p
	 K4eYDUMLWxXDOaYVHcBWCHFyToonwBpu/cIU8zqHFwXrxu7ZlWWGTHUWjGTUOCHvTj
	 XUEi1Gn5HDZRQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 653E8C53BBF; Mon,  8 Sep 2025 13:11:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220535] ext4 __jbd2_log_wait_for_space soft lockup and CPU
 stuck for 134s
Date: Mon, 08 Sep 2025 13:11:41 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: waxihus@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220535-13602-OtHT7q3hoR@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220535-13602@https.bugzilla.kernel.org/>
References: <bug-220535-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220535

--- Comment #5 from waxihus@gmail.com ---
Thank you for your suggestion.=20
Since the storage cluster requires InfiniBand RDMA network cards, the OFED
driver needs to be installed; otherwise, the cluster cannot generate suffic=
ient
load to reproduce the issue.=20
This problem needs to be reproduced on high-performance servers. We have
already requested such servers and will attempt to reproduce the issue once=
 the
machines are available (expected next week).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

