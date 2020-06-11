Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6785C1F6558
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jun 2020 12:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgFKKFq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Jun 2020 06:05:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:28023 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbgFKKFq (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 11 Jun 2020 06:05:46 -0400
IronPort-SDR: FQaTsR78G15t6Rtt1uLn2sHkRhRvGnPHzdT7y11o9rJNP1l5YdvZikqtEDyH05FMQ+M0f8/Cu2
 6ii6IbcQOHHQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 03:05:45 -0700
IronPort-SDR: F8mNebnfrvgV5uA88xDfeJfCiXwvQoKo+VhDrxnoUpUZuZ8JaU+wmHritQYDa1woC3dDeQheOe
 2tJg22zZKZkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,499,1583222400"; 
   d="scan'208";a="275285030"
Received: from lkp-server01.sh.intel.com (HELO b6eec31c25be) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 11 Jun 2020 03:05:44 -0700
Received: from kbuild by b6eec31c25be with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jjK5f-0000Ba-MO; Thu, 11 Jun 2020 10:05:43 +0000
Date:   Thu, 11 Jun 2020 18:04:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:ext4-dax] BUILD SUCCESS
 5749fe5af3db176659978718ddaecebb450cdb6b
Message-ID: <5ee201c4.fhrtAhd+hRqMAbtw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git  ext4-dax
branch HEAD: 5749fe5af3db176659978718ddaecebb450cdb6b  ext4: avoid race conditions when remounting with options that change dax

elapsed time: 776m

configs tested: 98
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
nios2                               defconfig
openrisc                            defconfig
sh                           se7619_defconfig
arm                         shannon_defconfig
arm                         socfpga_defconfig
sh                   sh7724_generic_defconfig
arm                            qcom_defconfig
sh                             espt_defconfig
powerpc                          allmodconfig
powerpc                     mpc512x_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
nios2                            allyesconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                           allnoconfig
powerpc                             defconfig
i386                 randconfig-a006-20200611
i386                 randconfig-a002-20200611
i386                 randconfig-a001-20200611
i386                 randconfig-a004-20200611
i386                 randconfig-a005-20200611
i386                 randconfig-a003-20200611
i386                 randconfig-a015-20200611
i386                 randconfig-a011-20200611
i386                 randconfig-a014-20200611
i386                 randconfig-a013-20200611
i386                 randconfig-a016-20200611
i386                 randconfig-a012-20200611
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
