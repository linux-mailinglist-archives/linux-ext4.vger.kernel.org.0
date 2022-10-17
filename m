Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86A9600536
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Oct 2022 04:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiJQCXZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 16 Oct 2022 22:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiJQCXX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 16 Oct 2022 22:23:23 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687204448F
        for <linux-ext4@vger.kernel.org>; Sun, 16 Oct 2022 19:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665973402; x=1697509402;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=w/9wgLLkQxOK8Tg28c8PqY358W9RRELtu/wARxQvJ/I=;
  b=DiEx7XTCtqwYtzAV+SSFPLl1FOdVTUyltWC456WMX7uoFxqmY1en89sD
   k0jUUaOW73YCt/zG6OXnpxFm2J4Gs2W15BOM7w7i3Qn2a948eBgFKmEJu
   MdCTuWnY2n0LZv5I7xcuI2j0bxwO7NuSKnrHjMrsnVVWuC10GfnTHPnui
   YzG3/PTXS8jbMkK+hlfvnDbBjoId2ubkpvpfQhK9p6zPAswBNcnVJ8+/P
   3KsdYAdPrth6xcoiD9px3h/UYJPRknnYfxFjPoS2kXKbgE8tYAIZNthrw
   zid5ugYfUJt1EXKhgJFXuypN9VBIvL5cG1u2+sNBTimOFKJvzf2j1eBL2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="293052499"
X-IronPort-AV: E=Sophos;i="5.95,190,1661842800"; 
   d="scan'208";a="293052499"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2022 19:23:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="661325783"
X-IronPort-AV: E=Sophos;i="5.95,190,1661842800"; 
   d="scan'208";a="661325783"
Received: from lkp-server02.sh.intel.com (HELO 8556ec0e0fdc) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 16 Oct 2022 19:23:19 -0700
Received: from kbuild by 8556ec0e0fdc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1okFmh-00004g-0g;
        Mon, 17 Oct 2022 02:23:19 +0000
Date:   Mon, 17 Oct 2022 10:23:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     ntfs3@lists.linux.dev, linux-mediatek@lists.infradead.org,
        linux-ext4@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:master] BUILD REGRESSION
 dca0a0385a4963145593ba417e1417af88a7c18d
Message-ID: <634cbc8f.WxvxsYX7nHpBItJN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        SUSPICIOUS_RECIPS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: dca0a0385a4963145593ba417e1417af88a7c18d  Add linux-next specific files for 20221014

Error/Warning reports:

https://lore.kernel.org/linux-doc/202210070057.NpbaMyxB-lkp@intel.com
https://lore.kernel.org/linux-mm/202210110857.9s0tXVNn-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

