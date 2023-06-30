Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773E97442A0
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Jun 2023 21:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjF3TPq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 30 Jun 2023 15:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjF3TPp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 30 Jun 2023 15:15:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F52D3C38;
        Fri, 30 Jun 2023 12:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688152544; x=1719688544;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=phMO0ZX0Pt9exDNJvM6sMnah+jyXyBQsyVCUMocv9R8=;
  b=gsfxMUXgzHsbNy0XZeROI7/vKhcajVXxaGVNAxPJFoekCfhnUrAUuR8V
   8B8VuYsD/e1xVknw9nAk4vE3tnJ+ezp9KW0Dvx7kjjvxyWbxixyps/4eq
   8CziBrfwV1eaIqipFJ0/UHEn2dni1NK3Gle6VLYRE47YbJlorHfyA3X0h
   vl7/rLHlKIeBDjwmyUNOCn7SIaxLOhLR06aCs3ok34Rvb/g/+8SqAVg0U
   +kVpXYgYdE2juubFb9QSvzfJ5Gy7dE6r802M9AEN4jhLNSrjmaGiJcDhz
   T2zOQkpjIB0H3CWJ4XrgdC+CpVqst7viQsv4z8/MyiQodKT8U0fTg5ulY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="342806217"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="342806217"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 12:15:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="747514096"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="747514096"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 30 Jun 2023 12:15:41 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qFJam-000FIN-0j;
        Fri, 30 Jun 2023 19:15:40 +0000
Date:   Sat, 1 Jul 2023 03:14:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Colin Ian King <colin.i.king@gmail.com>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ext2: remove redundant assignment to variable desc
Message-ID: <202307010203.gNQQkF8h-lkp@intel.com>
References: <20230630163033.165326-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630163033.165326-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Colin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.4 next-20230630]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Colin-Ian-King/ext2-remove-redundant-assignment-to-variable-desc/20230701-003209
base:   linus/master
patch link:    https://lore.kernel.org/r/20230630163033.165326-1-colin.i.king%40gmail.com
patch subject: [PATCH][next] ext2: remove redundant assignment to variable desc
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230701/202307010203.gNQQkF8h-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230701/202307010203.gNQQkF8h-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307010203.gNQQkF8h-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/ext2/ialloc.c: In function 'find_group_orlov':
>> fs/ext2/ialloc.c:276:41: warning: variable 'best_desc' set but not used [-Wunused-but-set-variable]
     276 |                 struct ext2_group_desc *best_desc = NULL;
         |                                         ^~~~~~~~~


vim +/best_desc +276 fs/ext2/ialloc.c

