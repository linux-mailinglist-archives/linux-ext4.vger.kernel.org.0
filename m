Return-Path: <linux-ext4+bounces-735-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3BB8262BD
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Jan 2024 03:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED73282E7C
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Jan 2024 02:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2D910A13;
	Sun,  7 Jan 2024 02:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kq1pzqKq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB2D10A0A
	for <linux-ext4@vger.kernel.org>; Sun,  7 Jan 2024 02:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DB8DC433CB
	for <linux-ext4@vger.kernel.org>; Sun,  7 Jan 2024 02:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704596205;
	bh=gVVilXsV9SfGYY1H3+UV8tSjntCSzmWLC9yfG3kw5s8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Kq1pzqKqn1ZGrcEf57xRKqiMRnAs3a/1L/3QVAxk5arymz2JxJyRuy0a0mZKOmGyO
	 BZOt5snvdQWt8gpewmLb7zLOkuUBFm039uiinJLWbCMPIu498U6M/71viPOeS6Ylnr
	 49SHL9YIpj34varNj+lecKyDebkkpIdExAIWXiDuMFbEX4oAtiF+/J8BHZSKtr9cWM
	 66VrUjM+t6G1PfbgQvUj24T6CKsRUwbOGFbNO/H8dh0QjmL/5eChwnLuQyTFcNPhIb
	 ONGMpj9nEan0vXftW0sguz5DDBHiPkMdwtXwxpA9tANH1j7TA4maROPuQ5oyIXu/xO
	 WncXNXTCz8wWQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 195B8C53BD4; Sun,  7 Jan 2024 02:56:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Sun, 07 Jan 2024 02:56:44 +0000
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
Message-ID: <bug-217965-13602-qyI8Zuxh5M@https.bugzilla.kernel.org/>
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

--- Comment #65 from Matthew Stapleton (matthew4196@gmail.com) ---
I'm not sure if this will be worth looking into, but with the cpu usage
problem, I've done some more testing and "perf report --stdio -i perf.data"=
 is
showing around 2 to 3 times as much cpu time since the commit that added the
CR_BEST_AVAIL_LEN feature: 7e170922f06bf .  With
/sys/fs/ext4/<dev>/mb_best_avail_max_trim_order set to 0 it goes a bit lowe=
r,
but is still at least 2 times cpu.  With perf record -ag sleep 25 which is =
the
time it takes the extract to run, it's goes from about 2% to 5% so fairly
small, but when measuring with 5 second intervals this can go from around 5=
% to
15%.  This cpu usage is concentrated in ext4_get_group_desc and
ext4_get_group_info and within these functions, perf is picking up more cpu
time in __rcu_read_lock and __rcu_read_unlock.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

