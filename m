Return-Path: <linux-ext4+bounces-7870-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 879FDAB5FAA
	for <lists+linux-ext4@lfdr.de>; Wed, 14 May 2025 00:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DBED19E0E07
	for <lists+linux-ext4@lfdr.de>; Tue, 13 May 2025 22:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E9E21767D;
	Tue, 13 May 2025 22:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ejae8Xw/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAD420B7F9;
	Tue, 13 May 2025 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747176622; cv=none; b=gnIIzPOgjqXVjonial2DZ7OdZp2M94pohrORX4Aw/AZB0Hb7dRpL1lNZYxv+6CULoA5zeTTI5F+aj6dJ9BOxD6IGHfEtXXQwOffs6+VYukUlG0xb1OO/hD5GJpYNTdp4ZEIsvFvu4ZllT+fp57rFWxgnb0lu1KqqjxCWLw+5GZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747176622; c=relaxed/simple;
	bh=YOm9j2GGESAbT4Kw5OSrV1pC85uJg3KLTfhUK9HOpsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlOg8CW5U2MlrACpGNuRsDORRMZixVhG3f5Rk+4aILNIWVrL5jQ90UpsMm+DGyKf9FH6W4EIZc5J9jCdJCtkkczNI7Yqjb/Zl8vP5SVTsj0u8QCeJJW3Pfx8JKcvhSTL+4ubVv23KWfsAh33aiCoWdN9NIln/3uHSkCvQ42sERQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ejae8Xw/; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747176621; x=1778712621;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YOm9j2GGESAbT4Kw5OSrV1pC85uJg3KLTfhUK9HOpsc=;
  b=ejae8Xw/fku34DEr3ClrGnI0i2aZKfoBCLhasf3zIsLHsEYYzBwPNKsW
   paKn9gMkZQdVyFgEGoy6BlK3XUFEg2kMZ8V1M34XVQBTaW8qcDB+zSwFM
   D2ycYKaLl/n7s+nkFnZnu3nHwjJAFZG7ppBkuDT5Vh63kGuLlcKiXAGZp
   dD8luUaf5swSq8g6P6cKPCCGN+2GqLsD9HCGTaNdHTP7mX1P1n/n532AG
   ciMj1VV9wAMHIyrYNG0OJA4Fg8LNApPRX1KQEHIhYI68zpDxlORqngCQI
   XjsKyvz2N92o6vHVnhb2jzWZosboKP9pfylyh474An7oqnN+JAm43wWNt
   Q==;
X-CSE-ConnectionGUID: nmU8DWVTRVePDit7x2y/VQ==
X-CSE-MsgGUID: K0t2Fb/zTbyqAKZEX1qfVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="48303093"
X-IronPort-AV: E=Sophos;i="6.15,286,1739865600"; 
   d="scan'208";a="48303093"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 15:50:20 -0700
X-CSE-ConnectionGUID: wHziW06rRHShu89ZmiEO1Q==
X-CSE-MsgGUID: LxdgacP5Ql+b1a9n6NGwPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,286,1739865600"; 
   d="scan'208";a="138832650"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 13 May 2025 15:50:13 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uEyRu-000GTD-38;
	Tue, 13 May 2025 22:50:10 +0000
Date: Wed, 14 May 2025 06:49:42 +0800
From: kernel test robot <lkp@intel.com>
To: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	kernel_team@skhynix.com, torvalds@linux-foundation.org,
	damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org, will@kernel.org,
	tglx@linutronix.de, rostedt@goodmis.org, joel@joelfernandes.org,
	sashal@kernel.org, daniel.vetter@ffwll.ch, duyuyang@gmail.com,
	johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
	willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
	gregkh@linuxfoundation.org, kernel-team@lge.com, linux-mm@kvack.org,
	akpm@linux-foundation.org, mhocko@kernel.org, minchan@kernel.org,
	hannes@cmpxchg.org, vdavydov.dev@gmail.com
Subject: Re: [PATCH v15 33/43] dept: assign unique dept_key to each distinct
 dma fence caller
Message-ID: <202505140631.FOWO8B5L-lkp@intel.com>
References: <20250513100730.12664-34-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513100730.12664-34-byungchul@sk.com>

Hi Byungchul,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3]

