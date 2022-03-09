Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1564D2B91
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Mar 2022 10:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiCIJQJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Mar 2022 04:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiCIJQJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Mar 2022 04:16:09 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D45D15722A;
        Wed,  9 Mar 2022 01:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646817310; x=1678353310;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qRqiy5eVsmTfmyFXtci1vfe0nMcWF1h794gg0ny/GmU=;
  b=WoQJ4+5IVsjuSrCBTLp3wjsbvklVyDUbhewxhRXP9ziWeTMqByXFN65w
   WZ1GuzRQ8Z1wzeyBXf8xSb6ABwWWXnywFYakypUtt8OGrINEF06rYu/IZ
   2bsrP2kl+MoUt5vBTm/srOFsfc4MI3ocEhcuTP4sw75M+J3eMXvLoM+5+
   ueVJhlNaB53L3gDqHdyLFhbgmBC3wNUOOIhWbXTr5oLtHDTqg7/QyRY9y
   eFtLkeqf74hguRubut3tJbL3fRDtFPHUevcrfyJLbIp4Y9G5KTOFouwEl
   ubfgYRk36vwKMlrflPYQau8KC7t/YaFh+TRHaW99MGcMjRM9l90WjuQCl
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="279653430"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="279653430"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 01:15:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="711877615"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 09 Mar 2022 01:15:01 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRsPM-0002z2-AQ; Wed, 09 Mar 2022 09:15:00 +0000
Date:   Wed, 9 Mar 2022 17:14:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Byungchul Park <byungchul.park@lge.com>,
        torvalds@linux-foundation.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, joel@joelfernandes.org, sashal@kernel.org,
        daniel.vetter@ffwll.ch, chris@chris-wilson.co.uk,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
        amir73il@gmail.com, bfields@fieldses.org,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org
