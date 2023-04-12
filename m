Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889106DFD54
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Apr 2023 20:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjDLSRs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Apr 2023 14:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjDLSRl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Apr 2023 14:17:41 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDBA186;
        Wed, 12 Apr 2023 11:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681323451; x=1712859451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7wmrE/oNWqq+jjiM4+RpoxzFAdJzUC6mUqnrHGpjgBM=;
  b=A+zKXy7fPEna7t4/Sk/3Xxk0dTorj/iNJcL2aNTi1JorT6Um1E38k2qZ
   zki0n1x6qXCgAhHfdhLCgZIxY8J5yETE21pUtSgRwLJjIHB91NcT9swng
   lvqIb+BwULP7omrtp3nebMH9io7ILY8Fht3NzE7P10OoEwUKm7DhK/sis
   FgHeEn8TuxARwhujJBkTXg9jgVHq+qGXD2oTAexkJewy6iGGsRUGkKzrv
   tK//q9VuyzoifqSagVd4z8wa3aiZiH31hbr0gBraGT5atH1mTFX3xsqXa
   /4JcUmLoXSDAnlumcZzPMerPo/v2jG2f+UNoj7YU0Y7Gkl9qhYSFd94Iz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="328096685"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="328096685"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 11:17:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="753641775"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="753641775"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 12 Apr 2023 11:17:21 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmf20-000XyN-1X;
        Wed, 12 Apr 2023 18:17:20 +0000
Date:   Thu, 13 Apr 2023 02:16:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ojaswin@linux.ibm.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: Re: [PATCH v2 19/19] ext4: add first unit test for
 ext4_mb_new_blocks_simple in mballoc
Message-ID: <202304130218.GUkZVdgG-lkp@intel.com>
References: <20230412172833.2317696-20-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412172833.2317696-20-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
config: hexagon-randconfig-r013-20230410 (https://download.01.org/0day-ci/archive/20230413/202304130218.GUkZVdgG-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 2c57868e2e877f73c339796c3374ae660bb77f0d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3ceb1daf83fdf578c28ede1a10e55f05ef7642d5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kemeng-Shi/ext4-fix-wrong-unit-use-in-ext4_mb_normalize_request/20230412-172757
        git checkout 3ceb1daf83fdf578c28ede1a10e55f05ef7642d5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304130218.GUkZVdgG-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/ext4/mballoc.c:12:
   In file included from fs/ext4/ext4_jbd2.h:16:
   In file included from include/linux/jbd2.h:23:
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
   In file included from fs/ext4/mballoc.c:12:
   In file included from fs/ext4/ext4_jbd2.h:16:
   In file included from include/linux/jbd2.h:23:
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
   In file included from fs/ext4/mballoc.c:12:
   In file included from fs/ext4/ext4_jbd2.h:16:
   In file included from include/linux/jbd2.h:23:
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
   fs/ext4/mballoc-test.c:153:1: warning: no previous prototype for function 'ext4_read_block_bitmap_nowait_stub' [-Wmissing-prototypes]
   ext4_read_block_bitmap_nowait_stub(struct super_block *sb, ext4_group_t block_group,
   ^
   fs/ext4/mballoc-test.c:152:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct buffer_head *
   ^
   static 
   fs/ext4/mballoc-test.c:162:5: warning: no previous prototype for function 'ext4_wait_block_bitmap_stub' [-Wmissing-prototypes]
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
   fs/ext4/mballoc-test.c:169:25: warning: no previous prototype for function 'ext4_get_group_desc_stub' [-Wmissing-prototypes]
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
   fs/ext4/mballoc-test.c:181:5: warning: no previous prototype for function 'ext4_mb_mark_group_bb_stub' [-Wmissing-prototypes]
   int ext4_mb_mark_group_bb_stub(struct ext4_mark_context *mc,
       ^
   fs/ext4/mballoc-test.c:181:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int ext4_mb_mark_group_bb_stub(struct ext4_mark_context *mc,
   ^
   static 
   11 warnings and 6 errors generated.


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

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
