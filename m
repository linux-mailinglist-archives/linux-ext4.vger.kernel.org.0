Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9C74782FE
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Dec 2021 03:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhLQCLg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Dec 2021 21:11:36 -0500
Received: from mga02.intel.com ([134.134.136.20]:16722 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhLQCLg (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 16 Dec 2021 21:11:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639707096; x=1671243096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yAjiwUaIEdzf9SApDqxL8mfZBxrBi9Lf0q22oUAsn3o=;
  b=McEoWApoDBlMJKB26LaHLQ05+ttbO4c0pOBd05qas3cYSDTnq6tlI1dm
   3bG5uyYI0g+nEFl8VsfRlbE/lIKDaFoMXxx3M/2925n3X9tPSXEAeB7pf
   X60aVsofH9ue9INnkQBhMp/Ui1m8R97/Mko6qG5mvDwPaVzr3rayZQ29C
   yiohlu9PuBkuzetg/mLT2R5HenB14axa8vWojc1piJ0XeaYvnRhk8Pbwv
   U20O08KGckHj/Vk0qHLq5WC0IioLWVOgmgJZR1nYpwVlK8OjBF0iSVMkC
   oOD2dFAszvpR/PPYmg2BvmW0D/p6AwkhVoCtvSCQeeKUEEmxGpIC+tYVg
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="226945614"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="226945614"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 18:11:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="756326021"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 16 Dec 2021 18:11:33 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1my2ib-00045e-4r; Fri, 17 Dec 2021 02:11:33 +0000
Date:   Fri, 17 Dec 2021 10:11:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     cgel.zte@gmail.com, tytso@mit.edu
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] ext4: use min() to make code cleaner
Message-ID: <202112171003.SXtQAHHE-lkp@intel.com>
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
[also build test WARNING on v5.16-rc5 next-20211215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/cgel-zte-gmail-com/ext4-use-min-to-make-code-cleaner/20211216-171213
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
config: hexagon-randconfig-r026-20211216 (https://download.01.org/0day-ci/archive/20211217/202112171003.SXtQAHHE-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dd245bab9fbb364faa1581e4f92ba3119a872fba)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/ff519f2d7d41c154cb0d31a9aebe16ce1f6af7ed
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review cgel-zte-gmail-com/ext4-use-min-to-make-code-cleaner/20211216-171213
        git checkout ff519f2d7d41c154cb0d31a9aebe16ce1f6af7ed
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/ext4/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/ext4/super.c:6926:12: warning: comparison of distinct pointer types ('typeof (sb->s_blocksize - offset) *' (aka 'unsigned long *') and 'typeof (toread) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
                   tocopy = min(sb->s_blocksize - offset, toread);
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:45:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
   fs/ext4/super.c:2173:1: warning: unused function 'ctx_test_flags' [-Wunused-function]
   EXT4_SET_CTX(flags);
   ^
   fs/ext4/super.c:2168:20: note: expanded from macro 'EXT4_SET_CTX'
   static inline bool ctx_test_##name(struct ext4_fs_context *ctx, int flag)\
                      ^
   <scratch space>:148:1: note: expanded from here
   ctx_test_flags
   ^
   fs/ext4/super.c:2176:1: warning: unused function 'ctx_clear_mount_flags' [-Wunused-function]
   EXT4_SET_CTX(mount_flags);
   ^
   fs/ext4/super.c:2163:20: note: expanded from macro 'EXT4_SET_CTX'
   static inline void ctx_clear_##name(struct ext4_fs_context *ctx, int flag)\
                      ^
   <scratch space>:169:1: note: expanded from here
   ctx_clear_mount_flags
   ^
   fs/ext4/super.c:2176:1: warning: unused function 'ctx_test_mount_flags' [-Wunused-function]
   fs/ext4/super.c:2168:20: note: expanded from macro 'EXT4_SET_CTX'
   static inline bool ctx_test_##name(struct ext4_fs_context *ctx, int flag)\
                      ^
   <scratch space>:172:1: note: expanded from here
   ctx_test_mount_flags
   ^
   4 warnings generated.


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
