Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB7D6D0A82
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Mar 2023 17:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbjC3P5a (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Mar 2023 11:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbjC3P5a (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 30 Mar 2023 11:57:30 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D96B10C4;
        Thu, 30 Mar 2023 08:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680191849; x=1711727849;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yewbTr0pQ+oC1FbnuuY+aaJjtcnB2/gFXv8AOAt+sQE=;
  b=KD4/dU4SH1pVCox2bvAHGHeUagjnMbLvPrZRBUjpD1ESMBJKLfwwbvFH
   IY443USq5SMqocDPFLyRbEWgM2RqEZLqWcvqiAFZNk9ufRKLnkjSRIaVC
   C29Nrti9sC3udohbWeOEVOthywmhnLXUhldvMIP1cZNXu3kub5kDtFEEX
   +9N0OFN/Q0jmhtfQ8Ysfi4thutjg6O0sB7QvZtEaUGXFQZHyuBvaf2K5F
   S9aKnT0xkqmNQkuzcBMzyDepGsocTzBBLujbvgZztdSxWUB0cd96cI77P
   K+BoTrPQ2qgSj0ah7Ngaw5MkiIMv18kO5ehIjClCv+Xv9rnL3OLd9++Rn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="320861249"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="320861249"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 08:57:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="930775185"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="930775185"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 30 Mar 2023 08:57:02 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phue3-000Ky8-10;
        Thu, 30 Mar 2023 15:56:59 +0000
Date:   Thu, 30 Mar 2023 23:56:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Triplett <josh@joshtriplett.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] ext4: Add a uapi header for ext4 userspace APIs
Message-ID: <202303302331.taAOklAx-lkp@intel.com>
References: <f0c650c0a0bcc799101573d265f3006c6f6bd046.1680149153.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0c650c0a0bcc799101573d265f3006c6f6bd046.1680149153.git.josh@joshtriplett.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Josh,

I love your patch! Yet something to improve:

[auto build test ERROR on tytso-ext4/dev]
[also build test ERROR on linus/master v6.3-rc4 next-20230330]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Josh-Triplett/ext4-Add-a-uapi-header-for-ext4-userspace-APIs/20230330-123712
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/f0c650c0a0bcc799101573d265f3006c6f6bd046.1680149153.git.josh%40joshtriplett.org
patch subject: [PATCH] ext4: Add a uapi header for ext4 userspace APIs
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20230330/202303302331.taAOklAx-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/9e61a3eab96b327fb2392b2ae665c6bc25e4b004
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Josh-Triplett/ext4-Add-a-uapi-header-for-ext4-userspace-APIs/20230330-123712
        git checkout 9e61a3eab96b327fb2392b2ae665c6bc25e4b004
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303302331.taAOklAx-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/ext4.h:7:10: fatal error: uapi/linux/fiemap.h: No such file or directory
       7 | #include <uapi/linux/fiemap.h>
         |          ^~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
