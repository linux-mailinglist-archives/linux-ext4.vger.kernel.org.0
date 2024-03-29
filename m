Return-Path: <linux-ext4+bounces-1778-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF31891453
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Mar 2024 08:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A432F287916
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Mar 2024 07:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2152C40BEA;
	Fri, 29 Mar 2024 07:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mIaO5oMs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEBB40863;
	Fri, 29 Mar 2024 07:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711697265; cv=none; b=mhgmxgElQWfVwfwGcq1e7x1VrYRyc/PCOPKfu95dpZO9kdGB/8jT66j6QtPjmkwsN3oM5+RHvD+hC/mtB9l6raMsS9PeTWovg5Mo3rVJCDWYEW1L5kGrb8gV5XSPG+MXw/QoWqAny5HHsXQJ9vXsapIyWGTi7jeV5fflAk+cME4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711697265; c=relaxed/simple;
	bh=gA68YKZWnmU308KH7pbZZOpx5P0ZYUuWUuzDeWNs53Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pc6jPxgf60Jamf+txga1AdEtwHb7QIaTIvPiq0Boy+G9SCOKptOdeO/CRrpa4FRIVtiVZrgU49h2437+Qg/WVuo9ReqIq3OV8mXNXUq2mYQIw1f1qCShWpBrqOZubUB/IqsoHheKwbocASK7MHT4Zm8kBCPadXETToZMu0N3eZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mIaO5oMs; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711697263; x=1743233263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gA68YKZWnmU308KH7pbZZOpx5P0ZYUuWUuzDeWNs53Y=;
  b=mIaO5oMsKHSi7IguAcUXQDKVLeDTr+GPcdtmD7/i2qhex1H0x8Cjq5Xt
   G8PIsAGEXYFvk+XkLsP3xdInfAgZoAxTFBccCZCoF+W31Th9Aqf9/TjVX
   5jU/52hiAtjzyQJ2zxYO0fQzPUZ+XXJl7WK/C4fe3G5kjRPpe6PZFNtoT
   Qdee9jP64tEqoWPh6kPkQmFJ1mch7zJ79CgXn1CM9pEf5ejsvwpRbgAaZ
   06waAYhTgk1vK7leUYsMM3fE3jxBwA2urWM3rqt8M4KINp5JpCzckxqxc
   W6r+t36gLAZvXjhexImklBCM6FSTIHF3wNkf3yfpkjIN3uwOQT/PCAFj2
   A==;
X-CSE-ConnectionGUID: G12mf7JfRXOM7NtiHSsXjw==
X-CSE-MsgGUID: c40ehaqYQA+moPWuDZVvGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="17604806"
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="17604806"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 00:27:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="40053301"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 29 Mar 2024 00:27:40 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rq6eH-0002x0-0z;
	Fri, 29 Mar 2024 07:27:37 +0000
Date: Fri, 29 Mar 2024 15:26:57 +0800
From: kernel test robot <lkp@intel.com>
To: Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jack@suse.cz, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com
Subject: Re: [PATCH 2/5] ext4: add test_mb_mark_used_cost to estimate cost of
 mb_mark_used
Message-ID: <202403291544.lxme27eF-lkp@intel.com>
References: <20240326213823.528302-3-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326213823.528302-3-shikemeng@huaweicloud.com>

Hi Kemeng,

kernel test robot noticed the following build errors:

[auto build test ERROR on tytso-ext4/dev]
[also build test ERROR on linus/master v6.9-rc1 next-20240328]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kemeng-Shi/ext4-keep-prefetch_grp-and-nr-consistent/20240326-214754
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20240326213823.528302-3-shikemeng%40huaweicloud.com
patch subject: [PATCH 2/5] ext4: add test_mb_mark_used_cost to estimate cost of mb_mark_used
config: x86_64-randconfig-072-20240329 (https://download.01.org/0day-ci/archive/20240329/202403291544.lxme27eF-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240329/202403291544.lxme27eF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403291544.lxme27eF-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/kunit/static_stub.h:18:0,
                    from fs/ext4/mballoc.c:21:
>> fs/ext4/mballoc-test.c:959:10: error: initializer element is not constant
             slow_attr),
             ^
   include/kunit/test.h:218:13: note: in definition of macro 'KUNIT_CASE_PARAM_ATTR'
        .attr = attributes, .module_name = KBUILD_MODNAME}
                ^~~~~~~~~~
   fs/ext4/mballoc-test.c:959:10: note: (near initialization for 'mbt_test_cases[6].attr')
             slow_attr),
             ^
   include/kunit/test.h:218:13: note: in definition of macro 'KUNIT_CASE_PARAM_ATTR'
        .attr = attributes, .module_name = KBUILD_MODNAME}
                ^~~~~~~~~~


vim +959 fs/ext4/mballoc-test.c

   950	
   951	static struct kunit_case mbt_test_cases[] = {
   952		KUNIT_CASE_PARAM(test_new_blocks_simple, mbt_layouts_gen_params),
   953		KUNIT_CASE_PARAM(test_free_blocks_simple, mbt_layouts_gen_params),
   954		KUNIT_CASE_PARAM(test_mb_generate_buddy, mbt_layouts_gen_params),
   955		KUNIT_CASE_PARAM(test_mb_mark_used, mbt_layouts_gen_params),
   956		KUNIT_CASE_PARAM(test_mb_free_blocks, mbt_layouts_gen_params),
   957		KUNIT_CASE_PARAM(test_mark_diskspace_used, mbt_layouts_gen_params),
   958		KUNIT_CASE_PARAM_ATTR(test_mb_mark_used_cost, mbt_layouts_gen_params,
 > 959				      slow_attr),
   960		{}
   961	};
   962	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

