Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D436FF780
	for <lists+linux-ext4@lfdr.de>; Thu, 11 May 2023 18:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238650AbjEKQgu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 May 2023 12:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238548AbjEKQgt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 May 2023 12:36:49 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CC4E51;
        Thu, 11 May 2023 09:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683823007; x=1715359007;
  h=date:from:to:cc:subject:message-id;
  bh=1WV/c8SxWyG5aYSongitVJNQQRVrDjLl2vUb+WM4Y0Y=;
  b=h57ZhMQLkSNq4rlfQnWUdVQpmGyxd5wGax9+1Vsa3LmJfB5bZ1vUEiGn
   ZFnRtpCqEd6QxBJ/XZESBfVHeV0eDsvEDWGwqsnIQUhFJlYo0aHsZY7AX
   pWKaRXTap5DH/BMFoWZd0BaUK2UwxFIUgz6YWyBCqlPKwTu51x7aYOvAf
   aWB2jztVyEfKvlHUIQOkFPRJKjbK9rJmWlPvZhX82ej4ZpegIcA4Q4WVs
   lVz7B9mxnqaA95BiqTY7t/HFRaFLvZF+8zaCaNOL+BXGCJFSu1stLWnQr
   4V9sR/wwToCbnNBBU6m6m9sv+59z7aS9rlGSGkAqx6Z1rNp12Cv8UOI4v
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="352788015"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="352788015"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 09:34:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="844034196"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="844034196"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 11 May 2023 09:34:56 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1px9Fn-00047j-2k;
        Thu, 11 May 2023 16:34:55 +0000
Date:   Fri, 12 May 2023 00:33:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-ext4@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [linux-next:master] BUILD SUCCESS WITH WARNING
 aabe491169befbe5481144acf575a0260939764a
Message-ID: <20230511163350.VcdPx%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: aabe491169befbe5481144acf575a0260939764a  Add linux-next specific files for 20230511

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202304140707.CoH337Ux-lkp@intel.com

Warning: (recently discovered and may have been fixed)

drivers/base/regmap/regcache-maple.c:113:23: warning: 'lower_index' is used uninitialized [-Wuninitialized]
drivers/base/regmap/regcache-maple.c:113:36: warning: 'lower_last' is used uninitialized [-Wuninitialized]
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:6395:21: warning: variable 'count' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:499:13: warning: variable 'j' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:48:38: warning: unused variable 'golden_settings_gc_9_4_3' [-Wunused-const-variable]

Unverified Warning (likely false positive, please contact us if interested):

drivers/gpu/drm/i915/display/intel_psr.c:2999:0-23: WARNING: i915_edp_psr_debug_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
fs/ext4/super.c:4724 ext4_check_feature_compatibility() warn: bitwise AND condition is false here
fs/ext4/verity.c:316 ext4_get_verity_descriptor_location() error: uninitialized symbol 'desc_size_disk'.

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- alpha-randconfig-m031-20230511
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- alpha-randconfig-s032-20230509
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- arc-allyesconfig
|   |-- drivers-base-regmap-regcache-maple.c:warning:lower_index-is-used-uninitialized
|   |-- drivers-base-regmap-regcache-maple.c:warning:lower_last-is-used-uninitialized
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- arc-randconfig-r043-20230511
|   |-- drivers-base-regmap-regcache-maple.c:warning:lower_index-is-used-uninitialized
|   |-- drivers-base-regmap-regcache-maple.c:warning:lower_last-is-used-uninitialized
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- arm-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- arm-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- arm64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- csky-randconfig-r021-20230511
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- csky-randconfig-r023-20230511
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- i386-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- ia64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- loongarch-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- loongarch-defconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- mips-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- mips-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- parisc-randconfig-m041-20230509
|   |-- fs-ext4-super.c-ext4_check_feature_compatibility()-warn:bitwise-AND-condition-is-false-here
|   `-- fs-ext4-verity.c-ext4_get_verity_descriptor_location()-error:uninitialized-symbol-desc_size_disk-.
|-- parisc-randconfig-r001-20230511
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- parisc-randconfig-r022-20230509
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- powerpc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- powerpc-buildonly-randconfig-r005-20230511
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- powerpc-randconfig-r022-20230511
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- powerpc-randconfig-s042-20230509
|   `-- drivers-spi-spi-fsl-cpm.c:sparse:sparse:incorrect-type-in-assignment-(different-base-types)-expected-unsigned-short-usertype-got-restricted-__le16
|-- riscv-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- s390-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- s390-randconfig-r026-20230511
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- s390-randconfig-r033-20230509
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- s390-randconfig-r044-20230511
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- sparc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- sparc64-randconfig-r032-20230509
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- x86_64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
`-- x86_64-randconfig-c002
    `-- drivers-gpu-drm-i915-display-intel_psr.c:WARNING:i915_edp_psr_debug_fops-should-be-defined-with-DEFINE_DEBUGFS_ATTRIBUTE
