Return-Path: <linux-ext4+bounces-665-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AD8823BCE
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 06:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6551C2490B
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 05:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24E0179BA;
	Thu,  4 Jan 2024 05:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5hSBD1T"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BA418EBE
	for <linux-ext4@vger.kernel.org>; Thu,  4 Jan 2024 05:38:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2B50C433CC
	for <linux-ext4@vger.kernel.org>; Thu,  4 Jan 2024 05:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704346716;
	bh=NUqRJIbij3iPXqplD7hcP/Z66Ir0hE4wJeBiScpw1pA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=E5hSBD1T/XEoAiSKyx8Mb/AaC7hph7t0VbCmJ5inBIkYcW3xfdoXO1SDz6H7m4yVN
	 NEqq+onVzvf/3Hr4X9WsW5VZBBxUjoKbBRiUcT+rdI3fqn2U3vDam4TARexZ/Amd5c
	 LluG0tCfoh0utth7ZuW38Ku9GF4jLvUMWXWZgNjGqsyOpEz5QzDPbjxd7fpFNd8Pmw
	 UvglnqS/3u2E0QopZLn6i24KP6AnHVDlghBCRuOMb3Wz6LBTaYFGnx/xhNIkPCknL5
	 Vh/zcHT+W2cxnscAJsByKt2Pi+3hLscGn0gaIgkOX/RKTdw0+sYLSE/j080k2yKH1B
	 Eq0WuMs2Y2iEQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id CEBD8C4332E; Thu,  4 Jan 2024 05:38:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Thu, 04 Jan 2024 05:38:36 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ojaswin.mujoo@ibm.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217965-13602-oNiK3hL8DX@https.bugzilla.kernel.org/>
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

--- Comment #61 from Ojaswin Mujoo (ojaswin.mujoo@ibm.com) ---
Hi Matthew, thanks for confirming. So as pointed out in comment 9 [1], for =
the
above steps to disable CR_BEST_AVAIL_LEN code did not fix the issue. My
suspicion is that this issue can occur either in CR_GOAL_LEN_FAST or
CR_BEST_AVAIL_LEN lookup, depending on the block groups being searched.
Probably for you, it was occurring during CR_BEST_AVAIL_LEN lookup and hence
disabling that code fixed it.=20

Further, as Carlos pointed out above, they are able to see this in all 6.*
kernels which means this is happening before CR_BEST_AVAIL_LEN was introduc=
ed
however it seems to be much easier to trigger in 6.5+ kernels. Now, assuming
the above theory is correct, then in cases where this is triggered from
CR_GOAL_LEN_FAST, it should ideally happen easily in pre 6.5 kernels as wel=
l,
but it doesn't, which makes me think that there might be some other related
changes in 6.5 that might be making it easier to trigger.

I'll try to play around a bit more with this. Also, as for higher CPU usage,
how high are we talking about? So CR_BEST_AVAIL_LEN does add some extra cyc=
les
at the cost of generally faster allocation in fragmented filesystems, howev=
er
since you have disabled it we shouldn't ideally be seeing it. Also, does the
CPU util consistently drop when you commented out that code?

[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D217965#c9

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

