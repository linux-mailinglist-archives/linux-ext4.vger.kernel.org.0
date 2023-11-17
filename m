Return-Path: <linux-ext4+bounces-28-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DC87EF561
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Nov 2023 16:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303C01C2093A
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Nov 2023 15:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339A734CFD;
	Fri, 17 Nov 2023 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKFnKNXK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C5937145
	for <linux-ext4@vger.kernel.org>; Fri, 17 Nov 2023 15:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51848C433CB
	for <linux-ext4@vger.kernel.org>; Fri, 17 Nov 2023 15:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700235573;
	bh=4Xc+iLSsPk2QbbDOLX38kpgYO88hV49T2B0TCEhgpuI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cKFnKNXKDRDmQ9mJWA49VY3QCD/9Kpv2/d8iR7WGkS/mvVLZh7g+3vFOXbjpwLsD5
	 r+HAWwIgtuj0/eyTVJd3se1RVE3E3AeAssCfB/BM66x0KNLmfqgqiYsPsnCEFnHoe/
	 jfnq3GTV1ZxUCWfVfuOQeR6x+nTK4rAF9QgW9HYLbzr49LJFPmzW0RjxYO2xwch8gp
	 0wGXZk+9cN9kD+UEgUUu0/wVugneQ7qmL5g5KtVLQY7yB9qGk1rps9gHl+o9QaXkmA
	 seKYUPqRgy63WhTyPCEXcUw0eYxABCH4Jjmh7p1/uPb9HyfHA7VS6/lns0cuOJW0M8
	 urlfpUvAnGRIw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 34E59C53BD4; Fri, 17 Nov 2023 15:39:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Fri, 17 Nov 2023 15:39:32 +0000
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
Message-ID: <bug-217965-13602-fyCk8yWSBF@https.bugzilla.kernel.org/>
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

--- Comment #36 from Ojaswin Mujoo (ojaswin.mujoo@ibm.com) ---
Hey Eyal,

So the trace data has given me an idea of what's going on. Basically in ext=
4 we
maintain a list of FS blocks groups (BGs) where each list will have BGs bas=
ed
on the order of free blocks (BG with 64 free blocks goes in list order 6. 6=
40
free blocks goes in order 9 list etc). In our case, we are trying to alloca=
te
stripe size blocks at a time ie 640 blocks or roughly 2.5 KB and ext4 tries=
 to
look at the order 9 list to find a BG that is fit to satisfy our request.=20

Unfortunately there seems to be a lot of BGs in the order 9 list (> 1000) b=
ut
most of them dont have enough free blocks to satisfy the request so we keep
looping=20
and trying to call ext4_mb_good_group() on each of them to see if anyone is
good enough. Once we do find a good enough BG, due to striping we actually =
try
to look for blocks which are specially aligned to stripe size and once we d=
on't
find it we just start looping in the list again from the beginning (!!).

Although I have a good idea now, I'm not able to point my finger at the exa=
ct
change in 6.5 that might have caused this. We did change the allocator to s=
ome
extent and it might be related to this but we need to dig a bit more deeper=
 to
confirm.

Would it be possible to share the same perf record again but this time I'm
adding a few more probes and removing -g so we can fit more in 5MBlimit and
also the commands for Linux 6.4 so we can compare whats changed:

Linux 6.5+:

Probe adding commands:

sudo perf probe -a "ext4_mb_find_good_group_avg_frag_lists order"
sudo perf probe -a "ext4_mb_find_good_group_avg_frag_lists:18 cr
iter->bb_group"
sudo perf probe -a "ext4_mb_good_group:20 free fragments ac->ac_g_ex.fe_len
ac->ac_2order"
sudo perf probe -a "ext4_mb_scan_aligned:26 i max"

Record command:

perf record -e probe:ext4_mb_find_good_group_avg_frag_lists_L18 -e
probe:ext4_mb_good_group_L20 -e probe:ext4_mb_find_good_group_avg_frag_list=
s -e
probe:ext4_mb_    scan_aligned_L26 -e ext4:ext4_mballoc_alloc -p <pid> slee=
p 20


Linux 6.4.x:

Probe adding commands:

sudo perf probe -a "ext4_mb_choose_next_group_cr1:25 i iter->bb_group"
sudo perf probe -a "ext4_mb_good_group:20 free fragments ac->ac_g_ex.fe_len
ac->ac_2order"
sudo perf probe -a "ext4_mb_scan_aligned:26 i max"

Record command:

sudo perf record -e probe:ext4_mb_choose_next_group_cr1_L25 -e
probe:ext4_mb_good_group_L20 -e probe:ext4_mb_scan_aligned_L26 -e
ext4:ext4_mballoc_alloc -p <pid> sleep 20

Thanks again for all your help on this!

Regards,
ojaswin

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

