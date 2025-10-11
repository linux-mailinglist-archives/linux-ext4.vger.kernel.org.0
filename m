Return-Path: <linux-ext4+bounces-10786-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A3FBCF16C
	for <lists+linux-ext4@lfdr.de>; Sat, 11 Oct 2025 09:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FFC24E0599
	for <lists+linux-ext4@lfdr.de>; Sat, 11 Oct 2025 07:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11008226CF1;
	Sat, 11 Oct 2025 07:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YCykTuiZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82B51B85FD;
	Sat, 11 Oct 2025 07:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760168914; cv=none; b=L4/ah0cqb3YotwOvnwvHLSLsNFHcQabvcuPWTx8E11staWCWTYEiB4tMilbxT1ygUagY/Y/Eh3kbynMOt6UwTECLVqsG4gHFZERyJpvdHLlZYaWX+4O9lAcAUxiHQ6fP1LVC0/U6spRFukENbjp+8vfcNXLEHC7835MrTRqeAdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760168914; c=relaxed/simple;
	bh=LHHPf2UPJZHB06XnOCsmcRYEMeWIuhBk1mgQHMhJ01g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dkc2uB1WY2zRik7Bq1lPpAIaftySyEIDauznvmCxRAfsuoaPj6EygeCfUhhCSkeky4MD2KC6sXP0kZur3ntJUwB5mfqcM1p82wr/kONxLePWzmmiYZ9/WW4Q0dqcTAKopwkJD/Y1BphB6+RZ4KeWnSJZ6rK1SiwvHSvnCB/uPv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YCykTuiZ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760168913; x=1791704913;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LHHPf2UPJZHB06XnOCsmcRYEMeWIuhBk1mgQHMhJ01g=;
  b=YCykTuiZ25hIfXYT2xtcmAGHHUo4NnbCAOMmykZ3nDFZgokd5WiA0nCD
   TtDHBFxiZWdb/DC3Pi0Zf4guMGyZx0mwGdJM7R4w6hORjEii4GdZRdLmW
   TTJtQuQN3nYf1rEKdy/qPrVBgLPbjNcd9IAJHpZhBrF6m9uAaR2aN6cDO
   xBEWextGJJs/3GG1+Y5QIzI6/4MLb6tyYi7/DH03tXejpAV/5sJKQM6zQ
   h/ckYfkirl0umLhm0+HVtcS+EaX5k+VnRCWyutOwmn12/w6pDNASY9kVz
   yH1u2KnTeu2PWHHIP26igywa1nEjk9bNT7DFPtAhd85vgxPODArdEEdUq
   g==;
X-CSE-ConnectionGUID: oQzvBHz+S7ajz1WhwgG4Ww==
X-CSE-MsgGUID: mn0cXySjRciEYQInxxumew==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="73820260"
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="73820260"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 00:48:31 -0700
X-CSE-ConnectionGUID: ZK1hUfyNTlGOlZ3+a5VOhg==
X-CSE-MsgGUID: kvHUn0d+S8ip7VmHV25tLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="181168851"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 11 Oct 2025 00:48:28 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7UL4-0003ch-0V;
	Sat, 11 Oct 2025 07:48:26 +0000
Date: Sat, 11 Oct 2025 15:48:00 +0800
From: kernel test robot <lkp@intel.com>
To: Ranganath V N <vnranganath.20@gmail.com>, tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: oe-kbuild-all@lists.linux.dev, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
	khalid@kernel.org, Ranganath V N <vnranganath.20@gmail.com>
