Return-Path: <linux-ext4+bounces-5545-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2515C9EC426
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Dec 2024 06:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B67E167704
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Dec 2024 05:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75191C07D9;
	Wed, 11 Dec 2024 05:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XdH1zUkz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27701BDAA0;
	Wed, 11 Dec 2024 05:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733893972; cv=none; b=QQePcSyQYWXVTc6DZevszPBlA8ksqjrGD+4DjrLTgF9IqfSt7cV32Azoswb+1sPxEyEyrXtfzgJwhAQB267cS6TpkB9zUcRNhYmlMkECIxX9lL8KO4y289WcmuYhzVs//9n17crX3Aqa1WwCd9o5kcI7oPrYUdH2Y/Mgz+ai7Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733893972; c=relaxed/simple;
	bh=TmSuMxI+37qp//b+Vc1lTofp/uZJ35cEAzMFBvx1dhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2h5JnKqNXgBKDBOy6scftRLETwRpJZ0Sqei28K6tO4Ipu2OgqnEn5DZWz56UPs8HWbcijG6Xlpj1Cxl/tr/SBFoWG5zUhUaQE3R5wDpYpj/pvCe67K2xcbEm/M5PBo/I6wIBSZnGLwpnRs3EENsfRM/hD5QDkN6hb2RziCMizc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XdH1zUkz; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733893970; x=1765429970;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TmSuMxI+37qp//b+Vc1lTofp/uZJ35cEAzMFBvx1dhw=;
  b=XdH1zUkzuEAEePZl7khXDrBC5Fgh+QVTRjQV4iH3nE6JNvs2qUoch9tM
   +APab0HRsPg+UER6JsK7Rh/FffhS1HLuCXBnrC7q+9EJQTVcEQH53/e1i
   3D9xKHtiUJ8OLTZE+IY1bTJNwyZsyRmajq4jsO1YKGJlpIRWg2w1NWLAK
   NMx2xx23fwN5xSdn8ASOYPjBUW1WKl1FC2JVuqUFNiD1/EQfqB0oe4tBK
   JGGr6Y1z54TVXrAUXIyH74c/a6HrWjEv/N+cAWE9jq2/mg1oQ32mBbIa6
   UQkPIHpE3PQSAdoxRQaPCKvd+urk6aaiorHas0gIpIEFQXYK0Uj/CbjS/
   Q==;
X-CSE-ConnectionGUID: tczH6gCSTc+LRu0ZHqMomw==
X-CSE-MsgGUID: BfhAedCTRJ6izDy0y+hAvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="33989696"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="33989696"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 21:12:49 -0800
X-CSE-ConnectionGUID: aq4+8XcnQbiDK1Q+Njg5aA==
X-CSE-MsgGUID: sEnUX6MqT9ajffeP+66V+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="100715439"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 10 Dec 2024 21:12:46 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLF1f-0006J7-0o;
	Wed, 11 Dec 2024 05:12:43 +0000
Date: Wed, 11 Dec 2024 13:12:14 +0800
From: kernel test robot <lkp@intel.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	linux-ext4@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Mingming Cao <cmm@us.ibm.com>, Kalpak Shah <kalpak@clusterfs.com>,
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	syzbot+57934e2c8e7a99992e41@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: only test for inode xattr state when expanding
 inode
Message-ID: <202412111225.cNzuFVRM-lkp@intel.com>
References: <20241210174850.4027690-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210174850.4027690-1-cascardo@igalia.com>

