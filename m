Return-Path: <linux-ext4+bounces-4083-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED349700AB
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Sep 2024 09:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8F11C21E62
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Sep 2024 07:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A2714885B;
	Sat,  7 Sep 2024 07:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0UnPlu7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D4C4D59F
	for <linux-ext4@vger.kernel.org>; Sat,  7 Sep 2024 07:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725695358; cv=none; b=pO5ytLTSm0o55n+bsmNloBFZi4P5KmmvCNb8gSNg7x50qisFRKHx9uUTgAKDmUjl9s1WkMN6h9yPglElSjTnryW8ru7Jx3ZZcKRpKjAsKB0wZI5hD13yGcZ01ZwuHCfgGLLFplx5DNeMwq6vfoCia+W+6kU9nC6/bkITZysxlms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725695358; c=relaxed/simple;
	bh=6sJWl/O/zragkPF2zfYYdPbcZBQKIfeRdfhtJuxZc/A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W6LxvR6iVzoiFbJNRspIqwOkMwT2edUAyltANoZlqMpJK24OvCcUPA7+Er6u/G97RvQFKsrLErO7QSulyCgnrDF8iDqHaQOuRBSGZjjLEjNbDFJj0QXSmP8fdr7TP2D5GuMW2Ln+5AadLOEtwKUDnpsxRb71LjUdt467tz11E/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0UnPlu7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91439C4CEC2
	for <linux-ext4@vger.kernel.org>; Sat,  7 Sep 2024 07:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725695357;
	bh=6sJWl/O/zragkPF2zfYYdPbcZBQKIfeRdfhtJuxZc/A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Y0UnPlu70w/Q8HFUzrdz95PCxL7sLQXgiOpGYRbHfrWl0k8NAcfSNR/pSq0BVw51a
	 pY1+L4U086QgJPMS9Kd7cJpPLa34B/MJZp0UqPZlMA26ThAclFRca0/Dwo+aRf8c9f
	 M58ac8TNlEOKWYaEB9UmSgyKVmmi/DXUGM0r27fmHCIsZecrcp51QL3hdT572GmtnJ
	 HU/pjPkUfq/uyVex6flETHRWIVRZBwwwkCE72EhAIq0T8rWlaRjIfbgXxsAbMdVc7/
	 iZJsBDdIjQx5IFstxltStg8Z45O45RCFR8/iF9OlYOcgj73mFjVtSl/O+PrqiJH2N7
	 bztqyrEcHVFNQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 80453C53BC4; Sat,  7 Sep 2024 07:49:17 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219166] occasional block layer hang when setting 'echo noop >
 /sys/block/sda/queue/scheduler'
Date: Sat, 07 Sep 2024 07:49:17 +0000
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
Message-ID: <bug-219166-13602-KJGSvHnnq7@https.bugzilla.kernel.org/>
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

--- Comment #17 from Richard W.M. Jones (rjones@redhat.com) ---
http://oirase.annexia.org/tmp/kbug-219166/

vmlinux and memory core dump captured when the bug happened.  You
can open this using the 'crash' utility.  The corresponding kernel is:

https://koji.fedoraproject.org/koji/buildinfo?buildID=3D2538598

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

