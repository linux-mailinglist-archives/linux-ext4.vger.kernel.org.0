Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86A3B166A75
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Feb 2020 23:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbgBTWlS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Feb 2020 17:41:18 -0500
Received: from mga14.intel.com ([192.55.52.115]:4616 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728992AbgBTWlS (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 20 Feb 2020 17:41:18 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 14:41:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,466,1574150400"; 
   d="scan'208";a="229035086"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 20 Feb 2020 14:41:16 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j4uVP-000H4H-IE; Fri, 21 Feb 2020 06:41:15 +0800
Date:   Fri, 21 Feb 2020 06:41:05 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Suraj Jitindar Singh <surajjs@amazon.com>
Cc:     kbuild-all@lists.01.org, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Balbir Singh <sblbir@amazon.com>
Subject: [ext4:fix-bz-206443 5/6] fs/ext4/ext4.h:3002:21: sparse: sparse:
 incompatible types in comparison expression (different address spaces):
Message-ID: <202002210600.Z8rZrCyX%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git fix-bz-206443
head:   c20bac9bf82cd6560d269aa1e885e036d9e418b3
commit: 08999c46de7867f694b25689f2432f0861f4d33f [5/6] ext4: fix potential race between s_group_info online resizing and access
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-173-ge0787745-dirty
        git checkout 08999c46de7867f694b25689f2432f0861f4d33f
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
--
   fs/ext4/balloc.c:284:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/ext4/balloc.c:284:16: sparse:    struct buffer_head *[noderef] <asn:4> *
   fs/ext4/balloc.c:284:16: sparse:    struct buffer_head **
>> fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
>> fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
--
>> fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
>> fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
>> fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
>> fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
>> fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
--
>> fs/ext4/mballoc.c:2377:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/ext4/mballoc.c:2377:9: sparse:    struct ext4_group_info **[noderef] <asn:4> *
>> fs/ext4/mballoc.c:2377:9: sparse:    struct ext4_group_info ***
>> fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
>> fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
>> fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
>> fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
>> fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
>> fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
>> fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
>> fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
>> fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
>> fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
>> fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
>> fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
>> fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
>> fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
>> fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
>> fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
>> fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
>> fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***
>> fs/ext4/ext4.h:3002:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info **[noderef] <asn:4> *
>> fs/ext4/ext4.h:3002:21: sparse:    struct ext4_group_info ***

vim +3002 fs/ext4/ext4.h

  2992	
  2993	static inline
  2994	struct ext4_group_info *ext4_get_group_info(struct super_block *sb,
  2995						    ext4_group_t group)
  2996	{
  2997		 struct ext4_group_info **grp_info;
  2998		 long indexv, indexh;
  2999		 BUG_ON(group >= EXT4_SB(sb)->s_groups_count);
  3000		 indexv = group >> (EXT4_DESC_PER_BLOCK_BITS(sb));
  3001		 indexh = group & ((EXT4_DESC_PER_BLOCK(sb)) - 1);
> 3002		 grp_info = sbi_array_rcu_deref(EXT4_SB(sb), s_group_info, indexv);
  3003		 return grp_info[indexh];
  3004	}
  3005	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
