Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D3063D017
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Nov 2022 09:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbiK3IEA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Nov 2022 03:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbiK3ID5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Nov 2022 03:03:57 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE22A654EE
        for <linux-ext4@vger.kernel.org>; Wed, 30 Nov 2022 00:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669795433; x=1701331433;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=7VzoOZTCd+fESVJC+Uq60L/lDqHpGuvWkHOISLu9nsw=;
  b=g0Oi9oxGc2d00BWjA9pFUGDca55C62OS+yPLXslXCNlGkTVAS15CY+fh
   SLP7j1G2hL7g3M5Krp4fGegcs3UZeaIqeYVJuSVIxPpDS2MWCjw4tezzj
   Zao7GFUm6VIflWNmhBcXLZOvXNC1hakNccc/EiKJQSdJesHpJefFi+rYl
   aFjlpjVcpTAT4UjAugVZ9kLbWvU/+AfiJztkIcasZ2XKbdCoLoVoHnFlp
   +sBHyvNFBSshjHmy4sBEltDAqEIEOYvYQMX/B++pnae7fUF4RX5XFfXzV
   deSZ4aWKmXkn35v0HVxTXgUM9X0gtLqdc/lJJKju5ThFVaGrnu2/l0b6j
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="312951411"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="312951411"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 00:03:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="712719991"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="712719991"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 30 Nov 2022 00:03:52 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p0I4N-000Aoh-1u;
        Wed, 30 Nov 2022 08:03:51 +0000
Date:   Wed, 30 Nov 2022 16:03:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 7944b67ff7e2d14bd51dc69b6ed866be102e27af
Message-ID: <63870e54.J/1jx++Nv+zeS3Y+%lkp@intel.com>
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
branch HEAD: 7944b67ff7e2d14bd51dc69b6ed866be102e27af  ext4: remove trailing newline from ext4_msg() message

elapsed time: 1633m

configs tested: 60
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arc                                 defconfig
powerpc                           allnoconfig
alpha                               defconfig
x86_64                              defconfig
um                             i386_defconfig
s390                             allmodconfig
x86_64                               rhel-8.3
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                           rhel-8.3-syz
s390                                defconfig
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a002-20221128
x86_64               randconfig-a001-20221128
x86_64               randconfig-a003-20221128
x86_64                           rhel-8.3-kvm
x86_64               randconfig-a004-20221128
i386                              allnoconfig
i386                 randconfig-a002-20221128
arm                               allnoconfig
s390                             allyesconfig
arc                  randconfig-r043-20221128
arc                               allnoconfig
x86_64               randconfig-a005-20221128
alpha                             allnoconfig
i386                 randconfig-a003-20221128
x86_64               randconfig-a006-20221128
i386                                defconfig
i386                 randconfig-a001-20221128
i386                 randconfig-a005-20221128
i386                 randconfig-a006-20221128
i386                 randconfig-a004-20221128
sh                               allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
mips                             allyesconfig
arc                              allyesconfig
powerpc                          allmodconfig
alpha                            allyesconfig
i386                             allyesconfig
ia64                             allmodconfig
arm                                 defconfig

clang tested configs:
x86_64               randconfig-a013-20221128
x86_64               randconfig-a012-20221128
x86_64               randconfig-a014-20221128
x86_64               randconfig-a011-20221128
x86_64               randconfig-a016-20221128
x86_64               randconfig-a015-20221128
hexagon              randconfig-r045-20221128
hexagon              randconfig-r041-20221128
riscv                randconfig-r042-20221128
s390                 randconfig-r044-20221128
i386                 randconfig-a012-20221128
i386                 randconfig-a011-20221128
i386                 randconfig-a013-20221128
i386                 randconfig-a015-20221128
i386                 randconfig-a016-20221128
i386                 randconfig-a014-20221128

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