ERROR: modpost: "devm_ioremap_resource" [drivers/dma/fsl-edma.ko] undefined!
ERROR: modpost: "devm_ioremap_resource" [drivers/dma/idma64.ko] undefined!
ERROR: modpost: "devm_ioremap_resource" [drivers/dma/qcom/hdma.ko] undefined!
ERROR: modpost: "devm_memremap" [drivers/misc/open-dice.ko] undefined!
ERROR: modpost: "devm_memunmap" [drivers/misc/open-dice.ko] undefined!
ERROR: modpost: "devm_platform_ioremap_resource" [drivers/char/xillybus/xillybus_of.ko] undefined!
ERROR: modpost: "ioremap" [drivers/net/ethernet/8390/pcnet_cs.ko] undefined!
ERROR: modpost: "ioremap" [drivers/tty/ipwireless/ipwireless.ko] undefined!
ERROR: modpost: "iounmap" [drivers/net/ethernet/8390/pcnet_cs.ko] undefined!
ERROR: modpost: "iounmap" [drivers/tty/ipwireless/ipwireless.ko] undefined!
Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
arch/arm64/kernel/alternative.c:199:6: warning: no previous prototype for 'apply_alternatives_vdso' [-Wmissing-prototypes]
arch/arm64/kernel/alternative.c:295:14: warning: no previous prototype for 'alt_cb_patch_nops' [-Wmissing-prototypes]
fs/ext4/super.c:1744:19: warning: 'deprecated_msg' defined but not used [-Wunused-const-variable=]
pahole: .tmp_vmlinux.btf: No such file or directory

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-allyesconfig
|   |-- arch-arm64-kernel-alternative.c:warning:no-previous-prototype-for-alt_cb_patch_nops
|   `-- arch-arm64-kernel-alternative.c:warning:no-previous-prototype-for-apply_alternatives_vdso
|-- csky-randconfig-r034-20221012
|   `-- pahole:.tmp_vmlinux.btf:No-such-file-or-directory
|-- i386-allyesconfig
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- i386-defconfig
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- i386-randconfig-a003
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- i386-randconfig-a005
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- i386-randconfig-a012
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- i386-randconfig-a014
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- i386-randconfig-a016
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- s390-allmodconfig
|   |-- ERROR:devm_ioremap_resource-drivers-dma-fsl-edma.ko-undefined
|   |-- ERROR:devm_ioremap_resource-drivers-dma-idma64.ko-undefined
|   |-- ERROR:devm_ioremap_resource-drivers-dma-qcom-hdma.ko-undefined
|   |-- ERROR:devm_memremap-drivers-misc-open-dice.ko-undefined
|   |-- ERROR:devm_memunmap-drivers-misc-open-dice.ko-undefined
|   |-- ERROR:devm_platform_ioremap_resource-drivers-char-xillybus-xillybus_of.ko-undefined
|   |-- ERROR:ioremap-drivers-net-ethernet-pcnet_cs.ko-undefined
|   |-- ERROR:ioremap-drivers-tty-ipwireless-ipwireless.ko-undefined
|   |-- ERROR:iounmap-drivers-net-ethernet-pcnet_cs.ko-undefined
|   `-- ERROR:iounmap-drivers-tty-ipwireless-ipwireless.ko-undefined
|-- x86_64-allnoconfig
|   `-- Warning:MAINTAINERS-references-a-file-that-doesn-t-exist:Documentation-devicetree-bindings-mtd-amlogic-meson-nand.txt
|-- x86_64-allyesconfig
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- x86_64-defconfig
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- x86_64-randconfig-a002
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- x86_64-randconfig-a006
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- x86_64-randconfig-a011
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- x86_64-randconfig-a015
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- x86_64-rhel-8.3
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- x86_64-rhel-8.3-func
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- x86_64-rhel-8.3-kselftests
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
clang_recent_errors
|-- arm-randconfig-r012-20221014
|   |-- drivers-phy-mediatek-phy-mtk-mipi-dsi-mt8173.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((mask_)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:
|   |-- drivers-phy-mediatek-phy-mtk-mipi-dsi-mt8183.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((mask_)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:
|   |-- drivers-phy-mediatek-phy-mtk-tphy.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((mask_)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:(unsigned-c
|   `-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|-- hexagon-randconfig-r004-20221012
|   |-- drivers-phy-mediatek-phy-mtk-mipi-dsi-mt8173.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((mask_)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:
|   |-- drivers-phy-mediatek-phy-mtk-mipi-dsi-mt8183.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((mask_)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:
|   |-- drivers-phy-mediatek-phy-mtk-tphy.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((mask_)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:(unsigned-c
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
|-- hexagon-randconfig-r041-20221012
|   |-- drivers-phy-mediatek-phy-mtk-tphy.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((mask_)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:(unsigned-c
|   `-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|-- hexagon-randconfig-r045-20221012
|   `-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|-- i386-randconfig-a002
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
|-- i386-randconfig-a004
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
|-- i386-randconfig-a011
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
|-- i386-randconfig-a013
|   `-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|-- i386-randconfig-a015
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
|-- x86_64-randconfig-a005
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
|-- x86_64-randconfig-a012
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
`-- x86_64-randconfig-a014
    |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
    `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true

elapsed time: 4290m

configs tested: 62
configs skipped: 2

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
csky                              allnoconfig
arc                               allnoconfig
s390                                defconfig
alpha                             allnoconfig
s390                             allmodconfig
riscv                             allnoconfig
x86_64                        randconfig-a002
x86_64                           rhel-8.3-kvm
i386                          randconfig-a001
x86_64                         rhel-8.3-kunit
i386                          randconfig-a003
powerpc                           allnoconfig
x86_64                        randconfig-a004
i386                          randconfig-a005
x86_64                           rhel-8.3-syz
mips                             allyesconfig
m68k                             allmodconfig
x86_64                          rhel-8.3-func
riscv                randconfig-r042-20221012
s390                             allyesconfig
i386                                defconfig
x86_64                              defconfig
powerpc                          allmodconfig
x86_64                    rhel-8.3-kselftests
arc                  randconfig-r043-20221012
x86_64                        randconfig-a006
arc                              allyesconfig
x86_64                               rhel-8.3
sh                               allmodconfig
alpha                            allyesconfig
arm                                 defconfig
m68k                             allyesconfig
x86_64                           allyesconfig
s390                 randconfig-r044-20221012
x86_64                        randconfig-a015
i386                             allyesconfig
x86_64                        randconfig-a013
ia64                             allmodconfig
x86_64                        randconfig-a011
i386                          randconfig-a014
arm64                            allyesconfig
arm                              allyesconfig
i386                          randconfig-a012
i386                          randconfig-a016

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
x86_64                        randconfig-a005
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r045-20221012
hexagon              randconfig-r041-20221012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
