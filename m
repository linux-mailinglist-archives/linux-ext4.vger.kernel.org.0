Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7126B50BE
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Mar 2023 20:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCJTL0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Mar 2023 14:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjCJTLS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Mar 2023 14:11:18 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9867224BE1;
        Fri, 10 Mar 2023 11:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678475463; x=1710011463;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Sj89mkIxbdQ4VKaoPz17QlIBDrLJBxmyjmVCcpHbqlg=;
  b=DnJmjL0Cyx8ol8Ba7siUShOjGeXZqTp6vKnST7n3hw3PY2O9Ulwevfzu
   u/PHebQIKLm0BPbLIR1fNd/bkQxKz/NZAGMhWiDHFJq0EltYYEZj3ahNo
   1oY29gILfPi7SMYR02LwB59s1pJC77Sk2b0cssweQpH32yiG+VoWF8PAQ
   W9uDp2r5LVGdguQijCa39qrS7nNthN4hV5HHObYKMoq0JTSY5XvDV7N8m
   cLH41gs86PSwqumQKBoob7sX3719wENFXS6oOq1MHnbevwVmM/fD9WNiE
   d6rQSpHQXBOTck5qWhZvftEARwtz/VRXTqxdsyd1slMZAnvHAD6lbflTX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="325162142"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="325162142"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 11:08:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="1007230595"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="1007230595"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 10 Mar 2023 11:08:27 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pai6M-00043u-2K;
        Fri, 10 Mar 2023 19:08:26 +0000
Date:   Sat, 11 Mar 2023 03:07:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yangtao Li <frank.li@vivo.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     oe-kbuild-all@lists.linux.dev, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Yangtao Li <frank.li@vivo.com>
Subject: Re: [PATCH] ext4: convert to DIV_ROUND_UP() in
 mpage_process_page_bufs()
Message-ID: <202303110211.LXeNm5uw-lkp@intel.com>
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
config: i386-defconfig (https://download.01.org/0day-ci/archive/20230311/202303110211.LXeNm5uw-lkp@intel.com/config)
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
| Link: https://lore.kernel.org/oe-kbuild-all/202303110211.LXeNm5uw-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: fs/ext4/inode.o: in function `mpage_process_page_bufs':
>> inode.c:(.text+0xbda): undefined reference to `__divdi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
