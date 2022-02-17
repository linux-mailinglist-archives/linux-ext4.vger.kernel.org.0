Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33E94BAA1C
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Feb 2022 20:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245417AbiBQTr0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Feb 2022 14:47:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245402AbiBQTrY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Feb 2022 14:47:24 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6C226549;
        Thu, 17 Feb 2022 11:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645127229; x=1676663229;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WYl42eI4HYLz25VSfvzg7qJMtNusab7DF8CglpN8QQE=;
  b=P14ifbhDmv3+7yV1aYSWImV5iz7xj3A8Ef7qCFnKLDcOdxkhSu1clDVn
   12Eg2dnBHl7Ql3NFL7PoKZlmZT1Niibn+pj1Ldd7WLLczTA8g6jZR8hAW
   TfoOj40Bpwebpbpyy9t4huttgDheS6I8m1pw+xzjzo5WZqhLqNY9Q+GxC
   eDB5/5b0qldLOUxmQntVPpe8jdX+GD2k6A2AQoJlvtdYO5IpzzjnUtyW4
   whFl3UJkaIEqodOnCOe9seNu/UV6SLQmFTlz0nRcZpl/vLOuAtSSdZlIP
   XpPgNZsaix5MU9JrGMWXoyxMgAWhiL+bKMNQEjaYt6iAENzGvsFUB1OPF
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="231586439"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="231586439"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 11:47:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="774876619"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 17 Feb 2022 11:47:02 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKmk1-0000UD-7a; Thu, 17 Feb 2022 19:47:01 +0000
Date:   Fri, 18 Feb 2022 03:46:26 +0800
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
Subject: Re: [PATCH 07/16] dept: Apply Dept to
 wait_for_completion()/complete()
Message-ID: <202202180000.zICbPUhq-lkp@intel.com>
References: <1645095472-26530-8-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645095472-26530-8-git-send-email-byungchul.park@lge.com>
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
[also build test WARNING on linux/master linus/master v5.17-rc4]
[cannot apply to tip/locking/core hnaz-mm/master next-20220217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Byungchul-Park/DEPT-Dependency-Tracker/20220217-190040
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 3624ba7b5e2acc02b01301ea5fd3534971eb9896
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220218/202202180000.zICbPUhq-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/8ef6cb09cb67a0c5cd7ba4f25f4825d0a5b269b0
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Byungchul-Park/DEPT-Dependency-Tracker/20220217-190040
        git checkout 8ef6cb09cb67a0c5cd7ba4f25f4825d0a5b269b0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/scsi/qla2xxx/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/scsi/qla2xxx/qla_dfs.c: In function 'qla2x00_dfs_tgt_port_database_show':
>> drivers/scsi/qla2xxx/qla_dfs.c:227:1: warning: the frame size of 1028 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     227 | }
         | ^


vim +227 drivers/scsi/qla2xxx/qla_dfs.c

