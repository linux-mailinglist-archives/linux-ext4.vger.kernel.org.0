Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A716C686EE6
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Feb 2023 20:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjBAT0w (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Feb 2023 14:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjBAT0v (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Feb 2023 14:26:51 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7158304D;
        Wed,  1 Feb 2023 11:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675279610; x=1706815610;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b+R9TM/vpJIqxsOgEi13czSzFWw8gYCA5ybDpq8DRJ4=;
  b=W1ww4e2bKZmYGZ76ueEhX8nAH4xj99zQLCBrYBfb/QFJfbXv6hd2lugB
   1lomfX4gQTk7Jjau6sS38uvEzpDLoNo9w5+TVDBDOCwxrWEDGShav+yvk
   9u+M+oEzYgbflb6dZItzwgZK+EtW3P7S4suVneeG3ePQKzaQRcAdXQYgY
   FrOOiNoYI1FsM0nGwJK7eV9dI/u0qtuYO4pXbuaKhQ1g555dTvf+Wa9lc
   SHSf+2TDYRvgp37gWMa6o3w1ZUs4WXJMay0NKzVhYo2peBhgHVmVwIcAg
   NWtrKNvcD2iPkSmjQOw5L8kFq0nW/bet8rBoJ1nnXIFQbXaivBlyS6idj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="308591976"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="308591976"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 11:26:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="614955875"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="614955875"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 01 Feb 2023 11:26:46 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNIko-0005kR-0D;
        Wed, 01 Feb 2023 19:26:46 +0000
Date:   Thu, 2 Feb 2023 03:26:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ye Bin <yebin@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH 2/5] ext4: introudce helper for jounral recover handle
Message-ID: <202302020346.Oh31U8Zk-lkp@intel.com>
References: <20230201114651.4090446-3-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201114651.4090446-3-yebin@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
config: i386-randconfig-a013-20230130 (https://download.01.org/0day-ci/archive/20230202/202302020346.Oh31U8Zk-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/316c2a97e3b3629813acbac07b6a03d836a00fa1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ye-Bin/jbd2-introduce-callback-for-recovery-journal/20230201-192400
        git checkout 316c2a97e3b3629813acbac07b6a03d836a00fa1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/ext4/ lib/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/ext4/ext4_jbd2.c:399:6: warning: no previous prototype for function 'ext4_replay_end_callback' [-Wmissing-prototypes]
   void ext4_replay_end_callback(struct journal_s *journal)
        ^
   fs/ext4/ext4_jbd2.c:399:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void ext4_replay_end_callback(struct journal_s *journal)
   ^
   static 
   1 warning generated.


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
