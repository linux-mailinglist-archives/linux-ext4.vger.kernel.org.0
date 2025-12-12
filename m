Return-Path: <linux-ext4+bounces-12332-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8880CB984F
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 19:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D14630198FE
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 18:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5535B2F618C;
	Fri, 12 Dec 2025 18:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d7/3qqB2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E682B4A01
	for <linux-ext4@vger.kernel.org>; Fri, 12 Dec 2025 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765563039; cv=none; b=utQq4gMPPxfIznAnT8ge3u6SoH19VKv0oXmoYLACAKUjs35kFnD29r9/TdzfBaS2UavrLRUQF6/5V9ykXIQ2pnDen4q2VYRfb4FoN7pcoN2r4oCpJ8IK3yUsND+TSaFIVCQ+Xpx3x9AnUY/e9tdSTn/i+LdaVHsvoLeiFNcOXdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765563039; c=relaxed/simple;
	bh=UMmIgxJZH37IioPo8O8PGueY3qsSqOpfbOtmLBFhJwM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mktcAvpbYbn/jC9QHsBUH7CZgvs/QKSxSw45qa5MGDgxPCSar87heQdY1EQqPEcXoBvgKEgEI0sEnKD98lxEkuZY/2wiTWQorwqkVuS4HDH9VojA3NJQxNpkiq/zLLoN1e7wRj7B7NQNTy8tdYO1UfqMM2pbdpew1of1TrkF44k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d7/3qqB2; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765563037; x=1797099037;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=UMmIgxJZH37IioPo8O8PGueY3qsSqOpfbOtmLBFhJwM=;
  b=d7/3qqB2TGCTHtjAOMvyYawr5aD7C0jGTBzZUgZ8wbOQiL3B2RjOi7jc
   bgYttPdXaOuPVVMLyHHnKBp82atMA/LQbZSXL2e+IvVdHI83S0QQHsyLI
   pcJ0cXjoe2ua7vcIgC0PfRIadhqbKiyJziX7qA7IBU/bzesEWhtO84NxI
   Z5aNGByQC4PxvQ6m5emtoVd8jXrNPe9kDxn9Syhj4fUdbu/6RxEt93Q5K
   MJl0Od61Iw4Oln/tK7iiQZqzedlp1Up+oLIH9WjpLZtAmrjbgM356pfJd
   cgO/1yQmjlkaVEqRPFl0NV0CMRdACiYeraqEy+8/kL1c36Vbng1t6QOLp
   g==;
X-CSE-ConnectionGUID: sl9K6XHqSqu/cJnsh35WpQ==
X-CSE-MsgGUID: 6m3TOZqJSKmvtdkasuBVSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11640"; a="79028206"
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="79028206"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 10:10:37 -0800
X-CSE-ConnectionGUID: OdlAvxkQQWigk7vNgsqj7w==
X-CSE-MsgGUID: +4uQkvONRUKWTc8r24tp2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="196225062"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by orviesa006.jf.intel.com with ESMTP; 12 Dec 2025 10:10:37 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id 6997B301831; Fri, 12 Dec 2025 10:10:36 -0800 (PST)
From: Andi Kleen <ak@linux.intel.com>
To: "Theodore Tso" <tytso@mit.edu>
Cc: Winston Wen <wentao@uniontech.com>,  linux-ext4@vger.kernel.org
Subject: Re: Inquiry: Possible built-in support for longer filenames in ext4
 (beyond 256 bytes)
In-Reply-To: <20251210232459.GD42106@macsyma.local> (Theodore Tso's message of
	"Thu, 11 Dec 2025 08:24:59 +0900")
References: <63C71AFEB9EEBDC8+20251210145935.72a6f028@winn-pc>
	<20251210090536.GB42106@macsyma.local>
	<2EB6F335572BB77B+20251210173202.58c83465@winn-pc>
	<20251210232459.GD42106@macsyma.local>
Date: Fri, 12 Dec 2025 10:10:36 -0800
Message-ID: <87pl8jzi3n.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Theodore Tso" <tytso@mit.edu> writes:
>
> Well, extended attributes won't work, because xattrs are associated
> with the inode, not the directory entry.  So you need to handle cases
> where the file has multiple hard links.  And if you are doing a lookup
> by long file name, there's a chicken and egg problem; you can't match
> against the full filename until you read the xattr, and you can't do
> that until you've lookup.

Perhaps you could use xattrs on the directory inode to store the longer
names, or the overflow.

One problem is that they may need to be big, exceeding xattr
limits, but perhaps some total limit on the longer file names
would be acceptable.

-Andi

