Return-Path: <linux-ext4+bounces-989-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C40D83F5F3
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jan 2024 15:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28DF72841B0
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jan 2024 14:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B3A219F0;
	Sun, 28 Jan 2024 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d9s+1UiF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9FC23748;
	Sun, 28 Jan 2024 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706453139; cv=none; b=Y14BhJe/pTf9LBsupYDLiZA9p52vmu6xethk29bkOPP8g4A5GPmWaKPDW/i9BLipZBDe0/zj4wUfu8O19MQjyRZv8d2nQCUD3bTFnltKK4E9X3hNbRsRuN/d7DtxMmhZ/GsWe+iIrwjbsk1l0PoaoG5u52n4FGFDNn2vZKwCx3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706453139; c=relaxed/simple;
	bh=P/meK+1adeiTFLyBVrnt7uGWc0ipxvtMeN9hzWEc3/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTQXjEBH7LqGRoZjOvH120aZxJv/WP4Lv9obsLifdjd0ealPb09cN9PmiiSBvsCosIIf3zuxSyFZ+JBfkv9osDcAKAq/wXKDPXoiGBC7IC/pOf2NzCb0+jCyHmLeuAegX5v2o8TAA7pkWG2yM/cF0a6MsijYcH5nOa5oVNSh58I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d9s+1UiF; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706453138; x=1737989138;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=P/meK+1adeiTFLyBVrnt7uGWc0ipxvtMeN9hzWEc3/Q=;
  b=d9s+1UiFxH1skMazeE5oYkbVLCcNkItIV5K4RUyls5GzndkNMVyPixeN
   kNqPoGHug7IUDyPOJ9igM1a/emNFFnbPfeuqGhkczmPNJ16mhvykM7NMd
   ixile35K/QhSNafImgeUcZwiONGlmtS/cunIHu3sUbzD9gzgFmfsGrO+e
   8ANMWijMvJd4mQwu5fVohFqG858ZenzSoNQTCjFvrZL01RP9sBZPhsSWp
   lvJ97yRjXFLg9e4Rv4S6NDd2MQlxWrBe/HFtTodMghMI4Lx5Kw/Wb/OCy
   ZZkSOaOq+WJCleOICwRGY49gxbtfNUQrQSdN1fvinv7zD7EyTt3jEhTLf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="2644690"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="2644690"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 06:45:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="857858400"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="857858400"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jan 2024 06:45:29 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rU6PX-0003T0-1O;
	Sun, 28 Jan 2024 14:45:27 +0000
Date: Sun, 28 Jan 2024 22:44:42 +0800
From: kernel test robot <lkp@intel.com>
To: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kernel_team@skhynix.com,
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
Subject: Re: [PATCH v11 25/26] dept: Print event context requestor's
 stacktrace on report
Message-ID: <202401282254.iwdPYJ9E-lkp@intel.com>
References: <20240124115938.80132-26-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240124115938.80132-26-byungchul@sk.com>

Hi Byungchul,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0dd3ee31125508cd67f7e7172247f05b7fd1753a]

url:    https://github.com/intel-lab-lkp/linux/commits/Byungchul-Park/llist-Move-llist_-head-node-definition-to-types-h/20240124-200243
base:   0dd3ee31125508cd67f7e7172247f05b7fd1753a
patch link:    https://lore.kernel.org/r/20240124115938.80132-26-byungchul%40sk.com
patch subject: [PATCH v11 25/26] dept: Print event context requestor's stacktrace on report
config: microblaze-allmodconfig (https://download.01.org/0day-ci/archive/20240128/202401282254.iwdPYJ9E-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240128/202401282254.iwdPYJ9E-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401282254.iwdPYJ9E-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/tests/drm_exec_test.c: In function 'test_prepare_array':
>> drivers/gpu/drm/tests/drm_exec_test.c:171:1: warning: the frame size of 1028 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     171 | }
         | ^


vim +171 drivers/gpu/drm/tests/drm_exec_test.c

9710631cc8f367 Christian König  2022-04-13  149  
9710631cc8f367 Christian König  2022-04-13  150  static void test_prepare_array(struct kunit *test)
9710631cc8f367 Christian König  2022-04-13  151  {
0f249678fef433 Arthur Grillo    2023-07-31  152  	struct drm_exec_priv *priv = test->priv;
9710631cc8f367 Christian König  2022-04-13  153  	struct drm_gem_object gobj1 = { };
9710631cc8f367 Christian König  2022-04-13  154  	struct drm_gem_object gobj2 = { };
9710631cc8f367 Christian König  2022-04-13  155  	struct drm_gem_object *array[] = { &gobj1, &gobj2 };
9710631cc8f367 Christian König  2022-04-13  156  	struct drm_exec exec;
9710631cc8f367 Christian König  2022-04-13  157  	int ret;
9710631cc8f367 Christian König  2022-04-13  158  
0f249678fef433 Arthur Grillo    2023-07-31  159  	drm_gem_private_object_init(priv->drm, &gobj1, PAGE_SIZE);
0f249678fef433 Arthur Grillo    2023-07-31  160  	drm_gem_private_object_init(priv->drm, &gobj2, PAGE_SIZE);
9710631cc8f367 Christian König  2022-04-13  161  
9710631cc8f367 Christian König  2022-04-13  162  	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
9710631cc8f367 Christian König  2022-04-13  163  	drm_exec_until_all_locked(&exec)
9710631cc8f367 Christian König  2022-04-13  164  		ret = drm_exec_prepare_array(&exec, array, ARRAY_SIZE(array),
9710631cc8f367 Christian König  2022-04-13  165  					     1);
9710631cc8f367 Christian König  2022-04-13  166  	KUNIT_EXPECT_EQ(test, ret, 0);
9710631cc8f367 Christian König  2022-04-13  167  	drm_exec_fini(&exec);
806fd6d005ad7a Danilo Krummrich 2023-08-10  168  
806fd6d005ad7a Danilo Krummrich 2023-08-10  169  	drm_gem_private_object_fini(&gobj1);
806fd6d005ad7a Danilo Krummrich 2023-08-10  170  	drm_gem_private_object_fini(&gobj2);
9710631cc8f367 Christian König  2022-04-13 @171  }
9710631cc8f367 Christian König  2022-04-13  172  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

