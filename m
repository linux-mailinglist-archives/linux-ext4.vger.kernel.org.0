Return-Path: <linux-ext4+bounces-8693-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F51AECA66
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Jun 2025 23:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 726763BF00A
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Jun 2025 21:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D5F2222C5;
	Sat, 28 Jun 2025 21:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvK2WUgZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C697DA66
	for <linux-ext4@vger.kernel.org>; Sat, 28 Jun 2025 21:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751146752; cv=none; b=N10j6zWyrnwAmDuD9rKfhcNCy67INVO8bUWqWah14SW7JtmQE4oJZz4zTLYqsi4CM2NrKTIU7zZvy4KBoHppciKCtlXvxFmmKBWP8jNj+OkDrKjsSAFwnifaD7rSFPwWslZ9XHrK26qX82mdeLiMvkHDmyDliM9uDYvYU51/Yfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751146752; c=relaxed/simple;
	bh=uCuUz38klKULwxsgAwJwA+O6Y96elUsMxv6cJ1haplw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tpac9TyjV5Twxab36aKuHyGhDDRm3qYmAY03JkneIcfiYOZ9DdJVJzDoJHh49wGbu6J8TKlLVEtQyf0SheZ4F2oJTA37fK/yXG+5Er1/4q4b1GzNot9Glf2pHDYCOn1FNeoMEPuANCFrSMwm9eZsOKG8awh0rygVPLmmmpORJlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvK2WUgZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D970BC4CEEE
	for <linux-ext4@vger.kernel.org>; Sat, 28 Jun 2025 21:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751146751;
	bh=uCuUz38klKULwxsgAwJwA+O6Y96elUsMxv6cJ1haplw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QvK2WUgZnMmsrVuiOEXuUFj9J8XqBL+isoy/vxpLShdcRbt7uOUzxNqvyoOfua1tv
	 eHlg8MZN0G9qcZPZexkge0ERSJ5Of94jkBZ8t0E1ff6hs2WHwfanyrOoUpQ0UBZ9ig
	 Qivya6EpMVWhQa6RtuMGuhDmg2IxVPEbDJMLwi/i3DMkTpfsVG0ZCh7WBI/tGgGGl3
	 sIBuVy3aqKAxAZrZ+iAdwN3j6jPx46qelcwme6cPeyi5OuzKhDES91lC+ob1DexhwX
	 604QdGZFmGh8umgCiPVZ31/g6DH95isFukaaOwb4tfsQZlFdPK/0i/SCvNd5GeYWMC
	 d4e+dANy2oM/g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C9CC7C3279F; Sat, 28 Jun 2025 21:39:11 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220288] A typo Leads to loss of all data on disk
Date: Sat, 28 Jun 2025 21:39:11 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: WILL_NOT_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220288-13602-Y5xrdJ0OuY@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220288-13602@https.bugzilla.kernel.org/>
References: <bug-220288-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220288

--- Comment #5 from Artem S. Tashkinov (aros@gmx.com) ---
(In reply to Andreas Dilger from comment #4)
> It is very common in my experience that ext4 filesystems are created on
> whole disk devices instead of partitions when run on servers, in order to
> ensure the filesystem is aligned to the start on the disk and with RAID
> stripes.

Not to mention that you can=20

mke2fs /tmp/random.file

and then

e2fsck /tmp/random.file

or even use a loop device with no number.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

