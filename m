Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E9E6F998E
	for <lists+linux-ext4@lfdr.de>; Sun,  7 May 2023 17:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjEGP7i (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 7 May 2023 11:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEGP7h (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 7 May 2023 11:59:37 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C535611639
        for <linux-ext4@vger.kernel.org>; Sun,  7 May 2023 08:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683475176; x=1715011176;
  h=date:from:to:cc:subject:message-id;
  bh=MOVQW9LGKCiOObo5LRvTxjtuklwIOMhnEkV4LIl3PaI=;
  b=aqeSWRapcXFDP7PjR/6xup0A3BtUUOIlgcmOtyI1wf+saIyFZOI9i6CS
   kdgLO21Pm7fCcGardCiXz0AwvpwVhv6ABaqnxm4GAPR90hhk3LWKnaaHe
   sdT8bs2E3diY3d6WNtw5wvRlnCHS6p3jY5J9bl8PMKCQXHxbrn4ffsc14
   3p1S/j2sVd+8XJNLYCaHW2WOB/SxtO6AXDc0fiF/wvyUn+apB5Fp6qtmd
   FTyJoEEFfa80ohDZbsPvSs+1Nd4/pRRKSgt1HL7PyWt/hpmPaPHwhFiIe
   J/Sla5bzSLbTc9zSmmt7yn210qRV+paLHOtNTcy0RHzm+V/XqaGQ8TiWU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="351651358"
X-IronPort-AV: E=Sophos;i="5.99,257,1677571200"; 
   d="scan'208";a="351651358"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2023 08:59:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="767791764"
X-IronPort-AV: E=Sophos;i="5.99,257,1677571200"; 
   d="scan'208";a="767791764"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 07 May 2023 08:59:35 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pvgnO-0000mh-1W;
        Sun, 07 May 2023 15:59:34 +0000
Date:   Sun, 07 May 2023 23:59:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:tt/next] BUILD SUCCESS
 0e65babaeb6b5047c309a33e31f071b6fa7de305
Message-ID: <20230507155903.81Fnm%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tt/next
branch HEAD: 0e65babaeb6b5047c309a33e31f071b6fa7de305  ext4: fix deadlock when converting an inline directory in nojournal mode

elapsed time: 724m

configs tested: 117
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r006-20230507   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r014-20230507   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230507   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                     davinci_all_defconfig   clang
arm                                 defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                       multi_v4t_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                  randconfig-r011-20230507   gcc  
arm                  randconfig-r046-20230507   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230507   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r015-20230507   clang
csky         buildonly-randconfig-r005-20230507   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r004-20230507   gcc  
csky                 randconfig-r032-20230507   gcc  
hexagon              randconfig-r021-20230507   clang
hexagon              randconfig-r041-20230507   clang
hexagon              randconfig-r045-20230507   clang
i386                             alldefconfig   gcc  
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
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r036-20230507   gcc  
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r003-20230507   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r005-20230507   gcc  
loongarch            randconfig-r016-20230507   gcc  
loongarch            randconfig-r025-20230507   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r002-20230507   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r006-20230507   gcc  
microblaze           randconfig-r033-20230507   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                     loongson1c_defconfig   clang
mips                           mtx1_defconfig   clang
nios2                               defconfig   gcc  
nios2                randconfig-r022-20230507   gcc  
openrisc             randconfig-r026-20230507   gcc  
parisc       buildonly-randconfig-r004-20230507   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     asp8347_defconfig   gcc  
powerpc                 canyonlands_defconfig   gcc  
powerpc                   lite5200b_defconfig   clang
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc              randconfig-r002-20230507   gcc  
powerpc              randconfig-r003-20230507   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r001-20230507   gcc  
riscv                randconfig-r013-20230507   clang
riscv                randconfig-r042-20230507   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230507   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r034-20230507   gcc  
sh                          sdk7780_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r035-20230507   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r012-20230507   gcc  
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
xtensa               randconfig-r024-20230507   gcc  
xtensa               randconfig-r031-20230507   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
