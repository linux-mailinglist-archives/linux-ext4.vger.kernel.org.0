Return-Path: <linux-ext4+bounces-22-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA427EE78A
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Nov 2023 20:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A43F281663
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Nov 2023 19:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4B54652A;
	Thu, 16 Nov 2023 19:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q07vOTBW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277DE38A
	for <linux-ext4@vger.kernel.org>; Thu, 16 Nov 2023 19:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1A8EC433CA
	for <linux-ext4@vger.kernel.org>; Thu, 16 Nov 2023 19:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700163225;
	bh=0393vviQX/0b7wotg5ClkTOgwAwceCX9N6Gigs6kTCc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=q07vOTBWRg7RIZYxkrn8xuXD/6JbUyR0u18medGARbiaPTcUpzXTSQNnYhJEp3Nq8
	 5mXlMY+5IeDA9wJSaMbfTJIco8GWj/nFmQCPZQdlrvnTdUWBN7HWOELNl/XoHryjwK
	 OAFrvqSWuEkLubaSP/FYe52zninZnYVdxo6IIM2CBycJcQIl6W3dgGDfaz1siIPq9o
	 7OOWzhuLkOj7DbUel4dp+bwMu8lh7/s5f5sMxWHqp8i5kJzSQpAQ2/tpl/3eXkJUh0
	 Goo0PriZd0A8tKL1TAGqfGf90pEraj+YbjbNsNd8qOAtHefn9wcBm2mxvxjwQyAJtI
	 3raK/NCTOY42g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DBAC8C53BD0; Thu, 16 Nov 2023 19:33:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Thu, 16 Nov 2023 19:33:44 +0000
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
Message-ID: <bug-217965-13602-Ko8xsm1koM@https.bugzilla.kernel.org/>
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

--- Comment #31 from Ojaswin Mujoo (ojaswin.mujoo@ibm.com) ---
Hey Eyal,

Thanks for running the tests. So it definitely feels that there is something
going on in the ext4 allocator side. Ideally we shouldn't be taking this mu=
ch
time in finding blocks in the FS especially since the older kernels complet=
e it
quickly so it couldn't be a low FS space issue.

I spent some good amount of time today trying to replicate it to no avail h=
ence
I'll have to request you for some more data. Thanks to the perf report you'=
ve
shared I have an idea of some kernel areas we can probe to understand whats
truly going on. I'll just share the perf probe and perf record commands bel=
ow.
Please let me know if its not possible to run these on the affected distro =
so
we can think of some other way :)=20

** Adding probe points **

sudo perf probe -a "ext4_mb_find_good_group_avg_frag_lists order"

sudo perf probe -a "ext4_mb_find_good_group_avg_frag_lists:18 cr
iter->bb_group"

sudo perf probe -a "ext4_mb_good_group:20 free fragments ac->ac_g_ex.fe_len
ac->ac_2order"

** Recording using the probe point **

sudo perf record -e probe:ext4_mb_find_good_group_avg_frag_lists -e
probe:ext4_mb_find_good_group_avg_frag_lists_L18 -e
probe:ext4_mb_good_group_L20 -e ext4:ext4_mballoc_alloc -g -p <pid> sleep 20

** Saving the output **

sudo perf script -i perf.data > perf-probe.log

I tried these commands on the mainline kernel but I hope they've not changed
too much for your kernel. You *might* need to change the line numbers of the
probe if thats the case and the event names in the record command would also
change accordingly. Please let me know if you need any more info from my en=
d to
get this done, I'd be glad to help.

Thanks again and regard,
ojaswin

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

