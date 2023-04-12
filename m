Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E95E6DFF30
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Apr 2023 21:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjDLTwE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Apr 2023 15:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjDLTvv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Apr 2023 15:51:51 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10A72721;
        Wed, 12 Apr 2023 12:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681329077; x=1712865077;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ryrT6XXWVMCWWKoxwWscM+/CIkHlB0N4maaPhHLtx88=;
  b=QvrS3H92JE4xUuUSt3zV/7Cv4ewOyhh7E9rsXdFhIiF7hupbsZIBhUCe
   QYm5Nfboe0afoEp6bFwvEW9PFf25/UaLnvib27l9bMBEFuY/o+HEEEeZN
   szUik3L+rQ8R+dyyTh8dJhlCdD4X7c3P5ccEE0EuHbgXglHNzXXnnUsq2
   yDoY60smghEzGRLJAb0qqrXr8JUoZ5bmy2TgidXSkhvcE8TSkGNdBqRa4
   gDoGcBijaG7vfoXd16GBh8AiigZFD+hm4YMxtnA+hJEJx0kIhbY2ZM7wq
   oPQdaz0UqXE4eKEnKUXpsF7YMgVEqMWtnIC5rjf9a09KyGnMoaB7b33l6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="324366531"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="324366531"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 12:50:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="935258310"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="935258310"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 12 Apr 2023 12:50:22 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmgU2-000Y1R-0X;
        Wed, 12 Apr 2023 19:50:22 +0000
Date:   Thu, 13 Apr 2023 03:49:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ojaswin@linux.ibm.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: Re: [PATCH v2 19/19] ext4: add first unit test for
 ext4_mb_new_blocks_simple in mballoc
