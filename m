Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7076012DE
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Oct 2022 17:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiJQPpb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 17 Oct 2022 11:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiJQPp3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 17 Oct 2022 11:45:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D1A4D248
        for <linux-ext4@vger.kernel.org>; Mon, 17 Oct 2022 08:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666021528; x=1697557528;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=3v629TfnQ6eCHCvRptZHiwXoRTAfdgVXR3TJuTbFQ10=;
  b=R+g0xXErCOfMuK1e8br1ZzMoenQtl92y+dQNxZai9CLApCuLwfbuxFBK
   iTVuSwNINdI+pg/SLd9iKQw3evIjU3h3Pv6qAWz9QMPKxxa+2C+AK03/u
   1sT+gYyEltgbIGOWNBj6hw2YXo6vh0hgwUzvLjzeER4HMAXt1bZXq/Hp1
   OLB5McAvHZ3VdCBF4BnFT9D4zL4sQTtzly87hS60MsqkQU7Ph2B7zaQS/
   pfT68s2F27L/VbcpoXFLXSTgq8C0eAFsU7ikbjuThG4IdtJQOKzrpzkoX
   gzR6rsi5gxPsGrF1pZto9HFEUMjK3cHM+0gSIYcyu53YiYOZ5mKK4rtxS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="286228422"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="286228422"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 08:45:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="717537483"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="717537483"
Received: from lkp-server01.sh.intel.com (HELO 8381f64adc98) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Oct 2022 08:45:25 -0700
Received: from kbuild by 8381f64adc98 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1okSIu-0000fA-28;
        Mon, 17 Oct 2022 15:45:24 +0000
Date:   Mon, 17 Oct 2022 23:44:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     ntfs3@lists.linux.dev, linux-mediatek@lists.infradead.org,
        linux-ext4@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:master] BUILD REGRESSION
 77d8bf70fac0900844491376bc18b491710168bf
Message-ID: <634d7858.CIIfTENtfSUJb4x+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 77d8bf70fac0900844491376bc18b491710168bf  Add linux-next specific files for 20221017

Error/Warning reports:

https://lore.kernel.org/linux-mm/202210110857.9s0tXVNn-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

ERROR: modpost: "devm_ioremap_resource" [drivers/dma/idma64.ko] undefined!
ERROR: modpost: "devm_ioremap_resource" [drivers/dma/qcom/hdma.ko] undefined!
arch/arm64/kernel/alternative.c:199:6: warning: no previous prototype for 'apply_alternatives_vdso' [-Wmissing-prototypes]
arch/arm64/kernel/alternative.c:295:14: warning: no previous prototype for 'alt_cb_patch_nops' [-Wmissing-prototypes]
fs/ext4/super.c:1744:19: warning: 'deprecated_msg' defined but not used [-Wunused-const-variable=]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-allyesconfig
|   |-- arch-arm64-kernel-alternative.c:warning:no-previous-prototype-for-alt_cb_patch_nops
|   `-- arch-arm64-kernel-alternative.c:warning:no-previous-prototype-for-apply_alternatives_vdso
|-- i386-allyesconfig
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- i386-defconfig
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- i386-randconfig-a003-20221017
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- s390-allmodconfig
|   |-- ERROR:devm_ioremap_resource-drivers-dma-idma64.ko-undefined
|   `-- ERROR:devm_ioremap_resource-drivers-dma-qcom-hdma.ko-undefined
|-- x86_64-allyesconfig
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- x86_64-buildonly-randconfig-r003-20221017
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- x86_64-defconfig
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- x86_64-randconfig-a001-20221017
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- x86_64-randconfig-a002-20221017
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- x86_64-randconfig-a003-20221017
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- x86_64-randconfig-a004-20221017
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- x86_64-randconfig-a005-20221017
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- x86_64-randconfig-a006-20221017
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- x86_64-randconfig-r002-20221017
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- x86_64-rhel-8.3
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- x86_64-rhel-8.3-func
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- x86_64-rhel-8.3-kselftests
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- x86_64-rhel-8.3-kvm
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
`-- x86_64-rhel-8.3-syz
    `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
clang_recent_errors
|-- arm64-randconfig-r011-20221017
|   `-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|-- arm64-randconfig-r024-20221017
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
|-- hexagon-buildonly-randconfig-r006-20221017
|   |-- drivers-phy-mediatek-phy-mtk-mipi-dsi-mt8173.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((mask_)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:
|   `-- drivers-phy-mediatek-phy-mtk-mipi-dsi-mt8183.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((mask_)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:
|-- hexagon-randconfig-r041-20221017
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
|-- i386-randconfig-a013-20221017
|   `-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|-- i386-randconfig-a014-20221017
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
|-- i386-randconfig-a016-20221017
|   `-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|-- mips-randconfig-r005-20221017
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
|-- riscv-randconfig-r042-20221017
|   `-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|-- s390-randconfig-r044-20221017
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
|-- x86_64-randconfig-a011-20221017
|   `-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|-- x86_64-randconfig-a012-20221017
|   `-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|-- x86_64-randconfig-a016-20221017
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
|-- x86_64-randconfig-r013-20221017
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
`-- x86_64-rhel-8.3-rust
    `-- fs-ext4-super.c:warning:unused-variable-deprecated_msg

elapsed time: 726m

configs tested: 59
configs skipped: 2

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arc                  randconfig-r043-20221017
i386                 randconfig-a001-20221017
i386                                defconfig
i386                 randconfig-a002-20221017
i386                 randconfig-a003-20221017
x86_64                              defconfig
i386                 randconfig-a005-20221017
i386                 randconfig-a004-20221017
i386                 randconfig-a006-20221017
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
arc                                 defconfig
powerpc                           allnoconfig
x86_64                           rhel-8.3-syz
s390                             allmodconfig
alpha                               defconfig
x86_64                         rhel-8.3-kunit
i386                             allyesconfig
s390                                defconfig
x86_64                           allyesconfig
sh                               allmodconfig
mips                             allyesconfig
s390                             allyesconfig
powerpc                          allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
x86_64               randconfig-a002-20221017
arm                                 defconfig
x86_64               randconfig-a003-20221017
x86_64               randconfig-a004-20221017
x86_64               randconfig-a001-20221017
x86_64               randconfig-a005-20221017
x86_64               randconfig-a006-20221017
arm64                            allyesconfig
arm                              allyesconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20221017
hexagon              randconfig-r045-20221017
s390                 randconfig-r044-20221017
riscv                randconfig-r042-20221017
x86_64               randconfig-a013-20221017
i386                 randconfig-a011-20221017
x86_64               randconfig-a012-20221017
x86_64                          rhel-8.3-rust
i386                 randconfig-a013-20221017
x86_64               randconfig-a015-20221017
x86_64               randconfig-a016-20221017
i386                 randconfig-a012-20221017
i386                 randconfig-a014-20221017
x86_64               randconfig-a011-20221017
i386                 randconfig-a016-20221017
x86_64               randconfig-a014-20221017
i386                 randconfig-a015-20221017

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
