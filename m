Return-Path: <linux-ext4+bounces-7936-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC6DAB972C
	for <lists+linux-ext4@lfdr.de>; Fri, 16 May 2025 10:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDD657B1EFB
	for <lists+linux-ext4@lfdr.de>; Fri, 16 May 2025 08:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB30422C32D;
	Fri, 16 May 2025 08:07:17 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641B921FF4D;
	Fri, 16 May 2025 08:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747382837; cv=none; b=ui7apUUAtgYvmDMuxUOtyf5BCBoRXbdfNHyO2qWgp4PEA8cAH8pXMpIpH6x9HjINh/JkKefhwO6uM+iDbhBNl9XGe7DMpYLwSGfKCBEqt2nbr3sYT3Rw8lut1JZh6yhozJf7utX/wBUF7iS9EbI5lR+yBHkdjcHcUiSg/Vxwn4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747382837; c=relaxed/simple;
	bh=UBvjaIp8Waej5vlBi/RKzzjiqZNfMRFLiFIwcKpqqNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7JgwMdIR+yEMBNOHkpFxbCIt/gY+ezwZClAlyxmXyck7yslqEogueK2q6OXvWBkGAb70vp703ksxqPGxqs/onag0V8kB2g+VtLHVbJQf0pf45JQN2yJElGySG2u/2EwAhHqLFW6SOWISljYhhADZdXDePVigWPdK665MlbgSs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-4c-6826f22eb14b
Date: Fri, 16 May 2025 17:07:04 +0900
From: Byungchul Park <byungchul@sk.com>
To: kernel test robot <lkp@intel.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, kernel_team@skhynix.com,
	torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
	will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
	joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
	duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
	tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
	amir73il@gmail.com, gregkh@linuxfoundation.org, kernel-team@lge.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
	minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com
Subject: Re: [PATCH v15 33/43] dept: assign unique dept_key to each distinct
 dma fence caller
