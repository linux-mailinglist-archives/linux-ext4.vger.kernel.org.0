Return-Path: <linux-ext4+bounces-4214-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 216F397BEFE
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2024 18:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA831F21A47
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2024 16:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4383E8493;
	Wed, 18 Sep 2024 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGPLJksx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91D71C8FBD
	for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2024 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726675713; cv=none; b=Jlwjjz+XiGB/KtGKvIT99qfTZwQX7hvChss2W7AvSlOIYAXhi40YuNZobxW/P70SbynAMQwy61dgmDe4yEnze8UhN1w6Y5nkxHbGsFw3pe40dZ4M4iGoV2jOr96hSCxZ/8Kf8Acke+Q5hEdv6/fp3MqbWpa+iq/9q0jPkMSFgBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726675713; c=relaxed/simple;
	bh=sXt01AExHRRHPZTg8kt7mzq2ofL0OU0voMTNNtfylZ8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KeRd3/2QBiX0iAzdYWuUy7rQM/GKaHYbnAO21Iq1XFMEBnY+Myu6CWq2yaX1jy6quo1cb0H5pPHwi9RSdLejnOBYKbct5QgIe6e2xA9OlQFJ4JImCfKv6G2+ob5Nd+USE1ZNemzS23xGC/iowp9ockojCQsdplMv3EnwmvpU8KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGPLJksx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9E67C4CEC6
	for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2024 16:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726675713;
	bh=sXt01AExHRRHPZTg8kt7mzq2ofL0OU0voMTNNtfylZ8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=eGPLJksx2wQMerhg6ZnvoF7j7Vu88sUU4cdb4dQAft1jxbDJmuFxZyKD6LTOZYtJJ
	 Bt4m3HsBB0x3Lg58igvx/BrJgHv3/hiOzhMq6TNKJeJylW21nv1c6D5T5S471fqkzi
	 3GYHMFirMchWopou5QVXimqPewaH2QwYmApWnUw0BwRMGQdgt168ta6VORSyXYZXnI
	 8la+mDh7v51YE0Zq/rpQEBh+45mRxvKqmbSbuAsXxTbUhbARjCGnBu2GOuIox/VBvA
	 GHSaDqgMPXBGvVU0twsCPO2CFCJDmnOuDoc14BRzrK7diMxCun/7Q282V/HLO3yz4k
	 JZc1oDImHbXfw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9B3D0C53BC3; Wed, 18 Sep 2024 16:08:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219283] kernel regression with ext4 and ea_inode mount flags
 and exercising xattrs (between Linux 6.8 and 6.11)
Date: Wed, 18 Sep 2024 16:08:33 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jack@suse.cz
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219283-13602-DlXoU1fag7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219283-13602@https.bugzilla.kernel.org/>
References: <bug-219283-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219283

--- Comment #11 from Jan Kara (jack@suse.cz) ---
I think I see the problem and AFAICT commit 0a46ef234756dca is just making =
the
latent deadlock easier to hit. The problem is shown by these two stacktraces
from your dmesg:

Task 1
[  247.045575]  __wait_on_freeing_inode+0xba/0x140
[  247.045584]  find_inode_fast+0xa4/0xe0
[  247.045588]  iget_locked+0x71/0x200
[  247.045597]  __ext4_iget+0x148/0x1080
[  247.045615]  ext4_xattr_inode_cache_find+0xe2/0x220
[  247.045621]  ext4_xattr_inode_lookup_create+0x122/0x240
[  247.045626]  ext4_xattr_block_set+0xc2/0xeb0
[  247.045633]  ext4_xattr_set_handle+0x4ba/0x650
[  247.045641]  ext4_xattr_set+0x80/0x160

Task 2
[  247.043719]  mb_cache_entry_wait_unused+0x9a/0xd0
[  247.043729]  ext4_evict_ea_inode+0x64/0xb0
[  247.043733]  ext4_evict_inode+0x35c/0x6d0
[  247.043739]  evict+0x108/0x2c0
[  247.043745]  iput+0x14a/0x260
[  247.043749]  ext4_xattr_ibody_set+0x175/0x1d0
[  247.043754]  ext4_xattr_set_handle+0x297/0x650
[  247.043762]  ext4_xattr_set+0x80/0x160

These two tasks are deadlocked against each other. One has dropped the last
reference to xattr inode and is trying to remove it from memory and waits f=
or
corresponding mbcache entry to get unused while another task is holding the
mbcache entry reference and is waiting for inode to be evicted from memory.
Commit 0a46ef234756dca removed synchronization on buffer lock for one of the
hot paths and thus hitting this race is now much more likely.

I just have to make up my mind how to best fix this ABBA deadlock.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

