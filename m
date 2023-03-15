Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743956BA4B4
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Mar 2023 02:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjCOBc6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Mar 2023 21:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjCOBcw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Mar 2023 21:32:52 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD293865D;
        Tue, 14 Mar 2023 18:32:19 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PbtD2607KzKmrn;
        Wed, 15 Mar 2023 09:32:02 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 15 Mar
 2023 09:32:16 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.com>,
        <tudor.ambarus@linaro.org>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v3 2/6] ext4: ext4_put_super: Remove redundant checking for 'sbi->s_journal_bdev'
Date:   Wed, 15 Mar 2023 09:31:24 +0800
Message-ID: <20230315013128.3911115-3-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230315013128.3911115-1-chengzhihao1@huawei.com>
References: <20230315013128.3911115-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

As discussed in [1], 'sbi->s_journal_bdev != sb->s_bdev' will always
become true if sbi->s_journal_bdev exists. Filesystem block device and
journal block device are both opened with 'FMODE_EXCL' mode, so these
two devices can't be same one. Then we can remove the redundant checking
'sbi->s_journal_bdev != sb->s_bdev' if 'sbi->s_journal_bdev' exists.

[1] https://lore.kernel.org/lkml/f86584f6-3877-ff18-47a1-2efaa12d18b2@huawei.com/

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 61511b7ba017..a22417d113ca 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1277,7 +1277,7 @@ static void ext4_put_super(struct super_block *sb)
 
 	sync_blockdev(sb->s_bdev);
 	invalidate_bdev(sb->s_bdev);
-	if (sbi->s_journal_bdev && sbi->s_journal_bdev != sb->s_bdev) {
+	if (sbi->s_journal_bdev) {
 		sync_blockdev(sbi->s_journal_bdev);
 		ext4_blkdev_remove(sbi);
 	}
-- 
2.31.1

