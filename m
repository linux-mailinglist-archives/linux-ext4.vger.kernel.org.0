Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FFE7D28AA
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Oct 2023 04:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjJWCoa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 22 Oct 2023 22:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjJWCo3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 22 Oct 2023 22:44:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBC4D41
        for <linux-ext4@vger.kernel.org>; Sun, 22 Oct 2023 19:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698029067; x=1729565067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HuwvtB7F55bafq5jamX4D2Pola9+EXOFFvR1ZVYonIs=;
  b=N07laSwLBXQFSgVAW3NqkUJMYoFt7cJQOilX/wIMmvobq9z1IOdpqCSF
   0r5n51kNobPWXZjVacxUmL7A377Kak105szPlO8r/jc9DJrWVBHzlHpJc
   EFFsmr/6soE7PUnoSbvjXr9ZmoIr1tU2JxQoXNqpG/n42SR4gLVJmeCbl
   SFtTbp8Zxqx0sQk6GmTiWb5M5cupihm8d8l3bgA/9fZtZsfSB68OuFmSu
   1GqfTT36anTR6EBG+wM2L38xhAwAgK3xvegnmZkqhB2OX1UkturOsR2PW
   YtdN+4QZq5WLvVacuLGqf/hoqKAVoGinSnK6WXRmVwcOyvVszdcWoviD9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="366980923"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="366980923"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 19:44:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="823828569"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="823828569"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 22 Oct 2023 19:44:26 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qukvY-0006Ur-06;
        Mon, 23 Oct 2023 02:44:24 +0000
Date:   Mon, 23 Oct 2023 10:43:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 3/4] ext4: avoid online resizing failures due to
 oversized flex bg
Message-ID: <202310231046.Ctx3aydr-lkp@intel.com>
References: <20231023013057.2117948-4-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023013057.2117948-4-libaokun1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Baokun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tytso-ext4/dev]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Baokun-Li/ext4-unify-the-type-of-flexbg_size-to-unsigned-int/20231023-092711
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20231023013057.2117948-4-libaokun1%40huawei.com
patch subject: [PATCH v2 3/4] ext4: avoid online resizing failures due to oversized flex bg
reproduce: (https://download.01.org/0day-ci/archive/20231023/202310231046.Ctx3aydr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310231046.Ctx3aydr-lkp@intel.com/

# many are suggestions rather than must-fix

WARNING:BLOCK_COMMENT_STYLE: Block comments use * on subsequent lines
#60: FILE: fs/ext4/resize.c:222:
+	ext4_group_t resize_bg;			/* number of allocated
+						   new_group_data */

WARNING:BLOCK_COMMENT_STYLE: Block comments use a trailing */ on a separate line
#60: FILE: fs/ext4/resize.c:222:
+						   new_group_data */

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
