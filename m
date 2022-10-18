Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E74602FF6
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Oct 2022 17:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiJRPpw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Oct 2022 11:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiJRPpv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Oct 2022 11:45:51 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F7A2BEF
        for <linux-ext4@vger.kernel.org>; Tue, 18 Oct 2022 08:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666107949; x=1697643949;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=iq2JOZtkV3u8G3g6ABUM7qsZi+b2OOZm7VlREo7/cOE=;
  b=QYQyxhmntC1Kit7KXe50RJo1s7C5X4Ja1YBu8LRbgyv7c+XoZ+tWdPS0
   NAuOOIe2kictBeqX53raQbop5A+imK2ydUEAQm418jBZqn+4uoOD6fx5+
   0sdjY1i1kWTv2b0DRHI/8/7cEaKI13zFrPk1WAaEoFAR0WbY3Lk0GL+HD
   svEHlBsGMJYHHsk81BHGojKdO9CawoIjHBYvTqcBcbBuidm/RCQAsg2WN
   d2y8VOKnJqKx3G4RGdo5eUId3GaNQRHjJchq+wWY61Z86SxNOFjP2qktm
   tgdxOL+dhKKMccpcvae+n7HK5g/r3TTPbXnQgrpUqQAsIgdSL9e2G0REz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="307229794"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="307229794"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 08:45:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="661961960"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="661961960"
Received: from lkp-server01.sh.intel.com (HELO 8381f64adc98) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 18 Oct 2022 08:45:45 -0700
Received: from kbuild by 8381f64adc98 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1okomm-0001nE-16;
        Tue, 18 Oct 2022 15:45:44 +0000
Date:   Tue, 18 Oct 2022 23:45:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     ntfs3@lists.linux.dev, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jfs-discussion@lists.sourceforge.net,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:master] BUILD REGRESSION
 4ca786ae6681b90b0ec3f4c55c89d12f835f8944
Message-ID: <634eca23.ML3KLI/hjp2jt28w%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 4ca786ae6681b90b0ec3f4c55c89d12f835f8944  Add linux-next specific files for 20221018

Error/Warning reports:

https://lore.kernel.org/linux-doc/202210070057.NpbaMyxB-lkp@intel.com
https://lore.kernel.org/linux-mm/202210090954.pTR6m6rj-lkp@intel.com
https://lore.kernel.org/linux-mm/202210110857.9s0tXVNn-lkp@intel.com
https://lore.kernel.org/linux-mm/202210111318.mbUfyhps-lkp@intel.com
https://lore.kernel.org/llvm/202210181318.WUNV3QRv-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

