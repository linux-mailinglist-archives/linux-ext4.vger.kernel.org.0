Return-Path: <linux-ext4+bounces-8899-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A32AFDCCB
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Jul 2025 03:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD20E1BC806B
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Jul 2025 01:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9571514E4;
	Wed,  9 Jul 2025 01:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UhSl7kPe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02EC26290;
	Wed,  9 Jul 2025 01:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752023625; cv=none; b=mey4HguE3sUvXTQKg/L7M4UVWJFNJjQXqilRhpDXBm4YD/MIfRcWmqViQn/rmlR2qD4bq+LPFrQ93S2KjwkKc5NqU1ElXIHMhAHKeZSN+gV7kFA6NhKdHAecYsxZ0h4/Lt+Ib/5eyLsuIYwNKyS/r3G4BBzyhnFFDTjLexSKZpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752023625; c=relaxed/simple;
	bh=rLljmfQ+Dh78X1UmJ3f7KKQyZnFs632DgJ+Uzdz30cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUuixtfPoGh2dHR4cV9PFPvJqih4pZcIzUpgmzTxPrrPZmqKKVXgJsVg1vbmDtLVTIZnr7q53e+36RtVSe9YDhnDR65RNeP9zG1DRm9CabPk7IbuZ9gGmx2HdtgNkzO3G8SI/VAmQJgo2GZfenhuIDfyoUi1gkFZrPIGZpN1F3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UhSl7kPe; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 8 Jul 2025 21:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752023610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cy2fv3s6ERO5d4cU+IzLOG038BuHbFit+Fwtwintg6A=;
	b=UhSl7kPeAE9NdrlN6dm0fuhSYJ+U/aw9XBq4CN7FGW9Phojz8I1CGRLbLw8wleVPz5RQHI
	5HbOIc7YTA8sPAuR3KhNCRrnFyl/8xtzRiOj7LAuxJ4uH51PZVZdOGEAm0yLDs3pWF5hsV
	wcT3hxFix0OyWJnAqgDKJsCyzR7eNb8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Dave Chinner <david@fromorbit.com>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Qu Wenruo <wqu@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	jack@suse.cz, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v4 1/6] fs: enhance and rename shutdown() callback to
 remove_bdev()
Message-ID: <c6zp6k7ozn7idiyt4shxhwwe2hoprkgdzq66eau5w4jlgbuwta@od2atq4kexoj>
References: <cover.1751589725.git.wqu@suse.com>
 <de25bbdb572c75df38b1002d3779bf19e3ad0ff6.1751589725.git.wqu@suse.com>
 <aGxSHKeyldrR1Q0T@dread.disaster.area>
 <dbd955f7-b9b4-402f-97bf-6b38f0c3237e@gmx.com>
 <20250708004532.GA2672018@frogsfrogsfrogs>
 <20250708-geahndet-rohmaterial-0419fd6a76b3@brauner>
 <aG2i3qP01m-vmFVE@dread.disaster.area>
 <00f5c2a2-4216-4eeb-b555-ef49f8cfd447@gmx.com>
 <lcbj2r4etktljckyv3q4mgryvwqsbl7pwe6sqdtyfwgmunhkov@4oinzvvnt44s>
 <eb7c3b1c-b5c0-4078-9a88-327f1220cae8@gmx.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb7c3b1c-b5c0-4078-9a88-327f1220cae8@gmx.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 09, 2025 at 10:25:08AM +0930, Qu Wenruo wrote:
> 在 2025/7/9 10:05, Kent Overstreet 写道:
> > Consider that the thing that has a block device open might not even be a
> > filesystem, or at least a VFS filesystem.
> > 
> > It could be a stacking block device driver - md or md - and those
> > absolutely should be implementing .mark_dead() (likely passing it
> > through on up the stack), or something else entirely.
> > 
> > In bcachefs's case, we might not even have created the VFS super_block
> > yet: we don't do that until after recovery finishes, and indeed we can't
> > because creating a super_block and leaving it in !SB_BORN will cause
> > such fun as sync calls to hang for the entire system...
> > 
> 
> Not related to the series, but IIRC if s_flags doesn't have SB_ACTIVE set,
> things like bdev_super_lock() won't choose that superblock, thus won't call
> ->sync() callback through the bdev callbacks.
> 
> And btrfs also follows the same scheme, only setting SB_ACTIVE after
> everything is done (including replaying the log etc), and so far we haven't
> yet hit such sync during mount.

Well, how long can that take? Have a look at iterate_supers(), it's
something to be wary of.

Fixing the fs/super.c locking is something I was looking at, it's doable
but it'd be a giant hassle - for bcachefs it wasn't worth it, bcachefs
has preexisting reasons for wanting to avoid the vfs superblock
dependency.

Anyways - the VFS trying to own .mark_dead() is a layering violation.

        VFS
------------------
        FS
------------------
        BLOCK

By default, the "FS" layer should be considered a black box by both the
block layer and VFS; reaching across that and assuming filesystem
behavior is a good way to paint yourself into a corner.

It's seductive because most filesystems are single device filesystems,
and for that case it makes total sense to provide helpers for
convenience, given that there's not much room for behaviour to deviate
in the single device case.

But in the multi device case: the behaviour is completely up to the
filesystem - in general we don't shut down the entire filesystem if a
single block device goes dead, if we're redundant we can just drop that
device and continue.

And if you're thinking you want to make use of locking provided by the
VFS - I would warn away from that line of thinking too, mixing up
locking from different layers creates all sorts of fun...

