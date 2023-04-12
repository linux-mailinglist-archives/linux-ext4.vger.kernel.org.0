Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06526DFCA8
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Apr 2023 19:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjDLRZg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Apr 2023 13:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDLRZf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Apr 2023 13:25:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DF32D59;
        Wed, 12 Apr 2023 10:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681320333; x=1712856333;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fg6uGIM3FM+B+1guXhrCn+MxDSVjY3zwLFWXWk63VL8=;
  b=eQP/ZMR1APpIs6Pq9ia47D6oxRFvizp3vOnBmtUiAIQinEP/o9QhH5jN
   k/WwKOmtzg4AR5viSxV8koWKijVpveyMg1OliGrPMeVmQFHIvCcbn0J04
   28/g9vFrgFLjSYMsbRUF3xmx9ebNuXjLziu3/p8NOkWzrPhNqfycU09dX
   3MXQ7WufYFBFVCb6D9oKuCbX+MypJ0F7tSO4mqFEvMlDX9OXJsl/AtHgv
   ceED+bcdTc2+2GWmjUscZJTkc41dKe2q/YfOR7nmf7a7LZCeQjKgaQrJg
   xl03gabS83bLXzxKnVD9B9xeDUqUGXlLY3DnqKsyDke2M2NQQROdK7+Fg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="406794192"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="406794192"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 10:25:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="719468741"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="719468741"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 12 Apr 2023 10:25:20 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmeDf-000XwN-0G;
        Wed, 12 Apr 2023 17:25:19 +0000
Date:   Thu, 13 Apr 2023 01:24:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH v3 6/8] ext4: make ext4_es_insert_delayed_block return
 void
Message-ID: <202304130044.d3iOG59z-lkp@intel.com>
References: <20230412124126.2286716-7-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412124126.2286716-7-libaokun1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Baokun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tytso-ext4/dev]
[also build test WARNING on linus/master v6.3-rc6 next-20230412]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Baokun-Li/ext4-only-update-i_reserved_data_blocks-on-successful-block-allocation/20230412-204407
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20230412124126.2286716-7-libaokun1%40huawei.com
patch subject: [PATCH v3 6/8] ext4: make ext4_es_insert_delayed_block return void
config: x86_64-randconfig-a002-20230410 (https://download.01.org/0day-ci/archive/20230413/202304130044.d3iOG59z-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/87f992eeab9cd894894e27c3c6ff322cbd473ebf
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Baokun-Li/ext4-only-update-i_reserved_data_blocks-on-successful-block-allocation/20230412-204407
        git checkout 87f992eeab9cd894894e27c3c6ff322cbd473ebf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/ext4/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304130044.d3iOG59z-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/ext4/inode.c:1640:7: warning: variable 'reserved' set but not used [-Wunused-but-set-variable]
           bool reserved = false;
                ^
   1 warning generated.


vim +/reserved +1640 fs/ext4/inode.c

df22291ff0fde0 Aneesh Kumar K.V 2008-09-08  1623  
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1624  /*
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1625   * ext4_insert_delayed_block - adds a delayed block to the extents status
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1626   *                             tree, incrementing the reserved cluster/block
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1627   *                             count or making a pending reservation
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1628   *                             where needed
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1629   *
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1630   * @inode - file containing the newly added block
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1631   * @lblk - logical block to be added
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1632   *
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1633   * Returns 0 on success, negative error code on failure.
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1634   */
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1635  static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1636  {
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1637  	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
87f992eeab9cd8 Baokun Li        2023-04-12  1638  	int ret = 0;
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1639  	bool allocated = false;
6fed83957f21ef Jeffle Xu        2021-08-23 @1640  	bool reserved = false;
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1641  
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1642  	/*
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1643  	 * If the cluster containing lblk is shared with a delayed,
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1644  	 * written, or unwritten extent in a bigalloc file system, it's
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1645  	 * already been accounted for and does not need to be reserved.
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1646  	 * A pending reservation must be made for the cluster if it's
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1647  	 * shared with a written or unwritten extent and doesn't already
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1648  	 * have one.  Written and unwritten extents can be purged from the
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1649  	 * extents status tree if the system is under memory pressure, so
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1650  	 * it's necessary to examine the extent tree if a search of the
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1651  	 * extents status tree doesn't get a match.
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1652  	 */
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1653  	if (sbi->s_cluster_ratio == 1) {
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1654  		ret = ext4_da_reserve_space(inode);
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1655  		if (ret != 0)   /* ENOSPC */
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1656  			goto errout;
6fed83957f21ef Jeffle Xu        2021-08-23  1657  		reserved = true;
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1658  	} else {   /* bigalloc */
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1659  		if (!ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk)) {
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1660  			if (!ext4_es_scan_clu(inode,
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1661  					      &ext4_es_is_mapped, lblk)) {
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1662  				ret = ext4_clu_mapped(inode,
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1663  						      EXT4_B2C(sbi, lblk));
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1664  				if (ret < 0)
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1665  					goto errout;
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1666  				if (ret == 0) {
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1667  					ret = ext4_da_reserve_space(inode);
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1668  					if (ret != 0)   /* ENOSPC */
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1669  						goto errout;
6fed83957f21ef Jeffle Xu        2021-08-23  1670  					reserved = true;
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1671  				} else {
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1672  					allocated = true;
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1673  				}
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1674  			} else {
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1675  				allocated = true;
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1676  			}
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1677  		}
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1678  	}
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1679  
87f992eeab9cd8 Baokun Li        2023-04-12  1680  	ext4_es_insert_delayed_block(inode, lblk, allocated);
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1681  errout:
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1682  	return ret;
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1683  }
0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1684  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
