Return-Path: <linux-ext4+bounces-32-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 537137EFF63
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Nov 2023 13:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E86280FA5
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Nov 2023 12:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1A410A0E;
	Sat, 18 Nov 2023 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNAlVyOs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3FB10976
	for <linux-ext4@vger.kernel.org>; Sat, 18 Nov 2023 12:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F601C433CA
	for <linux-ext4@vger.kernel.org>; Sat, 18 Nov 2023 12:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700309404;
	bh=0sA5BnhMh1p9FBBWBrm1hHmuBv2jHLGeJP9VM9Osrbg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JNAlVyOszEjVWtNZ/HPJv+TnS81vu7PVAZMFCsUNnLjTnUPywmyQKJ4SHZCulQs2G
	 KVagPfT21XNCibrmi7T2gEHab4/pRm0nJBl6MXQrQ9JZ0PLI0U9kbruBtfHv502rui
	 jdfXcj3xaYLyHcmq/ZoaYjhT7YsIze9uz/kubihdMQVScj+jAnr2pCPlyjKJsuIqfC
	 yKNtrRwqUgDz32agyFKC9hF9oFwI72rVyuNQY7InLTtNKgWLN1cj83ia9HafGmPTVt
	 X5CYFYGRehI1GDVykoI4wy2ePWwI+QrMxX1O0ig3w7odN+KCOe/uI9dv7trBYKEBy1
	 wS6/sC3qbF3lw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 87501C53BD0; Sat, 18 Nov 2023 12:10:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Sat, 18 Nov 2023 12:10:04 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ojaswin.mujoo@ibm.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217965-13602-YI7vwozwNJ@https.bugzilla.kernel.org/>
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

--- Comment #40 from Ojaswin Mujoo (ojaswin.mujoo@ibm.com) ---
Hey Eyal,

Thanks for the data, the perf probes you added were correct!

I see that the problem is as I suspected where we keep looking trying to fi=
nd
aligned blocks in ext4 when probably none of them exist. Aligned allocation
right now is only done when stripe mount option is passed as an optimizatio=
n.
Currently we don't seem to fallback to normal allocation if aligned allocat=
ion
doesn't work and this causes the very long, seemingly infinite looping.=20

I can try to work on a patchset that fixes this however as a temporary fix =
you
can continue with stripe mount option turned off for ext4. This will then
instruct ext4 to just use normal allocation rather than aligned.

One point to note is that -o stripe=3Dxyz is sometimes automatically added =
during
mount even when we don't pass it. You can look at Comment #6 #7 and #8 in t=
his
bug for more info. To confirm it's off you can look into
/proc/fs/ext4/<dev>/options file which has all the currently active mount
options, you shouldn't see stripe there.

Further, this is not something that was changed between 6.4 and 6.5 however
seems like the allocator changes in 6.5 made it even more difficult to come=
 out
of this loop thus prolonging the time taken to flush.=20

Also, just wanted to check if you have any non-prod setup where you'd be op=
en
to compile kernel with patches to see if we are able to fix the issue.

Lastly, thank you so much for all the probe data and logs, it's been a huge
help :)

Regard,
ojaswin

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

