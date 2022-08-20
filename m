Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B82A59B0D7
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Aug 2022 00:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbiHTWv1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 20 Aug 2022 18:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiHTWvZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 20 Aug 2022 18:51:25 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AB825E94;
        Sat, 20 Aug 2022 15:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661035882; x=1692571882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BMC9c98PYAsxMWUPCS4FPSTVdvVtrr6r3fNBNU+hp4s=;
  b=a6RfjFP0aYR7PnSQJ13CXvNsB+h5eyhR9M0reGF4ZcUnISRGFEt4WOE2
   toPwQzNr9JT5dMKCcDKR5IyJx1Hh0PsR4lriCVKnHI+GRkxiIgdzOimou
   urtvvheSaFWJMF9hb6MPEYaaMfLCDnaPseCJHjjyCBI5poSCTD/2ul0KF
   vIFIM9YGj00bCGPj3BbCd5dEUH1B5mRpg3C9rXRE5g95FyWwZT9jiW4Nw
   gTo8/kRIMHArV09vs9xHUYgNkB6pekv+eJFabXT/xiMvUoQG9V3pOcExj
   Ls7hiMjsyzT+dqz18SaevKb7y9gbWsCUBC4G3edzBvHy/TNndN28MgcsF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10445"; a="280171632"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="280171632"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 15:51:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="676800072"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Aug 2022 15:51:18 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPXJF-0003JD-2E;
        Sat, 20 Aug 2022 22:51:17 +0000
Date:   Sun, 21 Aug 2022 06:50:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiangshan Yi <13667453960@163.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     kbuild-all@lists.01.org, lczerner@redhat.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: Re: [PATCH v3] fs/ext4: replace ternary operator with min()/max()
 and min_t()
Message-ID: <202208210652.VUSXxffI-lkp@intel.com>
References: <20220816011553.2912926-1-13667453960@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816011553.2912926-1-13667453960@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Jiangshan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tytso-ext4/dev]
[also build test WARNING on linus/master v6.0-rc1 next-20220819]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiangshan-Yi/fs-ext4-replace-ternary-operator-with-min-max-and-min_t/20220816-144454
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
config: parisc-randconfig-s041-20220821 (https://download.01.org/0day-ci/archive/20220821/202208210652.VUSXxffI-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/cdc8d157495f1a1cbf921569e2babf14446058cf
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jiangshan-Yi/fs-ext4-replace-ternary-operator-with-min-max-and-min_t/20220816-144454
        git checkout cdc8d157495f1a1cbf921569e2babf14446058cf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc SHELL=/bin/bash fs/ext4/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> fs/ext4/super.c:6907:26: sparse: sparse: incompatible types in comparison expression (different type sizes):
>> fs/ext4/super.c:6907:26: sparse:    unsigned long *
>> fs/ext4/super.c:6907:26: sparse:    unsigned int *
   fs/ext4/super.c:992:6: sparse: sparse: context imbalance in '__ext4_grp_locked_error' - different lock contexts for basic block
   fs/ext4/super.c:3266:9: sparse: sparse: context imbalance in 'ext4_check_descriptors' - different lock contexts for basic block

vim +6907 fs/ext4/super.c

  6885	
  6886	/* Read data from quotafile - avoid pagecache and such because we cannot afford
  6887	 * acquiring the locks... As quota files are never truncated and quota code
  6888	 * itself serializes the operations (and no one else should touch the files)
  6889	 * we don't have to be afraid of races */
  6890	static ssize_t ext4_quota_read(struct super_block *sb, int type, char *data,
  6891				       size_t len, loff_t off)
  6892	{
  6893		struct inode *inode = sb_dqopt(sb)->files[type];
  6894		ext4_lblk_t blk = off >> EXT4_BLOCK_SIZE_BITS(sb);
  6895		int offset = off & (sb->s_blocksize - 1);
  6896		int tocopy;
  6897		size_t toread;
  6898		struct buffer_head *bh;
  6899		loff_t i_size = i_size_read(inode);
  6900	
  6901		if (off > i_size)
  6902			return 0;
  6903		if (off+len > i_size)
  6904			len = i_size-off;
  6905		toread = len;
  6906		while (toread > 0) {
> 6907			tocopy = min(sb->s_blocksize - offset, toread);
  6908			bh = ext4_bread(NULL, inode, blk, 0);
  6909			if (IS_ERR(bh))
  6910				return PTR_ERR(bh);
  6911			if (!bh)	/* A hole? */
  6912				memset(data, 0, tocopy);
  6913			else
  6914				memcpy(data, bh->b_data+offset, tocopy);
  6915			brelse(bh);
  6916			offset = 0;
  6917			toread -= tocopy;
  6918			data += tocopy;
  6919			blk++;
  6920		}
  6921		return len;
  6922	}
  6923	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
