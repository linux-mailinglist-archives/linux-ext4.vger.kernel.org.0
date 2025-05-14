Return-Path: <linux-ext4+bounces-7890-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CDAAB711C
	for <lists+linux-ext4@lfdr.de>; Wed, 14 May 2025 18:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3583A7DB2
	for <lists+linux-ext4@lfdr.de>; Wed, 14 May 2025 16:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E0F27B501;
	Wed, 14 May 2025 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UdKYknY2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6436227A44E;
	Wed, 14 May 2025 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747239657; cv=none; b=kZgP89y10tfXd9Yfz/sOxqKGU5sUI8AuxqM2U+UOXg64r7/TAScUsatcCvFP7/mX5wB8W2OC7987co7pIAhbi1MUCm0AeiGSbIkcOUS3xv+RSW3UY5YNjMQ+jFGhEVZo9aBZTNDXzW91VdZzRf+dya1Ofv1+4MVcC+ZfsJ8G0hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747239657; c=relaxed/simple;
	bh=Y8GIyFWlbCJO3k6maUmLChS3pM+763sRG0puUGzYrtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phoMNbOfkkCjqfSrlyziGcvxRYSJcP79plvwq5YSe470ojlsaKL4Y0kzRQl16uyHa85c3vpoxV811YuXsRzm3DTcHg2sZbZlHPbZXU4rP/xoo3XG4RyWFnV1jsps6O7nvq8XZD4A8F73oaiQKdT2t2TvpYO8zW0W6QdSh0TGWKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UdKYknY2; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747239655; x=1778775655;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y8GIyFWlbCJO3k6maUmLChS3pM+763sRG0puUGzYrtQ=;
  b=UdKYknY2Ym3ZxA9mqHq8svOo3PctvZEOurbJKelMu4J3uNVdl+NPjPYc
   9oDR2kJ8XS9oSmk82rPw3eviHLpgkyjA99KlwPyxQ9EBNdn5w4TVhzEmB
   CkhU6KCOoaxQTAMD7e5RM06uc4a0Q4M654i1HiSD86zSOPHK7EFUJLKr+
   MO6OPZoiSJtfFk9FyEe9J/LdW5BF2wb2AGF6FouM6qks8W9dyHAjLq1v8
   Suj2d8XUASd4LTD2vmhYTbZ6WYTY6Z5tB98Nz7Q4Yd10ghgPH3lvmiRQ7
   K9NsNbCgOvIjLoAMihqR8y3QWRJ4qYO+SXY1Y0mxqTQyS28LkA7LJgch8
   w==;
X-CSE-ConnectionGUID: RW/6iDw5TvOKv9/1IJielw==
X-CSE-MsgGUID: +ulUJlDFRgqKjeZobX7QxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49128374"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="49128374"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 09:20:54 -0700
X-CSE-ConnectionGUID: f1OrtovNTi+KcOkAyn5WJw==
X-CSE-MsgGUID: SPG5zt9qSfe+SvhPmtgPhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="142973150"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 14 May 2025 09:20:48 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uFEqb-000HKl-1F;
	Wed, 14 May 2025 16:20:45 +0000
Date: Thu, 15 May 2025 00:20:27 +0800
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
Subject: Re: [PATCH v15 34/43] dept: make dept aware of
 lockdep_set_lock_cmp_fn() annotation
Message-ID: <202505150014.6SbTtVaA-lkp@intel.com>
References: <20250513100730.12664-35-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513100730.12664-35-byungchul@sk.com>

Hi Byungchul,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3]

url:    https://github.com/intel-lab-lkp/linux/commits/Byungchul-Park/llist-move-llist_-head-node-definition-to-types-h/20250513-181346
base:   82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3
patch link:    https://lore.kernel.org/r/20250513100730.12664-35-byungchul%40sk.com
patch subject: [PATCH v15 34/43] dept: make dept aware of lockdep_set_lock_cmp_fn() annotation
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20250515/202505150014.6SbTtVaA-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250515/202505150014.6SbTtVaA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505150014.6SbTtVaA-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/microchip/vcap/vcap_api.c:3610:
>> drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c:1921:13: warning: stack frame size (2104) exceeds limit (2048) in 'vcap_api_next_lookup_advanced_test' [-Wframe-larger-than]
    1921 | static void vcap_api_next_lookup_advanced_test(struct kunit *test)
         |             ^
   1 warning generated.


vim +/vcap_api_next_lookup_advanced_test +1921 drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c

