Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1394BAA1D
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Feb 2022 20:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245349AbiBQTrb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Feb 2022 14:47:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245407AbiBQTrZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Feb 2022 14:47:25 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0157F2654C;
        Thu, 17 Feb 2022 11:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645127230; x=1676663230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TdGisY6DgZWxTVhGQt4rIy2LWkkZcMGDYbmhdspXFUw=;
  b=Dvl6Dc3Ygu3k9jkGn0hYqK0/mk2beQ51fXssvtdZN2vDOKKmkGxmCM4K
   5ko1VrNtp9xXu3lAsvFasd8mytQlcywqYV+OlX9dFitiqCogVbbb86cGL
   aBNi/H4K7C3mRvrQYgSQ5lspL3zQMNnwTUQ7/oqGMP1295f8eGArW7iNg
   Jxdr633unpNrBdcuQY8hk7/wTXAhAx+3FbzHcOCZ2TPFUvgMjoIUPwram
   bNLR3hYEx6QmKGLxRjjpL8TtcNG5Peg1+xxdkbCLbSWwoJvZmMMu6weri
   dfN+BeSj4P6UmWtIFds+kpmFg0l6+PU6mHT/pOC+YGTlKnEN3G1sY183E
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="238363454"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="238363454"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 11:47:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="626224968"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Feb 2022 11:47:01 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKmk1-0000Tr-1I; Thu, 17 Feb 2022 19:47:01 +0000
Date:   Fri, 18 Feb 2022 03:46:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Byungchul Park <byungchul.park@lge.com>,
        torvalds@linux-foundation.org
Cc:     kbuild-all@lists.01.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, will@kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, joel@joelfernandes.org, sashal@kernel.org,
        daniel.vetter@ffwll.ch, chris@chris-wilson.co.uk,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
        amir73il@gmail.com, bfields@fieldses.org,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org
Subject: Re: [PATCH 02/16] dept: Implement Dept(Dependency Tracker)
Message-ID: <202202172345.rVBMAj8W-lkp@intel.com>
References: <1645095472-26530-3-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645095472-26530-3-git-send-email-byungchul.park@lge.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Byungchul,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on hnaz-mm/master linux/master linus/master v5.17-rc4]
[cannot apply to tip/locking/core next-20220217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Byungchul-Park/DEPT-Dependency-Tracker/20220217-190040
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 3624ba7b5e2acc02b01301ea5fd3534971eb9896
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220217/202202172345.rVBMAj8W-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/4d0434b0b917f4374a09f3b75cbcadf148cfa711
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Byungchul-Park/DEPT-Dependency-Tracker/20220217-190040
        git checkout 4d0434b0b917f4374a09f3b75cbcadf148cfa711
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash kernel/dependency/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/dependency/dept.c:2105:6: warning: no previous prototype for '__dept_wait' [-Wmissing-prototypes]
    2105 | void __dept_wait(struct dept_map *m, unsigned long w_f, unsigned long ip,
         |      ^~~~~~~~~~~
   In file included from include/asm-generic/bug.h:22,
                    from arch/sh/include/asm/bug.h:112,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/current.h:5,
                    from ./arch/sh/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from kernel/dependency/dept.c:86:
   kernel/dependency/dept_hash.h: In function 'dept_init':
>> include/linux/kern_levels.h:5:25: warning: format '%zu' expects argument of type 'size_t', but argument 3 has type 'long unsigned int' [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:519:9: note: in expansion of macro 'printk'
     519 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:14:25: note: in expansion of macro 'KERN_SOH'
      14 | #define KERN_INFO       KERN_SOH "6"    /* informational */
         |                         ^~~~~~~~
   include/linux/printk.h:519:16: note: in expansion of macro 'KERN_INFO'
     519 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~~
   kernel/dependency/dept.c:2579:9: note: in expansion of macro 'pr_info'
    2579 |         pr_info("... hash list head used by %s: %zu KB\n",              \
         |         ^~~~~~~
   kernel/dependency/dept_hash.h:9:1: note: in expansion of macro 'HASH'
       9 | HASH(dep, 12)
         | ^~~~
>> include/linux/kern_levels.h:5:25: warning: format '%zu' expects argument of type 'size_t', but argument 3 has type 'long unsigned int' [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:519:9: note: in expansion of macro 'printk'
     519 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:14:25: note: in expansion of macro 'KERN_SOH'
      14 | #define KERN_INFO       KERN_SOH "6"    /* informational */
         |                         ^~~~~~~~
   include/linux/printk.h:519:16: note: in expansion of macro 'KERN_INFO'
     519 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~~
   kernel/dependency/dept.c:2579:9: note: in expansion of macro 'pr_info'
    2579 |         pr_info("... hash list head used by %s: %zu KB\n",              \
         |         ^~~~~~~
   kernel/dependency/dept_hash.h:10:1: note: in expansion of macro 'HASH'
      10 | HASH(class, 12)
         | ^~~~


vim +/__dept_wait +2105 kernel/dependency/dept.c

  2104	
> 2105	void __dept_wait(struct dept_map *m, unsigned long w_f, unsigned long ip,
  2106			 const char *w_fn, int ne)
  2107	{
  2108		int e;
  2109	
  2110		/*
  2111		 * Be as conservative as possible. In case of mulitple waits for
  2112		 * a single dept_map, we are going to keep only the last wait's
  2113		 * wgen for simplicity - keeping all wgens seems overengineering.
  2114		 *
  2115		 * Of course, it might cause missing some dependencies that
  2116		 * would rarely, probabily never, happen but it helps avoid
  2117		 * false positive report.
  2118		 */
  2119		for_each_set_bit(e, &w_f, DEPT_MAX_SUBCLASSES_EVT) {
  2120			struct dept_class *c;
  2121			struct dept_key *k;
  2122	
  2123			k = m->keys ?: &m->keys_local;
  2124			c = check_new_class(&m->keys_local, k,
  2125					    map_sub(m, e), m->name);
  2126			if (!c)
  2127				continue;
  2128	
  2129			add_wait(c, ip, w_fn, ne);
  2130		}
  2131	}
  2132	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
