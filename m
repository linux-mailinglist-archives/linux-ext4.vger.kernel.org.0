Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87ED8575548
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Jul 2022 20:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240818AbiGNSpi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Jul 2022 14:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbiGNSpg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Jul 2022 14:45:36 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7249F2655A
        for <linux-ext4@vger.kernel.org>; Thu, 14 Jul 2022 11:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657824335; x=1689360335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=axUJAiXtyhfkKPl/p703YhQUhJUoUv9GV4siXTqqpPU=;
  b=WzsL8zuDH+LxalQmlFrhh70wZya5VumMR9AUBVMYTkzdBajsdslTcirD
   A+lkpFCedyo1sRsnto6VTnms4nIqyIstAwY5Xi8sfBAFpmpa23i/YJFtI
   smfZhbf7WgikAxxfGq5JfQcQAFfyN8DSfduNnqgPByylRZy6UmXdn+sWz
   lUs+2TLl7RD7Am9Y7sGkJTmNQrTxlxr4N0OQgI6T8kh3sMcAa0GhBkJtF
   iJvcgvDUvCOh7+b/6eXOLQ1L7q8EvNXlsNQHmd/aknW6uamcY5c77IlC4
   vFJcT2tHloW6oHt2hEHSJjARM4FLMxIB4D0p/bebS5fuv+bcJNPxezCeZ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="283160653"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="283160653"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 11:45:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="772725466"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 14 Jul 2022 11:45:32 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oC3q8-00010I-8j;
        Thu, 14 Jul 2022 18:45:32 +0000
Date:   Fri, 15 Jul 2022 02:45:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Artem Blagodarenko <artem.blagodarenko@gmail.com>,
        linux-ext4@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        adilger.kernel@dilger.ca, andrew.perepechko@hpe.com,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>
Subject: Re: [PATCH v4] ext4: truncate during setxattr leads to kernel panic
Message-ID: <202207150257.B4gnbAMM-lkp@intel.com>
References: <20220711145735.53676-1-artem.blagodarenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711145735.53676-1-artem.blagodarenko@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Artem,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tytso-ext4/dev]
[also build test WARNING on linus/master v5.19-rc6 next-20220714]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Artem-Blagodarenko/ext4-truncate-during-setxattr-leads-to-kernel-panic/20220711-232350
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
config: hexagon-randconfig-r045-20220714 (https://download.01.org/0day-ci/archive/20220715/202207150257.B4gnbAMM-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e61b9c556267086ef9b743a0b57df302eef831b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/600aeea1cc6d36f380862bb88e50b670e0a57e4f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Artem-Blagodarenko/ext4-truncate-during-setxattr-leads-to-kernel-panic/20220711-232350
        git checkout 600aeea1cc6d36f380862bb88e50b670e0a57e4f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/btrfs/ fs/ext4/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/ext4/xattr.c:1563:15: warning: no previous prototype for function 'delayed_iput' [-Wmissing-prototypes]
   noinline void delayed_iput(struct inode *inode, struct delayed_iput_work *work)
                 ^
   fs/ext4/xattr.c:1563:10: note: declare 'static' if the function is not intended to be used outside of this translation unit
   noinline void delayed_iput(struct inode *inode, struct delayed_iput_work *work)
            ^
            static 
   1 warning generated.


vim +/delayed_iput +1563 fs/ext4/xattr.c

  1562	
> 1563	noinline void delayed_iput(struct inode *inode, struct delayed_iput_work *work)
  1564	{
  1565		if (!inode) {
  1566			kfree(work);
  1567			return;
  1568		}
  1569	
  1570		if (!work) {
  1571			iput(inode);
  1572		} else {
  1573			INIT_WORK(&work->work, delayed_iput_fn);
  1574			work->inode = inode;
  1575			queue_work(EXT4_SB(inode->i_sb)->s_misc_wq, &work->work);
  1576		}
  1577	}
  1578	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
