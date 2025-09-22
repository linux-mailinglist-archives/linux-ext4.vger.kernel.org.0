Return-Path: <linux-ext4+bounces-10346-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67896B928B1
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Sep 2025 20:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E7C3A4A56
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Sep 2025 18:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E49C3164C7;
	Mon, 22 Sep 2025 18:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnS2K31q"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BEE285CA2
	for <linux-ext4@vger.kernel.org>; Mon, 22 Sep 2025 18:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758564264; cv=none; b=T+m1urq5NjYVM0LsVgk+LHorJ6nCt2wPlbAPLaAnDG9fL9cm+ACzVasameqpM7+EDZJN8nfYmdpU8gjTptfQcoOrCpH/Uhkq75HPM9tw8S+yNplb26jsFqrL1hSjjk/wYoJIj+nsr5By8syRjgk+mIavrvGvB2ncTSC6ubfgM2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758564264; c=relaxed/simple;
	bh=luNJoyNg5/GDEN3G1MA3ST9oB+31UGgCE0zWm8wwZ4I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hFcyvZGSYxP4dVtLzQzXf+AnAgpGVZ/lty7w5sEB4fFvWb53c6nix4Yu8edA4N7+XwEvQHEgwmotiIx/wxyt0RBZ3WN9HHp+qYMp6XLtC+tEQvDFaMuFcnoqJPCgrmE8AxyCbeu+zx/t/jMZP1TVa+Y6lOxFN8CciyZzbZOyHpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnS2K31q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2642C4CEF7
	for <linux-ext4@vger.kernel.org>; Mon, 22 Sep 2025 18:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758564262;
	bh=luNJoyNg5/GDEN3G1MA3ST9oB+31UGgCE0zWm8wwZ4I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FnS2K31qBJR5B0FydkAmeCUIjbTPvNDDWnbe6hRfH/71ZQJFjuZ6fjaLm3fQuBhLi
	 kgKawSsLOJ+EUEXPdsagK61ycDNi7ZxEFcLrbR0w2ig79gsj38uRtg4AdHDted6Rvv
	 whpfSZ/3AexfEgUDlgNOHNt392n3NrCdM9D53okT2idHNQv6ZCXWQET6z72kQqtm8f
	 0qLEplU0BdkbmdXFI1+l+dF8gmI2bQ3X09teAmwQTGvOpLAM1Fg7mZ/Ga7Mt00/qSw
	 imsVnXcSXUOOlNcc8bl/IzQ/Z647Gc3KSEUdYiKMnhrWRJWZpvP1DQWCAmtUmFpv1/
	 ArCuecevW9OpQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B327AC53BBF; Mon, 22 Sep 2025 18:04:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220594] Online defragmentation has broken in 6.16
Date: Mon, 22 Sep 2025 18:04:22 +0000
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
Message-ID: <bug-220594-13602-OK4kHizRc3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220594-13602@https.bugzilla.kernel.org/>
References: <bug-220594-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220594

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
We are talking about over a hundred of files as small as 100KB despite ample
free space (yes, I do have enough space to properly allocate files) - over
16GB.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

