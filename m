Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE99B7D288C
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Oct 2023 04:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbjJWCbm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 22 Oct 2023 22:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbjJWCbm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 22 Oct 2023 22:31:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD10AE6
        for <linux-ext4@vger.kernel.org>; Sun, 22 Oct 2023 19:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698028299; x=1729564299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/z5TsfmBKgB8iOXf3RI+KVdgm0KDBHdg9UTLejQULv0=;
  b=L4cMRAaiwIWt502whopPLbjgY7nSFsJiufNbowNB7W9LQxns2EOh978G
   pwleFDLPvIdkOqpYK+BDtJVhEGnMDtrQPvWnrByNuIWG++t6TF3rHuVr8
   3vCSjeuqahpxY4Gf0ZOfuDPl6wFadZygqIJ+npxWp7Be84uaaxOJR2AEP
   n2OC8H0mdCwFjXvbQ4wGzWqU27RNW52ffgpbiQDhB+bnbWc1+HRW5OemB
   L+YZv9I9MPk0jg4juFQtoo4J+raoDtDAaYNJxxeC5vuMQ/NIGM0bO8LZn
   BqvjKvFrr9xRZhliQ5wKolai7cSnCEqvyds588ludNTNhim518cV1qyZV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="472966255"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="472966255"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 19:31:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="734512967"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="734512967"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Oct 2023 19:31:26 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qukix-0006UT-2t;
        Mon, 23 Oct 2023 02:31:23 +0000
Date:   Mon, 23 Oct 2023 10:31:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 1/4] ext4: unify the type of flexbg_size to unsigned
 int
Message-ID: <202310231017.HTcNT4ZK-lkp@intel.com>
References: <20231023013057.2117948-2-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023013057.2117948-2-libaokun1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Baokun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tytso-ext4/dev]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Baokun-Li/ext4-unify-the-type-of-flexbg_size-to-unsigned-int/20231023-092711
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20231023013057.2117948-2-libaokun1%40huawei.com
patch subject: [PATCH v2 1/4] ext4: unify the type of flexbg_size to unsigned int
reproduce: (https://download.01.org/0day-ci/archive/20231023/202310231017.HTcNT4ZK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310231017.HTcNT4ZK-lkp@intel.com/

# many are suggestions rather than must-fix

WARNING:SPLIT_STRING: quoted string split across lines
#50: FILE: fs/ext4/resize.c:387:
 		printk(KERN_DEBUG "EXT4-fs: adding a flex group with "
+		       "%u groups, flexbg size is %u:\n", flex_gd->count,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
