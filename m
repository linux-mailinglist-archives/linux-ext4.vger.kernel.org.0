Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975155890FF
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Aug 2022 19:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236766AbiHCRJk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Aug 2022 13:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiHCRJj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Aug 2022 13:09:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D55A18B13
        for <linux-ext4@vger.kernel.org>; Wed,  3 Aug 2022 10:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659546579; x=1691082579;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=F5tPgjvMYurx5jLb0RvLnopQe8cAA6llEG25zrkiCL0=;
  b=TIqPa3LSZBp/ugNWBQmh7zZkONs8Pz1iE0XwaCBpWeZvc4rdXzLZj1pJ
   zdQPOQaKwk8dw84J46Xn+m/Cl+Oqhni8/NUf1Cm7EDlq7Kz28ustRqzvS
   pgt6fR0BZmU76Q8cHc9fQFH5KvUDJl+ltyZxc0Av7lbnKlm6fnlWl4sPt
   10R8An9Q7usDCTkX1qLa0rzaAJ34ClOo5vK0b+7QI8CJzFDZv9/qVNwp0
   XsiLnT30+SiRU4WAA22Y9r+K+WCX4VS9sAonQwbk65qhQx0q1Qnz5ob2q
   mvgZdJ83QQIebMArnQA1B4zY1bug3iVF/etwer7Hi1lqVxdkrfKlmeKwP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="288487569"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="288487569"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 10:09:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="631230920"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 03 Aug 2022 10:09:14 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJHrt-000HU7-2q;
        Wed, 03 Aug 2022 17:09:13 +0000
Date:   Thu, 04 Aug 2022 01:08:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 d95efb14c0b81b684deb32ba10cdb78b4178ae5b
Message-ID: <62eaab9c.MuWPq0M7IqPYXOW4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: d95efb14c0b81b684deb32ba10cdb78b4178ae5b  ext4: add ioctls to get/set the ext4 superblock uuid

elapsed time: 722m

configs tested: 72
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
x86_64                              defconfig
i386                             allyesconfig
x86_64                               rhel-8.3
arc                  randconfig-r043-20220803
x86_64                          rhel-8.3-func
arm                                 defconfig
x86_64                         rhel-8.3-kunit
x86_64                           allyesconfig
i386                          randconfig-a014
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
riscv                randconfig-r042-20220803
powerpc                           allnoconfig
x86_64                           rhel-8.3-syz
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a012
s390                 randconfig-r044-20220803
i386                          randconfig-a005
i386                          randconfig-a016
powerpc                          allmodconfig
m68k                             allmodconfig
arm64                            allyesconfig
arc                              allyesconfig
mips                             allyesconfig
arm                              allyesconfig
alpha                            allyesconfig
sh                               allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
m68k                             allyesconfig
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
powerpc                   motionpro_defconfig
arm                         at91_dt_defconfig
sh                           se7343_defconfig
x86_64                           alldefconfig
sh                     sh7710voipgw_defconfig
m68k                       bvme6000_defconfig
arm                           h5000_defconfig
m68k                           sun3_defconfig
sh                             shx3_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
i386                          randconfig-c001

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
hexagon              randconfig-r041-20220803
i386                          randconfig-a002
i386                          randconfig-a004
hexagon              randconfig-r045-20220803
i386                          randconfig-a015
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
arm                         s5pv210_defconfig
arm                         lpc32xx_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
