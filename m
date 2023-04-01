Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227ED6D2C22
	for <lists+linux-ext4@lfdr.de>; Sat,  1 Apr 2023 02:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjDAAlI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 31 Mar 2023 20:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjDAAlH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 31 Mar 2023 20:41:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3741A463;
        Fri, 31 Mar 2023 17:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680309666; x=1711845666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/p6kHJVBSbUixOamAUXNdtskxeLyC+KHCubQPFvPg0c=;
  b=Yma0hFXNRzcwfCFdi/NYg0ArvirEO+He3uFZ8pDCaN+fZIGWy94FyFzA
   BRVxVaqUUnYP6FQ9knNDbQgLjp9YbZRvEafUqtCV9u04Y47iVJ1yHDFta
   orA4f4WFTYS9kwNNX37uro8AMdDmxr2ZSJc7R7aNcmr4dNvIqoP0YjoHS
   Hqz2URfJpmpZI2CR3xXoXsJajhy0QPg9aCgJ3kS7AWUzxzQgbekiNCISm
   msHlJqD77zKTs+j1EFoipWust48Ppwlh6fz+TYBPWsEk746wASrrjOuLP
   IDy6OjKcYFb8p6Q/uODdlu46fE7CUhKxKu/hNYnl7Db+pivQ2GaHPLH/n
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="341610528"
X-IronPort-AV: E=Sophos;i="5.98,308,1673942400"; 
   d="scan'208";a="341610528"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 17:41:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="931384387"
X-IronPort-AV: E=Sophos;i="5.98,308,1673942400"; 
   d="scan'208";a="931384387"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 31 Mar 2023 17:41:04 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1piPIl-000MJF-14;
        Sat, 01 Apr 2023 00:41:03 +0000
Date:   Sat, 1 Apr 2023 08:40:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Triplett <josh@joshtriplett.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] ext4: Add a uapi header for ext4 userspace APIs
Message-ID: <202304010801.X0Hn9zmw-lkp@intel.com>
References: <152752fa6b148e0ea304a3cdb3cc33bae0117918.1680272908.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152752fa6b148e0ea304a3cdb3cc33bae0117918.1680272908.git.josh@joshtriplett.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Josh,

I love your patch! Yet something to improve:

[auto build test ERROR on tytso-ext4/dev]
[also build test ERROR on linus/master v6.3-rc4 next-20230331]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Josh-Triplett/ext4-Add-a-uapi-header-for-ext4-userspace-APIs/20230331-224557
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/152752fa6b148e0ea304a3cdb3cc33bae0117918.1680272908.git.josh%40joshtriplett.org
patch subject: [PATCH v2] ext4: Add a uapi header for ext4 userspace APIs
config: x86_64-randconfig-a016 (https://download.01.org/0day-ci/archive/20230401/202304010801.X0Hn9zmw-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/50d05266bcf4bc3307776d25c0f70d11063a8a4e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Josh-Triplett/ext4-Add-a-uapi-header-for-ext4-userspace-APIs/20230331-224557
        git checkout 50d05266bcf4bc3307776d25c0f70d11063a8a4e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304010801.X0Hn9zmw-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/linux/ext4.h:113:2: error: unknown type name 'compat_u64'
           compat_u64 block_bitmap;
           ^
   ./usr/include/linux/ext4.h:114:2: error: unknown type name 'compat_u64'
           compat_u64 inode_bitmap;
           ^
   ./usr/include/linux/ext4.h:115:2: error: unknown type name 'compat_u64'
           compat_u64 inode_table;
           ^
   3 errors generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
