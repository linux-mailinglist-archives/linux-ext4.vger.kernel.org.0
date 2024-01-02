Return-Path: <linux-ext4+bounces-589-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCDD8217B9
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jan 2024 07:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A98228247F
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jan 2024 06:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B925E46AC;
	Tue,  2 Jan 2024 06:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qt/Pepe4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406354693
	for <linux-ext4@vger.kernel.org>; Tue,  2 Jan 2024 06:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACE7EC433CB
	for <linux-ext4@vger.kernel.org>; Tue,  2 Jan 2024 06:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704177856;
	bh=7cNAKEgyg97VhABmIpBXY+j5LDkh6hjLN1qDh/+G+hs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qt/Pepe40kv21ImMcmu4Wt0eQIPbsZuCMlpAwmoAL79KcUIWtQzrDDpp3wfAY5wCF
	 g3ZjOtyY/urQO1r6H4GhdOHZ7QxmzUMwgPSy+JckKjNEsew+7qIrtnRa0cfLxBnyXc
	 Qhn3qHL3AFSt6ZQACMyAkW3uMmaxUJbSz4+bvXsOJehhqc3hl/7VuASIrWOLbQHKk4
	 73psokztdlL2FJCCZswz6lMt05gg5YWanlMewRgkQFciPZxA2+7wypO1FKEmQTgmdV
	 Fl32lf2x/GKFT7HpgS2qTQHLxBiDzlsL1jGxC4aruxT8k04XHEFAQM4Xp128M7Jiwa
	 C5w+FP/fUIZhg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 90F69C53BD1; Tue,  2 Jan 2024 06:44:16 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Tue, 02 Jan 2024 06:44:15 +0000
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
Message-ID: <bug-217965-13602-P0NBRpOBHJ@https.bugzilla.kernel.org/>
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

--- Comment #60 from Matthew Stapleton (matthew4196@gmail.com) ---
It looks like echo "0" > /sys/fs/ext4/<dev>/mb_best_avail_max_trim_order st=
ops
flush from getting stuck, but the flush kworker still uses more cpu during =
the
write operation.  Hopefully I can get the perf results over the next few da=
ys.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

