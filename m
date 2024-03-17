Return-Path: <linux-ext4+bounces-1671-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B7D87DD1A
	for <lists+linux-ext4@lfdr.de>; Sun, 17 Mar 2024 12:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B89EB20DD3
	for <lists+linux-ext4@lfdr.de>; Sun, 17 Mar 2024 11:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE421AAC9;
	Sun, 17 Mar 2024 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRyiGc//"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7307171A4
	for <linux-ext4@vger.kernel.org>; Sun, 17 Mar 2024 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710676699; cv=none; b=i1GER6O7t+X/WEalwI41u1I1+Z3UQrRLKESJfRC/A6z2CLYlQSl+l0mIh76FzKb1/w3WEp35wTbSW/du2bCWy3k9f+VFzjI1PmxriJ9tOyHbd8hibtMDPCAXuq2XFdXTUJAoAVcWpIsePohFGyoNOTtp3TPZx59UFrlMW8fx6Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710676699; c=relaxed/simple;
	bh=1INMa1OkpWgp0vqVkYA9fSnuMYUTCG3nhahtBI04CYI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IW+KL87ZVIG/pAEcnNHPsNS9wz1IUv3gMM/sHwHDdaovkQItrUTE4FPMs96glk8GKZ/b9rJjV61A9FvmGBqflQ3KRfeBr2VnWBmF1ZA8CRZSrwP/MLc+VIDK5m8Lg2ESzgYnncFrxnzElDUq2MhlQOnOFFHtA/Miqa15SX/GtOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRyiGc//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 778C8C433B2
	for <linux-ext4@vger.kernel.org>; Sun, 17 Mar 2024 11:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710676698;
	bh=1INMa1OkpWgp0vqVkYA9fSnuMYUTCG3nhahtBI04CYI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oRyiGc//Trs3rvTOTQ8PegO04V1GK87v6JqaVjkrjuJ1s8gdR56VZX9RGKqh7L+Q4
	 fGFmWh2MwP7CYpMlcY+fzUHLsrcWrHBBh7VfK4ntByzsR8FA5Z3hRArfkVvRs0yOGq
	 8sZd1c3Wu5qJGb8qzeTMWpYPPsFdUb4aO8O5pnJr2HWHzHyquPkDo707BktrDloWWG
	 MQP9QPDy1zougM6v/iZhU2EWuXNFG6Hb0BIKxNI5BNw1Plooqll7uEZb8XdCsryuvU
	 GPNtyCzAL6iD1ZhdgbyDBii9HEfV5+5u4nc29i5C9FYwl4Gbf/ur4K7W3Y3ALYf6Pl
	 ujGwxexeIPgnw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 71170C53BD0; Sun, 17 Mar 2024 11:58:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Sun, 17 Mar 2024 11:58:17 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ojaswin.mujoo@ibm.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217965-13602-4cKE5DNPxG@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217965-13602@https.bugzilla.kernel.org/>
References: <bug-217965-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217965

--- Comment #68 from Ojaswin Mujoo (ojaswin.mujoo@ibm.com) ---
Hello Denk,

Both of the commands you mentioned "mount -o remount,stripe=3D0 <dev>" and
"tune2fs -f -E stride=3D0 <dev>" should be okay to run and aren't dangerous=
 for
your filesystem. You can always take a backup to be extra cautious ;)

That being said, this issue was fixed by the following patch [1] which I
believe landed in linux kernel 6.7 so anything above that should help you a=
void
the issue as well.

Regards,
Ojaswin=20=20

[1]
https://lore.kernel.org/linux-ext4/cover.1702455010.git.ojaswin@linux.ibm.c=
om

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

