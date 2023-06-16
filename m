Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07438732D30
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jun 2023 12:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjFPKQZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Jun 2023 06:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245134AbjFPKQO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Jun 2023 06:16:14 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE6C2D6B;
        Fri, 16 Jun 2023 03:16:09 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QjFPg3843zLljW;
        Fri, 16 Jun 2023 18:14:15 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 16 Jun
 2023 18:16:07 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <changfengnan@bytedance.com>, <yuehaibing@huawei.com>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] ext4: Remove used function ext4_journal_callback_try_del()
Date:   Fri, 16 Jun 2023 18:15:04 +0800
Message-ID: <20230616101504.32520-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

commit a015434480dc ("ext4: send parallel discards on commit completions")
removed its last caller so drop it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/ext4/ext4_jbd2.h | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 0c77697d5e90..33b9d328ca9e 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -185,27 +185,6 @@ static inline void ext4_journal_callback_add(handle_t *handle,
 	spin_unlock(&sbi->s_md_lock);
 }
 
-
-/**
- * ext4_journal_callback_del: delete a registered callback
- * @handle: active journal transaction handle on which callback was registered
- * @jce: registered journal callback entry to unregister
- * Return true if object was successfully removed
- */
-static inline bool ext4_journal_callback_try_del(handle_t *handle,
-					     struct ext4_journal_cb_entry *jce)
-{
-	bool deleted;
-	struct ext4_sb_info *sbi =
-			EXT4_SB(handle->h_transaction->t_journal->j_private);
-
-	spin_lock(&sbi->s_md_lock);
-	deleted = !list_empty(&jce->jce_list);
-	list_del_init(&jce->jce_list);
-	spin_unlock(&sbi->s_md_lock);
-	return deleted;
-}
-
 int
 ext4_mark_iloc_dirty(handle_t *handle,
 		     struct inode *inode,
-- 
2.34.1

