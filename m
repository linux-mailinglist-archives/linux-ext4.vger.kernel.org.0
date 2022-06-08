Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E415421BE
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jun 2022 08:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbiFHEmO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Jun 2022 00:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbiFHEjO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Jun 2022 00:39:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A8E27D0F3
        for <linux-ext4@vger.kernel.org>; Tue,  7 Jun 2022 19:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654655440; x=1686191440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H9Gegw95EeArwv/+dQCHsQrzK/8pfT26OnbRuAX1c3w=;
  b=fX5ASiKzOmuLT9AxDL/XmWri+wZqZkgb2/kSKZfuYKe9Nzynyrf4M8sQ
   nYCb9LkKvAvclAfOyrGJmJdfpeQUJgK+IXrOCbisLW2ssBJIXh6ZxcmNs
   wuJY+RCTkW8zKycRRjca2Ii1nfSjmg4OFKi0IXA7xyDDALsBF6ZYlV8sV
   +9NoKsSLYsV+HMCHhdIvzio0dMhJVf9FgImqPFu0l4iABsg+CCQgKOnAi
   SOCuWZHVL2nJ8dfZLOM4RsevVZePcYIs/H9XtiAaQ/xvbGg1ctQzoxMAK
   SA8kbcG83BC17xd3MSSCUCx4Xny5aRjIMmvO8sGK1E3Ni0Ig/h6YSkCrD
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="340812521"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="340812521"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 19:30:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="709748422"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 07 Jun 2022 19:30:14 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nylSY-000EAz-0H;
        Wed, 08 Jun 2022 02:30:14 +0000
Date:   Wed, 8 Jun 2022 10:29:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>
Cc:     kbuild-all@lists.01.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] jbd2: Remove unused exports for jbd2 debugging
Message-ID: <202206081021.Y85M7FUG-lkp@intel.com>
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
[also build test ERROR on linus/master v5.19-rc1 next-20220607]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Jan-Kara/jbd2-Remove-unused-exports-for-jbd2-debugging/20220606-224629
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
config: microblaze-buildonly-randconfig-r012-20220605 (https://download.01.org/0day-ci/archive/20220608/202206081021.Y85M7FUG-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9aaaac58ce0525ce441ad75b45bf3e5f3911a82b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jan-Kara/jbd2-Remove-unused-exports-for-jbd2-debugging/20220606-224629
        git checkout 9aaaac58ce0525ce441ad75b45bf3e5f3911a82b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__jbd2_debug" [fs/ext4/ext4.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
