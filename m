Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1EB35AA8D
	for <lists+linux-ext4@lfdr.de>; Sat, 10 Apr 2021 05:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbhDJDpA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Apr 2021 23:45:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:6495 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233332AbhDJDo7 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 9 Apr 2021 23:44:59 -0400
IronPort-SDR: iSIjEae5AWRxUOj+kOGjPEPYjTHUrmKx150YSSDHqv2UnInBHpAS7DCDn9smmdHPtslvAKFWUh
 +AntjwJVPGrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="181010615"
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="scan'208";a="181010615"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 20:44:44 -0700
IronPort-SDR: h/542kTS7vsXpiF+ke32yys5kPoYS3pgab9j9/4ajqWpYqGpUu6ttOtVj7kitS5qX9v+Ts79W0
 3kZt04je+XrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="scan'208";a="531216640"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 09 Apr 2021 20:44:43 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lV4Y6-000Hlq-BK; Sat, 10 Apr 2021 03:44:42 +0000
Date:   Sat, 10 Apr 2021 11:43:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS WITH WARNING
 21175ca434c5d49509b73cf473618b01b0b85437
Message-ID: <60711ef1.AxeK1thoTLdNPamE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 21175ca434c5d49509b73cf473618b01b0b85437  ext4: make prefetch_block_bitmaps default

Warning reports:

https://lore.kernel.org/linux-ext4/202104100159.B2w6vxAi-lkp@intel.com
https://lore.kernel.org/linux-ext4/202104100225.GIF5USvR-lkp@intel.com

Warning in current branch:

fs/ext4/fast_commit.c:1737:16: warning: format '%d' expects argument of type 'int', but argument 2 has type 'long unsigned int' [-Wformat=]
fs/ext4/fast_commit.c:1738:5: warning: format specifies type 'int' but the argument has type 'unsigned long' [-Wformat]
fs/jbd2/recovery.c:256:16: warning: format '%d' expects a matching 'int' argument [-Wformat=]
fs/jbd2/recovery.c:256:54: warning: more '%' conversions than data arguments [-Wformat-insufficient-args]

possible Warning in current branch:

fs/ext4/mballoc.c:2966:13: sparse: sparse: context imbalance in 'ext4_mb_seq_structs_summary_start' - wrong count at exit

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-randconfig-r013-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- arc-hsdk_defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- arm-defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- arm-ixp4xx_defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- arm-mmp2_defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- arm-multi_v5_defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- arm-multi_v7_defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- arm-mxs_defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- arm-pleb_defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- arm-s3c6400_defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- arm-vexpress_defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- arm-vf610m4_defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- arm64-defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- csky-defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- h8300-randconfig-r014-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- h8300-randconfig-r015-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- i386-defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- i386-randconfig-a003-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- i386-randconfig-a004-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- i386-randconfig-a006-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- i386-randconfig-a011-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- i386-randconfig-a014-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- i386-randconfig-m021-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- i386-randconfig-r022-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- ia64-defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- ia64-randconfig-r026-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- ia64-zx1_defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- m68k-defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- m68k-randconfig-c004-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- m68k-randconfig-p002-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- m68k-randconfig-r004-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- microblaze-mmu_defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- mips-bmips_be_defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- mips-loongson1b_defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- mips-qi_lb60_defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- mips-workpad_defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- nds32-defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- nds32-randconfig-c004-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- nios2-randconfig-m031-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- nios2-randconfig-r023-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- nios2-randconfig-r036-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- parisc-defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- parisc-randconfig-r031-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- powerpc-asp8347_defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- powerpc-currituck_defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- powerpc-ep8248e_defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- powerpc-mpc836x_rdk_defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- powerpc-mpc837x_mds_defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- powerpc-mpc837x_rdb_defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- powerpc-ppc64_defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- powerpc-pseries_defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- powerpc-randconfig-r025-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- powerpc-tqm8540_defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- powerpc64-defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- powerpc64-randconfig-r025-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- powerpc64-randconfig-s032-20210409
|   `-- fs-ext4-mballoc.c:sparse:sparse:context-imbalance-in-ext4_mb_seq_structs_summary_start-wrong-count-at-exit
|-- riscv-defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- riscv-rv32_defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- s390-randconfig-r013-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- sh-se7712_defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- sparc-randconfig-c023-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- sparc-randconfig-r032-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- um-defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- um-i386_defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- x86_64-defconfig
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- x86_64-kexec
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- x86_64-randconfig-a011-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- x86_64-randconfig-a012-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- x86_64-randconfig-a016-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- x86_64-randconfig-m001-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- x86_64-randconfig-s021-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   |-- fs-ext4-mballoc.c:sparse:sparse:context-imbalance-in-ext4_mb_seq_structs_summary_start-wrong-count-at-exit
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- x86_64-rhel-8.3
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- x86_64-rhel-8.3-kbuiltin
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- x86_64-rhel-8.3-kselftests
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
|-- xtensa-randconfig-r013-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
|   `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument
`-- xtensa-randconfig-r033-20210409
    |-- fs-ext4-fast_commit.c:warning:format-d-expects-argument-of-type-int-but-argument-has-type-long-unsigned-int
    `-- fs-jbd2-recovery.c:warning:format-d-expects-a-matching-int-argument

