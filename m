Return-Path: <linux-ext4+bounces-1606-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BC0879CDE
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Mar 2024 21:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27146B21FB9
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Mar 2024 20:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6493142907;
	Tue, 12 Mar 2024 20:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qH2pqJS+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A81C1386AA
	for <linux-ext4@vger.kernel.org>; Tue, 12 Mar 2024 20:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710275264; cv=none; b=oBJBxz1dBPfgwUb4urIqLW+IRG5hDXta+AdZBQbtjkgNScyZOvmzNePZmRN9CFg/Z8adHnlyp7GXg5No1s92Z+xJMHK/XC98yxPSDGJP3GM+HrmhSud2rfOvU/Th2ChadkTLgaAK3GQaHWsn2eI9imoy2QZCpju+LffwEriLtJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710275264; c=relaxed/simple;
	bh=NLKCKGfsbH8DLhcSfVrv/WFb8KQLxCYr2pad25BFV3w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZWtqfpe6wPWoAafHBTAO3f/Pc2xSSlovUz5FuSYpi5iCqFJ9uropKerZmbLIMO+15Qcw8rIi3r5Qn1Z0R5dnFxuQtAMW+JbHviLE32SM4LDGiigvLTQlq0cvESxwpeCYaVZ2KAsO21mWp1QwybivHfFLZP3tENrZHaiYOF2qNmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qH2pqJS+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B981EC433A6
	for <linux-ext4@vger.kernel.org>; Tue, 12 Mar 2024 20:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710275263;
	bh=NLKCKGfsbH8DLhcSfVrv/WFb8KQLxCYr2pad25BFV3w=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qH2pqJS+0D/KhFfNPnCD8ZHr0xox6lD31MfaMpTFKBwaIFqEMtj/mm4YNo62yACd8
	 qvBI0gkvAq30CsESSavMjhI/ERPieDB9fOv77sdTbxvH4n+BSF3Nvw7IwtLUti/cZc
	 yb2knlzYmy5HdFxeflzwasG6qXyq8FtwdLid5ya0apSTRg1Iy9LNCsvK3lDWLtErP+
	 aOjKSvEfVQhYZElWWyV9rBBj658Yqr6vOkBR3N64wnj09X4iO7haKcOImSauCSqFU9
	 mmoWXX9z14Y2YHqV7Hnq+Fi/9YU+z+Mg3U8X+c29ufJ45D1x8elo1B6On76/VYSHR3
	 wmlKxg8nGZRzA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A7FE1C53BC6; Tue, 12 Mar 2024 20:27:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Tue, 12 Mar 2024 20:27:43 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: denk@post.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217965-13602-olhSE5cbcu@https.bugzilla.kernel.org/>
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

denk@post.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |denk@post.com

--- Comment #67 from denk@post.com ---
Hi,

I just stumbled upon this issue, which it seems is the same I am suffering =
from
on a Raspberry Pi 5. Th e OS is Arch Linux ARM and linux-rpi 6.6.20 running=
 on
a NVME SSD. After reading this issue, I checked the ext4 mount options and
found stripe=3D8191. As a first test I downgraded linux-rpi to 6.1.69 and my
issue of a CPU hogging kworker process, when pulling and creating docker
containers did not happen anymore. With kernel 6.6.20 and all earlier 6.6.x
versions, docker operations were really slow, in some cases pulling and
recreating a container took over 1000 seconds. With kernel 6.1.69 these
operations are back to normal speed.
As a next step I would like to try to set stripe=3D0. What is the right app=
roach
here, as I am a bit unsure. Is it ok to remount the running system partition
with mount -o remount,stripe=3D0 <dev> without any risks for a first test? =
And to
change permanently to stripe=3D0,id it ok and sufficient to run tune2fs -f =
-E
stride=3D0 <dev> on the mounted system partition without any risks? I would=
 be
thankful for a helping hand here to not do anything wrong or dangerous.=20

I hope, that this works around my issue for now, until a fix has been found=
 for
this. Thank you very much for looking into this!

Kind regards
denk

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

