Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033C35F2200
	for <lists+linux-ext4@lfdr.de>; Sun,  2 Oct 2022 10:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJBITY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 2 Oct 2022 04:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJBITX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 2 Oct 2022 04:19:23 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB7C3F1EF
        for <linux-ext4@vger.kernel.org>; Sun,  2 Oct 2022 01:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664698762; x=1696234762;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=H9c/fS28AtFBFIA1ugW205KDzXEAWty4BCsijPT4/0Y=;
  b=ipViIjmxydjo3/6hXT7n45UG/8Q+06z0H9Xi/v09XOIF46OTPoj+EN9u
   G/udMlyJBjNFz9+shclYPqMdX0tkxmbID9rpWISEm4tvmNNt2PixIcQdk
   ivb8au5zS+bqsjMTrDK6gcTuz2JA1LqoMzDKQGrs/ZYumd+7ypy/m7rMD
   vxqoPeYsmjdYk1DEON+/PQSUkjpy0yxq5zCxlLIr6maYdQvlay5j6F1A2
   BPcW1Gt9tbMXRItOkDR0iT6djoPGpPH3t1Llej9yxkJ0Dageschi0iMP4
   i4C9MJTLhbXb/xxpMI9QqdNe4xp3KjOJacuA8OVKUjWDELBmntYoQvVig
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10487"; a="282827019"
X-IronPort-AV: E=Sophos;i="5.93,361,1654585200"; 
   d="scan'208";a="282827019"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2022 01:19:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10487"; a="574312379"
X-IronPort-AV: E=Sophos;i="5.93,361,1654585200"; 
   d="scan'208";a="574312379"
Received: from lkp-server01.sh.intel.com (HELO 14cc182da2d0) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 Oct 2022 01:19:21 -0700
Received: from kbuild by 14cc182da2d0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oeuC0-0003LK-1A;
        Sun, 02 Oct 2022 08:19:20 +0000
Date:   Sun, 02 Oct 2022 16:18:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 1b45cc5c7b920fd8bf72e5a888ec7abeadf41e09
Message-ID: <63394965.dV5aAQQAcbRFwiSO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 1b45cc5c7b920fd8bf72e5a888ec7abeadf41e09  ext4: fix potential out of bound read in ext4_fc_replay_scan()

elapsed time: 1680m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arm                                 defconfig
x86_64                              defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
x86_64                               rhel-8.3
s390                                defconfig
x86_64                          rhel-8.3-func
powerpc                           allnoconfig
x86_64                    rhel-8.3-kselftests
i386                                defconfig
s390                             allyesconfig
i386                 randconfig-a001-20220926
i386                 randconfig-a004-20220926
i386                 randconfig-a002-20220926
arm64                            allyesconfig
i386                 randconfig-a003-20220926
i386                 randconfig-a005-20220926
arm                              allyesconfig
x86_64                        randconfig-a004
x86_64                           allyesconfig
x86_64                           rhel-8.3-syz
sh                               allmodconfig
i386                 randconfig-a006-20220926
x86_64                         rhel-8.3-kunit
mips                             allyesconfig
x86_64                        randconfig-a002
powerpc                          allmodconfig
x86_64                           rhel-8.3-kvm
i386                             allyesconfig
arc                  randconfig-r043-20220926
x86_64                        randconfig-a006
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r045-20220926
x86_64               randconfig-a012-20220926
riscv                randconfig-r042-20220926
x86_64                        randconfig-a005
x86_64               randconfig-a014-20220926
x86_64               randconfig-a013-20220926
s390                 randconfig-r044-20220926
x86_64               randconfig-a011-20220926
hexagon              randconfig-r041-20220926
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64               randconfig-a016-20220926
x86_64               randconfig-a015-20220926
i386                 randconfig-a011-20220926
i386                 randconfig-a014-20220926
i386                 randconfig-a013-20220926
i386                 randconfig-a012-20220926
i386                 randconfig-a015-20220926
i386                 randconfig-a016-20220926

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
