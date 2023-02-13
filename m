Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E46B693E29
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Feb 2023 07:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjBMGUY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Feb 2023 01:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBMGUX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Feb 2023 01:20:23 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8747A6EB0
        for <linux-ext4@vger.kernel.org>; Sun, 12 Feb 2023 22:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676269221; x=1707805221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W5ovj3A01rCwZrafuh/KA7yhCF+GMCLPpkHfJmH3y3k=;
  b=PjQ1nRVUKmbtpsQ283TXUANN8uFkeQAyz4823DQkzxNrJtj837WxzurU
   AHBkzUnflGgAnq/4BbuiazVWVSsHkKN+LHZmeyG2P+6sKVkq7XDUOGAwb
   R9isjf80Rk1NGHUu6PjPddoc5BW8KoVsJ0n4VtXCb8EebTksINTDKG2h1
   M2M2YsWpRkP70DL4T9IaHzDDWGNax19/Mq8DshDnfT3JAd0iqzrcccX+v
   jsevHzWXT1nEkPfqwiA97oOlDhq56fa40xbyzg13op/kLWuD8bYmsq4yc
   7sJdoOSPCjdf9HS5/6Lela+zNVZM1164kTP3wxYf82459M851GRT1MonT
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="332125085"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="332125085"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 22:20:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="701147179"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="701147179"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 12 Feb 2023 22:20:10 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pRSC9-0007ar-25;
        Mon, 13 Feb 2023 06:20:09 +0000
Date:   Mon, 13 Feb 2023 14:19:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     zhanchengbin <zhanchengbin1@huawei.com>, tytso@mit.edu,
        jack@suse.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-ext4@vger.kernel.org, yi.zhang@huawei.com,
        linfeilong@huawei.com, liuzhiqiang26@huawei.com,
        zhanchengbin <zhanchengbin1@huawei.com>
Subject: Re: [PATCH v4 2/2] ext4: clear the verified flag of the modified
 leaf or idx if error
Message-ID: <202302131407.XrieHNuN-lkp@intel.com>
References: <20230213040522.3339406-3-zhanchengbin1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213040522.3339406-3-zhanchengbin1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi zhanchengbin,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tytso-ext4/dev]
[also build test ERROR on jack-fs/for_next linus/master v6.2-rc8 next-20230210]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/zhanchengbin/ext4-fix-inode-tree-inconsistency-caused-by-ENOMEM-in-ext4_split_extent_at/20230213-114334
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20230213040522.3339406-3-zhanchengbin1%40huawei.com
patch subject: [PATCH v4 2/2] ext4: clear the verified flag of the modified leaf or idx if error
config: i386-randconfig-a004-20230213 (https://download.01.org/0day-ci/archive/20230213/202302131407.XrieHNuN-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c6de5d67952addd5ffa288574ed55ebe7aeba755
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review zhanchengbin/ext4-fix-inode-tree-inconsistency-caused-by-ENOMEM-in-ext4_split_extent_at/20230213-114334
        git checkout c6de5d67952addd5ffa288574ed55ebe7aeba755
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/ext4/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302131407.XrieHNuN-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/ext4/extents.c:1760:32: error: member reference type 'struct ext4_ext_path' is not a pointer; did you mean to use '.'?
                   clear_buffer_verified(path[k]->p_bh);
                                         ~~~~~~~^~
                                                .
   fs/ext4/extents.c:2352:36: error: member reference type 'struct ext4_ext_path' is not a pointer; did you mean to use '.'?
                   clear_buffer_verified(path[depth]->p_bh);
                                         ~~~~~~~~~~~^~
                                                    .
   2 errors generated.


vim +1760 fs/ext4/extents.c

  1699	
  1700	/*
  1701	 * ext4_ext_correct_indexes:
  1702	 * if leaf gets modified and modified extent is first in the leaf,
  1703	 * then we have to correct all indexes above.
  1704	 * TODO: do we need to correct tree in all cases?
  1705	 */
  1706	static int ext4_ext_correct_indexes(handle_t *handle, struct inode *inode,
  1707					struct ext4_ext_path *path)
  1708	{
  1709		struct ext4_extent_header *eh;
  1710		int depth = ext_depth(inode);
  1711		struct ext4_extent *ex;
  1712		__le32 border;
  1713		int k, err = 0;
  1714	
  1715		eh = path[depth].p_hdr;
  1716		ex = path[depth].p_ext;
  1717	
  1718		if (unlikely(ex == NULL || eh == NULL)) {
  1719			EXT4_ERROR_INODE(inode,
  1720					 "ex %p == NULL or eh %p == NULL", ex, eh);
  1721			return -EFSCORRUPTED;
  1722		}
  1723	
  1724		if (depth == 0) {
  1725			/* there is no tree at all */
  1726			return 0;
  1727		}
  1728	
  1729		if (ex != EXT_FIRST_EXTENT(eh)) {
  1730			/* we correct tree if first leaf got modified only */
  1731			return 0;
  1732		}
  1733	
  1734		/*
  1735		 * TODO: we need correction if border is smaller than current one
  1736		 */
  1737		k = depth - 1;
  1738		border = path[depth].p_ext->ee_block;
  1739		err = ext4_ext_get_access(handle, inode, path + k);
  1740		if (err)
  1741			return err;
  1742		path[k].p_idx->ei_block = border;
  1743		err = ext4_ext_dirty(handle, inode, path + k);
  1744		if (err)
  1745			return err;
  1746	
  1747		while (k--) {
  1748			/* change all left-side indexes */
  1749			if (path[k+1].p_idx != EXT_FIRST_INDEX(path[k+1].p_hdr))
  1750				break;
  1751			err = ext4_ext_get_access(handle, inode, path + k);
  1752			if (err)
  1753				break;
  1754			path[k].p_idx->ei_block = border;
  1755			err = ext4_ext_dirty(handle, inode, path + k);
  1756			if (err)
  1757				break;
  1758		}
  1759		while (!(k < 0) && k++ < depth)
> 1760			clear_buffer_verified(path[k]->p_bh);
  1761	
  1762		return err;
  1763	}
  1764	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
