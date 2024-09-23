Return-Path: <linux-ext4+bounces-4266-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D0897E5F4
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Sep 2024 08:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59021F21128
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Sep 2024 06:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B73A175A1;
	Mon, 23 Sep 2024 06:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/fRZne9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A153CDDD2
	for <linux-ext4@vger.kernel.org>; Mon, 23 Sep 2024 06:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727072796; cv=none; b=uY2VLBX3ABHzvoWDUNbrndyWM+mhn1bdQmjCj6eR3R7W/48sJ+uX/8NU/rVTFtPA37iM0jnm+frquKT2iba60/8CLOekZG4ai5xt2U6TmQY8IGJljVx6ltwr4SX0qtNY/hq/AkFqInZAc+1+OMN5e+M76/NnR5rI2S5sMxxOzLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727072796; c=relaxed/simple;
	bh=wXicYqCoTU5IYyCHndgaTvqL5X1CuXUdsCIa0/UkslE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ECUm0Y5hzouHbLYP96dM5yLI5wsIPPDPtGJAfpRXmK1qB3ccCy0BrjG/PW8eDG5RPd4kFuv0iFWY3tMqcomMGNZyKWLFLefKJ/g/UOXfdCHnvSvaJo/rnn4n0+CxjZs8wySLVtY8R8qIv4hm4DRVJiPtzW1UkTwSGEBfcjXJYe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/fRZne9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 157E5C4CEC4
	for <linux-ext4@vger.kernel.org>; Mon, 23 Sep 2024 06:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727072796;
	bh=wXicYqCoTU5IYyCHndgaTvqL5X1CuXUdsCIa0/UkslE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=g/fRZne9/Mg3auq1pGPtsKSw0dBbIaS4qkRMamMHvENgTA3LE3Soe0cHrzoCJmb1O
	 DNxk2CvkTDjTNVQgl8C1aqdFwd2EpIaccoNH3fafpcvV/aZtNtoI8T0RbmynvFLnlI
	 Qpz+934Qrbuf3TDJ84Pa15P5yoq5BD0sKozTP2xQeuYzjX9O/db3Ldht34Rd48+p/n
	 7x7WDLcJ1Ds/88Se4/bu324gmxmJI5HCgIoKu/hdkziS+2FcJ/A6xziM6SYe+80s5/
	 OdMGkROnn1xH3JYrY5E8rhQX6ycYEvtsrP1EBCXNHV/QxE+PrwuPupzzfCn9bC7A+4
	 7Qeq+omQaRmSA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0A97DC53BC4; Mon, 23 Sep 2024 06:26:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219300] ext4 corrupts data on a specific pendrive
Date: Mon, 23 Sep 2024 06:26:35 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219300-13602-Tor3Eyz3zS@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219300-13602@https.bugzilla.kernel.org/>
References: <bug-219300-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219300

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tytso@mit.edu

--- Comment #5 from Theodore Tso (tytso@mit.edu) ---
Ext4 uses a block allocation algorithm which spreads the blocks used by fil=
es
across the entire storage device in order to reduce file fragmentation.   T=
here
are cheap thumb drives that claim to be, say, 16GB, but which only have 8GB=
 of
flash, and they rely on the fact that some Windows file systems (FAT and NT=
FS)
allocates blocks starting at the low-numbered block numbers, and so if ther=
e is
a fake/scammy USB thumb drive (the kind that you buy in the back alley of
Shenzhen, or at a deap discount in the checkout line of Microcenter, or a
really dodgy vendor on Amazon Marketplace at a price which is too good to be
true), it might work on Windows so long as you don't actually try to store =
that
many files on it.

In any case, the console messages are very clearly I/O errors and the LBA
sector number reported is a high-numbered address: 60278752.    Whether thi=
s is
just a failed thumbdrive, or one which is deliberately sold as a fake is
unclear, but I would suggest trying to read and write to all of the sectors=
 of
the disk.   Fundamentally, ext4 assumes that the storage device is valid; a=
nd
if it is not valid (e.g., has I/O errors when you try to read or write to
portions of the disk), that's the storage device's problem, not ext4.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

