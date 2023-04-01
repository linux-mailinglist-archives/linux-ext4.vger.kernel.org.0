Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F656D33DC
	for <lists+linux-ext4@lfdr.de>; Sat,  1 Apr 2023 22:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjDAUln (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 1 Apr 2023 16:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDAUln (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 1 Apr 2023 16:41:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977E62658B
        for <linux-ext4@vger.kernel.org>; Sat,  1 Apr 2023 13:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680381701; x=1711917701;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xnHQdrKDzsuOE6knyYbMZdyNPH3XjpnVUqHRgcCIU5Y=;
  b=oJnW5crbTmr4JBr8orCrTybhH3LB2qkruaDMbYAFKp1fbvoXUXLfapBE
   yQJYHUxUJPh6+X/WhUOslcu7UiwjTkQxjHzsKAa7nj8rKqVkKKTwSiD/Y
   RB18mmWPchWxk/ZPnU72Og9KdPt+arKoJVTMsZAB4eB7h1kchliPMT6a3
   u2VPtXp8AMMIHppSL9ht7sVUjCHczP0PIiTquglcTYi9yNwSWlSGqQq4U
   Hmp6cf/INPkQIz9HMeycjjmo44Wz/sJfDCYi6g4ZCFqRj8oxf7PxTPegs
   HhDxsmW3aqv8CQyA9DRcx77wERcHotsFR3m/hZEjSRdcE+lPf14a13Q+2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="404431740"
X-IronPort-AV: E=Sophos;i="5.98,311,1673942400"; 
   d="scan'208";a="404431740"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 13:41:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="685494399"
X-IronPort-AV: E=Sophos;i="5.98,311,1673942400"; 
   d="scan'208";a="685494399"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 01 Apr 2023 13:41:39 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pii2c-000N1f-1D;
        Sat, 01 Apr 2023 20:41:38 +0000
Date:   Sun, 2 Apr 2023 04:40:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     JunChao Sun <sunjunchao2870@gmail.com>, linux-ext4@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, tytso@mit.edu, jun.nie@linaro.org,
        JunChao Sun <sunjunchao2870@gmail.com>
Subject: Re: [PATCH] ext4: fix performance issue of xattr when expanding inode
Message-ID: <202304020403.NMWak0xA-lkp@intel.com>
References: <20230401143244.70332-1-sunjunchao2870@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230401143244.70332-1-sunjunchao2870@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi JunChao,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tytso-ext4/dev]
[also build test WARNING on linus/master v6.3-rc4 next-20230331]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/JunChao-Sun/ext4-fix-performance-issue-of-xattr-when-expanding-inode/20230401-223339
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20230401143244.70332-1-sunjunchao2870%40gmail.com
patch subject: [PATCH] ext4: fix performance issue of xattr when expanding inode
config: mips-randconfig-s033-20230402 (https://download.01.org/0day-ci/archive/20230402/202304020403.NMWak0xA-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/715c6d399c95e6914f37b3dfc08bb88a9d6b2120
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review JunChao-Sun/ext4-fix-performance-issue-of-xattr-when-expanding-inode/20230401-223339
        git checkout 715c6d399c95e6914f37b3dfc08bb88a9d6b2120
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash fs/ext4/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304020403.NMWak0xA-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   fs/ext4/xattr.c:2707:49: sparse: sparse: restricted __le16 degrades to integer
>> fs/ext4/xattr.c:2709:35: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long [usertype] offs @@     got restricted __le16 [usertype] e_value_offs @@
   fs/ext4/xattr.c:2709:35: sparse:     expected unsigned long [usertype] offs
   fs/ext4/xattr.c:2709:35: sparse:     got restricted __le16 [usertype] e_value_offs

vim +2709 fs/ext4/xattr.c

  2601	
  2602	/*
  2603	 * Move xattr pointed to by 'entry' from inode into external xattr block
  2604	 */
  2605	static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
  2606					    struct ext4_inode *raw_inode,
  2607					    struct ext4_xattr_entry *entry)
  2608	{
  2609		struct ext4_xattr_ibody_find *is = NULL;
  2610		struct ext4_xattr_block_find *bs = NULL;
  2611		char *buffer = NULL, *b_entry_name = NULL;
  2612		size_t value_size = le32_to_cpu(entry->e_value_size);
  2613		struct ext4_xattr_info i = {
  2614			.value = NULL,
  2615			.value_len = 0,
  2616			.name_index = entry->e_name_index,
  2617			.in_inode = !!entry->e_value_inum,
  2618		};
  2619		struct ext4_xattr_ibody_header *header = IHDR(inode, raw_inode);
  2620		struct ext4_xattr_entry *here = NULL, *last = NULL, *next = NULL;
  2621		struct inode *old_ea_inode = NULL;
  2622		size_t name_size = EXT4_XATTR_LEN(entry->e_name_len);
  2623		size_t min_offs;
  2624		int error;
  2625	
  2626		is = kzalloc(sizeof(struct ext4_xattr_ibody_find), GFP_NOFS);
  2627		bs = kzalloc(sizeof(struct ext4_xattr_block_find), GFP_NOFS);
  2628		b_entry_name = kmalloc(entry->e_name_len + 1, GFP_NOFS);
  2629		if (!is || !bs || !b_entry_name) {
  2630			error = -ENOMEM;
  2631			goto out;
  2632		}
  2633	
  2634		is->s.not_found = -ENODATA;
  2635		bs->s.not_found = -ENODATA;
  2636		is->iloc.bh = NULL;
  2637		bs->bh = NULL;
  2638	
  2639		/* Save the entry name and the entry value */
  2640		if (entry->e_value_inum) {
  2641			buffer = kvmalloc(value_size, GFP_NOFS);
  2642			if (!buffer) {
  2643				error = -ENOMEM;
  2644				goto out;
  2645			}
  2646	
  2647			error = ext4_xattr_inode_get(inode, entry, buffer, value_size);
  2648			if (error)
  2649				goto out;
  2650		} else {
  2651			size_t value_offs = le16_to_cpu(entry->e_value_offs);
  2652			buffer = (void *)IFIRST(header) + value_offs;
  2653		}
  2654	
  2655		memcpy(b_entry_name, entry->e_name, entry->e_name_len);
  2656		b_entry_name[entry->e_name_len] = '\0';
  2657		i.name = b_entry_name;
  2658	
  2659		error = ext4_get_inode_loc(inode, &is->iloc);
  2660		if (error)
  2661			goto out;
  2662	
  2663		error = ext4_xattr_ibody_find(inode, &i, is);
  2664		if (error)
  2665			goto out;
  2666	
  2667		i.value = buffer;
  2668		i.value_len = value_size;
  2669		here = is->s.here;
  2670		last = is->s.first;
  2671		min_offs = is->s.end - is->s.base;
  2672		/* Compute min_offs and last entry */
  2673		for (; !IS_LAST_ENTRY(last); last = next) {
  2674			next = EXT4_XATTR_NEXT(last);
  2675			if ((void *)next >= is->s.end) {
  2676				EXT4_ERROR_INODE(inode, "corrupted xattr entries");
  2677				error = -EFSCORRUPTED;
  2678				goto out;
  2679			}
  2680			if (!last->e_value_inum && last->e_value_size) {
  2681				size_t offs = le16_to_cpu(last->e_value_offs);
  2682	
  2683				if (offs < min_offs)
  2684					min_offs = offs;
  2685			}
  2686		}
  2687	
  2688		/* Remove the name in ibody */
  2689		last = ENTRY((void *)last - name_size);
  2690		memmove(here, (void *)here + name_size,
  2691			(void *)last - (void *)here + sizeof(__u32));
  2692		memset(last, 0, name_size);
  2693	
  2694		/* Get the ea_inode which store the old value */
  2695		if (here->e_value_inum) {
  2696			error = ext4_xattr_inode_iget(inode,
  2697						    le32_to_cpu(here->e_value_inum),
  2698						    le32_to_cpu(here->e_hash),
  2699						    &old_ea_inode);
  2700			if (error) {
  2701				old_ea_inode = NULL;
  2702				goto out;
  2703			}
  2704		} else if (here->e_value_size) {
  2705			/* Remove the old value in ibody */
  2706			void *first_val = is->s.base + min_offs;
  2707			void *rm_val = is->s.base + here->e_value_offs;
  2708			size_t rm_size = EXT4_XATTR_SIZE(le32_to_cpu(here->e_value_size));
> 2709			size_t offs = here->e_value_offs;
  2710	
  2711			memmove(first_val + rm_size, first_val, rm_val - first_val);
  2712			memset(first_val, 0, rm_size);
  2713			min_offs += rm_size;
  2714	
  2715			/* Adjust all value offsets */
  2716			last = is->s.first;
  2717			while (!IS_LAST_ENTRY(last)) {
  2718				size_t o = le16_to_cpu(last->e_value_offs);
  2719	
  2720				if (!last->e_value_inum &&
  2721				    last->e_value_size && o < offs)
  2722					last->e_value_offs = cpu_to_le16(o + rm_size);
  2723				last = EXT4_XATTR_NEXT(last);
  2724			}
  2725		}
  2726	
  2727		error = ext4_xattr_block_find(inode, &i, bs);
  2728		if (error)
  2729			goto out;
  2730	
  2731		/*
  2732		 * Move ea entry from the inode into the block, and do not need to
  2733		 * recreate an ea_inode that store the same value.
  2734		 */
  2735		error = ext4_xattr_block_set(handle, inode, &i, bs, old_ea_inode);
  2736		if (error)
  2737			goto out;
  2738	
  2739	out:
  2740		kfree(b_entry_name);
  2741		if (entry->e_value_inum && buffer)
  2742			kvfree(buffer);
  2743		if (is)
  2744			brelse(is->iloc.bh);
  2745		if (bs)
  2746			brelse(bs->bh);
  2747		kfree(is);
  2748		kfree(bs);
  2749		iput(old_ea_inode);
  2750	
  2751		return error;
  2752	}
  2753	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
