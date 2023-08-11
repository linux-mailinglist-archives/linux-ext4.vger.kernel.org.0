Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBD1778781
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Aug 2023 08:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjHKGg3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Aug 2023 02:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjHKGg3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Aug 2023 02:36:29 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264E12694
        for <linux-ext4@vger.kernel.org>; Thu, 10 Aug 2023 23:36:28 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RMYwS1HyKz4f3nVF
        for <linux-ext4@vger.kernel.org>; Fri, 11 Aug 2023 14:36:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP4 (Coremail) with SMTP id gCh0CgA3x6na1tVkKEbDAQ--.35746S6;
        Fri, 11 Aug 2023 14:36:25 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com
Subject: [PATCH v3 02/12] jbd2: move load_superblock() into journal_init_common()
Date:   Fri, 11 Aug 2023 14:36:00 +0800
Message-Id: <20230811063610.2980059-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230811063610.2980059-1-yi.zhang@huaweicloud.com>
References: <20230811063610.2980059-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3x6na1tVkKEbDAQ--.35746S6
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWfAw1xZr4xAr4DZr1rCrg_yoW8AFyxpr
        y3C348ZrWvvrWUZ3W8XFW8GFWUX3yIkFW7Gr4Duw1ktayrJrnxtw1Dtrn5JFy8ZFWUGw18
        JF1UCasrCw1qqa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUc6pPUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

Move the call to load_superblock() from jbd2_journal_load() and
jbd2_journal_wipe() early into journal_init_common(), the journal
superblock gets read and the in-memory journal_t structure gets
initialised after calling jbd2_journal_init_{dev,inode}, it's safe to
do following initialization according to it.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/journal.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 48c44c7fccf4..b247d374e7a6 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1582,6 +1582,10 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	journal->j_sb_buffer = bh;
 	journal->j_superblock = (journal_superblock_t *)bh->b_data;
 
+	err = load_superblock(journal);
+	if (err)
+		goto err_cleanup;
+
 	journal->j_shrink_transaction = NULL;
 	journal->j_shrinker.scan_objects = jbd2_journal_shrink_scan;
 	journal->j_shrinker.count_objects = jbd2_journal_shrink_count;
@@ -2056,13 +2060,7 @@ EXPORT_SYMBOL(jbd2_journal_update_sb_errno);
 int jbd2_journal_load(journal_t *journal)
 {
 	int err;
-	journal_superblock_t *sb;
-
-	err = load_superblock(journal);
-	if (err)
-		return err;
-
-	sb = journal->j_superblock;
+	journal_superblock_t *sb = journal->j_superblock;
 
 	/*
 	 * If this is a V2 superblock, then we have to check the
@@ -2521,10 +2519,6 @@ int jbd2_journal_wipe(journal_t *journal, int write)
 
 	J_ASSERT (!(journal->j_flags & JBD2_LOADED));
 
-	err = load_superblock(journal);
-	if (err)
-		return err;
-
 	if (!journal->j_tail)
 		goto no_recovery;
 
-- 
2.34.3

