Return-Path: <linux-ext4+bounces-4837-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C8E9B331A
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Oct 2024 15:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B55691F215F9
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Oct 2024 14:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A383A1DE2AA;
	Mon, 28 Oct 2024 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K/Cglwzm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C046D1DDC3F;
	Mon, 28 Oct 2024 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124909; cv=none; b=oSewyLi1ZHDvIBAW91Brd1v3VP6nTyxN0aZTWKjkkhDrB3tEZKbldeJksYUifUNAYHtd/35EgmtKE47o8bx48+FTjI34g+prVgZcVahuL9uIjzeVh9K95aprzlSirCPzFEsi6McHat9xiV5He0tB7HGOhjGRByr7+ZiF4sFsp+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124909; c=relaxed/simple;
	bh=KauFzW447yV1YygaFufYczwE3m1im87cT3aqIlvlSus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3V2jZlsRXJePM/ahu0SOaM5yjRF/gGlgxjjCDRC93Io5rFVyvExnyr8dl9kNkX7SyCbftruSA3sHc5+8iHMFG5pP/bz2ACCXITfVtmv4ErtdGcVLCu6S5ODleyLXEm9v3G+cAb9AEvukQV0K05pAsYyLgUhunjxwpP9CLoZss4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K/Cglwzm; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730124906; x=1761660906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KauFzW447yV1YygaFufYczwE3m1im87cT3aqIlvlSus=;
  b=K/CglwzmnRxql9YD/hxG0w2xEkDgPcZKGTflVPIGHzzS3bWA1FOd7lXB
   RcBNq2xB4hTcE3IHbJULA4WcFeD1qR5jcGNxZb2mNZwcKF6F5r+lXI78T
   39fY0qq1who8vg+joga9zqui3fO0WjnTpjTVP33lzmKFB9SM3r59uKgTK
   YoOF7Hjupll70of4QHklOM4hsptRUQGdu0HDlvzDf+wH4q+YzygZq59Ge
   1S69DQk+zvTnP1On2enX3fDqgPWxYMJKtla9kWvbmCGlwfsTpSTHjjj9O
   dpAw7/Agxpq3vCUjLKFFQm48Gqwl3V2reNirMwnDwSQhvTaEHNvGEbJLH
   w==;
X-CSE-ConnectionGUID: uFOXXgZESx2DaktINyeAyA==
X-CSE-MsgGUID: Rv1pIwYVRq6cTjiS8suKLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29827727"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="29827727"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 07:15:06 -0700
X-CSE-ConnectionGUID: y2TPtzXrQHmVK0j7fB4TOA==
X-CSE-MsgGUID: xQ4JiPp0Ram2dVoO9axa3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="81951815"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 28 Oct 2024 07:15:04 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5QWL-000cVw-2G;
	Mon, 28 Oct 2024 14:15:01 +0000
Date: Mon, 28 Oct 2024 22:14:25 +0800
From: kernel test robot <lkp@intel.com>
To: Edward Adam Davis <eadavis@qq.com>,
	syzbot+0c99c3f90699936c1e77@syzkaller.appspotmail.com
Cc: oe-kbuild-all@lists.linux.dev, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [PATCH] ext4: Add a sanity check for next dentry when insert
Message-ID: <202410282131.FBDMC1Gq-lkp@intel.com>
References: <tencent_E4CFC65D09852ECE2EF28C83A7C3C6E41206@qq.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_E4CFC65D09852ECE2EF28C83A7C3C6E41206@qq.com>

Hi Edward,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tytso-ext4/dev]
[also build test WARNING on linus/master v6.12-rc5 next-20241028]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Edward-Adam-Davis/ext4-Add-a-sanity-check-for-next-dentry-when-insert/20241027-191200
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/tencent_E4CFC65D09852ECE2EF28C83A7C3C6E41206%40qq.com
patch subject: [PATCH] ext4: Add a sanity check for next dentry when insert
config: x86_64-randconfig-121-20241028 (https://download.01.org/0day-ci/archive/20241028/202410282131.FBDMC1Gq-lkp@intel.com/config)
compiler: clang version 19.1.2 (https://github.com/llvm/llvm-project 7ba7d8e2f7b6445b60679da826210cdde29eaf8b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241028/202410282131.FBDMC1Gq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410282131.FBDMC1Gq-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/ext4/namei.c:2087:5: sparse: sparse: symbol 'ext4_check_next_dentry' was not declared. Should it be static?
   fs/ext4/namei.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:237:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:237:46: sparse: sparse: self-comparison always evaluates to false
   fs/ext4/namei.c: note: in included file:
   fs/ext4/ext4.h:2429:9: sparse: sparse: self-comparison always evaluates to false

vim +/ext4_check_next_dentry +2087 fs/ext4/namei.c

  2086	
> 2087	int ext4_check_next_dentry(struct inode *dir,
  2088				struct inode *inode,
  2089				struct ext4_dir_entry_2 *de,
  2090				int buf_size,
  2091				struct ext4_filename *fname)
  2092	{
  2093		int nlen, rlen;
  2094	
  2095		nlen = ext4_dir_rec_len(de->name_len, dir);
  2096		rlen = ext4_rec_len_from_disk(de->rec_len, buf_size);
  2097		if (de->inode) {
  2098			struct ext4_dir_entry_2 *nde =
  2099				(struct ext4_dir_entry_2 *)((char *)de + nlen);
  2100			nde->rec_len = ext4_rec_len_to_disk(rlen - nlen, buf_size);
  2101			de->rec_len = ext4_rec_len_to_disk(nlen, buf_size);
  2102			de = nde;
  2103			rlen = ext4_rec_len_from_disk(de->rec_len, buf_size);
  2104			return fname_len(fname) > rlen - EXT4_BASE_DIR_LEN;
  2105		}
  2106	
  2107		return 0;
  2108	}
  2109	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

