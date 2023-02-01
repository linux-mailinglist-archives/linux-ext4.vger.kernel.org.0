Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6352E685DDF
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Feb 2023 04:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjBADVL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 Jan 2023 22:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjBADVK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 31 Jan 2023 22:21:10 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BEF4F354;
        Tue, 31 Jan 2023 19:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675221649; x=1706757649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PH2OX5Teu6wMvMOs/pvq1Zt3+cHl034fiVKX4vm9w5M=;
  b=Z78ylTnrA7uvNooD/G50vaJK6lKRsEbBlOCyAP+xJ/XsrnVKS5B+z3aR
   6TdHMnnbe7NotNbU7nQrQZyTh8HdD6IiTfOrXQD5LZvFOJE137O5QxH6j
   Q173WwTvJ1qxO1BcAZJK7ez7o9qGIZMoxHw1+0AwU3L1e7VDxr0tJnoxX
   jMbBlN3qRjCO5esa2KzmDaYEOSypLeH46kOkKLM35+BVxUqOjbYgMIODb
   7RtmJPc8eJr6bJ+4AUJ4hcv1qJK8Tskw3OnDZEQvaFohapKIHP5SCgjam
   9eto0oLOn+P6DQ2SHJ10qO48P4sseHd16DZbucBHSHMMYYz69GtKYBFbw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="390394194"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="390394194"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 19:20:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="910153130"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="910153130"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 31 Jan 2023 19:20:41 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pN3fs-0004zn-2z;
        Wed, 01 Feb 2023 03:20:40 +0000
Date:   Wed, 1 Feb 2023 11:19:55 +0800
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
Subject: Re: [PATCH v9 07/25] dept: Apply sdt_might_sleep_{start,end}() to
 wait_for_completion()/complete()
Message-ID: <202302011107.Qs35wciq-lkp@intel.com>
References: <1675154394-25598-8-git-send-email-max.byungchul.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675154394-25598-8-git-send-email-max.byungchul.park@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Byungchul,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/locking/core]
[also build test WARNING on tip/sched/core drm-misc/drm-misc-next linus/master v6.2-rc6 next-20230131]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Byungchul-Park/llist-Move-llist_-head-node-definition-to-types-h/20230131-164632
patch link:    https://lore.kernel.org/r/1675154394-25598-8-git-send-email-max.byungchul.park%40gmail.com
patch subject: [PATCH v9 07/25] dept: Apply sdt_might_sleep_{start,end}() to wait_for_completion()/complete()
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20230201/202302011107.Qs35wciq-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4773cd9b4e467e974a08cfcd690019b170f2e123
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Byungchul-Park/llist-Move-llist_-head-node-definition-to-types-h/20230131-164632
        git checkout 4773cd9b4e467e974a08cfcd690019b170f2e123
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/scsi/qla2xxx/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/scsi/qla2xxx/qla_dfs.c: In function 'qla2x00_dfs_tgt_port_database_show':
>> drivers/scsi/qla2xxx/qla_dfs.c:227:1: warning: the frame size of 1032 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     227 | }
         | ^


vim +227 drivers/scsi/qla2xxx/qla_dfs.c