ERROR: modpost: "devm_ioremap_resource" [drivers/dma/idma64.ko] undefined!
ERROR: modpost: "devm_ioremap_resource" [drivers/dma/qcom/hdma.ko] undefined!
Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
arch/arm64/kernel/alternative.c:199:6: warning: no previous prototype for 'apply_alternatives_vdso' [-Wmissing-prototypes]
arch/arm64/kernel/alternative.c:295:14: warning: no previous prototype for 'alt_cb_patch_nops' [-Wmissing-prototypes]
fs/ext4/super.c:1744:19: warning: 'deprecated_msg' defined but not used [-Wunused-const-variable=]
grep: smatch_trinity_*: No such file or directory
mm/mmap.c:802 __vma_adjust() error: uninitialized symbol 'next_next'.

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-alldefconfig
|   |-- arch-arm64-kernel-alternative.c:warning:no-previous-prototype-for-alt_cb_patch_nops
|   `-- arch-arm64-kernel-alternative.c:warning:no-previous-prototype-for-apply_alternatives_vdso
|-- arm64-allyesconfig
|   |-- arch-arm64-kernel-alternative.c:warning:no-previous-prototype-for-alt_cb_patch_nops
|   `-- arch-arm64-kernel-alternative.c:warning:no-previous-prototype-for-apply_alternatives_vdso
|-- arm64-randconfig-c034-20221018
|   |-- arch-arm64-kernel-alternative.c:warning:no-previous-prototype-for-alt_cb_patch_nops
|   `-- arch-arm64-kernel-alternative.c:warning:no-previous-prototype-for-apply_alternatives_vdso
|-- i386-allyesconfig
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- i386-defconfig
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- i386-randconfig-a003-20221017
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- loongarch-randconfig-s053-20221018
|   |-- fs-ext4-fast_commit.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-int-priv1-got-restricted-__le16-addressable-usertype-fc_len
|   |-- fs-ext4-fast_commit.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-int-tag-got-restricted-__le16-addressable-usertype-fc_tag
|   |-- fs-ext4-fast_commit.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-unsigned-short-usertype-tag-got-restricted-__le16-addressable-usertype-fc_tag
|   |-- fs-ext4-fast_commit.c:sparse:sparse:incorrect-type-in-assignment-(different-base-types)-expected-restricted-__le16-usertype-fc_len-got-unsigned-short-usertype
|   |-- fs-ext4-fast_commit.c:sparse:sparse:incorrect-type-in-assignment-(different-base-types)-expected-restricted-__le16-usertype-fc_tag-got-unsigned-short-usertype
|   |-- fs-ext4-fast_commit.c:sparse:sparse:incorrect-type-in-initializer-(different-base-types)-expected-int-tag-got-restricted-__le16-usertype-fc_tag
|   |-- fs-ext4-fast_commit.c:sparse:sparse:restricted-__le16-degrades-to-integer
|   |-- fs-ntfs3-index.c:sparse:sparse:restricted-__le32-degrades-to-integer
|   |-- fs-ntfs3-namei.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-restricted-__le16-const-usertype-s1-got-unsigned-short
|   `-- fs-ntfs3-namei.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-restricted-__le16-const-usertype-s2-got-unsigned-short
|-- microblaze-randconfig-s031-20221018
|   |-- fs-ext4-fast_commit.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-int-priv1-got-restricted-__le16-addressable-usertype-fc_len
|   |-- fs-ext4-fast_commit.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-int-tag-got-restricted-__le16-addressable-usertype-fc_tag
|   |-- fs-ext4-fast_commit.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-unsigned-short-usertype-tag-got-restricted-__le16-addressable-usertype-fc_tag
|   |-- fs-ext4-fast_commit.c:sparse:sparse:incorrect-type-in-assignment-(different-base-types)-expected-restricted-__le16-usertype-fc_len-got-unsigned-short-usertype
|   |-- fs-ext4-fast_commit.c:sparse:sparse:incorrect-type-in-assignment-(different-base-types)-expected-restricted-__le16-usertype-fc_tag-got-unsigned-short-usertype
|   |-- fs-ext4-fast_commit.c:sparse:sparse:incorrect-type-in-initializer-(different-base-types)-expected-int-tag-got-restricted-__le16-usertype-fc_tag
|   |-- fs-ext4-fast_commit.c:sparse:sparse:restricted-__le16-degrades-to-integer
|   |-- fs-ntfs3-index.c:sparse:sparse:restricted-__le32-degrades-to-integer
|   |-- fs-ntfs3-namei.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-restricted-__le16-const-usertype-s1-got-unsigned-short
|   `-- fs-ntfs3-namei.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-restricted-__le16-const-usertype-s2-got-unsigned-short
|-- nios2-randconfig-m041-20221018
|   |-- grep:smatch_trinity_:No-such-file-or-directory
|   `-- mm-mmap.c-__vma_adjust()-error:uninitialized-symbol-next_next-.
|-- nios2-randconfig-s051-20221018
|   |-- fs-ext4-fast_commit.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-int-priv1-got-restricted-__le16-addressable-usertype-fc_len
|   |-- fs-ext4-fast_commit.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-int-tag-got-restricted-__le16-addressable-usertype-fc_tag
|   |-- fs-ext4-fast_commit.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-unsigned-short-usertype-tag-got-restricted-__le16-addressable-usertype-fc_tag
|   |-- fs-ext4-fast_commit.c:sparse:sparse:incorrect-type-in-assignment-(different-base-types)-expected-restricted-__le16-usertype-fc_len-got-unsigned-short-usertype
|   |-- fs-ext4-fast_commit.c:sparse:sparse:incorrect-type-in-assignment-(different-base-types)-expected-restricted-__le16-usertype-fc_tag-got-unsigned-short-usertype
|   |-- fs-ext4-fast_commit.c:sparse:sparse:incorrect-type-in-initializer-(different-base-types)-expected-int-tag-got-restricted-__le16-usertype-fc_tag
|   |-- fs-ext4-fast_commit.c:sparse:sparse:restricted-__le16-degrades-to-integer
|   |-- fs-ntfs3-index.c:sparse:sparse:restricted-__le32-degrades-to-integer
|   |-- fs-ntfs3-namei.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-restricted-__le16-const-usertype-s1-got-unsigned-short
clang_recent_errors
|-- arm64-randconfig-r011-20221017
|   `-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|-- arm64-randconfig-r024-20221017
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
|-- hexagon-randconfig-r023-20221017
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
|-- hexagon-randconfig-r041-20221017
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   |-- fs-jfs-jfs_dmap.c:warning:result-of-comparison-of-constant-with-expression-of-type-int-is-always-false
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
|-- i386-randconfig-a013-20221017
|   `-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|-- i386-randconfig-a014-20221017
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   |-- fs-jfs-jfs_dmap.c:warning:result-of-comparison-of-constant-with-expression-of-type-int-is-always-false
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
|-- i386-randconfig-a016-20221017
|   `-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|-- mips-randconfig-r005-20221017
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   |-- fs-jfs-jfs_dmap.c:warning:result-of-comparison-of-constant-with-expression-of-type-int-is-always-false
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
|-- powerpc-akebono_defconfig
|   `-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|-- powerpc-powernv_defconfig
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   `-- fs-jfs-jfs_dmap.c:warning:result-of-comparison-of-constant-with-expression-of-type-int-is-always-false
|-- powerpc-randconfig-r015-20221017
|   `-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|-- riscv-randconfig-r042-20221017
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   `-- fs-jfs-jfs_dmap.c:warning:result-of-comparison-of-constant-with-expression-of-type-int-is-always-false
|-- riscv-rv32_defconfig
|   `-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|-- s390-randconfig-r044-20221017
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
|-- x86_64-randconfig-a011-20221017
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   `-- fs-jfs-jfs_dmap.c:warning:result-of-comparison-of-constant-with-expression-of-type-int-is-always-false
|-- x86_64-randconfig-a012-20221017
|   `-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|-- x86_64-randconfig-a016-20221017
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
`-- x86_64-rhel-8.3-rust
    `-- fs-ext4-super.c:warning:unused-variable-deprecated_msg

