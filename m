Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91C36D293D
	for <lists+linux-ext4@lfdr.de>; Fri, 31 Mar 2023 22:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjCaUQB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 31 Mar 2023 16:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjCaUQA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 31 Mar 2023 16:16:00 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA3C22215;
        Fri, 31 Mar 2023 13:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680293757; x=1711829757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hl1xBPfLx9uM+0HT0MMByFyx2tcjgcA/qWKErLRqhtU=;
  b=nG7xANgka9YMaJwxPGt7e6ErB000LFCtih3IXoOncmPExEWTQ3qRPxRQ
   BNNA5ja7AB/4nRFrrsbPMOLLi6F05+vuGgTNbjFp5d9Tplqo7SSGp6CC5
   fmllklUWkNktFl8RJbbzDt7cBnh2L5KQ4Fm9xDeTWwHZ2R2OrvvbvlNls
   bnYMCdZFoYAIlu+JMvXphLqSN78e6fKhxObMAUJShx3RHZxmTXTHenHnZ
   366OZ/+gaMVCZshCKqWvp++jpzOttJdOb5q4WYHnYi8lXiGi8+JulCLlU
   nG2oeIAnmQfmjatbcWRdkTrvfJutd7byIo1tLcfUqwGndHLzE3frbCzdr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="321943002"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="321943002"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 13:15:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="754501901"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="754501901"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 31 Mar 2023 13:15:55 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1piLAA-000M85-2J;
        Fri, 31 Mar 2023 20:15:54 +0000
Date:   Sat, 1 Apr 2023 04:15:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Triplett <josh@joshtriplett.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] ext4: Add a uapi header for ext4 userspace APIs
Message-ID: <202304010437.q1ttcwK7-lkp@intel.com>
References: <152752fa6b148e0ea304a3cdb3cc33bae0117918.1680272908.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152752fa6b148e0ea304a3cdb3cc33bae0117918.1680272908.git.josh@joshtriplett.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Josh,

I love your patch! Yet something to improve:

[auto build test ERROR on tytso-ext4/dev]
[also build test ERROR on linus/master v6.3-rc4 next-20230331]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Josh-Triplett/ext4-Add-a-uapi-header-for-ext4-userspace-APIs/20230331-224557
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/152752fa6b148e0ea304a3cdb3cc33bae0117918.1680272908.git.josh%40joshtriplett.org
patch subject: [PATCH v2] ext4: Add a uapi header for ext4 userspace APIs
config: x86_64-randconfig-a004 (https://download.01.org/0day-ci/archive/20230401/202304010437.q1ttcwK7-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/50d05266bcf4bc3307776d25c0f70d11063a8a4e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Josh-Triplett/ext4-Add-a-uapi-header-for-ext4-userspace-APIs/20230331-224557
        git checkout 50d05266bcf4bc3307776d25c0f70d11063a8a4e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304010437.q1ttcwK7-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/ext4.h:113:9: error: unknown type name 'compat_u64'
     113 |         compat_u64 block_bitmap;
         |         ^~~~~~~~~~
   ./usr/include/linux/ext4.h:114:9: error: unknown type name 'compat_u64'
     114 |         compat_u64 inode_bitmap;
         |         ^~~~~~~~~~
   ./usr/include/linux/ext4.h:115:9: error: unknown type name 'compat_u64'
     115 |         compat_u64 inode_table;
         |         ^~~~~~~~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
