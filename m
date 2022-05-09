Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8725205DB
	for <lists+linux-ext4@lfdr.de>; Mon,  9 May 2022 22:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiEIUcQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 May 2022 16:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiEIUbZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 May 2022 16:31:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4717A2E17A3
        for <linux-ext4@vger.kernel.org>; Mon,  9 May 2022 13:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652127239; x=1683663239;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=98NTZW356s2vkebqyy8B1DF/f4Bdfbp8TMw5zU5Y5mQ=;
  b=aXKc6b0gQ33cCzfWsKNMxdkOwxMqPJ8fgh9/p/VKzE3Iain7gkTT1AMw
   lWFs7cR+QTyq66h2WOnz0AG2vsDjEt62jAwHiMqTkKhMTxO8uWmrGIOcC
   dHoKXsQTVE8ZopJ1/ybG3JSSMwDeQ+v/cYFQXr2Bb7IBFemjJmnM+dCdw
   hkTJvKPRbZDun4Ke5oNEdW1TxDS0d1h2SHlfLLdBqDQV2qWQSXib8PClq
   Ik4QAin62nWLZBVmVnGk8JiI7Es5bHNYUNEitGZE3PnH9A2NDFhF2nyy+
   DGhEtH3LrJTz11B//AZhRbEd1enMl59sNMmbmkuBQoNbTjlNDlWQfyIgj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="269090585"
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="269090585"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 13:13:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="570331315"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 09 May 2022 13:13:56 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1no9lT-000GrS-QF;
        Mon, 09 May 2022 20:13:55 +0000
Date:   Tue, 10 May 2022 04:13:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org
Cc:     kbuild-all@lists.01.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: Re: [PATCH v3 3/7] ext4: Implement ci comparison using unicode_name
Message-ID: <202205100425.howJyxrE-lkp@intel.com>
References: <20220429182728.14008-4-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429182728.14008-4-krisman@collabora.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
config: x86_64-rhel-8.3-func (https://download.01.org/0day-ci/archive/20220510/202205100425.howJyxrE-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/825d568247e8fc56f2f7e657c434936c7961cefc
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Gabriel-Krisman-Bertazi/Clean-up-the-case-insenstive-lookup-path/20220430-022957
        git checkout 825d568247e8fc56f2f7e657c434936c7961cefc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/ext4/ fs/f2fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/ext4/namei.c: In function 'ext4_match':
   fs/ext4/namei.c:1431:13: warning: unused variable 'ret' [-Wunused-variable]
    1431 |         int ret;
         |             ^~~
>> fs/ext4/namei.c:1429:29: warning: unused variable 'u' [-Wunused-variable]
    1429 |         struct unicode_name u;
         |                             ^


vim +/u +1429 fs/ext4/namei.c

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
> 1429		struct unicode_name u;
  1430		struct fscrypt_name f;
  1431		int ret;
  1432	
  1433		if (!de->inode)
  1434			return false;
  1435	
  1436		f.usr_fname = fname->usr_fname;
  1437		f.disk_name = fname->disk_name;
  1438	#ifdef CONFIG_FS_ENCRYPTION
  1439		f.crypto_buf = fname->crypto_buf;
  1440	#endif
  1441	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
