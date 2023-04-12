Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4321B6DFD52
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Apr 2023 20:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjDLSRb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Apr 2023 14:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjDLSR2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Apr 2023 14:17:28 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022F1769E;
        Wed, 12 Apr 2023 11:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681323444; x=1712859444;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y02E6hvkxtc5Gw89z3ATruCZ4MvvZMvsFhWaaNNs1sg=;
  b=KC7jdR20/LJ3U7cuFvDiGi4MQgO/KZGIQBhYdzNYoZ5ltT0B6DV7OpZg
   rgxtgUjdMfzU0iiev74FLe1tdvCTkkRunHHKC0VgkLFmf9LjyM/XD77J9
   5th7kO2QQBZZyorXseSD/mW71/WToZ70K51figiuYaWEjS9r0LkL2XKvB
   ++2EtV2mJTi3l377qVcQF3GjP23tzxpaozqn0lYUsiypE/WeomuCgAKKy
   /6dHx3kyZBzOsc7sOvxKQxd+c4kI4exK2iIyoESxnXpGdnZcAW7bUe6k0
   D515MCAv8q4KPSLIOIU0Tbx+gKLKrIilNdomlu2YGjwYSeXdjXsG7pYwn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="323606915"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="323606915"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 11:17:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="691633211"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="691633211"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 12 Apr 2023 11:17:21 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmf20-000XyP-1d;
        Wed, 12 Apr 2023 18:17:20 +0000
