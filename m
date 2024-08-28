Return-Path: <linux-ext4+bounces-3947-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E66C9633F7
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Aug 2024 23:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1ED71F24660
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Aug 2024 21:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7291AD3F5;
	Wed, 28 Aug 2024 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dRyIJ+iW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF121AB531
	for <linux-ext4@vger.kernel.org>; Wed, 28 Aug 2024 21:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724880957; cv=none; b=gLGSXsUsISQgpndkip3k92LKiCoGYrWdU51Aj7hiJOJZutC7F/YzibhzISOnZftNHP7I4QGRrYKMz5/RQ171oBoouljmz4SNr1CFK/LkfO/G+dmSRI37po6QHDo9B32F3F7C2MVR5Xd4GCWkT8AvGibA9kqr6Qt/l1z9rnyu8eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724880957; c=relaxed/simple;
	bh=61XA5LoekClLafVJAXsbMI9LoIYvALcf6wcbqa+CLOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBKzT3U94vo7GOL613t/ptTy4mqBK8sZ5jn8EhEgFeuc0x1Oo7WpLfJLPvCQryAgVA4nA0Pm7nLlKyqqiSXRjo8NmfQd8McI0NAqaR2gZ2JhqJtZKvtHnVTGP0wZQVKQaOeDrxD/eezS2Y/jUervQvaWdI7vNLExj9c3vKXH9Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dRyIJ+iW; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724880955; x=1756416955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=61XA5LoekClLafVJAXsbMI9LoIYvALcf6wcbqa+CLOo=;
  b=dRyIJ+iWqXJpdP06734sD9CQGPcVU/sWjoa78axIWiECIkCfrW651bwf
   VGUvuEaoxHwzsNn66iWOHoKbSS3dgV5FwE/rBHWnH2RvcaK9gQ+x/s151
   pvUJKTN91m3k4Tv9uuZs5Z0Em2boJnwMbCL0uNpgDG10MIALleglUN+q/
   5yCuPI0hyKdhDWeH1Y77N48UwEJnwcdCgWHFOROcjielJIpPbhyvLzoFW
   tvW6HOVrH44mwEt79Iw/+CiGbp51LS1DU8JSYU9gURQll2tGKYiVI3DqM
   a9kS37N6XmVjGQo/3t4J40zwSjotTrZcBPpQjtU+tdlnwxVLPZxP9rkHS
   Q==;
X-CSE-ConnectionGUID: GmFsSjK3SP6d1EFT6qrWVQ==
X-CSE-MsgGUID: QzMPV4BhSeeRMDGbXYV1AQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="34099575"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="34099575"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 14:34:33 -0700
X-CSE-ConnectionGUID: Hu0aOdQAToioz1Z0oV4wdA==
X-CSE-MsgGUID: TrQDYRYjSYa88qyP86fbSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="63545621"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 28 Aug 2024 14:34:31 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sjQJB-000LNq-05;
	Wed, 28 Aug 2024 21:34:29 +0000
Date: Thu, 29 Aug 2024 05:34:09 +0800
From: kernel test robot <lkp@intel.com>
To: Li Zetao <lizetao1@huawei.com>, tytso@mit.edu, adilger.kernel@dilger.ca
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	lizetao1@huawei.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH -next 3/3] ext4: Use scoped()/scoped_guard() to drop
 rcu_read_lock()/unlock pair
Message-ID: <202408290407.XQuWf1oH-lkp@intel.com>
References: <20240823061824.3323522-4-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823061824.3323522-4-lizetao1@huawei.com>

Hi Li,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20240823]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Zetao/ext4-Use-scoped-scoped_guard-to-drop-read_lock-unlock-pair/20240826-123331
base:   next-20240823
patch link:    https://lore.kernel.org/r/20240823061824.3323522-4-lizetao1%40huawei.com
patch subject: [PATCH -next 3/3] ext4: Use scoped()/scoped_guard() to drop rcu_read_lock()/unlock pair
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20240829/202408290407.XQuWf1oH-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 08e5a1de8227512d4774a534b91cb2353cef6284)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240829/202408290407.XQuWf1oH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408290407.XQuWf1oH-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/ext4/mballoc.c:12:
   In file included from fs/ext4/ext4_jbd2.h:16:
   In file included from include/linux/jbd2.h:23:
   In file included from include/linux/buffer_head.h:12:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/mm.h:2202:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> fs/ext4/mballoc.c:3470:2: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
    3470 |         guard(rcu)();
         |         ^
   include/linux/cleanup.h:303:2: note: expanded from macro 'guard'
     303 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^
   include/linux/cleanup.h:258:2: note: expanded from macro 'CLASS'
     258 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
         |         ^
   <scratch space>:94:1: note: expanded from here
      94 | class_rcu_t
         | ^
   5 warnings generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for OMAP2PLUS_MBOX
   Depends on [n]: MAILBOX [=y] && (ARCH_OMAP2PLUS || ARCH_K3)
   Selected by [m]:
   - TI_K3_M4_REMOTEPROC [=m] && REMOTEPROC [=y] && (ARCH_K3 || COMPILE_TEST [=y])


