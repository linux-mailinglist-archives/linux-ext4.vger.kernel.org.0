Return-Path: <linux-ext4+bounces-12741-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E189D1593B
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Jan 2026 23:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F20703027E34
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Jan 2026 22:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FD3285C84;
	Mon, 12 Jan 2026 22:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CpDKdzHV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4FC284B37
	for <linux-ext4@vger.kernel.org>; Mon, 12 Jan 2026 22:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768256963; cv=none; b=LmSEpB9lPOx5Pshocm7ntN3MX6LIXSdAzV4hX7TK/3197JlnUfaxgzti6N57b6+DKdBxMTC8E9QL3wJe/Me8zk+d8mHtF7oPvoNAXvkJUqdfr9EzpXqgvl0aLP3bCt2kKuUqSdhNFEqGDs24+ZFDyBalqrnwcMffzN26gzCSI7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768256963; c=relaxed/simple;
	bh=soeIJQW4isQzFAs6KAa9zTGiz6dkHM192du08OhT7g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWDNP6qnCWJWkyJw1UZErYub2xqS/MYLDmojF4oQr86QZHKlQQ6DZPhiweE0WH54fE/w07cpLK7bJT9obPo+//f3SbB54TeYgTGwFpq3f9LoiDAEvKPlwN8a71kP/BV0Y+79mT6x/JfecvXGeCIcfZ7ES/toBZt7h9Wd3UHBmWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CpDKdzHV; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768256963; x=1799792963;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=soeIJQW4isQzFAs6KAa9zTGiz6dkHM192du08OhT7g4=;
  b=CpDKdzHVq/Yn6NoJvI3ixBqQ2XmH8Vw3W4RmfUFbwC1+YVLR3TrPQXXs
   XQ8vfPItfo9wJMXyEakQzLfizEvUqdgCtcSGcoIa3kVp2oOsT6jaG2CBH
   UbQq6pnKcP+USAb7cJ6o07b7Tf/c9XG8sy+NVk7SvgsW+E8bh26FHyLRk
   NSSYQ6YeYLAD8qCRp0RGOAcHc2Wdznd+g+/udAbSlgIpUx0wNICRYzxmt
   svr43RjrqzYZCOiWWpXrZFUXIT9DFnpU1O1kNOh1jQM1sZIPBrN0iwg5e
   Wf4hb6yUzn1iXp5YG3A6Tqr2VLeufbFucWwFrPP9BSDhzJg7tphwqSCaC
   w==;
X-CSE-ConnectionGUID: JOAbYGxwSsunAwJJa/iMhw==
X-CSE-MsgGUID: i/OVG7NfQxCyfwSeZiu3mQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="72121097"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="72121097"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 14:29:22 -0800
X-CSE-ConnectionGUID: CyU/f65RRHWrYc4ytcGngg==
X-CSE-MsgGUID: WmWB3N9NTfuSqffPVUgEXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="204865575"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 12 Jan 2026 14:29:20 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vfQPW-00000000DwO-1nHb;
	Mon, 12 Jan 2026 22:29:18 +0000
Date: Tue, 13 Jan 2026 06:28:34 +0800
From: kernel test robot <lkp@intel.com>
To: Brian Foster <bfoster@redhat.com>, linux-ext4@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH v2] ext4: fix dirtyclusters double decrement on fs
 shutdown
Message-ID: <202601130514.GnuB5QCD-lkp@intel.com>
References: <20260112143652.8085-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112143652.8085-1-bfoster@redhat.com>

Hi Brian,

kernel test robot noticed the following build errors:

[auto build test ERROR on tytso-ext4/dev]
[also build test ERROR on linus/master v6.19-rc5 next-20260109]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Brian-Foster/ext4-fix-dirtyclusters-double-decrement-on-fs-shutdown/20260112-225259
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20260112143652.8085-1-bfoster%40redhat.com
patch subject: [PATCH v2] ext4: fix dirtyclusters double decrement on fs shutdown
config: arm64-randconfig-004-20260113 (https://download.01.org/0day-ci/archive/20260113/202601130514.GnuB5QCD-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260113/202601130514.GnuB5QCD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601130514.GnuB5QCD-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/ext4/mballoc.c:7185:
   fs/ext4/mballoc-test.c: In function 'test_mark_diskspace_used_range':
>> fs/ext4/mballoc-test.c:570:15: error: too many arguments to function 'ext4_mb_mark_diskspace_used'
     570 |         ret = ext4_mb_mark_diskspace_used(ac, NULL, 0);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/ext4/mballoc.c:4188:1: note: declared here
    4188 | ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac, handle_t *handle)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/ext4_mb_mark_diskspace_used +570 fs/ext4/mballoc-test.c

