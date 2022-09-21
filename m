Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A3F5BF64F
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Sep 2022 08:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiIUGaA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Sep 2022 02:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiIUG35 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Sep 2022 02:29:57 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AC514D1B;
        Tue, 20 Sep 2022 23:29:55 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MXT3D4mWzzpTjT;
        Wed, 21 Sep 2022 14:27:04 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 21 Sep
 2022 14:29:52 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next v2 3/3] ext4: update 'state->fc_regions_size' after successful memory allocation
Date:   Wed, 21 Sep 2022 14:40:40 +0800
Message-ID: <20220921064040.3693255-4-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220921064040.3693255-1-yebin10@huawei.com>
References: <20220921064040.3693255-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

To avoid to 'state->fc_regions_size' mismatch with 'state->fc_regions'
when fail to reallocate 'fc_reqions',only update 'state->fc_regions_size'
after 'state->fc_regions' is allocated successfully.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/fast_commit.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index f5b0fc50ed47..694ab0627395 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1681,14 +1681,15 @@ int ext4_fc_record_regions(struct super_block *sb, int ino,
 	if (state->fc_regions_used == state->fc_regions_size) {
 		struct ext4_fc_alloc_region *fc_regions;
 
-		state->fc_regions_size +=
-			EXT4_FC_REPLAY_REALLOC_INCREMENT;
 		fc_regions = krealloc(state->fc_regions,
-				      state->fc_regions_size *
-				      sizeof(struct ext4_fc_alloc_region),
+				      sizeof(struct ext4_fc_alloc_region) *
+				      (state->fc_regions_size +
+				       EXT4_FC_REPLAY_REALLOC_INCREMENT),
 				      GFP_KERNEL);
 		if (!fc_regions)
 			return -ENOMEM;
+		state->fc_regions_size +=
+			EXT4_FC_REPLAY_REALLOC_INCREMENT;
 		state->fc_regions = fc_regions;
 	}
 	region = &state->fc_regions[state->fc_regions_used++];
-- 
2.31.1

