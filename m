Return-Path: <linux-ext4+bounces-2785-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C9E8FD76F
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Jun 2024 22:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A9931C22016
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Jun 2024 20:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0A115ECC6;
	Wed,  5 Jun 2024 20:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrXTE/7C"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A909E152793
	for <linux-ext4@vger.kernel.org>; Wed,  5 Jun 2024 20:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717618906; cv=none; b=q17inzEtbKwLfaMDnlZzs6YuUenO6cS3i1L8w+KDVA5ymV0HtWAl0SqXzEy3NYv6875AmdihX23rmjf+Z0TpwgDbE9xLtqOxDLn/14JNTzIvriC77UQcVz5KWb1VuGBePPr3TGvPsDjszacZ8J8J0ST6QQM2zfOttOphEt41Esk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717618906; c=relaxed/simple;
	bh=j18B02j2nrfooDulfK4tDJrkyGL4x1Z8MVqu3gmqNYA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LAhYW6nfs6FeBbZdEumOugPXwm9zXXtdcsHeliD5B5H477+UdX6tcCON6A085Qf9phsFvBhgaXEDHbJYBQrwpjkxuXh3kKqGnVOek6nex8CnIRF/Aqrm2Z3zgwmPEn0whjPAq59z3u39omrsYePIq8zhuT55DpiZISaFEWQSFw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrXTE/7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79D94C32782
	for <linux-ext4@vger.kernel.org>; Wed,  5 Jun 2024 20:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717618906;
	bh=j18B02j2nrfooDulfK4tDJrkyGL4x1Z8MVqu3gmqNYA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nrXTE/7C/6LRbHaNu/+RmpFjLoHXDSBv+x0/vZhu8M4GP+AyrCtayqegk5Ap1lay0
	 zEE5r4RmlVoZbxrIm6i6X1TbxkTVHhXtqBbde1MBMXNVX02WgsSBRvqlo9uPPTl8PT
	 ZFB/qGHGz6glFaJPcnilxBy+5pgT6ojsf8S6ZlyZpiL6Q/pmAxMlfb/HwTlQcSqNI5
	 oFV4oX0GoLNz4tEZFPjdCXNCH94hXHQL7XcW91DhfnvTFa3/nsGyXJ2Ci4UQp84r7l
	 DBnxofVTiAzC5YPcCQKK/Cdc5SWfOUp1ahmkfmM2CuspNyBaG4F7MuHE63gGoZO5q9
	 e+64rLNQp1iFg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 70932C53BB0; Wed,  5 Jun 2024 20:21:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218932] Serious problem with ext4 with all kernels,
 auto-commits do not settle to block device
Date: Wed, 05 Jun 2024 20:21:46 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sirius@mailhaven.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218932-13602-GcyoiN1VwF@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218932-13602@https.bugzilla.kernel.org/>
References: <bug-218932-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218932

--- Comment #4 from Serious (sirius@mailhaven.com) ---
Oh you are right, /proc/sys/vm/dirty_writeback_centisecs, 3000.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

