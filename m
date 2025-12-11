Return-Path: <linux-ext4+bounces-12284-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD76ACB4B1F
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 05:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13F6B3008FAC
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 04:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9649A270553;
	Thu, 11 Dec 2025 04:54:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0C523EA93;
	Thu, 11 Dec 2025 04:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765428845; cv=none; b=nKLFL9lY3RK+ywRh4G0PZeRJDXNYFADoXA2B1wE+13kgjm7zp9NbhzahMtDvdoL/x4ejMV0MWdftaVQ90GoiKmnRPFQNbyNC1cMMJXLiUg/G1BtgnHGq20hrBNYc2Ktt4kZkxIYn+6WsFVWSRVjHHG+IztVDEbSlskv+KcKc4Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765428845; c=relaxed/simple;
	bh=BIP1AeZ/hd1sD+EPCPVGpDZLrZDZCsOr8lX/zEuKD+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4XUon3XRJsGMqqn04c1htFj3RpZPCkE3nuboVeEl0vBlaisrs0oy8GPXEE3kgJ8qeDJuyHFj5jU+bocivvwZzWp8gyUlU6yWCC25PPVJC7GVhgOvFysbiQ5iuBMJYEwy/7Zgpdttj2dke9FCVneUnoSJ+83cm9MR12eI87Lsew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3B5BD227A87; Thu, 11 Dec 2025 05:54:00 +0100 (CET)
Date: Thu, 11 Dec 2025 05:54:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Zorro Lang <zlang@kernel.org>,
	Anand Jain <anand.jain@oracle.com>,
	Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 12/12] xfs/650:  require a real SCRATCH_RTDEV
Message-ID: <20251211045400.GB26257@lst.de>
References: <20251210054831.3469261-1-hch@lst.de> <20251210054831.3469261-13-hch@lst.de> <20251210194549.GB94594@frogsfrogsfrogs> <20251210225043.GI94594@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210225043.GI94594@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Dec 10, 2025 at 02:50:43PM -0800, Darrick J. Wong wrote:
> Aha, I missed that an earlier patch created it. :(
> 
> The one downside to not injecting a rt device here is that now the only
> testing for the actual bug is if you happen to have rt enabled.  That
> used to be a concern of mine, but maybe between you, me, Meta, and the
> kdevops folks there's enough now.

I guess that was the reason to create it, but on the other hand injecting
new devices is a mess.  One option would be to totally inject the devices,
but that requires a lot of boilerplate as done in the labelling test.

So I think the concept of "you need a RT device to test RT specific
code" should be ok, even if your concern is real.


