Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE624BAA24
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Feb 2022 20:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245424AbiBQTra (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Feb 2022 14:47:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245403AbiBQTrY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Feb 2022 14:47:24 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D582654B;
        Thu, 17 Feb 2022 11:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645127229; x=1676663229;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F3ghFFmf9Z70ke5xUFrYTznu4LR/z5ek87I9Llnq9wE=;
  b=cKpiHU/2nbX+/oJHEq4DF/FW1yTnm5O2Ke8WaBa6WMQklB8rs7SAtFGp
   gz2aOrIrl9IoVFISmVC0BZjuHJG0qF8izlyzjF/lB2pxXVS/33HyqCavA
   CGbFO/a/Ho8+quwvZljO25HLOv7qJsOH0xxpmtZOwvcFrjhZD6ioNskjF
   1s/qXepB6bHL7+pWO5EOM//snM3f9TPIBqujUmc0GvriP+yXCNGssazSw
   mU5Ycqvf/q2V+4EC+aHdm93pkexy6iPoUNxBXmy3KGoUjbKrsHIttWK7V
   yBQnpnBSPZIMZZNETjtKBSv6IfJOGLgmdIOM8MlW5DcszMPuCRLzocj/m
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="250903382"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="250903382"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 11:47:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="637327206"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 17 Feb 2022 11:47:02 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKmk1-0000UI-9C; Thu, 17 Feb 2022 19:47:01 +0000
Date:   Fri, 18 Feb 2022 03:46:28 +0800
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
Subject: Re: [PATCH 02/16] dept: Implement Dept(Dependency Tracker)
Message-ID: <202202180059.SibYSAt1-lkp@intel.com>
References: <1645095472-26530-3-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645095472-26530-3-git-send-email-byungchul.park@lge.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
[also build test WARNING on hnaz-mm/master linux/master linus/master v5.17-rc4]
[cannot apply to tip/locking/core next-20220217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Byungchul-Park/DEPT-Dependency-Tracker/20220217-190040
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 3624ba7b5e2acc02b01301ea5fd3534971eb9896
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20220218/202202180059.SibYSAt1-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/4d0434b0b917f4374a09f3b75cbcadf148cfa711
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Byungchul-Park/DEPT-Dependency-Tracker/20220217-190040
        git checkout 4d0434b0b917f4374a09f3b75cbcadf148cfa711
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash drivers/net/ethernet/sfc/falcon/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/delay.h:23,
                    from drivers/net/ethernet/sfc/falcon/falcon.c:9:
   drivers/net/ethernet/sfc/falcon/falcon.c: In function 'falcon_spi_slow_wait':
>> drivers/net/ethernet/sfc/falcon/falcon.c:750:58: warning: '?:' using integer constants in boolean context [-Wint-in-bool-context]
     750 |                                     TASK_UNINTERRUPTIBLE : TASK_INTERRUPTIBLE);
   include/linux/sched.h:205:21: note: in definition of macro '__set_current_state'
     205 |                 if (state_value == TASK_RUNNING)                        \
         |                     ^~~~~~~~~~~


vim +750 drivers/net/ethernet/sfc/falcon/falcon.c

4a5b504d0c582db drivers/net/sfc/falcon.c                 Ben Hutchings 2008-09-01  738  
45a3fd55acc8989 drivers/net/ethernet/sfc/falcon.c        Ben Hutchings 2012-11-28  739  static int
45a3fd55acc8989 drivers/net/ethernet/sfc/falcon.c        Ben Hutchings 2012-11-28  740  falcon_spi_slow_wait(struct falcon_mtd_partition *part, bool uninterruptible)
45a3fd55acc8989 drivers/net/ethernet/sfc/falcon.c        Ben Hutchings 2012-11-28  741  {
45a3fd55acc8989 drivers/net/ethernet/sfc/falcon.c        Ben Hutchings 2012-11-28  742  	const struct falcon_spi_device *spi = part->spi;
5a6681e22c14090 drivers/net/ethernet/sfc/falcon/falcon.c Edward Cree   2016-11-28  743  	struct ef4_nic *efx = part->common.mtd.priv;
45a3fd55acc8989 drivers/net/ethernet/sfc/falcon.c        Ben Hutchings 2012-11-28  744  	u8 status;
45a3fd55acc8989 drivers/net/ethernet/sfc/falcon.c        Ben Hutchings 2012-11-28  745  	int rc, i;
45a3fd55acc8989 drivers/net/ethernet/sfc/falcon.c        Ben Hutchings 2012-11-28  746  
45a3fd55acc8989 drivers/net/ethernet/sfc/falcon.c        Ben Hutchings 2012-11-28  747  	/* Wait up to 4s for flash/EEPROM to finish a slow operation. */
45a3fd55acc8989 drivers/net/ethernet/sfc/falcon.c        Ben Hutchings 2012-11-28  748  	for (i = 0; i < 40; i++) {
45a3fd55acc8989 drivers/net/ethernet/sfc/falcon.c        Ben Hutchings 2012-11-28  749  		__set_current_state(uninterruptible ?
45a3fd55acc8989 drivers/net/ethernet/sfc/falcon.c        Ben Hutchings 2012-11-28 @750  				    TASK_UNINTERRUPTIBLE : TASK_INTERRUPTIBLE);
45a3fd55acc8989 drivers/net/ethernet/sfc/falcon.c        Ben Hutchings 2012-11-28  751  		schedule_timeout(HZ / 10);
45a3fd55acc8989 drivers/net/ethernet/sfc/falcon.c        Ben Hutchings 2012-11-28  752  		rc = falcon_spi_cmd(efx, spi, SPI_RDSR, -1, NULL,
45a3fd55acc8989 drivers/net/ethernet/sfc/falcon.c        Ben Hutchings 2012-11-28  753  				    &status, sizeof(status));
45a3fd55acc8989 drivers/net/ethernet/sfc/falcon.c        Ben Hutchings 2012-11-28  754  		if (rc)
45a3fd55acc8989 drivers/net/ethernet/sfc/falcon.c        Ben Hutchings 2012-11-28  755  			return rc;
45a3fd55acc8989 drivers/net/ethernet/sfc/falcon.c        Ben Hutchings 2012-11-28  756  		if (!(status & SPI_STATUS_NRDY))
45a3fd55acc8989 drivers/net/ethernet/sfc/falcon.c        Ben Hutchings 2012-11-28  757  			return 0;
45a3fd55acc8989 drivers/net/ethernet/sfc/falcon.c        Ben Hutchings 2012-11-28  758  		if (signal_pending(current))
45a3fd55acc8989 drivers/net/ethernet/sfc/falcon.c        Ben Hutchings 2012-11-28  759  			return -EINTR;
45a3fd55acc8989 drivers/net/ethernet/sfc/falcon.c        Ben Hutchings 2012-11-28  760  	}
45a3fd55acc8989 drivers/net/ethernet/sfc/falcon.c        Ben Hutchings 2012-11-28  761  	pr_err("%s: timed out waiting for %s\n",
45a3fd55acc8989 drivers/net/ethernet/sfc/falcon.c        Ben Hutchings 2012-11-28  762  	       part->common.name, part->common.dev_type_name);
45a3fd55acc8989 drivers/net/ethernet/sfc/falcon.c        Ben Hutchings 2012-11-28  763  	return -ETIMEDOUT;
45a3fd55acc8989 drivers/net/ethernet/sfc/falcon.c        Ben Hutchings 2012-11-28  764  }
45a3fd55acc8989 drivers/net/ethernet/sfc/falcon.c        Ben Hutchings 2012-11-28  765  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
