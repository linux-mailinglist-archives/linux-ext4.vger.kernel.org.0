Return-Path: <linux-ext4+bounces-14-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D907EBC83
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Nov 2023 05:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378F21C20B51
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Nov 2023 04:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C17A5C;
	Wed, 15 Nov 2023 04:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFA0cpgA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32202801
	for <linux-ext4@vger.kernel.org>; Wed, 15 Nov 2023 04:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93CDFC433CA
	for <linux-ext4@vger.kernel.org>; Wed, 15 Nov 2023 04:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700021193;
	bh=O/89WHZ3feC935Pc6ezq5bVXz3KryWZQwIKDsaw7gdo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qFA0cpgAA/Hfv4NDMhktqsHtWL8Il5ZHZGL5gNr1eZblVA2Z6tnJzlGQQhipptBOC
	 QqtAGXHsk3ffnHEjDElotS1TjGpRw7m3qQUTRMZwKHRhBosc3rCxBVz4pjG6GU9v/w
	 MDjkjRO0lGsSfXXnugRTF+RBXudWx+njhvMlkyjR3lSZXHUOhk6SwFOJRBNCCSXoe6
	 B+mLHgu738B1wCKP7K+U+n/HwICP2QmSQ9wkeQ/EZXyV1V2BItsgo3hpySrioU9Oum
	 TcUXhV6Ds71UuUj3gYoqk6PW0/tYYD4fFk2jX8P/T2duIBohLDXZLsV/UYDUm1hegB
	 5A9McXsqrNRjg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7C937C53BD5; Wed, 15 Nov 2023 04:06:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Wed, 15 Nov 2023 04:06:33 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bugzilla@eyal.emu.id.au
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217965-13602-WNe0TY9Gnt@https.bugzilla.kernel.org/>
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

--- Comment #24 from Eyal Lebedinsky (bugzilla@eyal.emu.id.au) ---
In case it helps.

Did a copy of a small part of my files tree.
     368 MB total size
  19,232 files

Checked how long it takes to write out the dirty blocks:

kernel-6.4.15    0m50s
kernel-6.5.7    20m
kernel-6.5.10   same

In all cases the flusher thread was running at 100%CPU from shortly after t=
he
copy.

At the start meminfo showed about 380MB Dirty size.

About https://bugzilla.kernel.org/show_bug.cgi?id=3D217965#c23

I do not see how it is relevant to me.

I also doubt a "new kernel version" was released with such user visible cha=
nges
without due advice.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

