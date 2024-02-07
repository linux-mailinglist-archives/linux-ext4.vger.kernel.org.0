Return-Path: <linux-ext4+bounces-1144-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D27C84C9DE
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 12:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F5831C25D1D
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 11:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB15E1B7F7;
	Wed,  7 Feb 2024 11:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ot3F3wCk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CD01B597
	for <linux-ext4@vger.kernel.org>; Wed,  7 Feb 2024 11:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306282; cv=none; b=j5to0OodvDa5NjmY0bSWPduCs2YLmbILtG8VW5E172/oDOUBAxXfTV/+YgzIVGuoIJEbZ7yN7p9fFQan/PNA+1Ej6Kol+MQfHPgA0uTE3blMu4CMhDNOzy+TG17AZHMg//RuK7goF8DDkwvV/rYXKemSTcDG/UgrXD2N3u0Cong=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306282; c=relaxed/simple;
	bh=MMtdcUrf7+lqsGar9fO5dL0kUZ3GV6ZtReUs8nmc/68=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B6W3785lQaCt5yjY9PYAxkzWYE7odnaf3ROEdKqFHbqDp4w15Yg8AqcAVMMPq54+pXyk8Lco2xmIgzRbiH9tLa2IJ2//2yaqNuY56urF42fxi1SGbOBVg7wE2oIHLIEbkilQ82YRNzYRHxNSk/+Nf2h08IBadqTZEJ+86g0kHFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ot3F3wCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3B25C43399
	for <linux-ext4@vger.kernel.org>; Wed,  7 Feb 2024 11:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707306282;
	bh=MMtdcUrf7+lqsGar9fO5dL0kUZ3GV6ZtReUs8nmc/68=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ot3F3wCkbNvMn/9mVSA02TC/Rk2DpVPhtLTZw2gTiJs6z71X2e8rJvn2AzTlFw2fB
	 SOHo8ACSlSToTWHOqwBfidnI9OSehqxl8yGyC/OxDT+H5CfOOhfrStX+CoVXP2Iy1t
	 FQjWb3CtCMEYI56kEul24b/fM+DoRhJ1SShBz9i/KW4aDMXiQU9NDJWosshRnjW5EF
	 vc7/e+RlAGn9ji7nkSjRBydKhtdpXLt0+nVz+xRYu5vVvNUHmEHTO7O3r1oaz1Z2AW
	 LP3nn7douOD1gogpPMnkw0CDVA2Wf1Q1BR+SGpNxXuSZgB7bDdnWddU4JpYJwnrwYF
	 +ZDMueErXlnQA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E360DC4332E; Wed,  7 Feb 2024 11:44:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Wed, 07 Feb 2024 11:44:41 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: matteo@mitalia.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217965-13602-bQrokS98YH@https.bugzilla.kernel.org/>
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

Matteo Italia (matteo@mitalia.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |matteo@mitalia.net

--- Comment #66 from Matteo Italia (matteo@mitalia.net) ---
I think I'm experiencing the same problem; relatively big (1.5T), relatively
empty (716 G used) ext4 partition on a slow-ish SATA magnetic HDD
(ST3000DM007-1WY10G), stripe=3D32747, 6.5.0-14-generic kernel from Ubuntu 2=
2.04
HWE stack; during the installation of COMSOL Multiphysics 6.2 (which
essentially untars ~16 GB of stuff) I got kworker flush process stuck at 10=
0%
of CPU for multiple hours, and IO cache filling my 32 GB of RAM. I tried the
various parameters tweaking suggested here with no particular change of pace
(although maybe the pending IO still worked according to the old values?). I
run the bfq scheduler on this disk, but I tried to switch to pretty much all
other schedulers mid-process with no perceptible change.

After ~3 hours of agonizingly slow progress (with disk write performance for
the installation often in the tens of KB/s) I decided to abort the
installation. I rebooted in the Ubuntu GA kernel (5.15.0-92-generic) without
touching any specific parameter and restarted the installation; this time it
completed in ~10 minutes.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

