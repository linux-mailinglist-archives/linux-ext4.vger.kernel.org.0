Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C26701856
	for <lists+linux-ext4@lfdr.de>; Sat, 13 May 2023 18:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjEMQyR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 13 May 2023 12:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjEMQyQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 13 May 2023 12:54:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CE430C6
        for <linux-ext4@vger.kernel.org>; Sat, 13 May 2023 09:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683996855; x=1715532855;
  h=date:from:to:cc:subject:message-id;
  bh=kSg70cwjeou811+5QWBsO/LustsfUcVFvvvvDzh/9aA=;
  b=YovunZJgpm3xZMKJLQQYbIRXri2weFfjkyw5BBFp3CEwJX571m/nGe//
   si8prJ4ApTqLkt01K/tax162RXAX9wNFyN0u/VM209xt1NLCWI4z8r6DT
   jY08VKc3bbCw+pd0I3dUxHPnBNnl/aBxesXPGPse/cNG05SE4q5GBuKJP
   280xYcrTReNBrb/xr7b3lFaUlcLiyK02v69g2A2hUfOQMZicY0cfUtUGR
   1gVGqhWGyHrPkE0D2/fHGtDymbizwF0YZddnNbij8l9PFH0POuG7QMb4M
   8GREy6R57fMF4X8RG+rInoLww0zVknH0s/jZCBixCDjSE9cJl5WgzPknZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="340306380"
X-IronPort-AV: E=Sophos;i="5.99,272,1677571200"; 
   d="scan'208";a="340306380"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 09:54:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="765480442"
X-IronPort-AV: E=Sophos;i="5.99,272,1677571200"; 
   d="scan'208";a="765480442"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 13 May 2023 09:54:14 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxsVZ-0005aY-1N;
        Sat, 13 May 2023 16:54:13 +0000
Date:   Sun, 14 May 2023 00:53:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 c34a0a724a5602769058d39da361b3b44c2c5990
Message-ID: <20230513165350.qu89N%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: c34a0a724a5602769058d39da361b3b44c2c5990  ext4: bail out of ext4_xattr_ibody_get() fails for any reason

elapsed time: 782m

configs tested: 146
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230513   gcc  
arc          buildonly-randconfig-r006-20230513   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230509   gcc  
arc                  randconfig-r043-20230511   gcc  
arc                  randconfig-r043-20230513   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         bcm2835_defconfig   clang
arm                                 defconfig   clang
arm                                 defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                  randconfig-r031-20230511   gcc  
arm                  randconfig-r033-20230509   clang
arm                  randconfig-r046-20230509   gcc  
arm                  randconfig-r046-20230511   clang
arm                  randconfig-r046-20230513   clang
arm                         s3c6400_defconfig   gcc  
arm                        spear6xx_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky         buildonly-randconfig-r002-20230511   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r004-20230511   gcc  
hexagon              randconfig-r021-20230511   clang
hexagon              randconfig-r023-20230511   clang
hexagon              randconfig-r026-20230511   clang
hexagon              randconfig-r034-20230511   clang
hexagon              randconfig-r036-20230509   clang
hexagon              randconfig-r041-20230509   clang
hexagon              randconfig-r041-20230511   clang
hexagon              randconfig-r041-20230513   clang
hexagon              randconfig-r045-20230509   clang
hexagon              randconfig-r045-20230511   clang
hexagon              randconfig-r045-20230513   clang
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
ia64                 randconfig-r013-20230511   gcc  
ia64                 randconfig-r035-20230511   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r005-20230511   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230509   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r003-20230511   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                 randconfig-r016-20230511   gcc  
m68k                 randconfig-r023-20230509   gcc  
m68k                 randconfig-r024-20230509   gcc  
m68k                 randconfig-r024-20230511   gcc  
m68k                 randconfig-r032-20230509   gcc  
microblaze           randconfig-r005-20230511   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                            ar7_defconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                 randconfig-r004-20230509   clang
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230509   gcc  
nios2                randconfig-r006-20230511   gcc  
nios2                randconfig-r033-20230511   gcc  
nios2                randconfig-r035-20230509   gcc  
openrisc     buildonly-randconfig-r001-20230511   gcc  
openrisc     buildonly-randconfig-r002-20230513   gcc  
openrisc             randconfig-r011-20230511   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc               randconfig-r012-20230511   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     asp8347_defconfig   gcc  
powerpc                   bluestone_defconfig   clang
powerpc      buildonly-randconfig-r005-20230513   gcc  
powerpc              randconfig-r003-20230511   clang
powerpc              randconfig-r034-20230509   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r001-20230513   gcc  
riscv        buildonly-randconfig-r004-20230511   gcc  
riscv        buildonly-randconfig-r004-20230513   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r021-20230509   clang
riscv                randconfig-r042-20230509   clang
riscv                randconfig-r042-20230511   gcc  
riscv                randconfig-r042-20230513   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r022-20230509   clang
s390                 randconfig-r032-20230511   clang
s390                 randconfig-r044-20230509   clang
s390                 randconfig-r044-20230511   gcc  
s390                 randconfig-r044-20230513   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r001-20230511   gcc  
sh                   randconfig-r025-20230511   gcc  
sh                           se7722_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r005-20230509   gcc  
sparc                randconfig-r014-20230511   gcc  
sparc                randconfig-r022-20230511   gcc  
sparc                randconfig-r026-20230509   gcc  
sparc                randconfig-r031-20230509   gcc  
sparc                       sparc64_defconfig   gcc  
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
xtensa               randconfig-r015-20230511   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
