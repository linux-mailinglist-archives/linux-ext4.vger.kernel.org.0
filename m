Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102BF4CC549
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Mar 2022 19:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiCCShy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Mar 2022 13:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiCCShy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Mar 2022 13:37:54 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2E8198ED4
        for <linux-ext4@vger.kernel.org>; Thu,  3 Mar 2022 10:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646332628; x=1677868628;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=6SjDncrqW7qxnTwAoP0Lo9Qkvoh6ajUoL7t+zdiYF2c=;
  b=NUafI+k5/g+wR4uXfRYIxG+k0nuf2WdXTI97HXZEILGB9i6zk0bwztjF
   Yr7ueuCvoEafIXD+BXWerFk4AUajldeDNlxBoPclhoea4RLld4oUYvDde
   kCO4WHLGYoPLsvFBbwqFYPU2ouTBF8kHQIsSsczM5fnmJAs1LoROTf30q
   QaqYvht9oSVFlp+lun3DCuddX9NjTjN5WhXqA7Nr0RAaPXgGMrF9DDPrN
   h27u1XCspMBr6pCQFiEtpgY6Am8tAQ2uPwLOYdY/hctRbtLLSW66+iQKH
   ELpcQNqn/5dEbMYSYZ2ioXOED9dQ/N87dLDOVRwELMnPd2G5DqPQk9NWr
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="316996507"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="316996507"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 10:37:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="642227450"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 03 Mar 2022 10:37:06 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPqK1-0000qC-QT; Thu, 03 Mar 2022 18:37:05 +0000
Date:   Fri, 04 Mar 2022 02:36:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 fe0aa5149f30e3803cdd60427cc8074504ebccba
Message-ID: <62210a9c.7P1CMZIVWuD409YW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: fe0aa5149f30e3803cdd60427cc8074504ebccba  ext4: don't BUG if someone dirty pages without asking ext4 first

elapsed time: 725m

configs tested: 133
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220303
arm                          iop32x_defconfig
x86_64                              defconfig
ia64                         bigsur_defconfig
h8300                    h8300h-sim_defconfig
microblaze                          defconfig
mips                         db1xxx_defconfig
sh                            shmin_defconfig
arm                          badge4_defconfig
m68k                             allyesconfig
h8300                     edosk2674_defconfig
powerpc                    amigaone_defconfig
mips                            ar7_defconfig
m68k                          sun3x_defconfig
arm                            mps2_defconfig
nios2                         10m50_defconfig
arc                        nsim_700_defconfig
arm                        cerfcube_defconfig
arc                            hsdk_defconfig
arm                         assabet_defconfig
sh                   sh7724_generic_defconfig
sparc                            allyesconfig
powerpc                     taishan_defconfig
m68k                        stmark2_defconfig
nios2                               defconfig
riscv             nommu_k210_sdcard_defconfig
mips                 decstation_r4k_defconfig
arm                         axm55xx_defconfig
xtensa                generic_kc705_defconfig
sh                          r7780mp_defconfig
nds32                            alldefconfig
arm                            qcom_defconfig
um                             i386_defconfig
sh                        sh7757lcr_defconfig
sh                          urquell_defconfig
arm                            lart_defconfig
arc                        nsimosci_defconfig
arm                           h3600_defconfig
arm                           sama5_defconfig
sparc                            alldefconfig
mips                            gpr_defconfig
powerpc                        warp_defconfig
m68k                            q40_defconfig
i386                                defconfig
h8300                               defconfig
sh                           se7705_defconfig
powerpc                       holly_defconfig
arm                        clps711x_defconfig
m68k                        m5407c3_defconfig
sh                           se7712_defconfig
m68k                          multi_defconfig
csky                                defconfig
riscv                               defconfig
arm                      jornada720_defconfig
arm                  randconfig-c002-20220302
arm                  randconfig-c002-20220303
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arc                  randconfig-r043-20220302
riscv                randconfig-r042-20220302
s390                 randconfig-r044-20220302
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220303
riscv                randconfig-c006-20220303
i386                          randconfig-c001
arm                  randconfig-c002-20220303
mips                 randconfig-c004-20220303
powerpc              randconfig-c003-20220302
riscv                randconfig-c006-20220302
arm                  randconfig-c002-20220302
mips                 randconfig-c004-20220302
mips                     loongson2k_defconfig
powerpc                       ebony_defconfig
i386                             allyesconfig
powerpc                      ppc64e_defconfig
mips                            e55_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220303
riscv                randconfig-r042-20220303
hexagon              randconfig-r041-20220303

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
