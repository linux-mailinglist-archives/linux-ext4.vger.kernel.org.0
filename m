Return-Path: <linux-ext4+bounces-10601-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE27EBB62A5
	for <lists+linux-ext4@lfdr.de>; Fri, 03 Oct 2025 09:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7AA33BCAF8
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Oct 2025 07:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8F123D7D0;
	Fri,  3 Oct 2025 07:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKOJ/uX1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4052045B5
	for <linux-ext4@vger.kernel.org>; Fri,  3 Oct 2025 07:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759476477; cv=none; b=pUZPVwWzHdTWGU+eora9HrMtTitvvyU2bizKUADdu7wyBy6695jFL3U2zKhNHNzUO1gtzgA9Ed57ilIrJluX0I8jVwfz4wNUETpgNbvb6Wb1JCSODojoi7XlVQZui81uJ1myXd8xE5IJbCkmPZmdoj6QxPtD5vGhqzpBlwYgiHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759476477; c=relaxed/simple;
	bh=FHeBIAzFqxMdYa8NOuIuJzQiDAWG93YAEXtw7KNwdbs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I+BLoukjDigFLxuWWZ0MmTWC9Fl4G0zHqedIDJQKYzNip3owHTyVzUqJ54zwMrzVKgYB2rnRqw61YuDFx+2cLWmIMVERYciYrnEmBfyVEKB5SmUK1m+3jhPBZpPqR38DnkF7PAglyHBVewlEJwKaaI/CU7rrKBD+HMLX202ZPcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKOJ/uX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E3F6C4CEF7
	for <linux-ext4@vger.kernel.org>; Fri,  3 Oct 2025 07:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759476477;
	bh=FHeBIAzFqxMdYa8NOuIuJzQiDAWG93YAEXtw7KNwdbs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LKOJ/uX1MLZk0vpQIfgh9v83SGHGsS3MvZmdnAW2K9uurUr/6nrCvmt0nvG1J4Tn/
	 FQxoCvSHwG8bAHeHXLEtyy31iEtbP8AqYpb1wJ3VwWd9WoumN5HmydUP9O1HeFHbaS
	 Dr4wJ+BwM4typTPOqwGJuinqhDTuynxXB4u0TewYS8x6j60i3KDnXw0SxLK2gL2aVW
	 CuKWKk/zksnTgVMqI0qiVu1Mo14UywTxKQm5h+N6zWZHvypR+0NQDHoKoapo3rdFDg
	 KPB5kQ3uYS8rx6bNrXjlD5AzPJ8T/MJOS0OEARayexV6LtfVA1/ZziR8Du8qpFKLjM
	 CbqW0MH8B3rsA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 16E14C4160E; Fri,  3 Oct 2025 07:27:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220623] Possible deadlock, system hangs on suspend
Date: Fri, 03 Oct 2025 07:27:56 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: athul.krishna.kr@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.description
Message-ID: <bug-220623-13602-LeK0tHpvPv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220623-13602@https.bugzilla.kernel.org/>
References: <bug-220623-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220623

Athul Krishna K R (athul.krishna.kr@protonmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Attachment #308745|Systems hangs on lid close  |journalctl_log
        description|                            |

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

