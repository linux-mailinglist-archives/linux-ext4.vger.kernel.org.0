Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487F367F582
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Jan 2023 08:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjA1HZd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 Jan 2023 02:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbjA1HZc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 28 Jan 2023 02:25:32 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDA784B52;
        Fri, 27 Jan 2023 23:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674890730; x=1706426730;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eDXPzbDiWfsbEwXkYaH34SmQGKn8//5UxGIVNNo7RcU=;
  b=IH//ZbjhgJq3d9Dw6ZBGyuGxPitojL7VS1cdD16Flh5TdTJg10WOyQi1
   cK/w262CleWo8JWxA4Y+GVPjh3oEz67skjsB7zcp09AaeQyxX4xhgyr8o
   bNpbH8H18W1ptwz11efZpV1jIxYgdCd6TAx8pJdr7zocLVe6GLQTg7/QY
   j1UiuE0TaiHfu3xV6XX0YBAMqagX8eaGoSJckGUpGCkXUOgQ42OuuAZFl
   xvvvqVyVNiPYKTUZGjXCuh461BAJd5K6/H62mjktHs8KxOmwvzNHJues4
   lpcIw/H/kN6EQl09t0JOEI5RJCrhxyh9rqdYzWBYTXMbvL4+KtDBstJib
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="315225924"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="315225924"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 23:25:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="663539356"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="663539356"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 27 Jan 2023 23:25:22 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLfaS-0000U6-36;
        Sat, 28 Jan 2023 07:25:20 +0000
Date:   Sat, 28 Jan 2023 15:24:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Byungchul Park <max.byungchul.park@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, torvalds@linux-foundation.org,
        damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, will@kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org, joel@joelfernandes.org,
        sashal@kernel.org, daniel.vetter@ffwll.ch, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org
Subject: Re: [PATCH v8 05/25] dept: Tie to Lockdep and IRQ tracing
Message-ID: <202301281551.sSDuxg0O-lkp@intel.com>
References: <1674782358-25542-6-git-send-email-max.byungchul.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674782358-25542-6-git-send-email-max.byungchul.park@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Byungchul,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/locking/core]
[also build test ERROR on tip/sched/core drm-misc/drm-misc-next linus/master v6.2-rc5 next-20230127]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Byungchul-Park/llist-Move-llist_-head-node-definition-to-types-h/20230128-102456
patch link:    https://lore.kernel.org/r/1674782358-25542-6-git-send-email-max.byungchul.park%40gmail.com
patch subject: [PATCH v8 05/25] dept: Tie to Lockdep and IRQ tracing
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20230128/202301281551.sSDuxg0O-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/aed5169e3b6767146ee602447fcf75b4c734d2db
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Byungchul-Park/llist-Move-llist_-head-node-definition-to-types-h/20230128-102456
        git checkout aed5169e3b6767146ee602447fcf75b4c734d2db
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc prepare

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/bitops.h:68,
                    from include/linux/kernel.h:22,
                    from include/linux/irqflags.h:16,
                    from include/asm-generic/cmpxchg-local.h:6,
                    from arch/parisc/include/asm/cmpxchg.h:89,
                    from arch/parisc/include/asm/atomic.h:10,
                    from include/linux/atomic.h:7,
                    from include/linux/rcupdate.h:25,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/parisc/kernel/asm-offsets.c:18:
   arch/parisc/include/asm/bitops.h: In function 'set_bit':
>> arch/parisc/include/asm/bitops.h:27:9: error: implicit declaration of function '_atomic_spin_lock_irqsave'; did you mean '__atomic_is_lock_free'? [-Werror=implicit-function-declaration]
      27 |         _atomic_spin_lock_irqsave(addr, flags);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
         |         __atomic_is_lock_free
>> arch/parisc/include/asm/bitops.h:29:9: error: implicit declaration of function '_atomic_spin_unlock_irqrestore' [-Werror=implicit-function-declaration]
      29 |         _atomic_spin_unlock_irqrestore(addr, flags);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/parisc/include/asm/bitops.h:204:
   include/asm-generic/bitops/lock.h: In function 'arch_test_and_set_bit_lock':
