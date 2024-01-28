Return-Path: <linux-ext4+bounces-988-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F59C83F58E
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jan 2024 14:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01040B21A4D
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jan 2024 13:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7E222F1E;
	Sun, 28 Jan 2024 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NO1ioS8Z"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA2023763;
	Sun, 28 Jan 2024 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706447439; cv=none; b=kdNS4pFv+sN0cunxKxiFHDxpcfpnVKUy8dOFDkQove0wSYaE907xqn1smy+xEL9blsZ3wEZYjo8fyoNdz0n/1ZCPHfbBHnAtyMYv+WPrhf4fKM8Xjpj0hzjXGkv/8JlonDTBV7zi9PI1F3Uyqwjcfbate+DkTOtUGzLvb/zBu2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706447439; c=relaxed/simple;
	bh=RQCFKqCSZ8PKHaLcxG5XoPIii7CJX96qAZHOGC0dsIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ea7t+/mbXmaNojFVLJf2DqUPorr1AUXIdKAscw0k2L081gfgYZNp2pQ0xAWn0oU+tRPlg6NtPtfbZ0lCjhKkImH7Cm6CfjclPcKtBV7ItGaPfyQxEtyYikI5s6pwpD4RW10hy9aAuD9GnmXcj70Gm4aHYdfLIApwArtPSdvToMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NO1ioS8Z; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706447438; x=1737983438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RQCFKqCSZ8PKHaLcxG5XoPIii7CJX96qAZHOGC0dsIU=;
  b=NO1ioS8ZofDPmBHERYmVa23PcABdzmp1ddbGFI8OchDe3GSE1gRP6mtw
   UDPlvoQDH88R1nes1yjA2dZhZA5ltS6Jiz8qbc4GsPGlIJOgCjYGI+Lww
   hp3H8YkfpHDS2E4kyN+CQ0mwYo9sdkMnn9JABEv04gPgR8onRShm1N0/B
   fPcJJli9L+nRAx0H5f2moXb0xaKCw3CVEiMhNkOL+hjSO8cpxtw7v77KX
   C8Ep4l+yUrHzHI2uwO8QMlYpb+K6fQS02d40sMKvCi069wbTg3Oy0lBdl
   5b7G8jljNmVB0RJjatzSjiPc4qOnMWE2n0XHk9Vm0zBosjwv96abnZ+QT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="10156788"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="10156788"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 05:10:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="960658944"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="960658944"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Jan 2024 05:10:27 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rU4vZ-0003P7-0k;
	Sun, 28 Jan 2024 13:10:25 +0000
Date: Sun, 28 Jan 2024 21:10:06 +0800
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
Subject: Re: [PATCH v11 05/26] dept: Tie to Lockdep and IRQ tracing
Message-ID: <202401282019.lvlmRwlL-lkp@intel.com>
References: <20240124115938.80132-6-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124115938.80132-6-byungchul@sk.com>

Hi Byungchul,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0dd3ee31125508cd67f7e7172247f05b7fd1753a]

url:    https://github.com/intel-lab-lkp/linux/commits/Byungchul-Park/llist-Move-llist_-head-node-definition-to-types-h/20240124-200243
base:   0dd3ee31125508cd67f7e7172247f05b7fd1753a
patch link:    https://lore.kernel.org/r/20240124115938.80132-6-byungchul%40sk.com
patch subject: [PATCH v11 05/26] dept: Tie to Lockdep and IRQ tracing
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20240128/202401282019.lvlmRwlL-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project a31a60074717fc40887cfe132b77eec93bedd307)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240128/202401282019.lvlmRwlL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401282019.lvlmRwlL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/ext4/mballoc.c:12:
   In file included from fs/ext4/ext4_jbd2.h:16:
   In file included from include/linux/jbd2.h:23:
   In file included from include/linux/buffer_head.h:12:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:12:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from fs/ext4/mballoc.c:12:
   In file included from fs/ext4/ext4_jbd2.h:16:
   In file included from include/linux/jbd2.h:23:
   In file included from include/linux/buffer_head.h:12:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:12:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from fs/ext4/mballoc.c:12:
   In file included from fs/ext4/ext4_jbd2.h:16:
   In file included from include/linux/jbd2.h:23:
   In file included from include/linux/buffer_head.h:12:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:12:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   In file included from fs/ext4/mballoc.c:7000:
