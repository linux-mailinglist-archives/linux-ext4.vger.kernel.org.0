Return-Path: <linux-ext4+bounces-730-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EED79825DD2
	for <lists+linux-ext4@lfdr.de>; Sat,  6 Jan 2024 03:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ABF41C20F3B
	for <lists+linux-ext4@lfdr.de>; Sat,  6 Jan 2024 02:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD0715B1;
	Sat,  6 Jan 2024 02:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9GR+xn2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1856D136F
	for <linux-ext4@vger.kernel.org>; Sat,  6 Jan 2024 02:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0674C433CC
	for <linux-ext4@vger.kernel.org>; Sat,  6 Jan 2024 02:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704507084;
	bh=Ru1IUEaRGZ9F2yULdi/eWA2iyabHfDi5jb214dltm+o=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=C9GR+xn28PN8tuMMd0QIOSi/XV5CrTTOsWmWuBsJRMwqE1WgBXZeYwA8mz1Ez753n
	 AGfwMUR5OeIfKnFHtZITVNkot6TEb5eeLrBdzKO5GndUtghvLc71dCQAMmgEiQ4V5R
	 UOu3Q1wK6cUiDRuUDTacI+KQIGKhwyDCNqr9HDHwEOORVXVbUsXNeDoG3acPb0sXgE
	 kKWR+qSkrjHYUrFr8cDpmnSEOxsA2qIHGf6h1i4zhVxywQi/q9/HZri7/rZ+6mE5Qy
	 fEYLGT8Z9luDUVOWryPolVS26L5sJjvX7Bk4CWk9r4i5N/cXNZm/WGYotzB0o2Q7fW
	 OEVICXtpPVfGA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C7C7AC53BD4; Sat,  6 Jan 2024 02:11:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Sat, 06 Jan 2024 02:11:24 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: matthew4196@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217965-13602-tfZ1grsPIF@https.bugzilla.kernel.org/>
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

--- Comment #63 from Matthew Stapleton (matthew4196@gmail.com) ---
I can't seem to trigger the problem now even with all the patches disabled =
and
/sys/fs/ext4/<dev>/mb_best_avail_max_trim_order set to the default of 3 so
unfortunately I won't be able to help with this problem for now.

According to perf record -ag sleep 5 at the moment most of the ext4 cpu usa=
ge
is in ext4_get_group_desc and ext4_get_group_info , both called from
ext4_mb_prefetch and some usage in ext4_mb_good_group called from
ext4_mb_find_good_group_avg_frag_lists .  Both ext4_mb_prefetch and
ext4_mb_find_good_group_avg_frag_lists were called from
ext4_mb_regular_allocator.  But this is all fairly low cpu usage at the mom=
ent
and it all stops shortly after the file operation is completed.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

