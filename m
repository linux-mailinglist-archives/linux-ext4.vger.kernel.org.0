Return-Path: <linux-ext4+bounces-1659-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D54487CB40
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Mar 2024 11:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDA0CB21BA4
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Mar 2024 10:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B5618622;
	Fri, 15 Mar 2024 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhjQ3V8u"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50B1182AE
	for <linux-ext4@vger.kernel.org>; Fri, 15 Mar 2024 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710497933; cv=none; b=aGOITnsJm6c/W6ySASNAAtVcyV3d2Bxek2fXr8qPKmNNAq6IdcdN8OPVecxSvnup7cV4AL39LoILOyAWc4dYGB+yl5iekTY/rRXxTgZaGZtNacmIC1EzPkURCBLzVkBZcReiTnwrOAXaUT//6W3I4SrPPm8zTIC0hx2JM+/Y2xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710497933; c=relaxed/simple;
	bh=7NVV6VY6Ss/dWGfp6psNb8N9dk3n8oeEpbd3nP9Py3I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YdRybh2KNUfkaflJFSzjloSANOICcsJHuUUbhWGRiwX1UPzoBUARdEnS+qywPFyrJhRqxgJ95bnMhkm8kMF/Awnd9Fof0IMOX3NjwXzM/GwE2CWE9K6BQAavHyU+5MW8Pm7d7XlOcIL2NBeB+iXeb7ypPcNdFtncsMyFHn0VoLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhjQ3V8u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 443E2C43399
	for <linux-ext4@vger.kernel.org>; Fri, 15 Mar 2024 10:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710497933;
	bh=7NVV6VY6Ss/dWGfp6psNb8N9dk3n8oeEpbd3nP9Py3I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZhjQ3V8u9YjSuyJ2F9PC30lQHJqWhhEiXvsxXSqXjcnZCD/PmjXf9Q9QKGtiU4Ezk
	 8sK0YyKCKwuaMGwbloGa4dtEc5f8YREatzYCoSG8eg2rKcx5SVie/x0E4wFCZ1J67n
	 +o/KZSdexE5BvU869g+6gBmYGiPKSz4nuoeAhAcnygiXqiU2bqaN+J37nDx5mfO/fK
	 /Dz5TYXa8STqDpSzLomAuFsn0VaktZYcD05V87jeKiit3oM9do5xaKw58+0NI6UH38
	 18nPAqpHFkFTD9Z+St0x56BGKidA32Qj/WQFYInRbQAgTm7/lxgDbDFLpaXoNBChXX
	 JBpv6WOlalJhQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3A1FFC53BD4; Fri, 15 Mar 2024 10:18:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218601] Regression - dd if=/dev/zero of=/zero causes
 shift-out-of-bounds &&  NULL pointer dereference, address: 0000000000000003
Date: Fri, 15 Mar 2024 10:18:52 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_bisect_commit
Message-ID: <bug-218601-13602-4CRFIjESSu@https.bugzilla.kernel.org/>
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

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Bisected commit-id|326e1c208f3f24d14b93f910b8a |
                   |e32c94923d22c               |

--- Comment #4 from Artem S. Tashkinov (aros@gmx.com) ---
I'm not an expert bug your backtrace looks weird. Please run memtest86 or
memtest86+ for an hour or two.

https://www.memtest86.com/download.htm

https://github.com/memtest86plus/memtest86plus/releases


I'm also removing the bisected ID because it doesn't look like it has anyth=
ing
to do with this issue.

You don't just copy random stuff from other bug reports which look similar =
to
yours. You actually bisect and provide the full bisect history.

Ubuntu 22.10 comes with kernel Kernel 5.19.

Ubuntu 23.10 comes with kernel Kernel 6.5.

That's a very large regression window. And then you can only bisect on vani=
lla
kernels, not Ubuntu ones. First compile and make sure 5.19 absolutely works=
 for
you. Then try consecutive kernels one by one. If you hit the issue, then you
will have just two kernel releases to work with, instead of trying to find =
the
regressions between two very distant kernels.

https://docs.kernel.org/admin-guide/bug-bisect.html

Best of luck.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

