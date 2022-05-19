Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC7C52C9B6
	for <lists+linux-ext4@lfdr.de>; Thu, 19 May 2022 04:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbiESCRt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 May 2022 22:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbiESCRs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 May 2022 22:17:48 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9978AC03BA;
        Wed, 18 May 2022 19:17:47 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24J2HSO8023427
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 22:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652926650; bh=7wJlaQdu2mLwEBMOUHaHYhduYpt4P6VnfVJXVzVPkpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GCtMqm4GKaEGsd6UAKAV62md6J7b4FrIiF6eQc+9C0QiAoZKMIeIQJvAP2UzbJHrW
         MexKDmmGgYnp3g5zrSZwa236VDYO1E42b3/BgE4i93wdP8Nl1ZLnessDvyrZ1Qmjvz
         zNRKjBdWusm1yr0yHRzlHCP9bun/aMJqB+O8eau9QDQoY9362QWh3Ny468SxVUeGtQ
         sk9DVD4TIR5X4qYwh2kAHr3lLk7ID9YhfRnaBR3a8fs3LO8GdT+5lOrcDUCCTzRvVp
         5+DWSoCCLKxYUF5Wt9T+mh9R0XfYh5FxFhyuzjf+Jz12RVsNqZVxoiylAOJhHyBHif
         G/5Ag6psP6uVQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 375F815C3EC0; Wed, 18 May 2022 22:17:28 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        Hulk Robot <hulkci@huawei.com>, jack@suse.cz,
        yukuai3@huawei.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yebin10@huawei.com
Subject: Re: [PATCH] ext4: fix bug_on in __es_tree_search
Date:   Wed, 18 May 2022 22:17:27 -0400
Message-Id: <165292657449.1203635.7617827761368588470.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220518120816.1541863-1-libaokun1@huawei.com>
References: <20220518120816.1541863-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 18 May 2022 20:08:16 +0800, Baokun Li wrote:
> Hulk Robot reported a BUG_ON:
> ==================================================================
> kernel BUG at fs/ext4/extents_status.c:199!
> [...]
> RIP: 0010:ext4_es_end fs/ext4/extents_status.c:199 [inline]
> RIP: 0010:__es_tree_search+0x1e0/0x260 fs/ext4/extents_status.c:217
> [...]
> Call Trace:
>  ext4_es_cache_extent+0x109/0x340 fs/ext4/extents_status.c:766
>  ext4_cache_extents+0x239/0x2e0 fs/ext4/extents.c:561
>  ext4_find_extent+0x6b7/0xa20 fs/ext4/extents.c:964
>  ext4_ext_map_blocks+0x16b/0x4b70 fs/ext4/extents.c:4384
>  ext4_map_blocks+0xe26/0x19f0 fs/ext4/inode.c:567
>  ext4_getblk+0x320/0x4c0 fs/ext4/inode.c:980
>  ext4_bread+0x2d/0x170 fs/ext4/inode.c:1031
>  ext4_quota_read+0x248/0x320 fs/ext4/super.c:6257
>  v2_read_header+0x78/0x110 fs/quota/quota_v2.c:63
>  v2_check_quota_file+0x76/0x230 fs/quota/quota_v2.c:82
>  vfs_load_quota_inode+0x5d1/0x1530 fs/quota/dquot.c:2368
>  dquot_enable+0x28a/0x330 fs/quota/dquot.c:2490
>  ext4_quota_enable fs/ext4/super.c:6137 [inline]
>  ext4_enable_quotas+0x5d7/0x960 fs/ext4/super.c:6163
>  ext4_fill_super+0xa7c9/0xdc00 fs/ext4/super.c:4754
>  mount_bdev+0x2e9/0x3b0 fs/super.c:1158
>  mount_fs+0x4b/0x1e4 fs/super.c:1261
> [...]
> ==================================================================
> 
> [...]

Applied, thanks!

[1/1] ext4: fix bug_on in __es_tree_search
      commit: b76a7dd9a7437e8c21253ce3a7574bebde3827f9

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