>> fs/ext4/mballoc-test.c:246:13: warning: stack frame size (1288) exceeds limit (1024) in 'test_new_blocks_simple' [-Wframe-larger-than]
     246 | static void test_new_blocks_simple(struct kunit *test)
         |             ^
   7 warnings generated.
--
>> drivers/gpu/drm/tests/drm_exec_test.c:150:13: warning: stack frame size (1064) exceeds limit (1024) in 'test_prepare_array' [-Wframe-larger-than]
     150 | static void test_prepare_array(struct kunit *test)
         |             ^
   1 warning generated.
--
   In file included from drivers/net/ethernet/microchip/vcap/vcap_api.c:9:
   In file included from drivers/net/ethernet/microchip/vcap/vcap_api_private.h:11:
   In file included from drivers/net/ethernet/microchip/vcap/vcap_api.h:11:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:12:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/net/ethernet/microchip/vcap/vcap_api.c:9:
   In file included from drivers/net/ethernet/microchip/vcap/vcap_api_private.h:11:
   In file included from drivers/net/ethernet/microchip/vcap/vcap_api.h:11:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:12:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/net/ethernet/microchip/vcap/vcap_api.c:9:
   In file included from drivers/net/ethernet/microchip/vcap/vcap_api_private.h:11:
   In file included from drivers/net/ethernet/microchip/vcap/vcap_api.h:11:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:12:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   In file included from drivers/net/ethernet/microchip/vcap/vcap_api.c:3598:
>> drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c:1926:13: warning: stack frame size (1296) exceeds limit (1024) in 'vcap_api_next_lookup_advanced_test' [-Wframe-larger-than]
    1926 | static void vcap_api_next_lookup_advanced_test(struct kunit *test)
         |             ^
   7 warnings generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for FRAME_POINTER
   Depends on [n]: DEBUG_KERNEL [=y] && (M68K || UML || SUPERH) || ARCH_WANT_FRAME_POINTERS [=n]
   Selected by [y]:
   - DEPT [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y] && !MIPS && !PPC && !ARM && !S390 && !MICROBLAZE && !ARC && !X86


vim +/test_new_blocks_simple +246 fs/ext4/mballoc-test.c

