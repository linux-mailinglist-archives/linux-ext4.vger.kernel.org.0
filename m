Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3FB4D3DAF
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Mar 2022 00:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238232AbiCIXpV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Mar 2022 18:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbiCIXpU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Mar 2022 18:45:20 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780D6F9F8E;
        Wed,  9 Mar 2022 15:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646869460; x=1678405460;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rMC+JXijdy5E1AXIX/JZM+A/puBgZ9IUECkOF4wNP8M=;
  b=WgGgvBPuhQjnGVpMXHqRT1HXJsHBRy3MQq9H3/LJA8CmYuVCOn8zzrV/
   AtZSe91vFFY1dQzvT22/GWHAgW/L94BOT1wBigvhtYNVHs06f3FTULCxH
   dddEK+qNgsv5NBvi3KJLfE4Brn20FohiolGuWk1owOk6dktIc0bT2yMRv
   /0kqG0H/4mplGpw2YK+HKekfFZ5rJ6jRfvltJcTPwsgghnJ3OarAeHWKi
   yA20hALUbZQmKc1mMBI862GfN/PkGn7i8Il2ArSNM7FJH+SiSB4iJ9g+D
   HTvae0VNBodgKbCiIf75mMnwkYuMIC83U1yiNyboC67naoIsVhPz0JeST
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="315833917"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="315833917"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 15:44:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="596454793"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 09 Mar 2022 15:44:12 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nS5yW-0003yN-08; Wed, 09 Mar 2022 23:44:12 +0000
Date:   Thu, 10 Mar 2022 07:43:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Byungchul Park <byungchul.park@lge.com>,
        torvalds@linux-foundation.org
Cc:     kbuild-all@lists.01.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        bfields@fieldses.org, gregkh@linuxfoundation.org,
        kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org
Subject: Re: [PATCH v4 02/24] dept: Implement Dept(Dependency Tracker)
Message-ID: <202203100728.FT7RsG8e-lkp@intel.com>
References: <1646377603-19730-3-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646377603-19730-3-git-send-email-byungchul.park@lge.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Byungchul,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on linux/master linus/master v5.17-rc7]
[cannot apply to tip/locking/core hnaz-mm/master next-20220309]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Byungchul-Park/DEPT-Dependency-Tracker/20220304-150943
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 25795ef6299f07ce3838f3253a9cb34f64efcfae
config: i386-randconfig-m031-20220307 (https://download.01.org/0day-ci/archive/20220310/202203100728.FT7RsG8e-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
kernel/dependency/dept.c:2519 dept_init() warn: inconsistent indenting

vim +2519 kernel/dependency/dept.c

  2518	
> 2519		pr_info("DEPendency Tracker: Copyright (c) 2020 LG Electronics, Inc., Byungchul Park\n");

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
