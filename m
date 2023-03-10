Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E57D6B510B
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Mar 2023 20:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCJTib (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Mar 2023 14:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjCJTib (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Mar 2023 14:38:31 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F09D5B430;
        Fri, 10 Mar 2023 11:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678477110; x=1710013110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SFrSHn6wWTytcNJCIUp5rOcYiQP4rHp4kuKwJv6VehU=;
  b=kn2fHtdR8sxA3DCGkgWR5qh8gSikMsCfghC4jPxtTyb7ujJblkkZ0Fxu
   QI9nkmtKfuWI9QOeEllidMrtebaWEs2q/Ynlg9R5tPAjcb8UDlJrE7wA6
   FVQHCqevmyeI375jZmNYbahOGUMesQt1zKPrp0FjGn4Rv+Vv5CIgkW4Wt
   rzjkeEGs34yeKZCIVatHVHF7EGsPuF0+4KEFe7fwIYvdMo7KG4O1uWCBP
   BgpDpbD2uXc0gC7IaZXqns/daV6jWOilBGrGfWZo9ERJ+oje4shoCMIHV
   J/DbMjtdwD2zFmw6IDTDDrhH9iP4iXuiErrmKBZpwyZo5KOSZ9KFMWTlU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="364469041"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="364469041"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 11:38:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="627922741"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="627922741"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 10 Mar 2023 11:38:27 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1paiZP-00044V-0z;
        Fri, 10 Mar 2023 19:38:27 +0000
Date:   Sat, 11 Mar 2023 03:38:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yangtao Li <frank.li@vivo.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     oe-kbuild-all@lists.linux.dev, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Yangtao Li <frank.li@vivo.com>
Subject: Re: [PATCH] ext4: convert to DIV_ROUND_UP() in
 mpage_process_page_bufs()
Message-ID: <202303110358.NxL6UI32-lkp@intel.com>
References: <20230310060734.8780-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310060734.8780-1-frank.li@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Yangtao,

I love your patch! Yet something to improve:

[auto build test ERROR on tytso-ext4/dev]
[also build test ERROR on linus/master v6.3-rc1 next-20230310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yangtao-Li/ext4-convert-to-DIV_ROUND_UP-in-mpage_process_page_bufs/20230310-140903
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20230310060734.8780-1-frank.li%40vivo.com
patch subject: [PATCH] ext4: convert to DIV_ROUND_UP() in mpage_process_page_bufs()
config: i386-debian-10.3 (https://download.01.org/0day-ci/archive/20230311/202303110358.NxL6UI32-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/f4d2db5f59592a5688be6e4d2d3dd6f3f94d4f96
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yangtao-Li/ext4-convert-to-DIV_ROUND_UP-in-mpage_process_page_bufs/20230310-140903
        git checkout f4d2db5f59592a5688be6e4d2d3dd6f3f94d4f96
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303110358.NxL6UI32-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__divdi3" [fs/ext4/ext4.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
