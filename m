Return-Path: <linux-ext4+bounces-3346-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E1E938622
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Jul 2024 23:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34791280FED
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Jul 2024 21:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B51B16A920;
	Sun, 21 Jul 2024 21:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqusGegh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3640C8C7
	for <linux-ext4@vger.kernel.org>; Sun, 21 Jul 2024 21:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721595727; cv=none; b=a98J/N9PiWayNKx3ahmpAgqb2M4+AZ3q5AUVLUWVk3dLH4fkV40Zako6LoV9FSOZURTIVdWAI+mejlv1iO7jwuIRUs2CiSdkbuLg9q1NyqR5wtYq343rgbZiktuXN1mSC8rN1VqthiKQCM+CTLGcHLNZLXvKS3AFDqUCiwV7Uao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721595727; c=relaxed/simple;
	bh=TjkdXU37INgMnCQeoVh0d/Z5GUA6MP5h1fe5xEuEpM0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OTlfYtKkb5uBP7ckgrdoeFlpD2/8atbhYUTfF01+L3MzkNq+y34P6KxIl+ItFv+dxMjHTzKNlm00plvdrZ7iQz+/YByTYcBft+tFToMxOSUJyzqF3ybnlNFWEnlEx3px2cFmLZecofkCo+7JJVtbcLfXpRVkh6PUAcjcXoOdlUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqusGegh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80D3EC32782
	for <linux-ext4@vger.kernel.org>; Sun, 21 Jul 2024 21:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721595726;
	bh=TjkdXU37INgMnCQeoVh0d/Z5GUA6MP5h1fe5xEuEpM0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GqusGegh5p4o2LeP1BGeHPHX0tlGpwMUZNNWNUBvdSRQJ0We5Q4rwngMAwILzCIJx
	 0MEaZejWKQBFgjytPNKaj6dqLmhd11Y4hKoEJV3H3ngwvrDMzhK824HzvZOucKqlKG
	 O8PHuCbzW8Hy9yUXGZrhPTGkzJ2Ky4ZdGnRsW1XRc8Cl8/yjrWqeyit8oGDFtxNPq3
	 vnKjJNeUP2XYSzE69xowDvdabl39AaAmOT6FUydlAX2uVL+yQeyIgymD0nVB47ql8b
	 V+T2DUrcS1xnHj6g2WwrT8DyGoPYKfD4RIpXUgzmY656R9lwWKqYuxZX/DtgkX6Qc9
	 OkFYycfgTe1kg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 77775C53BBF; Sun, 21 Jul 2024 21:02:06 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219078] Filesystem is not responding; file manager crashes;
 detected buffer overflow; steam won't start
Date: Sun, 21 Jul 2024 21:02:06 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DUPLICATE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status cf_kernel_version resolution
 cf_regression
Message-ID: <bug-219078-13602-gs0yks1tKz@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219078-13602@https.bugzilla.kernel.org/>
References: <bug-219078-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219078

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
     Kernel Version|                            |6.10
         Resolution|---                         |DUPLICATE
         Regression|No                          |Yes

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---


*** This bug has been marked as a duplicate of bug 219072 ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

