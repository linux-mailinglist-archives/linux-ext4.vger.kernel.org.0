Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1672546FE62
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Dec 2021 11:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbhLJKHh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Dec 2021 05:07:37 -0500
Received: from mga06.intel.com ([134.134.136.31]:53858 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239876AbhLJKHh (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 10 Dec 2021 05:07:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639130642; x=1670666642;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=R2Zo1F5XWrT2I6bmjHodcUuFRDGkHB5JziyMG1r0x/0=;
  b=G59XsX43mmnGu9KOKbTiX3ouSsd/2eIgju9cksoA1Wdyh6SdrVG7Anu2
   4yCq2dNPmns2h0a2n7+8/9z3e2jPzqDEwhTW/sa2aXCW6nibdXn4/yV5Q
   fERMFvqjOZ4S2hvFRFpBCTVnKAVqWV3tHArgrIB1lAa5PWB54lvCEoZLO
   I7zme2q7d/Q/FA4ArKSfx5Vd2DYYqN54LGAEjKZvFe70u7QlZB/0DcPup
   BSJ5qp3YBqOBZFhlmmC2s9ZpNfxzfsK3p5MFDYlAQQmPlCgofqDTA/qhS
   X1UXM7GqnRSCHD5V2Yr6rVmw+JWLBlKwxUs5+rbHGNokIlVwoRi5n18/y
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="299107385"
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="299107385"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 02:04:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="680696604"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 10 Dec 2021 02:04:00 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvcky-00032V-8a; Fri, 10 Dec 2021 10:04:00 +0000
Date:   Fri, 10 Dec 2021 18:03:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: [tytso-ext4:dev 6/13] fs/ext4/super.c:2689:51: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202112101722.3Kpomg0h-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
head:   ba2e524d918ab72c0e5edc02354bd6cb43d005f8
commit: e6e268cb682290da29e3c8408493a4474307b8cc [6/13] ext4: move quota configuration out of handle_mount_opt()
config: m68k-randconfig-s032-20211210 (https://download.01.org/0day-ci/archive/20211210/202112101722.3Kpomg0h-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/commit/?id=e6e268cb682290da29e3c8408493a4474307b8cc
        git remote add tytso-ext4 https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
        git fetch --no-tags tytso-ext4 dev
        git checkout e6e268cb682290da29e3c8408493a4474307b8cc
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=m68k SHELL=/bin/bash fs/ext4/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/ext4/super.c:2689:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const * @@     got char [noderef] __rcu * @@
   fs/ext4/super.c:2689:51: sparse:     expected char const *
   fs/ext4/super.c:2689:51: sparse:     got char [noderef] __rcu *
>> fs/ext4/super.c:2657:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *objp @@     got char [noderef] __rcu * @@
   fs/ext4/super.c:2657:38: sparse:     expected void const *objp
   fs/ext4/super.c:2657:38: sparse:     got char [noderef] __rcu *

vim +2689 fs/ext4/super.c

  2642	
  2643	static void ext4_apply_quota_options(struct fs_context *fc,
  2644					     struct super_block *sb)
  2645	{
  2646	#ifdef CONFIG_QUOTA
  2647		struct ext4_fs_context *ctx = fc->fs_private;
  2648		struct ext4_sb_info *sbi = EXT4_SB(sb);
  2649		char *qname;
  2650		int i;
  2651	
  2652		for (i = 0; i < EXT4_MAXQUOTAS; i++) {
  2653			if (!(ctx->qname_spec & (1 << i)))
  2654				continue;
  2655			qname = ctx->s_qf_names[i]; /* May be NULL */
  2656			ctx->s_qf_names[i] = NULL;
> 2657			kfree(sbi->s_qf_names[i]);
  2658			rcu_assign_pointer(sbi->s_qf_names[i], qname);
  2659			set_opt(sb, QUOTA);
  2660		}
  2661	#endif
  2662	}
  2663	
  2664	/*
  2665	 * Check quota settings consistency.
  2666	 */
  2667	static int ext4_check_quota_consistency(struct fs_context *fc,
  2668						struct super_block *sb)
  2669	{
  2670	#ifdef CONFIG_QUOTA
  2671		struct ext4_fs_context *ctx = fc->fs_private;
  2672		struct ext4_sb_info *sbi = EXT4_SB(sb);
  2673		bool quota_feature = ext4_has_feature_quota(sb);
  2674		bool quota_loaded = sb_any_quota_loaded(sb);
  2675		int i;
  2676	
  2677		if (ctx->qname_spec && quota_loaded) {
  2678			if (quota_feature)
  2679				goto err_feature;
  2680	
  2681			for (i = 0; i < EXT4_MAXQUOTAS; i++) {
  2682				if (!(ctx->qname_spec & (1 << i)))
  2683					continue;
  2684	
  2685				if (!!sbi->s_qf_names[i] != !!ctx->s_qf_names[i])
  2686					goto err_jquota_change;
  2687	
  2688				if (sbi->s_qf_names[i] && ctx->s_qf_names[i] &&
> 2689				    strcmp(sbi->s_qf_names[i],
  2690					   ctx->s_qf_names[i]) != 0)
  2691					goto err_jquota_specified;
  2692			}
  2693		}
  2694	
  2695		if (ctx->s_jquota_fmt) {
  2696			if (sbi->s_jquota_fmt != ctx->s_jquota_fmt && quota_loaded)
  2697				goto err_quota_change;
  2698			if (quota_feature) {
  2699				ext4_msg(NULL, KERN_INFO, "Quota format mount options "
  2700					 "ignored when QUOTA feature is enabled");
  2701				return 0;
  2702			}
  2703		}
  2704		return 0;
  2705	
  2706	err_quota_change:
  2707		ext4_msg(NULL, KERN_ERR,
  2708			 "Cannot change quota options when quota turned on");
  2709		return -EINVAL;
  2710	err_jquota_change:
  2711		ext4_msg(NULL, KERN_ERR, "Cannot change journaled quota "
  2712			 "options when quota turned on");
  2713		return -EINVAL;
  2714	err_jquota_specified:
  2715		ext4_msg(NULL, KERN_ERR, "%s quota file already specified",
  2716			 QTYPE2NAME(i));
  2717		return -EINVAL;
  2718	err_feature:
  2719		ext4_msg(NULL, KERN_ERR, "Journaled quota options ignored "
  2720			 "when QUOTA feature is enabled");
  2721		return 0;
  2722	#else
  2723		return 0;
  2724	#endif
  2725	}
  2726	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
