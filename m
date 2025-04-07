Return-Path: <linux-ext4+bounces-7085-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C355A7D3F4
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Apr 2025 08:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA05169BEE
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Apr 2025 06:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4795224B1E;
	Mon,  7 Apr 2025 06:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XmvEwK3C"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649AF224B14
	for <linux-ext4@vger.kernel.org>; Mon,  7 Apr 2025 06:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744007116; cv=none; b=QguhkFXI407jhTlI7hj/AqTyyPA/ZJozuh3C/DojjzqXIJ6hG7GLy3XR5lgmDYbiUhSLdWfuIZVtMnUwEwKPDQ8BuNTGtLXN4FjsF56E3mrilDM9rCiy1+xner7mQc8PVcVcJ+Hb/zL9GSDAss5spkC64UQFtl6r4a9nKlRDWsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744007116; c=relaxed/simple;
	bh=yGykrx+keMaD0trFbufW1ZmTQATCQCGPzQfRx4P9v/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAsYzPxwQSRJFbNk5gJk5XmMi+DAlFIFvg0Veh9jOF1GC75lmJdWa1lq0Du9iFF915ltlKghgTejHmx1329zNHyA5Bq/tJDKOCA2IWlPiU09cZtllH47BqXJGU2Lqce18XVvkcUjPkZ7IC++ythLrW5aFR+RC2hLr/fTRsnDS20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XmvEwK3C; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bvHxt9dsvhwTb3/2nb7chAj5q6wMKV2kmIdkROSZ6z4=; b=XmvEwK3Cn9ALM9EbjacJXs0owo
	UmodIGRJBatR3SFwI9+ofaSfrlpaa3r/4l0UP92HygyodNwW0AuQFJL4sKeeoItHoxug5rjB+bU2q
	yqEZ599IhYUeOVTG5CEdGUSP9KuCzIK6MuluRCmGeNS0kmM/dGCn+ElZdZCVNevvNUMP9rmczt1X4
	hb/hkxMBC41Z1GSPlsTts7ihqYzqUI59HJ2v9cXNAsCMU1keQdBmw0AKM8NuMn2lxiacmkIBcPsYu
	8S/Ie0gxmgjt1FJfDclteyLsgBiN4VFGMpT8y87RXZAYtHWv+vNEF7MtXilWhRw3PBT1bkiEI8zBF
	5ny5NWaA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1fuv-0000000GYwN-3v27;
	Mon, 07 Apr 2025 06:25:09 +0000
Date: Sun, 6 Apr 2025 23:25:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Catherine Hoang <catherine.hoang@oracle.com>,
	linux-ext4@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] remove buffer heads from ext2
Message-ID: <Z_NvxebhNgXSIWkQ@infradead.org>
References: <20250326014928.61507-1-catherine.hoang@oracle.com>
 <Z-UpSq8jLIUXMf-Z@infradead.org>
 <20250404164322.GB6307@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404164322.GB6307@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Apr 04, 2025 at 09:43:22AM -0700, Darrick J. Wong wrote:
> On Thu, Mar 27, 2025 at 03:32:42AM -0700, Christoph Hellwig wrote:
> > On Tue, Mar 25, 2025 at 06:49:24PM -0700, Catherine Hoang wrote:
> > > Hi all,
> > > 
> > > This series is an effort to begin removing buffer heads from ext2. 
> > 
> > Why is that desirable?
> 
> struct buffer_head is a mismash of things -- originally it was a landing
> place for the old buffer cache, right?

Yes.

> So it has the necessary things
> like a pointer to a memory page, the disk address, a length, buffer
> state flags (uptodate/dirty), and some locks.

Yes. (although the page to folio migration is almost done).

> For filesystem metadata
> blocks I think that's all that most filesystems really need.

Yes.

> Assuming
> that filesystems /never/ want overlapping metadata buffers, I think it's
> more efficient to look up buffer objects via an rhashtable instead of
> walking the address_space xarray to find a folio, and then walking a
> linked list from that folio to find the particular bh.

Probably.  But does it make a practical difference for ext2?

> Unfortunately, it also has a bunch of file mapping state information
> (e.g. BH_Delalloc) that aren't needed for caching metadata blocks.  All
> the confusion that results from the incohesive mixing of these two
> usecases goes away by separating out the metadata buffers into a
> separate cache and (ha) leaving the filesystems to port the file IO
> paths to iomap.

Exactly.

> Separating filesystem metadata buffers into a private datastructure
> instead of using the blockdev pagecache also closes off an entire class
> of attack surface where evil userspace can wait for a filesystem to load
> a metadata block into memory and validate it;

It does close that window.  OTOH that behavior has traditionally been
expected very much for extN for use with some tools (IIRC tunefs), so
changing that would actually break existing userspace.

> and then scribble on the
> pagecache block to cause the filesystem driver to make the wrong
> decisions -- look at all the ext4 metadata_csum bugs where syzkaller
> discovered that the decision to call the crc32c driver was gated on a
> bit in a bufferhead, and setting that bit having not initialized the
> crc32c driver would lead to a kernel crash.  Nowadays we have
> CONFIG_BLK_DEV_WRITE_MOUNTED to shut that down, though it defaults to y
> and I think that might actually break leased layout things like pnfs.

pNFS scsi/nvme only works for remote nodes, so it's not affected by
this.  The block layout could theoretically work locally, but it's
a pretty broken protocol to start with.

> So the upsides are: faster lookups, a more cohesive data structure that
> only tries to do one thing, and closing attack surfaces.
> 
> The downsides: this new buffer cache code still needs: an explicit hook
> into the dirty pagecache timeout to start its own writeback; to provide
> its own shrinker; and some sort of solution for file mapping metadata so
> that fsync can flush just those blocks and not the whole cache.

The other major downside is instead of one maintained code base we now
have one per file system.  That's probably okay for well maintained
file systems with somewhat special needs (say btrfs or xfs), but I'd
rather not have that for every misc file system using buffer_heads
right now.

So if we want to reduce problems with buffer_heads I'd much rather see
all data path usage go away ASAP.  After that the weird entanglement
with jbd2 would be the next step (and maybe a private buffer cache for
ext4/gfs2 is the answer there).  But copy and pasting a new buffer cache
into simple and barely maintained file systems like ext2 feels at least
a bit questionable.


