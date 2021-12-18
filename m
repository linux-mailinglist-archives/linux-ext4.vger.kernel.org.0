Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437F7479DFF
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Dec 2021 23:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229474AbhLRWcH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 18 Dec 2021 17:32:07 -0500
Received: from mga09.intel.com ([134.134.136.24]:9871 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229473AbhLRWcG (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 18 Dec 2021 17:32:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639866726; x=1671402726;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WMWcm96uBFu+K85kfALAlw2HjgXvdP1xSP713hj10Js=;
  b=DfDnVyh9FkmSlsPFFALJFa2JfyKArRsOdzudBVFwc6dXGQp8lbNaDJs0
   55qqeU7ihx8BUnne3VMMlvjpRZbiiTfyI0ojhGJzwl9DLILTs/9TLh0aL
   C9n0EKRPYwE6XHdzbRkyxNqKIDciFwidmT83snhal5GBFnbSRrq5TjULS
   ACB8CR4S4rZsl1v1+tc0pAwqNXzxM7Thvt5jqWHGneUSkhByX3tfXHNES
   8GbO5npDNxBm+bJesLUGxMbkPFgMJzhOQTlDdEXtSeGnFw67lHsUHYd4x
   3qLKo/0Pl/OqwbAaFWsIcz5VR46a0KYqeBtAwH/K2aIa8pU6HDZEWqUC4
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10202"; a="239765342"
X-IronPort-AV: E=Sophos;i="5.88,217,1635231600"; 
   d="scan'208";a="239765342"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2021 14:32:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,217,1635231600"; 
   d="scan'208";a="615947679"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 18 Dec 2021 14:32:04 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myiFH-0006Sc-EX; Sat, 18 Dec 2021 22:32:03 +0000
Date:   Sun, 19 Dec 2021 06:31:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     cgel.zte@gmail.com, tytso@mit.edu
Cc:     kbuild-all@lists.01.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] ext4: use min() to make code cleaner
Message-ID: <202112190602.FX1i96n9-lkp@intel.com>
References: <20211216091022.449364-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216091022.449364-1-deng.changcheng@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tytso-ext4/dev]
[also build test WARNING on v5.16-rc5 next-20211217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/cgel-zte-gmail-com/ext4-use-min-to-make-code-cleaner/20211216-171213
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
config: arc-randconfig-s032-20211218 (https://download.01.org/0day-ci/archive/20211219/202112190602.FX1i96n9-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/ff519f2d7d41c154cb0d31a9aebe16ce1f6af7ed
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review cgel-zte-gmail-com/ext4-use-min-to-make-code-cleaner/20211216-171213
        git checkout ff519f2d7d41c154cb0d31a9aebe16ce1f6af7ed
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash drivers/iio/accel/ fs/ext4/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/ext4/super.c:6926:26: sparse: sparse: incompatible types in comparison expression (different type sizes):
>> fs/ext4/super.c:6926:26: sparse:    unsigned long *
>> fs/ext4/super.c:6926:26: sparse:    unsigned int *
   fs/ext4/super.c:2643:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *objp @@     got char [noderef] __rcu * @@
   fs/ext4/super.c:2643:46: sparse:     expected void const *objp
   fs/ext4/super.c:2643:46: sparse:     got char [noderef] __rcu *
   fs/ext4/super.c:2698:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *cs @@     got char [noderef] __rcu * @@
   fs/ext4/super.c:2698:51: sparse:     expected char const *cs
   fs/ext4/super.c:2698:51: sparse:     got char [noderef] __rcu *
   fs/ext4/super.c:993:6: sparse: sparse: context imbalance in '__ext4_grp_locked_error' - different lock contexts for basic block
   fs/ext4/super.c:3321:9: sparse: sparse: context imbalance in 'ext4_check_descriptors' - different lock contexts for basic block

vim +6926 fs/ext4/super.c

  6904	
  6905	/* Read data from quotafile - avoid pagecache and such because we cannot afford
  6906	 * acquiring the locks... As quota files are never truncated and quota code
  6907	 * itself serializes the operations (and no one else should touch the files)
  6908	 * we don't have to be afraid of races */
  6909	static ssize_t ext4_quota_read(struct super_block *sb, int type, char *data,
  6910				       size_t len, loff_t off)
  6911	{
  6912		struct inode *inode = sb_dqopt(sb)->files[type];
  6913		ext4_lblk_t blk = off >> EXT4_BLOCK_SIZE_BITS(sb);
  6914		int offset = off & (sb->s_blocksize - 1);
  6915		int tocopy;
  6916		size_t toread;
  6917		struct buffer_head *bh;
  6918		loff_t i_size = i_size_read(inode);
  6919	
  6920		if (off > i_size)
  6921			return 0;
  6922		if (off+len > i_size)
  6923			len = i_size-off;
  6924		toread = len;
  6925		while (toread > 0) {
> 6926			tocopy = min(sb->s_blocksize - offset, toread);
  6927			bh = ext4_bread(NULL, inode, blk, 0);
  6928			if (IS_ERR(bh))
  6929				return PTR_ERR(bh);
  6930			if (!bh)	/* A hole? */
  6931				memset(data, 0, tocopy);
  6932			else
  6933				memcpy(data, bh->b_data+offset, tocopy);
  6934			brelse(bh);
  6935			offset = 0;
  6936			toread -= tocopy;
  6937			data += tocopy;
  6938			blk++;
  6939		}
  6940		return len;
  6941	}
  6942	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