7c9fa399a36954 Kemeng Shi 2023-09-29  245  
7c9fa399a36954 Kemeng Shi 2023-09-29 @246  static void test_new_blocks_simple(struct kunit *test)
7c9fa399a36954 Kemeng Shi 2023-09-29  247  {
7c9fa399a36954 Kemeng Shi 2023-09-29  248  	struct super_block *sb = (struct super_block *)test->priv;
7c9fa399a36954 Kemeng Shi 2023-09-29  249  	struct inode inode = { .i_sb = sb, };
7c9fa399a36954 Kemeng Shi 2023-09-29  250  	struct ext4_allocation_request ar;
7c9fa399a36954 Kemeng Shi 2023-09-29  251  	ext4_group_t i, goal_group = TEST_GOAL_GROUP;
7c9fa399a36954 Kemeng Shi 2023-09-29  252  	int err = 0;
7c9fa399a36954 Kemeng Shi 2023-09-29  253  	ext4_fsblk_t found;
7c9fa399a36954 Kemeng Shi 2023-09-29  254  	struct ext4_sb_info *sbi = EXT4_SB(sb);
7c9fa399a36954 Kemeng Shi 2023-09-29  255  
7c9fa399a36954 Kemeng Shi 2023-09-29  256  	ar.inode = &inode;
7c9fa399a36954 Kemeng Shi 2023-09-29  257  
7c9fa399a36954 Kemeng Shi 2023-09-29  258  	/* get block at goal */
7c9fa399a36954 Kemeng Shi 2023-09-29  259  	ar.goal = ext4_group_first_block_no(sb, goal_group);
7c9fa399a36954 Kemeng Shi 2023-09-29  260  	found = ext4_mb_new_blocks_simple(&ar, &err);
7c9fa399a36954 Kemeng Shi 2023-09-29  261  	KUNIT_ASSERT_EQ_MSG(test, ar.goal, found,
7c9fa399a36954 Kemeng Shi 2023-09-29  262  		"failed to alloc block at goal, expected %llu found %llu",
7c9fa399a36954 Kemeng Shi 2023-09-29  263  		ar.goal, found);
7c9fa399a36954 Kemeng Shi 2023-09-29  264  
7c9fa399a36954 Kemeng Shi 2023-09-29  265  	/* get block after goal in goal group */
7c9fa399a36954 Kemeng Shi 2023-09-29  266  	ar.goal = ext4_group_first_block_no(sb, goal_group);
7c9fa399a36954 Kemeng Shi 2023-09-29  267  	found = ext4_mb_new_blocks_simple(&ar, &err);
7c9fa399a36954 Kemeng Shi 2023-09-29  268  	KUNIT_ASSERT_EQ_MSG(test, ar.goal + EXT4_C2B(sbi, 1), found,
7c9fa399a36954 Kemeng Shi 2023-09-29  269  		"failed to alloc block after goal in goal group, expected %llu found %llu",
7c9fa399a36954 Kemeng Shi 2023-09-29  270  		ar.goal + 1, found);
7c9fa399a36954 Kemeng Shi 2023-09-29  271  
7c9fa399a36954 Kemeng Shi 2023-09-29  272  	/* get block after goal group */
7c9fa399a36954 Kemeng Shi 2023-09-29  273  	mbt_ctx_mark_used(sb, goal_group, 0, EXT4_CLUSTERS_PER_GROUP(sb));
7c9fa399a36954 Kemeng Shi 2023-09-29  274  	ar.goal = ext4_group_first_block_no(sb, goal_group);
7c9fa399a36954 Kemeng Shi 2023-09-29  275  	found = ext4_mb_new_blocks_simple(&ar, &err);
7c9fa399a36954 Kemeng Shi 2023-09-29  276  	KUNIT_ASSERT_EQ_MSG(test,
7c9fa399a36954 Kemeng Shi 2023-09-29  277  		ext4_group_first_block_no(sb, goal_group + 1), found,
7c9fa399a36954 Kemeng Shi 2023-09-29  278  		"failed to alloc block after goal group, expected %llu found %llu",
7c9fa399a36954 Kemeng Shi 2023-09-29  279  		ext4_group_first_block_no(sb, goal_group + 1), found);
7c9fa399a36954 Kemeng Shi 2023-09-29  280  
7c9fa399a36954 Kemeng Shi 2023-09-29  281  	/* get block before goal group */
7c9fa399a36954 Kemeng Shi 2023-09-29  282  	for (i = goal_group; i < ext4_get_groups_count(sb); i++)
7c9fa399a36954 Kemeng Shi 2023-09-29  283  		mbt_ctx_mark_used(sb, i, 0, EXT4_CLUSTERS_PER_GROUP(sb));
7c9fa399a36954 Kemeng Shi 2023-09-29  284  	ar.goal = ext4_group_first_block_no(sb, goal_group);
7c9fa399a36954 Kemeng Shi 2023-09-29  285  	found = ext4_mb_new_blocks_simple(&ar, &err);
7c9fa399a36954 Kemeng Shi 2023-09-29  286  	KUNIT_ASSERT_EQ_MSG(test,
7c9fa399a36954 Kemeng Shi 2023-09-29  287  		ext4_group_first_block_no(sb, 0) + EXT4_C2B(sbi, 1), found,
7c9fa399a36954 Kemeng Shi 2023-09-29  288  		"failed to alloc block before goal group, expected %llu found %llu",
7c9fa399a36954 Kemeng Shi 2023-09-29  289  		ext4_group_first_block_no(sb, 0 + EXT4_C2B(sbi, 1)), found);
7c9fa399a36954 Kemeng Shi 2023-09-29  290  
7c9fa399a36954 Kemeng Shi 2023-09-29  291  	/* no block available, fail to allocate block */
7c9fa399a36954 Kemeng Shi 2023-09-29  292  	for (i = 0; i < ext4_get_groups_count(sb); i++)
7c9fa399a36954 Kemeng Shi 2023-09-29  293  		mbt_ctx_mark_used(sb, i, 0, EXT4_CLUSTERS_PER_GROUP(sb));
7c9fa399a36954 Kemeng Shi 2023-09-29  294  	ar.goal = ext4_group_first_block_no(sb, goal_group);
7c9fa399a36954 Kemeng Shi 2023-09-29  295  	found = ext4_mb_new_blocks_simple(&ar, &err);
7c9fa399a36954 Kemeng Shi 2023-09-29  296  	KUNIT_ASSERT_NE_MSG(test, err, 0,
7c9fa399a36954 Kemeng Shi 2023-09-29  297  		"unexpectedly get block when no block is available");
7c9fa399a36954 Kemeng Shi 2023-09-29  298  }
7c9fa399a36954 Kemeng Shi 2023-09-29  299  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