url:    https://github.com/intel-lab-lkp/linux/commits/Byungchul-Park/llist-move-llist_-head-node-definition-to-types-h/20250513-181346
base:   82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3
patch link:    https://lore.kernel.org/r/20250513100730.12664-34-byungchul%40sk.com
patch subject: [PATCH v15 33/43] dept: assign unique dept_key to each distinct dma fence caller
config: arm-randconfig-002-20250514 (https://download.01.org/0day-ci/archive/20250514/202505140631.FOWO8B5L-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250514/202505140631.FOWO8B5L-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505140631.FOWO8B5L-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/dma-buf/dma-fence.c:503: warning: expecting prototype for dma_fence_wait_timeout(). Prototype was for __dma_fence_wait_timeout() instead
>> drivers/dma-buf/dma-fence.c:763: warning: expecting prototype for dma_fence_default_wait(). Prototype was for __dma_fence_default_wait() instead
>> drivers/dma-buf/dma-fence.c:853: warning: expecting prototype for dma_fence_wait_any_timeout(). Prototype was for __dma_fence_wait_any_timeout() instead


vim +503 drivers/dma-buf/dma-fence.c

e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  482  
e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  483  /**
f54d1867005c33 drivers/dma-buf/dma-fence.c Chris Wilson      2016-10-25  484   * dma_fence_wait_timeout - sleep until the fence gets signaled
e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  485   * or until timeout elapses
4dd3cdb281f7a3 drivers/dma-buf/dma-fence.c Simona Vetter     2018-07-04  486   * @fence: the fence to wait on
4dd3cdb281f7a3 drivers/dma-buf/dma-fence.c Simona Vetter     2018-07-04  487   * @intr: if true, do an interruptible wait
4dd3cdb281f7a3 drivers/dma-buf/dma-fence.c Simona Vetter     2018-07-04  488   * @timeout: timeout value in jiffies, or MAX_SCHEDULE_TIMEOUT
e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  489   *
e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  490   * Returns -ERESTARTSYS if interrupted, 0 if the wait timed out, or the
e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  491   * remaining timeout in jiffies on success. Other error values may be
e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  492   * returned on custom implementations.
e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  493   *
e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  494   * Performs a synchronous wait on this fence. It is assumed the caller
e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  495   * directly or indirectly (buf-mgr between reservation and committing)
e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  496   * holds a reference to the fence, otherwise the fence might be
e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  497   * freed before return, resulting in undefined behavior.
4dd3cdb281f7a3 drivers/dma-buf/dma-fence.c Simona Vetter     2018-07-04  498   *
4dd3cdb281f7a3 drivers/dma-buf/dma-fence.c Simona Vetter     2018-07-04  499   * See also dma_fence_wait() and dma_fence_wait_any_timeout().
e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  500   */
e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  501  signed long
15fe92c1e1cf69 drivers/dma-buf/dma-fence.c Byungchul Park    2025-05-13  502  __dma_fence_wait_timeout(struct dma_fence *fence, bool intr, signed long timeout)
e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01 @503  {
e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  504  	signed long ret;
e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  505  
e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  506  	if (WARN_ON(timeout < 0))
e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  507  		return -EINVAL;
e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  508  
ef8255506f6682 drivers/dma-buf/dma-fence.c Simona Vetter     2020-05-19  509  	might_sleep();
ef8255506f6682 drivers/dma-buf/dma-fence.c Simona Vetter     2020-05-19  510  
5fbff813a4a328 drivers/dma-buf/dma-fence.c Simona Vetter     2020-07-07  511  	__dma_fence_might_wait();
5fbff813a4a328 drivers/dma-buf/dma-fence.c Simona Vetter     2020-07-07  512  
b96fb1e724ae68 drivers/dma-buf/dma-fence.c Arvind Yadav      2022-09-14  513  	dma_fence_enable_sw_signaling(fence);
b96fb1e724ae68 drivers/dma-buf/dma-fence.c Arvind Yadav      2022-09-14  514  
f54d1867005c33 drivers/dma-buf/dma-fence.c Chris Wilson      2016-10-25  515  	trace_dma_fence_wait_start(fence);
418cc6ca06071e drivers/dma-buf/dma-fence.c Simona Vetter     2018-05-03  516  	if (fence->ops->wait)
e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  517  		ret = fence->ops->wait(fence, intr, timeout);
418cc6ca06071e drivers/dma-buf/dma-fence.c Simona Vetter     2018-05-03  518  	else
418cc6ca06071e drivers/dma-buf/dma-fence.c Simona Vetter     2018-05-03  519  		ret = dma_fence_default_wait(fence, intr, timeout);
f54d1867005c33 drivers/dma-buf/dma-fence.c Chris Wilson      2016-10-25  520  	trace_dma_fence_wait_end(fence);
e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  521  	return ret;
e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  522  }
15fe92c1e1cf69 drivers/dma-buf/dma-fence.c Byungchul Park    2025-05-13  523  EXPORT_SYMBOL(__dma_fence_wait_timeout);
e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  524  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