>> include/asm-generic/bitops/lock.h:28:15: error: implicit declaration of function 'arch_atomic_long_fetch_or_acquire' [-Werror=implicit-function-declaration]
      28 |         old = arch_atomic_long_fetch_or_acquire(mask, (atomic_long_t *)p);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/asm-generic/bitops/lock.h:28:56: error: 'atomic_long_t' undeclared (first use in this function); did you mean 'atomic_t'?
      28 |         old = arch_atomic_long_fetch_or_acquire(mask, (atomic_long_t *)p);
         |                                                        ^~~~~~~~~~~~~
         |                                                        atomic_t
   include/asm-generic/bitops/lock.h:28:56: note: each undeclared identifier is reported only once for each function it appears in
>> include/asm-generic/bitops/lock.h:28:71: error: expected expression before ')' token
      28 |         old = arch_atomic_long_fetch_or_acquire(mask, (atomic_long_t *)p);
         |                                                                       ^
   include/asm-generic/bitops/lock.h: In function 'arch_clear_bit_unlock':
>> include/asm-generic/bitops/lock.h:44:9: error: implicit declaration of function 'arch_atomic_long_fetch_andnot_release' [-Werror=implicit-function-declaration]
      44 |         arch_atomic_long_fetch_andnot_release(BIT_MASK(nr), (atomic_long_t *)p);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/bitops/lock.h:44:62: error: 'atomic_long_t' undeclared (first use in this function); did you mean 'atomic_t'?
      44 |         arch_atomic_long_fetch_andnot_release(BIT_MASK(nr), (atomic_long_t *)p);
         |                                                              ^~~~~~~~~~~~~
         |                                                              atomic_t
   include/asm-generic/bitops/lock.h:44:77: error: expected expression before ')' token
      44 |         arch_atomic_long_fetch_andnot_release(BIT_MASK(nr), (atomic_long_t *)p);
         |                                                                             ^
   include/asm-generic/bitops/lock.h: In function 'arch___clear_bit_unlock':
>> include/asm-generic/bitops/lock.h:66:9: error: implicit declaration of function 'arch_atomic_long_set_release' [-Werror=implicit-function-declaration]
      66 |         arch_atomic_long_set_release((atomic_long_t *)p, old);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/bitops/lock.h:66:39: error: 'atomic_long_t' undeclared (first use in this function); did you mean 'atomic_t'?
      66 |         arch_atomic_long_set_release((atomic_long_t *)p, old);
         |                                       ^~~~~~~~~~~~~
         |                                       atomic_t
   include/asm-generic/bitops/lock.h:66:54: error: expected expression before ')' token
      66 |         arch_atomic_long_set_release((atomic_long_t *)p, old);
         |                                                      ^
   include/asm-generic/bitops/lock.h: In function 'arch_clear_bit_unlock_is_negative_byte':
   include/asm-generic/bitops/lock.h:86:60: error: 'atomic_long_t' undeclared (first use in this function); did you mean 'atomic_t'?
      86 |         old = arch_atomic_long_fetch_andnot_release(mask, (atomic_long_t *)p);
         |                                                            ^~~~~~~~~~~~~
         |                                                            atomic_t
   include/asm-generic/bitops/lock.h:86:75: error: expected expression before ')' token
      86 |         old = arch_atomic_long_fetch_andnot_release(mask, (atomic_long_t *)p);
         |                                                                           ^
   In file included from include/linux/atomic.h:81:
   include/linux/atomic/atomic-long.h: At top level:
