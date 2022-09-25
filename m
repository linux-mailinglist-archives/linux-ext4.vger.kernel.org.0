Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A195E9396
	for <lists+linux-ext4@lfdr.de>; Sun, 25 Sep 2022 16:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiIYOQ7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 25 Sep 2022 10:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiIYOQ6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 25 Sep 2022 10:16:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C697E0C
        for <linux-ext4@vger.kernel.org>; Sun, 25 Sep 2022 07:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664115417; x=1695651417;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=L9yGHdJlnXy0HyutgRJ4/fRuXITojrOp3ZJSJqkavPg=;
  b=jO+5xW4XTydLxk2M8P1EZdfXht25M31UGoll88vBwNLrzB7eqeCnhuDQ
   bxyNiM8DxDu7xLfsIZD2SlmpKBYUneN3Vql5BY5QyEzb7jN6mCEEqwGJ/
   Hmdk+limxOSKqETSbvKxFKQrgs9oW/3MyecU2gf+6lZ6S+EFvkPSXlLL8
   3Y1VjdVBb/4qRzbnvKTTXnKCRgCDOC/O3bylyjBljsZfa69/q9Qc+xp+D
   YX/121F6EARIZTJkrkzkeZNMJcPwL2unoayCx0LapZKoWQAm/VTm5DNXe
   nboHEa4NPRkt9oHNNr1/rY/MggxH8T43KeGc4JOQnUwdb3++yOkfK04NF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="387159140"
X-IronPort-AV: E=Sophos;i="5.93,344,1654585200"; 
   d="scan'208";a="387159140"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2022 07:16:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,344,1654585200"; 
   d="scan'208";a="949570950"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 25 Sep 2022 07:16:56 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ocSRD-000837-1v;
        Sun, 25 Sep 2022 14:16:55 +0000
Date:   Sun, 25 Sep 2022 22:16:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 80fa46d6b9e7b1527bfd2197d75431fd9c382161
Message-ID: <633062b1.h0eI97/HQAcNI6Kv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 80fa46d6b9e7b1527bfd2197d75431fd9c382161  ext4: limit the number of retries after discarding preallocations blocks

elapsed time: 723m

configs tested: 112
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                              defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                               rhel-8.3
arm                                 defconfig
x86_64                           allyesconfig
i386                          randconfig-a014
arc                                 defconfig
arc                  randconfig-r043-20220925
powerpc                           allnoconfig
s390                             allmodconfig
i386                          randconfig-a012
i386                                defconfig
riscv                randconfig-r042-20220925
i386                          randconfig-a016
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
m68k                             allmodconfig
s390                 randconfig-r044-20220925
x86_64                        randconfig-a002
arc                              allyesconfig
x86_64                          rhel-8.3-func
alpha                            allyesconfig
m68k                             allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a006
i386                          randconfig-a001
arm                              allyesconfig
alpha                               defconfig
s390                             allyesconfig
s390                                defconfig
x86_64                        randconfig-a011
arm64                            allyesconfig
x86_64                        randconfig-a004
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
i386                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220925
i386                          randconfig-c001
arc                              alldefconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                      chrp32_defconfig
mips                    maltaup_xpa_defconfig
mips                           ci20_defconfig
m68k                       m5275evb_defconfig
arm                           corgi_defconfig
x86_64                           alldefconfig
m68k                        stmark2_defconfig
xtensa                  audio_kc705_defconfig
sh                           se7206_defconfig
sh                        apsh4ad0a_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
sh                        sh7763rdp_defconfig
powerpc                    adder875_defconfig
nios2                            allyesconfig
mips                  maltasmvp_eva_defconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
arm                           stm32_defconfig
sparc                       sparc64_defconfig
mips                     loongson1b_defconfig
arm                          pxa910_defconfig
nios2                            alldefconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
arm64                               defconfig
ia64                             allyesconfig
arm                              allmodconfig
m68k                                defconfig
ia64                                defconfig
mips                             allmodconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
hexagon              randconfig-r045-20220925
i386                          randconfig-a015
hexagon              randconfig-r041-20220925
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-k001
arm                   milbeaut_m10v_defconfig
mips                malta_qemu_32r6_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
