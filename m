Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2537A6FFA09
	for <lists+linux-ext4@lfdr.de>; Thu, 11 May 2023 21:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbjEKTW0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 May 2023 15:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjEKTWZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 May 2023 15:22:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765C86A76
        for <linux-ext4@vger.kernel.org>; Thu, 11 May 2023 12:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683832944; x=1715368944;
  h=date:from:to:cc:subject:message-id;
  bh=jhEr+dUSTPocGvCZOn1A0vmtZt195Ej8Kl/ULvXhuKo=;
  b=c7K55ZVFl/qDe3Rl0wxx5BVRjSLKK02jhAUxiDxrgvsq9jIaDwqimhEe
   +myYrsHKGqySkOKn1/GA1N9AJME1uhWMvcGhHCD2k5uSLMuHNh3J+IjwC
   2vF3ZlrpwaORBSncqHbVifLdq+OUJM9WIlChytyEJnJSoZHGn7K2m5ZrW
   R8zdna7pX6al9X46pc29NitsLW0jAv6zj3DtWJErETu6B2Gj5HXcwizlr
   tu0w1LtfFuo1SfMpHIw9HYdsjSDA/LhHG1auYa75fau1H8HUOWsUsfsyc
   Rx0/iQA23oogaNvArOKJXQQgUgbl+NhXJsBmoWn9PwNJdQVaYb5ihc3kL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="352843674"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="352843674"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 12:22:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="764886768"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="764886768"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 11 May 2023 12:22:21 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxBro-0004DA-2R;
        Thu, 11 May 2023 19:22:20 +0000
Date:   Fri, 12 May 2023 03:21:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 3b217639bd26db1fd627d5530d2612e043999762
Message-ID: <20230511192128.VRmpI%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 3b217639bd26db1fd627d5530d2612e043999762  ext4: fix deadlock when converting an inline directory in nojournal mode

elapsed time: 763m

configs tested: 135
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r006-20230510   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r006-20230511   gcc  
alpha                randconfig-r016-20230509   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r001-20230511   gcc  
arc          buildonly-randconfig-r002-20230510   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r005-20230509   gcc  
arc                  randconfig-r015-20230509   gcc  
arc                  randconfig-r032-20230509   gcc  
arc                  randconfig-r034-20230509   gcc  
arc                  randconfig-r043-20230509   gcc  
arc                  randconfig-r043-20230511   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230509   gcc  
arm                  randconfig-r046-20230511   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r013-20230509   clang
arm64                randconfig-r023-20230509   clang
csky         buildonly-randconfig-r003-20230510   gcc  
csky         buildonly-randconfig-r006-20230511   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r036-20230509   gcc  
hexagon      buildonly-randconfig-r003-20230511   clang
hexagon      buildonly-randconfig-r004-20230510   clang
hexagon      buildonly-randconfig-r004-20230511   clang
hexagon              randconfig-r002-20230511   clang
hexagon              randconfig-r003-20230509   clang
hexagon              randconfig-r004-20230509   clang
hexagon              randconfig-r016-20230511   clang
hexagon              randconfig-r041-20230509   clang
hexagon              randconfig-r041-20230511   clang
hexagon              randconfig-r045-20230509   clang
hexagon              randconfig-r045-20230511   clang
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
ia64                 randconfig-r003-20230511   gcc  
ia64                 randconfig-r034-20230511   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r001-20230510   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r024-20230511   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r011-20230509   gcc  
microblaze           randconfig-r001-20230511   gcc  
microblaze           randconfig-r006-20230509   gcc  
microblaze           randconfig-r021-20230509   gcc  
microblaze           randconfig-r033-20230509   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r024-20230509   gcc  
mips                 randconfig-r031-20230509   clang
mips                 randconfig-r035-20230509   clang
nios2                               defconfig   gcc  
nios2                randconfig-r012-20230509   gcc  
openrisc             randconfig-r002-20230509   gcc  
openrisc             randconfig-r013-20230511   gcc  
openrisc             randconfig-r022-20230511   gcc  
openrisc             randconfig-r025-20230511   gcc  
openrisc             randconfig-r033-20230511   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r005-20230511   gcc  
powerpc              randconfig-r023-20230511   gcc  
powerpc              randconfig-r026-20230511   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r035-20230511   clang
riscv                randconfig-r042-20230509   clang
riscv                randconfig-r042-20230511   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230511   clang
s390                 randconfig-r005-20230511   clang
s390                 randconfig-r014-20230509   clang
s390                 randconfig-r014-20230511   gcc  
s390                 randconfig-r031-20230511   clang
s390                 randconfig-r044-20230509   clang
s390                 randconfig-r044-20230511   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r011-20230511   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230509   gcc  
sparc                randconfig-r015-20230511   gcc  
sparc                randconfig-r021-20230511   gcc  
sparc                randconfig-r022-20230509   gcc  
sparc64              randconfig-r036-20230511   gcc  
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
xtensa       buildonly-randconfig-r005-20230510   gcc  
xtensa               randconfig-r012-20230511   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
