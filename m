Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500C56F2A18
	for <lists+linux-ext4@lfdr.de>; Sun, 30 Apr 2023 19:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjD3R6C (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 Apr 2023 13:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjD3R6B (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 30 Apr 2023 13:58:01 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 30 Apr 2023 10:57:59 PDT
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CC41992
        for <linux-ext4@vger.kernel.org>; Sun, 30 Apr 2023 10:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4Mqtu1t9eePALD3efCrUxAu5RMuT1favQiL1IkZSMjM=;
  b=cJYGMwV99Hes8LvxWP2JPujgfsZA+zY0YhjgJRHdAo+XRipr0TjgKtgO
   rj51jRgtROjwpk3bd0UAtPAIpTAwPKhkhoAizykQOlhamD3/zbRPdQjKb
   HB8YcgzVr+dWEZ8Q2AdB+lG9eBVpSD+756zCk5LqABZtsXzS0en2KAsah
   Q=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.99,239,1677538800"; 
   d="scan'208";a="54742619"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2023 19:56:55 +0200
Date:   Sun, 30 Apr 2023 19:56:54 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Theodore Ts'o <tytso@mit.edu>
cc:     linux-ext4@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        lkp@intel.com
Subject: [tytso-ext4:test 112/113] fs/ext4/mballoc.c:2598:6-9: duplicated
 argument to && or || (fwd)
Message-ID: <alpine.DEB.2.22.394.2304301956001.3000@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There is a double test of grp on line 2598.

julia

---------- Forwarded message ----------
Date: Mon, 1 May 2023 01:53:12 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: [tytso-ext4:test 112/113] fs/ext4/mballoc.c:2598:6-9: duplicated
    argument to && or ||

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-ext4@vger.kernel.org
TO: "Theodore Ts'o" <tytso@mit.edu>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git test
head:   493cc71f24795ab9afc311649f5d2c23f652fb1e
commit: b9d6ed27a28439d79a90058587b2e3eeb2fcab73 [112/113] ext4: DO NOT MERGE: allow ext4_get_group_info() to fail
:::::: branch date: 22 hours ago
:::::: commit date: 25 hours ago
config: i386-randconfig-c021 (https://download.01.org/0day-ci/archive/20230501/202305010128.IfRIXw8H-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Link: https://lore.kernel.org/r/202305010128.IfRIXw8H-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> fs/ext4/mballoc.c:2598:6-9: duplicated argument to && or ||

vim +2598 fs/ext4/mballoc.c

cfd73237722135 Alex Zhuravlev 2020-04-21  2572
cfd73237722135 Alex Zhuravlev 2020-04-21  2573  /*
cfd73237722135 Alex Zhuravlev 2020-04-21  2574   * Prefetching reads the block bitmap into the buffer cache; but we
cfd73237722135 Alex Zhuravlev 2020-04-21  2575   * need to make sure that the buddy bitmap in the page cache has been
cfd73237722135 Alex Zhuravlev 2020-04-21  2576   * initialized.  Note that ext4_mb_init_group() will block if the I/O
cfd73237722135 Alex Zhuravlev 2020-04-21  2577   * is not yet completed, or indeed if it was not initiated by
cfd73237722135 Alex Zhuravlev 2020-04-21  2578   * ext4_mb_prefetch did not start the I/O.
cfd73237722135 Alex Zhuravlev 2020-04-21  2579   *
cfd73237722135 Alex Zhuravlev 2020-04-21  2580   * TODO: We should actually kick off the buddy bitmap setup in a work
cfd73237722135 Alex Zhuravlev 2020-04-21  2581   * queue when the buffer I/O is completed, so that we don't block
cfd73237722135 Alex Zhuravlev 2020-04-21  2582   * waiting for the block allocation bitmap read to finish when
cfd73237722135 Alex Zhuravlev 2020-04-21  2583   * ext4_mb_prefetch_fini is called from ext4_mb_regular_allocator().
cfd73237722135 Alex Zhuravlev 2020-04-21  2584   */
3d392b2676bf31 Theodore Ts'o  2020-07-17  2585  void ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
cfd73237722135 Alex Zhuravlev 2020-04-21  2586  			   unsigned int nr)
cfd73237722135 Alex Zhuravlev 2020-04-21  2587  {
22fab984025313 Kemeng Shi     2023-03-04  2588  	struct ext4_group_desc *gdp;
22fab984025313 Kemeng Shi     2023-03-04  2589  	struct ext4_group_info *grp;
cfd73237722135 Alex Zhuravlev 2020-04-21  2590
22fab984025313 Kemeng Shi     2023-03-04  2591  	while (nr-- > 0) {
cfd73237722135 Alex Zhuravlev 2020-04-21  2592  		if (!group)
cfd73237722135 Alex Zhuravlev 2020-04-21  2593  			group = ext4_get_groups_count(sb);
cfd73237722135 Alex Zhuravlev 2020-04-21  2594  		group--;
22fab984025313 Kemeng Shi     2023-03-04  2595  		gdp = ext4_get_group_desc(sb, group, NULL);
cfd73237722135 Alex Zhuravlev 2020-04-21  2596  		grp = ext4_get_group_info(sb, group);
cfd73237722135 Alex Zhuravlev 2020-04-21  2597
b9d6ed27a28439 Theodore Ts'o  2023-04-29 @2598  		if (grp && grp && EXT4_MB_GRP_NEED_INIT(grp) &&
cfd73237722135 Alex Zhuravlev 2020-04-21  2599  		    ext4_free_group_clusters(sb, gdp) > 0 &&
cfd73237722135 Alex Zhuravlev 2020-04-21  2600  		    !(ext4_has_group_desc_csum(sb) &&
cfd73237722135 Alex Zhuravlev 2020-04-21  2601  		      (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT)))) {
cfd73237722135 Alex Zhuravlev 2020-04-21  2602  			if (ext4_mb_init_group(sb, group, GFP_NOFS))
cfd73237722135 Alex Zhuravlev 2020-04-21  2603  				break;
cfd73237722135 Alex Zhuravlev 2020-04-21  2604  		}
cfd73237722135 Alex Zhuravlev 2020-04-21  2605  	}
cfd73237722135 Alex Zhuravlev 2020-04-21  2606  }
cfd73237722135 Alex Zhuravlev 2020-04-21  2607

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
