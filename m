Return-Path: <linux-ext4+bounces-12287-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E21B5CB4B40
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 05:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1EE93009572
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 04:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE3328151C;
	Thu, 11 Dec 2025 04:58:43 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D023018FDDB;
	Thu, 11 Dec 2025 04:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765429123; cv=none; b=rZQrQ1QRSUmMEYvweIw6L/ENnyeNOH4PjPaRnisxe3lJmXmVBnFeW1CVXehIBVDu9WCboFYg1yf0au0cgWQ70sFsyrCel6y/5yvpj8rEml8TJXxorj6aSqYK/SHsuTzbpzrO6PdY0tmc1l+9jOubxdjHrARB5Xb6/fsiIGLrWyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765429123; c=relaxed/simple;
	bh=6mR0WlYXIe/ihckCsAwmPgD3dNssZNqavGhTve/44A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mW375wkh+dtX/5R6EMnEkhvacRDmxAwgmKIzV1NIgOoRw4sbXimowpZWrtY1/H/qVFvBt2/0oI/U9iRtOqEz15te0vrASqD+P+gxYTV0tSjDHFt1vhB1BBaUGa+mBkeuW6K7pMJTErtMJIOlq4GX8QwXBD3xBFUBUtbNuGesDAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D09E9227A87; Thu, 11 Dec 2025 05:58:38 +0100 (CET)
Date: Thu, 11 Dec 2025 05:58:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Zorro Lang <zlang@kernel.org>,
	Anand Jain <anand.jain@oracle.com>,
	Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 09/12] xfs/521: require a real SCRATCH_RTDEV
Message-ID: <20251211045838.GE26257@lst.de>
References: <20251210054831.3469261-1-hch@lst.de> <20251210054831.3469261-10-hch@lst.de> <20251210195427.GE94594@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210195427.GE94594@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Dec 10, 2025 at 11:54:27AM -0800, Darrick J. Wong wrote:
> 
> Hrmm, I wonder if this test should check that SCRATCH_RTDEV is at least
> 400m?  But I guess the old code didn't check that the loop file doesn't
> ENOSPC (which is another good reason to get rid of the fakery) so...

Yeah, I didn't add a new check.  But adding a _require_scratch_size
shouldn't hurt, so I'll look into that for the next version.


