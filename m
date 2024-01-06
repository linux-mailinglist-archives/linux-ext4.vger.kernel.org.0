Return-Path: <linux-ext4+bounces-731-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C0E825E09
	for <lists+linux-ext4@lfdr.de>; Sat,  6 Jan 2024 04:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E1C1F244C1
	for <lists+linux-ext4@lfdr.de>; Sat,  6 Jan 2024 03:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252E815BB;
	Sat,  6 Jan 2024 03:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9zaggcy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF5E15A5
	for <linux-ext4@vger.kernel.org>; Sat,  6 Jan 2024 03:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28745C433CB
	for <linux-ext4@vger.kernel.org>; Sat,  6 Jan 2024 03:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704511082;
	bh=dlisLK3gmzHc8LrqV63Y2qOnsMJ+rOFJ+7KNhtgF8fY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=I9zaggcyr9EkjG5cPds6yKrQyIWi3LVzaTk4BOIfZZ/hsTkDMZIGH3i2vcJDj+91v
	 BPxtAZzvaXNlduQtJ99rW43EmPE9P7ccxOrMBYKLaHYVlzWtS+eLj1nI+ST6dG63h+
	 gOT8Ii87dVEfufWPMi3fIFOFq3JxnbJQLVXS3pM+InQgmw6lo3hwmYPKH2gNMayo7X
	 6zF1h9cBwiq3jx/g1uwrBmg9R41lZblgTRq/xii2L2ookRgbqxWr3yfr/d20mf4Vnt
	 S4AoUy2hnuBcnDoHCOzBKg1N+058qxpLTqfEzIYJRUHlyH7vn1YV+QPc/6rDN/iKED
	 QZ8cUbvcOUFfw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 12DE0C53BD4; Sat,  6 Jan 2024 03:18:02 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Sat, 06 Jan 2024 03:18:01 +0000
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
Message-ID: <bug-217965-13602-nVpVMbmHGs@https.bugzilla.kernel.org/>
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

--- Comment #64 from Matthew Stapleton (matthew4196@gmail.com) ---
After patching ext4_mb_choose_next_group set of functions with
noinline_for_stack, perf is now including those in the report: perf report
--stdio -i perf.data .  That usage in ext4_mb_regular_allocator is only abo=
ut
1.39% (compared to 17.59 for ext4_get_group_desc and ext4_get_group_info) w=
ith
ext4_mb_choose_next_group_goal_fast using 0.74% and
ext4_mb_choose_next_group_best_avail using 0.58% which indicates
ext4_mb_choose_next_group_best_avail isn't stalling for me like it was befo=
re.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

