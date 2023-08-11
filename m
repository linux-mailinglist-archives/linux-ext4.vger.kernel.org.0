Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D38E778783
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Aug 2023 08:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjHKGga (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Aug 2023 02:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjHKGg3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Aug 2023 02:36:29 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E21926A6
        for <linux-ext4@vger.kernel.org>; Thu, 10 Aug 2023 23:36:28 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RMYwS3fDDz4f3tqK
        for <linux-ext4@vger.kernel.org>; Fri, 11 Aug 2023 14:36:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP4 (Coremail) with SMTP id gCh0CgA3x6na1tVkKEbDAQ--.35746S7;
        Fri, 11 Aug 2023 14:36:25 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com
Subject: [PATCH v3 03/12] jbd2: don't load superblock in jbd2_journal_check_used_features()
Date:   Fri, 11 Aug 2023 14:36:01 +0800
Message-Id: <20230811063610.2980059-4-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230811063610.2980059-1-yi.zhang@huaweicloud.com>
References: <20230811063610.2980059-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3x6na1tVkKEbDAQ--.35746S7
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFWkKrW7ArWDGr1xJr43Wrg_yoW8GrWUpa
        yfKFy8CrZYvr1UAF1ktFs5JFWY9ay0yFWUGr4kuw1vy3yUXrnIqry7tr1rtFyvyFZ7uw18
        JF1kCws3Gws0qrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd8n5UUUUU=
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

Since load_superblock() has been moved to journal_init_common(), the
in-memory superblock structure is initialized and contains valid data
once the file system has a journal_t object, so it's safe to access it,
let's drop the call to journal_get_superblock() from
jbd2_journal_check_used_features() and also drop the setting/clearing of
the veirfy bit of the superblock buffer.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/journal.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index b247d374e7a6..c7cdb434966f 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1361,8 +1361,6 @@ static int journal_get_superblock(journal_t *journal)
 	bh = journal->j_sb_buffer;
 
 	J_ASSERT(bh != NULL);
-	if (buffer_verified(bh))
-		return 0;
 
 	err = bh_read(bh, 0);
 	if (err < 0) {
@@ -1437,7 +1435,6 @@ static int journal_get_superblock(journal_t *journal)
 			goto out;
 		}
 	}
-	set_buffer_verified(bh);
 	return 0;
 
 out:
@@ -2224,8 +2221,6 @@ int jbd2_journal_check_used_features(journal_t *journal, unsigned long compat,
 
 	if (!compat && !ro && !incompat)
 		return 1;
-	if (journal_get_superblock(journal))
-		return 0;
 	if (!jbd2_format_support_feature(journal))
 		return 0;
 
-- 
2.34.3

