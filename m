Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8180701CF0
	for <lists+linux-ext4@lfdr.de>; Sun, 14 May 2023 13:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjENLF1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 14 May 2023 07:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjENLF0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 14 May 2023 07:05:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD1AE5D
        for <linux-ext4@vger.kernel.org>; Sun, 14 May 2023 04:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684062325; x=1715598325;
  h=date:from:to:cc:subject:message-id;
  bh=KR5/kfzHTI1e1AaYHz+uAaiB5IzqN3FgIYzBoLQmkWg=;
  b=WPgT6LrvZKqt2hEtx/cQpGFyB/kHD1QJVcuvcycuI3FnqO14K8hxdcn2
   Ze/f7up7wNfceJd773aTQeges22osugNNWXD5wkI9oex/cbL9cJF7itDd
   LXGCB/m87tchn/0s+3pZz4WbhGxzT5fdHQyevmjrOXGmL6bysLNV+iULb
   Y8Xrypyvb89k9PrpsLiEROZeRMAndeg3RQVD657CY1wrJRg1Y/K1UBJsL
   emA5Ge3ReChLD19NVnIbNbTk+YnvPAR/cq/dZ0qUnQx8wASUJMAkQ0jVw
   gEMMCcr9WF1AmLfVoWimXy9VZLDIk//ou0seu8jD3pySj2ZbyEScjpFt/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="354183039"
X-IronPort-AV: E=Sophos;i="5.99,274,1677571200"; 
   d="scan'208";a="354183039"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 04:05:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="694727507"
X-IronPort-AV: E=Sophos;i="5.99,274,1677571200"; 
   d="scan'208";a="694727507"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 14 May 2023 04:05:23 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1py9XX-0005vV-0z;
        Sun, 14 May 2023 11:05:23 +0000
Date:   Sun, 14 May 2023 19:04:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 2a534e1d0d1591e951f9ece2fb460b2ff92edabd
Message-ID: <20230514110440.lg8X2%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 2a534e1d0d1591e951f9ece2fb460b2ff92edabd  ext4: bail out of ext4_xattr_ibody_get() fails for any reason

elapsed time: 747m

configs tested: 115
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r015-20230514   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230514   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230514   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                  randconfig-r006-20230514   clang
arm                  randconfig-r022-20230514   gcc  
arm                  randconfig-r046-20230514   gcc  
arm                        shmobile_defconfig   gcc  
arm                       spear13xx_defconfig   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r004-20230514   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
hexagon                          alldefconfig   clang
hexagon              randconfig-r021-20230514   clang
hexagon              randconfig-r041-20230514   clang
hexagon              randconfig-r045-20230514   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             alldefconfig   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r012-20230514   gcc  
ia64                 randconfig-r026-20230514   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                  cavium_octeon_defconfig   clang
mips                     decstation_defconfig   gcc  
nios2                         3c120_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r011-20230514   gcc  
openrisc     buildonly-randconfig-r006-20230514   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     kilauea_defconfig   clang
powerpc               mpc834x_itxgp_defconfig   clang
powerpc                      pcm030_defconfig   gcc  
powerpc              randconfig-r023-20230514   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r035-20230514   gcc  
riscv                randconfig-r042-20230514   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r001-20230514   clang
s390         buildonly-randconfig-r002-20230514   clang
s390                                defconfig   gcc  
s390                 randconfig-r044-20230514   clang
sh                               allmodconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                   randconfig-r002-20230514   gcc  
sh                   randconfig-r016-20230514   gcc  
sh                           se7722_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r014-20230514   gcc  
sparc                randconfig-r031-20230514   gcc  
sparc                randconfig-r034-20230514   gcc  
sparc64              randconfig-r025-20230514   gcc  
sparc64              randconfig-r033-20230514   gcc  
sparc64              randconfig-r036-20230514   gcc  
um                               alldefconfig   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                               rhel-8.3   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa               randconfig-r004-20230514   gcc  
xtensa               randconfig-r032-20230514   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
