Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4EB686553
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Feb 2023 12:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjBALXD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Feb 2023 06:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjBALXA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Feb 2023 06:23:00 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FAC3C1A;
        Wed,  1 Feb 2023 03:22:59 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4P6KK94q4lz4f3jYx;
        Wed,  1 Feb 2023 19:22:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgDn4R+NS9pj_j45Cg--.57546S5;
        Wed, 01 Feb 2023 19:22:55 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH 1/5] jbd2: introduce callback for recovery journal
Date:   Wed,  1 Feb 2023 19:46:47 +0800
Message-Id: <20230201114651.4090446-2-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230201114651.4090446-1-yebin@huaweicloud.com>
References: <20230201114651.4090446-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDn4R+NS9pj_j45Cg--.57546S5
X-Coremail-Antispam: 1UD129KBjvJXoWrtryrCryxJrW7Aw4UWry7Awb_yoW8JrW8pa
        s5Cwn3CFW8uFy7Cr1fJa18AFWIv3yv9r4UGF98u3s0y347trZ2qaykGw15try5Ar43K3yj
        qr1UCrW3Cw1YkrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjxUzoGQUUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

EXT4 file system's super block may submited by journal, however it
maybe submited directly when do error handle and also other scene.
So super block isn't uptodate in journal. So there is need to do
some extra handle when recover journal.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 include/linux/jbd2.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 5962072a4b19..ab0e1a435a50 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1308,6 +1308,17 @@ struct journal_s
 				    struct buffer_head *bh,
 				    enum passtype pass, int off,
 				    tid_t expected_commit_id);
+	/*
+	 * EXT4 file system's super block may submited by journal, however it
+	 * maybe submited directly when do error handle. So super block isn't
+	 * uptodate in journal. So there is need to do some extra handle when
+	 * recover journal.
+	 */
+	void *j_replay_private_data;
+	int (*j_replay_prepare_callback)(struct journal_s *journal);
+	int (*j_replay_callback)(struct journal_s *journal,
+				  struct buffer_head *bh);
+	void (*j_replay_end_callback)(struct journal_s *journal);
 };
 
 #define jbd2_might_wait_for_commit(j) \
-- 
2.31.1

