Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C12A5749EC
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Jul 2022 12:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbiGNKBM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Jul 2022 06:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235515AbiGNKBK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Jul 2022 06:01:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C449237
        for <linux-ext4@vger.kernel.org>; Thu, 14 Jul 2022 03:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657792870; x=1689328870;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=efDAd+7JgTLKjA9wG2qUW/eO+wkP/iHL17gNm1UCSfs=;
  b=NY2eWcq9dZNV329PHsvhC42XdcEIhfEp1M/IezLkF2fX+tf1zNx40x9v
   OFVkyiB+NFCuCj4djrniOer7bDT3yH/2UKk9tIw4MRLiH+vyjEYlUymkN
   uh/kQazzrPbAX+RtL9cObXUtrIWxwM4qFKd1Iqi3uF2nPnyfcC/lfOEsV
   2Zh8i0WhXhw04LqwHnJGEuMYC72aYQA/GqUTf/l11VJD1HzT8komO7Lj3
   F/aw29SiLLu7ODDCBmKsAstL6bPI6bQUQAf9Sn3evEKkDfrAwNsFQ4mVi
   sTNWsmFQtCGne2gKAnMQRXeSwd2/3U/YvegswdCm8vIQA6l8UCSljAG93
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="265258444"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="265258444"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 03:01:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="722668106"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 14 Jul 2022 03:01:08 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBved-0000QA-GD;
        Thu, 14 Jul 2022 10:01:07 +0000
Date:   Thu, 14 Jul 2022 18:00:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Artem Blagodarenko <artem.blagodarenko@gmail.com>,
        linux-ext4@vger.kernel.org
Cc:     kbuild-all@lists.01.org, adilger.kernel@dilger.ca,
        andrew.perepechko@hpe.com,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>
Subject: Re: [PATCH v4] ext4: truncate during setxattr leads to kernel panic
Message-ID: <202207141731.mergfpu3-lkp@intel.com>
References: <20220711145735.53676-1-artem.blagodarenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711145735.53676-1-artem.blagodarenko@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Artem,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tytso-ext4/dev]
[also build test WARNING on linus/master v5.19-rc6 next-20220713]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Artem-Blagodarenko/ext4-truncate-during-setxattr-leads-to-kernel-panic/20220711-232350
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
config: um-x86_64_defconfig (https://download.01.org/0day-ci/archive/20220714/202207141731.mergfpu3-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/600aeea1cc6d36f380862bb88e50b670e0a57e4f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Artem-Blagodarenko/ext4-truncate-during-setxattr-leads-to-kernel-panic/20220711-232350
        git checkout 600aeea1cc6d36f380862bb88e50b670e0a57e4f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 SHELL=/bin/bash fs/ext4/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/ext4/xattr.c:1563:15: warning: no previous prototype for 'delayed_iput' [-Wmissing-prototypes]
    1563 | noinline void delayed_iput(struct inode *inode, struct delayed_iput_work *work)
         |               ^~~~~~~~~~~~


vim +/delayed_iput +1563 fs/ext4/xattr.c

  1562	
> 1563	noinline void delayed_iput(struct inode *inode, struct delayed_iput_work *work)
  1564	{
  1565		if (!inode) {
  1566			kfree(work);
  1567			return;
  1568		}
  1569	
  1570		if (!work) {
  1571			iput(inode);
  1572		} else {
  1573			INIT_WORK(&work->work, delayed_iput_fn);
  1574			work->inode = inode;
  1575			queue_work(EXT4_SB(inode->i_sb)->s_misc_wq, &work->work);
  1576		}
  1577	}
  1578	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
