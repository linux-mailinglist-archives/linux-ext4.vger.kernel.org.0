Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1D76EEC53
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Apr 2023 04:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239083AbjDZCWd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Apr 2023 22:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238460AbjDZCWc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 Apr 2023 22:22:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C66B86B5;
        Tue, 25 Apr 2023 19:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682475750; x=1714011750;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=8SZ3I2m1PTCJhxsTYgIZ6hOWIPZ8k9drMMvfpZQsbdc=;
  b=a5fG0RHroD+7/2q3R4N38a7MrlqMX8OkmQkotTqE2WgVYETtGHq+e8Pk
   Sy7QBeP/7OQjeOEUnbiBo/bZeFJjOZ216yJOKcAGHDwUAX+bYnhwTxNbg
   1mQco9E8Ut9l0F0GRMjXqPVSqxVIXIhnQ5z7a/mRh5z3/1F5YQxGRfKHx
   wJ9ZX4pbh6POV+5tPHuYCmHDnXm0K0uRvpJPCqnaWMWSxPmVa9gsoQR+p
   OyaNNnl8Of9Cx7Qss/6KD7SMuSYHa18tK3aMg7Nv152mypW30rioi4eN3
   dHcpzOSQiGSJD2KOvzIyTCqJP6oEjrBINHKFEMGGOQCHeX8uIZzg7vG16
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="346991730"
X-IronPort-AV: E=Sophos;i="5.99,227,1677571200"; 
   d="scan'208";a="346991730"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 19:22:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="644061305"
X-IronPort-AV: E=Sophos;i="5.99,227,1677571200"; 
   d="scan'208";a="644061305"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 Apr 2023 19:22:13 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1prUnM-000k0m-1o;
        Wed, 26 Apr 2023 02:22:12 +0000
Date:   Wed, 26 Apr 2023 10:21:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-ext4@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:master] BUILD REGRESSION
 f600e0bbde8562a06bee31b3eb1b69d49acac4c5
