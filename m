Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C3A6F0073
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Apr 2023 07:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242707AbjD0FhS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Apr 2023 01:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjD0FhR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 Apr 2023 01:37:17 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648921A4;
        Wed, 26 Apr 2023 22:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682573835; x=1714109835;
  h=date:from:to:cc:subject:message-id;
  bh=0zmSFm72B70qH6+SvJN8flTFFQSMt/vIt0/G0ZTd3fk=;
  b=Y+IcEx7M9nqk/KqkAnJbweSDXdJ6ZBeSQq7tqJ3PAllUVikZoIEFDWSQ
   pv7OVOWKQRRy0iPZMKbUm8fz6gFE7zrW5PyRq4Co9jJMkvryt6FCV/sus
   cEOzOvlizi9VXd7VXpzfUgOpX9l8vMQxRDgsBqnyYp80g/N8/3prCbKHl
   xoq9zduR9mYveN7hCBc2lQL+70V9drYlUZJVn1eioVb5qyQnm2wq+qAXj
   kJhkuioN32uxkIaH/178BVeThUbXf/SyrHDLpPt6LHvfnDHfyNah5bnj3
   hJ7UvKGVhReoo+qOaF2V8jZPWwMVxg49Pfe8oX2EKmPKYgSqaO5dD2JI9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="346094785"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="346094785"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 22:37:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="758936933"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="758936933"
Received: from lkp-server01.sh.intel.com (HELO 1e0e07564161) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 26 Apr 2023 22:37:12 -0700
Received: from kbuild by 1e0e07564161 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pruJb-00001h-1n;
        Thu, 27 Apr 2023 05:37:11 +0000
Date:   Thu, 27 Apr 2023 13:36:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        amd-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-watchdog@vger.kernel.org, qat-linux@intel.com,
        Mark Brown <broonie@kernel.org>
Subject: [linux-next:master] BUILD SUCCESS WITH WARNING
 b7455b10da762f2d447678c88e37cc1eb6cb45ee
Message-ID: <20230427053654.lVx1R%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: b7455b10da762f2d447678c88e37cc1eb6cb45ee  Add linux-next specific files for 20230426

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202304210303.nlMI0sRQ-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202304210349.DykCi88S-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202304220119.94Pw6YsD-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202304270438.mwnBZp1A-lkp@intel.com

Warning: (recently discovered and may have been fixed)