clang_recent_errors
|-- arm-randconfig-r001-20230509
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:unused-variable-golden_settings_gc_9_4_3
`-- riscv-randconfig-r042-20230509
    `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:unused-variable-golden_settings_gc_9_4_3

elapsed time: 739m

configs tested: 151
configs skipped: 10

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r006-20230510   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r001-20230511   gcc  
arc          buildonly-randconfig-r002-20230510   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r014-20230509   gcc  
arc                  randconfig-r043-20230509   gcc  
arc                  randconfig-r043-20230511   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                       imx_v4_v5_defconfig   clang
arm                  randconfig-r001-20230509   clang
arm                  randconfig-r002-20230509   clang
arm                  randconfig-r005-20230511   gcc  
arm                  randconfig-r024-20230509   gcc  
arm                  randconfig-r046-20230509   gcc  
arm                  randconfig-r046-20230511   clang
arm                         s3c6400_defconfig   gcc  
arm                       spear13xx_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky         buildonly-randconfig-r003-20230510   gcc  
csky         buildonly-randconfig-r006-20230511   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r021-20230511   gcc  
csky                 randconfig-r023-20230511   gcc  
hexagon      buildonly-randconfig-r003-20230511   clang
hexagon      buildonly-randconfig-r004-20230510   clang
hexagon      buildonly-randconfig-r004-20230511   clang
hexagon              randconfig-r005-20230509   clang
hexagon              randconfig-r011-20230511   clang
hexagon              randconfig-r015-20230511   clang
hexagon              randconfig-r031-20230509   clang
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
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r001-20230510   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r013-20230509   gcc  
loongarch            randconfig-r014-20230511   gcc  
loongarch            randconfig-r034-20230511   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                 randconfig-r012-20230511   gcc  
m68k                 randconfig-r021-20230509   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                     cu1000-neo_defconfig   clang
mips                           jazz_defconfig   gcc  
mips                 randconfig-r006-20230511   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r025-20230511   gcc  
nios2                randconfig-r026-20230509   gcc  
nios2                randconfig-r036-20230509   gcc  
openrisc                         alldefconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r033-20230511   gcc  
openrisc             randconfig-r035-20230511   gcc  
openrisc             randconfig-r036-20230511   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230511   gcc  
parisc               randconfig-r003-20230511   gcc  
parisc               randconfig-r022-20230509   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r005-20230511   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                    ge_imp3a_defconfig   clang
powerpc                       holly_defconfig   gcc  
powerpc                 mpc8313_rdb_defconfig   clang
powerpc              randconfig-r022-20230511   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_virt_defconfig   clang
riscv                randconfig-r034-20230509   gcc  
riscv                randconfig-r042-20230509   clang
riscv                randconfig-r042-20230511   gcc  
riscv                          rv32_defconfig   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r013-20230511   gcc  
s390                 randconfig-r026-20230511   gcc  
s390                 randconfig-r033-20230509   gcc  
s390                 randconfig-r044-20230509   clang
s390                 randconfig-r044-20230511   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r002-20230511   gcc  
sh                   randconfig-r004-20230509   gcc  
sh                   randconfig-r024-20230511   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7705_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230509   gcc  
sparc                randconfig-r015-20230509   gcc  
sparc                randconfig-r016-20230509   gcc  
sparc64              randconfig-r006-20230509   gcc  
sparc64              randconfig-r016-20230511   gcc  
sparc64              randconfig-r032-20230509   gcc  
sparc64              randconfig-r032-20230511   gcc  
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
x86_64                        randconfig-k001   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r005-20230510   gcc  
xtensa                              defconfig   gcc  
xtensa               randconfig-r035-20230509   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