vim +3470 fs/ext4/mballoc.c

  3386	
  3387	static int ext4_mb_init_backend(struct super_block *sb)
  3388	{
  3389		ext4_group_t ngroups = ext4_get_groups_count(sb);
  3390		ext4_group_t i;
  3391		struct ext4_sb_info *sbi = EXT4_SB(sb);
  3392		int err;
  3393		struct ext4_group_desc *desc;
  3394		struct ext4_group_info ***group_info;
  3395		struct kmem_cache *cachep;
  3396	
  3397		err = ext4_mb_alloc_groupinfo(sb, ngroups);
  3398		if (err)
  3399			return err;
  3400	
  3401		sbi->s_buddy_cache = new_inode(sb);
  3402		if (sbi->s_buddy_cache == NULL) {
  3403			ext4_msg(sb, KERN_ERR, "can't get new inode");
  3404			goto err_freesgi;
  3405		}
  3406		/* To avoid potentially colliding with an valid on-disk inode number,
  3407		 * use EXT4_BAD_INO for the buddy cache inode number.  This inode is
  3408		 * not in the inode hash, so it should never be found by iget(), but
  3409		 * this will avoid confusion if it ever shows up during debugging. */
  3410		sbi->s_buddy_cache->i_ino = EXT4_BAD_INO;
  3411		EXT4_I(sbi->s_buddy_cache)->i_disksize = 0;
  3412		for (i = 0; i < ngroups; i++) {
  3413			cond_resched();
  3414			desc = ext4_get_group_desc(sb, i, NULL);
  3415			if (desc == NULL) {
  3416				ext4_msg(sb, KERN_ERR, "can't read descriptor %u", i);
  3417				goto err_freebuddy;
  3418			}
  3419			if (ext4_mb_add_groupinfo(sb, i, desc) != 0)
  3420				goto err_freebuddy;
  3421		}
  3422	
  3423		if (ext4_has_feature_flex_bg(sb)) {
  3424			/* a single flex group is supposed to be read by a single IO.
  3425			 * 2 ^ s_log_groups_per_flex != UINT_MAX as s_mb_prefetch is
  3426			 * unsigned integer, so the maximum shift is 32.
  3427			 */
  3428			if (sbi->s_es->s_log_groups_per_flex >= 32) {
  3429				ext4_msg(sb, KERN_ERR, "too many log groups per flexible block group");
  3430				goto err_freebuddy;
  3431			}
  3432			sbi->s_mb_prefetch = min_t(uint, 1 << sbi->s_es->s_log_groups_per_flex,
  3433				BLK_MAX_SEGMENT_SIZE >> (sb->s_blocksize_bits - 9));
  3434			sbi->s_mb_prefetch *= 8; /* 8 prefetch IOs in flight at most */
  3435		} else {
  3436			sbi->s_mb_prefetch = 32;
  3437		}
  3438		if (sbi->s_mb_prefetch > ext4_get_groups_count(sb))
  3439			sbi->s_mb_prefetch = ext4_get_groups_count(sb);
  3440		/*
  3441		 * now many real IOs to prefetch within a single allocation at
  3442		 * CR_POWER2_ALIGNED. Given CR_POWER2_ALIGNED is an CPU-related
  3443		 * optimization we shouldn't try to load too many groups, at some point
  3444		 * we should start to use what we've got in memory.
  3445		 * with an average random access time 5ms, it'd take a second to get
  3446		 * 200 groups (* N with flex_bg), so let's make this limit 4
  3447		 */
  3448		sbi->s_mb_prefetch_limit = sbi->s_mb_prefetch * 4;
  3449		if (sbi->s_mb_prefetch_limit > ext4_get_groups_count(sb))
  3450			sbi->s_mb_prefetch_limit = ext4_get_groups_count(sb);
  3451	
  3452		return 0;
  3453	
  3454	err_freebuddy:
  3455		cachep = get_groupinfo_cache(sb->s_blocksize_bits);
  3456		while (i-- > 0) {
  3457			struct ext4_group_info *grp = ext4_get_group_info(sb, i);
  3458	
  3459			if (grp)
  3460				kmem_cache_free(cachep, grp);
  3461		}
  3462		i = sbi->s_group_info_size;
  3463		scoped_guard(rcu) {
  3464			group_info = rcu_dereference(sbi->s_group_info);
  3465			while (i-- > 0)
  3466				kfree(group_info[i]);
  3467		}
  3468		iput(sbi->s_buddy_cache);
  3469	err_freesgi:
> 3470		guard(rcu)();
  3471		kvfree(rcu_dereference(sbi->s_group_info));
  3472		return -ENOMEM;
  3473	}
  3474	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

