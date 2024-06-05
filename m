Return-Path: <linux-ext4+bounces-2786-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFF78FD7BC
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Jun 2024 22:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 405FF1C22026
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Jun 2024 20:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E8813A890;
	Wed,  5 Jun 2024 20:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iT6E0mqD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7747462
	for <linux-ext4@vger.kernel.org>; Wed,  5 Jun 2024 20:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717620430; cv=none; b=aQIrb+OZnw0Ov2TjV16oONQY2BR9TpoFrU7XXGmX92Gipr7fcqfC0upXuDjRP3t0VVAShoXnrcZ9umc1GACmb6DQX4fsvS7c7tgdJJBO4/AIuK93ho0X5oGd52kMMD63fZteJmIQ0flkWGWOM/7qv8+QB0kHI+c/ZFSyti3uRg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717620430; c=relaxed/simple;
	bh=4p91DIwL1FU6JTUC5lcX0F8o7b/jnjUIrCQmLZuQmgQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DbE34afU1YDiBTeTKnPbJKABBCr6KfbPr8KQuuee7O+vrEKUBVNa2++4+ogtM89LLt+QRFJZTYjE7NovqX5gZacw2jWqdxX/FBUrs68SaBqmRyBDkcxWCIj8JycRX1kBhPCOgDgjRgiRI+CxXbYI8TvqVA00Zw1RUMnCLcYjNZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iT6E0mqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F302BC32782
	for <linux-ext4@vger.kernel.org>; Wed,  5 Jun 2024 20:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717620430;
	bh=4p91DIwL1FU6JTUC5lcX0F8o7b/jnjUIrCQmLZuQmgQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=iT6E0mqDsogzINd7oiMJmf0RrGhMsgPjTyxJRmZiNsVS8y2PaGHaxyTOODCmGPJCZ
	 Xv1c6WX17ZGwMYd9Msv8PP/bXM4GV8WR3fESJXDcbebRH84GVGvGAKuTcKdtCH3aNE
	 t5gGGXxjM/rTv3cdoAp3LScbu4Rjesrk/KsFVPJjwZVCXDNeZhIOEEKrzlfBrG+z2k
	 /WgiQo4Ow+pOauN6ZS+9f0TUqHbW3+MzEOsVw6sHed4iT7UJS0l64Y04GvoqxGR0WK
	 vgMoULdGpgt1iW1v5Pl/58VzvUDaT2Th3rb7slZiCiUoaDWvlojTxj3XyuYfom2G5i
	 K8f05n/TAKM8A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E55E9C53BB0; Wed,  5 Jun 2024 20:47:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218932] Serious problem with ext4 with all kernels,
 auto-commits do not settle to block device
Date: Wed, 05 Jun 2024 20:47:09 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sirius@mailhaven.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218932-13602-vcnCYagqhU@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218932-13602@https.bugzilla.kernel.org/>
References: <bug-218932-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218932

--- Comment #5 from Serious (sirius@mailhaven.com) ---
/proc/sys/vm/dirty_expire_centisecs 3000
This contradicts information from
https://www.kernel.org/doc/Documentation/filesystems/ext4.txt
commit=3Dnrsec    (*)     Ext4 can be told to sync all its data and metadata
                        every 'nrsec' seconds. The default value is 5 secon=
ds.
                        This means that if you lose your power, you will lo=
se
                        as much as the latest 5 seconds of work (your
                        filesystem will not be damaged though, thanks to the
                        journaling).  This default value (or any low value)
                        will hurt performance, but it's good for data-safet=
y.
                        Setting it to 0 will have the same effect as leaving
                        it at the default (5 seconds).
                        Setting it to very large values will improve
                        performance.

So actually commit=3D5 does NOT guarantee, that if you lose your power, you=
 will
lose as much as the latest 5 seconds of work. You will lose 30 seconds of w=
ork.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

