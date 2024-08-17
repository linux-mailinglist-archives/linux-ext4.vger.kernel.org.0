Return-Path: <linux-ext4+bounces-3753-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6628095572C
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Aug 2024 12:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98F541C20DD1
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Aug 2024 10:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43439148853;
	Sat, 17 Aug 2024 10:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgX3GjRq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D8B58ABC
	for <linux-ext4@vger.kernel.org>; Sat, 17 Aug 2024 10:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723890131; cv=none; b=F9PhErdrj+Cwbl8dWb5oxrf8gjqpEe08JjphxICFbxS2gRAPkbKFfSWzALkFn0WtOn/5sqosqdTkoi8Qw8LY2UPO33i+t3bc2d7o7clTARxKSdDEvNbKp7i/CwMHD8iK/Iart3T4gNmTcy68llcDJUinWesos/BrXzWxAj5z6vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723890131; c=relaxed/simple;
	bh=5tVQektLzginQoolbdv1Oor1akb+HXjvhVKmVPS49jQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r3Xbg7Ba01pc3Vfz5e8CND60N6Fa3YD1odpgAUobRFN9kw9+Y7xAr5Z04ICbkWkJQkgtJMBXNK9UlyJaY9raRtAls+7XkbjOX69GMABxLBjcaf3dr5okjwykaf99xN4FNroJsSImaNZQu5HgnA0rlMlV5HWfb0ib3U+nfp8i2CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgX3GjRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3FB6FC116B1
	for <linux-ext4@vger.kernel.org>; Sat, 17 Aug 2024 10:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723890131;
	bh=5tVQektLzginQoolbdv1Oor1akb+HXjvhVKmVPS49jQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VgX3GjRqQU9EWntENB++sRynIA5sy733WxQCdHjzazQ4nLJqtPQa+CXdIrcTok3s2
	 naTpUFdE56//VghiqCtIEFzzE8ZZ+lYxe0HCxDBRR4v43/HEndJstqxBN1vCcHso5i
	 TzspRFb+Y7ckltzKH+FXHMjQ0vlrS/VSAJuHYQIwKinxSWh3Rox4eNU4C9mNHxM8FW
	 xEWhc6YI2sHgphQNaThkhPELpfI9F5YbsfAERDW4sjVu8iA/mpN9mfI1SUk8eu90uf
	 U30c1YIDobp/TglOON53INAz3ArKWwP062KI3/CE5y66Qij30VamuDcjDEqqLp70ds
	 AqVED/2hUgbDg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 349B9C53B7E; Sat, 17 Aug 2024 10:22:11 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219166] ext4 hang when setting echo noop >
 /sys/block/sda/queue/scheduler
Date: Sat, 17 Aug 2024 10:22:11 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rjones@redhat.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219166-13602-pjTw0fKgTW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219166-13602@https.bugzilla.kernel.org/>
References: <bug-219166-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219166

--- Comment #5 from Richard W.M. Jones (rjones@redhat.com) ---
I'm afraid that didn't reproduce the issue.  I have an idea to run the same
test, but in a software emulated virtual machine.  The idea is that the much
slower performance will exaggerate any race conditions in the kernel.  Howe=
ver
this will take time.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

