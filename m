Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5365129E5EA
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Oct 2020 09:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbgJ2IMo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Oct 2020 04:12:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:23002 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726938AbgJ2IMn (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 29 Oct 2020 04:12:43 -0400
IronPort-SDR: jotmbA/m4sfi1YSR7vIgMiQeCFyB6KduJ3r23ap20dbA4zd3UicvvKZDMC81yWGenNB/8LkhUx
 Ehq4pwRYzvbg==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="165782273"
X-IronPort-AV: E=Sophos;i="5.77,428,1596524400"; 
   d="scan'208";a="165782273"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 20:08:34 -0700
IronPort-SDR: 1ld/fqoT7wPboIofs1lH7ldt9xNIyhR4CUUSjc4fp1bFGp7Xuurerzj1Ng1vfcPkzC09Cg51GE
 Zax+xTj2FPqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,428,1596524400"; 
   d="scan'208";a="468978502"
Received: from lkp-server02.sh.intel.com (HELO 72b1a4bebef6) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 28 Oct 2020 20:08:33 -0700
Received: from kbuild by 72b1a4bebef6 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kXyIi-000018-Hg; Thu, 29 Oct 2020 03:08:32 +0000
Date:   Thu, 29 Oct 2020 11:08:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS 00c69f98e83d3cdb8910e0d4d4c89fc41a3a05d1
Message-ID: <5f9a3218.X5mzvWNawMSoQlaU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git  dev
branch HEAD: 00c69f98e83d3cdb8910e0d4d4c89fc41a3a05d1  ext4: use IS_ERR() for error checking of path

elapsed time: 724m

configs tested: 170
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
openrisc                         alldefconfig
powerpc                 mpc8272_ads_defconfig
mips                        maltaup_defconfig
sh                           se7721_defconfig
arc                          axs103_defconfig
powerpc                    socrates_defconfig
powerpc64                           defconfig
arm                         nhk8815_defconfig
arm                          pxa3xx_defconfig
ia64                                defconfig
arm                          prima2_defconfig
ia64                        generic_defconfig
mips                          malta_defconfig
sh                          lboxre2_defconfig
alpha                            alldefconfig
sh                          r7780mp_defconfig
arm                            lart_defconfig
mips                      bmips_stb_defconfig
arm                        magician_defconfig
m68k                        mvme147_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                              zx_defconfig
c6x                         dsk6455_defconfig
parisc                generic-32bit_defconfig
powerpc                    gamecube_defconfig
arm                      integrator_defconfig
powerpc                     mpc5200_defconfig
powerpc                      chrp32_defconfig
arc                     haps_hs_smp_defconfig
m68k                       m5249evb_defconfig
arm                           tegra_defconfig
powerpc                 mpc834x_mds_defconfig
arm                     davinci_all_defconfig
mips                     loongson1b_defconfig
sh                           se7343_defconfig
mips                             allyesconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                      bamboo_defconfig
arm                      pxa255-idp_defconfig
xtensa                           alldefconfig
powerpc                     tqm8560_defconfig
s390                       zfcpdump_defconfig
powerpc                    ge_imp3a_defconfig
mips                      fuloong2e_defconfig
h8300                    h8300h-sim_defconfig
mips                          ath79_defconfig
powerpc                 mpc8315_rdb_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                        edosk7760_defconfig
sh                ecovec24-romimage_defconfig
riscv                            alldefconfig
powerpc                     asp8347_defconfig
powerpc                     mpc512x_defconfig
powerpc                      walnut_defconfig
mips                     decstation_defconfig
m68k                        m5407c3_defconfig
mips                            gpr_defconfig
mips                      malta_kvm_defconfig
powerpc                 mpc8560_ads_defconfig
arm                        multi_v5_defconfig
arm                         s5pv210_defconfig
arm                          tango4_defconfig
arm                          badge4_defconfig
powerpc                     tqm8540_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                malta_qemu_32r6_defconfig
sh                             espt_defconfig
arm                          ixp4xx_defconfig
um                            kunit_defconfig
m68k                          multi_defconfig
powerpc                    sam440ep_defconfig
sh                          urquell_defconfig
sh                          sdk7780_defconfig
powerpc                     pseries_defconfig
sh                              ul2_defconfig
arm                            zeus_defconfig
sh                          rsk7264_defconfig
powerpc                    klondike_defconfig
riscv                    nommu_virt_defconfig
ia64                      gensparse_defconfig
arm                          pxa168_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20201026
i386                 randconfig-a003-20201026
i386                 randconfig-a005-20201026
i386                 randconfig-a001-20201026
i386                 randconfig-a006-20201026
i386                 randconfig-a004-20201026
i386                 randconfig-a002-20201028
i386                 randconfig-a005-20201028
i386                 randconfig-a003-20201028
i386                 randconfig-a001-20201028
i386                 randconfig-a004-20201028
i386                 randconfig-a006-20201028
x86_64               randconfig-a011-20201028
x86_64               randconfig-a013-20201028
x86_64               randconfig-a016-20201028
x86_64               randconfig-a015-20201028
x86_64               randconfig-a012-20201028
x86_64               randconfig-a014-20201028
x86_64               randconfig-a011-20201026
x86_64               randconfig-a013-20201026
x86_64               randconfig-a016-20201026
x86_64               randconfig-a015-20201026
x86_64               randconfig-a012-20201026
x86_64               randconfig-a014-20201026
i386                 randconfig-a016-20201028
i386                 randconfig-a014-20201028
i386                 randconfig-a015-20201028
i386                 randconfig-a013-20201028
i386                 randconfig-a012-20201028
i386                 randconfig-a011-20201028
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20201028
x86_64               randconfig-a002-20201028
x86_64               randconfig-a003-20201028
x86_64               randconfig-a006-20201028
x86_64               randconfig-a005-20201028
x86_64               randconfig-a004-20201028
x86_64               randconfig-a001-20201026
x86_64               randconfig-a003-20201026
x86_64               randconfig-a002-20201026
x86_64               randconfig-a006-20201026
x86_64               randconfig-a004-20201026
x86_64               randconfig-a005-20201026

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
