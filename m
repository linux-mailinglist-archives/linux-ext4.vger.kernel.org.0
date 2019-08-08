Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6D685865
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Aug 2019 05:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389520AbfHHDEC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Aug 2019 23:04:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:19466 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387536AbfHHDEC (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 7 Aug 2019 23:04:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 20:04:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,358,1559545200"; 
   d="scan'208";a="182465060"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Aug 2019 20:04:00 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hvYie-0008mq-1Y; Thu, 08 Aug 2019 11:04:00 +0800
Date:   Thu, 8 Aug 2019 11:03:04 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     kbuild-all@01.org, linux-ext4@vger.kernel.org, tytso@mit.edu,
        jack@suse.cz, adilger.kernel@dilger.ca, yi.zhang@huawei.com
Subject: Re: [PATCH v2] ext4: fix potential use after free in system zone via
 remount with noblock_validity
Message-ID: <201908081107.DkPpgosg%lkp@intel.com>
References: <1564755566-4378-1-git-send-email-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564755566-4378-1-git-send-email-yi.zhang@huawei.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi "zhangyi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[cannot apply to v5.3-rc3 next-20190807]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/zhangyi-F/ext4-fix-potential-use-after-free-in-system-zone-via-remount-with-noblock_validity/20190804-163619
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   include/linux/sched.h:609:43: sparse: sparse: bad integer constant expression
   include/linux/sched.h:609:73: sparse: sparse: invalid named zero-width bitfield `value'
   include/linux/sched.h:610:43: sparse: sparse: bad integer constant expression
   include/linux/sched.h:610:67: sparse: sparse: invalid named zero-width bitfield `bucket_id'
   include/linux/rbtree.h:84:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rbtree.h:84:9: sparse:    struct rb_node [noderef] <asn:4> *
   include/linux/rbtree.h:84:9: sparse:    struct rb_node *
>> fs/ext4/block_validity.c:252:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> fs/ext4/block_validity.c:252:9: sparse:    struct rb_node [noderef] <asn:4> *
>> fs/ext4/block_validity.c:252:9: sparse:    struct rb_node *

vim +252 fs/ext4/block_validity.c

   246	
   247	/* Called when the filesystem is unmounted */
   248	void ext4_release_system_zone(struct super_block *sb)
   249	{
   250		struct ext4_system_zone	*entry, *n;
   251	
 > 252		rcu_assign_pointer(EXT4_SB(sb)->system_blks.rb_node, NULL);
   253	
   254		rbtree_postorder_for_each_entry_safe(entry, n,
   255				&EXT4_SB(sb)->system_blks, node)
   256			call_rcu(&entry->rcu, destroy_system_zone);
   257	}
   258	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
