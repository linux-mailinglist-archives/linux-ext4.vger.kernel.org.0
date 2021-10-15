Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9A342FAEE
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Oct 2021 20:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238099AbhJOS1h (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Oct 2021 14:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242502AbhJOS1f (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 15 Oct 2021 14:27:35 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAC5C061762
        for <linux-ext4@vger.kernel.org>; Fri, 15 Oct 2021 11:25:28 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id e10so2014860plh.8
        for <linux-ext4@vger.kernel.org>; Fri, 15 Oct 2021 11:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/zML258PTe3cKA7ecvxnSQ7xvyxACM1IYLBF+ivpPU8=;
        b=SQmsCyfhs5Uz6GrjJX/K050hCPC/ZpkAqeBcXb0UmRElngz1EqzqGtX5V+th9dp6Ks
         51hLM+1G4w5AvMQtxKMiJKcfwS9TxQXe2bq4T2M+1UgxX+BUaTwFESbiWiii8KNh94Ua
         i47SI0g8OZTzOCqoYtn9ytixEFVS2JbDlJEfx0wccC3OeA0Rf3s1LUkY/ZqPr5F2x1fe
         lxD1djflrMlapfTzhruD6kcK580XP+Kz0pnB1kXjmjQ7APUgoY8OAiBDvjgpurHfWukf
         KJig2t5KBkb9tG0oiByYpijTdRe7EHYfmeoAorkmfdALoJLh7Iaok7yVmXIrr+4shDhT
         iBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/zML258PTe3cKA7ecvxnSQ7xvyxACM1IYLBF+ivpPU8=;
        b=VD6E5igZy18CV2fg95GkWWYNHaLPSm3LptoNkq43kRBXPJiKxpCERTiMl1OHyklzed
         l4nP8fD3ZljwA3Rk7Dq07erqLcDlF7B8aUAxkK+CPsvZNr0PbZ9ZXG2wQxA7+uAqTGGh
         MPSm1KbkzrZlmv/0d6Dr8oLhjZIrsxCeWW7Dqkl+x3vi4VwPFm66XYedlI1DI0ChG1ld
         ddDg47AmuLhct3zS8ajSsYrjyFRoG3RBf325yGKxSaaVXZIL7o3P04HN3leg11pyWk4w
         Rt7wNXFZomB7fkIqpOuI5pH4+eNtsGBHIlvynDQfXYLKpkjULaqOBa+3PRrUsErzCqyp
         wWcQ==
X-Gm-Message-State: AOAM532XWf9fCTXUA1qPTNhfsSNUhkmMoMw1nGM5qmkXBO1MnKD+zx2L
        r53oXuZyDjfVfwn+yHaGDioZngWE/Rc=
X-Google-Smtp-Source: ABdhPJy73MXJRbOze1bWaUoojEn4L0x50q2+Ie3Hn3RkpNj7k+iBJb0gcd2nyiYGlxkBPn5zSNnvtg==
X-Received: by 2002:a17:90a:9403:: with SMTP id r3mr29319227pjo.220.1634322327810;
        Fri, 15 Oct 2021 11:25:27 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:908e:77f9:869:b859])
        by smtp.googlemail.com with ESMTPSA id n14sm5215574pgd.68.2021.10.15.11.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 11:25:26 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 2/2] ext4: inline data inode fast commit replay fixes
Date:   Fri, 15 Oct 2021 11:25:13 -0700
Message-Id: <20211015182513.395917-2-harshads@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
In-Reply-To: <20211015182513.395917-1-harshads@google.com>
References: <20211015182513.395917-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Since there are no blocks in an inline data inode, there's no point in
fixing iblocks field in fast commit replay path for this inode.
Similarly, there's no point in fixing any block bitmaps / global block
counters with respect to such an inode. Just bail out from these
functions if an inline data inode is encountered.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/extents.c     | 3 +++
 fs/ext4/fast_commit.c | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 09f56e04f4b2..0ecf819bf189 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -6071,6 +6071,9 @@ int ext4_ext_clear_bb(struct inode *inode)
 	int j, ret = 0;
 	struct ext4_map_blocks map;
 
+	if (ext4_test_inode_flag(inode, EXT4_INODE_INLINE_DATA))
+		return 0;
+
 	/* Determin the size of the file first */
 	path = ext4_find_extent(inode, EXT_MAX_BLOCKS - 1, NULL,
 					EXT4_EX_NOCACHE);
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 744b000d9756..0f32b445582a 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1526,7 +1526,8 @@ static int ext4_fc_replay_inode(struct super_block *sb, struct ext4_fc_tl *tl,
 	 * crashing. This should be fixed but until then, we calculate
 	 * the number of blocks the inode.
 	 */
-	ext4_ext_replay_set_iblocks(inode);
+	if (!ext4_test_inode_flag(inode, EXT4_INODE_INLINE_DATA))
+		ext4_ext_replay_set_iblocks(inode);
 
 	inode->i_generation = le32_to_cpu(ext4_raw_inode(&iloc)->i_generation);
 	ext4_reset_inode_seed(inode);
@@ -1844,6 +1845,10 @@ static void ext4_fc_set_bitmaps_and_counters(struct super_block *sb)
 		}
 		cur = 0;
 		end = EXT_MAX_BLOCKS;
+		if (ext4_test_inode_flag(inode, EXT4_INODE_INLINE_DATA)) {
+			iput(inode);
+			continue;
+		}
 		while (cur < end) {
 			map.m_lblk = cur;
 			map.m_len = end - cur;
-- 
2.33.0.882.g93a45727a2-goog

