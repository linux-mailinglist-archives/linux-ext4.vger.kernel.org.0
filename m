Return-Path: <linux-ext4+bounces-26-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 268767EEAC9
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Nov 2023 02:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85385B20AA8
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Nov 2023 01:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F121A15D5;
	Fri, 17 Nov 2023 01:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjRo1fyf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E9A1378
	for <linux-ext4@vger.kernel.org>; Fri, 17 Nov 2023 01:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01FE0C433CC
	for <linux-ext4@vger.kernel.org>; Fri, 17 Nov 2023 01:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700185257;
	bh=aTMEgNT92MCczYdSFklJG01bQ0KDCDptgC/Wwqpfgpk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DjRo1fyfETOD5P3u5fDJ+GkcSjosNsZU0hmZxD8X82UBW8xvi578CETwsm6wF+xWW
	 5C5ZtplVSW/qBsGF7+TDs4bxZzZh3CPb6QVs2hTsxYrvCR/g5uIYKHvNk/h3CGf+22
	 f/X50eXFWr3uX0wn991Fc3HlJCNjjUPwqH6KI26Gg9V99nZfvGXKUuMrYJLzsUsI+s
	 7eBXFvdh9yUXbY02ch1RY+XH1lJoIwTIKnNG3UPfPSIDQs2aACAHFxnFeUcQavXNnZ
	 NGhpPrAY+BgGLaVyZpPjjHzQA8PdR/h0y4az14YmkGBZSpK4NeBrDQc6yvsb9ixh/J
	 N5rBUx+8z0IsA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E855EC53BD5; Fri, 17 Nov 2023 01:40:56 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Fri, 17 Nov 2023 01:40:56 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217965-13602-J5OFfrmSGB@https.bugzilla.kernel.org/>
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

--- Comment #35 from Eyal Lebedinsky (bugzilla@eyal.emu.id.au) ---
$ sudo dnf debuginfo-install kernel
Installing:
 kernel-debuginfo
Installing dependencies:
 kernel-debuginfo-common-x86_64

$ sudo perf probe -a "ext4_mb_find_good_group_avg_frag_lists order"

$ sudo perf probe -a "ext4_mb_find_good_group_avg_frag_lists:18 cr
iter->bb_group"

$ sudo perf record -e probe:ext4_mb_find_good_group_avg_frag_lists -e
probe:ext4_mb_find_good_group_avg_frag_lists_L18 -e
probe:ext4_mb_good_group_L20 -e ext4:ext4_mballoc_alloc -g -p 2789843 sleep=
 20

$ sudo perf script -i perf.data > perf-probe.log
[ perf record: Woken up 1395 times to write data ]
Warning:
Processed 24640612 events and lost 22 chunks!

Check IO/CPU overload!

[ perf record: Captured and wrote 4725.791 MB perf.data (19187380 samples) ]

$ sudo perf script -i perf.data > perf-probe.log
Warning:
Processed 24640612 events and lost 22 chunks!

Check IO/CPU overload!

$ ls -l perf-probe.log
-rw-r--r-- 1 eyal eyal 39024390135 Nov 17 12:31 perf-probe.log

I am limited to upload much less that this as an attachment.
        File size limit: 5120 KB)

I managed to include only so many likes ftom the head:

$ wc -l perf-probe-head.log
51594 perf-probe-head.log

See attachement https://bugzilla.kernel.org/attachment.cgi?id=3D305414

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

