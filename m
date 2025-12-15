Return-Path: <linux-ext4+bounces-12367-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F62CBE90A
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Dec 2025 16:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8245A30FCF1D
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Dec 2025 15:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2032E33710E;
	Mon, 15 Dec 2025 15:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EiZlE2Uw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD20336EDF
	for <linux-ext4@vger.kernel.org>; Mon, 15 Dec 2025 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765811081; cv=none; b=T7dyFJ65ByakHxVyCyi4q3+TPfZzW831GbxxaCou65WOLrUyumiDCWGoNTWhdlBd2nA8bYuUph112MntEqpplIHjySVf2iRyCJiC+bUlIKOCxf2gz1NWNxc5lO68gJR9hbH0erwN4Ij+ybRmn2zeU+RBY2/UdHRzQutlHkXUQsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765811081; c=relaxed/simple;
	bh=PDPe+lIdxgLuvA73XZkfmENhQFRJHYzgBj9yYm5luJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fT6IsUnebX9PpmwHzgl+bdTGEDuJjZXHsiiJ0zG4rifDZ6Lz/21uW1+MZtHwvc+Q6Sd4WqN4eXIxFGCwoiRTScrKsG+Mse9+ZBzPbYUs04nPWuFCoCQI8X3m90FyMuhT/J/qazvLHE0ryVfjglTYxhsV677cfol8BgVoSlNu63Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EiZlE2Uw; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765811080; x=1797347080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PDPe+lIdxgLuvA73XZkfmENhQFRJHYzgBj9yYm5luJs=;
  b=EiZlE2UwNFqvgRL+C/efXRZPKU86M7qFFMnXcwMkS1Qn+kzfGO/Q3HGI
   t/9m5VGBLmcoiPh4QR4ShIpr+5oO+h2nvIGJEdXpkdnYLiVJa27BmIhER
   Ngi4JdCOty0XM8AtgcWihbuqDj01Y/x6LTU5YYt20VcgDHNNn7YA2Hn3l
   cbkfoY4MgMVKomH22ddTF4T+e2GYWi6BgEGmj4XBrhUNnSuS6pZCMjXly
   Pg4dVCoV0NV24QI4id+GBnmX+7/fzZkPtBjIJamX8LqehbBeaBa4H146k
   heDvHayLQXVFwwp/6fe8GQjIDbPtzDzhqaMKiBUfOaZTOGLbL82Oci9yJ
   A==;
X-CSE-ConnectionGUID: 6UKoj11dQDuNl5DVaKMCsw==
X-CSE-MsgGUID: NIwiCBeMTy6B3CntsobuTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="67747771"
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; 
   d="scan'208";a="67747771"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 07:04:39 -0800
X-CSE-ConnectionGUID: mw3YnTf7TyiDRKHFHe7Zzw==
X-CSE-MsgGUID: IPc6HYU+QnKG6pXqwpp9DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; 
   d="scan'208";a="202247745"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 07:04:39 -0800
Date: Mon, 15 Dec 2025 07:04:37 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Theodore Tso <tytso@mit.edu>
Cc: Winston Wen <wentao@uniontech.com>, linux-ext4@vger.kernel.org
Subject: Re: Inquiry: Possible built-in support for longer filenames in ext4
 (beyond 256 bytes)
Message-ID: <aUAjhXgqjrtWXjEw@tassilo>
References: <63C71AFEB9EEBDC8+20251210145935.72a6f028@winn-pc>
 <20251210090536.GB42106@macsyma.local>
 <2EB6F335572BB77B+20251210173202.58c83465@winn-pc>
 <20251210232459.GD42106@macsyma.local>
 <87pl8jzi3n.fsf@linux.intel.com>
 <20251212233537.GC88311@macsyma.local>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212233537.GC88311@macsyma.local>

On Sat, Dec 13, 2025 at 08:35:37AM +0900, Theodore Tso wrote:
> On Fri, Dec 12, 2025 at 10:10:36AM -0800, Andi Kleen wrote:
> > 
> > Perhaps you could use xattrs on the directory inode to store the longer
> > names, or the overflow.
> > 
> > One problem is that they may need to be big, exceeding xattr
> > limits, but perhaps some total limit on the longer file names
> > would be acceptable.
> 
> With ext4, there is a limit of a single file system block for all
> extended attributes.  You can store the value of extended attribute in

With the bs>page size support this special use case could use larger 
blocks.

> an inode, in which case you only have the four byte inode number in
> the xattr block.  But still, if you assume 16 bytes of overhead for
> each xattr entry, plus the xattr header, there's only room for 9 400
> byte directory entries.

You would only need to store the overflow, and I assume most uses 
would be much shorter anyways. But yes it would add some limit
to the number of file names, but perhaps with a 64k and an average 
more toward 200 bytes it isn't that bad.

> 
> And you wouldn't want to have a lot of directory entries stored in
> xattrs anyway, since searching them would have to be a brute force,
> O(n) search.  You wouldn't be able to use a hash tree for fast
> lookups.

You could do the hash still on the original directory, and then
perhaps use 4 bytes of the original file name to point to an
xattr offset for the overflow. This would be incompatible of course,
but not too far from original ext4.

Perhaps it would also need something to have an efficient free list
in the xattr, or maybe that could be just done in memory.

-Andi

