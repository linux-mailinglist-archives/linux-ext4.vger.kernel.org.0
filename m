Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B764F4D2967
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Mar 2022 08:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiCIHXC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Mar 2022 02:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiCIHXC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Mar 2022 02:23:02 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B0910A7E5;
        Tue,  8 Mar 2022 23:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646810524; x=1678346524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8P15gyfMQXBcZtwt5sBe3cAJYWyxAa9xsRjkNdIfHfs=;
  b=c4rfCkKtxWbo2cNwGtazxDrff4PLQO3Bd8dSZnzZ15U0A7hK6JaOdK3T
   lM/OMA3SewgeGxHgAnLKnvFUWIs8F64MgNzs7OG/4mUx/+cPfibUDYGrz
   oc4oQuPihxkWXArRQIP710+6KzgFyOjaxYftaLTIXpxH82iiNA9YnWKpm
   6awFm3cP03W8tsLb6VfxR67yip3BSl0uUXk9CJrGfewQPMqAzOEWQZJYG
   sjleyWoz9tViXjnwGsUysmYd9xpoiC4dngT2oxOEEnzH4GGxpKfXogBIf
   AOdNJOuLqcTz4OUPLtj5HxlS7991m738MjwNYN2gXRfv8KY4F60roK1SL
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="234860537"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="234860537"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 23:22:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="814643883"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 08 Mar 2022 23:21:57 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRqdw-0002pB-R8; Wed, 09 Mar 2022 07:21:56 +0000
Date:   Wed, 9 Mar 2022 15:21:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Byungchul Park <byungchul.park@lge.com>,
        torvalds@linux-foundation.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org, will@kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org, joel@joelfernandes.org,
        sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        bfields@fieldses.org, gregkh@linuxfoundation.org,
        kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org
Subject: Re: [PATCH v4 02/24] dept: Implement Dept(Dependency Tracker)
Message-ID: <202203091550.PnufQ7gO-lkp@intel.com>
References: <1646377603-19730-3-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646377603-19730-3-git-send-email-byungchul.park@lge.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
[cannot apply to tip/locking/core hnaz-mm/master next-20220308]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Byungchul-Park/DEPT-Dependency-Tracker/20220304-150943
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 25795ef6299f07ce3838f3253a9cb34f64efcfae
config: hexagon-randconfig-r022-20220307 (https://download.01.org/0day-ci/archive/20220309/202203091550.PnufQ7gO-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/387c58f459c6eb2a17a99b6c42ad57512a917d5d
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Byungchul-Park/DEPT-Dependency-Tracker/20220304-150943
        git checkout 387c58f459c6eb2a17a99b6c42ad57512a917d5d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/target/ kernel/dependency/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/dependency/dept.c:2093:6: warning: no previous prototype for function '__dept_wait' [-Wmissing-prototypes]
   void __dept_wait(struct dept_map *m, unsigned long w_f, unsigned long ip,
        ^
   kernel/dependency/dept.c:2093:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __dept_wait(struct dept_map *m, unsigned long w_f, unsigned long ip,
   ^
   static 
   In file included from kernel/dependency/dept.c:2532:
>> kernel/dependency/dept_hash.h:9:1: warning: format specifies type 'size_t' (aka 'unsigned int') but the argument has type 'unsigned long' [-Wformat]
   HASH(dep, 12)
   ^~~~~~~~~~~~~
   kernel/dependency/dept.c:2531:14: note: expanded from macro 'HASH'
                  #id, B2KB(sizeof(struct hlist_head) * (1UL << bits)));
                  ~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:519:34: note: expanded from macro 'pr_info'
           printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   kernel/dependency/dept.c:2497:17: note: expanded from macro 'B2KB'
   #define B2KB(B) ((B) / 1024)
                   ^~~~~~~~~~~~
   In file included from kernel/dependency/dept.c:2532:
   kernel/dependency/dept_hash.h:10:1: warning: format specifies type 'size_t' (aka 'unsigned int') but the argument has type 'unsigned long' [-Wformat]
   HASH(class, 12)
   ^~~~~~~~~~~~~~~
   kernel/dependency/dept.c:2531:14: note: expanded from macro 'HASH'
                  #id, B2KB(sizeof(struct hlist_head) * (1UL << bits)));
                  ~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:519:34: note: expanded from macro 'pr_info'
           printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   kernel/dependency/dept.c:2497:17: note: expanded from macro 'B2KB'
   #define B2KB(B) ((B) / 1024)
                   ^~~~~~~~~~~~
   3 warnings generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for FRAME_POINTER
   Depends on DEBUG_KERNEL && (M68K || UML || SUPERH) || ARCH_WANT_FRAME_POINTERS
   Selected by
   - DEPT && DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT && !MIPS && !PPC && !ARM && !S390 && !MICROBLAZE && !ARC && !X86


vim +/__dept_wait +2093 kernel/dependency/dept.c

  2092	
> 2093	void __dept_wait(struct dept_map *m, unsigned long w_f, unsigned long ip,
  2094			 const char *w_fn, int ne)
  2095	{
  2096		int e;
  2097	
  2098		/*
  2099		 * Be as conservative as possible. In case of mulitple waits for
  2100		 * a single dept_map, we are going to keep only the last wait's
  2101		 * wgen for simplicity - keeping all wgens seems overengineering.
  2102		 *
  2103		 * Of course, it might cause missing some dependencies that
  2104		 * would rarely, probabily never, happen but it helps avoid
  2105		 * false positive report.
  2106		 */
  2107		for_each_set_bit(e, &w_f, DEPT_MAX_SUBCLASSES_EVT) {
  2108			struct dept_class *c;
  2109			struct dept_key *k;
  2110	
  2111			k = m->keys ?: &m->keys_local;
  2112			c = check_new_class(&m->keys_local, k,
  2113					    map_sub(m, e), m->name);
  2114			if (!c)
  2115				continue;
  2116	
  2117			add_wait(c, ip, w_fn, ne);
  2118		}
  2119	}
  2120	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
