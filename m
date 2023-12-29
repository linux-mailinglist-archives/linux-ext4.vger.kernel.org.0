Return-Path: <linux-ext4+bounces-578-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B755C820170
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Dec 2023 21:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BAF5B221C1
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Dec 2023 20:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A8E1426F;
	Fri, 29 Dec 2023 20:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMY+iM53"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B08914267
	for <linux-ext4@vger.kernel.org>; Fri, 29 Dec 2023 20:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02FA1C433CB
	for <linux-ext4@vger.kernel.org>; Fri, 29 Dec 2023 20:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703883102;
	bh=541bFhBVyyj3RuoFf8kzKqu+Ey7phsi0FWUzdfSce8g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RMY+iM53Svfrulun2srKbUUlF4j7UdZ2Qc/feze1z6IrYBZAFell8REfVY/edN0VS
	 YJBxWaNBbyB0ZYkCMKSdhcKqpUuNDJoh6xFPfc4bm+2ROtmNJ/6VR3qvPt4P6AZMn1
	 5pz3fz+XH7mb1D90RJBVaHVroTH9y4zUeEOqnWNOp465vN6u1jxmcCAuw09/FBAk1f
	 fnKUvcVnfDfblrH5cXbzKNq690kYfHpWJgA7bkjBOXLOyWQhn8chBd6Uc+GaZAXlvn
	 PzA/o1o4SEFUY5Ncmr51ezO+gg42Fej+lM4jOr5NWhMul23hxkkHfp+LWdJDrsnhos
	 T1qndTqLVdLTQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DF606C53BD4; Fri, 29 Dec 2023 20:51:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Fri, 29 Dec 2023 20:51:41 +0000
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
Message-ID: <bug-217965-13602-f8woBV6IIc@https.bugzilla.kernel.org/>
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

--- Comment #53 from Matthew Stapleton (matthew4196@gmail.com) ---
Oh I just rechecked and I do have RAID stride set to 32733 on my filesystem
which I think I did to optimise for SSD blocks.  Also, another test which m=
akes
the flush take a really long time to complete on my system is "cp -ai
linux-6.6.8 linux-6.6.8_orig".

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

