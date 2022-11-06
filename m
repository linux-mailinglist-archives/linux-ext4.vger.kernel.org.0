Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA3461E54D
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Nov 2022 19:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiKFSab (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 6 Nov 2022 13:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiKFSaa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 6 Nov 2022 13:30:30 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16771FAFF
        for <linux-ext4@vger.kernel.org>; Sun,  6 Nov 2022 10:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667759430; x=1699295430;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=W6zJpyfGTeTbsSI23JhbeRKLIWHC7GSTQHFMwj7IqQo=;
  b=kTW4ZZB/9L8VkBHXu8pI2Fa1FEfSKYwDNKq+WHvD6NIRqzQ3Yw+Cnczj
   4TJrZp1Pdr9EkX5qF1Er5m8g6d6Fz3TWBcE5q0+FsIb7pwICS9Ro+KC7P
   gqdrlZ4+rgXkhZLtDZotgWxIjYoGCBW/V9cS1kMwMxGawJpyxqKl1v/bN
   pGbBshHvoUc+OjmVxNa8uy2C3YqaiVh+aQ0woApcpSTSqtQdXVCvg7N7R
   ZXeRIv1UyVEizVuVhDsQ/F7cPhkLowq7y+POa2ZPewHq7TCMKP04A5QaO
   vAU4JeeWSA3nizpVSmiSyP72EPzLNMaWJ6akUkngvh3Ok42I8mRzVd2KK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="293617556"
X-IronPort-AV: E=Sophos;i="5.96,142,1665471600"; 
   d="scan'208";a="293617556"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 10:30:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="586737520"
X-IronPort-AV: E=Sophos;i="5.96,142,1665471600"; 
   d="scan'208";a="586737520"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 06 Nov 2022 10:30:28 -0800
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1orkPb-000IyH-2W;
        Sun, 06 Nov 2022 18:30:27 +0000
Date:   Mon, 07 Nov 2022 02:29:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 0d043351e5baf3857f915367deba2a518b6a0809
Message-ID: <6367fd1d.E9RCEEmOMiu26j/9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 0d043351e5baf3857f915367deba2a518b6a0809  ext4: fix fortify warning in fs/ext4/fast_commit.c:1551

elapsed time: 725m

configs tested: 86
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
ia64                             allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                               rhel-8.3
x86_64                        randconfig-a002
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                        randconfig-a006
arc                  randconfig-r043-20221106
riscv                randconfig-r042-20221106
x86_64                        randconfig-a015
alpha                             allnoconfig
s390                 randconfig-r044-20221106
arc                               allnoconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                           allyesconfig
i386                          randconfig-a016
x86_64                          rhel-8.3-func
i386                          randconfig-a005
x86_64                    rhel-8.3-kselftests
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
arc                              allyesconfig
powerpc                           allnoconfig
x86_64                           rhel-8.3-kvm
alpha                            allyesconfig
sh                               allmodconfig
m68k                             allmodconfig
m68k                             allyesconfig
i386                                defconfig
arm                              allyesconfig
arm                                 defconfig
arm64                            allyesconfig
i386                             allyesconfig
arm                          simpad_defconfig
powerpc                   motionpro_defconfig
powerpc                 mpc8540_ads_defconfig
riscv                    nommu_k210_defconfig
s390                       zfcpdump_defconfig
sh                          sdk7786_defconfig
sh                   rts7751r2dplus_defconfig
mips                         cobalt_defconfig
xtensa                generic_kc705_defconfig
arm                         at91_dt_defconfig
m68k                        mvme16x_defconfig
sh                     sh7710voipgw_defconfig
i386                          randconfig-c001
arc                                 defconfig
alpha                               defconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
arc                        vdk_hs38_defconfig
arc                          axs101_defconfig
powerpc                        cell_defconfig
sh                            migor_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
hexagon              randconfig-r045-20221106
hexagon              randconfig-r041-20221106
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a015
powerpc                   bluestone_defconfig
arm                       netwinder_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                  mpc885_ads_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
