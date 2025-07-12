Return-Path: <linux-ext4+bounces-8964-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC11B02D2B
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 23:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBF241AA10FC
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 21:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93681225A47;
	Sat, 12 Jul 2025 21:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MOVMPvp/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A2922258C;
	Sat, 12 Jul 2025 21:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752354809; cv=none; b=Z6O3aOxEHLnxLkPeLXhL1C3KGsphnoQ9c8AUxcClhsSXgSVzRUVMO4hbgu9/IFQ9Qti62I7meciDSgn1hdgTjgThmty2IsSNHjgY1Wy6roG4sGjM8kn8hwYxAp0Zb+VQcQ9bSkmJFjZkaCXOpAf9hWVlWn4UX/ePPAwiXt5XrzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752354809; c=relaxed/simple;
	bh=Yu/rqVtdJk1LsdyRzRH1EGxF9c126JGgqO4jhJfARbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nz4qVaULNtZDeGoJoBgQaDPgFlWVTfDrssLXGOo0ircITK7ZUceYbeikxuGlaz9WlZG3it8KyU72kOpHWlijvgy1K3234yemu07cWc3ye3iSgaOpRfzfUdCnzDevTPLfLDFQxbEmRxkmmU0C7tAHEscimApYI9nlV4tqwDIl0OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MOVMPvp/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752354807; x=1783890807;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Yu/rqVtdJk1LsdyRzRH1EGxF9c126JGgqO4jhJfARbI=;
  b=MOVMPvp/xwr8XT53LlYTi2HzZRLDbGQrquovFfofN1Ds0HGdmlc0Y+Ef
   PGMRKUk92Xo1qk8t737OTIL4oy5SDbSwaYvgkCdsqiFcVYS9R10X+Rgo1
   7K+aOVsw22hMs258tVMu7rRaI5NABfsAp1tqgxZqECI0Ugxlm3P5ptwzP
   w04fAiAVhvEE2W1ScL38UfUNTaCYJTf4ZBOJ3MK2UOVgA0ihE8auB66L0
   CtvhGAhxtPNZFIDEht/xoL0X5cHx4SpCyESNhaUOuMGWmLgEVKEwYBzYy
   QAvhNALu3Tz4s5oczd6ezsN3NRuOed3pqEb7/3NduYKqYiBvpB1G17VDM
   g==;
X-CSE-ConnectionGUID: wHilQttCTKuYnc9dn3wN3g==
X-CSE-MsgGUID: Bbmpj/lmSZWldPtGzOLcbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54476829"
X-IronPort-AV: E=Sophos;i="6.16,307,1744095600"; 
   d="scan'208";a="54476829"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 14:13:27 -0700
X-CSE-ConnectionGUID: 1ZUU7DwHSiO8IorFCloulg==
X-CSE-MsgGUID: R8lcEXhPTna0lvIwW0q9iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,307,1744095600"; 
   d="scan'208";a="160930908"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 12 Jul 2025 14:13:25 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uahX7-0007h5-3A;
	Sat, 12 Jul 2025 21:13:21 +0000
Date: Sun, 13 Jul 2025 05:12:55 +0800
From: kernel test robot <lkp@intel.com>
To: Theodore Ts'o <tytso@mit.edu>,
	Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-hardening@vger.kernel.org,
	ethan@ethancedwards.com, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 3/3] ext4: refactor the inline directory conversion and
 new directory codepaths
Message-ID: <202507130429.rPIzofCD-lkp@intel.com>
References: <20250712181249.434530-3-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250712181249.434530-3-tytso@mit.edu>

Hi Theodore,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tytso-ext4/dev]
[also build test WARNING on linus/master v6.16-rc5 next-20250711]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Theodore-Ts-o/ext4-use-memcpy-instead-of-strcpy/20250713-021635
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20250712181249.434530-3-tytso%40mit.edu
patch subject: [PATCH 3/3] ext4: refactor the inline directory conversion and new directory codepaths
config: i386-buildonly-randconfig-004-20250713 (https://download.01.org/0day-ci/archive/20250713/202507130429.rPIzofCD-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250713/202507130429.rPIzofCD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507130429.rPIzofCD-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/ext4/namei.c: In function 'ext4_init_new_dir':
>> fs/ext4/namei.c:2968:34: warning: variable 'de' set but not used [-Wunused-but-set-variable]
    2968 |         struct ext4_dir_entry_2 *de;
         |                                  ^~


vim +/de +2968 fs/ext4/namei.c

a774f9c20e0864 Tao Ma             2012-12-10  2963  
8016e29f4362e2 Harshad Shirwadkar 2020-10-15  2964  int ext4_init_new_dir(handle_t *handle, struct inode *dir,
a774f9c20e0864 Tao Ma             2012-12-10  2965  			     struct inode *inode)
ac27a0ec112a08 Dave Kleikamp      2006-10-11  2966  {
dabd991f9d8e32 Namhyung Kim       2011-01-10  2967  	struct buffer_head *dir_block = NULL;
617ba13b31fbf5 Mingming Cao       2006-10-11 @2968  	struct ext4_dir_entry_2 *de;
dc6982ff4db1f4 Theodore Ts'o      2013-02-14  2969  	ext4_lblk_t block = 0;
a774f9c20e0864 Tao Ma             2012-12-10  2970  	int err;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  2971  
3c47d54170b6a6 Tao Ma             2012-12-10  2972  	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)) {
3c47d54170b6a6 Tao Ma             2012-12-10  2973  		err = ext4_try_create_inline_dir(handle, dir, inode);
3c47d54170b6a6 Tao Ma             2012-12-10  2974  		if (err < 0 && err != -ENOSPC)
3c47d54170b6a6 Tao Ma             2012-12-10  2975  			goto out;
3c47d54170b6a6 Tao Ma             2012-12-10  2976  		if (!err)
3c47d54170b6a6 Tao Ma             2012-12-10  2977  			goto out;
3c47d54170b6a6 Tao Ma             2012-12-10  2978  	}
3c47d54170b6a6 Tao Ma             2012-12-10  2979  
5eb8361f6b02c3 Theodore Ts'o      2025-07-12  2980  	set_nlink(inode, 2);
dc6982ff4db1f4 Theodore Ts'o      2013-02-14  2981  	inode->i_size = 0;
0f70b40613ee14 Theodore Ts'o      2013-02-15  2982  	dir_block = ext4_append(handle, inode, &block);
0f70b40613ee14 Theodore Ts'o      2013-02-15  2983  	if (IS_ERR(dir_block))
0f70b40613ee14 Theodore Ts'o      2013-02-15  2984  		return PTR_ERR(dir_block);
a774f9c20e0864 Tao Ma             2012-12-10  2985  	de = (struct ext4_dir_entry_2 *)dir_block->b_data;
5eb8361f6b02c3 Theodore Ts'o      2025-07-12  2986  	err = ext4_init_dirblock(handle, inode, dir_block, dir->i_ino, NULL, 0);
a774f9c20e0864 Tao Ma             2012-12-10  2987  	if (err)
a774f9c20e0864 Tao Ma             2012-12-10  2988  		goto out;
a774f9c20e0864 Tao Ma             2012-12-10  2989  out:
a774f9c20e0864 Tao Ma             2012-12-10  2990  	brelse(dir_block);
a774f9c20e0864 Tao Ma             2012-12-10  2991  	return err;
a774f9c20e0864 Tao Ma             2012-12-10  2992  }
a774f9c20e0864 Tao Ma             2012-12-10  2993  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

