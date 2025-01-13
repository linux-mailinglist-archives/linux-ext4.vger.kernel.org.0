Return-Path: <linux-ext4+bounces-6066-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F15DA0C023
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2025 19:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D44937A3C06
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2025 18:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922011FA8F6;
	Mon, 13 Jan 2025 18:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAg+b+qN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343F318871F
	for <linux-ext4@vger.kernel.org>; Mon, 13 Jan 2025 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793318; cv=none; b=dDjyFHyBXqzmjnhzm5WoSd5fdJwN4Ykw/nGpve4uNudblmMQkzib9f5stAIQTuNVoe/FgYFfepFRQSQlB9aEenva+cjQ2s+J2vceWpwYibpwqVgz4hp6OBG6HT964NvJ5CEG1mv/+cCgBnpnq3gGrIf6MGuovgoMpE8YeMTl2VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793318; c=relaxed/simple;
	bh=uV7Q2p9e11PNJeE2XEKDLPYWp15q+2oV/4NRhCQm0RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYKwxcPKMjuZibLvZudddy8CDXcnFcXg8Gmkobghwv0eyYmT8m18B5KbUysHk0yv6h9ZHqC9uVb2Esf5rVnbD9qu/XI4SWdKTNVD3ucOdXFOJCbGIYoJra71MEUebo8YjZJ3Gy/gGhdiBuPeTfn0oZZaDrOY7ifXOdl7o9zBElQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAg+b+qN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0912C4CEE1;
	Mon, 13 Jan 2025 18:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793317;
	bh=uV7Q2p9e11PNJeE2XEKDLPYWp15q+2oV/4NRhCQm0RQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aAg+b+qNZV1SLbrChPl7QCtgXzj7Dxou0Mpue8RH/CDAqxdsYczxxqiv4YMO0sEuN
	 T6eg1GYLMvaJTEnZFRtOc4xu+HR6ufSpISjxSRWKFUX0p90x2S9/toyei2KwLHD8WY
	 01d1fVo8LPOvZpjrxzBX7IUDDC6HJo2XLQ2NJrgUnuETeJA9knYwVfpRrGGFf9PYXQ
	 2fLec3fwSUYI5Y6zYpIXNV3CHrLld4wcQdVgRc2rJvzv/vJv1YjzZ/PdEh9d9qdnqh
	 TvLjz8BQMVytB4u/JtikPTXmWuHDdSnLC8G07rhKaXWtGkOjHQ/kaEfRP4ndyFGiHM
	 hsznU9j7iA/2g==
Date: Mon, 13 Jan 2025 10:35:17 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Catalin Patulea <cronos586@gmail.com>, linux-ext4@vger.kernel.org,
	Kazuya Mio <k-mio@sx.jp.nec.com>
Subject: Re: e2fsck max blocks for huge non-extent file
Message-ID: <20250113183517.GC6152@frogsfrogsfrogs>
References: <CAE2LqHL6uY=Sq2+aVtW-Lkbu9mvjFkaNqLaDA8Bkpmvx9AjHBg@mail.gmail.com>
 <20250113163345.GO1284777@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113163345.GO1284777@mit.edu>

On Mon, Jan 13, 2025 at 11:33:45AM -0500, Theodore Ts'o wrote:
> On Mon, Jan 13, 2025 at 12:49:19AM -0500, Catalin Patulea wrote:
> > 
> > I have an ext3 filesystem on which I manually enabled huge_file
> > (files >2 TB) using tune2fs; then created a 3 TB file (backup image
> > of another disk).  Now, I am running e2fsck and it reports errors:
> 
> Hmm, it looks like this has been broken for a while.  I've done a
> quick look, and it appears this has been the case since e2fsprogs
> 1.28 and this commit:
> 
> commit da307041e75bdf3b24c1eb43132a4f9d8a1b3844
> Author: Theodore Ts'o <tytso@mit.edu>
> Date:   Tue May 21 21:19:14 2002 -0400
> 
>     Check for inodes which are too big (either too many blocks, or
>     would cause i_size to be too big), and offer to truncate the inode.
>     Remove old bogus i_size checks.
>     
>     Add test case which tests e2fsck's handling of large sparse files.
>     Older e2fsck with the old(er) bogus i_size checks didn't handle
>     this correctly.
> 
> I think no one noticed since trying to support files this large on a
> non-extent file is so inefficient and painful that in practice anyone
> trying to use files this large would be using ext4, and not a really
> ancient ext3 file system.
> 
> The fix might be as simple as this, but I haven't had a chance to test
> it and do appropriate regression tests....
> 
> diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
> index eb73922d3..e460a75f4 100644
> --- a/e2fsck/pass1.c
> +++ b/e2fsck/pass1.c
> @@ -3842,7 +3842,7 @@ static int process_block(ext2_filsys fs,
>  		problem = PR_1_TOOBIG_DIR;
>  	if (p->is_dir && p->num_blocks + 1 >= p->max_blocks)
>  		problem = PR_1_TOOBIG_DIR;
> -	if (p->is_reg && p->num_blocks + 1 >= p->max_blocks)
> +	if (p->is_reg && p->num_blocks + 1 >= 1U << 31)

Hmm -- num_blocks is ... the number of "extent records", right?  And on
a !extents file, each block mapped by an {in,}direct block counts as a
separate "extent record", right?

In that case, I think (1U<<31) isn't quite right, because the very large
file could have an ACL block, or (shudder) a "hurd translator block".
So that's (1U<<31) + 2 for !extents files.

For extents files, shouldn't this be (1U<<48) + 2?  Since you /could/
create a horrifingly large extent tree with a hojillion little
fragments, right?  Even if it took a million years to create such a
monster? :)

--D

>  		problem = PR_1_TOOBIG_REG;
>  	if (!p->is_dir && !p->is_reg && blockcnt > 0)
>  		problem = PR_1_TOOBIG_SYMLINK;
> 
> 
> 						- Ted
> 

