Return-Path: <linux-ext4+bounces-12285-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D04CB4B22
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 05:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBE80300CAE7
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 04:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1377274FDB;
	Thu, 11 Dec 2025 04:55:09 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96EF1A9F9B;
	Thu, 11 Dec 2025 04:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765428909; cv=none; b=rXZvTw9hm9MjSsHabPIBU+u6xRme9VKJ7fyrGKjM84BnoqnUQUFI+JOs+AcCskH2CJkfA+9f74IUiTAyCtNZaDtWV5BuoJfAwH8dxWohvKSvOoAJQaodNSuN3828M2NFQ+iaWWnBl8eb5KUNBCzxDkccvvbwkS9ne+F8bEC6wns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765428909; c=relaxed/simple;
	bh=5MIpaEzMJzj6w9boMhIYhPQ093INhCrg4TmsXbjfozI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJQ/UEv4j4UaZccpDcoqTA3ZTLooe1mhkzUWSCLzLtKWIm0IZu2YdkqCNZdXReKjEzVKfL5bUl4WLJHxt8Yln0NfsrQJNEqgSbaGSGw4wA3Lb+ROZcUOYu2GQ8YbD9cUXlNO2/lzhY4hH7gIJWNZ3hP+6zhchs5CG5KVmj02oZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0FC73227A87; Thu, 11 Dec 2025 05:55:05 +0100 (CET)
Date: Thu, 11 Dec 2025 05:55:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Zorro Lang <zlang@kernel.org>,
	Anand Jain <anand.jain@oracle.com>,
	Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 11/12] xfs/530: require a real SCRATCH_RTDEV
Message-ID: <20251211045504.GC26257@lst.de>
References: <20251210054831.3469261-1-hch@lst.de> <20251210054831.3469261-12-hch@lst.de> <20251210194948.GC94594@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210194948.GC94594@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Dec 10, 2025 at 11:49:48AM -0800, Darrick J. Wong wrote:
> > +$XFS_GROWFS_PROG -R $((rtdevsize / fsbsize)) $SCRATCH_MNT \
> 
> Why doesn't growfs -r still work here?

growfs -r still works, but the golden output expects a specific size.
So if we want to use use that we'd need to drop the gold output checking
for a specific new capacity.


