Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3170067FAF1
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Jan 2023 21:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbjA1Ubv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 Jan 2023 15:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbjA1Ubk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 28 Jan 2023 15:31:40 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505B529E09;
        Sat, 28 Jan 2023 12:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674937865; x=1706473865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KMvQ4PikohERJD+6DblQkrJ3J4O0NmthJ12AQuApcLQ=;
  b=AIF8Usk84yRXoYJ57zIcPQ5uFsLmuR2JKf0UOYFLjLXVBrND1Kti0eTo
   gj8vseWNutTGUrgXijVtmTttjm/LoK7H2Z0+Wp2xR8+Q87BRr+rBaano6
   r3utKS4Z+7Ykxk+zTGDrJeLDwjOzN8rQXeE5SKOUdBVnlG6SH3U2wYh3m
   /4FvTRRqGal5bOBLasq5Jmn2MALyNPRUK4GEL/o2uab9EVdU4rDCPW0uQ
   zxOSHIBTYM83nZXlQ/0twk/eoBNBjGrh/oKH+QHJUcg/wm/OHNALNirCh
   cKnc8ZFUUmMpNoKe1pYFAYLyNQmajtpp9RdZ4QTOvOuW9u8KphzNDqF+l
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="325025784"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="325025784"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 12:31:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="837533337"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="837533337"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Jan 2023 12:30:51 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLrqc-00015I-2y;
        Sat, 28 Jan 2023 20:30:50 +0000
Date:   Sun, 29 Jan 2023 04:30:30 +0800
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
Subject: Re: [PATCH v8 25/25] dept: Track the potential waits of
 PG_{locked,writeback}
Message-ID: <202301290402.j3poWc84-lkp@intel.com>
References: <1674782358-25542-26-git-send-email-max.byungchul.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674782358-25542-26-git-send-email-max.byungchul.park@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
patch link:    https://lore.kernel.org/r/1674782358-25542-26-git-send-email-max.byungchul.park%40gmail.com
patch subject: [PATCH v8 25/25] dept: Track the potential waits of PG_{locked,writeback}
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20230129/202301290402.j3poWc84-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ba934a05473c5212edeff20f2298a249bfe87351
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Byungchul-Park/llist-Move-llist_-head-node-definition-to-types-h/20230128-102456
        git checkout ba934a05473c5212edeff20f2298a249bfe87351
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "PG_locked_map" [mm/zsmalloc.ko] undefined!
>> ERROR: modpost: "PG_locked_map" [mm/z3fold.ko] undefined!
>> ERROR: modpost: "PG_locked_map" [fs/reiserfs/reiserfs.ko] undefined!
>> ERROR: modpost: "PG_locked_map" [fs/ext4/ext4.ko] undefined!
>> ERROR: modpost: "PG_locked_map" [fs/ext2/ext2.ko] undefined!
>> ERROR: modpost: "PG_locked_map" [fs/jbd2/jbd2.ko] undefined!
>> ERROR: modpost: "PG_locked_map" [fs/minix/minix.ko] undefined!
>> ERROR: modpost: "PG_locked_map" [fs/ecryptfs/ecryptfs.ko] undefined!
>> ERROR: modpost: "PG_locked_map" [fs/nfs/nfs.ko] undefined!
>> ERROR: modpost: "PG_locked_map" [fs/sysv/sysv.ko] undefined!
WARNING: modpost: suppressed 44 unresolved symbol warnings because there were too many)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
