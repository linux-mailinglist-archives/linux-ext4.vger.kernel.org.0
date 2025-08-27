Return-Path: <linux-ext4+bounces-9718-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7D0B3883B
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Aug 2025 19:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F073AAF89
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Aug 2025 17:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4982F6560;
	Wed, 27 Aug 2025 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABxfTmBL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4014E243964
	for <linux-ext4@vger.kernel.org>; Wed, 27 Aug 2025 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756314438; cv=none; b=QO9q7JmfMP/ZYoLEO4LjPTo2KmYYeUcRc5HeaH7+kPOmmdyoll2F7Q191elFIF16d9X7exbo0lIoDVNpYmM+cayQtVV5fFOCff3vzJR+EMOymv5wgcvBdXVJ/s0bwi9krHaWPg7p5/zrlPJIQ3tbL2FJ2kRa2+ErtEhKorSAfVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756314438; c=relaxed/simple;
	bh=5fjP4Ppe8zZ6g65SdrCMmNMCph9uNSl2nljC6mgEVIg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SQ1i7CrG0qotG/yGOMjxH9t0LFT2jNiSVRAfhP/lpcZvVpoSm/MUn6FllODJFnp9v2M1CimCVpAnrnggyStRRnXC5gKiVv+P/Ij4EmERomhhWRmAf3U7Oji8u5LS30fgHfCKFnRFGuTa8yJ5LTeT2qYmeF/WPkrDnYL2tvB+9CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABxfTmBL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D093AC4CEEB
	for <linux-ext4@vger.kernel.org>; Wed, 27 Aug 2025 17:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756314437;
	bh=5fjP4Ppe8zZ6g65SdrCMmNMCph9uNSl2nljC6mgEVIg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ABxfTmBLtZTPqbvmIaI9hqDrLKQCA3Kgnhwfr85Wdw6SELHZvanDO8dxgkUsLXpSu
	 7GQOZm6bJ5nAYFdfn+MPehW6yRPfdLWr48oFfItwVULP5XIudmfS5EXmK/sAcqPMld
	 mnBh/7TN7b65ptfnu98Cd9s0PvJoJLt0FMZD/jjSACN9a5YMCpA4ctddtvsA+Y4eAV
	 4yNPIyhg4TSmR4X+wcjBCWDsPyFpP9eLrbBc+3wxKqVlIMgVjRztwsrZuukpkSSBUF
	 5wngZOSCWPUBpZetojlY1AiWehORe7RYsbb6hWEftgRx327q80RboWvQrLmAY38tZz
	 s8cYC4a1iVIaQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id CA276C53BBF; Wed, 27 Aug 2025 17:07:17 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Wed, 27 Aug 2025 17:07:17 +0000
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
Message-ID: <bug-217965-13602-vGzi4pJCMX@https.bugzilla.kernel.org/>
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

--- Comment #73 from Ojaswin Mujoo (ojaswin.mujoo@ibm.com) ---
Hi Mingyu,

Thanks for looking into this and sharing the reproducer. You are correct in=
 the
analysis that we were getting stuck trying to check the same block group for
aligned blocks, due to the fact that the fragment lists always returned the
same group.=20

However, about this:

> The author changed the fragment order RB tree into list for better
> performance.
> However, the function 'ext4_mb_find_good_group_avg_frag_lists' will alway=
s=20
> returns the same group every time,

The change from rbtree to list was not done in the patchset you listed but
rather here:

https://lore.kernel.org/all/20220908092136.11770-5-jack@suse.cz/

which got merged in v6.0 kernel hence I think the behavior of fragment lists
returning the same block group was there even before my patchset (the one y=
ou
listed) However I remember people had mentioned that they started to see it
after v6.5.=20

Its been sometime since I looked into this but I remember I had concluded t=
hat
since my patchset added new allocation criteria which made the allocator tr=
im
the request to more aggressively look for BGs in the free fragment lists, we
just made this bug more easier to hit.

I tried the replicator however I was unable to get to the high CPU util, but
since you already have the setup, can you check if you are able to hit this
issue in v6.4 vs v6.5.

Thanks again,
Ojaswin

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

