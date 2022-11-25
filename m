Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2822A63821E
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Nov 2022 02:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiKYBlu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Nov 2022 20:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiKYBlu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Nov 2022 20:41:50 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C518D7C
        for <linux-ext4@vger.kernel.org>; Thu, 24 Nov 2022 17:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669340509; x=1700876509;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ojJwCg9nzPKm5u35y1SyyPkym313vIw29hDf04ofFU8=;
  b=EZeEVD2DUnyfN7cMRWuXfb5xCxMhaLkEGP5YMTtLDvv+7MB4LwH0Nyun
   Fzkbo30TATuaiCPcHBEQhT85v8grBm/jriTcwRIN3bS2t/HlX3SSvb7sx
   JY7Ws+JXJ9ptjjgGF09XlRjJiP7AVRyPF8t5VD2lrxtDWWgtKhnXrIG+w
   kIjDJrMD9RaUne4yHv/5klnbk9EpNrZFNBBOaq8TP482mW3WrLXjZKmbh
   v++oJ9KUNC/l0BJ0UYBp2YbIsjRospNV+/VkVBmC2yJ0laRhh4+maNKbI
   wfZ8IqK3ltVdG4QcLf2zWa2dQs+baY5InjKXZeZ+h8Q2vsSB+2MqC8xRh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="315547255"
X-IronPort-AV: E=Sophos;i="5.96,191,1665471600"; 
   d="scan'208";a="315547255"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 17:41:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="748416065"
X-IronPort-AV: E=Sophos;i="5.96,191,1665471600"; 
   d="scan'208";a="748416065"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 24 Nov 2022 17:41:47 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oyNit-0004W9-12;
        Fri, 25 Nov 2022 01:41:47 +0000
Date:   Fri, 25 Nov 2022 09:41:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 4e3c51f4e805291b057d12f5dda5aeb50a538dc4
Message-ID: <63801d3d.6QO92zIZVidko8QT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 4e3c51f4e805291b057d12f5dda5aeb50a538dc4  fs: do not update freeing inode i_io_list

elapsed time: 1341m

configs tested: 42
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                              allnoconfig
alpha                             allnoconfig
arm                               allnoconfig
arc                               allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
arc                                 defconfig
alpha                               defconfig
i386                             allyesconfig
i386                                defconfig
x86_64                            allnoconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
sh                               allmodconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
x86_64                              defconfig
arc                  randconfig-r043-20221124
x86_64                               rhel-8.3
ia64                             allmodconfig
x86_64                           allyesconfig

clang tested configs:
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
