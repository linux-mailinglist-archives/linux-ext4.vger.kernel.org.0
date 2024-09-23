Return-Path: <linux-ext4+bounces-4277-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E8D97EF35
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Sep 2024 18:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE801F222B3
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Sep 2024 16:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6229819E98E;
	Mon, 23 Sep 2024 16:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pThkrRiC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D74C8C7
	for <linux-ext4@vger.kernel.org>; Mon, 23 Sep 2024 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108700; cv=none; b=SuiY4BuCmgRWfPr341m+pIrQi7BlMaPQe2JA9sKbgFTtYOcnJqfWeeRvsdD9qrsdKi6BV4U6ieE/a56JiWurvrbuM8/Zf8I4zGGuVfmFZAxNRyKrdJyL1XtgwlRmfn+j7MGN6+DN7MCavHDHBBlv6xjwnsBXgOQrgYFi9EKHHAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108700; c=relaxed/simple;
	bh=VhXSyYBcRm9RTYtqmxyumhbNMns3F/euuHkqkV8HoCM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BShJ0ydSRxkGuBnUli5NhPmLlkJTa5+Bt+33ErlowVVfJueU+MdDrixNECVKu+LsKdiDepIl4ozwJcmU5gubzoMumpmlOKoMmJlzdxfPeZdsddD1i99Bn6qzglZkXlS87uOwmOYSjl8YWj5kFV8opXZR+ZeUqqz/35p6i9CcVIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pThkrRiC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BEF9C4CECD
	for <linux-ext4@vger.kernel.org>; Mon, 23 Sep 2024 16:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727108699;
	bh=VhXSyYBcRm9RTYtqmxyumhbNMns3F/euuHkqkV8HoCM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pThkrRiCZlww2geAc/DKCFD+UMQ/Lq6avpgPkE/K090ZrdPBw4I/4iSPo4RDWIpWg
	 vGKu3dGjjDB5I1Q5Kq0ginDXD5wqNAzLP1OHMkoWJBgF8/lQbXpuw/8VZdQuupZyig
	 JBbHoWfef9k0va1jfrJkNVeMdIF6/EEMuVA8cHiAIXuSaCHYx2hM42FSW4qRZ4VGxb
	 0RTi5is8wgSNvYGnfzDaiTRy3GUJiPkf1Yn/QZ+yxgDH1XRbkoY8o/mc+SkM9b9XJo
	 NFoHIdXD9ADwOQVOfZ3wDE5rk1Fe57P1TwBswDme9YB+oCr4cyCSBv+QgJRvTt5OZI
	 d5kcJTTNtxc1Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8CFDEC53BB8; Mon, 23 Sep 2024 16:24:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219300] ext4 corrupts data on a specific pendrive
Date: Mon, 23 Sep 2024 16:24:59 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: linuxnormaluser@proton.me
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219300-13602-Js98UzFiYD@https.bugzilla.kernel.org/>
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

--- Comment #7 from nxe9 (linuxnormaluser@proton.me) ---
Thank you for your entries. My pendrive is not a Chinese fake and I think s=
ize
is not correct. At least that's what I think. Intenso is a German company,
although the chips are probably imported from the Far East.

Back to the topic...

I don't know much about file systems, so I'm relying on you. Is it likely t=
hat
the file systems are so different that a hardware bug is visible regularly =
on
one file system but is impossible to reproduce on the other? Besides, the f=
act
is that two pendrives of the same model have the problem, and other models,
even from the same manufacturer, do not. If I could see the error on ntfs j=
ust
once, I wouldn't have a problem, but so far I haven't been able to reproduce
the error on ntfs even once. Today I tested ntfs again with f3 and as usual=
 no
error. Apart from that I generated test data and filled the disk completely=
. As
usual, all fully consistent on ntfs.

Freespace on ext4 according to f3write: Free space: 28.67 GB
Freespace on ntfs according to f3write: Free space: 29.23 GB

As you can see, I can write even more data to ntfs and it will not generate
errors.

I will summarize some points:
- i/o errors in dmesg appear very rarely. During data corruption this error
usually does not appear.
- f3 tests on ext4 are negative only sometimes.
- when copying my own files to ext4 I can generate data inconsistency very
quickly.
- badblocks doesn't show me any errors.
- ntfs always works great

Therefore, I am still interested in whether one file system can actually hi=
de
hardware defects (or is implemented in such a way that it is very difficult=
 to
reproduce) or maybe the other file system has some rare bug that will only
become visible in the case of this hardware. For me it's not settled.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