Message-ID: <202304130309.erdFVvYL-lkp@intel.com>
References: <20230412172833.2317696-20-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412172833.2317696-20-shikemeng@huaweicloud.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on tytso-ext4/dev]
[also build test ERROR on next-20230412]
[cannot apply to linus/master v6.3-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kemeng-Shi/ext4-fix-wrong-unit-use-in-ext4_mb_normalize_request/20230412-172757
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20230412172833.2317696-20-shikemeng%40huaweicloud.com
patch subject: [PATCH v2 19/19] ext4: add first unit test for ext4_mb_new_blocks_simple in mballoc
config: powerpc-randconfig-r006-20230409 (https://download.01.org/0day-ci/archive/20230413/202304130309.erdFVvYL-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 2c57868e2e877f73c339796c3374ae660bb77f0d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/3ceb1daf83fdf578c28ede1a10e55f05ef7642d5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kemeng-Shi/ext4-fix-wrong-unit-use-in-ext4_mb_normalize_request/20230412-172757
        git checkout 3ceb1daf83fdf578c28ede1a10e55f05ef7642d5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304130309.erdFVvYL-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   fs/ext4/mballoc.c:3752:12: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
           handle_t *handle = mc->handle;
                     ^
   In file included from fs/ext4/mballoc.c:6523:
>> fs/ext4/mballoc-test.c:107:31: error: casting from randomized structure pointer type 'struct super_block *' to 'struct mb_ctx *'
           struct mb_grp_ctx *grp_ctx = MB_GRP_CTX(sb, group);
                                        ^
   fs/ext4/mballoc-test.c:23:33: note: expanded from macro 'MB_GRP_CTX'
   #define MB_GRP_CTX(sb, group) (&MB_CTX(sb)->grp_ctx[group])
                                   ^
   fs/ext4/mballoc-test.c:22:21: note: expanded from macro 'MB_CTX'
   #define MB_CTX(sb) ((struct mb_ctx *)((struct super_block *)sb + 1))
                       ^
   fs/ext4/mballoc-test.c:115:23: error: casting from randomized structure pointer type 'struct super_block *' to 'struct mb_ctx *'
           struct mb_ctx *ctx = MB_CTX(sb);
                                ^
   fs/ext4/mballoc-test.c:22:21: note: expanded from macro 'MB_CTX'
   #define MB_CTX(sb) ((struct mb_ctx *)((struct super_block *)sb + 1))
                       ^
   fs/ext4/mballoc-test.c:144:23: error: casting from randomized structure pointer type 'struct super_block *' to 'struct mb_ctx *'
           struct mb_ctx *ctx = MB_CTX(sb);
                                ^
   fs/ext4/mballoc-test.c:22:21: note: expanded from macro 'MB_CTX'
   #define MB_CTX(sb) ((struct mb_ctx *)((struct super_block *)sb + 1))
                       ^
   fs/ext4/mballoc-test.c:156:31: error: casting from randomized structure pointer type 'struct super_block *' to 'struct mb_ctx *'
           struct mb_grp_ctx *grp_ctx = MB_GRP_CTX(sb, block_group);
                                        ^
   fs/ext4/mballoc-test.c:23:33: note: expanded from macro 'MB_GRP_CTX'
   #define MB_GRP_CTX(sb, group) (&MB_CTX(sb)->grp_ctx[group])
                                   ^
   fs/ext4/mballoc-test.c:22:21: note: expanded from macro 'MB_CTX'
   #define MB_CTX(sb) ((struct mb_ctx *)((struct super_block *)sb + 1))
                       ^
>> fs/ext4/mballoc-test.c:153:1: warning: no previous prototype for function 'ext4_read_block_bitmap_nowait_stub' [-Wmissing-prototypes]
   ext4_read_block_bitmap_nowait_stub(struct super_block *sb, ext4_group_t block_group,
   ^
   fs/ext4/mballoc-test.c:152:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct buffer_head *
   ^
   static 
>> fs/ext4/mballoc-test.c:162:5: warning: no previous prototype for function 'ext4_wait_block_bitmap_stub' [-Wmissing-prototypes]
   int ext4_wait_block_bitmap_stub(struct super_block *sb,
       ^
   fs/ext4/mballoc-test.c:162:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int ext4_wait_block_bitmap_stub(struct super_block *sb,
   ^
   static 
   fs/ext4/mballoc-test.c:173:31: error: casting from randomized structure pointer type 'struct super_block *' to 'struct mb_ctx *'
           struct mb_grp_ctx *grp_ctx = MB_GRP_CTX(sb, block_group);
                                        ^
   fs/ext4/mballoc-test.c:23:33: note: expanded from macro 'MB_GRP_CTX'
   #define MB_GRP_CTX(sb, group) (&MB_CTX(sb)->grp_ctx[group])
                                   ^
   fs/ext4/mballoc-test.c:22:21: note: expanded from macro 'MB_CTX'
   #define MB_CTX(sb) ((struct mb_ctx *)((struct super_block *)sb + 1))
                       ^
>> fs/ext4/mballoc-test.c:169:25: warning: no previous prototype for function 'ext4_get_group_desc_stub' [-Wmissing-prototypes]
   struct ext4_group_desc *ext4_get_group_desc_stub(struct super_block *sb,
                           ^
   fs/ext4/mballoc-test.c:169:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct ext4_group_desc *ext4_get_group_desc_stub(struct super_block *sb,
   ^
   static 
   fs/ext4/mballoc-test.c:185:31: error: casting from randomized structure pointer type 'struct super_block *' to 'struct mb_ctx *'
           struct mb_grp_ctx *grp_ctx = MB_GRP_CTX(mc->sb, group);
                                        ^
   fs/ext4/mballoc-test.c:23:33: note: expanded from macro 'MB_GRP_CTX'
   #define MB_GRP_CTX(sb, group) (&MB_CTX(sb)->grp_ctx[group])
                                   ^
   fs/ext4/mballoc-test.c:22:21: note: expanded from macro 'MB_CTX'
   #define MB_CTX(sb) ((struct mb_ctx *)((struct super_block *)sb + 1))
                       ^
>> fs/ext4/mballoc-test.c:181:5: warning: no previous prototype for function 'ext4_mb_mark_group_bb_stub' [-Wmissing-prototypes]
   int ext4_mb_mark_group_bb_stub(struct ext4_mark_context *mc,
       ^
   fs/ext4/mballoc-test.c:181:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int ext4_mb_mark_group_bb_stub(struct ext4_mark_context *mc,
   ^
   static 
   5 warnings and 6 errors generated.


vim +107 fs/ext4/mballoc-test.c

   103	
   104	static void mb_ctx_mark_used(struct super_block *sb, ext4_group_t group,
   105				     unsigned int start, unsigned int len)
   106	{
 > 107		struct mb_grp_ctx *grp_ctx = MB_GRP_CTX(sb, group);
   108	
   109		mb_set_bits(grp_ctx->bitmap_bh.b_data, start, len);
   110	}
   111	
   112	/* called after init_sb_layout */
   113	static int mb_ctx_init(struct super_block *sb)
   114	{
   115		struct mb_ctx *ctx = MB_CTX(sb);
   116		ext4_group_t i, ngroups = ext4_get_groups_count(sb);
   117	
   118		ctx->grp_ctx = kcalloc(ngroups, sizeof(struct mb_grp_ctx),
   119				       GFP_KERNEL);
   120		if (ctx->grp_ctx == NULL)
   121			return -ENOMEM;
   122	
   123		for (i = 0; i < ngroups; i++)
   124			if (mb_grp_ctx_init(sb, &ctx->grp_ctx[i]))
   125				goto out;
   126	
   127		/*
   128		 * first data block(first cluster in first group) is used by
   129		 * metadata, mark it used to avoid to alloc data block at first
   130		 * block which will fail ext4_sb_block_valid check.
   131		 */
   132		mb_set_bits(ctx->grp_ctx[0].bitmap_bh.b_data, 0, 1);
   133	
   134		return 0;
   135	out:
   136		while (i-- > 0)
   137			mb_grp_ctx_release(&ctx->grp_ctx[i]);
   138		kfree(ctx->grp_ctx);
   139		return -ENOMEM;
   140	}
   141	
   142	static void mb_ctx_release(struct super_block *sb)
   143	{
   144		struct mb_ctx *ctx = MB_CTX(sb);
   145		ext4_group_t i, ngroups = ext4_get_groups_count(sb);
   146	
   147		for (i = 0; i < ngroups; i++)
   148			mb_grp_ctx_release(&ctx->grp_ctx[i]);
   149		kfree(ctx->grp_ctx);
   150	}
   151	
   152	struct buffer_head *
 > 153	ext4_read_block_bitmap_nowait_stub(struct super_block *sb, ext4_group_t block_group,
   154					   bool ignore_locked)
   155	{
   156		struct mb_grp_ctx *grp_ctx = MB_GRP_CTX(sb, block_group);
   157	
   158		get_bh(&grp_ctx->bitmap_bh);
   159		return &grp_ctx->bitmap_bh;
   160	}
   161	
 > 162	int ext4_wait_block_bitmap_stub(struct super_block *sb,
   163					ext4_group_t block_group,
   164					struct buffer_head *bh)
   165	{
   166		return 0;
   167	}
   168	
 > 169	struct ext4_group_desc *ext4_get_group_desc_stub(struct super_block *sb,
   170						     ext4_group_t block_group,
   171						     struct buffer_head **bh)
   172	{
   173		struct mb_grp_ctx *grp_ctx = MB_GRP_CTX(sb, block_group);
   174	
   175		if (bh != NULL)
   176			*bh = &grp_ctx->gd_bh;
   177	
   178		return &grp_ctx->desc;
   179	}
   180	
 > 181	int ext4_mb_mark_group_bb_stub(struct ext4_mark_context *mc,
   182				       ext4_group_t group, ext4_grpblk_t blkoff,
   183				       ext4_grpblk_t len, int flags)
   184	{
   185		struct mb_grp_ctx *grp_ctx = MB_GRP_CTX(mc->sb, group);
   186		struct buffer_head *bitmap_bh = &grp_ctx->bitmap_bh;
   187	
   188		if (mc->state)
   189			mb_set_bits(bitmap_bh->b_data, blkoff, len);
   190		else
   191			mb_clear_bits(bitmap_bh->b_data, blkoff, len);
   192	
   193		return 0;
   194	}
   195	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