>> include/linux/atomic/atomic-long.h:539:1: warning: conflicting types for 'arch_atomic_long_set_release'; have 'void(atomic_long_t *, long int)' {aka 'void(atomic_t *, long int)'}
     539 | arch_atomic_long_set_release(atomic_long_t *v, long i)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/atomic/atomic-long.h:539:1: error: static declaration of 'arch_atomic_long_set_release' follows non-static declaration
   include/asm-generic/bitops/lock.h:66:9: note: previous implicit declaration of 'arch_atomic_long_set_release' with type 'void(atomic_long_t *, long int)' {aka 'void(atomic_t *, long int)'}
      66 |         arch_atomic_long_set_release((atomic_long_t *)p, old);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/atomic/atomic-long.h:809:1: error: conflicting types for 'arch_atomic_long_fetch_andnot_release'; have 'long int(long int,  atomic_long_t *)' {aka 'long int(long int,  atomic_t *)'}
     809 | arch_atomic_long_fetch_andnot_release(long i, atomic_long_t *v)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/bitops/lock.h:44:9: note: previous implicit declaration of 'arch_atomic_long_fetch_andnot_release' with type 'int()'
      44 |         arch_atomic_long_fetch_andnot_release(BIT_MASK(nr), (atomic_long_t *)p);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/atomic/atomic-long.h:833:1: error: conflicting types for 'arch_atomic_long_fetch_or_acquire'; have 'long int(long int,  atomic_long_t *)' {aka 'long int(long int,  atomic_t *)'}
     833 | arch_atomic_long_fetch_or_acquire(long i, atomic_long_t *v)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/bitops/lock.h:28:15: note: previous implicit declaration of 'arch_atomic_long_fetch_or_acquire' with type 'int()'
      28 |         old = arch_atomic_long_fetch_or_acquire(mask, (atomic_long_t *)p);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:114: arch/parisc/kernel/asm-offsets.s] Error 1
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:1298: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:242: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +27 arch/parisc/include/asm/bitops.h

^1da177e4c3f41 include/asm-parisc/bitops.h      Linus Torvalds 2005-04-16  14  
a366064c3ff46c include/asm-parisc/bitops.h      Grant Grundler 2005-10-21  15  /* See http://marc.theaimsgroup.com/?t=108826637900003 for discussion
a366064c3ff46c include/asm-parisc/bitops.h      Grant Grundler 2005-10-21  16   * on use of volatile and __*_bit() (set/clear/change):
a366064c3ff46c include/asm-parisc/bitops.h      Grant Grundler 2005-10-21  17   *	*_bit() want use of volatile.
a366064c3ff46c include/asm-parisc/bitops.h      Grant Grundler 2005-10-21  18   *	__*_bit() are "relaxed" and don't use spinlock or volatile.
a366064c3ff46c include/asm-parisc/bitops.h      Grant Grundler 2005-10-21  19   */
a366064c3ff46c include/asm-parisc/bitops.h      Grant Grundler 2005-10-21  20  
a366064c3ff46c include/asm-parisc/bitops.h      Grant Grundler 2005-10-21  21  static __inline__ void set_bit(int nr, volatile unsigned long * addr)
^1da177e4c3f41 include/asm-parisc/bitops.h      Linus Torvalds 2005-04-16  22  {
208151bfb70fb7 arch/parisc/include/asm/bitops.h Helge Deller   2020-06-14  23  	unsigned long mask = BIT_MASK(nr);
^1da177e4c3f41 include/asm-parisc/bitops.h      Linus Torvalds 2005-04-16  24  	unsigned long flags;
^1da177e4c3f41 include/asm-parisc/bitops.h      Linus Torvalds 2005-04-16  25  
208151bfb70fb7 arch/parisc/include/asm/bitops.h Helge Deller   2020-06-14  26  	addr += BIT_WORD(nr);
^1da177e4c3f41 include/asm-parisc/bitops.h      Linus Torvalds 2005-04-16 @27  	_atomic_spin_lock_irqsave(addr, flags);
^1da177e4c3f41 include/asm-parisc/bitops.h      Linus Torvalds 2005-04-16  28  	*addr |= mask;
^1da177e4c3f41 include/asm-parisc/bitops.h      Linus Torvalds 2005-04-16 @29  	_atomic_spin_unlock_irqrestore(addr, flags);
^1da177e4c3f41 include/asm-parisc/bitops.h      Linus Torvalds 2005-04-16  30  }
^1da177e4c3f41 include/asm-parisc/bitops.h      Linus Torvalds 2005-04-16  31  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