Message-ID: <20250516080704.GA56738@system.software.com>
References: <20250513100730.12664-34-byungchul@sk.com>
 <202505140631.FOWO8B5L-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202505140631.FOWO8B5L-lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+59zds7ZcnFchv+0DzJTQWqWWb0fIqIL/LELgeAHw2zpqa28
	1DTLIDJyotPsgqs2rDRpXtPYNDVLbV3tYjdJMbMaWpqZMXJm2m0LqW8/nufhed4PL08r9BI/
	XpucJuqS1YlKVsbIRrxKFqqcwZpF+s6ZMPY1h4Gi2moWntZUIZh8/ISGknevaai724eg3ZjH
	wtHSWhaqrBvBkhkEjnIzB+19LyVgOt/Lwt1GBwUvrhWx0Ff9SwIfjzpY6C9sZWHYZaHBMjbK
	wfO2YgrsFZ0U3DvWRkFLzlsKrNUvWbBZjTR8L7uDwFEwwoE+f4KDPP1pBrJ6l8LktyJ2VQC5
	9WmUJlm2/eSGq5ghDy5i0mR+zZGslh6O2MpDSen1IYqUOMckxFqZyxKr8xRHDCOdFPnc0cGR
	+2cnGdJ6rpojgzYT2uwTI1uRICZq00Vd2MptMs2HT830HmvEgeZbmVwmMi4wICmPhQhc017C
	TPOjvJOcmxkhCOubztBuZoUQ3N094WGfP3rjOwtlQDKeFsYl+MrtVuQ2Zgtx2GS0e0JyAfDo
	l3HWgHheIWzFA6VRf2Vv3G7q92zRQiju/jlEuSO04I/LfvJuWSqE49LzLzyROUIgbrt6zzOF
	hUs8bs4voP/eORffLO9mTiDB/F+t+b9a87/aYkRXIoU2OT1JrU2MUGkykrUHVPEpSVb05zks
	h6a2NCLn0yg7Enik9JKv6grSKCTq9NSMJDvCPK30kXftCtQo5AnqjIOiLiVOty9RTLUjf55R
	+srDXfsTFMJOdZq4WxT3iLppl+Klfplo17LVwSdE++DzGNeRedmHXQfDnEtic1UDQ8por+XR
	0oe2GT277z8LOe6IMmgss+qH18yeb75ef3yqZ0ek0Xs7G1C3SY9FU69v0vD7wnR/1VDC2o2X
	X623wEBcg8s8qH4Tl+s6dWE80jf2xw3iakgJ0m/QZlftlUY2rdv7ML5CIlEyqRr14lBal6r+
	De+8Zj0YAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Rf0yMcRzH932e557n6bh5OqWvGltHbE2IzGcj4sSz/JhhM2bVjUd3VHSX
	q5BlFbmUmNKdtHJ250eUq1lEtYu4hKamRkU31g/9sH4cSeEy47/X3u/X+683S0o7KU9WFR0r
	qKMVkTJaTIm3rEj28xucp1xc37AcRobTKMgrLqKh4c4tBGMvXpFQ2NFGQlltOwJbdjoNycZi
	Gm5ZNoMpyQfs1w0M2NrfiKDmik0E+vxWGmrL7QQ0Psijob3opwh6ku00fLxYRcNnh4kE08gA
	A6+rCwiw3mgi4GlGNQGVaR8IsBS9oaHUkk3Cd/MTBPbMPgZSz44ykJ6aQ0FK6zIY+5ZHB3nz
	Nb0DJJ9SGsc/chRQfN1VzN83tDF8SuVbhi+97ssbH3YTfOHgiIi33DxD85bBCwyv62si+P6X
	Lxn+We4YxVddKWL4rlI92uq+W7xynxCp0grqRavCxcrO3grysCUgvqImiUlC2Qt0yIXFXACu
	Tz/POJnifHDq/Uukk2luPm5pGZ1kt995eYeJ0CExS3JfRbjkcRVyFtO5MKzPtk5KEg7wwJev
	tA6xrJQLxZ+M2//Ertim/0g5meR8cctEN+FUSM4LmydYZ+zCLcHG/MZJxZ2bg6vvPSWykMTw
	39rw39rwb12AyJvITRWtjVKoIpct1BxUJkSr4hfuPRRlQb/vNyX+OF+Ohhs3WBHHItlUSVCz
	j1IqUmg1CVFWhFlS5iZpPjBHKZXsUyQcFdSHwtRHIgWNFXmxlMxDErJTCJdyEYpY4aAgHBbU
	f1uCdfFMQo3flsrvho6vCcZBQ7kex0NOVVtcJ+wvcuseHcmMGdqBDDEnTwR3euy/nKY8FiKv
	68/VZLjKKzfOtjnM6+J7AuWG8XBtzururtsR057rm+ulgYkzzr2vgEtD78Znrncz+5uzfuac
	vubATXPX7pni1X/Nb92skl3eN0blm7zLtsXETZdRGqXC35dUaxS/AKmkskj6AgAA
X-CFilter-Loop: Reflected

