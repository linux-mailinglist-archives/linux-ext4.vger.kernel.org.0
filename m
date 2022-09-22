Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE62A5E67FA
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Sep 2022 18:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiIVQBF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Sep 2022 12:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiIVQBD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 22 Sep 2022 12:01:03 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FC8FB336
        for <linux-ext4@vger.kernel.org>; Thu, 22 Sep 2022 09:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663862461; x=1695398461;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2Gr3DvoNOlrUGQb7B3Yyue3dMb7cPs6nRG7NoITIMT0=;
  b=O3HbHjX2YoZVyQisXaK1ZFyEZjJD4Vk2m63HEL5hMMnCwkIeBqVK3FPv
   w791cZbniu9+BVBxq2y+GS8lQ3Ucep3bgqyUs+rNAuHe5nn+10EizCF7L
   c23RIuMvubDfkjq167dBH9ZdSdKc2Cndg4JvSe4LjJ4R1A9+l+fxIoSzv
   UCTmmm/nSjdVI2ELhUKb43ezTQyKb8Bp5BcQpr7gGS0RsLcwnX9I/su7l
   YHGkjLmF0SEN0udKKZlfkxyXr6NFhg5az0gq2RDW5L3RUg1rxRRqgDNzr
   IfGAOz2fLzIAKjbljg/zP2blDC002I4vEyvwzsyq5ydhtLJ9EoeS+8IWw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="362110702"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="362110702"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 09:00:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="708929444"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Sep 2022 09:00:29 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obOcm-0004mY-1N;
        Thu, 22 Sep 2022 16:00:28 +0000
Date:   Fri, 23 Sep 2022 00:00:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 1a0bdad3d548dac44e406992e99dd4e9fd347f39
Message-ID: <632c8683.0yIZfnNwJM7ZSBKm%lkp@intel.com>
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
branch HEAD: 1a0bdad3d548dac44e406992e99dd4e9fd347f39  ext4: limit the number of retries after discarding preallocations blocks

elapsed time: 725m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                          randconfig-a001
i386                          randconfig-a003
um                           x86_64_defconfig
um                             i386_defconfig
i386                          randconfig-a005
i386                                defconfig
x86_64                        randconfig-a015
x86_64                              defconfig
x86_64                        randconfig-a013
arm                                 defconfig
x86_64                        randconfig-a011
arm64                            allyesconfig
arc                                 defconfig
arm                              allyesconfig
s390                             allmodconfig
arc                  randconfig-r043-20220921
x86_64                               rhel-8.3
i386                          randconfig-a014
riscv                randconfig-r042-20220921
alpha                               defconfig
s390                                defconfig
x86_64                           allyesconfig
i386                          randconfig-a012
i386                          randconfig-a016
s390                             allyesconfig
x86_64                        randconfig-a004
s390                 randconfig-r044-20220921
x86_64                        randconfig-a002
i386                             allyesconfig
m68k                             allmodconfig
x86_64                         rhel-8.3-kunit
arc                              allyesconfig
x86_64                        randconfig-a006
x86_64                          rhel-8.3-func
alpha                            allyesconfig
m68k                             allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
ia64                             allmodconfig
sh                               allmodconfig

clang tested configs:
i386                          randconfig-a004
i386                          randconfig-a002
x86_64                        randconfig-a014
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a006
i386                          randconfig-a015
x86_64                        randconfig-a016
i386                          randconfig-a011
hexagon              randconfig-r041-20220921
hexagon              randconfig-r045-20220921
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
