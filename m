Return-Path: <linux-ext4+bounces-10779-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D18BCE442
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Oct 2025 20:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE45189FBA5
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Oct 2025 18:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695692FE569;
	Fri, 10 Oct 2025 18:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TblIOZoU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0568B2737E4;
	Fri, 10 Oct 2025 18:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760121739; cv=none; b=C1sFLdfP2+veMqMmwUUxgUVxNuX12KqWdtIimffoITJ2bX3qzYnlqgaaMNZwPn7knnkq/pAAnJZgpueIVSAKiuyhiypdSKTEla28HnvffNA8FlPl7eDmqK3tD127N84jrkJyUPxAQmG0jXTHiD5muqeo1E13tN3s70zQDegWdII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760121739; c=relaxed/simple;
	bh=S73rbUBFC+mrE245jU9Ypo/25QVGZaOzPsk13eaG0cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWV16l5k8tFMg3Eb+l5QUUS178yyTE4ShcVsVJCGPjJ+/5Vr6APbsscCOw2ygl2ATG4MpY+D7Y4O+X54agqr34nTjwLhkMjuNfi5F9akhD/Rnhzmyv1ecB2E56dVvCqoFJjrhmgyKOks6pN3NqnGVv2SzIyH5FOwL6jzHGlCADE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TblIOZoU; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760121736; x=1791657736;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S73rbUBFC+mrE245jU9Ypo/25QVGZaOzPsk13eaG0cA=;
  b=TblIOZoUUQ/scCgqT0poTi9jrtT0r4bSmmA89V7azKtQF4UdjNd/tdxo
   iWqjbbDEGnPcXU7ZDovNpUVfAXWgNhq4nI9yfzJbCOZy/UKRuuuFGWI0u
   dkvwhQxZhQRC7kap4nc9D4irIkmXZZhNAmxpmeeZVJIHBWjQjhzck/uh3
   0j+RVi1H15wDuZhPBeqqiTVdTZLvk512RbCxnalpppqlvgRPxzGx+Cq5L
   /twUJn5ITJWtT80vAGx/4AohRmRyaRvBvhDbq1jkChUzIenAozAC6KKgV
   Wk2aG6OZLEHjysYOOGbA9BkXdQLyl4kcqZFSiSo5TsUWM9gyWV2VQnKYx
   A==;
X-CSE-ConnectionGUID: 2ZMZfkvCSce/4aE6fmTYRg==
X-CSE-MsgGUID: HmZ+TZt1RI2UONS9TvpaPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="62442280"
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="62442280"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 11:42:15 -0700
X-CSE-ConnectionGUID: maYslqNSRYyJyS4GdUHGDQ==
X-CSE-MsgGUID: oN6dYjExSVWeoWkmOMQbyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="180870341"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 10 Oct 2025 11:42:12 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7I49-000343-2n;
	Fri, 10 Oct 2025 18:42:09 +0000
Date: Sat, 11 Oct 2025 02:41:36 +0800
From: kernel test robot <lkp@intel.com>
To: Ranganath V N <vnranganath.20@gmail.com>, tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: oe-kbuild-all@lists.linux.dev, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
	khalid@kernel.org, Ranganath V N <vnranganath.20@gmail.com>
Subject: Re: [PATCH] fs: ext4: fix uninitialized symbols
Message-ID: <202510110207.yBvUMr5Z-lkp@intel.com>
References: <20251008171614.12129-1-vnranganath.20@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008171614.12129-1-vnranganath.20@gmail.com>

Hi Ranganath,

kernel test robot noticed the following build errors:

[auto build test ERROR on tytso-ext4/dev]
[also build test ERROR on linus/master v6.17 next-20251010]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ranganath-V-N/fs-ext4-fix-uninitialized-symbols/20251010-065232
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20251008171614.12129-1-vnranganath.20%40gmail.com
patch subject: [PATCH] fs: ext4: fix uninitialized symbols
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20251011/202510110207.yBvUMr5Z-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251011/202510110207.yBvUMr5Z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510110207.yBvUMr5Z-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/objtool_types.h:7,
                    from include/linux/objtool.h:5,
                    from include/linux/instrumentation.h:7,
                    from arch/x86/include/asm/bug.h:6,
                    from include/linux/bug.h:5,
                    from include/linux/vfsdebug.h:5,
                    from include/linux/fs.h:5,
                    from fs/ext4/inode.c:22:
   fs/ext4/inode.c: In function 'ext4_map_blocks_atomic_write_slow':
>> include/linux/stddef.h:8:14: error: initialization of 'ext4_fsblk_t' {aka 'long long unsigned int'} from 'void *' makes integer from pointer without a cast [-Wint-conversion]
       8 | #define NULL ((void *)0)
         |              ^
   fs/ext4/inode.c:3547:34: note: in expansion of macro 'NULL'
    3547 |         ext4_fsblk_t next_pblk = NULL;
         |                                  ^~~~


vim +8 include/linux/stddef.h

^1da177e4c3f41 Linus Torvalds   2005-04-16  6  
^1da177e4c3f41 Linus Torvalds   2005-04-16  7  #undef NULL
^1da177e4c3f41 Linus Torvalds   2005-04-16 @8  #define NULL ((void *)0)
6e218287432472 Richard Knutsson 2006-09-30  9  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