36c7845282eef01 Quinn Tran       2016-02-04  174  
c423437e3ff41b8 Himanshu Madhani 2017-03-15  175  static int
c423437e3ff41b8 Himanshu Madhani 2017-03-15  176  qla2x00_dfs_tgt_port_database_show(struct seq_file *s, void *unused)
c423437e3ff41b8 Himanshu Madhani 2017-03-15  177  {
c423437e3ff41b8 Himanshu Madhani 2017-03-15  178  	scsi_qla_host_t *vha = s->private;
c423437e3ff41b8 Himanshu Madhani 2017-03-15  179  	struct qla_hw_data *ha = vha->hw;
4e5a05d1ecd92ce Arun Easi        2020-09-03  180  	struct gid_list_info *gid_list;
c423437e3ff41b8 Himanshu Madhani 2017-03-15  181  	dma_addr_t gid_list_dma;
c423437e3ff41b8 Himanshu Madhani 2017-03-15  182  	fc_port_t fc_port;
4e5a05d1ecd92ce Arun Easi        2020-09-03  183  	char *id_iter;
c423437e3ff41b8 Himanshu Madhani 2017-03-15  184  	int rc, i;
c423437e3ff41b8 Himanshu Madhani 2017-03-15  185  	uint16_t entries, loop_id;
c423437e3ff41b8 Himanshu Madhani 2017-03-15  186  
c423437e3ff41b8 Himanshu Madhani 2017-03-15  187  	seq_printf(s, "%s\n", vha->host_str);
c423437e3ff41b8 Himanshu Madhani 2017-03-15  188  	gid_list = dma_alloc_coherent(&ha->pdev->dev,
c423437e3ff41b8 Himanshu Madhani 2017-03-15  189  				      qla2x00_gid_list_size(ha),
c423437e3ff41b8 Himanshu Madhani 2017-03-15  190  				      &gid_list_dma, GFP_KERNEL);
c423437e3ff41b8 Himanshu Madhani 2017-03-15  191  	if (!gid_list) {
83548fe2fcbb78a Quinn Tran       2017-06-02  192  		ql_dbg(ql_dbg_user, vha, 0x7018,
c423437e3ff41b8 Himanshu Madhani 2017-03-15  193  		       "DMA allocation failed for %u\n",
c423437e3ff41b8 Himanshu Madhani 2017-03-15  194  		       qla2x00_gid_list_size(ha));
c423437e3ff41b8 Himanshu Madhani 2017-03-15  195  		return 0;
c423437e3ff41b8 Himanshu Madhani 2017-03-15  196  	}
c423437e3ff41b8 Himanshu Madhani 2017-03-15  197  
c423437e3ff41b8 Himanshu Madhani 2017-03-15  198  	rc = qla24xx_gidlist_wait(vha, gid_list, gid_list_dma,
c423437e3ff41b8 Himanshu Madhani 2017-03-15  199  				  &entries);
c423437e3ff41b8 Himanshu Madhani 2017-03-15  200  	if (rc != QLA_SUCCESS)
c423437e3ff41b8 Himanshu Madhani 2017-03-15  201  		goto out_free_id_list;
c423437e3ff41b8 Himanshu Madhani 2017-03-15  202  
4e5a05d1ecd92ce Arun Easi        2020-09-03  203  	id_iter = (char *)gid_list;
c423437e3ff41b8 Himanshu Madhani 2017-03-15  204  
c423437e3ff41b8 Himanshu Madhani 2017-03-15  205  	seq_puts(s, "Port Name	Port ID		Loop ID\n");
c423437e3ff41b8 Himanshu Madhani 2017-03-15  206  
c423437e3ff41b8 Himanshu Madhani 2017-03-15  207  	for (i = 0; i < entries; i++) {
4e5a05d1ecd92ce Arun Easi        2020-09-03  208  		struct gid_list_info *gid =
4e5a05d1ecd92ce Arun Easi        2020-09-03  209  			(struct gid_list_info *)id_iter;
c423437e3ff41b8 Himanshu Madhani 2017-03-15  210  		loop_id = le16_to_cpu(gid->loop_id);
c423437e3ff41b8 Himanshu Madhani 2017-03-15  211  		memset(&fc_port, 0, sizeof(fc_port_t));
c423437e3ff41b8 Himanshu Madhani 2017-03-15  212  
c423437e3ff41b8 Himanshu Madhani 2017-03-15  213  		fc_port.loop_id = loop_id;
c423437e3ff41b8 Himanshu Madhani 2017-03-15  214  
c423437e3ff41b8 Himanshu Madhani 2017-03-15  215  		rc = qla24xx_gpdb_wait(vha, &fc_port, 0);
c423437e3ff41b8 Himanshu Madhani 2017-03-15  216  		seq_printf(s, "%8phC  %02x%02x%02x  %d\n",
c423437e3ff41b8 Himanshu Madhani 2017-03-15  217  			   fc_port.port_name, fc_port.d_id.b.domain,
c423437e3ff41b8 Himanshu Madhani 2017-03-15  218  			   fc_port.d_id.b.area, fc_port.d_id.b.al_pa,
c423437e3ff41b8 Himanshu Madhani 2017-03-15  219  			   fc_port.loop_id);
4e5a05d1ecd92ce Arun Easi        2020-09-03  220  		id_iter += ha->gid_list_info_size;
c423437e3ff41b8 Himanshu Madhani 2017-03-15  221  	}
c423437e3ff41b8 Himanshu Madhani 2017-03-15  222  out_free_id_list:
c423437e3ff41b8 Himanshu Madhani 2017-03-15  223  	dma_free_coherent(&ha->pdev->dev, qla2x00_gid_list_size(ha),
c423437e3ff41b8 Himanshu Madhani 2017-03-15  224  			  gid_list, gid_list_dma);
c423437e3ff41b8 Himanshu Madhani 2017-03-15  225  
c423437e3ff41b8 Himanshu Madhani 2017-03-15  226  	return 0;
c423437e3ff41b8 Himanshu Madhani 2017-03-15 @227  }
c423437e3ff41b8 Himanshu Madhani 2017-03-15  228  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
