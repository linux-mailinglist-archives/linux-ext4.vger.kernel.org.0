Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A535207A3
	for <lists+linux-ext4@lfdr.de>; Tue, 10 May 2022 00:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbiEIWd6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 May 2022 18:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiEIWd6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 May 2022 18:33:58 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAB126FA57
        for <linux-ext4@vger.kernel.org>; Mon,  9 May 2022 15:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652135403; x=1683671403;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l7oUeQy/HV7AuYW8cUuoACsDI/rpWawVCuiMBlaqBSM=;
  b=DhBpKQK3TK47LwgmOaYydBs2plnypex4EWQTAkVPmIJSWS07ShSm8EyQ
   kSw7Z90kxkGSbUnuvGkuYEoPrZe0DV32r2fi8Z0m0hESqfVWBdR0bHVui
   VW4qOufiLp9ZGqjdmiGy3lvw+zjSzrit5UhfBTDuTGcZExCL9wwqWe8LL
   wToigHquBjKAV2+BpmL7Q+6f70wJt5ueYZkc1Dm+J6QOPbVWJrNdu545o
   bBGJfzgA3AUBtaYvjor7CtV+LrBo4BgSYeoWeLhenBqT1WBbCE1JZBugt
   vCq6H70g66+CiWej84s2B+YkwfqtYhWp6eXkj0yBEto8YMUqIxsTk1SbA
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="251233069"
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="251233069"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 15:30:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="593102653"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 09 May 2022 15:30:00 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noBt9-000Gxw-Bh;
        Mon, 09 May 2022 22:29:59 +0000
Date:   Tue, 10 May 2022 06:29:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org
Cc:     kbuild-all@lists.01.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: Re: [PATCH v3 7/7] f2fs: Reuse generic_ci_match for ci comparisons
Message-ID: <202205100642.aJFfVuMb-lkp@intel.com>
References: <20220429182728.14008-8-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429182728.14008-8-krisman@collabora.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
config: x86_64-rhel-8.3-func (https://download.01.org/0day-ci/archive/20220510/202205100642.aJFfVuMb-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/293ba304c3d9ce0d65df81e519822c3e66152acc
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Gabriel-Krisman-Bertazi/Clean-up-the-case-insenstive-lookup-path/20220430-022957
        git checkout 293ba304c3d9ce0d65df81e519822c3e66152acc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/f2fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/f2fs/dir.c: In function 'f2fs_match_name':
>> fs/f2fs/dir.c:216:29: warning: unused variable 'u' [-Wunused-variable]
     216 |         struct unicode_name u;
         |                             ^


vim +/u +216 fs/f2fs/dir.c

   210	
   211	static inline int f2fs_match_name(const struct inode *dir,
   212					   const struct f2fs_filename *fname,
   213					   const u8 *de_name, u32 de_name_len)
   214	{
   215		struct fscrypt_name f;
 > 216		struct unicode_name u;
   217	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
