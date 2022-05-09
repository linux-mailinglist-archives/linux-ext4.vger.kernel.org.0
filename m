Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72445520436
	for <lists+linux-ext4@lfdr.de>; Mon,  9 May 2022 20:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240037AbiEISMt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 May 2022 14:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239998AbiEISMs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 May 2022 14:12:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B043F2AC6ED
        for <linux-ext4@vger.kernel.org>; Mon,  9 May 2022 11:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652119733; x=1683655733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8ZI7mfbzahJdoiSrtu+vjsMRnRrViVdIknttglmat18=;
  b=PXMnBw/4IpA89XrkW6bXGvlh/q2raoI5+g/vgQUJJ4Jjo6neHUr8Yc0x
   NhG3UQq8kjVAJuyz6133Dpsu/iHyfQbRqBFWuB6aDSJ8BxlYJUVkwsh0l
   P+e8YvINqnhmMRXfg1F2zQ7Vt+jKvxAXN0dshdk3J6I6oLdIjnjz4bx3l
   fM4S7U9ZqP6TPKLy3gPPrUxD1i2hrWDXFVAncSvrpWgoXNxghA4OieEfu
   ZblZxz96Qtjdh6If6mJAUDElE018rGUz7x7gSnUvwV2b6/UMjtNJbfbPQ
   h1/nGJRiH5OqCyc69znoV0e2tnUgXFoWNidWmFIrnaG7yKxURZ007bPYA
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="294354287"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="294354287"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 11:08:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="894473113"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 09 May 2022 11:08:51 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1no7oQ-000Gko-I8;
        Mon, 09 May 2022 18:08:50 +0000
Date:   Tue, 10 May 2022 02:08:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org
Cc:     kbuild-all@lists.01.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: Re: [PATCH v3 1/7] ext4: Match the f2fs ci_compare implementation
Message-ID: <202205100125.ebeEi8X2-lkp@intel.com>
References: <20220429182728.14008-2-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429182728.14008-2-krisman@collabora.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Gabriel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tytso-ext4/dev]
[also build test WARNING on jaegeuk-f2fs/dev-test linus/master v5.18-rc6 next-20220509]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Gabriel-Krisman-Bertazi/Clean-up-the-case-insenstive-lookup-path/20220430-022957
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
config: x86_64-rhel-8.3-func (https://download.01.org/0day-ci/archive/20220510/202205100125.ebeEi8X2-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/6bf2e9e6750865e9e033adc185eacd37e8b5b0dd
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Gabriel-Krisman-Bertazi/Clean-up-the-case-insenstive-lookup-path/20220430-022957
        git checkout 6bf2e9e6750865e9e033adc185eacd37e8b5b0dd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/ext4/ fs/f2fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/ext4/namei.c: In function 'ext4_match':
>> fs/ext4/namei.c:1430:13: warning: unused variable 'ret' [-Wunused-variable]
    1430 |         int ret;
         |             ^~~


vim +/ret +1430 fs/ext4/namei.c

  1419	
  1420	/*
  1421	 * Test whether a directory entry matches the filename being searched for.
  1422	 *
  1423	 * Return: %true if the directory entry matches, otherwise %false.
  1424	 */
  1425	static bool ext4_match(struct inode *parent,
  1426				      const struct ext4_filename *fname,
  1427				      struct ext4_dir_entry_2 *de)
  1428	{
  1429		struct fscrypt_name f;
> 1430		int ret;
  1431	
  1432		if (!de->inode)
  1433			return false;
  1434	
  1435		f.usr_fname = fname->usr_fname;
  1436		f.disk_name = fname->disk_name;
  1437	#ifdef CONFIG_FS_ENCRYPTION
  1438		f.crypto_buf = fname->crypto_buf;
  1439	#endif
  1440	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
