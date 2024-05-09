Return-Path: <linux-ext4+bounces-2408-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA0D8C0D09
	for <lists+linux-ext4@lfdr.de>; Thu,  9 May 2024 11:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A90E283144
	for <lists+linux-ext4@lfdr.de>; Thu,  9 May 2024 09:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D3314A0B8;
	Thu,  9 May 2024 09:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2a0E9Fi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B662149DE5
	for <linux-ext4@vger.kernel.org>; Thu,  9 May 2024 09:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715245513; cv=none; b=fVz6pco+nHtyDWWSKHvqmQHzmth/ixBdAAnllMGCWCyacpbRYdc76Ibqbvysfm8PR4KR2bNQEcafWA3JwewTm+aiEGj1KiGf7PWc36w423GXlLT4IStni2NlQfIRxxdUeTG21PtZhTky04O3zuc/naZAPbEYhgesEysuNKJ0Am4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715245513; c=relaxed/simple;
	bh=tlBCVbB2SH2IMKieNDTDDSVaKGhzcQiP4++58czrCes=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HZ8ghSEESYPFnSJogVC5/QQ37nWank02aU0brZrFL6ReMDuoitP2YVGcxEW6btUXtAshuwlGBLCDZuLa6pLOi+Wr3cQ9L2/TbNZ0JUbomjrr2dN/uXmpl0vRJ63WOq2A8Zosvyz0KQjAguxvhV13yv8LElnlC6Pc/Wz4fIdvdXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2a0E9Fi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC039C2BBFC
	for <linux-ext4@vger.kernel.org>; Thu,  9 May 2024 09:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715245513;
	bh=tlBCVbB2SH2IMKieNDTDDSVaKGhzcQiP4++58czrCes=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=U2a0E9FiG50CF97dTrnZdFInOcfTmLJ82YvPXFhLcDWVnaCtXlBMEcQ5aLWenNZwv
	 /r5re+sXrbS4IF2wD398sELmZSZR8UBXyrPDiHAvmN4dxeFx+gDPcD1uc3t/bw9AAH
	 zXYD8mSdxkx/iDxctzQQoopqOdhoit0EUQMPxZItRdKgsNBOYmlBg6VVXIX10wWRJc
	 HITMVipVPnjkSPtxbyAHIONMVuwEdVzGB0QuviYwdjPRgGUzY6lpPwFdSG88V3Mt3H
	 Hl8y1SUbj+PbQtIao2q4Nu2dpMIDYvOBjpHG1XpN3ZUmIvJWrufZ3GGaKpcn0M2IiG
	 9FaRbSK3Rk13Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D628AC53B6C; Thu,  9 May 2024 09:05:12 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218822] Delete the file from the upper layer directly, the file
 will become "Stale"
Date: Thu, 09 May 2024 09:05:12 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Squall.Zhou@vecima.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218822-13602-Np5VUZxfFU@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218822-13602@https.bugzilla.kernel.org/>
References: <bug-218822-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218822

--- Comment #1 from Squall.Zhou@vecima.com ---
1. The issue has also been reproduced on:
29~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Thu Apr  4 14:39:20 UTC 2 x86_64 x86_=
64
x86_64 GNU/Linux=20

~:mount -t overlay -o  lowerdir=3Detc,upperdir=3Dupper,workdir=3Dwork overl=
ay etc=20
~:~/overlaytest$ touch etc/a=20
rm upper/a=20
rm etc/a=20
rm: cannot remove 'etc/a': Stale file handle=20

2. But not reproduced on WSL(Ubuntu 20.04.6)
Squall.Zhou[~/over1]:mkdir etc
mkdir upper
mkdir work
sudo mount -t overlay -o  lowerdir=3Detc,upperdir=3Dupper,workdir=3Dwork ov=
erlay etc
sudo touch etc/a
sudo rm upper/a
sudo rm etc/a
rm: cannot remove 'etc/a': No such file or directory
Squall.Zhou[~/over]:uname -a
Linux PC3203 4.4.0-22621-Microsoft #2506-Microsoft Fri Jan 01 08:00:00 PST =
2016
x86_64 x86_64 x86_64 GNU/Linux

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