Message-ID: <64488a9a.Dl/ldFuPHOHNov5Q%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: f600e0bbde8562a06bee31b3eb1b69d49acac4c5  Add linux-next specific files for 20230425

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202304102354.Q4VOXGTE-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202304140707.CoH337Ux-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202304210303.nlMI0sRQ-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202304210349.DykCi88S-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202304230014.YbScpx20-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202304260503.EVDTG0PJ-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/accel/habanalabs/gaudi/gaudi.c:117:19: warning: unused variable 'gaudi_irq_name' [-Wunused-const-variable]
drivers/base/regmap/regcache-maple.c:113:23: warning: 'lower_index' is used uninitialized [-Wuninitialized]
drivers/base/regmap/regcache-maple.c:113:36: warning: 'lower_last' is used uninitialized [-Wuninitialized]
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:458:16: warning: variable 'j' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:1078:6: warning: no previous prototype for 'gfx_v9_4_3_disable_gpa_mode' [-Wmissing-prototypes]
drivers/gpu/drm/i915/gt/uc/guc_capture_fwif.h:62: warning: wrong kernel-doc identifier on line:
drivers/gpu/drm/i915/i915_pmu.h:41: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
drivers/gpu/drm/i915/i915_request.h:176: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
drivers/gpu/drm/i915/i915_vma.h:145: warning: expecting prototype for i915_vma_offset(). Prototype was for i915_vma_size() instead
drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:298:6: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
fs/ext4/super.c:1262:13: warning: unused variable 'i' [-Wunused-variable]
fs/ext4/super.c:1262:6: warning: unused variable 'i' [-Wunused-variable]
s390-linux-ld: arc-rimi.c:(.text+0x18c): undefined reference to `iounmap'

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/acpi/property.c:985 acpi_data_prop_read_single() error: potentially dereferencing uninitialized 'obj'.

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- alpha-buildonly-randconfig-r006-20230424
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- alpha-randconfig-r013-20230424
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- arc-allyesconfig
|   |-- drivers-base-regmap-regcache-maple.c:warning:lower_index-is-used-uninitialized
|   |-- drivers-base-regmap-regcache-maple.c:warning:lower_last-is-used-uninitialized
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- arc-randconfig-c031-20230423
|   |-- drivers-base-regmap-regcache-maple.c:warning:lower_index-is-used-uninitialized
|   `-- drivers-base-regmap-regcache-maple.c:warning:lower_last-is-used-uninitialized
|-- arc-randconfig-m031-20230423
|   |-- drivers-base-regmap-regcache-maple.c:warning:lower_index-is-used-uninitialized
|   `-- drivers-base-regmap-regcache-maple.c:warning:lower_last-is-used-uninitialized
|-- arc-randconfig-r043-20230424
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- arm-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- arm-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- arm64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- arm64-randconfig-r031-20230423
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- i386-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- i386-randconfig-a011-20230424
|   `-- fs-ext4-super.c:warning:unused-variable-i
|-- i386-randconfig-a016-20230424
|   `-- fs-ext4-super.c:warning:unused-variable-i
|-- i386-randconfig-c021
|   `-- fs-ext4-super.c:warning:unused-variable-i
|-- i386-randconfig-m021-20230424
|   `-- drivers-acpi-property.c-acpi_data_prop_read_single()-error:potentially-dereferencing-uninitialized-obj-.
|-- ia64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- loongarch-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- loongarch-defconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- loongarch-loongson3_defconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- mips-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- mips-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- openrisc-buildonly-randconfig-r002-20230424
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- parisc-randconfig-c043-20230423
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- parisc-randconfig-s052-20230423
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- powerpc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- powerpc-randconfig-s031-20230423
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|   `-- drivers-spi-spi-fsl-cpm.c:sparse:sparse:incorrect-type-in-assignment-(different-base-types)-expected-unsigned-short-usertype-got-restricted-__le16
|-- riscv-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- riscv-buildonly-randconfig-r005-20230424
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- s390-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- s390-randconfig-r022-20230424
|   `-- s390-linux-ld:arc-rimi.c:(.text):undefined-reference-to-iounmap
|-- s390-randconfig-r044-20230424
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- sparc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- sparc64-buildonly-randconfig-r002-20230423
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- x86_64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
`-- x86_64-randconfig-m001
    `-- drivers-acpi-property.c-acpi_data_prop_read_single()-error:potentially-dereferencing-uninitialized-obj-.
clang_recent_errors
|-- arm-randconfig-r046-20230424
|   `-- drivers-phy-mediatek-phy-mtk-hdmi-mt8195.c:warning:variable-ret-is-uninitialized-when-used-here
|-- i386-randconfig-a001-20230424
|   `-- fs-ext4-super.c:warning:unused-variable-i
|-- i386-randconfig-a003-20230424
|   `-- fs-ext4-super.c:warning:unused-variable-i
|-- i386-randconfig-a004-20230424
|   |-- drivers-gpu-drm-i915-gt-uc-guc_capture_fwif.h:warning:wrong-kernel-doc-identifier-on-line:
|   |-- drivers-gpu-drm-i915-i915_pmu.h:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   |-- drivers-gpu-drm-i915-i915_request.h:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   `-- drivers-gpu-drm-i915-i915_vma.h:warning:expecting-prototype-for-i915_vma_offset().-Prototype-was-for-i915_vma_size()-instead
|-- i386-randconfig-a005-20230424
|   `-- fs-ext4-super.c:warning:unused-variable-i
|-- x86_64-randconfig-a001-20230424
|   `-- fs-ext4-super.c:warning:unused-variable-i
|-- x86_64-randconfig-a003-20230424
|   `-- fs-ext4-super.c:warning:unused-variable-i
|-- x86_64-randconfig-a004-20230424
|   |-- drivers-accel-habanalabs-gaudi-gaudi.c:warning:unused-variable-gaudi_irq_name
|   `-- fs-ext4-super.c:warning:unused-variable-i
|-- x86_64-randconfig-a005-20230424
|   `-- fs-ext4-super.c:warning:unused-variable-i
|-- x86_64-randconfig-a006-20230424
|   `-- fs-ext4-super.c:warning:unused-variable-i
|-- x86_64-randconfig-a012
|   `-- fs-ext4-super.c:warning:unused-variable-i
`-- x86_64-randconfig-a014
    `-- fs-ext4-super.c:warning:unused-variable-i

