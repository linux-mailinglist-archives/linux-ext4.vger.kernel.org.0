Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6326D0748
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Mar 2023 15:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjC3Nuk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Mar 2023 09:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjC3Nui (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 30 Mar 2023 09:50:38 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3A45B86;
        Thu, 30 Mar 2023 06:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680184236; x=1711720236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0RFB1dYZ9F2StXue2dw6vh4Fi8li3Ziwy4v/kPzxaaQ=;
  b=lyayXXt0GM7m6k/XxvD5TSE9A3oHJgvmpiZamgOH10syR0w/TN58jPKF
   ncppL7wXIas07HXkrqIchrxNwYMKnCRX9jW5kSSnPwvqDNGaQ5OSOa19L
   +je0qhEBoPjNjFUs+vxVE3H5adhWkhTxjx4jUhxnr5eHk+A9T4nF3kqWs
   zIt+OGr1sasyfP6LmpJlF4DEHsxu6SkB12IR0nupKspI+gscGog3WUsBD
   njgeb5qaf28JeYpf46rTLcYXd2IEr+fRkNdbQaunbQqT/n9O4ziN4r+0d
   tjEhQBgf/y0SYVZ3HhEkmvE9VexLrplPNklS69XFo7GbAODHoTlul1iqt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="343638563"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="343638563"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 06:22:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="753990820"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="753990820"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 30 Mar 2023 06:22:56 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phsEx-000KtE-0z;
        Thu, 30 Mar 2023 13:22:55 +0000
Date:   Thu, 30 Mar 2023 21:22:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Triplett <josh@joshtriplett.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] ext4: Add a uapi header for ext4 userspace APIs
Message-ID: <202303302155.FBlvXAL3-lkp@intel.com>
References: <f0c650c0a0bcc799101573d265f3006c6f6bd046.1680149153.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0c650c0a0bcc799101573d265f3006c6f6bd046.1680149153.git.josh@joshtriplett.org>
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
[also build test ERROR on linus/master v6.3-rc4 next-20230330]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Josh-Triplett/ext4-Add-a-uapi-header-for-ext4-userspace-APIs/20230330-123712
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/f0c650c0a0bcc799101573d265f3006c6f6bd046.1680149153.git.josh%40joshtriplett.org
patch subject: [PATCH] ext4: Add a uapi header for ext4 userspace APIs
config: x86_64-randconfig-a016 (https://download.01.org/0day-ci/archive/20230330/202303302155.FBlvXAL3-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9e61a3eab96b327fb2392b2ae665c6bc25e4b004
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Josh-Triplett/ext4-Add-a-uapi-header-for-ext4-userspace-APIs/20230330-123712
        git checkout 9e61a3eab96b327fb2392b2ae665c6bc25e4b004
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303302155.FBlvXAL3-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/linux/ext4.h:7:10: fatal error: 'uapi/linux/fiemap.h' file not found
   #include <uapi/linux/fiemap.h>
            ^~~~~~~~~~~~~~~~~~~~~
   1 error generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
