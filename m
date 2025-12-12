Return-Path: <linux-ext4+bounces-12334-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BFDCB9B84
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 21:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DDE130A2994
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 20:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE8D2D8783;
	Fri, 12 Dec 2025 20:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YP/KVItp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F19427B34D;
	Fri, 12 Dec 2025 20:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765569624; cv=none; b=YjmFm7HZHv4kUIfCAd6RdkH4QjSIiq4M+u3nbT6mD76by9NIF7SFbk0kXAjGI+pWvBqxjF8FkJawu4Nc9V6EcdpugMwIShK6maU2m2ObNirBu7at4MMzU+QHYs2QTyaRarB4K2MFCsNoJubaLW+65/eIopWrsHXeTdt6UPgqa+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765569624; c=relaxed/simple;
	bh=yF13ZhuvRrDqS/1zJDVq2wFl51VakdHaLcvKg9eITsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUlh9/KdvjxmeDULjQRNxCLs7VtTN2UThrCyHSa0/CpuXbhoA2sMX6JkDQ8cFOUXYqqx0fwmpNu/NVQ3uFGx6Si3M5BtHvccno+4iUHf9f5xswLmRRCivtGxinkeHwe13dJ+kIKXdq6MNGgHHmsDK0CN5VHFiIVygzp1pJF5nic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YP/KVItp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F41C4CEF1;
	Fri, 12 Dec 2025 20:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765569623;
	bh=yF13ZhuvRrDqS/1zJDVq2wFl51VakdHaLcvKg9eITsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YP/KVItpfpBHL5BrrJvPY0abKPx3QwP7a80XSCJXMIGkOlJ7ORAvxdlpdPjWx08yE
	 jU2whLKsBww3X88VySYymtvj3+kvwJk8OHHdJk7KTE+Kknky8ftrPxUbCBKgu4ykXC
	 1gq1ZeCbJ4U4vu0lrA089+zSLDklQC/zQPHR9D50SWJ1kKAdexTm67/OMrBm/6rGuo
	 evN38NMdEv7FNJrC9cOxEEmSSkRdEzh8gy6CahhwwOx0WMbXk66HFMQHrrSsF1ZXND
	 rw1sHBtpVEp8FwtVVLLmt5Y4bQn8qLJ2GCdE8QJezDgQCuQAB3qvTC7NAxADFxsUXl
	 ruOlL1Sh0jNAg==
Date: Fri, 12 Dec 2025 12:00:22 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, Anand Jain <anand.jain@oracle.com>,
	Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 11/12] xfs/530: require a real SCRATCH_RTDEV
Message-ID: <20251212200022.GF7725@frogsfrogsfrogs>
References: <20251210054831.3469261-1-hch@lst.de>
 <20251210054831.3469261-12-hch@lst.de>
 <20251210194948.GC94594@frogsfrogsfrogs>
 <20251211045504.GC26257@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211045504.GC26257@lst.de>

On Thu, Dec 11, 2025 at 05:55:04AM +0100, Christoph Hellwig wrote:
> On Wed, Dec 10, 2025 at 11:49:48AM -0800, Darrick J. Wong wrote:
> > > +$XFS_GROWFS_PROG -R $((rtdevsize / fsbsize)) $SCRATCH_MNT \
> > 
> > Why doesn't growfs -r still work here?
> 
> growfs -r still works, but the golden output expects a specific size.
> So if we want to use use that we'd need to drop the gold output checking
> for a specific new capacity.

Got it, thanks.

--D

