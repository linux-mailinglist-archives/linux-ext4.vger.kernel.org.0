Return-Path: <linux-ext4+bounces-3805-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AFB958B6C
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 17:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C723A1C21BD0
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 15:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D81194137;
	Tue, 20 Aug 2024 15:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urZ0Y7Uc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92787194085
	for <linux-ext4@vger.kernel.org>; Tue, 20 Aug 2024 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724168022; cv=none; b=DqtaBU4oEISvuBdf29fvPifx2MGSPWWtrlECU2Bpfzt2ZrU/c8XJFtjSiQADD+3soqccZ+1Ifs2ho01hrru5WjTj0E5fSEFZMYUhy9S7k2OKANQ+du+GspxNKPOLT+UOLOfpmK5l0XnPzRDf9LAEui6qaG4WsglqTXDD+O4rBug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724168022; c=relaxed/simple;
	bh=MjDfPRguW/6OQIw1csf3N2yZ6S5eMkp7YwFkAWOhOvM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kn3eKUgUyI9JbHchkZFBsocq79qQCmytSPf5kBPE89DMgsuKMtzx2qnLnR7IcoYavAbvaVbqLYdeaYl9XFdQWg0eOyCAbqDLqK1s0OTIRqusylwqNedDpBjQP5UKpMTwVFuPqxTrcITfjdygvTBZX0ashJJG3+QzhPDeBH+K5GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urZ0Y7Uc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D978C4AF11
	for <linux-ext4@vger.kernel.org>; Tue, 20 Aug 2024 15:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724168022;
	bh=MjDfPRguW/6OQIw1csf3N2yZ6S5eMkp7YwFkAWOhOvM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=urZ0Y7Uc7pEd2e8fiQWgJcOfh9OIPyu5A1FxM2iY//yqzzpcvHfMDvsXxjmPkeEA7
	 bHG01LaA3GIQ+B/nrlva339BqzTTR+u4Vf+KOyEAMfGWYYT50gNNzVbTvz9IISSyEl
	 NV46KeFIG14v52JQi8nQ5DxqaZpXNFpvClsjU5pwHxpoqm5mWWf48t8TgoNcXhoX5/
	 4spoOKxZBf9wa6otnPaA86EAs5Rf/k1HRKPEmu4F05ssDRMJKs36b0PDGKs0RUFszr
	 xYb6D0qYnwgQJyMe2XNPHOIf+l5Zd6DJ+HKYX+mL7CVOba4827gjTOiZtSdadHW3sG
	 tzMfk0MBqi3EA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 25B33C53BB7; Tue, 20 Aug 2024 15:33:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219166] occasional block layer hang when setting 'echo noop >
 /sys/block/sda/queue/scheduler'
Date: Tue, 20 Aug 2024 15:33:41 +0000
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
X-Bugzilla-Changed-Fields: short_desc
Message-ID: <bug-219166-13602-4cXpAE0xG3@https.bugzilla.kernel.org/>
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

Richard W.M. Jones (rjones@redhat.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
            Summary|ext4 hang when setting echo |occasional block layer hang
                   |noop >                      |when setting 'echo noop >
                   |/sys/block/sda/queue/schedu |/sys/block/sda/queue/schedu
                   |ler                         |ler'

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

