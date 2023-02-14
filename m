Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF56695659
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Feb 2023 03:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjBNCFe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Feb 2023 21:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjBNCFc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Feb 2023 21:05:32 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C83D113E2;
        Mon, 13 Feb 2023 18:05:29 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PG4Kv6bmNz4f3jHy;
        Tue, 14 Feb 2023 10:05:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgCnUiBk7OpjvrkRDQ--.53521S5;
        Tue, 14 Feb 2023 10:05:26 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH v3 1/2] ext4: commit super block if fs record error when journal record without error
Date:   Tue, 14 Feb 2023 10:29:04 +0800
Message-Id: <20230214022905.765088-2-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230214022905.765088-1-yebin@huaweicloud.com>
References: <20230214022905.765088-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCnUiBk7OpjvrkRDQ--.53521S5
X-Coremail-Antispam: 1UD129KBjvJXoWrtrWUJry7uF48tr48ZFWrZrb_yoW8Jr48p3
        95Arn7AFZ0vF17CwsrJwsrXFyvg34Fka4UWr1Sk3Z3Aa9xtr9IvrZ8tF15AFWjgrW8Ww1r
        X34UGay7G3s5Kr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Now, 'es->s_state' maybe covered by recover journal. And journal errno
maybe not recorded in journal sb as IO error. ext4_update_super() only
update error information when 'sbi->s_add_error_count' large than zero.
Then 'EXT4_ERROR_FS' flag maybe lost.
To solve above issue commit error information after recover journal.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/super.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dc3907dff13a..b94754ba8556 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5932,6 +5932,18 @@ static int ext4_load_journal(struct super_block *sb,
 		goto err_out;
 	}
 
+	if (unlikely(es->s_error_count && !jbd2_journal_errno(journal) &&
+		     !(le16_to_cpu(es->s_state) & EXT4_ERROR_FS))) {
+		EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
+		es->s_state |= cpu_to_le16(EXT4_ERROR_FS);
+		err = ext4_commit_super(sb);
+		if (err) {
+			ext4_msg(sb, KERN_ERR,
+				 "Failed to commit error information, please repair fs force!");
+			goto err_out;
+		}
+	}
+
 	EXT4_SB(sb)->s_journal = journal;
 	err = ext4_clear_journal_err(sb, es);
 	if (err) {
-- 
2.31.1

