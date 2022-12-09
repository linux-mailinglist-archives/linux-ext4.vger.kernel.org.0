Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530FE648867
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Dec 2022 19:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiLISZV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Dec 2022 13:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiLISZV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Dec 2022 13:25:21 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903FB379E9
        for <linux-ext4@vger.kernel.org>; Fri,  9 Dec 2022 10:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670610320; x=1702146320;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=r9bQfHi0rKvUslfQpzQaShiDKVd7W3VsxX5OyCeE9o0=;
  b=Ci+IBzgNkl39ncghztA0txiNqYewKQJy4oBuWJLVW9sjkNbsWPunDJQH
   38y5Dcu0w9eLa25XKY//heEc94DP4D+it0tlbLv5AnCHIquA0IueIxHrf
   SK6SAq2iY3HpDrLdmp7de/z/30gT72qP9uikr4YtjCFjrZFGAkuGhZeB3
   1doIyKbV+icy20u6nMJDE2JGKOShCTfYbKsp3EFRskIVQlYTlrycGF+hh
   KgvDMArx8bW99ZMN1aWu+Kan583muxLzcb8vh0m40nSoI8U6xykmY/n4y
   inqBaZXRcBTviu4z8pSQcJ4YbtzR5/HZBkxBKSrLupVAtu1fmrah/n5gX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="403775501"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="403775501"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 10:25:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="647483385"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="647483385"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 09 Dec 2022 10:25:18 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p3i3i-00020f-08;
        Fri, 09 Dec 2022 18:25:18 +0000
Date:   Sat, 10 Dec 2022 02:25:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 1da18e38cb97e9521e93d63034521a9649524f64
Message-ID: <63937d7e.LEtIS+piSVvPxpzV%lkp@intel.com>
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
branch HEAD: 1da18e38cb97e9521e93d63034521a9649524f64  ext4: fix reserved cluster accounting in __es_remove_extent()

elapsed time: 726m

configs tested: 66
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
alpha                             allnoconfig
i386                              allnoconfig
arm                               allnoconfig
arc                               allnoconfig
x86_64                          rhel-8.3-rust
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
arc                  randconfig-r043-20221207
s390                                defconfig
i386                                defconfig
i386                          randconfig-a001
x86_64                        randconfig-a013
riscv                randconfig-r042-20221207
arm                                 defconfig
ia64                             allmodconfig
i386                          randconfig-a003
powerpc                           allnoconfig
m68k                             allyesconfig
x86_64                        randconfig-a002
m68k                             allmodconfig
x86_64                        randconfig-a011
s390                 randconfig-r044-20221207
s390                             allyesconfig
x86_64                               rhel-8.3
x86_64                              defconfig
arc                              allyesconfig
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a006
alpha                            allyesconfig
x86_64                        randconfig-a004
x86_64                           allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
i386                          randconfig-a014
x86_64                         rhel-8.3-kunit
sh                               allmodconfig
i386                          randconfig-a012
i386                          randconfig-a016
mips                             allyesconfig
arm64                            allyesconfig
powerpc                          allmodconfig
i386                             allyesconfig
arm                              allyesconfig
x86_64                            allnoconfig
riscv                             allnoconfig

clang tested configs:
arm                  randconfig-r046-20221207
hexagon              randconfig-r041-20221207
hexagon              randconfig-r045-20221207
i386                          randconfig-a002
x86_64                        randconfig-a005
x86_64                        randconfig-a016
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a012
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a003
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