Date:   Thu, 13 Apr 2023 02:16:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ojaswin@linux.ibm.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: Re: [PATCH v2 18/19] ext4: add some kunit stub for mballoc kunit test
Message-ID: <202304130244.S0jqbqkn-lkp@intel.com>
References: <20230412172833.2317696-19-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412172833.2317696-19-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
config: powerpc-randconfig-r006-20230409 (https://download.01.org/0day-ci/archive/20230413/202304130244.S0jqbqkn-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 2c57868e2e877f73c339796c3374ae660bb77f0d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/357d528a1ead868fa038c4bfe426744ac7c34ea6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kemeng-Shi/ext4-fix-wrong-unit-use-in-ext4_mb_normalize_request/20230412-172757
        git checkout 357d528a1ead868fa038c4bfe426744ac7c34ea6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304130244.S0jqbqkn-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/ext4/balloc.c:275:15: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
           unsigned int group_desc;
                        ^
   fs/ext4/balloc.c:435:26: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
           struct ext4_group_desc *desc;
                                   ^
   fs/ext4/balloc.c:538:26: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
           struct ext4_group_desc *desc;
                                   ^
   3 warnings generated.
--
>> fs/ext4/mballoc.c:3752:12: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
           handle_t *handle = mc->handle;
                     ^
   1 warning generated.


vim +275 fs/ext4/balloc.c

717d50e4971b81 Andreas Dilger    2007-10-16  248  
ac27a0ec112a08 Dave Kleikamp     2006-10-11  249  /*
ac27a0ec112a08 Dave Kleikamp     2006-10-11  250   * The free blocks are managed by bitmaps.  A file system contains several
ac27a0ec112a08 Dave Kleikamp     2006-10-11  251   * blocks groups.  Each group contains 1 bitmap block for blocks, 1 bitmap
ac27a0ec112a08 Dave Kleikamp     2006-10-11  252   * block for inodes, N blocks for the inode table and data blocks.
ac27a0ec112a08 Dave Kleikamp     2006-10-11  253   *
ac27a0ec112a08 Dave Kleikamp     2006-10-11  254   * The file system contains group descriptors which are located after the
ac27a0ec112a08 Dave Kleikamp     2006-10-11  255   * super block.  Each descriptor contains the number of the bitmap block and
ac27a0ec112a08 Dave Kleikamp     2006-10-11  256   * the free blocks count in the block.  The descriptors are loaded in memory
e627432c2948d5 Aneesh Kumar K.V  2007-02-20  257   * when a file system is mounted (see ext4_fill_super).
ac27a0ec112a08 Dave Kleikamp     2006-10-11  258   */
ac27a0ec112a08 Dave Kleikamp     2006-10-11  259  
ac27a0ec112a08 Dave Kleikamp     2006-10-11  260  /**
617ba13b31fbf5 Mingming Cao      2006-10-11  261   * ext4_get_group_desc() -- load group descriptor from disk
ac27a0ec112a08 Dave Kleikamp     2006-10-11  262   * @sb:			super block
ac27a0ec112a08 Dave Kleikamp     2006-10-11  263   * @block_group:	given block group
ac27a0ec112a08 Dave Kleikamp     2006-10-11  264   * @bh:			pointer to the buffer head to store the block
ac27a0ec112a08 Dave Kleikamp     2006-10-11  265   *			group descriptor
ac27a0ec112a08 Dave Kleikamp     2006-10-11  266   */
617ba13b31fbf5 Mingming Cao      2006-10-11  267  struct ext4_group_desc * ext4_get_group_desc(struct super_block *sb,
fd2d42912f9f09 Avantika Mathur   2008-01-28  268  					     ext4_group_t block_group,
ac27a0ec112a08 Dave Kleikamp     2006-10-11  269  					     struct buffer_head **bh)
ac27a0ec112a08 Dave Kleikamp     2006-10-11  270  {
357d528a1ead86 Kemeng Shi        2023-04-13  271  #ifdef CONFIG_EXT4_KUNIT_TESTS
357d528a1ead86 Kemeng Shi        2023-04-13  272  	KUNIT_STATIC_STUB_REDIRECT(ext4_get_group_desc,
357d528a1ead86 Kemeng Shi        2023-04-13  273  				   sb, block_group, bh);
357d528a1ead86 Kemeng Shi        2023-04-13  274  #endif
498e5f24158da7 Theodore Ts'o     2008-11-05 @275  	unsigned int group_desc;
498e5f24158da7 Theodore Ts'o     2008-11-05  276  	unsigned int offset;
8df9675f8b498d Theodore Ts'o     2009-05-01  277  	ext4_group_t ngroups = ext4_get_groups_count(sb);
617ba13b31fbf5 Mingming Cao      2006-10-11  278  	struct ext4_group_desc *desc;
617ba13b31fbf5 Mingming Cao      2006-10-11  279  	struct ext4_sb_info *sbi = EXT4_SB(sb);
1d0c3924a92e69 Theodore Ts'o     2020-02-15  280  	struct buffer_head *bh_p;
ac27a0ec112a08 Dave Kleikamp     2006-10-11  281  
8df9675f8b498d Theodore Ts'o     2009-05-01  282  	if (block_group >= ngroups) {
12062dddda4509 Eric Sandeen      2010-02-15  283  		ext4_error(sb, "block_group >= groups_count - block_group = %u,"
12062dddda4509 Eric Sandeen      2010-02-15  284  			   " groups_count = %u", block_group, ngroups);
ac27a0ec112a08 Dave Kleikamp     2006-10-11  285  
ac27a0ec112a08 Dave Kleikamp     2006-10-11  286  		return NULL;
ac27a0ec112a08 Dave Kleikamp     2006-10-11  287  	}
ac27a0ec112a08 Dave Kleikamp     2006-10-11  288  
617ba13b31fbf5 Mingming Cao      2006-10-11  289  	group_desc = block_group >> EXT4_DESC_PER_BLOCK_BITS(sb);
617ba13b31fbf5 Mingming Cao      2006-10-11  290  	offset = block_group & (EXT4_DESC_PER_BLOCK(sb) - 1);
1d0c3924a92e69 Theodore Ts'o     2020-02-15  291  	bh_p = sbi_array_rcu_deref(sbi, s_group_desc, group_desc);
1d0c3924a92e69 Theodore Ts'o     2020-02-15  292  	/*
1d0c3924a92e69 Theodore Ts'o     2020-02-15  293  	 * sbi_array_rcu_deref returns with rcu unlocked, this is ok since
1d0c3924a92e69 Theodore Ts'o     2020-02-15  294  	 * the pointer being dereferenced won't be dereferenced again. By
1d0c3924a92e69 Theodore Ts'o     2020-02-15  295  	 * looking at the usage in add_new_gdb() the value isn't modified,
1d0c3924a92e69 Theodore Ts'o     2020-02-15  296  	 * just the pointer, and so it remains valid.
1d0c3924a92e69 Theodore Ts'o     2020-02-15  297  	 */
1d0c3924a92e69 Theodore Ts'o     2020-02-15  298  	if (!bh_p) {
12062dddda4509 Eric Sandeen      2010-02-15  299  		ext4_error(sb, "Group descriptor not loaded - "
498e5f24158da7 Theodore Ts'o     2008-11-05  300  			   "block_group = %u, group_desc = %u, desc = %u",
ac27a0ec112a08 Dave Kleikamp     2006-10-11  301  			   block_group, group_desc, offset);
ac27a0ec112a08 Dave Kleikamp     2006-10-11  302  		return NULL;
ac27a0ec112a08 Dave Kleikamp     2006-10-11  303  	}
ac27a0ec112a08 Dave Kleikamp     2006-10-11  304  
0d1ee42f27d30e Alexandre Ratchov 2006-10-11  305  	desc = (struct ext4_group_desc *)(
1d0c3924a92e69 Theodore Ts'o     2020-02-15  306  		(__u8 *)bh_p->b_data +
0d1ee42f27d30e Alexandre Ratchov 2006-10-11  307  		offset * EXT4_DESC_SIZE(sb));
ac27a0ec112a08 Dave Kleikamp     2006-10-11  308  	if (bh)
1d0c3924a92e69 Theodore Ts'o     2020-02-15  309  		*bh = bh_p;
0d1ee42f27d30e Alexandre Ratchov 2006-10-11  310  	return desc;
ac27a0ec112a08 Dave Kleikamp     2006-10-11  311  }
ac27a0ec112a08 Dave Kleikamp     2006-10-11  312  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