clang_recent_errors
|-- arm-randconfig-r011-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-specifies-type-int-but-the-argument-has-type-unsigned-long
|   `-- fs-jbd2-recovery.c:warning:more-conversions-than-data-arguments
|-- arm64-randconfig-r001-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-specifies-type-int-but-the-argument-has-type-unsigned-long
|   `-- fs-jbd2-recovery.c:warning:more-conversions-than-data-arguments
|-- mips-randconfig-r016-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-specifies-type-int-but-the-argument-has-type-unsigned-long
|   `-- fs-jbd2-recovery.c:warning:more-conversions-than-data-arguments
|-- riscv-randconfig-r005-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-specifies-type-int-but-the-argument-has-type-unsigned-long
|   `-- fs-jbd2-recovery.c:warning:more-conversions-than-data-arguments
|-- x86_64-randconfig-a005-20210409
|   |-- fs-ext4-fast_commit.c:warning:format-specifies-type-int-but-the-argument-has-type-unsigned-long
|   `-- fs-jbd2-recovery.c:warning:more-conversions-than-data-arguments
`-- x86_64-randconfig-r034-20210409
    |-- fs-ext4-fast_commit.c:warning:format-specifies-type-int-but-the-argument-has-type-unsigned-long
    `-- fs-jbd2-recovery.c:warning:more-conversions-than-data-arguments

elapsed time: 720m

configs tested: 129
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
sh                           se7722_defconfig
m68k                        m5307c3_defconfig
powerpc                       ppc64_defconfig
arm                          gemini_defconfig
powerpc                     ep8248e_defconfig
powerpc                      tqm8xx_defconfig
openrisc                         alldefconfig
arm                            mmp2_defconfig
um                             i386_defconfig
powerpc64                           defconfig
sh                             espt_defconfig
arm                         vf610m4_defconfig
mips                          rb532_defconfig
mips                            gpr_defconfig
arc                     haps_hs_smp_defconfig
arm                             mxs_defconfig
powerpc                      arches_defconfig
sh                        dreamcast_defconfig
arm                             rpc_defconfig
powerpc                   currituck_defconfig
powerpc                 mpc837x_mds_defconfig
microblaze                      mmu_defconfig
mips                        workpad_defconfig
mips                       bmips_be_defconfig
sh                            shmin_defconfig
arm                        multi_v7_defconfig
arc                            hsdk_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                        multi_v5_defconfig
h8300                               defconfig
powerpc                 mpc836x_rdk_defconfig
m68k                       m5249evb_defconfig
ia64                            zx1_defconfig
arm                          ixp4xx_defconfig
powerpc                       ebony_defconfig
mips                             allyesconfig
sh                           se7712_defconfig
mips                        qi_lb60_defconfig
powerpc                     pseries_defconfig
arm                         s3c6400_defconfig
sh                          r7785rp_defconfig
powerpc                     asp8347_defconfig
powerpc                     sbc8548_defconfig
powerpc                     tqm8540_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                      mgcoge_defconfig
m68k                        m5407c3_defconfig
i386                                defconfig
arm                        vexpress_defconfig
sh                               alldefconfig
mips                     loongson1b_defconfig
arm                            pleb_defconfig
arm                          collie_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20210409
i386                 randconfig-a003-20210409
i386                 randconfig-a001-20210409
i386                 randconfig-a004-20210409
i386                 randconfig-a002-20210409
i386                 randconfig-a005-20210409
x86_64               randconfig-a014-20210409
x86_64               randconfig-a015-20210409
x86_64               randconfig-a012-20210409
x86_64               randconfig-a011-20210409
x86_64               randconfig-a013-20210409
x86_64               randconfig-a016-20210409
i386                 randconfig-a014-20210409
i386                 randconfig-a011-20210409
i386                 randconfig-a016-20210409
i386                 randconfig-a012-20210409
i386                 randconfig-a013-20210409
i386                 randconfig-a015-20210409
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210409
x86_64               randconfig-a005-20210409
x86_64               randconfig-a003-20210409
x86_64               randconfig-a001-20210409
x86_64               randconfig-a002-20210409
x86_64               randconfig-a006-20210409

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
