Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCE9685D57
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Feb 2023 03:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjBAC2s (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 Jan 2023 21:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjBAC2s (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 31 Jan 2023 21:28:48 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DDAAD3D;
        Tue, 31 Jan 2023 18:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675218526; x=1706754526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=toLA3/CCNOUSAf7uhabNH7zDl/Gt2MCQkgKD0DBBBzQ=;
  b=CyqTowoo7gb046XOHOKKvP7o7WhsFhbjJy8tcX+8838I9/yEaoAKeGmk
   GbS0i7HhuSz0eQFbSbKv2sD+oLXDspGzwGbZfstkd4TxfqFyUKXlgQPYO
   Gig0QxUeaoRU1xdPNd5LzhlcXu+0WKxuQFXFuUau5wr0v+7MQMtaFU/SD
   K6Gx5nsUMHtMVLNDOUIDNKS6HwCfvo2/jPTF7R9K3xFwk89QoNbCDsFXr
   Kip0LusrdRWCPZ4ZzQVI/j8AwLrxeMDwwKXcU3yU1phD7OFAnmmo4h4EY
   7ujGYy9EZXJ3u/0XJdIeZ/R0UL7jkuPrEkkPBc2sGA3UIvDzA0etDGk/y
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="315989754"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="315989754"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 18:28:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="614685237"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="614685237"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 31 Jan 2023 18:28:38 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pN2rV-0004wA-1F;
        Wed, 01 Feb 2023 02:28:37 +0000
Date:   Wed, 1 Feb 2023 10:28:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Byungchul Park <max.byungchul.park@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, torvalds@linux-foundation.org,
        damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, will@kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org, joel@joelfernandes.org,
        sashal@kernel.org, daniel.vetter@ffwll.ch, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org
Subject: Re: [PATCH v9 05/25] dept: Tie to Lockdep and IRQ tracing
Message-ID: <202302011038.V1juoXv1-lkp@intel.com>
References: <1675154394-25598-6-git-send-email-max.byungchul.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675154394-25598-6-git-send-email-max.byungchul.park@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Byungchul,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/locking/core]
[also build test WARNING on tip/sched/core drm-misc/drm-misc-next linus/master v6.2-rc6 next-20230131]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Byungchul-Park/llist-Move-llist_-head-node-definition-to-types-h/20230131-164632
patch link:    https://lore.kernel.org/r/1675154394-25598-6-git-send-email-max.byungchul.park%40gmail.com
patch subject: [PATCH v9 05/25] dept: Tie to Lockdep and IRQ tracing
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20230201/202302011038.V1juoXv1-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ee619b0e7faff81e8b794e2adcdf9102d5bc83e8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Byungchul-Park/llist-Move-llist_-head-node-definition-to-types-h/20230131-164632
        git checkout ee619b0e7faff81e8b794e2adcdf9102d5bc83e8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/iommu/ drivers/scsi/qla2xxx/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/atomic.h:80,
                    from drivers/iommu/io-pgtable-arm.c:12:
   drivers/iommu/io-pgtable-arm.c: In function 'arm_lpae_install_table':
   include/linux/atomic/atomic-arch-fallback.h:60:32: error: implicit declaration of function 'arch_cmpxchg64'; did you mean 'arch_cmpxchg'? [-Werror=implicit-function-declaration]
      60 | #define arch_cmpxchg64_relaxed arch_cmpxchg64
         |                                ^~~~~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:1968:9: note: in expansion of macro 'arch_cmpxchg64_relaxed'
    1968 |         arch_cmpxchg64_relaxed(__ai_ptr, __VA_ARGS__); \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/io-pgtable-arm.c:330:15: note: in expansion of macro 'cmpxchg64_relaxed'
     330 |         old = cmpxchg64_relaxed(ptep, curr, new);
         |               ^~~~~~~~~~~~~~~~~
   drivers/iommu/io-pgtable-arm.c: In function 'arm_lpae_do_selftests':
>> drivers/iommu/io-pgtable-arm.c:1296:1: warning: the frame size of 1088 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    1296 | }
         | ^
   cc1: some warnings being treated as errors


vim +1296 drivers/iommu/io-pgtable-arm.c

