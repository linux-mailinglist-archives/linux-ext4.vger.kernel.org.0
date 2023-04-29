Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0E66F2414
	for <lists+linux-ext4@lfdr.de>; Sat, 29 Apr 2023 12:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjD2KEE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 29 Apr 2023 06:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjD2KEC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 29 Apr 2023 06:04:02 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9A2199F
        for <linux-ext4@vger.kernel.org>; Sat, 29 Apr 2023 03:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682762641; x=1714298641;
  h=date:from:to:cc:subject:message-id;
  bh=h9KhkNwZLECoOjXp+y/VLzOnhXWze6SUzHq2NARv0h0=;
  b=L8DvYUscbm+LSgsCNITLwhueAZG9UH41n70QZVcfhzgZbIBe2cUp3FJT
   TlKtwXVVW331JHXXaC2YghEVX2SYbyVl5rvSHLHVO0LH1nO3VvvHMF758
   OBL1CHNq3fbiKv+b4AiErXa+4mHx3kJrlwbVTCPpwNTGOjE6KwUKWmi8b
   lKFlAQqfLewdLpXT/jBlPhyWcD1Pc8HJQt88MP17gvpMzJgMLOMpZf6hb
   oCStExqvEoIXuG7VZ/ARSspOJD4oNc9wZS5EmlH1588aDWYWheoPHX+qw
   Thy43yjmEk9HV5R2dLkmNfGM3IFu+4UgNNyasDS96LxH4P0bsraVw07hG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="328266569"
X-IronPort-AV: E=Sophos;i="5.99,237,1677571200"; 
   d="scan'208";a="328266569"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2023 03:04:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="727881044"
X-IronPort-AV: E=Sophos;i="5.99,237,1677571200"; 
   d="scan'208";a="727881044"
Received: from lkp-server01.sh.intel.com (HELO 5bad9d2b7fcb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 29 Apr 2023 03:03:59 -0700
Received: from kbuild by 5bad9d2b7fcb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pshQs-000134-2j;
        Sat, 29 Apr 2023 10:03:58 +0000
Date:   Sat, 29 Apr 2023 18:03:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 d4fab7b28e2f5d74790d47a8d298da0abfb5132f
Message-ID: <20230429100313.67IoB%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: d4fab7b28e2f5d74790d47a8d298da0abfb5132f  ext4: clean up error handling in __ext4_fill_super()

elapsed time: 1007m

configs tested: 98
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230428   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230428   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230428   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r002-20230428   clang
arm64                randconfig-r031-20230428   clang
csky                                defconfig   gcc  
hexagon      buildonly-randconfig-r004-20230428   clang
hexagon              randconfig-r041-20230428   clang
hexagon              randconfig-r045-20230428   clang
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
ia64                 randconfig-r006-20230428   gcc  
ia64                 randconfig-r012-20230428   gcc  
ia64                 randconfig-r015-20230428   gcc  
ia64                 randconfig-r025-20230428   gcc  
ia64                 randconfig-r033-20230428   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r011-20230428   gcc  
loongarch            randconfig-r024-20230428   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r003-20230428   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r001-20230428   gcc  
m68k                 randconfig-r023-20230428   gcc  
microblaze           randconfig-r021-20230428   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r005-20230428   gcc  
nios2        buildonly-randconfig-r001-20230428   gcc  
nios2        buildonly-randconfig-r006-20230428   gcc  
nios2                               defconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230428   gcc  
parisc               randconfig-r014-20230428   gcc  
parisc               randconfig-r036-20230428   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r032-20230428   clang
riscv                randconfig-r042-20230428   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230428   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r026-20230428   gcc  
sparc                               defconfig   gcc  
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
xtensa       buildonly-randconfig-r005-20230428   gcc  
xtensa               randconfig-r013-20230428   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
