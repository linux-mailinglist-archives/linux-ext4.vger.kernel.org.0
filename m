Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57CF41A0792
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Apr 2020 08:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgDGGqe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Apr 2020 02:46:34 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40875 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgDGGqd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Apr 2020 02:46:33 -0400
Received: by mail-pl1-f195.google.com with SMTP id h11so861150plk.7
        for <linux-ext4@vger.kernel.org>; Mon, 06 Apr 2020 23:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ta8VeTPdYNXMmAei3xDhPMTgNBRynkarJJvWk6QAh/c=;
        b=vCg/UzTdxAVAiW9l/1zUQMXkDwlua4BgxWhrq9eue55vbccNeSRM5dRESHA2R7kPiy
         YhdG/GEDPWeeBLP9ksDRN1V5J6g0ZM+KpL+BS3XUHk4/68b9b/65B22GIr22sVLSlG49
         3avIFCRJKDzI1Ey/hEdAkXAYQUzWn/O9znm7thK0fORQ9ts1YA+w8x8FXZIHB2EJ2uUS
         jqYNaZBCOmx7lPP5mShV+TX/AR0PizxV3sJtBOakbvu8IR05D7EAY/AqJpoJNzFCYvQR
         F31fXRfesIebfKVWAJC2RKUysh7boguLT/BZlYSdjf2DA1mxA0vkX9bjxNXYkoSIVo7i
         ZTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ta8VeTPdYNXMmAei3xDhPMTgNBRynkarJJvWk6QAh/c=;
        b=a4lc/E/pfTnQP5wpFDxaCAn6LwGg2xrYZwASjFACciLHyf3NEMFA92VQEYw1uV4mMi
         6I34BvOVxTf0PgskvQeyWsyxwoy5KxvJFoIwjk8jIUpTpCwGQ+Nz6hUqxrb6WUwT2Q1q
         fI1XrdGsmrOINcocRN5HYRejXwBPZwTUPK7f6I6aj1wDUayxOtUZQFmqxV4m2riI4tSf
         Oxf/FqSSsN8KPzixMBPx4nm6pJR4PgSUAtQrqCG/os1SkXUjZfPevbRRCzwRd+9u7V8p
         YXtIb4OmhE7FB0hmHqEcwYjEq2DiVK8Vb0Xo8q51JwS+xkgWKTgcDSm9y8LpCzFSBO8X
         kC0A==
X-Gm-Message-State: AGi0PuY7RLL2PJH6IYCEW6gxPGhkBNoVQFmA70w9fA5Q3v8WH+g9sZtY
        j4bHAIN/oNl19Sh6T3O19D2KVEbK
X-Google-Smtp-Source: APiQypIlHKEMULNNUZdic+5rLAREgmeXftD1+Z0C3vKCFy+HpAIeFxHbCOkY6vTFDmUyDKNEjcR0HQ==
X-Received: by 2002:a17:90a:290a:: with SMTP id g10mr957828pjd.81.1586241992128;
        Mon, 06 Apr 2020 23:46:32 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:6271:607:aca0:b6f7])
        by smtp.googlemail.com with ESMTPSA id g25sm5592030pfh.55.2020.04.06.23.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 23:46:31 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger@dilger.ca, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 3/3] ext4: reimplement ext4_empty_dir() using is_dirent_block_empty
Date:   Mon,  6 Apr 2020 23:46:16 -0700
Message-Id: <20200407064616.221459-3-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
In-Reply-To: <20200407064616.221459-1-harshadshirwadkar@gmail.com>
References: <20200407064616.221459-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The new function added in this patchset adds an efficient way to
check if a dirent block is empty. Based on that, reimplement
ext4_empty_dir().

This is a new patch added in V2.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/namei.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 39360c442dad..dae7d15fba5c 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3179,6 +3179,7 @@ bool ext4_empty_dir(struct inode *inode)
 	struct buffer_head *bh;
 	struct ext4_dir_entry_2 *de;
 	struct super_block *sb;
+	ext4_lblk_t lblk;
 
 	if (ext4_has_inline_data(inode)) {
 		int has_inline_data = 1;
@@ -3218,34 +3219,26 @@ bool ext4_empty_dir(struct inode *inode)
 		brelse(bh);
 		return true;
 	}
-	offset += ext4_rec_len_from_disk(de->rec_len, sb->s_blocksize);
-	while (offset < inode->i_size) {
-		if (!(offset & (sb->s_blocksize - 1))) {
-			unsigned int lblock;
-			brelse(bh);
-			lblock = offset >> EXT4_BLOCK_SIZE_BITS(sb);
-			bh = ext4_read_dirblock(inode, lblock, EITHER);
-			if (bh == NULL) {
-				offset += sb->s_blocksize;
-				continue;
-			}
-			if (IS_ERR(bh))
-				return true;
-		}
-		de = (struct ext4_dir_entry_2 *) (bh->b_data +
-					(offset & (sb->s_blocksize - 1)));
-		if (ext4_check_dir_entry(inode, NULL, de, bh,
-					 bh->b_data, bh->b_size, offset)) {
-			offset = (offset | (sb->s_blocksize - 1)) + 1;
+	de = ext4_next_entry(de, sb->s_blocksize);
+	if (!is_empty_dirent_block(inode, bh, de)) {
+		brelse(bh);
+		return false;
+	}
+	brelse(bh);
+
+	for (lblk = 1; lblk < inode->i_size >> EXT4_BLOCK_SIZE_BITS(sb);
+			lblk++) {
+		bh = ext4_read_dirblock(inode, lblk, EITHER);
+		if (bh == NULL)
 			continue;
-		}
-		if (le32_to_cpu(de->inode)) {
+		if (IS_ERR(bh))
+			return true;
+		if (!is_empty_dirent_block(inode, bh, NULL)) {
 			brelse(bh);
 			return false;
 		}
-		offset += ext4_rec_len_from_disk(de->rec_len, sb->s_blocksize);
+		brelse(bh);
 	}
-	brelse(bh);
 	return true;
 }
 
-- 
2.26.0.292.g33ef6b2f38-goog