On Wed, May 14, 2025 at 06:49:42AM +0800, kernel test robot wrote:
> Hi Byungchul,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Byungchul-Park/llist-move-llist_-head-node-definition-to-types-h/20250513-181346
> base:   82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3
> patch link:    https://lore.kernel.org/r/20250513100730.12664-34-byungchul%40sk.com
> patch subject: [PATCH v15 33/43] dept: assign unique dept_key to each distinct dma fence caller
> config: arm-randconfig-002-20250514 (https://download.01.org/0day-ci/archive/20250514/202505140631.FOWO8B5L-lkp@intel.com/config)
> compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250514/202505140631.FOWO8B5L-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202505140631.FOWO8B5L-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/dma-buf/dma-fence.c:503: warning: expecting prototype for dma_fence_wait_timeout(). Prototype was for __dma_fence_wait_timeout() instead
> >> drivers/dma-buf/dma-fence.c:763: warning: expecting prototype for dma_fence_default_wait(). Prototype was for __dma_fence_default_wait() instead
> >> drivers/dma-buf/dma-fence.c:853: warning: expecting prototype for dma_fence_wait_any_timeout(). Prototype was for __dma_fence_wait_any_timeout() instead

I have just fixed it.  Thanks.

	Byungchul
> 
> vim +503 drivers/dma-buf/dma-fence.c
> 
> e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  482  
> e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  483  /**
> f54d1867005c33 drivers/dma-buf/dma-fence.c Chris Wilson      2016-10-25  484   * dma_fence_wait_timeout - sleep until the fence gets signaled
> e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  485   * or until timeout elapses
> 4dd3cdb281f7a3 drivers/dma-buf/dma-fence.c Simona Vetter     2018-07-04  486   * @fence: the fence to wait on
> 4dd3cdb281f7a3 drivers/dma-buf/dma-fence.c Simona Vetter     2018-07-04  487   * @intr: if true, do an interruptible wait
> 4dd3cdb281f7a3 drivers/dma-buf/dma-fence.c Simona Vetter     2018-07-04  488   * @timeout: timeout value in jiffies, or MAX_SCHEDULE_TIMEOUT
> e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  489   *
> e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  490   * Returns -ERESTARTSYS if interrupted, 0 if the wait timed out, or the
> e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  491   * remaining timeout in jiffies on success. Other error values may be
> e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  492   * returned on custom implementations.
> e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  493   *
> e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  494   * Performs a synchronous wait on this fence. It is assumed the caller
> e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  495   * directly or indirectly (buf-mgr between reservation and committing)
> e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  496   * holds a reference to the fence, otherwise the fence might be
> e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  497   * freed before return, resulting in undefined behavior.
> 4dd3cdb281f7a3 drivers/dma-buf/dma-fence.c Simona Vetter     2018-07-04  498   *
> 4dd3cdb281f7a3 drivers/dma-buf/dma-fence.c Simona Vetter     2018-07-04  499   * See also dma_fence_wait() and dma_fence_wait_any_timeout().
> e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  500   */
> e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  501  signed long
> 15fe92c1e1cf69 drivers/dma-buf/dma-fence.c Byungchul Park    2025-05-13  502  __dma_fence_wait_timeout(struct dma_fence *fence, bool intr, signed long timeout)
> e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01 @503  {
> e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  504  	signed long ret;
> e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  505  
> e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  506  	if (WARN_ON(timeout < 0))
> e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  507  		return -EINVAL;
> e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  508  
> ef8255506f6682 drivers/dma-buf/dma-fence.c Simona Vetter     2020-05-19  509  	might_sleep();
> ef8255506f6682 drivers/dma-buf/dma-fence.c Simona Vetter     2020-05-19  510  
> 5fbff813a4a328 drivers/dma-buf/dma-fence.c Simona Vetter     2020-07-07  511  	__dma_fence_might_wait();
> 5fbff813a4a328 drivers/dma-buf/dma-fence.c Simona Vetter     2020-07-07  512  
> b96fb1e724ae68 drivers/dma-buf/dma-fence.c Arvind Yadav      2022-09-14  513  	dma_fence_enable_sw_signaling(fence);
> b96fb1e724ae68 drivers/dma-buf/dma-fence.c Arvind Yadav      2022-09-14  514  
> f54d1867005c33 drivers/dma-buf/dma-fence.c Chris Wilson      2016-10-25  515  	trace_dma_fence_wait_start(fence);
> 418cc6ca06071e drivers/dma-buf/dma-fence.c Simona Vetter     2018-05-03  516  	if (fence->ops->wait)
> e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  517  		ret = fence->ops->wait(fence, intr, timeout);
> 418cc6ca06071e drivers/dma-buf/dma-fence.c Simona Vetter     2018-05-03  518  	else
> 418cc6ca06071e drivers/dma-buf/dma-fence.c Simona Vetter     2018-05-03  519  		ret = dma_fence_default_wait(fence, intr, timeout);
> f54d1867005c33 drivers/dma-buf/dma-fence.c Chris Wilson      2016-10-25  520  	trace_dma_fence_wait_end(fence);
> e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  521  	return ret;
> e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  522  }
> 15fe92c1e1cf69 drivers/dma-buf/dma-fence.c Byungchul Park    2025-05-13  523  EXPORT_SYMBOL(__dma_fence_wait_timeout);
> e941759c74a44d drivers/dma-buf/fence.c     Maarten Lankhorst 2014-07-01  524  
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

