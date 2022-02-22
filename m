Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594494C01FF
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Feb 2022 20:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbiBVT00 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Feb 2022 14:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiBVT0Z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 22 Feb 2022 14:26:25 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BDB674D0;
        Tue, 22 Feb 2022 11:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645557959; x=1677093959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=je6pxxUyucOKnuMDKEdXL57fjZykpHI9O7enNl2qahg=;
  b=dIcq6AAHzVgb5fElyNsE0G6LIO3Kix6CGVD5xqFLx48XHPLcoOSgFLWF
   4sXAtaZ7HVoEW5AaH97pS9hS6WK3Oewjgvo3wmFSKTxRp0KbolmnGHJIS
   dWxi6YeOEZFDEJoLkFHwf/sQ8LrSMDt4yDeiU6VAMYl3b1X7cTAKWejY8
   rqNs/neohk6LpZeSCXU/8QHLZdGzq5Yl0hzMeL/pCnZYRdC0UPvoTOvRY
   p2ABUbrJjo0/lgJHFV1oot3YZdeF3msMB12CHazQhUBGK4oOpaPV+/FJW
   CQGaiD9akg3BcxxwaUv/oM+JtDxoQZ/8NFetHzl55GM82hv8t2gJ6BceK
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="276400870"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="276400870"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 11:25:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="606801391"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 22 Feb 2022 11:25:52 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nManH-0000XB-LZ; Tue, 22 Feb 2022 19:25:51 +0000
Date:   Wed, 23 Feb 2022 03:25:44 +0800
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
Subject: Re: [PATCH v2 08/18] dept: Apply Dept to
 wait_for_completion()/complete()
Message-ID: <202202230329.dwOppOXY-lkp@intel.com>
References: <1645268311-24222-9-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645268311-24222-9-git-send-email-byungchul.park@lge.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
[also build test WARNING on linux/master linus/master v5.17-rc5]
[cannot apply to tip/locking/core hnaz-mm/master next-20220217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Byungchul-Park/DEPT-Dependency-Tracker/20220220-185528
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ed3b362d54f0038cafc985248350d301af7af686
reproduce: make htmldocs

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> include/linux/completion.h:121: warning: expecting prototype for init_completion(). Prototype was for __init_completion() instead

vim +121 include/linux/completion.h

8b3db9c542e18b7 Ingo Molnar     2006-07-03  110  
65eb3dc609dec17 Kevin Diggs     2008-08-26  111  /**
ee2f154a598e96d Randy Dunlap    2010-10-26  112   * init_completion - Initialize a dynamically allocated completion
c32f74ab2872994 Wolfram Sang    2013-11-14  113   * @x:  pointer to completion structure that is to be initialized
65eb3dc609dec17 Kevin Diggs     2008-08-26  114   *
65eb3dc609dec17 Kevin Diggs     2008-08-26  115   * This inline function will initialize a dynamically created completion
65eb3dc609dec17 Kevin Diggs     2008-08-26  116   * structure.
65eb3dc609dec17 Kevin Diggs     2008-08-26  117   */
82b6a46bab5dcb0 Byungchul Park  2022-02-19  118  static inline void __init_completion(struct completion *x,
82b6a46bab5dcb0 Byungchul Park  2022-02-19  119  				     struct dept_key *dkey,
82b6a46bab5dcb0 Byungchul Park  2022-02-19  120  				     const char *name)
^1da177e4c3f415 Linus Torvalds  2005-04-16 @121  {
^1da177e4c3f415 Linus Torvalds  2005-04-16  122  	x->done = 0;
82b6a46bab5dcb0 Byungchul Park  2022-02-19  123  	dept_wfc_init(&x->dmap, dkey, 0, name);
a5c6234e10280b3 Thomas Gleixner 2020-03-21  124  	init_swait_queue_head(&x->wait);
^1da177e4c3f415 Linus Torvalds  2005-04-16  125  }
^1da177e4c3f415 Linus Torvalds  2005-04-16  126  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
