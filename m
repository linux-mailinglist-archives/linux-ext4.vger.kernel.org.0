Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912EF6D6B11
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Apr 2023 20:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjDDSBy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Apr 2023 14:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjDDSBw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Apr 2023 14:01:52 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96ED1C9;
        Tue,  4 Apr 2023 11:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680631311; x=1712167311;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pKl3HEZ6pw4XTW76clROp444ezAtoai1AXFHPcYLmqk=;
  b=m+l5z+6HLVpOMNBDspYFeRMFXd50jBGQT9s1WzUJYlxkj6I2rb0ZPjOy
   OtHXwoWoAuZPxXjsgtZ1JXii7+EXAKYOHVSIqCCtoXMHD2sv1Uywphqri
   xgiQ16B8uUmXSakzZeXzX+K9Q8oE7/lX8pDo8ca/x7BmcFxbJ2V/VNBXP
   yyV/RHTPX7QKDV6JVVgrfaL3i7Y6WxFjU0f1GIAHmzCXK7toFeiYDqF91
   8nqNaaPG9j5NFKbAZ6igGI7P5hP+/mpCgOlcqmUqNubD6UrKAbWq2jb0d
   2Sd+DbBbaA6I39OoWKB5dhLUrDPxvhuE61jCcjarqB1CGZX9+Q3ERKiAz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="370081688"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="370081688"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 11:01:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="932533140"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="932533140"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 04 Apr 2023 11:01:39 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pjkyQ-000Py2-22;
        Tue, 04 Apr 2023 18:01:38 +0000
Date:   Wed, 5 Apr 2023 02:01:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrey Albershteyn <aalbersh@redhat.com>, djwong@kernel.org,
        dchinner@redhat.com, ebiggers@kernel.org, hch@infradead.org,
        linux-xfs@vger.kernel.org, fsverity@lists.linux.dev
Cc:     oe-kbuild-all@lists.linux.dev, rpeterso@redhat.com,
        agruenba@redhat.com, xiang@kernel.org, chao@kernel.org,
        damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, Andrey Albershteyn <aalbersh@redhat.com>
Subject: Re: [PATCH v2 20/23] xfs: add fs-verity support
Message-ID: <202304050102.zJkNrHah-lkp@intel.com>
References: <20230404145319.2057051-21-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404145319.2057051-21-aalbersh@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Andrey,

kernel test robot noticed the following build errors:

[auto build test ERROR on xfs-linux/for-next]
[also build test ERROR on kdave/for-next tytso-ext4/dev jaegeuk-f2fs/dev-test jaegeuk-f2fs/dev linus/master v6.3-rc5]
[cannot apply to next-20230404]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrey-Albershteyn/xfs-Add-new-name-to-attri-d/20230404-230224
base:   https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git for-next
patch link:    https://lore.kernel.org/r/20230404145319.2057051-21-aalbersh%40redhat.com
patch subject: [PATCH v2 20/23] xfs: add fs-verity support
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20230405/202304050102.zJkNrHah-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1324353702eaba7da1643d589631adcaedf9a046
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andrey-Albershteyn/xfs-Add-new-name-to-attri-d/20230404-230224
        git checkout 1324353702eaba7da1643d589631adcaedf9a046
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304050102.zJkNrHah-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   In function 'xfs_check_ondisk_structs',
       inlined from 'init_xfs_fs' at fs/xfs/xfs_super.c:2307:2:
>> include/linux/compiler_types.h:397:45: error: call to '__compiletime_assert_1674' declared with attribute error: XFS: value of strlen(XFS_VERITY_DESCRIPTOR_NAME) is wrong, expected XFS_VERITY_DESCRIPTOR_NAME_LEN
     397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:378:25: note: in definition of macro '__compiletime_assert'
     378 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
     397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   fs/xfs/xfs_ondisk.h:19:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      19 |         BUILD_BUG_ON_MSG((value) != (expected), \
         |         ^~~~~~~~~~~~~~~~
   fs/xfs/xfs_ondisk.h:194:9: note: in expansion of macro 'XFS_CHECK_VALUE'
     194 |         XFS_CHECK_VALUE(strlen(XFS_VERITY_DESCRIPTOR_NAME),
         |         ^~~~~~~~~~~~~~~


vim +/__compiletime_assert_1674 +397 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  383  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  384  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  385  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  386  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  387  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  388   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  389   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  390   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  391   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  392   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  393   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  394   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  395   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  396  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @397  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  398  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
