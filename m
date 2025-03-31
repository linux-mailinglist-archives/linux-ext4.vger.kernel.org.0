Return-Path: <linux-ext4+bounces-7021-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9C1A76BDC
	for <lists+linux-ext4@lfdr.de>; Mon, 31 Mar 2025 18:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 994197A40D9
	for <lists+linux-ext4@lfdr.de>; Mon, 31 Mar 2025 16:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A862144DA;
	Mon, 31 Mar 2025 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGpKJXy7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1251F38FB0
	for <linux-ext4@vger.kernel.org>; Mon, 31 Mar 2025 16:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743438034; cv=none; b=UsigX/SmDvp6XS8/3ojmqmTxNz5AHGJ7vhWHRg8yT1+eSO4vd/i+G+V03AkP5EOQJk0/5wbLP20aWPdvQv5zHjFX6ic4XOHyWpuJkvZCyijfFTYTGvbcscPlvynsxkU4/sQK1LSrnubUsxmUhMhUDCIogWbevamo5gxi0q+VUII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743438034; c=relaxed/simple;
	bh=QmU9lnTbM2E0eyRPs2lhoxxFJPvmfufrONBgfymRW3k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CMSpFSU0yr+jVE7pw/ySjLs8OUIkLAfrvHYhwRWt5y1Qxue6Ri8N5ot/Hrme7H40/TKWar0vr33Nzwh95/cYA2N0+byHIZUS0Fqt1MQrHTcmot2wJkv2aiP+dhHyiAyMPdTMat0Au0Qw3NPD59fQVemMv+DzLH6iybHlNGTlVGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGpKJXy7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90EF1C4CEEB
	for <linux-ext4@vger.kernel.org>; Mon, 31 Mar 2025 16:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743438033;
	bh=QmU9lnTbM2E0eyRPs2lhoxxFJPvmfufrONBgfymRW3k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VGpKJXy7QCaJ4bINpFn3IRCQ5zfpVvf1moazs5qtjZ0j7bHOVgY1FgEgD0bjqzJmj
	 CG8e8l4XaAFyq5Bxhr3setjfgmuSGz/F+YKEpA6PaI806KjtT0EVmRpfSPRjvEsoVq
	 nuvzXA/Ch+ItIjT46SDuIA94iOx0j7eRa+RdOIEeBec0+EIphShJmOiIjLwVA22gvt
	 gKgsYi70EbqEbS8+NLmfT6gxENt+c17o/en322ZKKmcGRQr4FdzBI/EAPq5qmKBl4k
	 7Pg/B2ywl2NPsji7EUv58FPqsez3vxR8/Io/9Uk6jxLUYXCF0vICAvw1bRtXXJuDPL
	 QfvWcm2eokDSw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7AB90C53BBF; Mon, 31 Mar 2025 16:20:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 61601] rootflags=noatime causes kernel panic when booting
 without initrd.
Date: Mon, 31 Mar 2025 16:20:33 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: immmrfff@gmail.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-61601-13602-SPDfvvKvyO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-61601-13602@https.bugzilla.kernel.org/>
References: <bug-61601-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D61601

immmrfff@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |immmrfff@gmail.com

--- Comment #19 from immmrfff@gmail.com ---
Is there no workaround yet such as another paramater? It still exists in ke=
rnel
6.14.0.
I noticed that cost to remount / with noatime is larger than mount / with
module less https://github.com/anatol/booster directly .

So I made a hardcoted workaround
(https://github.com/oech3/initramfs-none/blob/main/README.md). The pseudo
initrd less boot have 0.1~0.5 sec advantage.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

