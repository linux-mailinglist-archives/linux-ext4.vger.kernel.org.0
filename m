Return-Path: <linux-ext4+bounces-18-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0267ED9E5
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Nov 2023 04:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E13C2810EB
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Nov 2023 03:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E7F63CF;
	Thu, 16 Nov 2023 03:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/bfcv0n"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F68463BD
	for <linux-ext4@vger.kernel.org>; Thu, 16 Nov 2023 03:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8EBEEC433CA
	for <linux-ext4@vger.kernel.org>; Thu, 16 Nov 2023 03:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700104533;
	bh=NXvJktUT/JIlYAtRxYA0I6R1uPL2nUVOPtfd2W+02/M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=t/bfcv0nDeQHTkF8GHdlRKiZgq7gy8OIsf/dG/XiCL9jSqYQ1TRuTmug71aHE8Efx
	 pIH2psudkm1s9InPa0szEYQXTXfSRWggK5GHDJFvYn5EFdFbIOvAB6aU7SfDXPux/L
	 eRuYPGTNyX13DxS4C/ADMs1FJ9OqPBpf5QEJpNMLKn/qT3tDuecZRecqWtrgryXyn8
	 pI0CXx+wXrawRrzrSOkSY7paMGHdf8ucUxNGSC9Y7e5WwOycXtMQJTD0ZuIPTiIUIy
	 AuJx//LYgEi1xqHRCDefYhSROF11n9h2YZznYM1NubwkPwwIHg7ZIN3NSZkjkPSsYn
	 bX5oxa2SL2+1w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 76ADBC53BC6; Thu, 16 Nov 2023 03:15:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Thu, 16 Nov 2023 03:15:33 +0000
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
Message-ID: <bug-217965-13602-acQutmnfg8@https.bugzilla.kernel.org/>
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

--- Comment #27 from Ojaswin Mujoo (ojaswin.mujoo@ibm.com) ---
Hey Eyal,

So the way most file systems handle their writes is:

1. Data is written to memory buffers aka pagecache=20

2. When writeback/flush kicks in, FS tries to group adjacent data together =
and
allocates disk blocks for it=20

3. Finally, send the data to lower levels like blocks layer -> raid -> scsi=
 etc
for the actual write.

The practice of delaying the actual allocation till writeback/flush is know=
n as
delayed allocation or delalloc in ext4 and is on by default (other FSes mig=
ht
have different names).  This is why the ext4 allocation related functions
(ext4_mb_regular_allocator etc) show up in your perf report of the flusher
thread.

With delaloc, we are sending bigger requests to the ext4 allocator since we=
 try
to group together buffers. With nodelalloc we disable this so fs block
allocation happens when we are dirtying the buffers (in step 1 above) and we
only allocate as much as that write asked for thus sending smaller requests=
 at
a time. Since with delalloc we see that your flusher seemed to be taking a =
lot
of time in ext4 allocation routines, I wanted to check if a change in
allocation pattern via nodelalloc could help us narrow down the issue.

Using:

$ sudo mount -o remount,nodelalloc /data1

should be safe and preserve your other mount options so you can give it a t=
ry.

Lastly, thanks for the perf report however I'm sorry I forgot to mention th=
at i
was actually looking for the call graph, which could be collected as follow=
s:

$ sudo perf record -p 1234 -g sleep 60

Can you please share the report of the above command.

Thanks!=20=20
Ojaswin

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

