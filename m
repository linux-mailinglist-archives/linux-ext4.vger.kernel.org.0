Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B49568665E
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Feb 2023 14:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjBANFc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Feb 2023 08:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjBANFc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Feb 2023 08:05:32 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36A21E2B3;
        Wed,  1 Feb 2023 05:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675256730; x=1706792730;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1ezy7vzV4A+mQkaS59I0Os4yOVb8/Gz4isjpFiZSdb8=;
  b=FxpJn5kVbeWQRegMNBJ55hWkNxhF9McQoYBzFyaoSKeddDjO0Mq8C8i1
   zKRtqrHU8I4ye8ia8m/uNXDZHyVgyNYNcUcnwRbJSY2Zw9F7MOqbAFpAy
   5gQANq5y62eQb+SBCSh+C0tJO0lKDr4C1O6MzoXxybn+Ugs8cE8lLjS8D
   uqEo1HXuru1klnMshSLnx3o2m4oVbAQg7TrnP4onnhQudLLBbuGpZ4mc7
   GKBRI1zGZ0Vo24gUbCOxCWzMixo1otTVRc3INYeA5BS66juoBsBFve2ZH
   UEa254EedH5sC9ep04WTA8OKFVszI1YJfOQAGUXG/WdfOeuef1HqlHGPA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="329426793"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="329426793"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 05:05:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="993685455"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="993685455"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 01 Feb 2023 05:05:27 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNCnm-0005Ry-2J;
        Wed, 01 Feb 2023 13:05:26 +0000
Date:   Wed, 1 Feb 2023 21:05:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ye Bin <yebin@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH 2/5] ext4: introudce helper for jounral recover handle
Message-ID: <202302012039.pe8277UH-lkp@intel.com>
References: <20230201114651.4090446-3-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201114651.4090446-3-yebin@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ye,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tytso-ext4/dev]
[also build test WARNING on linus/master v6.2-rc6 next-20230201]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ye-Bin/jbd2-introduce-callback-for-recovery-journal/20230201-192400
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20230201114651.4090446-3-yebin%40huaweicloud.com
patch subject: [PATCH 2/5] ext4: introudce helper for jounral recover handle
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230201/202302012039.pe8277UH-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/316c2a97e3b3629813acbac07b6a03d836a00fa1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ye-Bin/jbd2-introduce-callback-for-recovery-journal/20230201-192400
        git checkout 316c2a97e3b3629813acbac07b6a03d836a00fa1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/ext4/ext4_jbd2.c:399:6: warning: no previous prototype for 'ext4_replay_end_callback' [-Wmissing-prototypes]
     399 | void ext4_replay_end_callback(struct journal_s *journal)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/ext4_replay_end_callback +399 fs/ext4/ext4_jbd2.c

   398	
 > 399	void ext4_replay_end_callback(struct journal_s *journal)
   400	{
   401		kfree(journal->j_replay_private_data);
   402		journal->j_replay_private_data = NULL;
   403		journal->j_replay_callback = NULL;
   404		journal->j_replay_end_callback = NULL;
   405	}
   406	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
