Return-Path: <linux-ext4+bounces-16-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE757EC9AA
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Nov 2023 18:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A60B1C209C8
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Nov 2023 17:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797473BB33;
	Wed, 15 Nov 2023 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mt6BAey8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D273BB43
	for <linux-ext4@vger.kernel.org>; Wed, 15 Nov 2023 17:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BB88C433CA
	for <linux-ext4@vger.kernel.org>; Wed, 15 Nov 2023 17:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700069278;
	bh=M0Cf009k+XIiCUQwneXKLoqVd6S7ZlVoXf2AODdBfAU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Mt6BAey8G0dbR3fAw6LIP3KORhJBRSXnl2e3gF9m1n81vqDpoRrTHgD5thTgTFsWF
	 OhQ8EYsJ8tVHpH+LuAxm8GPogGgQdlAqIDuF8dyc8nWlcWCechjxEBhBPYdMeUbB8p
	 NHyqLqT4a0S77aVHFMOSJ9MzskyM+NV9CuEDGzKFEd/EK17stzybhK3gfsAZIybz+/
	 HWi3sETlFtHmg96TU4Beud7z5HL1yWBVcquSu5pKQSf4ipWZCfI3tEHckuvt4s8h4j
	 ORuxx5VVb9hjD1GTSWaQOpbmCPuyau/BkRcymoPvEelpz5wxohMBHNTju4zHS2JBnU
	 smZeeTbqLmVpg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3C7C4C53BC6; Wed, 15 Nov 2023 17:27:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Wed, 15 Nov 2023 17:27:57 +0000
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
Message-ID: <bug-217965-13602-UCTHUQm1PI@https.bugzilla.kernel.org/>
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

--- Comment #25 from Ojaswin Mujoo (ojaswin.mujoo@ibm.com) ---
Hey Eyal,

Will it be possible for you to try this experiment on an ext4 FS mounted wi=
th
-o nodelalloc option. This should allocate the blocks immediately instead of
doing so during writeback.

Further, will you be able to provide the perf data file along with kallsyms=
 or
somthing similar that can be used to resolve the symbols. If not, the follo=
wing
output will also do:

perf report --no-children --stdio -i perf.data

Meanwhile I'll continue to look.

Thanks!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

