Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE3372117D
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Jun 2023 20:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjFCSKv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 3 Jun 2023 14:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFCSKu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 3 Jun 2023 14:10:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A132132
        for <linux-ext4@vger.kernel.org>; Sat,  3 Jun 2023 11:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685815849; x=1717351849;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PiVxAOBplKPVqLeSZYeQJUUaCvkuH2sLLrPQWUz/1zU=;
  b=kw8NX4N+2teN7OzI2RHRO/hu4yh2jFUqF8MmqZUGW86GlQkUIDwLJiAP
   crgKZlc348vDeV5PCgPNnNQtMeeuIJ4IPTtUYwQKCRKhGY9Q9W47P83Uc
   aCZaTavGigqP40VfXU8c2DWY3vz+nbiTnSpBhsRj8EmOw2T/zxNUaUzAn
   CWiYkOaCGtuSlb/IY9QUYV0g13fh4Fz7LOxlVXiwW0z8eVU7HUF3Fx/W6
   EtnM9GcN4LIcGEo/+gjgm1wvuxQRFiN15tEK/jBfp0R9ROef+qzcpiAoM
   kCR7YR55iAL6/7sWcX6HhGcsdz4pae1+kJjFzAL/PDLKkVOQTPDi2ulXi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="340735527"
X-IronPort-AV: E=Sophos;i="6.00,216,1681196400"; 
   d="scan'208";a="340735527"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2023 11:10:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="882422250"
X-IronPort-AV: E=Sophos;i="6.00,216,1681196400"; 
   d="scan'208";a="882422250"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 03 Jun 2023 11:10:46 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q5ViA-0001sF-0b;
        Sat, 03 Jun 2023 18:10:46 +0000
Date:   Sun, 4 Jun 2023 02:10:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wang Jianjian <wangjianjian0@foxmail.com>,
        linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        wangjianjian0@foxmail.com
Subject: Re: [PATCH] ext4: Add correct group descriptors and reserved GDT
 blocks to system zone
Message-ID: <202306040223.dXAuRONL-lkp@intel.com>
References: <tencent_4A474CC049B9E77D0F172468991EED5B9105@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_4A474CC049B9E77D0F172468991EED5B9105@qq.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Wang,

kernel test robot noticed the following build errors:

[auto build test ERROR on tytso-ext4/dev]
[also build test ERROR on linus/master v6.4-rc4 next-20230602]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wang-Jianjian/ext4-Add-correct-group-descriptors-and-reserved-GDT-blocks-to-system-zone/20230604-003439
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/tencent_4A474CC049B9E77D0F172468991EED5B9105%40qq.com
patch subject: [PATCH] ext4: Add correct group descriptors and reserved GDT blocks to system zone
config: hexagon-randconfig-r041-20230604 (https://download.01.org/0day-ci/archive/20230604/202306040223.dXAuRONL-lkp@intel.com/config)
compiler: clang version 15.0.4 (https://github.com/llvm/llvm-project 5c68a1cb123161b54b72ce90e7975d95a8eaf2a4)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/54ea70d6b1189628ed4017129457d77e0bfa7fde
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Wang-Jianjian/ext4-Add-correct-group-descriptors-and-reserved-GDT-blocks-to-system-zone/20230604-003439
        git checkout 54ea70d6b1189628ed4017129457d77e0bfa7fde
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/ext4/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306040223.dXAuRONL-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from fs/ext4/block_validity.c:16:
   In file included from include/linux/buffer_head.h:12:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from fs/ext4/block_validity.c:16:
   In file included from include/linux/buffer_head.h:12:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from fs/ext4/block_validity.c:16:
   In file included from include/linux/buffer_head.h:12:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> fs/ext4/block_validity.c:228:44: error: no member named 'es' in 'struct ext4_sb_info'
                   unsigned int rsvd_gdt = le16_to_cpu(sbi->es->s_reserved_gdt_blocks);
                                                       ~~~  ^
   include/linux/byteorder/generic.h:91:21: note: expanded from macro 'le16_to_cpu'
   #define le16_to_cpu __le16_to_cpu
                       ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
>> fs/ext4/block_validity.c:226:16: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                   unsigned int sb_num = ext4_bg_has_super(sb, i);
                                ^
   7 warnings and 1 error generated.


vim +228 fs/ext4/block_validity.c

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
 > 228			unsigned int rsvd_gdt = le16_to_cpu(sbi->es->s_reserved_gdt_blocks);
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
