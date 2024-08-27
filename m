Return-Path: <linux-ext4+bounces-3900-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13627960828
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2024 13:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A780B22103
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2024 11:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5CE19E7F7;
	Tue, 27 Aug 2024 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBwPrjlG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BDF155CBD
	for <linux-ext4@vger.kernel.org>; Tue, 27 Aug 2024 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724756855; cv=none; b=a6JmktLwb8fZik01sd3NZvCPeWprr7DbS/5kkPzWW7trd3CaZ0TVxYNU9KZBPy6d+bbD/s9jpSbA4trtDJwGi8VPz2ALkg3wcqXliAyINfvhmDY/pMVTNQH4K9KVGpmr0SUtqPsBRHCH/C36xPqyvkNurMVfdNWH79qAciyWY+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724756855; c=relaxed/simple;
	bh=jYRoOxWpfoKZUEqN4PPxjRzVt7jVHzffQ22kkuxINA8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XFdgNi//bYLXF2ty5rvuDd6rz23Nf/s6yHDpD2QlgLKL1yqQeLbw8Rg7X7FGvkSUKrTR0hUteePwo2uxeyjuG1JMzJi4V9ZyTpwD6PO8dfZ2DlLWIvyAnf4+yQEX1Sf2Q08wb+725Kq9cqm9oq3YwlrCtiPFdMz5jf2+t4fBHBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBwPrjlG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCC25C8B7A0
	for <linux-ext4@vger.kernel.org>; Tue, 27 Aug 2024 11:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724756854;
	bh=jYRoOxWpfoKZUEqN4PPxjRzVt7jVHzffQ22kkuxINA8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YBwPrjlGMiNopKXeWzLVOkzSXxaaftILmRBzqZ4qyCavlpBN/65L044K5KCrZBSLz
	 Cb48qNG8DH7sj5e3kuF7No5vgjJfKZowFVBxPLxpshS0gdeIUBeNB7eJhp54NjFa5D
	 3gx54BBWOaWzSmXKaeaYyvoLh8KlmFFPakJX/FmCii1QSlgf/sdglhP9XShGBLfoWa
	 9DGvqvKBqqcJz4SfJIIzsP9Smkypm9bsr8TlRNVVeq8GlWA0MhS5hFrI6+pYqBIwmK
	 u3XKFAomw3sbnPmy0ETnFvqwFTZExElgQOKuVqfGruTnzz4m25rn9zphhjTF3qNnok
	 +bHs4EfF2JR9A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C1AF3C53BBF; Tue, 27 Aug 2024 11:07:34 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219200] update from 6.11.0-rc1 to 6.11.0-rc5 causes file system
 check every boot
Date: Tue, 27 Aug 2024 11:07:34 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext2@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext2
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: PATCH_ALREADY_AVAILABLE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext2@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-219200-13602-3XzCQJaQYt@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219200-13602@https.bugzilla.kernel.org/>
References: <bug-219200-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219200

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |PATCH_ALREADY_AVAILABLE

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

