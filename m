Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3484654374D
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jun 2022 17:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244320AbiFHPY6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Jun 2022 11:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244352AbiFHPYV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Jun 2022 11:24:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E773C6
        for <linux-ext4@vger.kernel.org>; Wed,  8 Jun 2022 08:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654701598; x=1686237598;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C/vRiU53efJcn6fLogwCXc6HwBl6rv6d1wnE187attg=;
  b=cj+B7BUKkOReHJDTLuzWGq8/z+LdAG12XFZ1uqhUSYlYazZYaVxohovE
   HpLNXto5UiuEEcv6v99dQolJAAm9raisv2yghKUpnN94OXhcgjaUxwxfV
   ok+EB5txg9wccs4g9ELdxhxKGY8wMyUZkS0q6e5++f5QPhT6fD3VhwBny
   tL2/WmeYn/VpvdajLqxC7CTgxA8AwaHDNxWYYCj0ypm3OpESdWPWx3Q3Y
   N+O+Xy3iZfHd3ObOLL3Hpw4OrXbErIBCsKLO8QQRJrDvq8W4kETcT20tU
   lRGXaC1ER0wo5DIGLsKTZSlqa04wZBQoKLHp5UuKl1K2RVK5qa8Me3qc9
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="363261963"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="363261963"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 08:19:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="533136744"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 08 Jun 2022 08:19:37 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyxT6-000Ejc-GS;
        Wed, 08 Jun 2022 15:19:36 +0000
Date:   Wed, 8 Jun 2022 23:19:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] jbd2: Remove unused exports for jbd2 debugging
Message-ID: <202206082321.RIUKdEnL-lkp@intel.com>
References: <20220606144047.16780-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606144047.16780-1-jack@suse.cz>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Jan,

I love your patch! Yet something to improve:

[auto build test ERROR on tytso-ext4/dev]
[also build test ERROR on linus/master v5.19-rc1 next-20220608]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Jan-Kara/jbd2-Remove-unused-exports-for-jbd2-debugging/20220606-224629
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
config: hexagon-randconfig-r023-20220607 (https://download.01.org/0day-ci/archive/20220608/202206082321.RIUKdEnL-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b92436efcb7813fc481b30f2593a4907568d917a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9aaaac58ce0525ce441ad75b45bf3e5f3911a82b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jan-Kara/jbd2-Remove-unused-exports-for-jbd2-debugging/20220606-224629
        git checkout 9aaaac58ce0525ce441ad75b45bf3e5f3911a82b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__jbd2_debug" [fs/ext4/ext4.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