elapsed time: 723m

configs tested: 136
configs skipped: 8

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r006-20230424   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r011-20230423   gcc  
alpha                randconfig-r013-20230424   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                  randconfig-r043-20230423   gcc  
arc                  randconfig-r043-20230424   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm          buildonly-randconfig-r004-20230423   gcc  
arm                                 defconfig   gcc  
arm                            hisi_defconfig   gcc  
arm                  randconfig-r015-20230424   clang
arm                  randconfig-r016-20230423   gcc  
arm                  randconfig-r023-20230425   gcc  
arm                  randconfig-r046-20230423   gcc  
arm                  randconfig-r046-20230424   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r013-20230423   clang
arm64                randconfig-r031-20230423   gcc  
arm64                randconfig-r035-20230423   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r021-20230425   gcc  
csky                 randconfig-r033-20230423   gcc  
hexagon              randconfig-r004-20230425   clang
hexagon              randconfig-r014-20230423   clang
hexagon              randconfig-r041-20230423   clang
hexagon              randconfig-r041-20230424   clang
hexagon              randconfig-r045-20230423   clang
hexagon              randconfig-r045-20230424   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230424   clang
i386                 randconfig-a002-20230424   clang
i386                 randconfig-a003-20230424   clang
i386                 randconfig-a004-20230424   clang
i386                 randconfig-a005-20230424   clang
i386                 randconfig-a006-20230424   clang
i386                 randconfig-a011-20230424   gcc  
i386                 randconfig-a012-20230424   gcc  
i386                 randconfig-a013-20230424   gcc  
i386                 randconfig-a014-20230424   gcc  
i386                 randconfig-a015-20230424   gcc  
i386                 randconfig-a016-20230424   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r001-20230425   gcc  
ia64                 randconfig-r026-20230425   gcc  
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch            randconfig-r002-20230425   gcc  
loongarch            randconfig-r034-20230423   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                 randconfig-r015-20230423   gcc  
microblaze   buildonly-randconfig-r004-20230424   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r014-20230424   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   clang
mips         buildonly-randconfig-r003-20230423   clang
mips                 randconfig-r031-20230424   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r034-20230424   gcc  
openrisc     buildonly-randconfig-r002-20230424   gcc  
openrisc             randconfig-r032-20230423   gcc  
openrisc             randconfig-r036-20230423   gcc  
openrisc             randconfig-r036-20230424   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r012-20230424   gcc  
parisc               randconfig-r025-20230425   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      bamboo_defconfig   gcc  
powerpc                   currituck_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r003-20230424   gcc  
riscv        buildonly-randconfig-r005-20230424   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230423   clang
riscv                randconfig-r042-20230424   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r012-20230423   clang
s390                 randconfig-r044-20230423   clang
s390                 randconfig-r044-20230424   gcc  
sh                               allmodconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh           buildonly-randconfig-r001-20230423   gcc  
sh           buildonly-randconfig-r005-20230423   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                   randconfig-r032-20230424   gcc  
sh                   randconfig-r033-20230424   gcc  
sparc        buildonly-randconfig-r001-20230424   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r016-20230424   gcc  
sparc                randconfig-r022-20230425   gcc  
sparc64      buildonly-randconfig-r002-20230423   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230424   clang
x86_64               randconfig-a002-20230424   clang
x86_64               randconfig-a003-20230424   clang
x86_64               randconfig-a004-20230424   clang
x86_64               randconfig-a005-20230424   clang
x86_64               randconfig-a006-20230424   clang
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r006-20230423   gcc  
xtensa               randconfig-r006-20230425   gcc  
xtensa               randconfig-r024-20230425   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
