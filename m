Return-Path: <linux-ext4+bounces-7083-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F36AA7C1B2
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Apr 2025 18:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2037176008
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Apr 2025 16:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8147821019E;
	Fri,  4 Apr 2025 16:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uc03WWsd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A85D20FAA9
	for <linux-ext4@vger.kernel.org>; Fri,  4 Apr 2025 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743785004; cv=none; b=nN0fIysEK0/GgmHnHNzGl5DtbIYCWperugvnFzidU7l4hNOZq01+WIXQ3dDVzPdDymDRHBSQzoFTZLk+uDRIH0K97KoF+mtDuenBOivjSrscg1jc9pDrnrlD2HE2MoOqqaVi2iD/W+nRPFFQPk2rqwdLzDSXwbjJt0n3YfNBYPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743785004; c=relaxed/simple;
	bh=lV3RQnr83IBrr31/mLHzYUvJkBWX0UHouFGFaMBvfmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f03MgxgBVF+XbRewf8WmNPcHwAr6+HnA7CpjMYc3HK4iV7vatiaTZ7ILqsla+fVKgOqJRxdggWEenf8DyiHPbKagvzdl6arI5qt1ztG6IXPE02Uo+kG/whz3hUOi0vMq0ZfprJDdOl9+TnE2Kb4Gcosa8FRnvDFQxG8fu6qoh8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uc03WWsd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B35EC4CEDD;
	Fri,  4 Apr 2025 16:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743785003;
	bh=lV3RQnr83IBrr31/mLHzYUvJkBWX0UHouFGFaMBvfmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uc03WWsdQQgCQkFnKGs0j/UhmTKV3S7CYHldW7ZJEutj45WY4j39Ad/Y+13LRREvI
	 NLCCcdc6+uNIGXop6nYAvFlkBNza4ZLJI7gkSAN6ECzLhNhJT3FzwDS28/bdbIYRZC
	 nW+i32aTIXxnNsmS43QaHyjI06zuFliVUTfwndea8fUKHZ2H36FFjUEHKQNMKrErFy
	 YMisjk84ZW0U+tQCTALhfI3U1rL9mAhVM1Bsagg9d/y74Qhm0tvumuHC7BOhq3MFzI
	 8zFV7dUdNQMyrD2eJI0aQPE6oe2clXraD43kOERp+P6WhO7Tnr10oewXZjKjY1nDs0
	 TqTrhDIWhvogg==
Date: Fri, 4 Apr 2025 09:43:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Catherine Hoang <catherine.hoang@oracle.com>,
	linux-ext4@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] remove buffer heads from ext2
Message-ID: <20250404164322.GB6307@frogsfrogsfrogs>
References: <20250326014928.61507-1-catherine.hoang@oracle.com>
 <Z-UpSq8jLIUXMf-Z@infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-UpSq8jLIUXMf-Z@infradead.org>

On Thu, Mar 27, 2025 at 03:32:42AM -0700, Christoph Hellwig wrote:
> On Tue, Mar 25, 2025 at 06:49:24PM -0700, Catherine Hoang wrote:
> > Hi all,
> > 
> > This series is an effort to begin removing buffer heads from ext2. 
> 
> Why is that desirable?

struct buffer_head is a mismash of things -- originally it was a landing
place for the old buffer cache, right?  So it has the necessary things
like a pointer to a memory page, the disk address, a length, buffer
state flags (uptodate/dirty), and some locks.  For filesystem metadata
blocks I think that's all that most filesystems really need.  Assuming
that filesystems /never/ want overlapping metadata buffers, I think it's
more efficient to look up buffer objects via an rhashtable instead of
walking the address_space xarray to find a folio, and then walking a
linked list from that folio to find the particular bh.

Unfortunately, it also has a bunch of file mapping state information
(e.g. BH_Delalloc) that aren't needed for caching metadata blocks.  All
the confusion that results from the incohesive mixing of these two
usecases goes away by separating out the metadata buffers into a
separate cache and (ha) leaving the filesystems to port the file IO
paths to iomap.

Separating filesystem metadata buffers into a private datastructure
instead of using the blockdev pagecache also closes off an entire class
of attack surface where evil userspace can wait for a filesystem to load
a metadata block into memory and validate it; and then scribble on the
pagecache block to cause the filesystem driver to make the wrong
decisions -- look at all the ext4 metadata_csum bugs where syzkaller
discovered that the decision to call the crc32c driver was gated on a
bit in a bufferhead, and setting that bit having not initialized the
crc32c driver would lead to a kernel crash.  Nowadays we have
CONFIG_BLK_DEV_WRITE_MOUNTED to shut that down, though it defaults to y
and I think that might actually break leased layout things like pnfs.

So the upsides are: faster lookups, a more cohesive data structure that
only tries to do one thing, and closing attack surfaces.

The downsides: this new buffer cache code still needs: an explicit hook
into the dirty pagecache timeout to start its own writeback; to provide
its own shrinker; and some sort of solution for file mapping metadata so
that fsync can flush just those blocks and not the whole cache.

--D

