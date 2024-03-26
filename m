Return-Path: <linux-ext4+bounces-1757-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FB088C788
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Mar 2024 16:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 697921F804FA
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Mar 2024 15:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990AF13C9AA;
	Tue, 26 Mar 2024 15:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKa9uZQV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2275B757FD
	for <linux-ext4@vger.kernel.org>; Tue, 26 Mar 2024 15:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467491; cv=none; b=ly6TOuZn6ftb6wWPigTAcKqLFuSoucROBmv6GNIAV+LiYV+I7ctjGJ5RzkyKessuYXgMPCgy1NAuUKXmTxkRMrsYVLGUty4lquwDsTOlYHKFAXiMYJVW0vRrkW4gIb/qtN4cJY9J+Nv+gJV44vh8HF76GP4zicYvxccVNT79yNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467491; c=relaxed/simple;
	bh=cXdMxISYEXO4k05HPoYACGvxNr9LaL1nmXISGpF1534=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FXf6YIQxEE0Un0zIYgYvuZTNL1UALbXGfP+iODLVnPjq86Wg69sit44H5vroSCOFJMfV9hvlmEgqQ4++NO+rC6SengXcxO8qBudXwTcYz0TavyxZzM+SMcD6t2OoRMNeOGb1qIdPnkrc0xDmSxSgmKprGxx1+8evcU9M+6gyWCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKa9uZQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DE4FC43394
	for <linux-ext4@vger.kernel.org>; Tue, 26 Mar 2024 15:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711467489;
	bh=cXdMxISYEXO4k05HPoYACGvxNr9LaL1nmXISGpF1534=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tKa9uZQVKflH/Hr0XfbJrOy3r3esoZGvPEPlll0vqb0mVsCuN3BScBoiPoiWiNdUP
	 Zna/nVuXkOi4AjmS+gt0sa5+pDV4YdoiPUxAeG5YjaMv4JhNwyO4ZpTtWzJyGCtGKI
	 zdVOhH0j6bndUb6nQNZfGRMsO4TdmVKwPbKUUU8MOsEFYK9T469E/dlCwsK7CeTvmm
	 8yVol3OmOpiNK92oFXIvbZ01jriorcmI/+NUFBKOVlsmzBdrktfnlbyFpibhDOhgr8
	 z2ebFg/mu0PWHGvtfIMrWMkyKtpADH0qUIo83YmzJkKPEw1HS/CWdhAliokpeYNp4I
	 P5G1w+b1pJaIw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 85FD8C53BCD; Tue, 26 Mar 2024 15:38:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218626] fstest ext4/014 fails when using filesystem quotas
Date: Tue, 26 Mar 2024 15:38:09 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luis.henriques@linux.dev
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218626-13602-xYEOTpypHh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218626-13602@https.bugzilla.kernel.org/>
References: <bug-218626-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218626

--- Comment #1 from Luis Henriques (luis.henriques@linux.dev) ---
Created attachment 306044
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306044&action=3Dedit
Fix lost+found directory

OK, I've a patch that seems to fix the issue.

When mke2fs creates the 'lost+found' directory, it ensures that there are a=
 few
empty blocks in it.  However, this test (ext4/014) corrupts the filesystem =
and
this directory needs to be created again.

The e2fsck program, however, when recreating the lost+found directory, isn't
making sure that there are these empty blocks.  These extra blocks will be =
then
taken into account in the quota calculation, as they were in the initial
(non-corrupted) filesystem.  The patch I'm attaching basically copies the l=
oop
that adds the blocks to the empty directory.  There are a few I haven't yet
understood -- for example, the '16*1024' magic number is still a mistery.

Any thoughts?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

