Return-Path: <linux-ext4+bounces-12267-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE00CB35F5
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 16:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE1FE3016707
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 15:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591D225392C;
	Wed, 10 Dec 2025 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nlVE4Pcu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482C624469E;
	Wed, 10 Dec 2025 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765381827; cv=none; b=OuplqyrRRs5HD2PkbzTeiI9/F1gto0FwHsGBjCZg1A2iUMc0Pd2cR9E4oG+/We5yAg4J6guabl7dhFMRyRl0ULEZjXUu7a+ppq3Kzx2oJuKzRwCmtWNICav/WZgMKtqG/xseuqgmQZx7JBb9llMVV3grXCUUHl5uagHpdylhJUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765381827; c=relaxed/simple;
	bh=hasZzzOaLmSc07adgtyvn0E8N2Cwm1aRTz9PRqpmc9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2Qz6TRg9w/P+ZTiwf4kTs4MmSKRb4NUgLYB6h7T2qD3Q1Y8L/GIdPLx7BTLg9vteQa/2HgqzVu9xnyjIuyVqLI/ySMtPYgkoMf7InB5ILSkps+qptjc/LFAhMMCqRl1aHbkNYCgfO5acqFYPP9VsER52BfXhh/NFvmwtWkguOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nlVE4Pcu; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765381826; x=1796917826;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hasZzzOaLmSc07adgtyvn0E8N2Cwm1aRTz9PRqpmc9g=;
  b=nlVE4PcuAwTWgO0B84cp2ds1juCoM/otJ5SmzEfzap68DvJ0P11gENKc
   Tw9Uyp8dhcfQ1zetQvRhl473H5KN3uQ6fGOqQCvfwjx/KWWDjJLyTABd9
   oIA+Os5+k2LhNVErc4rtLbrsdsmP1mY92E7Vlw35Unl/3x890ET/c1XkT
   WA7bqbNCjUugs9qjAPqLzqP3nNnwdV5jhWOIkK0YOTtZhIVLeSOxW+wlo
   pluTvsfA7I7nbOwrTK1WNaO+6s3yGpO1LoRWykZqTS2pJs24yOl0gDgVV
   Ug6JPSLIQSzcBWWxYrHQCZKpEXjBBbb7DL9bqjj2df09SRIORIkxDKPuq
   Q==;
X-CSE-ConnectionGUID: hAmzzjzNQASx+6rG/Ns6LQ==
X-CSE-MsgGUID: bTX+0oe+TqKd+8glfXY33Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67292948"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="67292948"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 07:50:26 -0800
X-CSE-ConnectionGUID: hJQ52FewSE6ia09b0K4ShQ==
X-CSE-MsgGUID: 6ohFTmlJS5mpslT9vJaFCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; 
   d="scan'208";a="233954105"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 10 Dec 2025 07:50:24 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vTMSL-000000003Kb-2LF8;
	Wed, 10 Dec 2025 15:50:21 +0000
Date: Wed, 10 Dec 2025 23:49:40 +0800
From: kernel test robot <lkp@intel.com>
To: Yu Kuai <yukuai@fnnas.com>, tytso@mit.edu, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	yukuai@fnnas.com
Subject: Re: [PATCH 2/2] ext4: align preallocation size to stripe width
Message-ID: <202512102331.yweFnVTU-lkp@intel.com>
References: <20251208083246.320965-3-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208083246.320965-3-yukuai@fnnas.com>

Hi Yu,

kernel test robot noticed the following build errors:

[auto build test ERROR on tytso-ext4/dev]
[also build test ERROR on linus/master v6.18 next-20251210]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yu-Kuai/ext4-refactor-size-prediction-into-helper-functions/20251208-163553
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20251208083246.320965-3-yukuai%40fnnas.com
patch subject: [PATCH 2/2] ext4: align preallocation size to stripe width
config: i386-randconfig-001-20251210 (https://download.01.org/0day-ci/archive/20251210/202512102331.yweFnVTU-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251210/202512102331.yweFnVTU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512102331.yweFnVTU-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: fs/ext4/mballoc.o: in function `ext4_mb_predict_file_size':
>> fs/ext4/mballoc.c:4570:(.text+0xc37): undefined reference to `__moddi3'
>> ld: fs/ext4/mballoc.c:4578:(.text+0xc7c): undefined reference to `__moddi3'
   ld: fs/ext4/mballoc.c:4584:(.text+0xcf2): undefined reference to `__moddi3'


vim +4570 fs/ext4/mballoc.c

  4522	
  4523	/*
  4524	 * Predict file size for preallocation. Returns the predicted size
  4525	 * in bytes. When stripe width (io_opt) is configured, returns sizes
  4526	 * that are multiples of stripe for optimal RAID performance.
  4527	 *
  4528	 * Sets start_off if alignment is needed for large files.
  4529	 */
  4530	static loff_t ext4_mb_predict_file_size(struct ext4_sb_info *sbi,
  4531						struct ext4_allocation_context *ac,
  4532						loff_t size, loff_t *start_off)
  4533	{
  4534		int bsbits = ac->ac_sb->s_blocksize_bits;
  4535		int max = 2 << bsbits;
  4536	
  4537		*start_off = 0;
  4538	
  4539		/*
  4540		 * For RAID/striped devices, align preallocation size to stripe
  4541		 * width (io_opt) for optimal I/O performance. Use power-of-2
  4542		 * multiples of stripe size for size prediction.
  4543		 */
  4544		if (sbi->s_stripe) {
  4545			loff_t stripe_bytes = (loff_t)sbi->s_stripe << bsbits;
  4546			loff_t max_size = (loff_t)max << bsbits;
  4547	
  4548			/*
  4549			 * TODO: If stripe is larger than max chunk size, we can't
  4550			 * do stripe-aligned allocation. Fall back to traditional
  4551			 * size prediction. This can happen with very large stripe
  4552			 * configurations on small block sizes.
  4553			 */
  4554			if (stripe_bytes > max_size)
  4555				goto no_stripe;
  4556	
  4557			if (size <= stripe_bytes) {
  4558				size = stripe_bytes;
  4559			} else if (size <= stripe_bytes * 2) {
  4560				size = stripe_bytes * 2;
  4561			} else if (size <= stripe_bytes * 4) {
  4562				size = stripe_bytes * 4;
  4563			} else if (size <= stripe_bytes * 8) {
  4564				size = stripe_bytes * 8;
  4565			} else if (size <= stripe_bytes * 16) {
  4566				size = stripe_bytes * 16;
  4567			} else if (size <= stripe_bytes * 32) {
  4568				size = stripe_bytes * 32;
  4569			} else {
> 4570				size = roundup(size, stripe_bytes);
  4571			}
  4572	
  4573			/*
  4574			 * Limit size to max free chunk size, rounded down to
  4575			 * stripe alignment.
  4576			 */
  4577			if (size > max_size)
> 4578				size = rounddown(max_size, stripe_bytes);
  4579	
  4580			/*
  4581			 * Align start offset to stripe boundary for large allocations
  4582			 * to ensure both start and size are stripe-aligned.
  4583			 */
  4584			*start_off = rounddown((loff_t)ac->ac_o_ex.fe_logical << bsbits,
  4585					       stripe_bytes);
  4586	
  4587			return size;
  4588		}
  4589	
  4590	no_stripe:
  4591		/* No stripe: use traditional hardcoded size prediction */
  4592		if (size <= 16 * 1024) {
  4593			size = 16 * 1024;
  4594		} else if (size <= 32 * 1024) {
  4595			size = 32 * 1024;
  4596		} else if (size <= 64 * 1024) {
  4597			size = 64 * 1024;
  4598		} else if (size <= 128 * 1024) {
  4599			size = 128 * 1024;
  4600		} else if (size <= 256 * 1024) {
  4601			size = 256 * 1024;
  4602		} else if (size <= 512 * 1024) {
  4603			size = 512 * 1024;
  4604		} else if (size <= 1024 * 1024) {
  4605			size = 1024 * 1024;
  4606		} else if (ext4_mb_check_size(size, 4 * 1024 * 1024, max, 2 * 1024)) {
  4607			*start_off = ((loff_t)ac->ac_o_ex.fe_logical >>
  4608							(21 - bsbits)) << 21;
  4609			size = 2 * 1024 * 1024;
  4610		} else if (ext4_mb_check_size(size, 8 * 1024 * 1024, max, 4 * 1024)) {
  4611			*start_off = ((loff_t)ac->ac_o_ex.fe_logical >>
  4612								(22 - bsbits)) << 22;
  4613			size = 4 * 1024 * 1024;
  4614		} else if (ext4_mb_check_size(EXT4_C2B(sbi, ac->ac_o_ex.fe_len),
  4615						(8<<20)>>bsbits, max, 8 * 1024)) {
  4616			*start_off = ((loff_t)ac->ac_o_ex.fe_logical >>
  4617								(23 - bsbits)) << 23;
  4618			size = 8 * 1024 * 1024;
  4619		} else {
  4620			*start_off = (loff_t)ac->ac_o_ex.fe_logical << bsbits;
  4621			size = (loff_t)EXT4_C2B(sbi, ac->ac_o_ex.fe_len) << bsbits;
  4622		}
  4623	
  4624		return size;
  4625	}
  4626	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

