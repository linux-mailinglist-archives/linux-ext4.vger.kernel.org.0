Return-Path: <linux-ext4+bounces-4290-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F44F984965
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Sep 2024 18:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042541F25252
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Sep 2024 16:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158031ABEC4;
	Tue, 24 Sep 2024 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yc++Gxzn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE70C1ABEA7
	for <linux-ext4@vger.kernel.org>; Tue, 24 Sep 2024 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727194510; cv=none; b=NxoVW5+GRZnyWwgbRGKJ6KmTo5N+ji9R9OzqUIy7ZrrkCNTKLN+X5bHEHaWvLlbYpM5vsqO4Lwa3a+irrHXuuSnDMSH4NmwAvS4O6xrYpV4gpc1kOuJleMBapwS2Yxd9u+yJ3oi1J6AVK308BRMTzu8RSraFfmfNOIG8qUzfU1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727194510; c=relaxed/simple;
	bh=Lropeo9HyL+uYVkQh2dUgDZ9eTbhv9Y9slgfV7PWwc0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fpZQ3lWHnPdDVX79hqITlUEG1GM8sqIp4m9NOCFYtj622l1EppYfCdl8RQo35dkHkMRnoo3lKE57zwbNr04ALWTDom4kNPzE02olNO5zazucHmAG38BZWkiVzw563Dxb/VxvT1W50te515ntj+Qc20CrVt5+iisc/daMXv37ukQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yc++Gxzn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5233AC4CEC4
	for <linux-ext4@vger.kernel.org>; Tue, 24 Sep 2024 16:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727194510;
	bh=Lropeo9HyL+uYVkQh2dUgDZ9eTbhv9Y9slgfV7PWwc0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Yc++Gxzna8C0Kbg/fdJD/FYEZn9VSdiDI4xtQl/pteZ9J5i0rdKiqmXafkFc1WxbL
	 gCn8ag37nTIy/IqtQSISKcoSYuaV9MXb0j9JOICI1xa2q/BYZTFh2gFv9+RSBNu2ev
	 133vXg7OoSJW7JBt0E/HF3qzh99qTFx5uF0DNwsALY3ckEqaQpPaMqEewZX/KNC9Lj
	 MNoGUSLYrPs+jzdtkqYijBJ6baHzNNecbyEpeax09D87omkwXcHKGHCZAtcnEmFznO
	 CIOqezjRxOhnWgWqJspJdFH8t4IdOU7JxyjVNSNf6tAtWXOK9phpRe9JbaM+ZbLeWy
	 6ui+zrd/msEOQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4A410C53BC3; Tue, 24 Sep 2024 16:15:10 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219300] ext4 corrupts data on a specific pendrive
Date: Tue, 24 Sep 2024 16:15:10 +0000
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
Message-ID: <bug-219300-13602-YGMBAnF0Uu@https.bugzilla.kernel.org/>
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

--- Comment #10 from nxe9 (linuxnormaluser@proton.me) ---
OK, thanks. You convinced me.

@Theodore Tso: Thank you for your detailed post.=20

As I wrote in the first post, i tried f2fs once and it also broke the data.
This confirms your claims.

I tried the =E2=80=9Ebasic-veryfy.fio=E2=80=9C. Unfortunately, this method =
is not very
practical, because in the case of my pendrive, the verification time is abo=
ut
60 days. After 10 hours I stopped. The progress was less than one percent.
Another properly functioning pendrive would also require many days. Perhaps
this method would generate an error, but it is very cumbersome.

From the perspective of the average user, this is not a good situation, bec=
ause
you can operate on hardware that is not fully functional, not be fully awar=
e of
it and not have an easy and effective method to verify the status of your
device. True, you can also buy hardware from a more reputable manufacturer.

Unfortunately, there's nothing I can do about it. Well, the only thing I ca=
n do
is throw this equipment in the trash. Thank you again.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