drivers/base/regmap/regcache-maple.c:113:23: warning: 'lower_index' is used uninitialized [-Wuninitialized]
drivers/base/regmap/regcache-maple.c:113:36: warning: 'lower_last' is used uninitialized [-Wuninitialized]
drivers/bluetooth/btnxpuart.c:1332:34: warning: unused variable 'nxpuart_of_match_table' [-Wunused-const-variable]
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:6339:6: warning: no previous prototype for 'amdgpu_dm_connector_funcs_force' [-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:6395:21: warning: variable 'count' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:458:16: warning: variable 'j' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:1078:6: warning: no previous prototype for 'gfx_v9_4_3_disable_gpa_mode' [-Wmissing-prototypes]
drivers/watchdog/starfive-wdt.c:584:34: warning: unused variable 'starfive_wdt_match' [-Wunused-const-variable]
fs/ext4/super.c:1262:13: warning: unused variable 'i' [-Wunused-variable]
fs/ext4/super.c:1262:6: warning: unused variable 'i' [-Wunused-variable]

Unverified Warning (likely false positive, please contact us if interested):

drivers/acpi/property.c:985 acpi_data_prop_read_single() error: potentially dereferencing uninitialized 'obj'.
drivers/crypto/intel/qat/qat_common/adf_cfg.c:262 adf_cfg_add_key_value_param() warn: argument 4 to %lx specifier is cast from pointer

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:no-previous-prototype-for-amdgpu_dm_connector_funcs_force
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- arc-allyesconfig
|   |-- drivers-base-regmap-regcache-maple.c:warning:lower_index-is-used-uninitialized
|   |-- drivers-base-regmap-regcache-maple.c:warning:lower_last-is-used-uninitialized
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:no-previous-prototype-for-amdgpu_dm_connector_funcs_force
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- arc-randconfig-r012-20230426
|   |-- drivers-base-regmap-regcache-maple.c:warning:lower_index-is-used-uninitialized
|   `-- drivers-base-regmap-regcache-maple.c:warning:lower_last-is-used-uninitialized
|-- arc-randconfig-r021-20230426
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- arc-randconfig-r043-20230426
|   |-- drivers-base-regmap-regcache-maple.c:warning:lower_index-is-used-uninitialized
|   `-- drivers-base-regmap-regcache-maple.c:warning:lower_last-is-used-uninitialized
|-- arc-randconfig-s053-20230426
|   |-- drivers-base-regmap-regcache-maple.c:warning:lower_index-is-used-uninitialized
|   `-- drivers-base-regmap-regcache-maple.c:warning:lower_last-is-used-uninitialized
|-- arm-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:no-previous-prototype-for-amdgpu_dm_connector_funcs_force
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- arm-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:no-previous-prototype-for-amdgpu_dm_connector_funcs_force
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- arm64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:no-previous-prototype-for-amdgpu_dm_connector_funcs_force
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- i386-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:no-previous-prototype-for-amdgpu_dm_connector_funcs_force
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- i386-randconfig-a003
|   `-- fs-ext4-super.c:warning:unused-variable-i
|-- i386-randconfig-a014
|   `-- fs-ext4-super.c:warning:unused-variable-i
|-- i386-randconfig-a016
|   `-- fs-ext4-super.c:warning:unused-variable-i
|-- i386-randconfig-c021
|   `-- fs-ext4-super.c:warning:unused-variable-i
|-- i386-randconfig-m021
|   |-- drivers-acpi-property.c-acpi_data_prop_read_single()-error:potentially-dereferencing-uninitialized-obj-.
|   `-- drivers-crypto-intel-qat-qat_common-adf_cfg.c-adf_cfg_add_key_value_param()-warn:argument-to-lx-specifier-is-cast-from-pointer
|-- ia64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:no-previous-prototype-for-amdgpu_dm_connector_funcs_force
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- ia64-randconfig-c041-20230426
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:no-previous-prototype-for-amdgpu_dm_connector_funcs_force
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- ia64-randconfig-r006-20230426
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:no-previous-prototype-for-amdgpu_dm_connector_funcs_force
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- loongarch-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:no-previous-prototype-for-amdgpu_dm_connector_funcs_force
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- loongarch-defconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:no-previous-prototype-for-amdgpu_dm_connector_funcs_force
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- mips-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:no-previous-prototype-for-amdgpu_dm_connector_funcs_force
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- mips-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:no-previous-prototype-for-amdgpu_dm_connector_funcs_force
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- powerpc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:no-previous-prototype-for-amdgpu_dm_connector_funcs_force
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- riscv-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:no-previous-prototype-for-amdgpu_dm_connector_funcs_force
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- riscv-randconfig-r042-20230426
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- s390-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:no-previous-prototype-for-amdgpu_dm_connector_funcs_force
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- s390-randconfig-r011-20230426
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- s390-randconfig-r044-20230426
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:no-previous-prototype-for-amdgpu_dm_connector_funcs_force
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- sparc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:no-previous-prototype-for-amdgpu_dm_connector_funcs_force
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- sparc-randconfig-c44-20230426
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- x86_64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:no-previous-prototype-for-amdgpu_dm_connector_funcs_force
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:no-previous-prototype-for-gfx_v9_4_3_disable_gpa_mode
|-- x86_64-randconfig-a002
|   `-- fs-ext4-super.c:warning:unused-variable-i
`-- x86_64-randconfig-m001
    `-- drivers-acpi-property.c-acpi_data_prop_read_single()-error:potentially-dereferencing-uninitialized-obj-.
clang_recent_errors
|-- hexagon-randconfig-r035-20230426
|   |-- drivers-bluetooth-btnxpuart.c:warning:unused-variable-nxpuart_of_match_table
|   `-- drivers-watchdog-starfive-wdt.c:warning:unused-variable-starfive_wdt_match
|-- i386-randconfig-a002
|   `-- fs-ext4-super.c:warning:unused-variable-i
|-- x86_64-randconfig-a012
|   `-- fs-ext4-super.c:warning:unused-variable-i
`-- x86_64-randconfig-a014
    `-- fs-ext4-super.c:warning:unused-variable-i

elapsed time: 734m

configs tested: 121
configs skipped: 8

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              alldefconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r002-20230426   gcc  
arc                  randconfig-r012-20230426   gcc  
arc                  randconfig-r013-20230426   gcc  
arc                  randconfig-r021-20230426   gcc  
arc                  randconfig-r043-20230426   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         bcm2835_defconfig   clang
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230426   clang
arm                           stm32_defconfig   gcc  
arm                       versatile_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r032-20230426   gcc  
hexagon              randconfig-r035-20230426   clang
hexagon              randconfig-r041-20230426   clang
hexagon              randconfig-r045-20230426   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r006-20230426   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r022-20230426   gcc  
loongarch            randconfig-r036-20230426   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r015-20230426   gcc  
microblaze           randconfig-r024-20230426   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r006-20230426   gcc  
mips                  cavium_octeon_defconfig   clang
mips                      pic32mzda_defconfig   clang
mips                 randconfig-r031-20230426   gcc  
mips                 randconfig-r033-20230426   gcc  
nios2        buildonly-randconfig-r001-20230426   gcc  
nios2                               defconfig   gcc  
openrisc     buildonly-randconfig-r002-20230426   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc             randconfig-r001-20230426   gcc  
openrisc             randconfig-r025-20230426   gcc  
openrisc             randconfig-r034-20230426   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r005-20230426   gcc  
parisc64                            defconfig   gcc  
powerpc                      acadia_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                       ebony_defconfig   clang
powerpc                 linkstation_defconfig   gcc  
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc                  mpc885_ads_defconfig   clang
powerpc              randconfig-r004-20230426   clang
powerpc              randconfig-r023-20230426   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                randconfig-r042-20230426   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r011-20230426   gcc  
s390                 randconfig-r044-20230426   gcc  
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r004-20230426   gcc  
sh                                  defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7705_defconfig   gcc  
sh                           se7721_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r003-20230426   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r016-20230426   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
