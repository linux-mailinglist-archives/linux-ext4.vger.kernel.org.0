Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931956DFCE2
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Apr 2023 19:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjDLRqe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Apr 2023 13:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDLRqe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Apr 2023 13:46:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABE42697;
        Wed, 12 Apr 2023 10:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681321592; x=1712857592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mIg/PdOWqRtz6YIfoWbbfNd8QfS4uRg4EPBlGFTu+pE=;
  b=EHJg0zZeNfg0mqPg1wSdEndWf4y+P0mitxtoqDZrRHFZs3maRCOcG9f4
   8rc9UkOyomR32xfbpJ0wJ9SShTHpFpT99zegIym/54f1cAPPg6/tqj4Wj
   nt0P33GEr/VWGJwVcCr/eRcLO9qEGGVrp9ar7Z+04Wl1GpydJ8cLPq7Kt
   E6czAFnFQSt4bNKbmuLJSCnLA43+yPT/04G7zZLEuvS13pp1BAaJiis8K
   o2iVIHv0AWoVqGx7irAocyqjuCDJxH0BmOKhyUb/cDsIoJm5DdmOjpThZ
   IvP3uwFShYDzrvu7KFaAbIbsV42/RG1jEfaQ1rXqTSdJ7OoSn2UPunXHh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="406803188"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="406803188"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 10:46:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="682574205"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="682574205"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 12 Apr 2023 10:46:20 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmeY0-000XxZ-0A;
        Wed, 12 Apr 2023 17:46:20 +0000