Subject: Re: [PATCH v4 14/24] dept: Apply SDT to swait
Message-ID: <202203091736.ZSni5gJV-lkp@intel.com>
References: <1646377603-19730-15-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646377603-19730-15-git-send-email-byungchul.park@lge.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
[also build test WARNING on linux/master linus/master v5.17-rc7]
[cannot apply to tip/locking/core hnaz-mm/master next-20220308]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Byungchul-Park/DEPT-Dependency-Tracker/20220304-150943
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 25795ef6299f07ce3838f3253a9cb34f64efcfae
config: hexagon-randconfig-r022-20220307 (https://download.01.org/0day-ci/archive/20220309/202203091736.ZSni5gJV-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/dbdd22ef0f5b79f561dc8766d253b10b496c0091
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Byungchul-Park/DEPT-Dependency-Tracker/20220304-150943
        git checkout dbdd22ef0f5b79f561dc8766d253b10b496c0091
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/target/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/target/target_core_xcopy.c:667:13: warning: stack frame size (1064) exceeds limit (1024) in 'target_xcopy_do_work' [-Wframe-larger-than]
   static void target_xcopy_do_work(struct work_struct *work)
               ^
   1 warning generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for FRAME_POINTER
   Depends on DEBUG_KERNEL && (M68K || UML || SUPERH) || ARCH_WANT_FRAME_POINTERS
   Selected by
   - DEPT && DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT && !MIPS && !PPC && !ARM && !S390 && !MICROBLAZE && !ARC && !X86


vim +/target_xcopy_do_work +667 drivers/target/target_core_xcopy.c

cbf031f425fd0b Nicholas Bellinger 2013-08-20  666  
cbf031f425fd0b Nicholas Bellinger 2013-08-20 @667  static void target_xcopy_do_work(struct work_struct *work)
cbf031f425fd0b Nicholas Bellinger 2013-08-20  668  {
cbf031f425fd0b Nicholas Bellinger 2013-08-20  669  	struct xcopy_op *xop = container_of(work, struct xcopy_op, xop_work);
cbf031f425fd0b Nicholas Bellinger 2013-08-20  670  	struct se_cmd *ec_cmd = xop->xop_se_cmd;
d877d7275be34a Bart Van Assche    2017-05-23  671  	struct se_device *src_dev, *dst_dev;
d877d7275be34a Bart Van Assche    2017-05-23  672  	sector_t src_lba, dst_lba, end_lba;
cbf031f425fd0b Nicholas Bellinger 2013-08-20  673  	unsigned int max_sectors;
d877d7275be34a Bart Van Assche    2017-05-23  674  	int rc = 0;
0ad08996da05b6 David Disseldorp   2020-03-27  675  	unsigned short nolb, max_nolb, copied_nolb = 0;
0394b5048efd73 Sergey Samoylenko  2021-08-03  676  	sense_reason_t sense_rc;
d877d7275be34a Bart Van Assche    2017-05-23  677  
0394b5048efd73 Sergey Samoylenko  2021-08-03  678  	sense_rc = target_parse_xcopy_cmd(xop);
0394b5048efd73 Sergey Samoylenko  2021-08-03  679  	if (sense_rc != TCM_NO_SENSE)
d877d7275be34a Bart Van Assche    2017-05-23  680  		goto err_free;
cbf031f425fd0b Nicholas Bellinger 2013-08-20  681  
0394b5048efd73 Sergey Samoylenko  2021-08-03  682  	if (WARN_ON_ONCE(!xop->src_dev) || WARN_ON_ONCE(!xop->dst_dev)) {
0394b5048efd73 Sergey Samoylenko  2021-08-03  683  		sense_rc = TCM_INVALID_PARAMETER_LIST;
d877d7275be34a Bart Van Assche    2017-05-23  684  		goto err_free;
0394b5048efd73 Sergey Samoylenko  2021-08-03  685  	}
d877d7275be34a Bart Van Assche    2017-05-23  686  
d877d7275be34a Bart Van Assche    2017-05-23  687  	src_dev = xop->src_dev;
d877d7275be34a Bart Van Assche    2017-05-23  688  	dst_dev = xop->dst_dev;
d877d7275be34a Bart Van Assche    2017-05-23  689  	src_lba = xop->src_lba;
d877d7275be34a Bart Van Assche    2017-05-23  690  	dst_lba = xop->dst_lba;
d877d7275be34a Bart Van Assche    2017-05-23  691  	nolb = xop->nolb;
cbf031f425fd0b Nicholas Bellinger 2013-08-20  692  	end_lba = src_lba + nolb;
cbf031f425fd0b Nicholas Bellinger 2013-08-20  693  	/*
cbf031f425fd0b Nicholas Bellinger 2013-08-20  694  	 * Break up XCOPY I/O into hw_max_sectors sized I/O based on the
cbf031f425fd0b Nicholas Bellinger 2013-08-20  695  	 * smallest max_sectors between src_dev + dev_dev, or
cbf031f425fd0b Nicholas Bellinger 2013-08-20  696  	 */
cbf031f425fd0b Nicholas Bellinger 2013-08-20  697  	max_sectors = min(src_dev->dev_attrib.hw_max_sectors,
cbf031f425fd0b Nicholas Bellinger 2013-08-20  698  			  dst_dev->dev_attrib.hw_max_sectors);
cbf031f425fd0b Nicholas Bellinger 2013-08-20  699  	max_sectors = min_t(u32, max_sectors, XCOPY_MAX_SECTORS);
cbf031f425fd0b Nicholas Bellinger 2013-08-20  700  
cbf031f425fd0b Nicholas Bellinger 2013-08-20  701  	max_nolb = min_t(u16, max_sectors, ((u16)(~0U)));
cbf031f425fd0b Nicholas Bellinger 2013-08-20  702  
cbf031f425fd0b Nicholas Bellinger 2013-08-20  703  	pr_debug("target_xcopy_do_work: nolb: %hu, max_nolb: %hu end_lba: %llu\n",
cbf031f425fd0b Nicholas Bellinger 2013-08-20  704  			nolb, max_nolb, (unsigned long long)end_lba);
cbf031f425fd0b Nicholas Bellinger 2013-08-20  705  	pr_debug("target_xcopy_do_work: Starting src_lba: %llu, dst_lba: %llu\n",
cbf031f425fd0b Nicholas Bellinger 2013-08-20  706  			(unsigned long long)src_lba, (unsigned long long)dst_lba);
cbf031f425fd0b Nicholas Bellinger 2013-08-20  707  
cbf031f425fd0b Nicholas Bellinger 2013-08-20  708  	while (src_lba < end_lba) {
0ad08996da05b6 David Disseldorp   2020-03-27  709  		unsigned short cur_nolb = min(nolb, max_nolb);
0ad08996da05b6 David Disseldorp   2020-03-27  710  		u32 cur_bytes = cur_nolb * src_dev->dev_attrib.block_size;
0ad08996da05b6 David Disseldorp   2020-03-27  711  
0ad08996da05b6 David Disseldorp   2020-03-27  712  		if (cur_bytes != xop->xop_data_bytes) {
0ad08996da05b6 David Disseldorp   2020-03-27  713  			/*
0ad08996da05b6 David Disseldorp   2020-03-27  714  			 * (Re)allocate a buffer large enough to hold the XCOPY
0ad08996da05b6 David Disseldorp   2020-03-27  715  			 * I/O size, which can be reused each read / write loop.
0ad08996da05b6 David Disseldorp   2020-03-27  716  			 */
0ad08996da05b6 David Disseldorp   2020-03-27  717  			target_free_sgl(xop->xop_data_sg, xop->xop_data_nents);
0ad08996da05b6 David Disseldorp   2020-03-27  718  			rc = target_alloc_sgl(&xop->xop_data_sg,
0ad08996da05b6 David Disseldorp   2020-03-27  719  					      &xop->xop_data_nents,
0ad08996da05b6 David Disseldorp   2020-03-27  720  					      cur_bytes,
0ad08996da05b6 David Disseldorp   2020-03-27  721  					      false, false);
0ad08996da05b6 David Disseldorp   2020-03-27  722  			if (rc < 0)
0ad08996da05b6 David Disseldorp   2020-03-27  723  				goto out;
0ad08996da05b6 David Disseldorp   2020-03-27  724  			xop->xop_data_bytes = cur_bytes;
0ad08996da05b6 David Disseldorp   2020-03-27  725  		}
cbf031f425fd0b Nicholas Bellinger 2013-08-20  726  
cbf031f425fd0b Nicholas Bellinger 2013-08-20  727  		pr_debug("target_xcopy_do_work: Calling read src_dev: %p src_lba: %llu,"
cbf031f425fd0b Nicholas Bellinger 2013-08-20  728  			" cur_nolb: %hu\n", src_dev, (unsigned long long)src_lba, cur_nolb);
cbf031f425fd0b Nicholas Bellinger 2013-08-20  729  
cbf031f425fd0b Nicholas Bellinger 2013-08-20  730  		rc = target_xcopy_read_source(ec_cmd, xop, src_dev, src_lba, cur_nolb);
cbf031f425fd0b Nicholas Bellinger 2013-08-20  731  		if (rc < 0)
cbf031f425fd0b Nicholas Bellinger 2013-08-20  732  			goto out;
cbf031f425fd0b Nicholas Bellinger 2013-08-20  733  
cbf031f425fd0b Nicholas Bellinger 2013-08-20  734  		src_lba += cur_nolb;
cbf031f425fd0b Nicholas Bellinger 2013-08-20  735  		pr_debug("target_xcopy_do_work: Incremented READ src_lba to %llu\n",
cbf031f425fd0b Nicholas Bellinger 2013-08-20  736  				(unsigned long long)src_lba);
cbf031f425fd0b Nicholas Bellinger 2013-08-20  737  
cbf031f425fd0b Nicholas Bellinger 2013-08-20  738  		pr_debug("target_xcopy_do_work: Calling write dst_dev: %p dst_lba: %llu,"
cbf031f425fd0b Nicholas Bellinger 2013-08-20  739  			" cur_nolb: %hu\n", dst_dev, (unsigned long long)dst_lba, cur_nolb);
cbf031f425fd0b Nicholas Bellinger 2013-08-20  740  
cbf031f425fd0b Nicholas Bellinger 2013-08-20  741  		rc = target_xcopy_write_destination(ec_cmd, xop, dst_dev,
cbf031f425fd0b Nicholas Bellinger 2013-08-20  742  						dst_lba, cur_nolb);
b92fcfcb687de7 David Disseldorp   2020-03-27  743  		if (rc < 0)
cbf031f425fd0b Nicholas Bellinger 2013-08-20  744  			goto out;
cbf031f425fd0b Nicholas Bellinger 2013-08-20  745  
cbf031f425fd0b Nicholas Bellinger 2013-08-20  746  		dst_lba += cur_nolb;
cbf031f425fd0b Nicholas Bellinger 2013-08-20  747  		pr_debug("target_xcopy_do_work: Incremented WRITE dst_lba to %llu\n",
cbf031f425fd0b Nicholas Bellinger 2013-08-20  748  				(unsigned long long)dst_lba);
cbf031f425fd0b Nicholas Bellinger 2013-08-20  749  
cbf031f425fd0b Nicholas Bellinger 2013-08-20  750  		copied_nolb += cur_nolb;
cbf031f425fd0b Nicholas Bellinger 2013-08-20  751  		nolb -= cur_nolb;
cbf031f425fd0b Nicholas Bellinger 2013-08-20  752  	}
cbf031f425fd0b Nicholas Bellinger 2013-08-20  753  
cbf031f425fd0b Nicholas Bellinger 2013-08-20  754  	xcopy_pt_undepend_remotedev(xop);
0ad08996da05b6 David Disseldorp   2020-03-27  755  	target_free_sgl(xop->xop_data_sg, xop->xop_data_nents);
cbf031f425fd0b Nicholas Bellinger 2013-08-20  756  	kfree(xop);
cbf031f425fd0b Nicholas Bellinger 2013-08-20  757  
cbf031f425fd0b Nicholas Bellinger 2013-08-20  758  	pr_debug("target_xcopy_do_work: Final src_lba: %llu, dst_lba: %llu\n",
cbf031f425fd0b Nicholas Bellinger 2013-08-20  759  		(unsigned long long)src_lba, (unsigned long long)dst_lba);
cbf031f425fd0b Nicholas Bellinger 2013-08-20  760  	pr_debug("target_xcopy_do_work: Blocks copied: %hu, Bytes Copied: %u\n",
cbf031f425fd0b Nicholas Bellinger 2013-08-20  761  		copied_nolb, copied_nolb * dst_dev->dev_attrib.block_size);
cbf031f425fd0b Nicholas Bellinger 2013-08-20  762  
cbf031f425fd0b Nicholas Bellinger 2013-08-20  763  	pr_debug("target_xcopy_do_work: Setting X-COPY GOOD status -> sending response\n");
cbf031f425fd0b Nicholas Bellinger 2013-08-20  764  	target_complete_cmd(ec_cmd, SAM_STAT_GOOD);
cbf031f425fd0b Nicholas Bellinger 2013-08-20  765  	return;
cbf031f425fd0b Nicholas Bellinger 2013-08-20  766  
cbf031f425fd0b Nicholas Bellinger 2013-08-20  767  out:
0394b5048efd73 Sergey Samoylenko  2021-08-03  768  	/*
0394b5048efd73 Sergey Samoylenko  2021-08-03  769  	 * The XCOPY command was aborted after some data was transferred.
0394b5048efd73 Sergey Samoylenko  2021-08-03  770  	 * Terminate command with CHECK CONDITION status, with the sense key
0394b5048efd73 Sergey Samoylenko  2021-08-03  771  	 * set to COPY ABORTED.
0394b5048efd73 Sergey Samoylenko  2021-08-03  772  	 */
0394b5048efd73 Sergey Samoylenko  2021-08-03  773  	sense_rc = TCM_COPY_TARGET_DEVICE_NOT_REACHABLE;
cbf031f425fd0b Nicholas Bellinger 2013-08-20  774  	xcopy_pt_undepend_remotedev(xop);
0ad08996da05b6 David Disseldorp   2020-03-27  775  	target_free_sgl(xop->xop_data_sg, xop->xop_data_nents);
d877d7275be34a Bart Van Assche    2017-05-23  776  
d877d7275be34a Bart Van Assche    2017-05-23  777  err_free:
cbf031f425fd0b Nicholas Bellinger 2013-08-20  778  	kfree(xop);
0394b5048efd73 Sergey Samoylenko  2021-08-03  779  	pr_warn_ratelimited("target_xcopy_do_work: rc: %d, sense: %u, XCOPY operation failed\n",
0394b5048efd73 Sergey Samoylenko  2021-08-03  780  			   rc, sense_rc);
0394b5048efd73 Sergey Samoylenko  2021-08-03  781  	target_complete_cmd_with_sense(ec_cmd, SAM_STAT_CHECK_CONDITION, sense_rc);
cbf031f425fd0b Nicholas Bellinger 2013-08-20  782  }
cbf031f425fd0b Nicholas Bellinger 2013-08-20  783  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