c956b9b318d903 Steen Hegelund 2022-11-09  1920  
c956b9b318d903 Steen Hegelund 2022-11-09 @1921  static void vcap_api_next_lookup_advanced_test(struct kunit *test)
c956b9b318d903 Steen Hegelund 2022-11-09  1922  {
129ff4de58ff0c Arnd Bergmann  2023-02-17  1923  	struct vcap_admin admin[] = {
129ff4de58ff0c Arnd Bergmann  2023-02-17  1924  	{
c956b9b318d903 Steen Hegelund 2022-11-09  1925  		.vtype = VCAP_TYPE_IS0,
c956b9b318d903 Steen Hegelund 2022-11-09  1926  		.vinst = 0,
c956b9b318d903 Steen Hegelund 2022-11-09  1927  		.first_cid = 1000000,
c956b9b318d903 Steen Hegelund 2022-11-09  1928  		.last_cid =  1199999,
c956b9b318d903 Steen Hegelund 2022-11-09  1929  		.lookups = 6,
c956b9b318d903 Steen Hegelund 2022-11-09  1930  		.lookups_per_instance = 2,
129ff4de58ff0c Arnd Bergmann  2023-02-17  1931  	}, {
c956b9b318d903 Steen Hegelund 2022-11-09  1932  		.vtype = VCAP_TYPE_IS0,
c956b9b318d903 Steen Hegelund 2022-11-09  1933  		.vinst = 1,
c956b9b318d903 Steen Hegelund 2022-11-09  1934  		.first_cid = 1200000,
c956b9b318d903 Steen Hegelund 2022-11-09  1935  		.last_cid =  1399999,
c956b9b318d903 Steen Hegelund 2022-11-09  1936  		.lookups = 6,
c956b9b318d903 Steen Hegelund 2022-11-09  1937  		.lookups_per_instance = 2,
129ff4de58ff0c Arnd Bergmann  2023-02-17  1938  	}, {
c956b9b318d903 Steen Hegelund 2022-11-09  1939  		.vtype = VCAP_TYPE_IS0,
c956b9b318d903 Steen Hegelund 2022-11-09  1940  		.vinst = 2,
c956b9b318d903 Steen Hegelund 2022-11-09  1941  		.first_cid = 1400000,
c956b9b318d903 Steen Hegelund 2022-11-09  1942  		.last_cid =  1599999,
c956b9b318d903 Steen Hegelund 2022-11-09  1943  		.lookups = 6,
c956b9b318d903 Steen Hegelund 2022-11-09  1944  		.lookups_per_instance = 2,
129ff4de58ff0c Arnd Bergmann  2023-02-17  1945  	}, {
c956b9b318d903 Steen Hegelund 2022-11-09  1946  		.vtype = VCAP_TYPE_IS2,
c956b9b318d903 Steen Hegelund 2022-11-09  1947  		.vinst = 0,
c956b9b318d903 Steen Hegelund 2022-11-09  1948  		.first_cid = 8000000,
c956b9b318d903 Steen Hegelund 2022-11-09  1949  		.last_cid = 8199999,
c956b9b318d903 Steen Hegelund 2022-11-09  1950  		.lookups = 4,
c956b9b318d903 Steen Hegelund 2022-11-09  1951  		.lookups_per_instance = 2,
129ff4de58ff0c Arnd Bergmann  2023-02-17  1952  	}, {
c956b9b318d903 Steen Hegelund 2022-11-09  1953  		.vtype = VCAP_TYPE_IS2,
c956b9b318d903 Steen Hegelund 2022-11-09  1954  		.vinst = 1,
c956b9b318d903 Steen Hegelund 2022-11-09  1955  		.first_cid = 8200000,
c956b9b318d903 Steen Hegelund 2022-11-09  1956  		.last_cid = 8399999,
c956b9b318d903 Steen Hegelund 2022-11-09  1957  		.lookups = 4,
c956b9b318d903 Steen Hegelund 2022-11-09  1958  		.lookups_per_instance = 2,
129ff4de58ff0c Arnd Bergmann  2023-02-17  1959  	}
c956b9b318d903 Steen Hegelund 2022-11-09  1960  	};
c956b9b318d903 Steen Hegelund 2022-11-09  1961  	bool ret;
c956b9b318d903 Steen Hegelund 2022-11-09  1962  
129ff4de58ff0c Arnd Bergmann  2023-02-17  1963  	vcap_test_api_init(&admin[0]);
129ff4de58ff0c Arnd Bergmann  2023-02-17  1964  	list_add_tail(&admin[1].list, &test_vctrl.list);
129ff4de58ff0c Arnd Bergmann  2023-02-17  1965  	list_add_tail(&admin[2].list, &test_vctrl.list);
129ff4de58ff0c Arnd Bergmann  2023-02-17  1966  	list_add_tail(&admin[3].list, &test_vctrl.list);
129ff4de58ff0c Arnd Bergmann  2023-02-17  1967  	list_add_tail(&admin[4].list, &test_vctrl.list);
c956b9b318d903 Steen Hegelund 2022-11-09  1968  
c956b9b318d903 Steen Hegelund 2022-11-09  1969  	ret = vcap_is_next_lookup(&test_vctrl, 1000000, 1001000);
c956b9b318d903 Steen Hegelund 2022-11-09  1970  	KUNIT_EXPECT_EQ(test, false, ret);
c956b9b318d903 Steen Hegelund 2022-11-09  1971  	ret = vcap_is_next_lookup(&test_vctrl, 1000000, 1101000);
c956b9b318d903 Steen Hegelund 2022-11-09  1972  	KUNIT_EXPECT_EQ(test, true, ret);
c956b9b318d903 Steen Hegelund 2022-11-09  1973  
c956b9b318d903 Steen Hegelund 2022-11-09  1974  	ret = vcap_is_next_lookup(&test_vctrl, 1100000, 1201000);
c956b9b318d903 Steen Hegelund 2022-11-09  1975  	KUNIT_EXPECT_EQ(test, true, ret);
c956b9b318d903 Steen Hegelund 2022-11-09  1976  	ret = vcap_is_next_lookup(&test_vctrl, 1100000, 1301000);
784c3067d094dd Steen Hegelund 2023-01-14  1977  	KUNIT_EXPECT_EQ(test, true, ret);
c956b9b318d903 Steen Hegelund 2022-11-09  1978  	ret = vcap_is_next_lookup(&test_vctrl, 1100000, 8101000);
784c3067d094dd Steen Hegelund 2023-01-14  1979  	KUNIT_EXPECT_EQ(test, true, ret);
c956b9b318d903 Steen Hegelund 2022-11-09  1980  	ret = vcap_is_next_lookup(&test_vctrl, 1300000, 1401000);
c956b9b318d903 Steen Hegelund 2022-11-09  1981  	KUNIT_EXPECT_EQ(test, true, ret);
c956b9b318d903 Steen Hegelund 2022-11-09  1982  	ret = vcap_is_next_lookup(&test_vctrl, 1400000, 1501000);
c956b9b318d903 Steen Hegelund 2022-11-09  1983  	KUNIT_EXPECT_EQ(test, true, ret);
c956b9b318d903 Steen Hegelund 2022-11-09  1984  	ret = vcap_is_next_lookup(&test_vctrl, 1500000, 8001000);
c956b9b318d903 Steen Hegelund 2022-11-09  1985  	KUNIT_EXPECT_EQ(test, true, ret);
c956b9b318d903 Steen Hegelund 2022-11-09  1986  
c956b9b318d903 Steen Hegelund 2022-11-09  1987  	ret = vcap_is_next_lookup(&test_vctrl, 8000000, 8001000);
c956b9b318d903 Steen Hegelund 2022-11-09  1988  	KUNIT_EXPECT_EQ(test, false, ret);
c956b9b318d903 Steen Hegelund 2022-11-09  1989  	ret = vcap_is_next_lookup(&test_vctrl, 8000000, 8101000);
c956b9b318d903 Steen Hegelund 2022-11-09  1990  	KUNIT_EXPECT_EQ(test, true, ret);
c956b9b318d903 Steen Hegelund 2022-11-09  1991  
c956b9b318d903 Steen Hegelund 2022-11-09  1992  	ret = vcap_is_next_lookup(&test_vctrl, 8300000, 8301000);
c956b9b318d903 Steen Hegelund 2022-11-09  1993  	KUNIT_EXPECT_EQ(test, false, ret);
c956b9b318d903 Steen Hegelund 2022-11-09  1994  	ret = vcap_is_next_lookup(&test_vctrl, 8300000, 8401000);
784c3067d094dd Steen Hegelund 2023-01-14  1995  	KUNIT_EXPECT_EQ(test, false, ret);
c956b9b318d903 Steen Hegelund 2022-11-09  1996  }
c956b9b318d903 Steen Hegelund 2022-11-09  1997  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

