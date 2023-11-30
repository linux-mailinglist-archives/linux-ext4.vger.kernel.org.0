Return-Path: <linux-ext4+bounces-226-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A367FE825
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Nov 2023 05:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 323ED1C20BAA
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Nov 2023 04:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E66156E7;
	Thu, 30 Nov 2023 04:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="HPx4i/ge"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47102D5C
	for <linux-ext4@vger.kernel.org>; Wed, 29 Nov 2023 20:07:01 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-111-98.bstnma.fios.verizon.net [173.48.111.98])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3AU46qlJ020706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 23:06:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1701317213; bh=Xsps4n/sMTMzmrMyP3g+fp2MnKRVB+UsMMREoNSvnpc=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=HPx4i/geY+SjpwfkR5NqsHI0kF8HUtDpdfheC/9TOpOhI8pMRPuMg4LZbcSSsjlGD
	 fGjhTQG98O3GZmHjWNTIcmaF1t/qI+vAtkoBNjdEfhDf5yk5ScYHcgkDto8GJmB29k
	 pI2biLKWVw3Z42gd/4Pz0A1uTQdpY1cL91lQeW9TqJUKjV5ImFzxiC9yz3tLFZPaMn
	 /zyqZ8c/yDF6wO9AKUB+xlgh1+e9e8euZXXpFKKjg3muVxF7x/b8k5iIzdOdjeEa6b
	 wr6JQ8oqmGwd65eP5CLWsmwQBuHG2SUv55PuNNQuOzYTl6m8+wJCaGDnOvyYVCjIEJ
	 N8cZAIUQmvqDg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id C8F8815C027C; Wed, 29 Nov 2023 23:06:51 -0500 (EST)
Date: Wed, 29 Nov 2023 23:06:51 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Daniel Dawson <danielcdawson@gmail.com>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [inline_data] ext4: Stale flags before sync when convert to
 non-inline
Message-ID: <20231130040651.GC510020@mit.edu>
References: <5189fe60-c3e3-4bc6-89d4-1033cf4337c3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5189fe60-c3e3-4bc6-89d4-1033cf4337c3@gmail.com>

On Tue, Nov 28, 2023 at 10:15:09PM -0800, Daniel Dawson wrote:
> When a file is converted from inline to non-inline, it has stale flags until
> sync.
> 
> If a file with inline data is written to such that it must become
> non-inline, it temporarily appears to have the inline data flag and not (if
> applicable) the extent flag. This is corrected on sync, but can cause
> problems in certain situations.

The issue here is delayed allocation.  When you write to a file with
delayed allocation enabled, the file system doesn't decide where the
data will be written on the storage device until the last possible
minute, when writeback occurs.  This can be triggered by a fsync(2) or
sync(2) system call,

> Why is this a problem? Because some code will fail under such a condition,
> for example, lseek(..., SEEK_HOLE) will result in ENOENT. I ran into this
> with Gentoo's Portage, which uses the call to handle sparse files when
> copying. Sometimes, an ebuild creates a temporary file that is quickly
> copied, and apparently the temporary is written in small increments,
> triggering this.

This is caused by missing logic in ext4_iomap_begin_report().  For the
non-inline case, this function does this:

	ret = ext4_map_blocks(NULL, inode, &map, 0);
	if (ret < 0)
		return ret;
	if (ret == 0)
		delalloc = ext4_iomap_is_delalloc(inode, &map);

For a non-inline file, if you write some data blocks that hasn't been
written back due to delayed allocation, ext4_map_blocks() won't be
able to map the logical block to a physical block.  This logic is
missing in the inline_data case:

	if (ext4_has_inline_data(inode)) {
		ret = ext4_inline_data_iomap(inode, iomap);
		if (ret != -EAGAIN) {
			if (ret == 0 && offset >= iomap->length)
				ret = -ENOENT;
			return ret;
		}
	}

What's missing is a call to ext4_iomap_is_delalloc() in the case where
ret == 0, and then setting the delayed allocation flag:

	if (delalloc && iomap->type == IOMAP_HOLE)
		iomap->type = IOMAP_DELALLOC;

This will deal with the combination of inline_data and delayed
allocation for SEEK_HOLE and for FIEMAP.

I'll need to turn this into an actual patch and then create a test to
validate the patch but I'm pretty sure this should deal with the
problem you've come across.

Cheers,

						- Ted

