Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1960E4720D0
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Dec 2021 06:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhLMF4r (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Dec 2021 00:56:47 -0500
Received: from mga06.intel.com ([134.134.136.31]:27502 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230054AbhLMF4q (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 13 Dec 2021 00:56:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639375006; x=1670911006;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/a7e8TtvfwryHUi7Xo3w+e3z2THQeNIFRVb4B8riaQ4=;
  b=C6DA/Y0lTP+UIndB5SuyoS/nZv5TC73d7vAqA0UqeM7HOzT0/64Xa6FI
   wldsAcv5uTMQJQlecZ3eLIS1GPaIkeuRoqH5jkZUm5JMeAv+VSUo/5nhp
   DcuxHd+JL6koPYCQzG0rVTdAgzq3sVXvkFAUkl4w8BcHw+IBM962StyDE
   2Oi5BTEk4YjRA59fDEWkqJpYGmqFbZD55d6EMHJEcqVKayhXEI/xFXxaB
   Ady15Nplp1P4FrsdeUSa9eI0IRrwsVTNeMt+3xXVjP92vqWt3lnaQKjk2
   0ihtPppy2Be0WlzJwxVTNOQrJzCBjMen4+/UOMhCCUB4BjIKS+dUjPfMO
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="299450303"
X-IronPort-AV: E=Sophos;i="5.88,201,1635231600"; 
   d="scan'208";a="299450303"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2021 21:56:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,201,1635231600"; 
   d="scan'208";a="613705899"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 12 Dec 2021 21:56:38 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mweKD-0006M4-RG; Mon, 13 Dec 2021 05:56:37 +0000
Date:   Mon, 13 Dec 2021 13:56:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jan Kara <jack@suse.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/2] Remove bdi_congested() and wb_congested() and
 related functions
Message-ID: <202112131323.fj31o6EV-lkp@intel.com>
References: <163936886727.23860.5245364396572576756.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163936886727.23860.5245364396572576756.stgit@noble.brown>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi NeilBrown,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on hnaz-mm/master]
[also build test WARNING on axboe-block/for-next konis-nilfs2/upstream xfs-linux/for-next linus/master v5.16-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/NeilBrown/Remove-some-congested-tests/20211213-121653
base:   https://github.com/hnaz/linux-mm master
config: arc-randconfig-r015-20211213 (https://download.01.org/0day-ci/archive/20211213/202112131323.fj31o6EV-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/41802b6debbde3d5553a8067ba2deb2035e6da6e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review NeilBrown/Remove-some-congested-tests/20211213-121653
        git checkout 41802b6debbde3d5553a8067ba2deb2035e6da6e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash fs/ext2/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/ext2/ialloc.c: In function 'ext2_preread_inode':
>> fs/ext2/ialloc.c:173:34: warning: variable 'bdi' set but not used [-Wunused-but-set-variable]
     173 |         struct backing_dev_info *bdi;
         |                                  ^~~


vim +/bdi +173 fs/ext2/ialloc.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  154  
^1da177e4c3f41 Linus Torvalds    2005-04-16  155  /*
^1da177e4c3f41 Linus Torvalds    2005-04-16  156   * We perform asynchronous prereading of the new inode's inode block when
^1da177e4c3f41 Linus Torvalds    2005-04-16  157   * we create the inode, in the expectation that the inode will be written
^1da177e4c3f41 Linus Torvalds    2005-04-16  158   * back soon.  There are two reasons:
^1da177e4c3f41 Linus Torvalds    2005-04-16  159   *
^1da177e4c3f41 Linus Torvalds    2005-04-16  160   * - When creating a large number of files, the async prereads will be
^1da177e4c3f41 Linus Torvalds    2005-04-16  161   *   nicely merged into large reads
^1da177e4c3f41 Linus Torvalds    2005-04-16  162   * - When writing out a large number of inodes, we don't need to keep on
^1da177e4c3f41 Linus Torvalds    2005-04-16  163   *   stalling the writes while we read the inode block.
^1da177e4c3f41 Linus Torvalds    2005-04-16  164   *
^1da177e4c3f41 Linus Torvalds    2005-04-16  165   * FIXME: ext2_get_group_desc() needs to be simplified.
^1da177e4c3f41 Linus Torvalds    2005-04-16  166   */
^1da177e4c3f41 Linus Torvalds    2005-04-16  167  static void ext2_preread_inode(struct inode *inode)
^1da177e4c3f41 Linus Torvalds    2005-04-16  168  {
^1da177e4c3f41 Linus Torvalds    2005-04-16  169  	unsigned long block_group;
^1da177e4c3f41 Linus Torvalds    2005-04-16  170  	unsigned long offset;
^1da177e4c3f41 Linus Torvalds    2005-04-16  171  	unsigned long block;
^1da177e4c3f41 Linus Torvalds    2005-04-16  172  	struct ext2_group_desc * gdp;
^1da177e4c3f41 Linus Torvalds    2005-04-16 @173  	struct backing_dev_info *bdi;
^1da177e4c3f41 Linus Torvalds    2005-04-16  174  
de1414a654e66b Christoph Hellwig 2015-01-14  175  	bdi = inode_to_bdi(inode);
^1da177e4c3f41 Linus Torvalds    2005-04-16  176  
^1da177e4c3f41 Linus Torvalds    2005-04-16  177  	block_group = (inode->i_ino - 1) / EXT2_INODES_PER_GROUP(inode->i_sb);
ef2fb67989d30f Eric Sandeen      2007-10-16  178  	gdp = ext2_get_group_desc(inode->i_sb, block_group, NULL);
^1da177e4c3f41 Linus Torvalds    2005-04-16  179  	if (gdp == NULL)
^1da177e4c3f41 Linus Torvalds    2005-04-16  180  		return;
^1da177e4c3f41 Linus Torvalds    2005-04-16  181  
^1da177e4c3f41 Linus Torvalds    2005-04-16  182  	/*
^1da177e4c3f41 Linus Torvalds    2005-04-16  183  	 * Figure out the offset within the block group inode table
^1da177e4c3f41 Linus Torvalds    2005-04-16  184  	 */
^1da177e4c3f41 Linus Torvalds    2005-04-16  185  	offset = ((inode->i_ino - 1) % EXT2_INODES_PER_GROUP(inode->i_sb)) *
^1da177e4c3f41 Linus Torvalds    2005-04-16  186  				EXT2_INODE_SIZE(inode->i_sb);
^1da177e4c3f41 Linus Torvalds    2005-04-16  187  	block = le32_to_cpu(gdp->bg_inode_table) +
^1da177e4c3f41 Linus Torvalds    2005-04-16  188  				(offset >> EXT2_BLOCK_SIZE_BITS(inode->i_sb));
^1da177e4c3f41 Linus Torvalds    2005-04-16  189  	sb_breadahead(inode->i_sb, block);
^1da177e4c3f41 Linus Torvalds    2005-04-16  190  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  191  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
