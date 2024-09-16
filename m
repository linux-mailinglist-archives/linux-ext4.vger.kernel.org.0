Return-Path: <linux-ext4+bounces-4193-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E1297A723
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2024 20:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9896B22119
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2024 18:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1623015B149;
	Mon, 16 Sep 2024 18:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pxz0Ou/t"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94296143C63
	for <linux-ext4@vger.kernel.org>; Mon, 16 Sep 2024 18:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726510163; cv=none; b=ntrOC3c/mDTKTMWksGdWpiYBwSSEV9q8/shy0LYYRYy8bVkaRDu8LfRVpmUlwUlRtiPeWXaRoUpHcxl+0V9m8qDCiA3u1oimHBNRRH1PuMpt70xjquqgJnS9bCxLqdiQ/pLAaTIFFvYNXa2NWf8F5o7+Llnpsq//ZPflVjS65Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726510163; c=relaxed/simple;
	bh=K2rr9R4yfFcPafPVm++KizL+Z/azbTvQAA8kNWTe9UM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HKckoM+DLADrRZYDO6YZnoyBwlZW6XiM2Kf3j1/6ZaCMICVhNbYAFTi3eKMxW4js58NkOhVcBnMWxv/wS2ZlT9/Ajn6duLT84nwOXIA9dTapId/drDaF21RXzvu5dzuJHD0g7yUbwUfehaHfFsFsHUL/1SMABGfuCgFVXIvZBrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pxz0Ou/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 737FBC4CEC5
	for <linux-ext4@vger.kernel.org>; Mon, 16 Sep 2024 18:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726510163;
	bh=K2rr9R4yfFcPafPVm++KizL+Z/azbTvQAA8kNWTe9UM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Pxz0Ou/tyNcqc0w7n+jRKOUET/nAKoZfzlIT0U5Iy7DHZrEpQkhTyP+QJgiTBrD3F
	 cpkjRKwXPWjZbWZP4DUM2FOApd9IHTjyOrSv/WmegqQjllDMDBU20cAjOBWMA2DHQa
	 5xYyWguywGWmJvCR3Wy/aVa6i2lr99frQeselw5cfSZRA3VlCjwS2BrumZzi5Xa+t2
	 5iYFujR3MJ5WTrzoV6htCvKc9buwbkffsYMM3qtMqZeew/qJ4HoeDvM55hP7GQl7L9
	 +e2Y/GuQS+pwlNhW6JKwHb0PPG/wkaS+gqWz2jagAlrg9k5QiMhc+vTwoKivhIA3yG
	 1YDAsfkN3pdWQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 58A2BC53BC3; Mon, 16 Sep 2024 18:09:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219283] kernel regression with ext4 and ea_inode mount flags
 and exercising xattrs (between Linux 6.8 and 6.11)
Date: Mon, 16 Sep 2024 18:09:23 +0000
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
Message-ID: <bug-219283-13602-SwVDIh5nA4@https.bugzilla.kernel.org/>
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

--- Comment #6 from Artem S. Tashkinov (aros@gmx.com) ---
(In reply to Colin Ian King from comment #4)
> I'm doing some bisect builds, but my system is a bit slow, so may take a =
few
> days.

Use ext4 in RAM, e.g. using tmpfs.

For building the kernel you could use ccache.

To avoid reboots, have your root fs on any other FS, e.g. xfs and build ext=
4 as
a module.

Or even perform everything in a VM.

It's not a hardware module, so the whole test could be performed in a VM.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

