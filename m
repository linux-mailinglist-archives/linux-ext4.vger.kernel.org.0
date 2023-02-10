Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC496916E9
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Feb 2023 03:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjBJC5H (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Feb 2023 21:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjBJC5F (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Feb 2023 21:57:05 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD84663CD;
        Thu,  9 Feb 2023 18:57:03 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PCdgH1MP9z4f3nTG;
        Fri, 10 Feb 2023 10:56:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgCHgR96suVjIkgqDA--.35208S6;
        Fri, 10 Feb 2023 10:57:01 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH v2 2/6] ext4: introudce helper for jounral recover handle
Date:   Fri, 10 Feb 2023 11:20:40 +0800
Message-Id: <20230210032044.146115-3-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230210032044.146115-1-yebin@huaweicloud.com>
References: <20230210032044.146115-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCHgR96suVjIkgqDA--.35208S6
X-Coremail-Antispam: 1UD129KBjvJXoWxAFy5KFyfGF13Jr43Kry7GFg_yoW5tFyDpr
        WrCr1FyrW8u3Zrua13GrsrJF9Ivw40ka45Gry3CasIka47tryxAayktF1UCFWYqrWUWw1r
        Xa4jy348Gw45KrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjxU2_MaUUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

Now, ext4 file system only need to handle super block when do
recover journal.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/ext4_jbd2.c | 65 +++++++++++++++++++++++++++++++++++++++++++++
 fs/ext4/ext4_jbd2.h |  2 ++
 fs/ext4/super.c     |  1 +
 3 files changed, 68 insertions(+)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 77f318ec8abb..af03035606e1 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -395,3 +395,68 @@ int __ext4_handle_dirty_metadata(const char *where, unsigned int line,
 	}
 	return err;
 }
+
+static void ext4_replay_end_callback(struct journal_s *journal)
+{
+	kfree(journal->j_replay_private_data);
+	journal->j_replay_private_data = NULL;
+	journal->j_replay_callback = NULL;
+	journal->j_replay_end_callback = NULL;
+}
+
+static int ext4_replay_callback(struct journal_s *journal,
+				struct buffer_head *bh)
+{
+	struct super_block *sb = journal->j_private;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_super_block *es = sbi->s_es;
+	struct ext4_super_block *nes;
+	unsigned long offset;
+
+	if (likely(sbi->s_sbh != bh))
+		return 0;
+
+	offset = (void*)es - (void*)sbi->s_sbh->b_data;
+	nes = (struct ext4_super_block*)(bh->b_data + offset);
+	/*
+	 * If super block has error flag in journal record, there isn't need to
+	 * cover error information, as in this case is errors=continue mode,
+	 * error handle submit super block through journal.
+	 */
+	if (le16_to_cpu(nes->s_state) & EXT4_ERROR_FS)
+		return 0;
+
+	memcpy(((char *)es) + EXT4_S_ERR_START,
+	       journal->j_replay_private_data, EXT4_S_ERR_LEN);
+	if (sbi->s_mount_state & EXT4_ERROR_FS)
+		es->s_state |= cpu_to_le16(EXT4_ERROR_FS);
+
+	return 0;
+}
+
+static int ext4_replay_prepare_callback(struct journal_s *journal)
+{
+	struct super_block *sb = journal->j_private;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	char *private;
+	struct ext4_super_block *es = sbi->s_es;
+
+	if (!(sbi->s_mount_state & EXT4_ERROR_FS))
+		return 0;
+
+	private = kmalloc(EXT4_S_ERR_LEN, GFP_KERNEL);
+	if (!private)
+		return -ENOMEM;
+	memcpy(private, ((char *)es) + EXT4_S_ERR_START, EXT4_S_ERR_LEN);
+
+	journal->j_replay_private_data = private;
+	journal->j_replay_callback = ext4_replay_callback;
+	journal->j_replay_end_callback = ext4_replay_end_callback;
+
+	return 0;
+}
+
+void ext4_init_replay(journal_t *journal)
+{
+	journal->j_replay_prepare_callback = ext4_replay_prepare_callback;
+}
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 0c77697d5e90..8dcc7ef5028c 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -513,4 +513,6 @@ static inline int ext4_should_dioread_nolock(struct inode *inode)
 	return 1;
 }
 
+void ext4_init_replay(journal_t *journal);
+
 #endif	/* _EXT4_JBD2_H */
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dc3907dff13a..ea0fea04907c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5677,6 +5677,7 @@ static void ext4_init_journal_params(struct super_block *sb, journal_t *journal)
 	journal->j_commit_interval = sbi->s_commit_interval;
 	journal->j_min_batch_time = sbi->s_min_batch_time;
 	journal->j_max_batch_time = sbi->s_max_batch_time;
+	ext4_init_replay(journal);
 	ext4_fc_init(sb, journal);
 
 	write_lock(&journal->j_state_lock);
-- 
2.31.1

