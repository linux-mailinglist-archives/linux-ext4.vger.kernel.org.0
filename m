Return-Path: <linux-ext4+bounces-9238-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BEAB16223
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jul 2025 16:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 788BD3A3CA4
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jul 2025 14:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E782D94B4;
	Wed, 30 Jul 2025 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bm/rYsay"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B85E1DA60D;
	Wed, 30 Jul 2025 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753884050; cv=none; b=gQgqTc03Pnfbf5ggU7/VIdcWlFJ/2/IaCUcd0YIjs4oHfll2dcGHmc1szN7QyfaBfZyj1qdULjJSRNcerMwimo6dOUYOfjPHn6BkLCXqYUyjsMgpNqRzhB2OwjYL5NTFZ66eZQKQadcpLIwoFZaC+nstLCz89RHRQ4bjYD3u0AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753884050; c=relaxed/simple;
	bh=b1BzOVs+xTZVKuI2csl0s8gtRoQhCdrEdPDJl88e2nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmicWqeEkVQNPshzl/7EbJyTeeebi/Q5A6+ta8tFV6DNamixPQHiIYZoNcst8cZa4ZLRbr1Y01uwKrsYIrLXboYzWWQ1ENEG/OI4Nr3s+hZ3GzP4dbxgg/eCLvx6/PMHUOlGyLD1iYVC9wA/zGCYTZOXMknCUGGPWw/8jlVgVxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bm/rYsay; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753884049; x=1785420049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b1BzOVs+xTZVKuI2csl0s8gtRoQhCdrEdPDJl88e2nY=;
  b=bm/rYsaymABhZYlrdScLurCYOX49AEZhsBj9vK+faRSyPiaUJ5KpvlP/
   ZdJ39gYTxiEVxtppUEE6HBdO1Wp5nec7jJ85AedOv0F9TjWt8ryalYJ7g
   whqRd/Okv/9N5iID0vIC1awrnLeLyyfo1m1hBCE5AqvxWfMz6mdeHJSf6
   BnuK84TcDbXdbfzP8MIRFBEYV4yXpitIoKGUyCUpU1zPeI9zFW1qEi6jh
   fq7dt6C+/GIV01nHOx7obhdrrV8a2oVBXqtZoEoO2lbJsqzIoAYF4FqjX
   BJbNoBWa5Mju0vgHfVGtoa91QGaM15W+19Q3/UJz8pmHiYb+Iab8y6p3M
   g==;
X-CSE-ConnectionGUID: EhKSNi+CQo29WJ14F+E5Mw==
X-CSE-MsgGUID: e3hxxanMSu21E/usbO1Xlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="55883895"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="55883895"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 07:00:48 -0700
X-CSE-ConnectionGUID: yxreNB54S1mHmw72TEYTig==
X-CSE-MsgGUID: gJ1OkRvzS5q1LKcxMRdWQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="163445568"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 30 Jul 2025 07:00:46 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 527D717; Wed, 30 Jul 2025 17:01:17 +0200 (CEST)
Date: Wed, 30 Jul 2025 17:01:17 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, kernel test robot <lkp@intel.com>,
	Ext4 Developers List <linux-ext4@vger.kernel.org>,
	oe-kbuild-all@lists.linux.dev, linux-hardening@vger.kernel.org,
	ethan@ethancedwards.com
Subject: Re: [PATCH 3/3] ext4: refactor the inline directory conversion and
 new directory codepaths
Message-ID: <aIozvXz0zcRYwwvQ@black.igk.intel.com>
References: <20250712181249.434530-3-tytso@mit.edu>
 <202507130429.rPIzofCD-lkp@intel.com>
 <20250721231559.GA85006@quark>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721231559.GA85006@quark>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jul 21, 2025 at 04:15:59PM -0700, Eric Biggers wrote:
> On Sun, Jul 13, 2025 at 05:12:55AM +0800, kernel test robot wrote:
> > All warnings (new ones prefixed by >>):
> > 
> >    fs/ext4/namei.c: In function 'ext4_init_new_dir':
> > >> fs/ext4/namei.c:2968:34: warning: variable 'de' set but not used [-Wunused-but-set-variable]
> >     2968 |         struct ext4_dir_entry_2 *de;
> >          |                                  ^~
> 
> This warning is present in ext4/dev now.

For somebody (who doesn't alter CONFIG_WERROR) this is a build breakage with both GCC and clang.

-- 
With Best Regards,
Andy Shevchenko



