Return-Path: <linux-ext4+bounces-163-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0637F8BE5
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Nov 2023 16:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCF2FB21142
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Nov 2023 15:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECC328DD5;
	Sat, 25 Nov 2023 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S7Loye1O"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54985F2;
	Sat, 25 Nov 2023 07:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700924493; x=1732460493;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LGrjJaIkkh5RpqgA3aTrFEKAmizU9Ll5N3HfdhPU8z8=;
  b=S7Loye1OQjLxR2VGQHWAxECsz6L2k/zyFmBh9zeitH6C1F7UWk2jwSaU
   /thsLZUEvijas7LPaUxn1RO1584lMWxb65eStrvJqTmSlzkILOdjb8/vN
   /lbMb5CMqzvqc29El3rJ7feeHmpbQlmdC3DJ0Oz3eHCPo5e8eloaXerPE
   flYS1XCmRZmm6HI3Y1A+quYVoXKzVD9wy+AyKzkNlCTV7ouYuI+/bzNb8
   gjetpx7Ez4Nve9qULY0f0y4He5cyXVm9vKqOMRtz5j2Astfza4holOZmo
   zAnWXVcs00tTjdC5c27LrOjSLMeMKDT7rxTStrPKnMrR5csojcZ6XN2wA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10905"; a="377562201"
X-IronPort-AV: E=Sophos;i="6.04,226,1695711600"; 
   d="scan'208";a="377562201"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2023 07:01:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10905"; a="796829558"
X-IronPort-AV: E=Sophos;i="6.04,226,1695711600"; 
   d="scan'208";a="796829558"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 25 Nov 2023 07:01:30 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r6u9w-00046s-0U;
	Sat, 25 Nov 2023 15:01:28 +0000
Date: Sat, 25 Nov 2023 23:00:29 +0800
From: kernel test robot <lkp@intel.com>
To: Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: oe-kbuild-all@lists.linux.dev, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] ext4: Add unit test for ext4_mb_mark_diskspace_used
Message-ID: <202311252009.Z6vrLAjg-lkp@intel.com>
References: <20231125154144.3943442-6-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125154144.3943442-6-shikemeng@huaweicloud.com>

Hi Kemeng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tytso-ext4/dev]
[also build test WARNING on linus/master v6.7-rc2 next-20231124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kemeng-Shi/ext4-Add-unit-test-for-test_free_blocks_simple/20231125-154444
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20231125154144.3943442-6-shikemeng%40huaweicloud.com
patch subject: [PATCH 5/5] ext4: Add unit test for ext4_mb_mark_diskspace_used
config: i386-buildonly-randconfig-004-20231125 (https://download.01.org/0day-ci/archive/20231125/202311252009.Z6vrLAjg-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231125/202311252009.Z6vrLAjg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311252009.Z6vrLAjg-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/ext4/mballoc.c:6996:
   fs/ext4/mballoc-test.c: In function 'test_mark_diskspace_used':
>> fs/ext4/mballoc-test.c:510:23: warning: variable 'max' set but not used [-Wunused-but-set-variable]
     510 |         ext4_grpblk_t max;
         |                       ^~~


vim +/max +510 fs/ext4/mballoc-test.c

   505	
   506	static void test_mark_diskspace_used(struct kunit *test)
   507	{
   508		struct super_block *sb = (struct super_block *)test->priv;
   509		struct inode inode = { .i_sb = sb, };
 > 510		ext4_grpblk_t max;
   511		struct ext4_allocation_context ac;
   512		struct test_range ranges[TEST_RANGE_COUNT];
   513		int i;
   514	
   515		mbt_generate_test_ranges(sb, ranges, TEST_RANGE_COUNT);
   516	
   517		ac.ac_status = AC_STATUS_FOUND;
   518		ac.ac_sb = sb;
   519		ac.ac_inode = &inode;
   520		max = EXT4_CLUSTERS_PER_GROUP(sb);
   521		for (i = 0; i < TEST_RANGE_COUNT; i++)
   522			test_mark_diskspace_used_range(test, &ac, ranges[i].start,
   523						       ranges[i].len);
   524	}
   525	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

