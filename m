Return-Path: <linux-ext4+bounces-25-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D51EC7EEAC4
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Nov 2023 02:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04CD01C209E2
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Nov 2023 01:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1951E137E;
	Fri, 17 Nov 2023 01:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="io2PVvcp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91EA1370
	for <linux-ext4@vger.kernel.org>; Fri, 17 Nov 2023 01:39:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23C10C433CC
	for <linux-ext4@vger.kernel.org>; Fri, 17 Nov 2023 01:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700185162;
	bh=0AfJeJyZqwML831cw8bTSWf9lvj0La0kjD3ifDcIHEI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=io2PVvcpLVzXI4xwdGQ5WMayvv805GkO4mWHN34YFUsqHJISKZnec46xcUez4Mp/0
	 AvDPPaeuLNAXNVTFrgpvs1nVF2IS3BDu24hchPGxklzrATk7O6a4IOcUgSPgZ4/gCp
	 YuWCQVxuiwksld1ANXxyVyoaeQPpQslDt+PtfV//vHHyu6HCfZpe1j90OszogREH4x
	 XMxf+XBrV/O3Ch4NhiDBqFxXGbQvcglxhiIIUg8vySNQrpZyt+dA+bw4RXecPyBu20
	 rBoGZpuIP8PklskWnyDvvrtMCIYIosYGxM8WgrS6hk/YyIMmt22KCUX7Y6U3c4z+iq
	 kIKy4LWi8F9sw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 110C9C53BD4; Fri, 17 Nov 2023 01:39:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Fri, 17 Nov 2023 01:39:21 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bugzilla@eyal.emu.id.au
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-217965-13602-fco7Ox0Wt5@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217965-13602@https.bugzilla.kernel.org/>
References: <bug-217965-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217965

--- Comment #34 from Eyal Lebedinsky (bugzilla@eyal.emu.id.au) ---
Created attachment 305414
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305414&action=3Dedit
detailed perf log

Attachment for comment #34

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

