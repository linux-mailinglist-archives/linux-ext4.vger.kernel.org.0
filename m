Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A0946FF3A
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Dec 2021 11:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240063AbhLJLBj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Dec 2021 06:01:39 -0500
Received: from mga14.intel.com ([192.55.52.115]:37306 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233200AbhLJLBi (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 10 Dec 2021 06:01:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639133884; x=1670669884;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=g+7leLgfaR0+07L/H+vu94VuXf4L31Ra8nniPK9SPis=;
  b=P/svcgDDZj14GyRjrs5R+MO+FABN+SsaxX0mMbyafM1AFQiS8xo9hxRi
   xbFnDm96mLVL43wnoAc3IkQ+3sDBH6mkMwMnkyR/geJsptDXTIHUcQKg1
   DBdwaSEjcbYpnRc9Y8vbRf+/S+MVmjnJTtDvFAmyIErxIktyhBfWpdull
   us0vmAnIGPUSkn6sBdWfAeAQxX5TkvrfvW8XDOUqbxq9k4sLngtIi1KzP
   mWLvhBXMGnKX+R89TRJNHQfycDMkwBG4NkQT38z9cQj50L62IOpRrcAZQ
   Z32/CSasmgnu9/3kSeMGX5xdeQi2FxhaoiAp6EsAHgJcMsxHpCSF7w5mq
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="238550338"
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="238550338"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 02:58:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="516717342"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 10 Dec 2021 02:58:02 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvdbF-000365-EM; Fri, 10 Dec 2021 10:58:01 +0000
Date:   Fri, 10 Dec 2021 18:57:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 ba2e524d918ab72c0e5edc02354bd6cb43d005f8
Message-ID: <61b33280.04UwtDZ7f5FE8jMs%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: ba2e524d918ab72c0e5edc02354bd6cb43d005f8  ext4: Remove unused match_table_t tokens

elapsed time: 723m

configs tested: 167
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
i386                 randconfig-c001-20211210
mips                 randconfig-c004-20211210
powerpc                      chrp32_defconfig
powerpc                     pq2fads_defconfig
powerpc                 mpc8272_ads_defconfig
arm                           u8500_defconfig
xtensa                  cadence_csp_defconfig
sh                          polaris_defconfig
arm                           corgi_defconfig
arm                         assabet_defconfig
sh                        sh7785lcr_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                      maltaaprp_defconfig
powerpc                    sam440ep_defconfig
powerpc                      tqm8xx_defconfig
m68k                        m5307c3_defconfig
arm                             mxs_defconfig
sh                        apsh4ad0a_defconfig
alpha                            allyesconfig
powerpc                 mpc834x_mds_defconfig
powerpc                     kilauea_defconfig
powerpc                      makalu_defconfig
sh                          lboxre2_defconfig
sh                         ap325rxa_defconfig
powerpc                   microwatt_defconfig
arm                      integrator_defconfig
arm                         orion5x_defconfig
x86_64                           alldefconfig
powerpc                      ppc6xx_defconfig
xtensa                  audio_kc705_defconfig
ia64                         bigsur_defconfig
sh                           se7712_defconfig
arm                             rpc_defconfig
sparc                       sparc32_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                    socrates_defconfig
nds32                             allnoconfig
powerpc                     redwood_defconfig
sh                          rsk7269_defconfig
arm                           sama5_defconfig
sh                        sh7763rdp_defconfig
powerpc                     rainier_defconfig
arm                            dove_defconfig
nds32                               defconfig
m68k                         apollo_defconfig
arm                     am200epdkit_defconfig
mips                         mpc30x_defconfig
powerpc                 canyonlands_defconfig
powerpc                      pcm030_defconfig
arm                        keystone_defconfig
xtensa                              defconfig
powerpc                     ppa8548_defconfig
mips                           ip28_defconfig
um                             i386_defconfig
h8300                            alldefconfig
m68k                        stmark2_defconfig
mips                        bcm63xx_defconfig
powerpc                  iss476-smp_defconfig
arm                             pxa_defconfig
m68k                        m5407c3_defconfig
powerpc                        warp_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                           tegra_defconfig
powerpc                 mpc836x_mds_defconfig
arm                     davinci_all_defconfig
powerpc                     taishan_defconfig
sh                             shx3_defconfig
sh                             espt_defconfig
xtensa                    smp_lx200_defconfig
arc                        nsim_700_defconfig
h8300                               defconfig
um                           x86_64_defconfig
arm                       spear13xx_defconfig
arm                          pxa168_defconfig
openrisc                 simple_smp_defconfig
powerpc                      ppc44x_defconfig
arm                  randconfig-c002-20211210
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
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
x86_64               randconfig-a006-20211210
x86_64               randconfig-a005-20211210
x86_64               randconfig-a001-20211210
x86_64               randconfig-a002-20211210
x86_64               randconfig-a003-20211210
x86_64               randconfig-a004-20211210
i386                 randconfig-a001-20211210
i386                 randconfig-a002-20211210
i386                 randconfig-a005-20211210
i386                 randconfig-a003-20211210
i386                 randconfig-a006-20211210
i386                 randconfig-a004-20211210
i386                 randconfig-a001-20211209
i386                 randconfig-a005-20211209
i386                 randconfig-a003-20211209
i386                 randconfig-a002-20211209
i386                 randconfig-a006-20211209
i386                 randconfig-a004-20211209
x86_64               randconfig-a006-20211209
x86_64               randconfig-a005-20211209
x86_64               randconfig-a001-20211209
x86_64               randconfig-a002-20211209
x86_64               randconfig-a004-20211209
x86_64               randconfig-a003-20211209
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20211210
x86_64               randconfig-a012-20211210
x86_64               randconfig-a014-20211210
x86_64               randconfig-a013-20211210
x86_64               randconfig-a016-20211210
x86_64               randconfig-a015-20211210
i386                 randconfig-a013-20211210
i386                 randconfig-a011-20211210
i386                 randconfig-a016-20211210
i386                 randconfig-a014-20211210
i386                 randconfig-a015-20211210
i386                 randconfig-a012-20211210
hexagon              randconfig-r045-20211210
riscv                randconfig-r042-20211210
s390                 randconfig-r044-20211210
hexagon              randconfig-r041-20211210

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
