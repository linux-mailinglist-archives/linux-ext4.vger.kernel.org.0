Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EE7531E75
	for <lists+linux-ext4@lfdr.de>; Tue, 24 May 2022 00:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiEWWSS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 May 2022 18:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiEWWSO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 May 2022 18:18:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595127CDF6;
        Mon, 23 May 2022 15:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653344293; x=1684880293;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tFdr/SC/rUcmHy+veU5Ux3G408O9bx0eu9Dzwcx8c1U=;
  b=PtACE1JoElQrJBiadj7wrmv3tuZjfkwAIZP29r8vA6AFn9nDSr2jPtjX
   k9ylFLw5mpNkgm1AyIChD+A/h2jrMJadGIClo3kDUVdfJ4ilqeeTW54Xq
   nrb0CrR0I0y26r/SPoLwUz45mC6fB2Ct0yfj63VKvMiovXsy7BcAAEasn
   nK1Pud1UjTENpX5Xh9zJ/WZ5EF0Tm727D6Ah+n8EjND26RQZxi6oTYjvH
   8IAy1sLmlXtl7rJOx8v+xItOlFMS9cB4jn1LFcXf/dULjuNH6kOO/wJD4
   zo2ltoXn/WYje9BqjgPRXtVA/k+DZ4v1ZR38X0FYKyTFL+LvCyVOcNssz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="273367878"
X-IronPort-AV: E=Sophos;i="5.91,247,1647327600"; 
   d="scan'208";a="273367878"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 15:18:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,247,1647327600"; 
   d="scan'208";a="900785781"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 23 May 2022 15:18:09 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntGNH-0001U6-Nq;
        Mon, 23 May 2022 22:18:03 +0000
