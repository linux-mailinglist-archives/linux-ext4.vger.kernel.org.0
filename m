Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB20473FD08
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Jun 2023 15:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjF0NnX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Jun 2023 09:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjF0NnQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Jun 2023 09:43:16 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0BC2D77
        for <linux-ext4@vger.kernel.org>; Tue, 27 Jun 2023 06:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687873393; x=1719409393;
  h=date:from:to:cc:subject:message-id;
  bh=Ym7Tc5GSeTTn9TSKrZSyUSFcArCoeeztZspvEgXMELg=;
  b=d/STEqAvsqQ+ljZXG2UXassCIuCdH0QnpBldDYQNaWaBm7ifW9tmYDYf
   MnonRzkY/T/f0qo9JvxuCC9AwWtLoI0ZQSLr44ol93tXOYZ8mXFU5kQ0b
   XOin3Ney/qJKtnD3vLB5pfk1t/4JkaQJwv9lny/ckWToeRWHFSWZernL3
   fwU9D1HgyRZC1Ylg7L5i+uGSXmKQLUQgCffjSY4+McfI3Ff7fesjXMw9q
   qI4lwqlXAt0Wag1U4/aI5A5B7WsPZconsT6FUR9DJ3LIfF1xVt/vwqRsj
   +AYuymHXzILmBSNLgp+Sg0Ql5mYjGow6wwat0nP558s1UvhqWSlyddrwa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="361611339"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="361611339"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 06:43:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="890695096"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="890695096"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 Jun 2023 06:43:07 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qE8yI-000Bws-2D;
        Tue, 27 Jun 2023 13:43:06 +0000
Date:   Tue, 27 Jun 2023 21:42:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 2ef6c32a914b85217b44a0a2418e830e520b085e
Message-ID: <202306272145.JIolDs02-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 2ef6c32a914b85217b44a0a2418e830e520b085e  ext4: avoid updating the superblock on a r/o mount if not needed

elapsed time: 722m

configs tested: 97
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230627   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r036-20230627   gcc  
arc                  randconfig-r043-20230627   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         bcm2835_defconfig   clang
arm                          collie_defconfig   clang
arm                                 defconfig   gcc  
arm                            hisi_defconfig   gcc  
arm                  randconfig-r046-20230627   gcc  
arm64                            alldefconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r022-20230627   gcc  
csky                 randconfig-r031-20230627   gcc  
hexagon              randconfig-r041-20230627   clang
hexagon              randconfig-r045-20230627   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i006-20230627   gcc  
i386                 randconfig-i016-20230627   clang
i386                 randconfig-r015-20230627   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r005-20230627   gcc  
loongarch            randconfig-r006-20230627   gcc  
loongarch            randconfig-r034-20230627   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                           xway_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r035-20230627   gcc  
openrisc             randconfig-r012-20230627   gcc  
openrisc             randconfig-r016-20230627   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r012-20230627   gcc  
parisc               randconfig-r021-20230627   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                 mpc8315_rdb_defconfig   clang
powerpc                      pasemi_defconfig   gcc  
powerpc              randconfig-r014-20230627   clang
powerpc              randconfig-r026-20230627   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r011-20230627   clang
riscv                randconfig-r042-20230627   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r033-20230627   gcc  
s390                 randconfig-r044-20230627   clang
sh                               allmodconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                          rsk7264_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r025-20230627   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r032-20230627   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r023-20230627   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r013-20230627   clang
x86_64               randconfig-x001-20230627   clang
x86_64               randconfig-x002-20230627   clang
x86_64               randconfig-x003-20230627   clang
x86_64               randconfig-x004-20230627   clang
x86_64               randconfig-x005-20230627   clang
x86_64               randconfig-x015-20230627   gcc  
x86_64               randconfig-x016-20230627   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r001-20230627   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