36c7845282eef0 Quinn Tran       2016-02-04  174  
c423437e3ff41b Himanshu Madhani 2017-03-15  175  static int
c423437e3ff41b Himanshu Madhani 2017-03-15  176  qla2x00_dfs_tgt_port_database_show(struct seq_file *s, void *unused)
c423437e3ff41b Himanshu Madhani 2017-03-15  177  {
c423437e3ff41b Himanshu Madhani 2017-03-15  178  	scsi_qla_host_t *vha = s->private;
c423437e3ff41b Himanshu Madhani 2017-03-15  179  	struct qla_hw_data *ha = vha->hw;
4e5a05d1ecd92c Arun Easi        2020-09-03  180  	struct gid_list_info *gid_list;
c423437e3ff41b Himanshu Madhani 2017-03-15  181  	dma_addr_t gid_list_dma;
c423437e3ff41b Himanshu Madhani 2017-03-15  182  	fc_port_t fc_port;
4e5a05d1ecd92c Arun Easi        2020-09-03  183  	char *id_iter;
c423437e3ff41b Himanshu Madhani 2017-03-15  184  	int rc, i;
c423437e3ff41b Himanshu Madhani 2017-03-15  185  	uint16_t entries, loop_id;
c423437e3ff41b Himanshu Madhani 2017-03-15  186  
c423437e3ff41b Himanshu Madhani 2017-03-15  187  	seq_printf(s, "%s\n", vha->host_str);
c423437e3ff41b Himanshu Madhani 2017-03-15  188  	gid_list = dma_alloc_coherent(&ha->pdev->dev,
c423437e3ff41b Himanshu Madhani 2017-03-15  189  				      qla2x00_gid_list_size(ha),
c423437e3ff41b Himanshu Madhani 2017-03-15  190  				      &gid_list_dma, GFP_KERNEL);
c423437e3ff41b Himanshu Madhani 2017-03-15  191  	if (!gid_list) {
83548fe2fcbb78 Quinn Tran       2017-06-02  192  		ql_dbg(ql_dbg_user, vha, 0x7018,
c423437e3ff41b Himanshu Madhani 2017-03-15  193  		       "DMA allocation failed for %u\n",
c423437e3ff41b Himanshu Madhani 2017-03-15  194  		       qla2x00_gid_list_size(ha));
c423437e3ff41b Himanshu Madhani 2017-03-15  195  		return 0;
c423437e3ff41b Himanshu Madhani 2017-03-15  196  	}
c423437e3ff41b Himanshu Madhani 2017-03-15  197  
c423437e3ff41b Himanshu Madhani 2017-03-15  198  	rc = qla24xx_gidlist_wait(vha, gid_list, gid_list_dma,
c423437e3ff41b Himanshu Madhani 2017-03-15  199  				  &entries);
c423437e3ff41b Himanshu Madhani 2017-03-15  200  	if (rc != QLA_SUCCESS)
c423437e3ff41b Himanshu Madhani 2017-03-15  201  		goto out_free_id_list;
c423437e3ff41b Himanshu Madhani 2017-03-15  202  
4e5a05d1ecd92c Arun Easi        2020-09-03  203  	id_iter = (char *)gid_list;
c423437e3ff41b Himanshu Madhani 2017-03-15  204  
c423437e3ff41b Himanshu Madhani 2017-03-15  205  	seq_puts(s, "Port Name	Port ID		Loop ID\n");
c423437e3ff41b Himanshu Madhani 2017-03-15  206  
c423437e3ff41b Himanshu Madhani 2017-03-15  207  	for (i = 0; i < entries; i++) {
4e5a05d1ecd92c Arun Easi        2020-09-03  208  		struct gid_list_info *gid =
4e5a05d1ecd92c Arun Easi        2020-09-03  209  			(struct gid_list_info *)id_iter;
c423437e3ff41b Himanshu Madhani 2017-03-15  210  		loop_id = le16_to_cpu(gid->loop_id);
c423437e3ff41b Himanshu Madhani 2017-03-15  211  		memset(&fc_port, 0, sizeof(fc_port_t));
c423437e3ff41b Himanshu Madhani 2017-03-15  212  
c423437e3ff41b Himanshu Madhani 2017-03-15  213  		fc_port.loop_id = loop_id;
c423437e3ff41b Himanshu Madhani 2017-03-15  214  
c423437e3ff41b Himanshu Madhani 2017-03-15  215  		rc = qla24xx_gpdb_wait(vha, &fc_port, 0);
c423437e3ff41b Himanshu Madhani 2017-03-15  216  		seq_printf(s, "%8phC  %02x%02x%02x  %d\n",
c423437e3ff41b Himanshu Madhani 2017-03-15  217  			   fc_port.port_name, fc_port.d_id.b.domain,
c423437e3ff41b Himanshu Madhani 2017-03-15  218  			   fc_port.d_id.b.area, fc_port.d_id.b.al_pa,
c423437e3ff41b Himanshu Madhani 2017-03-15  219  			   fc_port.loop_id);
4e5a05d1ecd92c Arun Easi        2020-09-03  220  		id_iter += ha->gid_list_info_size;
c423437e3ff41b Himanshu Madhani 2017-03-15  221  	}
c423437e3ff41b Himanshu Madhani 2017-03-15  222  out_free_id_list:
c423437e3ff41b Himanshu Madhani 2017-03-15  223  	dma_free_coherent(&ha->pdev->dev, qla2x00_gid_list_size(ha),
c423437e3ff41b Himanshu Madhani 2017-03-15  224  			  gid_list, gid_list_dma);
c423437e3ff41b Himanshu Madhani 2017-03-15  225  
c423437e3ff41b Himanshu Madhani 2017-03-15  226  	return 0;
c423437e3ff41b Himanshu Madhani 2017-03-15 @227  }
c423437e3ff41b Himanshu Madhani 2017-03-15  228  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
