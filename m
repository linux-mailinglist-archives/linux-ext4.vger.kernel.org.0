Return-Path: <linux-ext4+bounces-7090-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5785FA7E796
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Apr 2025 19:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233ED188ED0D
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Apr 2025 16:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EE5215769;
	Mon,  7 Apr 2025 16:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYnExifR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92C3215760
	for <linux-ext4@vger.kernel.org>; Mon,  7 Apr 2025 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744044851; cv=none; b=YGQKw9qQUR43qdcinXMcf1MVpjWP0+jhJ7uBdq7J52eHPtbPEyA29TOF3KxDibKpseql3/2iEY1RZ3gwijBEi7eEqkS4hp9dKmBbJY3zFplukgykW6skh1Q/XXNcDbcHzP5COZ/qdASmDsy5RBIKEsXuU4Ut3ENGpNdbPqjkNYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744044851; c=relaxed/simple;
	bh=dgr9J0K/CqGr2SAlhwinuIlXx9KPijFCFY7bsPr3vvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUNAPcV//plwj5u929cCIz3opFAzsjGbh4In9OFYRSaMgF7EOyNzrq+92ZIXNLhWD/sPie6BdKO1C6TkRD0txjH9SK3UPA1h62Hqa0iPZRzjcN835EO+D20Zm4zEdbE0KhJd7i47qg8hxfgetdTh0khn/2sM3rgkzq+5Mtebzxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYnExifR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07B5C4CEDD;
	Mon,  7 Apr 2025 16:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744044851;
	bh=dgr9J0K/CqGr2SAlhwinuIlXx9KPijFCFY7bsPr3vvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dYnExifROPFlqdBhQFqCV0cAqt/ATNFp1ybR0RNOBZ4ey38qkJS4FMjQthsI0WTMM
	 q5TwPqgie8RXr+f35LgvuWaTeNMcltV9YW9+2aZsOL/AGP0apzYmUG+rYTCcfv4r8X
	 yukZtCDJ8FELb09KNEPxwhQjv2nVuCm5Flxbd3kYoF7YNWb+UJowkgqJd9sXMz2YzL
	 NBdzpvtna3YnMnxYJ5ggC+05uaE25jX/463e+VWQM6t1oxjtrJmHOH42rMwJNbJJfl
	 OkFQkUsfvH/AXLXElbkl5Tudk014eQswGIOWQVcPg2GP3eSKDZxNBPOzjZGhBL84r5
	 YrZramhxwoQxQ==
Date: Mon, 7 Apr 2025 09:54:11 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Catherine Hoang <catherine.hoang@oracle.com>,
	linux-ext4@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] remove buffer heads from ext2
Message-ID: <20250407165411.GA6262@frogsfrogsfrogs>
References: <20250326014928.61507-1-catherine.hoang@oracle.com>
 <Z-UpSq8jLIUXMf-Z@infradead.org>
 <20250404164322.GB6307@frogsfrogsfrogs>
 <Z_NvxebhNgXSIWkQ@infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_NvxebhNgXSIWkQ@infradead.org>

On Sun, Apr 06, 2025 at 11:25:09PM -0700, Christoph Hellwig wrote:
> On Fri, Apr 04, 2025 at 09:43:22AM -0700, Darrick J. Wong wrote:
> > On Thu, Mar 27, 2025 at 03:32:42AM -0700, Christoph Hellwig wrote:
> > > On Tue, Mar 25, 2025 at 06:49:24PM -0700, Catherine Hoang wrote:
> > > > Hi all,
> > > > 
> > > > This series is an effort to begin removing buffer heads from ext2. 
> > > 
> > > Why is that desirable?
> > 
> > struct buffer_head is a mismash of things -- originally it was a landing
> > place for the old buffer cache, right?
> 
> Yes.
> 
> > So it has the necessary things
> > like a pointer to a memory page, the disk address, a length, buffer
> > state flags (uptodate/dirty), and some locks.
> 
> Yes. (although the page to folio migration is almost done).

Yeah, now that your folio conversion has landed for xfs_buf, Catherine
should crib your implementation into this one.  Though at least ext2
doesn't have all the discontiguous multi-fsblock stuff to deal with.

> > For filesystem metadata
> > blocks I think that's all that most filesystems really need.
> 
> Yes.
> 
> > Assuming
> > that filesystems /never/ want overlapping metadata buffers, I think it's
> > more efficient to look up buffer objects via an rhashtable instead of
> > walking the address_space xarray to find a folio, and then walking a
> > linked list from that folio to find the particular bh.
> 
> Probably.  But does it make a practical difference for ext2?

Not really, ext2 is just the test vehicle for getting this going.

> > Unfortunately, it also has a bunch of file mapping state information
> > (e.g. BH_Delalloc) that aren't needed for caching metadata blocks.  All
> > the confusion that results from the incohesive mixing of these two
> > usecases goes away by separating out the metadata buffers into a
> > separate cache and (ha) leaving the filesystems to port the file IO
> > paths to iomap.
> 
> Exactly.
> 
> > Separating filesystem metadata buffers into a private datastructure
> > instead of using the blockdev pagecache also closes off an entire class
> > of attack surface where evil userspace can wait for a filesystem to load
> > a metadata block into memory and validate it;
> 
> It does close that window.  OTOH that behavior has traditionally been
> expected very much for extN for use with some tools (IIRC tunefs), so
> changing that would actually break existing userspace.

Ted at least would like to get rid of tune2fs' scribbling on the block
device.  It's really gross in ext4 since tune2fs can race with the
kernel to update sb fields and recalculate the checksum.

> > and then scribble on the
> > pagecache block to cause the filesystem driver to make the wrong
> > decisions -- look at all the ext4 metadata_csum bugs where syzkaller
> > discovered that the decision to call the crc32c driver was gated on a
> > bit in a bufferhead, and setting that bit having not initialized the
> > crc32c driver would lead to a kernel crash.  Nowadays we have
> > CONFIG_BLK_DEV_WRITE_MOUNTED to shut that down, though it defaults to y
> > and I think that might actually break leased layout things like pnfs.
> 
> pNFS scsi/nvme only works for remote nodes, so it's not affected by
> this.  The block layout could theoretically work locally, but it's
> a pretty broken protocol to start with.

Ah.

> > So the upsides are: faster lookups, a more cohesive data structure that
> > only tries to do one thing, and closing attack surfaces.
> > 
> > The downsides: this new buffer cache code still needs: an explicit hook
> > into the dirty pagecache timeout to start its own writeback; to provide
> > its own shrinker; and some sort of solution for file mapping metadata so
> > that fsync can flush just those blocks and not the whole cache.
> 
> The other major downside is instead of one maintained code base we now
> have one per file system.  That's probably okay for well maintained
> file systems with somewhat special needs (say btrfs or xfs), but I'd
> rather not have that for every misc file system using buffer_heads
> right now.
> 
> So if we want to reduce problems with buffer_heads I'd much rather see
> all data path usage go away ASAP.  After that the weird entanglement
> with jbd2 would be the next step (and maybe a private buffer cache for
> ext4/gfs2 is the answer there).  But copy and pasting a new buffer cache
> into simple and barely maintained file systems like ext2 feels at least
> a bit questionable.

The next step is to yank all that code up to fs/ and port another
filesystem (e.g. fat) to it.  But let's let Catherine get it working for
all the metadata types within the confines of ext2.

--D

