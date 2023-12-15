Return-Path: <linux-ext4+bounces-457-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9690A8146DC
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Dec 2023 12:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DF671F2158F
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Dec 2023 11:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC1E24B37;
	Fri, 15 Dec 2023 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUc0xOD6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F38925546
	for <linux-ext4@vger.kernel.org>; Fri, 15 Dec 2023 11:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE01AC433CB
	for <linux-ext4@vger.kernel.org>; Fri, 15 Dec 2023 11:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702639649;
	bh=0J2OzrDRi4hprSrZiRHgl0Wkr2v0pMLRh+/huoJh8yg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HUc0xOD6iYT8MinR9pM+QXNUzLhRfNLbKfqOX28Z5whDMjC+GiNmYEa11zFqZW4T1
	 lDI+ZK4r20MC6Q+qyJrQky3aHYcTCFRreV7U8WzC5V8QRoEq3reDM7G78KSU0T/zZU
	 mDEzXnmZxfkyOR9xCMe+UMXsQ6QUTkxZE5AiD0Kb6LuWhJFFPGllUUbL809378cb18
	 LqAO+F3gd0EecvSqnuqBI5qDh6OkwrgJp4VF+2dA7Psh/30x12yJNFjHmY8qJOvQhi
	 fexzhQ+blJ1sQ55EXxp/D/pwRFiWfjV18shyfQFs0wRUWPGDs+u+UFgZksk8yhP7LV
	 O3WfkOQWx5wVA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id ABA5DC53BD2; Fri, 15 Dec 2023 11:27:29 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Fri, 15 Dec 2023 11:27:29 +0000
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
Message-ID: <bug-217965-13602-Cxlobtlolc@https.bugzilla.kernel.org/>
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

--- Comment #46 from Ojaswin Mujoo (ojaswin.mujoo@ibm.com) ---
Hello,

I've posted a patch that, as per my understanding of the issue, should be a=
ble
to fix the halt in kernels above 6.5

As I was not able to completely replicate the issue, I relied on the probes=
 and
other logs collected to root cause this, so I'd really appreciate if the fo=
lks
here can help test this on their setups where the issue was being observed.

Link to patch:
https://lore.kernel.org/linux-ext4/cover.1702455010.git.ojaswin@linux.ibm.c=
om/T/#t

Regards,
ojaswin

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

