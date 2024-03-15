Return-Path: <linux-ext4+bounces-1666-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1326F87D24A
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Mar 2024 18:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44F4C1C224D5
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Mar 2024 17:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A104CE1F;
	Fri, 15 Mar 2024 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5/3daHo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647E04F1EE
	for <linux-ext4@vger.kernel.org>; Fri, 15 Mar 2024 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521701; cv=none; b=qExwJBNJHlC61wAgUyAm6dspCEfNy05fYYxHJOxGTS/0DqEyBtbVIc2o33dL02baJsN79gG7g1ZCiI9QvX4Lk5iDEaVORg0hqm0TBCi0yAhO6RGWWYNQz3Ovbt4yMR4+IKhe/PXidY6qC4sVGww5yIMhLfptXEEd5X5I/7Y33Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521701; c=relaxed/simple;
	bh=KxgvY9rJVUnnM0/7+dyTroBPMhffBOB/jKsHrJwS4Uw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IybH0DhwZVBC9zOB5WxXrQbkXo0J8BEKUdZABeNxvrIEE2Dblh8E689GZVgib4SktUK8tuqN85O8BSIHq4gjBWSJYnTA66S0fgIDijX2NqNw32ht1+jYJL/kdW+qYhfzBZtTg/GKoxw9OxBAKY9VxCksZT84hsi+F1HbVr25w4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5/3daHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA5CFC43394
	for <linux-ext4@vger.kernel.org>; Fri, 15 Mar 2024 16:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710521701;
	bh=KxgvY9rJVUnnM0/7+dyTroBPMhffBOB/jKsHrJwS4Uw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=e5/3daHokmBSGJEY8sPQpvQzmP7C7ZCko0E2vDMiuzzikzQd9HzLbDHp1OyhuDb9s
	 96J4o2dXUzlpoHYMjg40Cx8h/jNNe++KQ+IAN6BpRqIOAaG6TUaxQOolDPDmrTEMPx
	 UvdyADKkUJnXEghMT4DAaR/Vh2c7xPHrcI6Amw+ijOed4/eWnKpV3u6aRF+x9B+zh8
	 sZDalTrlOC5eljKr7JXJfGLe2PDq5ZnaaAd/aJwdtFX0nq7ldmM7+2euh0CLCmz3Zx
	 Yn34ci5/+bONYBrDlar+O6UrGN3RUGAqC9G4kCXI8tR8eURvneWHDLerRrOjtWB7ds
	 f9rfWGLRBcG4w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DE454C53BD4; Fri, 15 Mar 2024 16:55:00 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218601] Regression - dd if=/dev/zero of=/zero causes
 shift-out-of-bounds &&  NULL pointer dereference, address: 0000000000000003
Date: Fri, 15 Mar 2024 16:55:00 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218601-13602-4DrKgxr5Jc@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218601-13602@https.bugzilla.kernel.org/>
References: <bug-218601-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218601

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tytso@mit.edu

--- Comment #5 from Theodore Tso (tytso@mit.edu) ---
Also note that upstream Linux kernel developers do not provide free kernel
support for Ubuntu (or any Distro) kernel.   If you want support for your
distro kernel, in the case of Ubuntu, you need to pay $$$ to Canonical.=20
Otherwise, please try to replicate the problem on the *current* upstream
kernel, and not an ancient kernel such as 5.19 or 6.5.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

