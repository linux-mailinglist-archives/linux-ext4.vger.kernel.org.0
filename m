Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5ACE4DB50E
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Mar 2022 16:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348244AbiCPPkU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Mar 2022 11:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353704AbiCPPkT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Mar 2022 11:40:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3605434B8E
        for <linux-ext4@vger.kernel.org>; Wed, 16 Mar 2022 08:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647445145; x=1678981145;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=CTzVZSQ0dQct9YEQXL6QIlR0JmaYLXh/RLvmUao8OsU=;
  b=EOJ/6nXE246hPOxXID4f+ZfdPh7wKYjybxp9/14uBzBDNX5YzsjGcvUa
   NbwiV9dPdp/+lyk6MczoUZ43qoWuYP3mwgA0YvQGHCA7SG/kDp7nakge+
   RR2QzSPZDE04Knh4/OzFKcTSU2bx1Dzraws1hCO7cWR1UtUCj94BA2e7N
   8e+L+O7t2IG0gPClPqG27genSCYFPPitZ6kPK0Au38Af7rHBVPE5v4Q89
   C7Bzedf+5DQ+0Ge+tRTHWNiuj8z/Qnw3uQisoAukHa8EHzrRQ0KrZW3XW
   uyrkvlH3380pZ5+GYupmzNvZckzwsquk/jPhj7ZaM/Dxk8gM/u2uj7xnL
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="244088262"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="244088262"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 08:39:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="498487636"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 16 Mar 2022 08:39:00 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUVjn-000CZH-E6; Wed, 16 Mar 2022 15:38:59 +0000
Date:   Wed, 16 Mar 2022 23:38:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 919adbfec29d5b89b3e45620653cbeeb0d42e6fd
Message-ID: <62320474.yjPAD8u2Z8yyp0kM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 919adbfec29d5b89b3e45620653cbeeb0d42e6fd  ext4: fix kernel doc warnings

elapsed time: 751m

configs tested: 168
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
i386                 randconfig-c001-20220314
powerpc                 mpc834x_itx_defconfig
arm                     eseries_pxa_defconfig
arm                      footbridge_defconfig
mips                        vocore2_defconfig
arm                             pxa_defconfig
x86_64                              defconfig
sh                             espt_defconfig
powerpc64                        alldefconfig
powerpc64                           defconfig
mips                  decstation_64_defconfig
sh                         apsh4a3a_defconfig
sh                           se7780_defconfig
sh                          landisk_defconfig
powerpc                    amigaone_defconfig
h8300                            alldefconfig
sh                          rsk7201_defconfig
s390                          debug_defconfig
arm                         lubbock_defconfig
powerpc                 canyonlands_defconfig
xtensa                  cadence_csp_defconfig
ia64                      gensparse_defconfig
sh                        sh7785lcr_defconfig
arm                        oxnas_v6_defconfig
powerpc                     tqm8541_defconfig
m68k                        mvme16x_defconfig
mips                        bcm47xx_defconfig
powerpc                     tqm8548_defconfig
arm                         axm55xx_defconfig
powerpc                      pcm030_defconfig
arm                        shmobile_defconfig
arm                          pxa910_defconfig
arm                         at91_dt_defconfig
powerpc                      arches_defconfig
powerpc                     mpc83xx_defconfig
m68k                           sun3_defconfig
m68k                        m5272c3_defconfig
sparc                            alldefconfig
openrisc                 simple_smp_defconfig
nios2                         3c120_defconfig
sh                          polaris_defconfig
arm                        realview_defconfig
sh                        edosk7760_defconfig
arm                         assabet_defconfig
xtensa                          iss_defconfig
arm                          badge4_defconfig
powerpc                     pq2fads_defconfig
sh                        sh7763rdp_defconfig
sh                     sh7710voipgw_defconfig
mips                           ci20_defconfig
arm                  randconfig-c002-20220313
arm                  randconfig-c002-20220314
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20220314
x86_64               randconfig-a005-20220314
x86_64               randconfig-a003-20220314
x86_64               randconfig-a002-20220314
x86_64               randconfig-a006-20220314
x86_64               randconfig-a001-20220314
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
i386                 randconfig-a003-20220314
i386                 randconfig-a004-20220314
i386                 randconfig-a001-20220314
i386                 randconfig-a006-20220314
i386                 randconfig-a002-20220314
i386                 randconfig-a005-20220314
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
arc                  randconfig-r043-20220313
riscv                randconfig-r042-20220313
s390                 randconfig-r044-20220313
arc                  randconfig-r043-20220314
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220313
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220313
riscv                randconfig-c006-20220313
mips                 randconfig-c004-20220313
i386                          randconfig-c001
arm                         palmz72_defconfig
powerpc                     pseries_defconfig
powerpc                          g5_defconfig
powerpc                     skiroot_defconfig
powerpc                 mpc8560_ads_defconfig
hexagon                          alldefconfig
arm                        neponset_defconfig
riscv                          rv32_defconfig
mips                        omega2p_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a014-20220314
x86_64               randconfig-a015-20220314
x86_64               randconfig-a016-20220314
x86_64               randconfig-a012-20220314
x86_64               randconfig-a013-20220314
x86_64               randconfig-a011-20220314
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
i386                 randconfig-a012-20220314
i386                 randconfig-a011-20220314
i386                 randconfig-a013-20220314
i386                 randconfig-a014-20220314
i386                 randconfig-a015-20220314
i386                 randconfig-a016-20220314
hexagon              randconfig-r045-20220313
hexagon              randconfig-r041-20220313

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