6c5e0c9c21456f Kemeng Shi 2024-01-03  548  
2b81493f8eb6fc Kemeng Shi 2024-01-03  549  static void
2b81493f8eb6fc Kemeng Shi 2024-01-03  550  test_mark_diskspace_used_range(struct kunit *test,
2b81493f8eb6fc Kemeng Shi 2024-01-03  551  			       struct ext4_allocation_context *ac,
2b81493f8eb6fc Kemeng Shi 2024-01-03  552  			       ext4_grpblk_t start,
2b81493f8eb6fc Kemeng Shi 2024-01-03  553  			       ext4_grpblk_t len)
2b81493f8eb6fc Kemeng Shi 2024-01-03  554  {
2b81493f8eb6fc Kemeng Shi 2024-01-03  555  	struct super_block *sb = (struct super_block *)test->priv;
2b81493f8eb6fc Kemeng Shi 2024-01-03  556  	int ret;
2b81493f8eb6fc Kemeng Shi 2024-01-03  557  	void *bitmap;
2b81493f8eb6fc Kemeng Shi 2024-01-03  558  	ext4_grpblk_t i, max;
2b81493f8eb6fc Kemeng Shi 2024-01-03  559  
2b81493f8eb6fc Kemeng Shi 2024-01-03  560  	/* ext4_mb_mark_diskspace_used will BUG if len is 0 */
2b81493f8eb6fc Kemeng Shi 2024-01-03  561  	if (len == 0)
2b81493f8eb6fc Kemeng Shi 2024-01-03  562  		return;
2b81493f8eb6fc Kemeng Shi 2024-01-03  563  
2b81493f8eb6fc Kemeng Shi 2024-01-03  564  	ac->ac_b_ex.fe_group = TEST_GOAL_GROUP;
2b81493f8eb6fc Kemeng Shi 2024-01-03  565  	ac->ac_b_ex.fe_start = start;
2b81493f8eb6fc Kemeng Shi 2024-01-03  566  	ac->ac_b_ex.fe_len = len;
2b81493f8eb6fc Kemeng Shi 2024-01-03  567  
2b81493f8eb6fc Kemeng Shi 2024-01-03  568  	bitmap = mbt_ctx_bitmap(sb, TEST_GOAL_GROUP);
2b81493f8eb6fc Kemeng Shi 2024-01-03  569  	memset(bitmap, 0, sb->s_blocksize);
2b81493f8eb6fc Kemeng Shi 2024-01-03 @570  	ret = ext4_mb_mark_diskspace_used(ac, NULL, 0);
2b81493f8eb6fc Kemeng Shi 2024-01-03  571  	KUNIT_ASSERT_EQ(test, ret, 0);
2b81493f8eb6fc Kemeng Shi 2024-01-03  572  
2b81493f8eb6fc Kemeng Shi 2024-01-03  573  	max = EXT4_CLUSTERS_PER_GROUP(sb);
2b81493f8eb6fc Kemeng Shi 2024-01-03  574  	i = mb_find_next_bit(bitmap, max, 0);
2b81493f8eb6fc Kemeng Shi 2024-01-03  575  	KUNIT_ASSERT_EQ(test, i, start);
2b81493f8eb6fc Kemeng Shi 2024-01-03  576  	i = mb_find_next_zero_bit(bitmap, max, i + 1);
2b81493f8eb6fc Kemeng Shi 2024-01-03  577  	KUNIT_ASSERT_EQ(test, i, start + len);
2b81493f8eb6fc Kemeng Shi 2024-01-03  578  	i = mb_find_next_bit(bitmap, max, i + 1);
2b81493f8eb6fc Kemeng Shi 2024-01-03  579  	KUNIT_ASSERT_EQ(test, max, i);
2b81493f8eb6fc Kemeng Shi 2024-01-03  580  }
2b81493f8eb6fc Kemeng Shi 2024-01-03  581  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

