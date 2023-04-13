Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDA26E045B
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Apr 2023 04:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjDMCiQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Apr 2023 22:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjDMChn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Apr 2023 22:37:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A83693CB;
        Wed, 12 Apr 2023 19:37:05 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PxkC53w8xznc0Q;
        Thu, 13 Apr 2023 10:33:05 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 10:36:40 +0800
Message-ID: <8c7984b9-b4b9-0af3-73a1-2bbd10c928ba@huawei.com>
Date:   Thu, 13 Apr 2023 10:36:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3 6/8] ext4: make ext4_es_insert_delayed_block return
 void
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, <linux-ext4@vger.kernel.org>
CC:     <oe-kbuild-all@lists.linux.dev>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <20230412124126.2286716-7-libaokun1@huawei.com>
 <202304122234.3Meeshf9-lkp@intel.com>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <202304122234.3Meeshf9-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/4/12 22:19, kernel test robot wrote:
> Hi Baokun,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on tytso-ext4/dev]
> [also build test WARNING on linus/master v6.3-rc6 next-20230412]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Baokun-Li/ext4-only-update-i_reserved_data_blocks-on-successful-block-allocation/20230412-204407
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
> patch link:    https://lore.kernel.org/r/20230412124126.2286716-7-libaokun1%40huawei.com
> patch subject: [PATCH v3 6/8] ext4: make ext4_es_insert_delayed_block return void
> config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230412/202304122234.3Meeshf9-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/intel-lab-lkp/linux/commit/87f992eeab9cd894894e27c3c6ff322cbd473ebf
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Baokun-Li/ext4-only-update-i_reserved_data_blocks-on-successful-block-allocation/20230412-204407
>          git checkout 87f992eeab9cd894894e27c3c6ff322cbd473ebf
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash fs/ext4/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202304122234.3Meeshf9-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>     fs/ext4/inode.c: In function 'ext4_insert_delayed_block':
>>> fs/ext4/inode.c:1640:14: warning: variable 'reserved' set but not used [-Wunused-but-set-variable]
>      1640 |         bool reserved = false;
>           |              ^~~~~~~~

Thank you very much for testing, I will fix this issue in the next 
version of the patch.

I checked with make W=2 to see if it would introduce a compile warning 
before sending,
but it did not check for the problem. When I saw this email I checked 
again with W=1,
and this checked the problem instead. This is strange, doesn't it seem 
to me that a high
rank warning check should include a low rank warning check?
Am I misunderstanding or is this a bug?

>
> vim +/reserved +1640 fs/ext4/inode.c
>
> df22291ff0fde0 Aneesh Kumar K.V 2008-09-08  1623
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1624  /*
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1625   * ext4_insert_delayed_block - adds a delayed block to the extents status
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1626   *                             tree, incrementing the reserved cluster/block
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1627   *                             count or making a pending reservation
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1628   *                             where needed
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1629   *
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1630   * @inode - file containing the newly added block
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1631   * @lblk - logical block to be added
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1632   *
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1633   * Returns 0 on success, negative error code on failure.
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1634   */
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1635  static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1636  {
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1637  	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> 87f992eeab9cd8 Baokun Li        2023-04-12  1638  	int ret = 0;
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1639  	bool allocated = false;
> 6fed83957f21ef Jeffle Xu        2021-08-23 @1640  	bool reserved = false;
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1641
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1642  	/*
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1643  	 * If the cluster containing lblk is shared with a delayed,
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1644  	 * written, or unwritten extent in a bigalloc file system, it's
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1645  	 * already been accounted for and does not need to be reserved.
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1646  	 * A pending reservation must be made for the cluster if it's
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1647  	 * shared with a written or unwritten extent and doesn't already
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1648  	 * have one.  Written and unwritten extents can be purged from the
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1649  	 * extents status tree if the system is under memory pressure, so
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1650  	 * it's necessary to examine the extent tree if a search of the
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1651  	 * extents status tree doesn't get a match.
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1652  	 */
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1653  	if (sbi->s_cluster_ratio == 1) {
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1654  		ret = ext4_da_reserve_space(inode);
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1655  		if (ret != 0)   /* ENOSPC */
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1656  			goto errout;
> 6fed83957f21ef Jeffle Xu        2021-08-23  1657  		reserved = true;
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1658  	} else {   /* bigalloc */
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1659  		if (!ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk)) {
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1660  			if (!ext4_es_scan_clu(inode,
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1661  					      &ext4_es_is_mapped, lblk)) {
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1662  				ret = ext4_clu_mapped(inode,
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1663  						      EXT4_B2C(sbi, lblk));
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1664  				if (ret < 0)
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1665  					goto errout;
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1666  				if (ret == 0) {
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1667  					ret = ext4_da_reserve_space(inode);
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1668  					if (ret != 0)   /* ENOSPC */
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1669  						goto errout;
> 6fed83957f21ef Jeffle Xu        2021-08-23  1670  					reserved = true;
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1671  				} else {
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1672  					allocated = true;
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1673  				}
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1674  			} else {
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1675  				allocated = true;
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1676  			}
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1677  		}
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1678  	}
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1679
> 87f992eeab9cd8 Baokun Li        2023-04-12  1680  	ext4_es_insert_delayed_block(inode, lblk, allocated);
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1681  errout:
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1682  	return ret;
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1683  }
> 0b02f4c0d6d9e2 Eric Whitney     2018-10-01  1684
>