Date:   Thu, 13 Apr 2023 01:45:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ojaswin@linux.ibm.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, shikemeng@huaweicloud.com
Subject: Re: [PATCH v2 18/19] ext4: add some kunit stub for mballoc kunit test
Message-ID: <202304130140.2kslXTgi-lkp@intel.com>
References: <20230412172833.2317696-19-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412172833.2317696-19-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Kemeng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tytso-ext4/dev]
[also build test WARNING on next-20230412]
[cannot apply to linus/master v6.3-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kemeng-Shi/ext4-fix-wrong-unit-use-in-ext4_mb_normalize_request/20230412-172757
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20230412172833.2317696-19-shikemeng%40huaweicloud.com
patch subject: [PATCH v2 18/19] ext4: add some kunit stub for mballoc kunit test
config: loongarch-randconfig-r004-20230409 (https://download.01.org/0day-ci/archive/20230413/202304130140.2kslXTgi-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/357d528a1ead868fa038c4bfe426744ac7c34ea6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kemeng-Shi/ext4-fix-wrong-unit-use-in-ext4_mb_normalize_request/20230412-172757
        git checkout 357d528a1ead868fa038c4bfe426744ac7c34ea6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304130140.2kslXTgi-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/ext4/mballoc.c: In function 'ext4_mb_mark_group_bb':
>> fs/ext4/mballoc.c:3752:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    3752 |         handle_t *handle = mc->handle;
         |         ^~~~~~~~
--
   fs/ext4/balloc.c: In function 'ext4_get_group_desc':
>> fs/ext4/balloc.c:275:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     275 |         unsigned int group_desc;
         |         ^~~~~~~~
   fs/ext4/balloc.c: In function 'ext4_read_block_bitmap_nowait':
   fs/ext4/balloc.c:435:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     435 |         struct ext4_group_desc *desc;
         |         ^~~~~~
   fs/ext4/balloc.c: In function 'ext4_wait_block_bitmap':
   fs/ext4/balloc.c:538:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     538 |         struct ext4_group_desc *desc;
         |         ^~~~~~


vim +3752 fs/ext4/mballoc.c

80cb2f14af5f5f Kemeng Shi 2023-04-13  3743  
80cb2f14af5f5f Kemeng Shi 2023-04-13  3744  static int
80cb2f14af5f5f Kemeng Shi 2023-04-13  3745  ext4_mb_mark_group_bb(struct ext4_mark_context *mc, ext4_group_t group,
a760807c4967d7 Kemeng Shi 2023-04-13  3746  		      ext4_grpblk_t blkoff, ext4_grpblk_t len, int flags)
80cb2f14af5f5f Kemeng Shi 2023-04-13  3747  {
357d528a1ead86 Kemeng Shi 2023-04-13  3748  #ifdef CONFIG_EXT4_KUNIT_TESTS
357d528a1ead86 Kemeng Shi 2023-04-13  3749  	KUNIT_STATIC_STUB_REDIRECT(ext4_mb_mark_group_bb,
357d528a1ead86 Kemeng Shi 2023-04-13  3750  				   mc, group, blkoff, len, flags);
357d528a1ead86 Kemeng Shi 2023-04-13  3751  #endif
a760807c4967d7 Kemeng Shi 2023-04-13 @3752  	handle_t *handle = mc->handle;
80cb2f14af5f5f Kemeng Shi 2023-04-13  3753  	struct super_block *sb = mc->sb;
80cb2f14af5f5f Kemeng Shi 2023-04-13  3754  	struct ext4_sb_info *sbi = EXT4_SB(sb);
80cb2f14af5f5f Kemeng Shi 2023-04-13  3755  	struct buffer_head *bitmap_bh = NULL;
80cb2f14af5f5f Kemeng Shi 2023-04-13  3756  	struct ext4_group_desc *gdp;
80cb2f14af5f5f Kemeng Shi 2023-04-13  3757  	struct buffer_head *gdp_bh;
80cb2f14af5f5f Kemeng Shi 2023-04-13  3758  	int err;
a760807c4967d7 Kemeng Shi 2023-04-13  3759  	unsigned int i, already, changed = len;
80cb2f14af5f5f Kemeng Shi 2023-04-13  3760  
a760807c4967d7 Kemeng Shi 2023-04-13  3761  	mc->changed = 0;
80cb2f14af5f5f Kemeng Shi 2023-04-13  3762  	bitmap_bh = ext4_read_block_bitmap(sb, group);
80cb2f14af5f5f Kemeng Shi 2023-04-13  3763  	if (IS_ERR(bitmap_bh))
80cb2f14af5f5f Kemeng Shi 2023-04-13  3764  		return PTR_ERR(bitmap_bh);
80cb2f14af5f5f Kemeng Shi 2023-04-13  3765  
a760807c4967d7 Kemeng Shi 2023-04-13  3766  	if (handle) {
a760807c4967d7 Kemeng Shi 2023-04-13  3767  		BUFFER_TRACE(bitmap_bh, "getting write access");
a760807c4967d7 Kemeng Shi 2023-04-13  3768  		err = ext4_journal_get_write_access(handle, sb, bitmap_bh,
a760807c4967d7 Kemeng Shi 2023-04-13  3769  						    EXT4_JTR_NONE);
a760807c4967d7 Kemeng Shi 2023-04-13  3770  		if (err)
a760807c4967d7 Kemeng Shi 2023-04-13  3771  			goto out_err;
a760807c4967d7 Kemeng Shi 2023-04-13  3772  	}
a760807c4967d7 Kemeng Shi 2023-04-13  3773  
80cb2f14af5f5f Kemeng Shi 2023-04-13  3774  	err = -EIO;
80cb2f14af5f5f Kemeng Shi 2023-04-13  3775  	gdp = ext4_get_group_desc(sb, group, &gdp_bh);
80cb2f14af5f5f Kemeng Shi 2023-04-13  3776  	if (!gdp)
80cb2f14af5f5f Kemeng Shi 2023-04-13  3777  		goto out_err;
80cb2f14af5f5f Kemeng Shi 2023-04-13  3778  
a760807c4967d7 Kemeng Shi 2023-04-13  3779  	if (handle) {
a760807c4967d7 Kemeng Shi 2023-04-13  3780  		BUFFER_TRACE(gdp_bh, "get_write_access");
a760807c4967d7 Kemeng Shi 2023-04-13  3781  		err = ext4_journal_get_write_access(handle, sb, gdp_bh,
a760807c4967d7 Kemeng Shi 2023-04-13  3782  						    EXT4_JTR_NONE);
a760807c4967d7 Kemeng Shi 2023-04-13  3783  		if (err)
a760807c4967d7 Kemeng Shi 2023-04-13  3784  			goto out_err;
a760807c4967d7 Kemeng Shi 2023-04-13  3785  	}
a760807c4967d7 Kemeng Shi 2023-04-13  3786  
80cb2f14af5f5f Kemeng Shi 2023-04-13  3787  	ext4_lock_group(sb, group);
80cb2f14af5f5f Kemeng Shi 2023-04-13  3788  	if (ext4_has_group_desc_csum(sb) &&
80cb2f14af5f5f Kemeng Shi 2023-04-13  3789  	    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
80cb2f14af5f5f Kemeng Shi 2023-04-13  3790  		gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
80cb2f14af5f5f Kemeng Shi 2023-04-13  3791  		ext4_free_group_clusters_set(sb, gdp,
80cb2f14af5f5f Kemeng Shi 2023-04-13  3792  			ext4_free_clusters_after_init(sb, group, gdp));
80cb2f14af5f5f Kemeng Shi 2023-04-13  3793  	}
80cb2f14af5f5f Kemeng Shi 2023-04-13  3794  
a760807c4967d7 Kemeng Shi 2023-04-13  3795  	if (flags & EXT4_MB_BITMAP_MARKED_CHECK) {
80cb2f14af5f5f Kemeng Shi 2023-04-13  3796  		already = 0;
80cb2f14af5f5f Kemeng Shi 2023-04-13  3797  		for (i = 0; i < len; i++)
80cb2f14af5f5f Kemeng Shi 2023-04-13  3798  			if (mb_test_bit(blkoff + i, bitmap_bh->b_data) ==
80cb2f14af5f5f Kemeng Shi 2023-04-13  3799  					mc->state)
80cb2f14af5f5f Kemeng Shi 2023-04-13  3800  				already++;
80cb2f14af5f5f Kemeng Shi 2023-04-13  3801  		changed = len - already;
a760807c4967d7 Kemeng Shi 2023-04-13  3802  	}
80cb2f14af5f5f Kemeng Shi 2023-04-13  3803  
80cb2f14af5f5f Kemeng Shi 2023-04-13  3804  	if (mc->state) {
80cb2f14af5f5f Kemeng Shi 2023-04-13  3805  		mb_set_bits(bitmap_bh->b_data, blkoff, len);
80cb2f14af5f5f Kemeng Shi 2023-04-13  3806  		ext4_free_group_clusters_set(sb, gdp,
80cb2f14af5f5f Kemeng Shi 2023-04-13  3807  			ext4_free_group_clusters(sb, gdp) - changed);
80cb2f14af5f5f Kemeng Shi 2023-04-13  3808  	} else {
80cb2f14af5f5f Kemeng Shi 2023-04-13  3809  		mb_clear_bits(bitmap_bh->b_data, blkoff, len);
80cb2f14af5f5f Kemeng Shi 2023-04-13  3810  		ext4_free_group_clusters_set(sb, gdp,
80cb2f14af5f5f Kemeng Shi 2023-04-13  3811  			ext4_free_group_clusters(sb, gdp) + changed);
80cb2f14af5f5f Kemeng Shi 2023-04-13  3812  	}
80cb2f14af5f5f Kemeng Shi 2023-04-13  3813  
80cb2f14af5f5f Kemeng Shi 2023-04-13  3814  	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
80cb2f14af5f5f Kemeng Shi 2023-04-13  3815  	ext4_group_desc_csum_set(sb, group, gdp);
80cb2f14af5f5f Kemeng Shi 2023-04-13  3816  	ext4_unlock_group(sb, group);
a760807c4967d7 Kemeng Shi 2023-04-13  3817  	mc->changed = changed;
80cb2f14af5f5f Kemeng Shi 2023-04-13  3818  
80cb2f14af5f5f Kemeng Shi 2023-04-13  3819  	if (sbi->s_log_groups_per_flex) {
80cb2f14af5f5f Kemeng Shi 2023-04-13  3820  		ext4_group_t flex_group = ext4_flex_group(sbi, group);
80cb2f14af5f5f Kemeng Shi 2023-04-13  3821  		struct flex_groups *fg = sbi_array_rcu_deref(sbi,
80cb2f14af5f5f Kemeng Shi 2023-04-13  3822  					   s_flex_groups, flex_group);
80cb2f14af5f5f Kemeng Shi 2023-04-13  3823  
80cb2f14af5f5f Kemeng Shi 2023-04-13  3824  		if (mc->state)
80cb2f14af5f5f Kemeng Shi 2023-04-13  3825  			atomic64_sub(changed, &fg->free_clusters);
80cb2f14af5f5f Kemeng Shi 2023-04-13  3826  		else
80cb2f14af5f5f Kemeng Shi 2023-04-13  3827  			atomic64_add(changed, &fg->free_clusters);
80cb2f14af5f5f Kemeng Shi 2023-04-13  3828  	}
80cb2f14af5f5f Kemeng Shi 2023-04-13  3829  
a760807c4967d7 Kemeng Shi 2023-04-13  3830  	err = ext4_handle_dirty_metadata(handle, NULL, bitmap_bh);
80cb2f14af5f5f Kemeng Shi 2023-04-13  3831  	if (err)
80cb2f14af5f5f Kemeng Shi 2023-04-13  3832  		goto out_err;
a760807c4967d7 Kemeng Shi 2023-04-13  3833  	err = ext4_handle_dirty_metadata(handle, NULL, gdp_bh);
80cb2f14af5f5f Kemeng Shi 2023-04-13  3834  	if (err)
80cb2f14af5f5f Kemeng Shi 2023-04-13  3835  		goto out_err;
80cb2f14af5f5f Kemeng Shi 2023-04-13  3836  
a760807c4967d7 Kemeng Shi 2023-04-13  3837  	if (flags & EXT4_MB_SYNC_UPDATE) {
80cb2f14af5f5f Kemeng Shi 2023-04-13  3838  		sync_dirty_buffer(bitmap_bh);
80cb2f14af5f5f Kemeng Shi 2023-04-13  3839  		sync_dirty_buffer(gdp_bh);
a760807c4967d7 Kemeng Shi 2023-04-13  3840  	}
80cb2f14af5f5f Kemeng Shi 2023-04-13  3841  
80cb2f14af5f5f Kemeng Shi 2023-04-13  3842  out_err:
80cb2f14af5f5f Kemeng Shi 2023-04-13  3843  	brelse(bitmap_bh);
80cb2f14af5f5f Kemeng Shi 2023-04-13  3844  	return err;
80cb2f14af5f5f Kemeng Shi 2023-04-13  3845  }
c9de560ded61fa Alex Tomas 2008-01-29  3846  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