^1da177e4c3f41 Linus Torvalds     2005-04-16  250  
^1da177e4c3f41 Linus Torvalds     2005-04-16  251  static int find_group_orlov(struct super_block *sb, struct inode *parent)
^1da177e4c3f41 Linus Torvalds     2005-04-16  252  {
^1da177e4c3f41 Linus Torvalds     2005-04-16  253  	int parent_group = EXT2_I(parent)->i_block_group;
^1da177e4c3f41 Linus Torvalds     2005-04-16  254  	struct ext2_sb_info *sbi = EXT2_SB(sb);
^1da177e4c3f41 Linus Torvalds     2005-04-16  255  	struct ext2_super_block *es = sbi->s_es;
^1da177e4c3f41 Linus Torvalds     2005-04-16  256  	int ngroups = sbi->s_groups_count;
^1da177e4c3f41 Linus Torvalds     2005-04-16  257  	int inodes_per_group = EXT2_INODES_PER_GROUP(sb);
^1da177e4c3f41 Linus Torvalds     2005-04-16  258  	int freei;
^1da177e4c3f41 Linus Torvalds     2005-04-16  259  	int avefreei;
^1da177e4c3f41 Linus Torvalds     2005-04-16  260  	int free_blocks;
^1da177e4c3f41 Linus Torvalds     2005-04-16  261  	int avefreeb;
^1da177e4c3f41 Linus Torvalds     2005-04-16  262  	int blocks_per_dir;
^1da177e4c3f41 Linus Torvalds     2005-04-16  263  	int ndirs;
^1da177e4c3f41 Linus Torvalds     2005-04-16  264  	int max_debt, max_dirs, min_blocks, min_inodes;
^1da177e4c3f41 Linus Torvalds     2005-04-16  265  	int group = -1, i;
^1da177e4c3f41 Linus Torvalds     2005-04-16  266  	struct ext2_group_desc *desc;
^1da177e4c3f41 Linus Torvalds     2005-04-16  267  
^1da177e4c3f41 Linus Torvalds     2005-04-16  268  	freei = percpu_counter_read_positive(&sbi->s_freeinodes_counter);
^1da177e4c3f41 Linus Torvalds     2005-04-16  269  	avefreei = freei / ngroups;
^1da177e4c3f41 Linus Torvalds     2005-04-16  270  	free_blocks = percpu_counter_read_positive(&sbi->s_freeblocks_counter);
^1da177e4c3f41 Linus Torvalds     2005-04-16  271  	avefreeb = free_blocks / ngroups;
^1da177e4c3f41 Linus Torvalds     2005-04-16  272  	ndirs = percpu_counter_read_positive(&sbi->s_dirs_counter);
^1da177e4c3f41 Linus Torvalds     2005-04-16  273  
2b0143b5c986be David Howells      2015-03-17  274  	if ((parent == d_inode(sb->s_root)) ||
^1da177e4c3f41 Linus Torvalds     2005-04-16  275  	    (EXT2_I(parent)->i_flags & EXT2_TOPDIR_FL)) {
^1da177e4c3f41 Linus Torvalds     2005-04-16 @276  		struct ext2_group_desc *best_desc = NULL;
^1da177e4c3f41 Linus Torvalds     2005-04-16  277  		int best_ndir = inodes_per_group;
^1da177e4c3f41 Linus Torvalds     2005-04-16  278  		int best_group = -1;
^1da177e4c3f41 Linus Torvalds     2005-04-16  279  
8032bf1233a746 Jason A. Donenfeld 2022-10-09  280  		parent_group = get_random_u32_below(ngroups);
^1da177e4c3f41 Linus Torvalds     2005-04-16  281  		for (i = 0; i < ngroups; i++) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  282  			group = (parent_group + i) % ngroups;
ef2fb67989d30f Eric Sandeen       2007-10-16  283  			desc = ext2_get_group_desc (sb, group, NULL);
^1da177e4c3f41 Linus Torvalds     2005-04-16  284  			if (!desc || !desc->bg_free_inodes_count)
^1da177e4c3f41 Linus Torvalds     2005-04-16  285  				continue;
^1da177e4c3f41 Linus Torvalds     2005-04-16  286  			if (le16_to_cpu(desc->bg_used_dirs_count) >= best_ndir)
^1da177e4c3f41 Linus Torvalds     2005-04-16  287  				continue;
^1da177e4c3f41 Linus Torvalds     2005-04-16  288  			if (le16_to_cpu(desc->bg_free_inodes_count) < avefreei)
^1da177e4c3f41 Linus Torvalds     2005-04-16  289  				continue;
^1da177e4c3f41 Linus Torvalds     2005-04-16  290  			if (le16_to_cpu(desc->bg_free_blocks_count) < avefreeb)
^1da177e4c3f41 Linus Torvalds     2005-04-16  291  				continue;
^1da177e4c3f41 Linus Torvalds     2005-04-16  292  			best_group = group;
^1da177e4c3f41 Linus Torvalds     2005-04-16  293  			best_ndir = le16_to_cpu(desc->bg_used_dirs_count);
^1da177e4c3f41 Linus Torvalds     2005-04-16  294  			best_desc = desc;
^1da177e4c3f41 Linus Torvalds     2005-04-16  295  		}
^1da177e4c3f41 Linus Torvalds     2005-04-16  296  		if (best_group >= 0) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  297  			group = best_group;
^1da177e4c3f41 Linus Torvalds     2005-04-16  298  			goto found;
^1da177e4c3f41 Linus Torvalds     2005-04-16  299  		}
^1da177e4c3f41 Linus Torvalds     2005-04-16  300  		goto fallback;
^1da177e4c3f41 Linus Torvalds     2005-04-16  301  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  302  
^1da177e4c3f41 Linus Torvalds     2005-04-16  303  	if (ndirs == 0)
^1da177e4c3f41 Linus Torvalds     2005-04-16  304  		ndirs = 1;	/* percpu_counters are approximate... */
^1da177e4c3f41 Linus Torvalds     2005-04-16  305  
^1da177e4c3f41 Linus Torvalds     2005-04-16  306  	blocks_per_dir = (le32_to_cpu(es->s_blocks_count)-free_blocks) / ndirs;
^1da177e4c3f41 Linus Torvalds     2005-04-16  307  
^1da177e4c3f41 Linus Torvalds     2005-04-16  308  	max_dirs = ndirs / ngroups + inodes_per_group / 16;
^1da177e4c3f41 Linus Torvalds     2005-04-16  309  	min_inodes = avefreei - inodes_per_group / 4;
^1da177e4c3f41 Linus Torvalds     2005-04-16  310  	min_blocks = avefreeb - EXT2_BLOCKS_PER_GROUP(sb) / 4;
^1da177e4c3f41 Linus Torvalds     2005-04-16  311  
^1da177e4c3f41 Linus Torvalds     2005-04-16  312  	max_debt = EXT2_BLOCKS_PER_GROUP(sb) / max(blocks_per_dir, BLOCK_COST);
^1da177e4c3f41 Linus Torvalds     2005-04-16  313  	if (max_debt * INODE_COST > inodes_per_group)
^1da177e4c3f41 Linus Torvalds     2005-04-16  314  		max_debt = inodes_per_group / INODE_COST;
^1da177e4c3f41 Linus Torvalds     2005-04-16  315  	if (max_debt > 255)
^1da177e4c3f41 Linus Torvalds     2005-04-16  316  		max_debt = 255;
^1da177e4c3f41 Linus Torvalds     2005-04-16  317  	if (max_debt == 0)
^1da177e4c3f41 Linus Torvalds     2005-04-16  318  		max_debt = 1;
^1da177e4c3f41 Linus Torvalds     2005-04-16  319  
^1da177e4c3f41 Linus Torvalds     2005-04-16  320  	for (i = 0; i < ngroups; i++) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  321  		group = (parent_group + i) % ngroups;
ef2fb67989d30f Eric Sandeen       2007-10-16  322  		desc = ext2_get_group_desc (sb, group, NULL);
^1da177e4c3f41 Linus Torvalds     2005-04-16  323  		if (!desc || !desc->bg_free_inodes_count)
^1da177e4c3f41 Linus Torvalds     2005-04-16  324  			continue;
^1da177e4c3f41 Linus Torvalds     2005-04-16  325  		if (sbi->s_debts[group] >= max_debt)
^1da177e4c3f41 Linus Torvalds     2005-04-16  326  			continue;
^1da177e4c3f41 Linus Torvalds     2005-04-16  327  		if (le16_to_cpu(desc->bg_used_dirs_count) >= max_dirs)
^1da177e4c3f41 Linus Torvalds     2005-04-16  328  			continue;
^1da177e4c3f41 Linus Torvalds     2005-04-16  329  		if (le16_to_cpu(desc->bg_free_inodes_count) < min_inodes)
^1da177e4c3f41 Linus Torvalds     2005-04-16  330  			continue;
^1da177e4c3f41 Linus Torvalds     2005-04-16  331  		if (le16_to_cpu(desc->bg_free_blocks_count) < min_blocks)
^1da177e4c3f41 Linus Torvalds     2005-04-16  332  			continue;
^1da177e4c3f41 Linus Torvalds     2005-04-16  333  		goto found;
^1da177e4c3f41 Linus Torvalds     2005-04-16  334  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  335  
^1da177e4c3f41 Linus Torvalds     2005-04-16  336  fallback:
^1da177e4c3f41 Linus Torvalds     2005-04-16  337  	for (i = 0; i < ngroups; i++) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  338  		group = (parent_group + i) % ngroups;
ef2fb67989d30f Eric Sandeen       2007-10-16  339  		desc = ext2_get_group_desc (sb, group, NULL);
^1da177e4c3f41 Linus Torvalds     2005-04-16  340  		if (!desc || !desc->bg_free_inodes_count)
^1da177e4c3f41 Linus Torvalds     2005-04-16  341  			continue;
^1da177e4c3f41 Linus Torvalds     2005-04-16  342  		if (le16_to_cpu(desc->bg_free_inodes_count) >= avefreei)
^1da177e4c3f41 Linus Torvalds     2005-04-16  343  			goto found;
^1da177e4c3f41 Linus Torvalds     2005-04-16  344  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  345  
^1da177e4c3f41 Linus Torvalds     2005-04-16  346  	if (avefreei) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  347  		/*
^1da177e4c3f41 Linus Torvalds     2005-04-16  348  		 * The free-inodes counter is approximate, and for really small
^1da177e4c3f41 Linus Torvalds     2005-04-16  349  		 * filesystems the above test can fail to find any blockgroups
^1da177e4c3f41 Linus Torvalds     2005-04-16  350  		 */
^1da177e4c3f41 Linus Torvalds     2005-04-16  351  		avefreei = 0;
^1da177e4c3f41 Linus Torvalds     2005-04-16  352  		goto fallback;
^1da177e4c3f41 Linus Torvalds     2005-04-16  353  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  354  
^1da177e4c3f41 Linus Torvalds     2005-04-16  355  	return -1;
^1da177e4c3f41 Linus Torvalds     2005-04-16  356  
^1da177e4c3f41 Linus Torvalds     2005-04-16  357  found:
^1da177e4c3f41 Linus Torvalds     2005-04-16  358  	return group;
^1da177e4c3f41 Linus Torvalds     2005-04-16  359  }
^1da177e4c3f41 Linus Torvalds     2005-04-16  360  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
