Return-Path: <linux-ext4+bounces-559-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE4E81D48D
	for <lists+linux-ext4@lfdr.de>; Sat, 23 Dec 2023 15:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6837A283250
	for <lists+linux-ext4@lfdr.de>; Sat, 23 Dec 2023 14:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C9E10961;
	Sat, 23 Dec 2023 14:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDjrmQYs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE9410940
	for <linux-ext4@vger.kernel.org>; Sat, 23 Dec 2023 14:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 505F4C433CC
	for <linux-ext4@vger.kernel.org>; Sat, 23 Dec 2023 14:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703341337;
	bh=KPymVG2NK6C4lDS2IurlYFpxqczXXIBSdjcDyGqeROg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qDjrmQYseT2IlrOK8CKVwk22TVjHFAjJarn4IoXGqa5ZR0CpF5iKwC1yA+OGEuUuC
	 XwwLAAx+I47eNF6sMV841FYVPTDJBbYbuBzqPXClwub1os+UdXFAVw5s6+E1WMoiGd
	 3QOcGNZFijhyxATLIkJ0q2wTVKUh/qIW0HJMmLSpAWrhNPI2RBPxpzopoeTR69kYSf
	 IRHJZ2eFRpjYQoLdNZDF9/j+9CiTG+5YYcpsON8lxXsyCt/2aloozI4bR+bkl9WoAQ
	 EGYA28Vzza8mwU+Okn/uFjXiOuQTjQ562ivNmwjM64N3k5LCYU04SkqLK7lgsysC7D
	 ZccMVWlWb2V1A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3AFF9C53BCD; Sat, 23 Dec 2023 14:22:17 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Sat, 23 Dec 2023 14:22:16 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: glandvador@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217965-13602-UaJSV65JhI@https.bugzilla.kernel.org/>
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

--- Comment #50 from Eduard Kohler (glandvador@yahoo.com) ---
After Andreas comment, I throw a look to the raid wiki and changed the
stripe/stride values:

tune2fs -E stride=3D32,stripe-width=3D32 /dev/md0p1

which may or may not be optimal for a RAID1.

Running a 6.5.12 kernel (fedora released one, not the previous compiled one=
).
And it also makes the issue go away.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

