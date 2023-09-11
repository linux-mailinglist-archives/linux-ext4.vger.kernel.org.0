Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E22B79B647
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Sep 2023 02:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbjIKVUi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Sep 2023 17:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242578AbjIKPvZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 11 Sep 2023 11:51:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6C9E6
        for <linux-ext4@vger.kernel.org>; Mon, 11 Sep 2023 08:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694447481; x=1725983481;
  h=date:from:to:cc:subject:message-id;
  bh=7xZ+nH/WbvYHFVkLXK2RXi3EI37Cy4AcwhINorZFyTc=;
  b=nNGjn19AraT3Dg4lbljCKJjR2C7YXZU0L2/TBMESDQxRorRoFq1jB2Ni
   aWRSxjdFsggczs+inE1lv8KZbul3UDbABPgVTmlgIcLOxLB+YFGe6Mj0k
   JOeHnJTqOcXvy7hFhXPB2w3ZcGkh1r+LD1bAjpePcB8H7FtaWhQTKzCT/
   TKapyfOhEnmCOXNobtygpwmNb6CvFFOUD6HDDImlFiKErZwzITcI8LQS4
   hHPDF94930k3hUYkh9OA+YugmtsE+rAHeSQiLeP4jwuyvfBwbjugImP4f
   L35fFe31IPgwZyeHJSikJDRB2ioVGAo3+pPwT7tRtrPRl9nSM/yJO/pqT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="358414487"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="358414487"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 08:51:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="990129107"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="990129107"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 11 Sep 2023 08:51:19 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qfjC1-0006Pq-1z;
        Mon, 11 Sep 2023 15:51:17 +0000
Date:   Mon, 11 Sep 2023 23:51:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 147d4a092e9a726ce706dbf0d329d2b96a025459
Message-ID: <202309112315.e4lGBu1R-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 147d4a092e9a726ce706dbf0d329d2b96a025459  jbd2: Remove page size assumptions

elapsed time: 720m

configs tested: 180
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230911   gcc  
alpha                randconfig-r013-20230911   gcc  
alpha                randconfig-r026-20230911   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20230911   gcc  
arc                  randconfig-r032-20230911   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                                 defconfig   gcc  
arm                            mps2_defconfig   gcc  
arm                   randconfig-001-20230911   gcc  
arm                  randconfig-r015-20230911   gcc  
arm                          sp7021_defconfig   clang
arm                           sunxi_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r014-20230911   gcc  
hexagon               randconfig-001-20230911   clang
hexagon               randconfig-002-20230911   clang
hexagon              randconfig-r023-20230911   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230911   gcc  
i386         buildonly-randconfig-002-20230911   gcc  
i386         buildonly-randconfig-003-20230911   gcc  
i386         buildonly-randconfig-004-20230911   gcc  
i386         buildonly-randconfig-005-20230911   gcc  
i386         buildonly-randconfig-006-20230911   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230911   gcc  
i386                  randconfig-002-20230911   gcc  
i386                  randconfig-003-20230911   gcc  
i386                  randconfig-004-20230911   gcc  
i386                  randconfig-005-20230911   gcc  
i386                  randconfig-006-20230911   gcc  
i386                  randconfig-011-20230911   clang
i386                  randconfig-012-20230911   clang
i386                  randconfig-013-20230911   clang
i386                  randconfig-014-20230911   clang
i386                  randconfig-015-20230911   clang
i386                  randconfig-016-20230911   clang
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230911   gcc  
loongarch            randconfig-r023-20230911   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r006-20230911   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                        qi_lb60_defconfig   clang
mips                 randconfig-r011-20230911   gcc  
mips                 randconfig-r036-20230911   clang
mips                   sb1250_swarm_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230911   gcc  
nios2                randconfig-r024-20230911   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r035-20230911   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r022-20230911   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                     tqm5200_defconfig   clang
powerpc64            randconfig-r005-20230911   gcc  
powerpc64            randconfig-r012-20230911   clang
powerpc64            randconfig-r016-20230911   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230911   gcc  
riscv                randconfig-r003-20230911   gcc  
riscv                randconfig-r005-20230911   gcc  
riscv                randconfig-r021-20230911   clang
riscv                randconfig-r033-20230911   gcc  
riscv                          rv32_defconfig   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230911   clang
s390                 randconfig-r002-20230911   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                            shmin_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r004-20230911   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230911   gcc  
x86_64       buildonly-randconfig-002-20230911   gcc  
x86_64       buildonly-randconfig-003-20230911   gcc  
x86_64       buildonly-randconfig-004-20230911   gcc  
x86_64       buildonly-randconfig-005-20230911   gcc  
x86_64       buildonly-randconfig-006-20230911   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230911   clang
x86_64                randconfig-002-20230911   clang
x86_64                randconfig-003-20230911   clang
x86_64                randconfig-004-20230911   clang
x86_64                randconfig-005-20230911   clang
x86_64                randconfig-006-20230911   clang
x86_64                randconfig-011-20230911   gcc  
x86_64                randconfig-012-20230911   gcc  
x86_64                randconfig-013-20230911   gcc  
x86_64                randconfig-014-20230911   gcc  
x86_64                randconfig-015-20230911   gcc  
x86_64                randconfig-016-20230911   gcc  
x86_64                randconfig-071-20230911   gcc  
x86_64                randconfig-072-20230911   gcc  
x86_64                randconfig-073-20230911   gcc  
x86_64                randconfig-074-20230911   gcc  
x86_64                randconfig-075-20230911   gcc  
x86_64                randconfig-076-20230911   gcc  
x86_64               randconfig-r003-20230911   gcc  
x86_64               randconfig-r006-20230911   gcc  
x86_64               randconfig-r031-20230911   gcc  
x86_64               randconfig-r034-20230911   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa               randconfig-r025-20230911   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
