Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3135156C618
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Jul 2022 04:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiGICyW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Jul 2022 22:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGICyV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Jul 2022 22:54:21 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1782E32ED4
        for <linux-ext4@vger.kernel.org>; Fri,  8 Jul 2022 19:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657335261; x=1688871261;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=h34036lVbe6h7cZ1wbon7FssiYNw5QFE4EYX4RsU59c=;
  b=DPIXweciVs/IeK7My6aDDX+QLGfIY8GpVeB+xIsoNLunp0gP8P+P4IvW
   TAP4YnOzEh3WNqqGPubACi8js77ISGXbaw/NSvCIE0zw4KoSH3cSnAJcd
   Qa+rC8kJApodlYPFGk1SXgfVPi030u3yaep/EeIc9cnE0vGuKMpaSSVnu
   5nNVFscguTw0GZ2FlgaZrJ3csXBACknFiFm6GFV4PJZBkIH9UkxtFVgSp
   Bkc+jw4SwvuiDCF+nty3H7sqWukExIJhJ3cC1c0+p/ql8NDDr+qRxS1nq
   phAb1jq6ONgiBVHj5+JiKL1GGiNRQbojCS0cKLQ3eHNeWTrsGz+tGJmDA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="264180637"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="264180637"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 19:54:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="736533455"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 08 Jul 2022 19:54:19 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oA0br-000OEA-0K;
        Sat, 09 Jul 2022 02:54:19 +0000
Date:   Sat, 09 Jul 2022 10:53:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 f8dc286e4d942dab79d1814e0708ac91052a34fa
Message-ID: <62c8edaf.Hxl+dQGJdxL7Lbi1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: f8dc286e4d942dab79d1814e0708ac91052a34fa  jbd2: fix outstanding credits assert in jbd2_journal_commit_transaction()

elapsed time: 728m

configs tested: 91
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
sh                               j2_defconfig
powerpc                     sequoia_defconfig
arm                           h3600_defconfig
mips                         rt305x_defconfig
ia64                          tiger_defconfig
sh                          rsk7264_defconfig
sh                        edosk7705_defconfig
arm                           corgi_defconfig
powerpc                     ep8248e_defconfig
powerpc                 linkstation_defconfig
arm                         vf610m4_defconfig
sh                           se7619_defconfig
sh                           se7712_defconfig
sh                           se7721_defconfig
sh                           se7750_defconfig
alpha                            alldefconfig
arm                        clps711x_defconfig
arm                        oxnas_v6_defconfig
powerpc                        warp_defconfig
arm                            hisi_defconfig
powerpc                     taishan_defconfig
parisc64                            defconfig
nios2                            alldefconfig
mips                      maltasmvp_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220707
arc                  randconfig-r043-20220707
s390                 randconfig-r044-20220707
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                   sb1250_swarm_defconfig
arm                        mvebu_v5_defconfig
powerpc                      ppc64e_defconfig
hexagon                          alldefconfig
arm                   milbeaut_m10v_defconfig
powerpc                    gamecube_defconfig
arm                            dove_defconfig
powerpc                      walnut_defconfig
powerpc                          g5_defconfig
mips                       rbtx49xx_defconfig
arm                         palmz72_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220707
hexagon              randconfig-r041-20220707

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
