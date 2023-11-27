Return-Path: <linux-ext4+bounces-205-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B707FA7F7
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Nov 2023 18:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55C281C20B27
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Nov 2023 17:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC192381AF;
	Mon, 27 Nov 2023 17:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slYA1iM9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F56426AC3
	for <linux-ext4@vger.kernel.org>; Mon, 27 Nov 2023 17:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBBE6C433C9
	for <linux-ext4@vger.kernel.org>; Mon, 27 Nov 2023 17:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701106313;
	bh=hW34EIWMK+0wwpfotwMIgsPbe6rDRcT3q1QzrZEjxtg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=slYA1iM9+BW1ofBNO161jdhpV960LwlxHTkRukeXNI+YxEMUwGiJvU7pEJAtj2jhw
	 m8xxi5D1QGhE95e+emjN//MZgnG1DWXI8CCcxdJe5L9Cx/uduXSfqqcVDU7rvD/yGn
	 /3/orT+3jzbsq0LZJWJHCojwDrfOkQokT6+wkQ3R2zu4tCrCwI+0/jHORMg98tKOvI
	 1TxRYY3i9gI4+JYHAwv8O2j8I8Ii/Aoa9XfGNo2HDctrsCfR1j0LDO3CU2RWtRM1LW
	 2BkfNSLODSqPStF8bSd8bN+f65HdzOxUPo/d0Kk65E+EqfKw7y9Vmh2GRxXPHVn+Ck
	 7aVAMJRosCW7A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B78B7C53BD2; Mon, 27 Nov 2023 17:31:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Mon, 27 Nov 2023 17:31:53 +0000
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
Message-ID: <bug-217965-13602-iJzXFyJQDT@https.bugzilla.kernel.org/>
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

--- Comment #44 from Eduard Kohler (glandvador@yahoo.com) ---
Hi Ojaswin,

I'm still interested by a patch for this. I may find a way to give it a try.
This aligned allocation should work for most otherwise more people would be
here.
Also as the FS is automagically mounted with a stripe value (based on raid
info) it would be nice to avoid future misbehaviours like this.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

