Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9055EBB74
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Sep 2022 09:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiI0H2c (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Sep 2022 03:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiI0H2b (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Sep 2022 03:28:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5187F5AA0C
        for <linux-ext4@vger.kernel.org>; Tue, 27 Sep 2022 00:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664263710; x=1695799710;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=MeXacMMAL/J+IZWqRmCgrQThGmBI+O37SQuYisT1d18=;
  b=Vbwt5J1pC/cNoiWsmWHwEpDjbDzKgYTtFP7TTD2LYehqpASeZX6LLFrk
   Al84H8D8yRwNkByVHIga2yqNconFRl+9M17AyMRYvb0WCBq4r9/roXQky
   c1SrWNjmEiqNKfE/9TLC2/kSUWGE3c8bUEIdqLcaBqLk0Bv+5EQo2yL/o
   4M48o9m0KzM2GTZM0bUl0MLpsaNiB2V/Gm1dQsnWuuRN5TY4+X7GP6DO2
   qwTkR+VkhE0bL0bSt9jXZx8EkCzdvpilr2c+ocwoKSaWkESv7VN2TuRG1
   4b6hGEeSLktIylYJizjPC+BmMvBKvV8q905f16mndgOdzFgyItbQ2zTry
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="280966976"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="280966976"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 00:28:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="866468577"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="866468577"
Received: from lkp-server02.sh.intel.com (HELO dfa2c9fcd321) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 27 Sep 2022 00:28:29 -0700
Received: from kbuild by dfa2c9fcd321 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1od512-0000le-1J;
        Tue, 27 Sep 2022 07:28:28 +0000
Date:   Tue, 27 Sep 2022 15:27:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 a078dff870136090b5779ca2831870a6c5539d36
Message-ID: <6332a5f8.KX9A1zG1mDAcDNoI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: a078dff870136090b5779ca2831870a6c5539d36  ext4: fixup possible uninitialized variable access in ext4_mb_choose_next_group_cr1()

elapsed time: 724m

configs tested: 85
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
s390                                defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
s390                             allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
x86_64                              defconfig
s390                             allyesconfig
i386                                defconfig
x86_64                               rhel-8.3
i386                 randconfig-a001-20220926
i386                 randconfig-a002-20220926
i386                 randconfig-a003-20220926
i386                 randconfig-a006-20220926
m68k                             allyesconfig
i386                 randconfig-a004-20220926
i386                 randconfig-a005-20220926
m68k                             allmodconfig
arm                                 defconfig
x86_64               randconfig-a002-20220926
x86_64               randconfig-a001-20220926
arc                  randconfig-r043-20220925
x86_64               randconfig-a003-20220926
riscv                randconfig-r042-20220925
arc                  randconfig-r043-20220926
s390                 randconfig-r044-20220925
x86_64               randconfig-a004-20220926
arm64                            allyesconfig
x86_64                           allyesconfig
arm                              allyesconfig
x86_64               randconfig-a005-20220926
i386                             allyesconfig
x86_64               randconfig-a006-20220926
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
sh                   secureedge5410_defconfig
arm                          gemini_defconfig
powerpc                      tqm8xx_defconfig
m68k                        m5307c3_defconfig
powerpc                      cm5200_defconfig
i386                          randconfig-c001
powerpc                       eiger_defconfig
mips                  decstation_64_defconfig
sh                      rts7751r2d1_defconfig
sh                               alldefconfig
sh                           se7724_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
i386                 randconfig-a011-20220926
i386                 randconfig-a013-20220926
i386                 randconfig-a012-20220926
i386                 randconfig-a016-20220926
hexagon              randconfig-r045-20220925
i386                 randconfig-a015-20220926
hexagon              randconfig-r041-20220926
i386                 randconfig-a014-20220926
hexagon              randconfig-r045-20220926
hexagon              randconfig-r041-20220925
riscv                randconfig-r042-20220926
s390                 randconfig-r044-20220926
x86_64               randconfig-a012-20220926
x86_64               randconfig-a013-20220926
x86_64               randconfig-a011-20220926
x86_64               randconfig-a016-20220926
x86_64               randconfig-a015-20220926
x86_64               randconfig-a014-20220926
x86_64                        randconfig-k001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
