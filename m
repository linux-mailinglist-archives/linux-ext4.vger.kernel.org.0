Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E916456EB
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 10:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiLGJ4M (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 04:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiLGJ4K (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 04:56:10 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD7F391E8
        for <linux-ext4@vger.kernel.org>; Wed,  7 Dec 2022 01:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670406968; x=1701942968;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ZyfUz0OkYhAJ80lrRfbboud1pdAWuj+CpFEfWQErS4Q=;
  b=Jew9fI2Lfrru79jg7+G9KhaKQsh0Hag8L9WDP6PnqNZjYyOgISVFXIxU
   4adLJyoGM2AHqzfe1KD1/YTNL2GCV3Ro64CRaVU++nYUK4iTe24pAJI4Z
   kH/C77jrx2e68xUfZ6+ljECMfJRKZ8TRcO3uMkXHj3wKyFh06BR3GFqvw
   j+0Aorp74cAFFTUue+6ZAhCqFzqewqLy/23nJqDx+NS6laWu8Izyu81L2
   NVYlY/iiL+Qft8+79hrrDSo19/cc685rCx4UISXzxEKm6E4U6Je/QwZ6f
   iU33EbJSQPvS99b/7SyJg4kXUv5evSo2RFjCe+ja0wi8IchStbQsSCh5J
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="316866826"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="316866826"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 01:56:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="648674962"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="648674962"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 07 Dec 2022 01:56:01 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p2r9k-00009M-30;
        Wed, 07 Dec 2022 09:56:00 +0000
Date:   Wed, 07 Dec 2022 17:55:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 ad7ab3c3f740ce379e230d28c6aa8f9550182841
Message-ID: <63906318.UU8oG79+OUucd3+G%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: ad7ab3c3f740ce379e230d28c6aa8f9550182841  ext4: fix use-after-free in ext4_orphan_cleanup

elapsed time: 725m

configs tested: 61
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
um                           x86_64_defconfig
x86_64                           rhel-8.3-kvm
arc                               allnoconfig
alpha                             allnoconfig
i386                              allnoconfig
arm                               allnoconfig
x86_64                               rhel-8.3
i386                                defconfig
powerpc                           allnoconfig
arc                                 defconfig
x86_64                              defconfig
x86_64                        randconfig-a002
s390                             allmodconfig
alpha                               defconfig
ia64                             allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
arm                  randconfig-r046-20221206
s390                                defconfig
arc                  randconfig-r043-20221206
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                           allyesconfig
s390                             allyesconfig
x86_64                        randconfig-a011
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a015
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a016
x86_64                          rhel-8.3-func
x86_64                        randconfig-a013
sh                               allmodconfig
i386                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
hexagon              randconfig-r045-20221206
x86_64                        randconfig-a003
hexagon              randconfig-r041-20221206
i386                          randconfig-a013
riscv                randconfig-r042-20221206
s390                 randconfig-r044-20221206
x86_64                        randconfig-a016
i386                          randconfig-a011
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
