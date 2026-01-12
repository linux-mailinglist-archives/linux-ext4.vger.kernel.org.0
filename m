Return-Path: <linux-ext4+bounces-12739-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 795FCD15787
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Jan 2026 22:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB8B8300968F
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Jan 2026 21:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA26343D7B;
	Mon, 12 Jan 2026 21:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ha2II4nY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBD3342525
	for <linux-ext4@vger.kernel.org>; Mon, 12 Jan 2026 21:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768254228; cv=none; b=LoJHK0DRQWWcTIkFoVZHUpc62qvfDDVMjK6sSrfZFHVhLiezwcF6Osrpyyyff0VMdk7qSh9wRYEvdfRdHz33jtMJzcre88N6MYzw64w+3QOW3jgGHauoLELYc9l8qq3m1CQ+OV3LgIRTxWLtD1NTpojNVxmACmRz6zuoKFo0SPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768254228; c=relaxed/simple;
	bh=58E0h/b6o9dHKR8rRXLMUueE2qtgFm4P/nvejTVp0B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rx+7LAxJk8xRcHQ+a07iAO0IChs9oIqV8MLVusWt98vUvD4ltu3kKaTJ67N92Oq86/GkoGfnj2xoOD3Gkf8y5cwSLzAJ6qqWGPjYc/itbtFU17zKVmn2gEN5jFYS1KqLCPpb25VbHzXC8GMAPo5QVKlFHzgbvFWji4pJnRLNwuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ha2II4nY; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768254227; x=1799790227;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=58E0h/b6o9dHKR8rRXLMUueE2qtgFm4P/nvejTVp0B4=;
  b=ha2II4nYlISW1lUAKJQdCUwjrIEleNDV6MiY4osyvJumnyJSaFFDXK8G
   /VCbNho9cirp/3WBB/U0uy+HNxFcYiBv7ULTDlWkL7AW7mP2E6LQL5r+i
   NX0LTN9LKqdFkAUyd/3jhPLx9YNFw7NtDClV+hiol08t4BYFp9eOhvgT9
   QO4Rgn1m32rVM3sebtGsBO0voJFRN0bio2FnMBIUfGysrqCLmvK4eyiEM
   gbi/oP27hPghCJUYNrWhc4iqM0G0+xqxldCEUXXG6bABI4L5j0mQrydAh
   6aNAGv9eaeeK8H3+qaS5jSUyEAOcWTRlLtwgWdymeC8Tn1fZynEbE8JGr
   Q==;
X-CSE-ConnectionGUID: ati5c4IrTnCYwajssJz4Zw==
X-CSE-MsgGUID: gPBlldcjRMOiiAyUl/Rgfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="69586656"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="69586656"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 13:43:46 -0800
X-CSE-ConnectionGUID: rQS+mfM6T4Gn6t5GmsNyFQ==
X-CSE-MsgGUID: tHn0vppdTf+hhEk4vnd55g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="208672357"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 12 Jan 2026 13:43:45 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vfPhO-00000000Dto-1T9l;
	Mon, 12 Jan 2026 21:43:42 +0000
Date: Tue, 13 Jan 2026 05:43:10 +0800
From: kernel test robot <lkp@intel.com>
To: Brian Foster <bfoster@redhat.com>, linux-ext4@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH v2] ext4: fix dirtyclusters double decrement on fs
 shutdown
Message-ID: <202601130527.WKPDXmMv-lkp@intel.com>
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
config: arm64-randconfig-002-20260113 (https://download.01.org/0day-ci/archive/20260113/202601130527.WKPDXmMv-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260113/202601130527.WKPDXmMv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601130527.WKPDXmMv-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/ext4/mballoc.c:7185:
>> fs/ext4/mballoc-test.c:570:46: error: too many arguments to function call, expected 2, have 3
     570 |         ret = ext4_mb_mark_diskspace_used(ac, NULL, 0);
         |               ~~~~~~~~~~~~~~~~~~~~~~~~~~~           ^
   fs/ext4/mballoc.c:4188:1: note: 'ext4_mb_mark_diskspace_used' declared here
    4188 | ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac, handle_t *handle)
         | ^                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +570 fs/ext4/mballoc-test.c

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

