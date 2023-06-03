Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD220721174
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Jun 2023 19:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjFCR7u (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 3 Jun 2023 13:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjFCR7t (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 3 Jun 2023 13:59:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C528132
        for <linux-ext4@vger.kernel.org>; Sat,  3 Jun 2023 10:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685815188; x=1717351188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jgq+1rYwmgzHnud/Ohp248BNKPfvXLplI2J4Bycqv5M=;
  b=jFP+18D6+YUPRAglcryNmTW88IBvM8axuHrplLLRm9YFBjMJ5Yzr+dq/
   oUEcZoe3EUhczwjwCevZt0ihVNDv9qYJ4Ec9oRl43wgIsWEdfyvsk6NTg
   sejQz3yA1AlsaO5Vluvpuqac5vocSrpnzY3LGOXgpn/h4/NKSko1LlDA3
   O0uO3ajR7IDy2gdRvwmSfQb5RYcImK17AcYDtEytB6XXbk8X0vB72aaUX
   10UFs9ad4JB/YTWYl4zItFpGnCoLOoDXMiTQrn902yfVODlukmhqFEvEm
   b8OozzwwK/KhUeTobX/yULyzPpGx2D5WGQrGxiK+H1BjLDRGhse3qm6Qy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="442474519"
X-IronPort-AV: E=Sophos;i="6.00,216,1681196400"; 
   d="scan'208";a="442474519"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2023 10:59:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="711317210"
X-IronPort-AV: E=Sophos;i="6.00,216,1681196400"; 
   d="scan'208";a="711317210"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jun 2023 10:59:46 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q5VXV-0001rl-2M;
        Sat, 03 Jun 2023 17:59:45 +0000
Date:   Sun, 4 Jun 2023 01:59:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wang Jianjian <wangjianjian0@foxmail.com>,
        linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     oe-kbuild-all@lists.linux.dev, wangjianjian0@foxmail.com
Subject: Re: [PATCH] ext4: Add correct group descriptors and reserved GDT
 blocks to system zone
Message-ID: <202306040126.Feq16jJP-lkp@intel.com>
References: <tencent_4A474CC049B9E77D0F172468991EED5B9105@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_4A474CC049B9E77D0F172468991EED5B9105@qq.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Wang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tytso-ext4/dev]
[also build test WARNING on linus/master v6.4-rc4 next-20230602]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wang-Jianjian/ext4-Add-correct-group-descriptors-and-reserved-GDT-blocks-to-system-zone/20230604-003439
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/tencent_4A474CC049B9E77D0F172468991EED5B9105%40qq.com
patch subject: [PATCH] ext4: Add correct group descriptors and reserved GDT blocks to system zone
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20230604/202306040126.Feq16jJP-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/54ea70d6b1189628ed4017129457d77e0bfa7fde
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Wang-Jianjian/ext4-Add-correct-group-descriptors-and-reserved-GDT-blocks-to-system-zone/20230604-003439
        git checkout 54ea70d6b1189628ed4017129457d77e0bfa7fde
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/ext4/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306040126.Feq16jJP-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/ext4/block_validity.c: In function 'ext4_setup_system_zone':
>> fs/ext4/block_validity.c:226:17: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     226 |                 unsigned int sb_num = ext4_bg_has_super(sb, i);
         |                 ^~~~~~~~
   In file included from include/linux/byteorder/little_endian.h:5,
                    from arch/x86/include/uapi/asm/byteorder.h:5,
                    from arch/x86/include/asm/orc_types.h:49,
                    from arch/x86/include/asm/unwind_hints.h:6,
                    from arch/x86/include/asm/nospec-branch.h:13,
                    from arch/x86/include/asm/paravirt_types.h:27,
                    from arch/x86/include/asm/ptrace.h:97,
                    from arch/x86/include/asm/math_emu.h:5,
                    from arch/x86/include/asm/processor.h:13,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from fs/ext4/block_validity.c:12:
   fs/ext4/block_validity.c:228:58: error: 'struct ext4_sb_info' has no member named 'es'; did you mean 's_es'?
     228 |                 unsigned int rsvd_gdt = le16_to_cpu(sbi->es->s_reserved_gdt_blocks);
         |                                                          ^~
   include/uapi/linux/byteorder/little_endian.h:37:51: note: in definition of macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   fs/ext4/block_validity.c:228:41: note: in expansion of macro 'le16_to_cpu'
     228 |                 unsigned int rsvd_gdt = le16_to_cpu(sbi->es->s_reserved_gdt_blocks);
         |                                         ^~~~~~~~~~~


vim +226 fs/ext4/block_validity.c

   201	
   202	/*
   203	 * Build system zone rbtree which is used for block validity checking.
   204	 *
   205	 * The update of system_blks pointer in this function is protected by
   206	 * sb->s_umount semaphore. However we have to be careful as we can be
   207	 * racing with ext4_inode_block_valid() calls reading system_blks rbtree
   208	 * protected only by RCU. That's why we first build the rbtree and then
   209	 * swap it in place.
   210	 */
   211	int ext4_setup_system_zone(struct super_block *sb)
   212	{
   213		ext4_group_t ngroups = ext4_get_groups_count(sb);
   214		struct ext4_sb_info *sbi = EXT4_SB(sb);
   215		struct ext4_system_blocks *system_blks;
   216		struct ext4_group_desc *gdp;
   217		ext4_group_t i;
   218		int ret;
   219	
   220		system_blks = kzalloc(sizeof(*system_blks), GFP_KERNEL);
   221		if (!system_blks)
   222			return -ENOMEM;
   223	
   224		for (i=0; i < ngroups; i++) {
   225			cond_resched();
 > 226			unsigned int sb_num = ext4_bg_has_super(sb, i);
   227			unsigned long gdb_num = ext4_bg_num_gdb(sb, i);
   228			unsigned int rsvd_gdt = le16_to_cpu(sbi->es->s_reserved_gdt_blocks);
   229	
   230			if (sb_num != 0 || gdb_num != 0) {
   231				ret = add_system_zone(system_blks,
   232						ext4_group_first_block_no(sb, i),
   233						sb_num + gdb_num + rsvd_gdt, 0);
   234				if (ret)
   235					goto err;
   236			}
   237			gdp = ext4_get_group_desc(sb, i, NULL);
   238			ret = add_system_zone(system_blks,
   239					ext4_block_bitmap(sb, gdp), 1, 0);
   240			if (ret)
   241				goto err;
   242			ret = add_system_zone(system_blks,
   243					ext4_inode_bitmap(sb, gdp), 1, 0);
   244			if (ret)
   245				goto err;
   246			ret = add_system_zone(system_blks,
   247					ext4_inode_table(sb, gdp),
   248					sbi->s_itb_per_group, 0);
   249			if (ret)
   250				goto err;
   251		}
   252		if (ext4_has_feature_journal(sb) && sbi->s_es->s_journal_inum) {
   253			ret = ext4_protect_reserved_inode(sb, system_blks,
   254					le32_to_cpu(sbi->s_es->s_journal_inum));
   255			if (ret)
   256				goto err;
   257		}
   258	
   259		/*
   260		 * System blks rbtree complete, announce it once to prevent racing
   261		 * with ext4_inode_block_valid() accessing the rbtree at the same
   262		 * time.
   263		 */
   264		rcu_assign_pointer(sbi->s_system_blks, system_blks);
   265	
   266		if (test_opt(sb, DEBUG))
   267			debug_print_tree(sbi);
   268		return 0;
   269	err:
   270		release_system_zone(system_blks);
   271		kfree(system_blks);
   272		return ret;
   273	}
   274	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