Subject: Re: [PATCH] fs: ext4: fix uninitialized symbols
Message-ID: <202510111521.OLlwqh7d-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on tytso-ext4/dev]
[also build test WARNING on linus/master v6.17 next-20251010]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ranganath-V-N/fs-ext4-fix-uninitialized-symbols/20251010-065232
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20251008171614.12129-1-vnranganath.20%40gmail.com
patch subject: [PATCH] fs: ext4: fix uninitialized symbols
config: i386-randconfig-063-20251011 (https://download.01.org/0day-ci/archive/20251011/202510111521.OLlwqh7d-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251011/202510111521.OLlwqh7d-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510111521.OLlwqh7d-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/ext4/inode.c:3547:34: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long long [usertype] next_pblk @@     got void * @@
   fs/ext4/inode.c:3547:34: sparse:     expected unsigned long long [usertype] next_pblk
   fs/ext4/inode.c:3547:34: sparse:     got void *

vim +3547 fs/ext4/inode.c

  3540	
  3541	static int ext4_map_blocks_atomic_write_slow(handle_t *handle,
  3542				struct inode *inode, struct ext4_map_blocks *map)
  3543	{
  3544		ext4_lblk_t m_lblk = map->m_lblk;
  3545		unsigned int m_len = map->m_len;
  3546		unsigned int mapped_len = 0, m_flags = 0;
> 3547		ext4_fsblk_t next_pblk = NULL;
  3548		bool check_next_pblk = false;
  3549		int ret = 0;
  3550	
  3551		WARN_ON_ONCE(!ext4_has_feature_bigalloc(inode->i_sb));
  3552	
  3553		/*
  3554		 * This is a slow path in case of mixed mapping. We use
  3555		 * EXT4_GET_BLOCKS_CREATE_ZERO flag here to make sure we get a single
  3556		 * contiguous mapped mapping. This will ensure any unwritten or hole
  3557		 * regions within the requested range is zeroed out and we return
  3558		 * a single contiguous mapped extent.
  3559		 */
  3560		m_flags = EXT4_GET_BLOCKS_CREATE_ZERO;
  3561	
  3562		do {
  3563			ret = ext4_map_blocks(handle, inode, map, m_flags);
  3564			if (ret < 0 && ret != -ENOSPC)
  3565				goto out_err;
  3566			/*
  3567			 * This should never happen, but let's return an error code to
  3568			 * avoid an infinite loop in here.
  3569			 */
  3570			if (ret == 0) {
  3571				ret = -EFSCORRUPTED;
  3572				ext4_warning_inode(inode,
  3573					"ext4_map_blocks() couldn't allocate blocks m_flags: 0x%x, ret:%d",
  3574					m_flags, ret);
  3575				goto out_err;
  3576			}
  3577			/*
  3578			 * With bigalloc we should never get ENOSPC nor discontiguous
  3579			 * physical extents.
  3580			 */
  3581			if ((check_next_pblk && next_pblk != map->m_pblk) ||
  3582					ret == -ENOSPC) {
  3583				ext4_warning_inode(inode,
  3584					"Non-contiguous allocation detected: expected %llu, got %llu, "
  3585					"or ext4_map_blocks() returned out of space ret: %d",
  3586					next_pblk, map->m_pblk, ret);
  3587				ret = -EFSCORRUPTED;
  3588				goto out_err;
  3589			}
  3590			next_pblk = map->m_pblk + map->m_len;
  3591			check_next_pblk = true;
  3592	
  3593			mapped_len += map->m_len;
  3594			map->m_lblk += map->m_len;
  3595			map->m_len = m_len - mapped_len;
  3596		} while (mapped_len < m_len);
  3597	
  3598		/*
  3599		 * We might have done some work in above loop, so we need to query the
  3600		 * start of the physical extent, based on the origin m_lblk and m_len.
  3601		 * Let's also ensure we were able to allocate the required range for
  3602		 * mixed mapping case.
  3603		 */
  3604		map->m_lblk = m_lblk;
  3605		map->m_len = m_len;
  3606		map->m_flags = 0;
  3607	
  3608		ret = ext4_map_blocks(handle, inode, map,
  3609				      EXT4_GET_BLOCKS_QUERY_LAST_IN_LEAF);
  3610		if (ret != m_len) {
  3611			ext4_warning_inode(inode,
  3612				"allocation failed for atomic write request m_lblk:%u, m_len:%u, ret:%d\n",
  3613				m_lblk, m_len, ret);
  3614			ret = -EINVAL;
  3615		}
  3616		return ret;
  3617	
  3618	out_err:
  3619		/* reset map before returning an error */
  3620		map->m_lblk = m_lblk;
  3621		map->m_len = m_len;
  3622		map->m_flags = 0;
  3623		return ret;
  3624	}
  3625	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

