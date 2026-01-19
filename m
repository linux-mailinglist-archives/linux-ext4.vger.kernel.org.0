Return-Path: <linux-ext4+bounces-12967-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8ADD39CA4
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jan 2026 04:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C526300720A
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jan 2026 03:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8177481AA8;
	Mon, 19 Jan 2026 03:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ZflvbTIx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EBB1FC7
	for <linux-ext4@vger.kernel.org>; Mon, 19 Jan 2026 03:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768791626; cv=none; b=d5aYWpsWSatW7m+yMHJC+bQA7il1uQQV7/6owJ18PEaPYsuwknu13mqJw1qDxLdB2YLxOzSEUl6BcBV9Kg0yqk7Sikj6Bl3qTVPQ4QJgoEsdc+fcRM2tVdmwQCAl/iMZEkaQeIRFho/lmCoDr3mWo4bKR6b8D3bnyiNnBHtTpnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768791626; c=relaxed/simple;
	bh=kYFf20rT6f17wiGUNWsZrabyAYU/Ivq5nGmdFnw2Lk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYTYbyqniFOnyGpdo1Am5/HynJe1vdmjDSUkUp5Ajq/GYopnTMJkg02cbRWk+x/IxoFcdJTUQ74Qcz5BXfwwcQ2m6OpuLvRBUtjL6iNINgQCD34ePFGtyedrvWOynjvRKzC+RTOQftI0Vdsdn7J73QizpvkjzfmslFUK1hSjlts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ZflvbTIx; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([172.56.176.29])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 60J2xZ5v002519
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Jan 2026 21:59:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1768791581; bh=j/gdzEuIvBWKdRaHU/LTvK59F4Xl7xCNw0dR66Gm4+E=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=ZflvbTIxZnO9PvQ7QZixbHNdTSxtLqqOyuBzFXL7f+CjdEy67DSC0SdL6SSUbKEmP
	 jykbT2AE8rKM279F9RqPkKm73GBA1e9VU42MGyxuGl+hCFfc5xjzVmnASSrg6v4upv
	 /fXv6bN135K/fZpthj2B5vHsjN9OxTxmURWm9UIOjy4EnYTtlWhjB6B6RLAYqQbxVe
	 dvXzJNdPWZae3gO8aRLbki0EUzaZ06EHag31EuQg/Zq3ZBA5t2LNwF7FledpSfFmPc
	 pgiEhypVoUqq6SYoFH5ocvZlNEboUj3hbGXU/H+vspBq9KOnfiXwUtm8OkMDRrydAm
	 HKMjfX5LZnfZg==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id D29CC553241D; Sun, 18 Jan 2026 16:58:57 -1000 (HST)
Date: Sun, 18 Jan 2026 16:58:57 -1000
From: "Theodore Tso" <tytso@mit.edu>
To: Li Chen <me@linux.beauty>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC 5/5] ext4: mark group extend fast-commit ineligible
Message-ID: <20260119025857.GC19954@macsyma.local>
References: <20251211115146.897420-1-me@linux.beauty>
 <20251211115146.897420-6-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211115146.897420-6-me@linux.beauty>

On Thu, Dec 11, 2025 at 07:51:42PM +0800, Li Chen wrote:
> Fast commits only log operations that have dedicated replay support.
> EXT4_IOC_GROUP_EXTEND grows the filesystem to the end of the last
> block group and updates the same on-disk metadata without going
> through the fast commit tracking paths.
> In practice these operations are rare and usually followed by further
> updates, but mixing them into a fast commit makes the overall
> semantics harder to reason about and risks replay gaps if new call
> sites appear.
> 
> Teach ext4 to mark the filesystem fast-commit ineligible when
> EXT4_IOC_GROUP_EXTEND grows the filesystem.
> This forces those transactions to fall back to a full commit,
> ensuring that the group extension changes are captured by the normal
> journal rather than partially encoded in fast commit TLVs.
> This change should not affect common workloads but makes online
> resize via GROUP_EXTEND safer and easier to reason about under fast
> commit.
> 
> Testing:
> 1. prepare:
>     dd if=/dev/zero of=/root/fc_resize.img bs=1M count=0 seek=256
>     mkfs.ext4 -O fast_commit -F /root/fc_resize.img
>     mkdir -p /mnt/fc_resize && mount -t ext4 -o loop /root/fc_resize.img /mnt/fc_resize
> 2. Extended the filesystem to the end of the last block group using a
>    helper that calls EXT4_IOC_GROUP_EXTEND on the mounted filesystem
>    and checked fc_info:
>     ./group_extend_helper /mnt/fc_resize
>     cat /proc/fs/ext4/loop0/fc_info
>    shows the "Resize" ineligible reason increased.
> 3. Fsynced a file on the resized filesystem and confirmed that the fast
>    commit ineligible counter incremented for the resize transaction:
>     touch /mnt/fc_resize/file
>     /root/fsync_file /mnt/fc_resize/file
>     sync
>     cat /proc/fs/ext4/loop0/fc_info
> 
> Signed-off-by: Li Chen <me@linux.beauty>

I'm curious what version of the kernel you were testing against?  I
needed to mnake the final fix up to allow the patch to compile:

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 9354083222b1..ce1f738dff93 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -321,7 +321,8 @@ static int mext_move_extent(struct mext_data *mext, u64 *m_len)
 		ret = PTR_ERR(handle);
 		goto out;
 	}
-	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_MOVE_EXT, handle);
+	ext4_fc_mark_ineligible(orig_inode->i_sb, EXT4_FC_REASON_MOVE_EXT,
+				handle);
 
 	ret = mext_move_begin(mext, folio, &move_type);
 	if (ret)

						- Ted

