Return-Path: <linux-ext4+bounces-3656-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B63E94A4C2
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Aug 2024 11:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C1B91C20C48
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Aug 2024 09:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A623A267;
	Wed,  7 Aug 2024 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esEvZqvl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEF51C9DC8
	for <linux-ext4@vger.kernel.org>; Wed,  7 Aug 2024 09:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723024397; cv=none; b=GRPCPE1LIYrEfQ0efBMQ1J41m3S/ZoK1GHSzekHt5nGc5YR+CRHVrDBfEVt0lO+fMtBG6BCaH0gAiDnI+3zcrhexfFtYylsJQLctKMXn9YnwRvFcxESO4BdoCYiGXxKIaoto0aCDQ2dYmsJsmwawg4dvfmc/jd4w41wQsPYPH6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723024397; c=relaxed/simple;
	bh=3iyPnEn3EMG/Ugv+G8eqYYI2LUmkr+A1ccGQUkgP+ZU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=umxCiYs1KZh+of5XSaaf96ZpkI/giMaJ1D+ec90Ts/TH33J7RFMubf4zbRnJriZ91r6MaV+PaWHp7LOjZ6i4lMmjoqCdP3DtXg4kfzwEuw69dnu6UcPh2gGDKsS1Ttc6EgiewtH2mIoV+YrNres1rbKQnu4/f3tRrEvW/BDTB0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esEvZqvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56B43C32782
	for <linux-ext4@vger.kernel.org>; Wed,  7 Aug 2024 09:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723024396;
	bh=3iyPnEn3EMG/Ugv+G8eqYYI2LUmkr+A1ccGQUkgP+ZU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=esEvZqvlL5ian/Pg3WPKY7AdkES1hUu90GN7TvIeA7YOgfFtFxX2lkL8bCLhjl4h5
	 q1KAaj8FzdESQQePMvGWN2Zvpj8DDKJVBuxaooihHGioJ3ldnVYNnaxlX03lXnjWqh
	 NZBZHLDEowmQHxEwHvxnQlvdUBCn8UcsK8AeRS1xnbDL43zg7q0htJa5F0Sks5d4PG
	 epX5WcjKq1dKvbOEkeprwtLgOtsdR0GNyc5swvuWiMaQu/bnYcK62YCNL1Mijw6i9Z
	 ae07hqRTh1qz2/oagaFb1gZ1n1dFfJ743UxFiYEUf32LP+qUmrHZAlzCr63CZKUlFW
	 pIcs/cAbD16JQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4AF41C53B73; Wed,  7 Aug 2024 09:53:16 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219132] Redundant "re-mounted ro" message
Date: Wed, 07 Aug 2024 09:53:16 +0000
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
Message-ID: <bug-219132-13602-oAXx8fGoLn@https.bugzilla.kernel.org/>
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

--- Comment #3 from Artem S. Tashkinov (aros@gmx.com) ---
Log messages normally convey what has actually been done.

The current messaging implies the kernel has indeed remounted something whi=
ch
is not the case. That's my concern.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

