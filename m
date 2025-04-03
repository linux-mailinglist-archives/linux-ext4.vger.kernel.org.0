Return-Path: <linux-ext4+bounces-7047-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 011E8A7A0C9
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Apr 2025 12:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A670176250
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Apr 2025 10:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E15D248883;
	Thu,  3 Apr 2025 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXNxBEWk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011EB248862
	for <linux-ext4@vger.kernel.org>; Thu,  3 Apr 2025 10:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743675300; cv=none; b=UXykzlRZpVtHDGnwzCcRkbWT+WvFGdHRu3CfMdyn31O76KGBa20rUHxo0sOP+BQWqtb0deUZsttZKAyJftjzzMEM0K7ByTidCVbQTZMiHcpfVzc8wbdzcrLL1neIT4GQTbSXiGWqFRXnG80SYeT8GAlGymJewrJLDFm3kp4fCqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743675300; c=relaxed/simple;
	bh=oBSqGAtz2fqWplZYEEIrZscKRNWPUZ2kWZ762Z3mJNQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ky0zzcqoVXb3GVGDKx2UmsNNKyFZ+MAX0qFaZXeLrYzD4TAbwcaBL7H0se7/Zj70lyTqVxoTKxca2B153s376PPAzWpghaW3YvYLRIgEDsX59zCAnD+zi4Z+Sor8oY/bftw1LshedqWCyaFpJB7AY8hDvu0yJD7prUlWin0QyMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXNxBEWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F618C4CEEA
	for <linux-ext4@vger.kernel.org>; Thu,  3 Apr 2025 10:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743675299;
	bh=oBSqGAtz2fqWplZYEEIrZscKRNWPUZ2kWZ762Z3mJNQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=aXNxBEWkBDHbTSowa+iO03RTtRdRy7RAMFkuiR595cZoJjvJzPC+gd2AdWL/8VoKT
	 c1SEkIzPmR6wDbEtbJTIXAhE6njWzDNSmjS3lX9DJGoIlanuOAlOvFipKcBRmJWCuG
	 8yS7MnXBfElpiid/TQpHP1czkBWhyUl+tDjPrk6ii5IR8cn0oRcL0mSuRm+pWoWGvz
	 Cmdo/xDXxfPUpxFADQBRaxLyO7wzByJoHa0mG8g+D89uTV/3Ff1eNt80fHyYMUH4B0
	 44T5EKAWzG3oAXMPCyJ2t+6IZ1zd0zWK8C/UbZKJvX9HgOj0DuxnOgXNno2gFMeIoI
	 vVyOrWlUDTvoQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 60B2DC53BBF; Thu,  3 Apr 2025 10:14:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 61601] rootflags=noatime causes kernel panic when booting
 without initrd.
Date: Thu, 03 Apr 2025 10:14:59 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: shosioness123q@hotmail.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-61601-13602-p0mwwyQLkB@https.bugzilla.kernel.org/>
In-Reply-To: <bug-61601-13602@https.bugzilla.kernel.org/>
References: <bug-61601-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D61601

Disce1971 (shosioness123q@hotmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |shosioness123q@hotmail.com

--- Comment #20 from Disce1971 (shosioness123q@hotmail.com) ---
I encounter a similar bug. Thanks for useful sharing
(https://blockblastadventure.com) linux-4.0.5
fstype=3Dbtrfs

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

