Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61676DF83A
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Apr 2023 16:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjDLOUR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Apr 2023 10:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjDLOUR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Apr 2023 10:20:17 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EDD44B9;
        Wed, 12 Apr 2023 07:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681309215; x=1712845215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dAApaBOmjnGI+B8dl1J1ZbNF3a5taTtRMYO+AejGQt4=;
  b=E5MLwxlGPAX55SaE8DCCY9nWS+QxXVbys//547KZ8aeC9tEV6aZeVx1d
   kLfBJd4PGYFFI6RpaVVNGma6LXdKIKcWlQesBnQypCh+iN/tz65gp6Nq+
   tf2Kmx965jZJYS8o4yALpeT0nsZ6kpy0FYbBCI2nvuTmZITxr0jhOzDqC
   csWinMzEaRcc2Y5tzM0ar8ibO1e5RGVlH/0VXoPeyFl/OzZ7aW0GUetho
   vnjUqz2mbyHDP1twghZM9eKxq6Px6OBE9LFgfGuclwchm+shqlRImBsSs
   KxkTKM6KzErghrQY3WbaVg24MOI+pMXvituPOD0hrmlD5itplnDT7Q6/+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="328019954"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="328019954"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 07:20:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="753544041"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="753544041"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 12 Apr 2023 07:20:12 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmbKV-000XmB-19;
        Wed, 12 Apr 2023 14:20:11 +0000
Date:   Wed, 12 Apr 2023 22:19:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH v3 6/8] ext4: make ext4_es_insert_delayed_block return
 void
Message-ID: <202304122234.3Meeshf9-lkp@intel.com>
References: <20230412124126.2286716-7-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412124126.2286716-7-libaokun1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230412/202304122234.3Meeshf9-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/87f992eeab9cd894894e27c3c6ff322cbd473ebf
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Baokun-Li/ext4-only-update-i_reserved_data_blocks-on-successful-block-allocation/20230412-204407
        git checkout 87f992eeab9cd894894e27c3c6ff322cbd473ebf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash fs/ext4/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304122234.3Meeshf9-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/ext4/inode.c: In function 'ext4_insert_delayed_block':
>> fs/ext4/inode.c:1640:14: warning: variable 'reserved' set but not used [-Wunused-but-set-variable]
    1640 |         bool reserved = false;
         |              ^~~~~~~~


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
