Return-Path: <linux-ext4+bounces-9016-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B096B060D8
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Jul 2025 16:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD3DD7BFD20
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Jul 2025 14:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3085528FAB7;
	Tue, 15 Jul 2025 14:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j5yDoecf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA8728DF25;
	Tue, 15 Jul 2025 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588536; cv=none; b=ZOx4X1k+l+eZtrVs8A/VyoqN2gZ74n6KqsS1iIwvXFtLXNp2D7zGPZYyEYSg8WbVRKZwYL10f0Ddb9mjYUynYKZvmi/sv9/3tWerDYuTZCclKvBFvuW2H77VHsZ4laPyq8x9wawMxq+315v4FPBXaBfx7jf7XCfKd4OrDEwLyqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588536; c=relaxed/simple;
	bh=iGwHdMx7YnUfsMLr6f7G2QpvZ6flc36YWO+ymAakJAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwu/0fWDTasIuvwEOTK5C3KWOI1xLU4MfD0e6bSr3GcSkGmRvkMrJqZXa6/sktBGfjNvhbmj/8ARPdAEn6E9lYQnArn1AeWE4W3dg/QZ3qu+vtDFY8i5LxbmEhxqGwPNauApnT3WBl7BhgaRXT13SxjeJcfRmaMdRmHZC1dRba8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j5yDoecf; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752588535; x=1784124535;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iGwHdMx7YnUfsMLr6f7G2QpvZ6flc36YWO+ymAakJAQ=;
  b=j5yDoecfDvZh2B/3ISxpCjcRIBy08HvhX3aS9fxzc537U/0EaItTHrpO
   9zeAQPi7zgSK1rBZjeFLf6yJT8mMXofkfAy4EkVWjzZ0s/cnPWmWkKcHC
   2qmhjy/noinEkPEpSDaPj9NZ1Q7XhiusTd/VQAs6JoQEeB3tE36d6Wybm
   xcvqQaxMXPDpdfhm8UJjFtv0pGQr/M6za2ATAyuz4egjS9xf1GXzRZqSk
   nPd5mrE3ZJdr/ePgVYyXGwdGQvIjUAeNcxvY0DFOuG4wCMEei1q9aK6fS
   sPKldUwVDYhq7eUJUrSVckplUYgAYXBEkLbgm+YdzUK9POeiHEhqZPEMG
   Q==;
X-CSE-ConnectionGUID: GypIYwCiQJOTklV2giqRcQ==
X-CSE-MsgGUID: vHWVJ03eSrinTtJq/wz/Fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="66166892"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="66166892"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 07:08:54 -0700
X-CSE-ConnectionGUID: wY3ged7VSAqwm8fXiFEAkQ==
X-CSE-MsgGUID: HAw3qmz5Rcy23BXfm+gZ/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="162778934"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 15 Jul 2025 07:08:53 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubgKw-000B8h-2h;
	Tue, 15 Jul 2025 14:08:50 +0000
Date: Tue, 15 Jul 2025 22:08:10 +0800
From: kernel test robot <lkp@intel.com>
To: chuguangqing <chuguangqing@inspur.com>, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: oe-kbuild-all@lists.linux.dev, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chuguangqing <chuguangqing@inspur.com>
Subject: Re: [PATCH 1/1] Add FALLOC_FL_ALLOCATE_RANGE to the set of supported
 fallocate mode flags. This change improves code clarity and maintains by
 explicitly showing this flag in the supported flags mask.
Message-ID: <202507152101.0vyIZZfK-lkp@intel.com>
References: <20250715031531.1693-2-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715031531.1693-2-chuguangqing@inspur.com>