Date:   Tue, 24 May 2022 06:17:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org
Cc:     kbuild-all@lists.01.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, lczerner@redhat.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yebin10@huawei.com, yukuai3@huawei.com, libaokun1@huawei.com,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH v2 1/2] ext4: fix bug_on ext4_mb_use_inode_pa
Message-ID: <202205240647.cDZVGw5H-lkp@intel.com>
References: <20220523141658.2919003-2-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523141658.2919003-2-libaokun1@huawei.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Baokun,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tytso-ext4/dev]
[also build test WARNING on linux/master linus/master v5.18 next-20220523]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Baokun-Li/ext4-fix-two-bugs-in-ext4_mb_normalize_request/20220523-221114
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
config: ia64-randconfig-s031-20220522 (https://download.01.org/0day-ci/archive/20220524/202205240647.cDZVGw5H-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/74180b479936a47521200fae540eafdf35ca5a07
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Baokun-Li/ext4-fix-two-bugs-in-ext4_mb_normalize_request/20220523-221114
        git checkout 74180b479936a47521200fae540eafdf35ca5a07
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=ia64 SHELL=/bin/bash fs/ext4/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/ext4/mballoc.c:4113:17: sparse: sparse: incompatible types in comparison expression (different type sizes):
>> fs/ext4/mballoc.c:4113:17: sparse:    unsigned int *
>> fs/ext4/mballoc.c:4113:17: sparse:    unsigned long *

vim +4113 fs/ext4/mballoc.c

  4016	
  4017	/*
  4018	 * Normalization means making request better in terms of
  4019	 * size and alignment
  4020	 */
  4021	static noinline_for_stack void
  4022	ext4_mb_normalize_request(struct ext4_allocation_context *ac,
  4023					struct ext4_allocation_request *ar)
  4024	{
  4025		struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
  4026		int bsbits, max;
  4027		ext4_lblk_t end;
  4028		loff_t size, start_off;
  4029		loff_t orig_size __maybe_unused;
  4030		ext4_lblk_t start;
  4031		struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
  4032		struct ext4_prealloc_space *pa;
  4033	
  4034		/* do normalize only data requests, metadata requests
  4035		   do not need preallocation */
  4036		if (!(ac->ac_flags & EXT4_MB_HINT_DATA))
  4037			return;
  4038	
  4039		/* sometime caller may want exact blocks */
  4040		if (unlikely(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY))
  4041			return;
  4042	
  4043		/* caller may indicate that preallocation isn't
  4044		 * required (it's a tail, for example) */
  4045		if (ac->ac_flags & EXT4_MB_HINT_NOPREALLOC)
  4046			return;
  4047	
  4048		if (ac->ac_flags & EXT4_MB_HINT_GROUP_ALLOC) {
  4049			ext4_mb_normalize_group_request(ac);
  4050			return ;
  4051		}
  4052	
  4053		bsbits = ac->ac_sb->s_blocksize_bits;
  4054	
  4055		/* first, let's learn actual file size
  4056		 * given current request is allocated */
  4057		size = ac->ac_o_ex.fe_logical + EXT4_C2B(sbi, ac->ac_o_ex.fe_len);
  4058		size = size << bsbits;
  4059		if (size < i_size_read(ac->ac_inode))
  4060			size = i_size_read(ac->ac_inode);
  4061		orig_size = size;
  4062	
  4063		/* max size of free chunks */
  4064		max = 2 << bsbits;
  4065	
  4066	#define NRL_CHECK_SIZE(req, size, max, chunk_size)	\
  4067			(req <= (size) || max <= (chunk_size))
  4068	
  4069		/* first, try to predict filesize */
  4070		/* XXX: should this table be tunable? */
  4071		start_off = 0;
  4072		if (size <= 16 * 1024) {
  4073			size = 16 * 1024;
  4074		} else if (size <= 32 * 1024) {
  4075			size = 32 * 1024;
  4076		} else if (size <= 64 * 1024) {
  4077			size = 64 * 1024;
  4078		} else if (size <= 128 * 1024) {
  4079			size = 128 * 1024;
  4080		} else if (size <= 256 * 1024) {
  4081			size = 256 * 1024;
  4082		} else if (size <= 512 * 1024) {
  4083			size = 512 * 1024;
  4084		} else if (size <= 1024 * 1024) {
  4085			size = 1024 * 1024;
  4086		} else if (NRL_CHECK_SIZE(size, 4 * 1024 * 1024, max, 2 * 1024)) {
  4087			start_off = ((loff_t)ac->ac_o_ex.fe_logical >>
  4088							(21 - bsbits)) << 21;
  4089			size = 2 * 1024 * 1024;
  4090		} else if (NRL_CHECK_SIZE(size, 8 * 1024 * 1024, max, 4 * 1024)) {
  4091			start_off = ((loff_t)ac->ac_o_ex.fe_logical >>
  4092								(22 - bsbits)) << 22;
  4093			size = 4 * 1024 * 1024;
  4094		} else if (NRL_CHECK_SIZE(ac->ac_o_ex.fe_len,
  4095						(8<<20)>>bsbits, max, 8 * 1024)) {
  4096			start_off = ((loff_t)ac->ac_o_ex.fe_logical >>
  4097								(23 - bsbits)) << 23;
  4098			size = 8 * 1024 * 1024;
  4099		} else {
  4100			start_off = (loff_t) ac->ac_o_ex.fe_logical << bsbits;
  4101			size	  = (loff_t) EXT4_C2B(EXT4_SB(ac->ac_sb),
  4102						      ac->ac_o_ex.fe_len) << bsbits;
  4103		}
  4104		size = size >> bsbits;
  4105		start = start_off >> bsbits;
  4106	
  4107		/*
  4108		 * For tiny groups (smaller than 8MB) the chosen allocation
  4109		 * alignment may be larger than group size. Make sure the
  4110		 * alignment does not move allocation to a different group which
  4111		 * makes mballoc fail assertions later.
  4112		 */
> 4113		start = max(start, rounddown(ac->ac_o_ex.fe_logical,
  4114				EXT4_BLOCKS_PER_GROUP(ac->ac_sb)));
  4115	
  4116		/* don't cover already allocated blocks in selected range */
  4117		if (ar->pleft && start <= ar->lleft) {
  4118			size -= ar->lleft + 1 - start;
  4119			start = ar->lleft + 1;
  4120		}
  4121		if (ar->pright && start + size - 1 >= ar->lright)
  4122			size -= start + size - ar->lright;
  4123	
  4124		/*
  4125		 * Trim allocation request for filesystems with artificially small
  4126		 * groups.
  4127		 */
  4128		if (size > EXT4_BLOCKS_PER_GROUP(ac->ac_sb))
  4129			size = EXT4_BLOCKS_PER_GROUP(ac->ac_sb);
  4130	
  4131		end = start + size;
  4132	
  4133		/* check we don't cross already preallocated blocks */
  4134		rcu_read_lock();
  4135		list_for_each_entry_rcu(pa, &ei->i_prealloc_list, pa_inode_list) {
  4136			ext4_lblk_t pa_end;
  4137	
  4138			if (pa->pa_deleted)
  4139				continue;
  4140			spin_lock(&pa->pa_lock);
  4141			if (pa->pa_deleted) {
  4142				spin_unlock(&pa->pa_lock);
  4143				continue;
  4144			}
  4145	
  4146			pa_end = pa->pa_lstart + EXT4_C2B(EXT4_SB(ac->ac_sb),
  4147							  pa->pa_len);
  4148	
  4149			/* PA must not overlap original request */
  4150			BUG_ON(!(ac->ac_o_ex.fe_logical >= pa_end ||
  4151				ac->ac_o_ex.fe_logical < pa->pa_lstart));
  4152	
  4153			/* skip PAs this normalized request doesn't overlap with */
  4154			if (pa->pa_lstart >= end || pa_end <= start) {
  4155				spin_unlock(&pa->pa_lock);
  4156				continue;
  4157			}
  4158			BUG_ON(pa->pa_lstart <= start && pa_end >= end);
  4159	
  4160			/* adjust start or end to be adjacent to this pa */
  4161			if (pa_end <= ac->ac_o_ex.fe_logical) {
  4162				BUG_ON(pa_end < start);
  4163				start = pa_end;
  4164			} else if (pa->pa_lstart > ac->ac_o_ex.fe_logical) {
  4165				BUG_ON(pa->pa_lstart > end);
  4166				end = pa->pa_lstart;
  4167			}
  4168			spin_unlock(&pa->pa_lock);
  4169		}
  4170		rcu_read_unlock();
  4171		size = end - start;
  4172	
  4173		/* XXX: extra loop to check we really don't overlap preallocations */
  4174		rcu_read_lock();
  4175		list_for_each_entry_rcu(pa, &ei->i_prealloc_list, pa_inode_list) {
  4176			ext4_lblk_t pa_end;
  4177	
  4178			spin_lock(&pa->pa_lock);
  4179			if (pa->pa_deleted == 0) {
  4180				pa_end = pa->pa_lstart + EXT4_C2B(EXT4_SB(ac->ac_sb),
  4181								  pa->pa_len);
  4182				BUG_ON(!(start >= pa_end || end <= pa->pa_lstart));
  4183			}
  4184			spin_unlock(&pa->pa_lock);
  4185		}
  4186		rcu_read_unlock();
  4187	
  4188		if (start + size <= ac->ac_o_ex.fe_logical &&
  4189				start > ac->ac_o_ex.fe_logical) {
  4190			ext4_msg(ac->ac_sb, KERN_ERR,
  4191				 "start %lu, size %lu, fe_logical %lu",
  4192				 (unsigned long) start, (unsigned long) size,
  4193				 (unsigned long) ac->ac_o_ex.fe_logical);
  4194			BUG();
  4195		}
  4196		BUG_ON(size <= 0 || size > EXT4_BLOCKS_PER_GROUP(ac->ac_sb));
  4197	
  4198		/* now prepare goal request */
  4199	
  4200		/* XXX: is it better to align blocks WRT to logical
  4201		 * placement or satisfy big request as is */
  4202		ac->ac_g_ex.fe_logical = start;
  4203		ac->ac_g_ex.fe_len = EXT4_NUM_B2C(sbi, size);
  4204	
  4205		/* define goal start in order to merge */
  4206		if (ar->pright && (ar->lright == (start + size))) {
  4207			/* merge to the right */
  4208			ext4_get_group_no_and_offset(ac->ac_sb, ar->pright - size,
  4209							&ac->ac_f_ex.fe_group,
  4210							&ac->ac_f_ex.fe_start);
  4211			ac->ac_flags |= EXT4_MB_HINT_TRY_GOAL;
  4212		}
  4213		if (ar->pleft && (ar->lleft + 1 == start)) {
  4214			/* merge to the left */
  4215			ext4_get_group_no_and_offset(ac->ac_sb, ar->pleft + 1,
  4216							&ac->ac_f_ex.fe_group,
  4217							&ac->ac_f_ex.fe_start);
  4218			ac->ac_flags |= EXT4_MB_HINT_TRY_GOAL;
  4219		}
  4220	
  4221		mb_debug(ac->ac_sb, "goal: %lld(was %lld) blocks at %u\n", size,
  4222			 orig_size, start);
  4223	}
  4224	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
