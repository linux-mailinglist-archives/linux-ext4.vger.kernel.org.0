Return-Path: <linux-ext4+bounces-12361-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D25CBC904
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Dec 2025 06:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 430A830119EE
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Dec 2025 05:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCBB324B3B;
	Mon, 15 Dec 2025 05:29:18 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CE232471D;
	Mon, 15 Dec 2025 05:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765776558; cv=none; b=QUIB3sKCxObVtnyJ+1EJAs875QqECQDnwfJlL4Hwe5OZjp9Xn4GDPy1W/n6j9zVYDjgzSp5EeQHEyfKZjm/EoFXjOnGOAZD76E7jGP3Zy5GFi69WP0OksNEOefv/FGP2f/br3bIVk1Ydaq4+QMMx5SeWw6rROYxrCiD5z15I1iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765776558; c=relaxed/simple;
	bh=8jrllcZZqV2touBAoLiQ5THno83S/XzmCnowMjsP58s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h38gE8RuKXUIS347qpPzryDG6m0jVDUdkpT52X+j7GExQY44YxcK+M5uEyIls3gQLmbE9JfEQgO3VbzfBqQ6ky5SEucYV/Jz2pfgqW6Bqao77fLHoDvCT4lLQkq9RXzm8RAE+r1sRXE2dk/6oy5dCe4+Hah9ReEGR96TUpdAFnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7240768B05; Mon, 15 Dec 2025 06:29:13 +0100 (CET)
Date: Mon, 15 Dec 2025 06:29:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Zorro Lang <zlang@kernel.org>,
	Anand Jain <asj@kernel.org>, Filipe Manana <fdmanana@suse.com>,
	fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 01/13] dmflakey: override SCRATCH_DEV in _init_flakey
Message-ID: <20251215052913.GB30524@lst.de>
References: <20251212082210.23401-1-hch@lst.de> <20251212082210.23401-2-hch@lst.de> <20251212201142.GF7716@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212201142.GF7716@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Dec 12, 2025 at 12:11:42PM -0800, Darrick J. Wong wrote:
> Ok, so _init_flakey still sets FLAKEY_TABLE_ERROR...
> 
> >  	_dmsetup_create $FLAKEY_NAME --table "$FLAKEY_TABLE" || \
> >  		_fatal "failed to create flakey device"
> >  

> >  # no error will be injected
> >  _init_flakey
> 
> ...but won't _init_flakey clobber the value of FLAKEY_TABLE_ERROR set
> by make_xfs_scratch_flakey_table?

I think so.  But nothing really changed here except for a variable
name, so the whatever clobber was there before is the same and apparently
worked?