Hi chuguangqing,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20250714]
[cannot apply to tytso-ext4/dev v6.16-rc6 v6.16-rc5 v6.16-rc4 linus/master v6.16-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/chuguangqing/Add-FALLOC_FL_ALLOCATE_RANGE-to-the-set-of-supported-fallocate-mode-flags-This-change-improves-code-clarity-and-maintain/20250715-111753
base:   next-20250714
patch link:    https://lore.kernel.org/r/20250715031531.1693-2-chuguangqing%40inspur.com
patch subject: [PATCH 1/1] Add FALLOC_FL_ALLOCATE_RANGE to the set of supported fallocate mode flags. This change improves code clarity and maintains by explicitly showing this flag in the supported flags mask.
config: arc-randconfig-002-20250715 (https://download.01.org/0day-ci/archive/20250715/202507152101.0vyIZZfK-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250715/202507152101.0vyIZZfK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507152101.0vyIZZfK-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/ext4/extents.c: In function 'ext4_fallocate':
>> fs/ext4/extents.c:4787:22: error: 'FALL_C_FL_ALLOCATE_RANGE' undeclared (first use in this function); did you mean 'FALLOC_FL_ALLOCATE_RANGE'?
    4787 |         if (mode & ~(FALL_C_FL_ALLOCATE_RANGE | FALLOC_FL_KEEP_SIZE |
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~
         |                      FALLOC_FL_ALLOCATE_RANGE
   fs/ext4/extents.c:4787:22: note: each undeclared identifier is reported only once for each function it appears in


vim +4787 fs/ext4/extents.c

  4755	
  4756	/*
  4757	 * preallocate space for a file. This implements ext4's fallocate file
  4758	 * operation, which gets called from sys_fallocate system call.
  4759	 * For block-mapped files, posix_fallocate should fall back to the method
  4760	 * of writing zeroes to the required new blocks (the same behavior which is
  4761	 * expected for file systems which do not support fallocate() system call).
  4762	 */
  4763	long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
  4764	{
  4765		struct inode *inode = file_inode(file);
  4766		struct address_space *mapping = file->f_mapping;
  4767		int ret;
  4768	
  4769		/*
  4770		 * Encrypted inodes can't handle collapse range or insert
  4771		 * range since we would need to re-encrypt blocks with a
  4772		 * different IV or XTS tweak (which are based on the logical
  4773		 * block number).
  4774		 */
  4775		if (IS_ENCRYPTED(inode) &&
  4776		    (mode & (FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE)))
  4777			return -EOPNOTSUPP;
  4778		/*
  4779		 * Don't allow writing zeroes if the underlying device does not
  4780		 * enable the unmap write zeroes operation.
  4781		 */
  4782		if ((mode & FALLOC_FL_WRITE_ZEROES) &&
  4783		    !bdev_write_zeroes_unmap_sectors(inode->i_sb->s_bdev))
  4784			return -EOPNOTSUPP;
  4785	
  4786		/* Return error if mode is not supported */
> 4787		if (mode & ~(FALL_C_FL_ALLOCATE_RANGE | FALLOC_FL_KEEP_SIZE |
  4788			     FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
  4789			     FALLOC_FL_ZERO_RANGE | FALLOC_FL_INSERT_RANGE))
  4790			return -EOPNOTSUPP;
  4791	
  4792		inode_lock(inode);
  4793		ret = ext4_convert_inline_data(inode);
  4794		if (ret)
  4795			goto out_inode_lock;
  4796	
  4797		/* Wait all existing dio workers, newcomers will block on i_rwsem */
  4798		inode_dio_wait(inode);
  4799	
  4800		ret = file_modified(file);
  4801		if (ret)
  4802			goto out_inode_lock;
  4803	
  4804		if ((mode & FALLOC_FL_MODE_MASK) == FALLOC_FL_ALLOCATE_RANGE) {
  4805			ret = ext4_do_fallocate(file, offset, len, mode);
  4806			goto out_inode_lock;
  4807		}
  4808	
  4809		/*
  4810		 * Follow-up operations will drop page cache, hold invalidate lock
  4811		 * to prevent page faults from reinstantiating pages we have
  4812		 * released from page cache.
  4813		 */
  4814		filemap_invalidate_lock(mapping);
  4815	
  4816		ret = ext4_break_layouts(inode);
  4817		if (ret)
  4818			goto out_invalidate_lock;
  4819	
  4820		switch (mode & FALLOC_FL_MODE_MASK) {
  4821		case FALLOC_FL_PUNCH_HOLE:
  4822			ret = ext4_punch_hole(file, offset, len);
  4823			break;
  4824		case FALLOC_FL_COLLAPSE_RANGE:
  4825			ret = ext4_collapse_range(file, offset, len);
  4826			break;
  4827		case FALLOC_FL_INSERT_RANGE:
  4828			ret = ext4_insert_range(file, offset, len);
  4829			break;
  4830		case FALLOC_FL_ZERO_RANGE:
  4831		case FALLOC_FL_WRITE_ZEROES:
  4832			ret = ext4_zero_range(file, offset, len, mode);
  4833			break;
  4834		default:
  4835			ret = -EOPNOTSUPP;
  4836		}
  4837	
  4838	out_invalidate_lock:
  4839		filemap_invalidate_unlock(mapping);
  4840	out_inode_lock:
  4841		inode_unlock(inode);
  4842		return ret;
  4843	}
  4844	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

