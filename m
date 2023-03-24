Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86D66C7D89
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Mar 2023 12:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjCXL6Y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Mar 2023 07:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjCXL6Y (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 24 Mar 2023 07:58:24 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFC39760
        for <linux-ext4@vger.kernel.org>; Fri, 24 Mar 2023 04:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679659102; x=1711195102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZBOnlGHEHX5QehSOnThNvSqkic6+pzAnwoOKrCff764=;
  b=VxL+DGa9l3New1R99Z7NX2zQwgMdAITTRGkIZG9X0RlY2+wRSVfzeYY2
   GYcb3QC0uSgDVr/YpF8/yUynaZKyh+stNi07gufeOQmgmUtoKLEYyPgRP
   Cd1sQveH+3k4HVyT5CR1FUAeNvyI3k/qvGIzpKZ0CtiWfrlp4oSONm0IQ
   wmILpw5GTsPXNX4tcGtMjuT6NzmXH2+gAo2IKEF7n/BLqmdX9RfTDt+r7
   7izXwj4G2D5CElCLJ0ENZICOQvdDNpGj3e/FCSGqdEsxLcTOnM0SXBn3k
   no4seGFO4qHIkoerHIt9yZGSlBKv7V7CHGJVhTRHyl4mUogIU3HUy7Lco
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="367494519"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="367494519"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 04:58:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="632818046"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="632818046"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 Mar 2023 04:58:19 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfg3h-000FGu-29;
        Fri, 24 Mar 2023 11:58:13 +0000
Date:   Fri, 24 Mar 2023 19:57:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chung-Chiang Cheng <cccheng@synology.com>,
        linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        shepjeng@gmail.com, kernel@cccheng.net,
        Chung-Chiang Cheng <cccheng@synology.com>,
        Robbie Ko <robbieko@synology.com>
Subject: Re: [PATCH] ext4: defer updating i_disksize until endio
Message-ID: <202303241950.C1ApLyal-lkp@intel.com>
References: <20230324092907.1341457-1-cccheng@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324092907.1341457-1-cccheng@synology.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Chung-Chiang,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v6.3-rc3]
[also build test WARNING on linus/master]
[cannot apply to tytso-ext4/dev next-20230324]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chung-Chiang-Cheng/ext4-defer-updating-i_disksize-until-endio/20230324-173716
patch link:    https://lore.kernel.org/r/20230324092907.1341457-1-cccheng%40synology.com
patch subject: [PATCH] ext4: defer updating i_disksize until endio
config: x86_64-randconfig-a014 (https://download.01.org/0day-ci/archive/20230324/202303241950.C1ApLyal-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9a02b364d2cffe71a45866edf750b0280c8cb990
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Chung-Chiang-Cheng/ext4-defer-updating-i_disksize-until-endio/20230324-173716
        git checkout 9a02b364d2cffe71a45866edf750b0280c8cb990
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/ext4/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303241950.C1ApLyal-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/ext4/inode.c:3115:23: warning: variable 'end' set but not used [-Wunused-but-set-variable]
           unsigned long start, end;
                                ^
   1 warning generated.


vim +/end +3115 fs/ext4/inode.c

64769240bd07f4 Alex Tomas         2008-07-11  3108  
64769240bd07f4 Alex Tomas         2008-07-11  3109  static int ext4_da_write_end(struct file *file,
64769240bd07f4 Alex Tomas         2008-07-11  3110  			     struct address_space *mapping,
64769240bd07f4 Alex Tomas         2008-07-11  3111  			     loff_t pos, unsigned len, unsigned copied,
64769240bd07f4 Alex Tomas         2008-07-11  3112  			     struct page *page, void *fsdata)
64769240bd07f4 Alex Tomas         2008-07-11  3113  {
64769240bd07f4 Alex Tomas         2008-07-11  3114  	struct inode *inode = mapping->host;
632eaeab1feb5d Mingming Cao       2008-07-11 @3115  	unsigned long start, end;
79f0be8d2e6ebd Aneesh Kumar K.V   2008-10-08  3116  	int write_mode = (int)(unsigned long)fsdata;
79f0be8d2e6ebd Aneesh Kumar K.V   2008-10-08  3117  
74d553aad7926e Theodore Ts'o      2013-04-03  3118  	if (write_mode == FALL_BACK_TO_NONDELALLOC)
74d553aad7926e Theodore Ts'o      2013-04-03  3119  		return ext4_write_end(file, mapping, pos,
79f0be8d2e6ebd Aneesh Kumar K.V   2008-10-08  3120  				      len, copied, page, fsdata);
632eaeab1feb5d Mingming Cao       2008-07-11  3121  
9bffad1ed2a003 Theodore Ts'o      2009-06-17  3122  	trace_ext4_da_write_end(inode, pos, len, copied);
6984aef59814fb Zhang Yi           2021-07-16  3123  
6984aef59814fb Zhang Yi           2021-07-16  3124  	if (write_mode != CONVERT_INLINE_DATA &&
6984aef59814fb Zhang Yi           2021-07-16  3125  	    ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA) &&
6984aef59814fb Zhang Yi           2021-07-16  3126  	    ext4_has_inline_data(inode))
6984aef59814fb Zhang Yi           2021-07-16  3127  		return ext4_write_inline_data_end(inode, pos, len, copied, page);
6984aef59814fb Zhang Yi           2021-07-16  3128  
09cbfeaf1a5a67 Kirill A. Shutemov 2016-04-01  3129  	start = pos & (PAGE_SIZE - 1);
632eaeab1feb5d Mingming Cao       2008-07-11  3130  	end = start + copied - 1;
64769240bd07f4 Alex Tomas         2008-07-11  3131  
64769240bd07f4 Alex Tomas         2008-07-11  3132  	/*
4df031ff5876d9 Zhang Yi           2021-07-16  3133  	 * Since we are holding inode lock, we are sure i_disksize <=
4df031ff5876d9 Zhang Yi           2021-07-16  3134  	 * i_size. We also know that if i_disksize < i_size, there are
9a02b364d2cffe Chung-Chiang Cheng 2023-03-24  3135  	 * delalloc writes pending in the range upto i_size. There's no
9a02b364d2cffe Chung-Chiang Cheng 2023-03-24  3136  	 * need to touch i_disksize since the endio of writeback will
9a02b364d2cffe Chung-Chiang Cheng 2023-03-24  3137  	 * push i_disksize upto i_size eventually.
4df031ff5876d9 Zhang Yi           2021-07-16  3138  	 *
4df031ff5876d9 Zhang Yi           2021-07-16  3139  	 * Note that we defer inode dirtying to generic_write_end() /
4df031ff5876d9 Zhang Yi           2021-07-16  3140  	 * ext4_da_write_inline_data_end().
64769240bd07f4 Alex Tomas         2008-07-11  3141  	 */
9c3569b50f12e4 Tao Ma             2012-12-10  3142  
cc883236b79297 Zhang Yi           2021-07-16  3143  	return generic_write_end(file, mapping, pos, len, copied, page, fsdata);
64769240bd07f4 Alex Tomas         2008-07-11  3144  }
64769240bd07f4 Alex Tomas         2008-07-11  3145  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
