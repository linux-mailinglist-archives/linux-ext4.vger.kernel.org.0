Return-Path: <linux-ext4+bounces-24-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9767EEA70
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Nov 2023 01:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F751F25A6C
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Nov 2023 00:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E33655;
	Fri, 17 Nov 2023 00:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAx+vuFz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6719C384
	for <linux-ext4@vger.kernel.org>; Fri, 17 Nov 2023 00:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E13FCC433CB
	for <linux-ext4@vger.kernel.org>; Fri, 17 Nov 2023 00:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700181878;
	bh=uLrAbs3AEGOjDqKEzy7y+66sXfdsqHH+Wmj2JrC9K0I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=aAx+vuFzz/Jxo3NhDdnZLjwgLDhh77Ant9HWCa20nU8w44kGx0hPBq6Bmtjg3IjUM
	 InBDe6Wy0qKDisGofv5vnkSceBlRl+60Ski+fOpWZgVuWwHf5PrRgbObH0MmXy9ekt
	 QvM6K94rCVdOvNI+EYHe3zxyKPynPrM9eEiJK1Bkhpxy+15MhUenQvnsoTLCH5tpLm
	 2HjjB+QoKYU957dtzbZesbgjCDk4b1eJCxjFiZSd94Y0CG6UwXiRFobf8nNHpbRcAc
	 C4V97aXuc/yKm9dwnSmgURddc1snp16QHpXx/lq90/JwFwXPMFiWmB2s46WpisjL4V
	 ZDnDE+rBvi0hQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C53D2C53BD0; Fri, 17 Nov 2023 00:44:38 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Fri, 17 Nov 2023 00:44:38 +0000
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
Message-ID: <bug-217965-13602-1kgEExRHtB@https.bugzilla.kernel.org/>
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

--- Comment #33 from Ojaswin Mujoo (ojaswin.mujoo@ibm.com) ---
Hey Eyal,

Yes you are right, it is not able to find the vmlinux with debug symbols. Y=
ou
can either download the debuginfo package of the corresponding kernel which
should place the vmlinux in  the required place or even having the "vmlinux"
with debug symbols in the same directory as where you are running perf probe
shall do.

Also, once this error is resolved you *might* encounter something like " Er=
ror:
Failed to show lines." To fix it you can install the kernel source code pac=
kage
or just use the -s flag to point to the source code. (Example of how I use =
it):

sudo perf probe -s ~/workspace/9p -a "ext4_mb_find_good_group_avg_frag_lists
order"

Let me know if it still doesn't work.

Thanks!
Ojaswin

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

