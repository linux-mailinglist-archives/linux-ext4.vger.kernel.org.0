Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACA258622B
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Aug 2022 03:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbiHABUI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 31 Jul 2022 21:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiHABUH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 31 Jul 2022 21:20:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61497DEB3
        for <linux-ext4@vger.kernel.org>; Sun, 31 Jul 2022 18:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659316806; x=1690852806;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=gHkuu++NAnbB111PoO2MdrNE3Nq2B9BFkqXlW71qDj8=;
  b=EEKv4jN75oMXGFIqE1VrA/O8E22P/z74bh+TcWvc1sWK1VZh3EuCwFJL
   56ZqT9NCYgOsph1vvwWpKpRPEI67o/gpyKKz9uJhwV018LMYibWXSTse0
   xXRdplAtW/qyyUo62Y0Rgdbsj3Ba6UnuwLcgDIYDYOc6AYKx1mwFOz2YD
   pmEFlVJhM5hnjrGKisBRIf8U8bVdUecnNMGuAAY9hckpEwZv5pkbzLmGk
   jQGCH5IZVyxN/qPBnVrKzL2iUGNxNnvwWBdFvUvlc3QECInbz8kTnkr5I
   yV2qw+ed4LjMfoA27r6hbZwrDBSB62Y2ACag5F1djhPj0ZX+MFyHN/9du
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="275940193"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="275940193"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 18:20:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="577603069"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 31 Jul 2022 18:20:04 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIK6G-000EgB-0V;
        Mon, 01 Aug 2022 01:20:04 +0000
Date:   Mon, 01 Aug 2022 09:19:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 2cdc09d757bf2cefe5de132076eb5d0a8e8df384
Message-ID: <62e72a0b.jdTPzArf/YyS31dg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 2cdc09d757bf2cefe5de132076eb5d0a8e8df384  ext4: add ioctls to get/set the ext4 superblock uuid

elapsed time: 719m

configs tested: 128
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                                defconfig
x86_64                              defconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
arc                  randconfig-r043-20220731
x86_64                        randconfig-a013
powerpc                           allnoconfig
powerpc                          allmodconfig
m68k                             allyesconfig
mips                             allyesconfig
x86_64                        randconfig-a004
x86_64                               rhel-8.3
x86_64                        randconfig-a002
m68k                             allmodconfig
sh                               allmodconfig
riscv                randconfig-r042-20220731
x86_64                        randconfig-a011
s390                 randconfig-r044-20220731
x86_64                           allyesconfig
i386                             allyesconfig
x86_64                        randconfig-a006
i386                          randconfig-a014
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a001
i386                          randconfig-a003
arm                                 defconfig
powerpc                      pcm030_defconfig
arm                        realview_defconfig
arc                         haps_hs_defconfig
arm                              allyesconfig
i386                          randconfig-a005
arc                               allnoconfig
arm64                            allyesconfig
alpha                             allnoconfig
csky                              allnoconfig
riscv                             allnoconfig
arm                            zeus_defconfig
xtensa                generic_kc705_defconfig
ia64                             allmodconfig
i386                          randconfig-c001
arm                        trizeps4_defconfig
m68k                       m5249evb_defconfig
powerpc                       eiger_defconfig
sh                        sh7763rdp_defconfig
powerpc                      makalu_defconfig
arc                        nsimosci_defconfig
parisc                generic-64bit_defconfig
arm                          pxa910_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
powerpc                     ep8248e_defconfig
arm                      footbridge_defconfig
arm                        mvebu_v7_defconfig
xtensa                  cadence_csp_defconfig
powerpc                      chrp32_defconfig
parisc64                         alldefconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                          simpad_defconfig
arm                          iop32x_defconfig
powerpc                    amigaone_defconfig
powerpc                      mgcoge_defconfig
arm                           h3600_defconfig
mips                       bmips_be_defconfig
m68k                         apollo_defconfig
arm                        multi_v7_defconfig
sh                          rsk7264_defconfig
sh                        sh7757lcr_defconfig
mips                 randconfig-c004-20220731
arm                         lubbock_defconfig
powerpc                 mpc834x_itx_defconfig
sparc                               defconfig
sh                          r7780mp_defconfig
sparc                            allyesconfig
xtensa                          iss_defconfig
m68k                            q40_defconfig
powerpc                  iss476-smp_defconfig
sh                          rsk7269_defconfig
ia64                                defconfig
mips                        vocore2_defconfig
i386                 randconfig-a016-20220801
i386                 randconfig-a013-20220801
i386                 randconfig-a015-20220801
i386                 randconfig-a012-20220801
i386                 randconfig-a011-20220801
i386                 randconfig-a014-20220801
s390                 randconfig-r044-20220801
arc                  randconfig-r043-20220801
riscv                randconfig-r042-20220801

clang tested configs:
hexagon              randconfig-r041-20220731
hexagon              randconfig-r045-20220731
x86_64                        randconfig-a005
x86_64                        randconfig-a001
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a003
i386                          randconfig-a011
x86_64                        randconfig-a014
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-k001
x86_64               randconfig-a002-20220801
x86_64               randconfig-a001-20220801
x86_64               randconfig-a006-20220801
x86_64               randconfig-a003-20220801
x86_64               randconfig-a004-20220801
x86_64               randconfig-a005-20220801
mips                     loongson1c_defconfig
powerpc                     kmeter1_defconfig
hexagon                             defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
