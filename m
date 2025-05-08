Return-Path: <linux-ext4+bounces-7767-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0604FAAFF2C
	for <lists+linux-ext4@lfdr.de>; Thu,  8 May 2025 17:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEE807B3CCE
	for <lists+linux-ext4@lfdr.de>; Thu,  8 May 2025 15:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AE72797B2;
	Thu,  8 May 2025 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGEeb3U+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3EA278E6F
	for <linux-ext4@vger.kernel.org>; Thu,  8 May 2025 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746717558; cv=none; b=D+dhXrGqHToNhP78ij2C/HTofEubr7OnjhhaDIdIl/SWRPNyGeSDL3M4l2/pvW+qcCxI/Zz+EEGz1mEqPaOsQN0LrzxhF48ne9u73BsG2GvHv4zikOwLUYkqryKIfAWf5Kl5dQtIWUqJIBcSnzP9bXNx4bxMGyAiH9WjZNXHoHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746717558; c=relaxed/simple;
	bh=zPGP8dTT8biYswrCSlgaVLuvzfvQB7BoRaB1PwCJm7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvP0l48WnquTla309emYkmuKi+8xuiSPzp2kj/E9fcP7otjmkFrrw66SiLsMcHvHNP3i4kkysy1ib/PuzKJH2eHKXKQeIraaMlJDDkm7S+cXbAD30Gl9aWFgid9nnvbtbkmK3TaduXfnZkuMM6+uiCrRuaKV9a0M0JDkuZ9RuYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGEeb3U+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FD0C4CEE7;
	Thu,  8 May 2025 15:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746717557;
	bh=zPGP8dTT8biYswrCSlgaVLuvzfvQB7BoRaB1PwCJm7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CGEeb3U+iRziCEYcyGJVDGgvmzkENudt6h1xITnRB8OsB5hAzdZyIerU8VyuG+s/H
	 9II7erTmTWFqfB+/IbuKcAjSEY5cWklSRpW9JHkFcr4v/MfggWXGYHwROofwbzONCz
	 xc++LLuSXhbtfG6b9aBgKmvab1nP4Isjr3ukXWbB6/oy7mV0gzby+gBAC42do/yxc+
	 bFQdP2yFNccuQb8wU2sBHYFYb6xu6S6fwRBIGkkqcNJl5+PLcwI/hFl/9IbRw8n2uU
	 AKpl/Hq/QCJEa/fq9c98TwXOKUPZ6ayiUnkBTBpp/DS8HZopCUrA+zpoa944EWp9Tw
	 dtqtw5/4AUGKg==
Date: Thu, 8 May 2025 08:19:17 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: John Garry <john.g.garry@oracle.com>, Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>, Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-ext4@vger.kernel.org
Subject: Re: [RFC v2 0/2] ext4: Add multi-fsblock atomic write support using
 bigalloc
Message-ID: <20250508151917.GD25700@frogsfrogsfrogs>
References: <cover.1745987268.git.ritesh.list@gmail.com>
 <d031d255-b528-4870-b933-475b969aabdf@oracle.com>
 <878qn7gogg.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qn7gogg.fsf@gmail.com>

On Thu, May 08, 2025 at 08:05:27PM +0530, Ritesh Harjani wrote:
> John Garry <john.g.garry@oracle.com> writes:
> 
> > On 30/04/2025 06:20, Ritesh Harjani (IBM) wrote:
> >> This is still an early preview (RFC v2) of multi-fsblock atomic write. Since the
> >> core design of the feature looks ready, wanted to post this for some early
> >> feedback. We will break this into more smaller and meaningful patches in later
> >> revision. However to simplify the review of the core design changes, this
> >> version is limited to just two patches. Individual patches might have more
> >> details in the commit msg.
> >> 
> >> Note: This overall needs more careful review (other than the core design) which
> >> I will be doing in parallel. However it would be helpful if one can provide any
> >> feedback on the core design changes. Specially around ext4_iomap_alloc()
> >> changes, ->end_io() changes and a new get block flag
> >> EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS.
> >
> > I gave this a try and it looks ok, specifically atomic writing mixed 
> > mappings.
> >
> 
> Thanks John for taking a look.
> 
> > I'll try to look closer that the implementation details.
> 
> We are in the process of sending v3 (hopefully by tonight) which is an
> improved version w.r.t error handling, journal credits and few other
> changes. Although nothing has changed w.r.t the design aspect.
> 
> > But I do note 
> > that you use blkdev_issue_zeroout() to pre-zero any unwritten range 
> > which is being atomically written.
> 
> Yes, that is how internally ext4_map_blocks() with
> EXT4_GET_BLOCKS_CREATE_ZERO will return us the allocated blocks. During
> block allocation, on mixed mapping range, we ensure that the entire range
> becomes a contiguous mapped extent before starting any data writes.
> That means calling ext4_map_blocks() in a loop with
> EXT4_GET_BLOCKS_CREATE_ZERO, so that it can zero out any unwritten
> extents in the requested region.
> I assume writing over a mixed mapping region is not a performance
> critical path. 
> 
> Do you forsee any problems with the approach (since you said "But I do note...")?

It's a little dumb to write zeroes just so you can atomicwrite a block.
However, ext4 lacks an out of place write handler, so I don't think
there's much else that can be done easily.

--D

> -ritesh

