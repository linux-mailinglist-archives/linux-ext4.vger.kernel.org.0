Return-Path: <linux-ext4+bounces-990-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 429BF83F637
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jan 2024 16:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B109B1F21C65
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jan 2024 15:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8D9286B2;
	Sun, 28 Jan 2024 15:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WZw7rZ1u"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DC01F945;
	Sun, 28 Jan 2024 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706457582; cv=none; b=GiCm6qUzS2ZW4PMLqNig2ChMMX78Mx5MILXjPU9FfbBHDigPWZ7lAaB+5c1NDRkZ1LsvabyP+dbajsxh3/R4V6JncYbgrgSOe72/R/sMsDQRgVU0TYbR1+U6C4lLrzsr2YGKfGPn/MGTs8JFTKCLeismmRBlYVW71IaaCgB/ABM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706457582; c=relaxed/simple;
	bh=vt7QapGb0fiuypTY9c2VIltgIvC8yztVDtRDQjAAGLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jX/qmRLFKu+sNLh1FMuGq96IMlibuTSCy6lMzLTQ+gLMNCZpCT9EQETTPZVKaKzLjyFsDywYkmTBwynlvvdU8u4r9CzZUdczI+saLeiFe8aFUQ2Ht9Ft+i63Y1qtdUO0cxDUHdYqRjPpnhLp/JrDXhDVSMN2BRgcU3rfLE3pp1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WZw7rZ1u; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706457581; x=1737993581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vt7QapGb0fiuypTY9c2VIltgIvC8yztVDtRDQjAAGLc=;
  b=WZw7rZ1uGz4zgea7LoLjTK+12KiH8iLzt8ImYU6OvDZmwHh0rWiNMo50
   C6qVti8zOcnmKQuRZMRmSjLQrT/OU3ceVSrVYpGSK0RqdNX6hFJoV7ay7
   aqQk+LEFXPLn2EPynz/FKzIYaCAw55pr1TZD+yS+H0taBnGQHmFD4PcGw
   /nSvPxzMEVcoAGJoTSoQloq9mSot68gNCBKMICTzqBRrIskeR6IhIFkK3
   RfhMGyuqbYmgTFDsoJjKiX+mrYIreSRSGcRjCPOHmqV7Q35lYP3vLlVM7
   4SrMvkJfpEKNWfykml2taek6YVY8W0Uc7HgpBujO6eUChexeV/ntxVzWZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="10170660"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="10170660"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 07:59:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="3056368"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 28 Jan 2024 07:59:31 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rU7ZB-0003W9-0Q;
	Sun, 28 Jan 2024 15:59:29 +0000
Date: Sun, 28 Jan 2024 23:58:48 +0800
From: kernel test robot <lkp@intel.com>
To: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kernel_team@skhynix.com,
	torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
	will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
	joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
	duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
	tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
	amir73il@gmail.com, gregkh@linuxfoundation.org, kernel-team@lge.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
	minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com
Subject: Re: [PATCH v11 05/26] dept: Tie to Lockdep and IRQ tracing
Message-ID: <202401282340.oDsdGzj2-lkp@intel.com>
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
config: microblaze-allyesconfig (https://download.01.org/0day-ci/archive/20240128/202401282340.oDsdGzj2-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240128/202401282340.oDsdGzj2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401282340.oDsdGzj2-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/ext4/mballoc.c:7000:
   fs/ext4/mballoc-test.c: In function 'test_new_blocks_simple':
>> fs/ext4/mballoc-test.c:298:1: warning: the frame size of 1120 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     298 | }
         | ^
--
   In file included from drivers/net/ethernet/microchip/vcap/vcap_api.c:3598:
   drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c: In function 'vcap_api_next_lookup_advanced_test':
>> drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c:2001:1: warning: the frame size of 1260 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    2001 | }
         | ^


vim +298 fs/ext4/mballoc-test.c

7c9fa399a36954 Kemeng Shi 2023-09-29  245  
7c9fa399a36954 Kemeng Shi 2023-09-29  246  static void test_new_blocks_simple(struct kunit *test)
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
7c9fa399a36954 Kemeng Shi 2023-09-29 @298  }
7c9fa399a36954 Kemeng Shi 2023-09-29  299  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

