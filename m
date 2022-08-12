Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4147359162E
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Aug 2022 22:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbiHLUL6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Aug 2022 16:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbiHLUL6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 Aug 2022 16:11:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135F5B5152;
        Fri, 12 Aug 2022 13:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660335117; x=1691871117;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=U7VKJ/YR4r6dt1TIieIa50ZssYXbZQFLKweTbIbNLBI=;
  b=CCa3dMjjMxcQM3b/9Aq3lAK5xISjDDTpIYiEunC7yL+k5umAwSPBnnoC
   Hm4BhnxWYRPGOkeBo/Qs25+nsvjWoLTz4O9e5W+2NmC0MQC5tEDmoW7Wo
   CpmvWnIJpfQO84OROVtm5N7x8iv2e3dCqftDz9Q4mPSXLnl0e09p/IzqW
   DCUtuQOlnkcGO26FjApGigrbbdOJdZutUotb4ngRKLIvy7ZqEPmOvduQz
   Mx0L10F4s3m3fe1brSrCDIUvtK0Ab5HdInmCK6gkJXd7dsDRkYsOsJqxj
   J7HK5Qq5RuM7DfkVrqYdjketnDdXnlmhAKsODvjj96K/vqZA+tTFX/ock
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="289248638"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="289248638"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 13:11:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="748312267"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 12 Aug 2022 13:11:54 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMb0b-0000tF-1q;
        Fri, 12 Aug 2022 20:11:53 +0000
Date:   Sat, 13 Aug 2022 04:11:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        wenqingliu0120@gmail.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>,
        Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH v3] ext4: fix bug in extents parsing when eh_entries == 0
 and eh_depth > 0
Message-ID: <202208130421.BZpzWWRK-lkp@intel.com>
References: <20220812141329.9501-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220812141329.9501-1-lhenriques@suse.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi "Luís,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tytso-ext4/dev]
[also build test ERROR on linus/master v5.19 next-20220812]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lu-s-Henriques/ext4-fix-bug-in-extents-parsing-when-eh_entries-0-and-eh_depth-0/20220812-221443
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
config: arm64-buildonly-randconfig-r002-20220812 (https://download.01.org/0day-ci/archive/20220813/202208130421.BZpzWWRK-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/ef3617646de6e939d29961099c7c8adcaa0d9fd9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Lu-s-Henriques/ext4-fix-bug-in-extents-parsing-when-eh_entries-0-and-eh_depth-0/20220812-221443
        git checkout ef3617646de6e939d29961099c7c8adcaa0d9fd9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash fs/ext4/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/ext4/extents.c:463:41: error: use of undeclared identifier 'eh_depth'; did you mean 'ext_depth'?
           if (unlikely((eh->eh_entries == 0) && (eh_depth > 0))) {
                                                  ^~~~~~~~
                                                  ext_depth
   include/linux/compiler.h:78:42: note: expanded from macro 'unlikely'
   # define unlikely(x)    __builtin_expect(!!(x), 0)
                                               ^
   fs/ext4/ext4_extents.h:192:30: note: 'ext_depth' declared here
   static inline unsigned short ext_depth(struct inode *inode)
                                ^
   1 error generated.


vim +463 fs/ext4/extents.c

   434	
   435	static int __ext4_ext_check(const char *function, unsigned int line,
   436				    struct inode *inode, struct ext4_extent_header *eh,
   437				    int depth, ext4_fsblk_t pblk, ext4_lblk_t lblk)
   438	{
   439		const char *error_msg;
   440		int max = 0, err = -EFSCORRUPTED;
   441	
   442		if (unlikely(eh->eh_magic != EXT4_EXT_MAGIC)) {
   443			error_msg = "invalid magic";
   444			goto corrupted;
   445		}
   446		if (unlikely(le16_to_cpu(eh->eh_depth) != depth)) {
   447			error_msg = "unexpected eh_depth";
   448			goto corrupted;
   449		}
   450		if (unlikely(eh->eh_max == 0)) {
   451			error_msg = "invalid eh_max";
   452			goto corrupted;
   453		}
   454		max = ext4_ext_max_entries(inode, depth);
   455		if (unlikely(le16_to_cpu(eh->eh_max) > max)) {
   456			error_msg = "too large eh_max";
   457			goto corrupted;
   458		}
   459		if (unlikely(le16_to_cpu(eh->eh_entries) > le16_to_cpu(eh->eh_max))) {
   460			error_msg = "invalid eh_entries";
   461			goto corrupted;
   462		}
 > 463		if (unlikely((eh->eh_entries == 0) && (eh_depth > 0))) {
   464			error_msg = "eh_entries is 0 but eh_depth is > 0";
   465			goto corrupted;
   466		}
   467		if (!ext4_valid_extent_entries(inode, eh, lblk, &pblk, depth)) {
   468			error_msg = "invalid extent entries";
   469			goto corrupted;
   470		}
   471		if (unlikely(depth > 32)) {
   472			error_msg = "too large eh_depth";
   473			goto corrupted;
   474		}
   475		/* Verify checksum on non-root extent tree nodes */
   476		if (ext_depth(inode) != depth &&
   477		    !ext4_extent_block_csum_verify(inode, eh)) {
   478			error_msg = "extent tree corrupted";
   479			err = -EFSBADCRC;
   480			goto corrupted;
   481		}
   482		return 0;
   483	
   484	corrupted:
   485		ext4_error_inode_err(inode, function, line, 0, -err,
   486				     "pblk %llu bad header/extent: %s - magic %x, "
   487				     "entries %u, max %u(%u), depth %u(%u)",
   488				     (unsigned long long) pblk, error_msg,
   489				     le16_to_cpu(eh->eh_magic),
   490				     le16_to_cpu(eh->eh_entries),
   491				     le16_to_cpu(eh->eh_max),
   492				     max, le16_to_cpu(eh->eh_depth), depth);
   493		return err;
   494	}
   495	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