Hi Thadeu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tytso-ext4/dev]
[also build test WARNING on linus/master v6.13-rc2 next-20241210]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thadeu-Lima-de-Souza-Cascardo/ext4-only-test-for-inode-xattr-state-when-expanding-inode/20241211-015015
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20241210174850.4027690-1-cascardo%40igalia.com
patch subject: [PATCH] ext4: only test for inode xattr state when expanding inode
config: csky-randconfig-002-20241211 (https://download.01.org/0day-ci/archive/20241211/202412111225.cNzuFVRM-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241211/202412111225.cNzuFVRM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412111225.cNzuFVRM-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/ext4/inode.c: In function '__ext4_expand_extra_isize':
>> fs/ext4/inode.c:5818:41: warning: variable 'header' set but not used [-Wunused-but-set-variable]
    5818 |         struct ext4_xattr_ibody_header *header;
         |                                         ^~~~~~


vim +/header +5818 fs/ext4/inode.c

ac27a0ec112a089 Dave Kleikamp                 2006-10-11  5811  
c03b45b853f5829 Miao Xie                      2017-08-06  5812  static int __ext4_expand_extra_isize(struct inode *inode,
c03b45b853f5829 Miao Xie                      2017-08-06  5813  				     unsigned int new_extra_isize,
c03b45b853f5829 Miao Xie                      2017-08-06  5814  				     struct ext4_iloc *iloc,
c03b45b853f5829 Miao Xie                      2017-08-06  5815  				     handle_t *handle, int *no_expand)
c03b45b853f5829 Miao Xie                      2017-08-06  5816  {
c03b45b853f5829 Miao Xie                      2017-08-06  5817  	struct ext4_inode *raw_inode;
c03b45b853f5829 Miao Xie                      2017-08-06 @5818  	struct ext4_xattr_ibody_header *header;
4ea99936a1630f5 Theodore Ts'o                 2019-11-07  5819  	unsigned int inode_size = EXT4_INODE_SIZE(inode->i_sb);
4ea99936a1630f5 Theodore Ts'o                 2019-11-07  5820  	struct ext4_inode_info *ei = EXT4_I(inode);
c03b45b853f5829 Miao Xie                      2017-08-06  5821  	int error;
c03b45b853f5829 Miao Xie                      2017-08-06  5822  
4ea99936a1630f5 Theodore Ts'o                 2019-11-07  5823  	/* this was checked at iget time, but double check for good measure */
4ea99936a1630f5 Theodore Ts'o                 2019-11-07  5824  	if ((EXT4_GOOD_OLD_INODE_SIZE + ei->i_extra_isize > inode_size) ||
4ea99936a1630f5 Theodore Ts'o                 2019-11-07  5825  	    (ei->i_extra_isize & 3)) {
4ea99936a1630f5 Theodore Ts'o                 2019-11-07  5826  		EXT4_ERROR_INODE(inode, "bad extra_isize %u (inode size %u)",
4ea99936a1630f5 Theodore Ts'o                 2019-11-07  5827  				 ei->i_extra_isize,
4ea99936a1630f5 Theodore Ts'o                 2019-11-07  5828  				 EXT4_INODE_SIZE(inode->i_sb));
4ea99936a1630f5 Theodore Ts'o                 2019-11-07  5829  		return -EFSCORRUPTED;
4ea99936a1630f5 Theodore Ts'o                 2019-11-07  5830  	}
4ea99936a1630f5 Theodore Ts'o                 2019-11-07  5831  	if ((new_extra_isize < ei->i_extra_isize) ||
4ea99936a1630f5 Theodore Ts'o                 2019-11-07  5832  	    (new_extra_isize < 4) ||
4ea99936a1630f5 Theodore Ts'o                 2019-11-07  5833  	    (new_extra_isize > inode_size - EXT4_GOOD_OLD_INODE_SIZE))
4ea99936a1630f5 Theodore Ts'o                 2019-11-07  5834  		return -EINVAL;	/* Should never happen */
4ea99936a1630f5 Theodore Ts'o                 2019-11-07  5835  
c03b45b853f5829 Miao Xie                      2017-08-06  5836  	raw_inode = ext4_raw_inode(iloc);
c03b45b853f5829 Miao Xie                      2017-08-06  5837  
c03b45b853f5829 Miao Xie                      2017-08-06  5838  	header = IHDR(inode, raw_inode);
c03b45b853f5829 Miao Xie                      2017-08-06  5839  
c03b45b853f5829 Miao Xie                      2017-08-06  5840  	/* No extended attributes present */
555d75b1e3bf941 Thadeu Lima de Souza Cascardo 2024-12-10  5841  	if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
c03b45b853f5829 Miao Xie                      2017-08-06  5842  		memset((void *)raw_inode + EXT4_GOOD_OLD_INODE_SIZE +
c03b45b853f5829 Miao Xie                      2017-08-06  5843  		       EXT4_I(inode)->i_extra_isize, 0,
c03b45b853f5829 Miao Xie                      2017-08-06  5844  		       new_extra_isize - EXT4_I(inode)->i_extra_isize);
c03b45b853f5829 Miao Xie                      2017-08-06  5845  		EXT4_I(inode)->i_extra_isize = new_extra_isize;
c03b45b853f5829 Miao Xie                      2017-08-06  5846  		return 0;
c03b45b853f5829 Miao Xie                      2017-08-06  5847  	}
c03b45b853f5829 Miao Xie                      2017-08-06  5848  
8994d11395f8165 Jan Kara                      2022-12-07  5849  	/*
8994d11395f8165 Jan Kara                      2022-12-07  5850  	 * We may need to allocate external xattr block so we need quotas
8994d11395f8165 Jan Kara                      2022-12-07  5851  	 * initialized. Here we can be called with various locks held so we
8994d11395f8165 Jan Kara                      2022-12-07  5852  	 * cannot affort to initialize quotas ourselves. So just bail.
8994d11395f8165 Jan Kara                      2022-12-07  5853  	 */
8994d11395f8165 Jan Kara                      2022-12-07  5854  	if (dquot_initialize_needed(inode))
8994d11395f8165 Jan Kara                      2022-12-07  5855  		return -EAGAIN;
8994d11395f8165 Jan Kara                      2022-12-07  5856  
c03b45b853f5829 Miao Xie                      2017-08-06  5857  	/* try to expand with EAs present */
c03b45b853f5829 Miao Xie                      2017-08-06  5858  	error = ext4_expand_extra_isize_ea(inode, new_extra_isize,
c03b45b853f5829 Miao Xie                      2017-08-06  5859  					   raw_inode, handle);
c03b45b853f5829 Miao Xie                      2017-08-06  5860  	if (error) {
c03b45b853f5829 Miao Xie                      2017-08-06  5861  		/*
c03b45b853f5829 Miao Xie                      2017-08-06  5862  		 * Inode size expansion failed; don't try again
c03b45b853f5829 Miao Xie                      2017-08-06  5863  		 */
c03b45b853f5829 Miao Xie                      2017-08-06  5864  		*no_expand = 1;
c03b45b853f5829 Miao Xie                      2017-08-06  5865  	}
c03b45b853f5829 Miao Xie                      2017-08-06  5866  
c03b45b853f5829 Miao Xie                      2017-08-06  5867  	return error;
c03b45b853f5829 Miao Xie                      2017-08-06  5868  }
c03b45b853f5829 Miao Xie                      2017-08-06  5869  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

