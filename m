Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFDB487D4D
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Jan 2022 20:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbiAGTtN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Jan 2022 14:49:13 -0500
Received: from mga01.intel.com ([192.55.52.88]:9573 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233528AbiAGTtM (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 7 Jan 2022 14:49:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641584952; x=1673120952;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=T4YKDaGwzh7oaLkHquZldPLSiKm9eHt8mUO7fcU8y5M=;
  b=hTXlCO0a+GPdPxf0rdCMJU7l1dB66c5ZxnlfdBudsfMD2tXqHIYcaSFZ
   PtcoMsKP4pfQQ66VHYmM7VYofJccOXYDspEs4oQvbgOn6MUYGuJ8Jk6Yg
   Qpt1QQi8ZXN2dJmCFOAUYzDzAkjBw37xsejMo/hYjh1VbGZkKVXufCZGD
   GWQRFKK55rmszKiBpDcWoEcXHWbiGxWINngmyvOAoCdPEasKxe4O+764t
   2obWFRZK1MTlHmdvQQnlCe8H6Drc7jm9fGEsUd1/18GsYI8n1HWAt0cct
   lgvptuTy3l8Fyazx9/QANOwNgWdE9WdgFV+v08njTuuLQnChmPZuv7NHK
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="267233948"
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="267233948"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 11:49:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="557363464"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 07 Jan 2022 11:49:10 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5vEb-000IzF-38; Fri, 07 Jan 2022 19:49:09 +0000
Date:   Sat, 08 Jan 2022 03:48:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 412aac1d161a0190996b37826e3a2f6757c39611
Message-ID: <61d89900.+3AtEs+ykSVdyaHd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 412aac1d161a0190996b37826e3a2f6757c39611  ext4: don't use the orphan list when migrating an inode

elapsed time: 1562m

configs tested: 107
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
arm64                               defconfig
i386                 randconfig-c001-20220107
um                           x86_64_defconfig
sh                        sh7785lcr_defconfig
powerpc                  iss476-smp_defconfig
mips                  maltasmvp_eva_defconfig
mips                           jazz_defconfig
arm                       aspeed_g5_defconfig
parisc                generic-64bit_defconfig
powerpc                 mpc837x_mds_defconfig
sparc64                          alldefconfig
arm                           h5000_defconfig
arm                          badge4_defconfig
sh                        dreamcast_defconfig
xtensa                    smp_lx200_defconfig
sh                          polaris_defconfig
m68k                       m5208evb_defconfig
m68k                          sun3x_defconfig
sh                            migor_defconfig
mips                         cobalt_defconfig
arm                  randconfig-c002-20220107
arm                  randconfig-c002-20220106
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
x86_64               randconfig-a005-20220107
x86_64               randconfig-a001-20220107
x86_64               randconfig-a006-20220107
x86_64               randconfig-a002-20220107
x86_64               randconfig-a004-20220107
x86_64               randconfig-a003-20220107
i386                 randconfig-a005-20220107
i386                 randconfig-a004-20220107
i386                 randconfig-a006-20220107
i386                 randconfig-a002-20220107
i386                 randconfig-a001-20220107
i386                 randconfig-a003-20220107
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
mips                 randconfig-c004-20220107
arm                  randconfig-c002-20220107
i386                 randconfig-c001-20220107
riscv                randconfig-c006-20220107
powerpc              randconfig-c003-20220107
x86_64               randconfig-c007-20220107
powerpc                     skiroot_defconfig
x86_64               randconfig-a012-20220107
x86_64               randconfig-a015-20220107
x86_64               randconfig-a014-20220107
x86_64               randconfig-a013-20220107
x86_64               randconfig-a011-20220107
x86_64               randconfig-a016-20220107
i386                 randconfig-a012-20220107
i386                 randconfig-a011-20220107
i386                 randconfig-a013-20220107
i386                 randconfig-a014-20220107
i386                 randconfig-a015-20220107
i386                 randconfig-a016-20220107
s390                 randconfig-r044-20220107
hexagon              randconfig-r041-20220107
hexagon              randconfig-r045-20220107
riscv                randconfig-r042-20220107

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