elapsed time: 727m

configs tested: 78
configs skipped: 3

gcc tested configs:
um                             i386_defconfig
i386                                defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
arm                                 defconfig
i386                             allyesconfig
x86_64               randconfig-a002-20221017
x86_64                           allyesconfig
x86_64               randconfig-a003-20221017
i386                 randconfig-a004-20221017
x86_64               randconfig-a004-20221017
x86_64                          rhel-8.3-func
arm64                            allyesconfig
x86_64               randconfig-a001-20221017
arm                              allyesconfig
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a001-20221017
x86_64               randconfig-a006-20221017
arc                                 defconfig
x86_64               randconfig-a005-20221017
powerpc                           allnoconfig
i386                 randconfig-a006-20221017
s390                             allmodconfig
i386                 randconfig-a002-20221017
alpha                               defconfig
arc                  randconfig-r043-20221017
i386                 randconfig-a003-20221017
x86_64                           rhel-8.3-syz
s390                                defconfig
i386                 randconfig-a005-20221017
x86_64                         rhel-8.3-kunit
alpha                            allyesconfig
sh                               allmodconfig
s390                             allyesconfig
x86_64                           rhel-8.3-kvm
mips                             allyesconfig
arc                              allyesconfig
powerpc                          allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
ia64                             allmodconfig
arm                            pleb_defconfig
microblaze                          defconfig
arm                          exynos_defconfig
arm                        clps711x_defconfig
arm                           sama5_defconfig
arc                        nsim_700_defconfig
arm64                            alldefconfig
mips                           jazz_defconfig
mips                  maltasmvp_eva_defconfig
arc                        nsimosci_defconfig
arm                         lpc18xx_defconfig
sh                          rsk7264_defconfig
powerpc                     asp8347_defconfig
sh                             shx3_defconfig

clang tested configs:
hexagon              randconfig-r045-20221017
hexagon              randconfig-r041-20221017
x86_64               randconfig-a013-20221017
x86_64               randconfig-a014-20221017
i386                 randconfig-a011-20221017
x86_64               randconfig-a012-20221017
i386                 randconfig-a013-20221017
riscv                randconfig-r042-20221017
x86_64               randconfig-a015-20221017
i386                 randconfig-a012-20221017
x86_64               randconfig-a016-20221017
i386                 randconfig-a014-20221017
s390                 randconfig-r044-20221017
x86_64               randconfig-a011-20221017
i386                 randconfig-a016-20221017
i386                 randconfig-a015-20221017
x86_64                          rhel-8.3-rust
hexagon                          alldefconfig
powerpc                  mpc885_ads_defconfig
powerpc                     akebono_defconfig
powerpc                     powernv_defconfig
riscv                          rv32_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
