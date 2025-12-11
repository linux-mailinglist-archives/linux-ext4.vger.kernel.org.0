Return-Path: <linux-ext4+bounces-12286-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E44FCB4B37
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 05:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBA113009572
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 04:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456A0279DB7;
	Thu, 11 Dec 2025 04:57:32 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14181272E45;
	Thu, 11 Dec 2025 04:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765429052; cv=none; b=spURbMlpB2i+WiocAy/d9RnUTeIUA1VMCv0JZ2maE9KSMfai4kxMiDkhsfjNiw8Y0mjo+1ROfOK23l/WaqcQVMsqZWLFnGA7hUyZxQlT8rInelXF9LaKIRNDqyltzZReXuJ+z00nw7edvOAiQwzVhwdUGFo5NpKCpkjPtYA94Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765429052; c=relaxed/simple;
	bh=ITnMn4UEwfAoOCkOEWAg5gwZfcjPp5kmLgF606juggY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p59bEA8YwYbI1/OLhDgsptF9z5FxZ/uswkXQiKfWB4VOI42bd81W3x38g0LMi4b5OFB09P5EnYI3/L09T/mujhvCE1QzHx4WDsiDNv+zCcJW9CIQnxWnHCy/HXYLM87pEkk4EwDl6XAZRrc3ZdELAxikd3XtyUjzYHb5mlF9w0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 50FE3227A87; Thu, 11 Dec 2025 05:57:25 +0100 (CET)
Date: Thu, 11 Dec 2025 05:57:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Zorro Lang <zlang@kernel.org>,
	Anand Jain <anand.jain@oracle.com>,
	Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 10/12] xfs/528: require a real SCRATCH_RTDEV
Message-ID: <20251211045724.GD26257@lst.de>
References: <20251210054831.3469261-1-hch@lst.de> <20251210054831.3469261-11-hch@lst.de> <20251210195220.GD94594@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210195220.GD94594@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Dec 10, 2025 at 11:52:20AM -0800, Darrick J. Wong wrote:
> >  	log "Format rtextsize=$rextsize"
> > -	_scratch_unmount
> >  	_scratch_mkfs -r extsize=$rextsize >> $seqres.full
> >  	_try_scratch_mount || \
> >  		_notrun "Could not mount rextsize=$rextsize with synthetic rt volume"
> > @@ -150,30 +138,16 @@ test_ops() {
> >  	check_file $SCRATCH_MNT/lpunch
> >  
> >  	log "Check everything, rextsize=$rextsize"
> > +	_scratch_unmount
> >  	_check_scratch_fs
> 
> Why does _scratch_unmount move to this part of the loop?  Unmounting the
> filesystem means that _check_xfs_filesystem won't run xfs_scrub on it.
> 
> (Everything else looks ok.)

Because it now it also is mounted inside the loop and not before the
loop, so unmounting it in the beginning won't work.  But I'll sort out
the order vs _check_scratch_fs.


