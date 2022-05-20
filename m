Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A15652E232
	for <lists+linux-ext4@lfdr.de>; Fri, 20 May 2022 03:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiETBxx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 May 2022 21:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiETBxw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 May 2022 21:53:52 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D061C9EC7
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 18:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653011631; x=1684547631;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=j0udE53k6IBRjBITFB9sFFjfQoF1NU0DNPoxEuGKWKc=;
  b=Eg24qWX4MhczfltmCbfKIiRDmCzXkVw19grmRB1KX7C4yToL/Zg7a8OT
   duG8r7Ra02MHv4dx8eS+NRPICVLkh2wUx5hlmG9ICjrzI5r+RFZ/4edAJ
   rlPkFKY4N//+gU93UMSFipIaliDN4Z8bMrgTWK+k5N5o4pCEhNmKtMxs0
   3hyJ+UnAqUNlN5comH8vxeYh9zch5BKAs9HrRQQfp7geOAdilMe8uA4Ed
   7caxva1yPVRrIVPpr+l20qx23X9YUvIS45blUxVxotMjxluRZVVth4XGi
   n/MT/z+xkiZ/HytQHOaNPLCqw19fgkOfFNObyOzqtXMXamJE8eauAapsH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="272577472"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="272577472"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 18:53:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="570545842"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 19 May 2022 18:53:49 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrrps-00049S-HG;
        Fri, 20 May 2022 01:53:48 +0000
Date:   Fri, 20 May 2022 09:53:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS WITH WARNING
 b76a7dd9a7437e8c21253ce3a7574bebde3827f9
Message-ID: <6286f485.ZNRL1yIcomyjZqHJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: b76a7dd9a7437e8c21253ce3a7574bebde3827f9  ext4: fix bug_on in __es_tree_search

Warning reports:

https://lore.kernel.org/llvm/202205200431.kzojEoNc-lkp@intel.com

Warning: (recently discovered and may have been fixed)

fs/ext4/super.c:2677:29: warning: unused variable 'sbi' [-Wunused-variable]
fs/ext4/super.c:2799:29: warning: unused variable 'sbi' [-Wunused-variable]

Warning ids grouped by kconfigs:

clang_recent_errors
|-- i386-randconfig-a004
|   `-- fs-ext4-super.c:warning:unused-variable-sbi
`-- i386-randconfig-a015
    `-- fs-ext4-super.c:warning:unused-variable-sbi

elapsed time: 726m

configs tested: 139
configs skipped: 4

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
m68k                           sun3_defconfig
mips                         bigsur_defconfig
xtensa                    smp_lx200_defconfig
powerpc                     mpc83xx_defconfig
arm                      footbridge_defconfig
s390                          debug_defconfig
xtensa                    xip_kc705_defconfig
openrisc                 simple_smp_defconfig
mips                           ci20_defconfig
xtensa                          iss_defconfig
s390                             allyesconfig
powerpc                      pcm030_defconfig
sh                   sh7770_generic_defconfig
h8300                    h8300h-sim_defconfig
sh                        sh7763rdp_defconfig
powerpc                     sequoia_defconfig
sh                         microdev_defconfig
riscv                            allyesconfig
arm                      jornada720_defconfig
powerpc64                           defconfig
mips                       capcella_defconfig
powerpc                 linkstation_defconfig
powerpc                        warp_defconfig
h8300                            allyesconfig
sh                          landisk_defconfig
sh                           se7343_defconfig
sh                            migor_defconfig
nios2                            alldefconfig
powerpc                      ep88xc_defconfig
h8300                       h8s-sim_defconfig
powerpc                 mpc834x_mds_defconfig
xtensa                         virt_defconfig
arm                        keystone_defconfig
xtensa                       common_defconfig
m68k                       m5208evb_defconfig
mips                  decstation_64_defconfig
m68k                       bvme6000_defconfig
m68k                          hp300_defconfig
mips                         mpc30x_defconfig
powerpc                     rainier_defconfig
sh                   secureedge5410_defconfig
arm                        realview_defconfig
sh                   rts7751r2dplus_defconfig
sh                          urquell_defconfig
sh                          sdk7786_defconfig
m68k                          sun3x_defconfig
sh                        sh7757lcr_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220519
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
sparc                               defconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
s390                 randconfig-c005-20220519
powerpc              randconfig-c003-20220519
x86_64                        randconfig-c007
riscv                randconfig-c006-20220519
mips                 randconfig-c004-20220519
i386                          randconfig-c001
arm                  randconfig-c002-20220519
powerpc                          g5_defconfig
hexagon                             defconfig
mips                     loongson2k_defconfig
riscv                          rv32_defconfig
powerpc                     akebono_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                     tqm8540_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                 mpc8272_ads_defconfig
arm                         palmz72_defconfig
mips                            e55_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220519
riscv                randconfig-r042-20220519
hexagon              randconfig-r041-20220519
s390                 randconfig-r044-20220519

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