fe4b991dcd84e0 Will Deacon        2014-11-17  1256  
fe4b991dcd84e0 Will Deacon        2014-11-17  1257  static int __init arm_lpae_do_selftests(void)
fe4b991dcd84e0 Will Deacon        2014-11-17  1258  {
9062c1d0bedacf Christophe JAILLET 2019-09-09  1259  	static const unsigned long pgsize[] __initconst = {
fe4b991dcd84e0 Will Deacon        2014-11-17  1260  		SZ_4K | SZ_2M | SZ_1G,
fe4b991dcd84e0 Will Deacon        2014-11-17  1261  		SZ_16K | SZ_32M,
fe4b991dcd84e0 Will Deacon        2014-11-17  1262  		SZ_64K | SZ_512M,
fe4b991dcd84e0 Will Deacon        2014-11-17  1263  	};
fe4b991dcd84e0 Will Deacon        2014-11-17  1264  
9062c1d0bedacf Christophe JAILLET 2019-09-09  1265  	static const unsigned int ias[] __initconst = {
fe4b991dcd84e0 Will Deacon        2014-11-17  1266  		32, 36, 40, 42, 44, 48,
fe4b991dcd84e0 Will Deacon        2014-11-17  1267  	};
fe4b991dcd84e0 Will Deacon        2014-11-17  1268  
fe4b991dcd84e0 Will Deacon        2014-11-17  1269  	int i, j, pass = 0, fail = 0;
ca25ec247aadbf Robin Murphy       2022-08-15  1270  	struct device dev;
fe4b991dcd84e0 Will Deacon        2014-11-17  1271  	struct io_pgtable_cfg cfg = {
fe4b991dcd84e0 Will Deacon        2014-11-17  1272  		.tlb = &dummy_tlb_ops,
fe4b991dcd84e0 Will Deacon        2014-11-17  1273  		.oas = 48,
4f41845b340783 Will Deacon        2019-06-25  1274  		.coherent_walk = true,
ca25ec247aadbf Robin Murphy       2022-08-15  1275  		.iommu_dev = &dev,
fe4b991dcd84e0 Will Deacon        2014-11-17  1276  	};
fe4b991dcd84e0 Will Deacon        2014-11-17  1277  
ca25ec247aadbf Robin Murphy       2022-08-15  1278  	/* __arm_lpae_alloc_pages() merely needs dev_to_node() to work */
ca25ec247aadbf Robin Murphy       2022-08-15  1279  	set_dev_node(&dev, NUMA_NO_NODE);
ca25ec247aadbf Robin Murphy       2022-08-15  1280  
fe4b991dcd84e0 Will Deacon        2014-11-17  1281  	for (i = 0; i < ARRAY_SIZE(pgsize); ++i) {
fe4b991dcd84e0 Will Deacon        2014-11-17  1282  		for (j = 0; j < ARRAY_SIZE(ias); ++j) {
fe4b991dcd84e0 Will Deacon        2014-11-17  1283  			cfg.pgsize_bitmap = pgsize[i];
fe4b991dcd84e0 Will Deacon        2014-11-17  1284  			cfg.ias = ias[j];
fe4b991dcd84e0 Will Deacon        2014-11-17  1285  			pr_info("selftest: pgsize_bitmap 0x%08lx, IAS %u\n",
fe4b991dcd84e0 Will Deacon        2014-11-17  1286  				pgsize[i], ias[j]);
fe4b991dcd84e0 Will Deacon        2014-11-17  1287  			if (arm_lpae_run_tests(&cfg))
fe4b991dcd84e0 Will Deacon        2014-11-17  1288  				fail++;
fe4b991dcd84e0 Will Deacon        2014-11-17  1289  			else
fe4b991dcd84e0 Will Deacon        2014-11-17  1290  				pass++;
fe4b991dcd84e0 Will Deacon        2014-11-17  1291  		}
fe4b991dcd84e0 Will Deacon        2014-11-17  1292  	}
fe4b991dcd84e0 Will Deacon        2014-11-17  1293  
fe4b991dcd84e0 Will Deacon        2014-11-17  1294  	pr_info("selftest: completed with %d PASS %d FAIL\n", pass, fail);
fe4b991dcd84e0 Will Deacon        2014-11-17  1295  	return fail ? -EFAULT : 0;
fe4b991dcd84e0 Will Deacon        2014-11-17 @1296  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
