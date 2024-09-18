Return-Path: <linux-ext4+bounces-4200-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AEC97B97A
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2024 10:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F6132834FA
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2024 08:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14A017A597;
	Wed, 18 Sep 2024 08:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzAK2P9I"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBCC17A58C
	for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2024 08:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726648615; cv=none; b=jrayLxIWuWoL9YguErtRZAnTmBFm3rW5ipJQ5nK3iGGp6xDRb69x3X+U2g/9dib2v7Txaeoj0egs8Gv5lv4w6lMWmj6utk0/d4eMxnvnphajGoEGaUo+m8cp3hoqOQK140SMiIM9+DDldyct3HHREqBJyIvgTzkrDEofGvjPdgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726648615; c=relaxed/simple;
	bh=B5K9j6bFziAGwY54gmcn/mjlIKcIxoBrBeVpuvCCLws=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JgAEdYb2DfU9yeBS5abZbCww4UVxNPXfOmv0jjTLW+bDgg4Lg4x7N0T/9ivJHabOd/XlHaEmiFK1Favfy7yiqmQ/p150hlpOxBsZnBvRTOqfqS6E2WQSJK5M1J4RPmDusfyto92CyGZnFgZPrX5t/3OOzqtuGnqML5xQd9Te1+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzAK2P9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB609C4CECE
	for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2024 08:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726648614;
	bh=B5K9j6bFziAGwY54gmcn/mjlIKcIxoBrBeVpuvCCLws=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dzAK2P9I8apaWzsPk8PU4mBJUBokEk6F78dNVz2RvO4beXgjYRMpXPu1bXXejNama
	 zeVv6E9E5rFtSDYCw0u67IUSw7Ev9OqW75wgbWaFVqfsm6B+Ehtt15FGprIAiD3kFg
	 OBWWr5RkYmFuLNVim0JSMzs33LovFiji0uWqjL7bFyjG7INIGDqa9f3R7huvmWUffQ
	 GAbankdAO3MtQ10Oc0CUZ6kt20KJbfSpwZeMwEdv992AztQgdI71D/AZRcLr6DQoRG
	 SQFoZNS2PH5Cdqy80VPnVot22F8+Pu9XOHCwiqIxYkCc9mVO0bAWG9l5VJmThzacJ8
	 PaBXzLEpXPGxA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C0D99C53BC3; Wed, 18 Sep 2024 08:36:54 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219166] occasional block layer hang when setting 'echo noop >
 /sys/block/sda/queue/scheduler'
Date: Wed, 18 Sep 2024 08:36:54 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: Block Layer
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rjones@redhat.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status bug_file_loc resolution
Message-ID: <bug-219166-13602-11VqypICmh@https.bugzilla.kernel.org/>
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
             Status|NEW                         |RESOLVED
                URL|                            |https://git.kernel.org/pub/
                   |                            |scm/linux/kernel/git/torval
                   |                            |ds/linux.git/commit/?id=3D=
734
                   |                            |e1a8603128ac31526c477a39456
                   |                            |be5f4092b6
         Resolution|---                         |CODE_FIX

--- Comment #19 from Richard W.M. Jones (rjones@redhat.com) ---
Closing as fixed in:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D734e1a8603128ac31526c477a39456be5f4092b6

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

