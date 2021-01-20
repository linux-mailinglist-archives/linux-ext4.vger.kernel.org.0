Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E8C2FDDFF
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Jan 2021 01:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbhAUAcW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Jan 2021 19:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733125AbhATVb5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Jan 2021 16:31:57 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01EEC0617B1
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jan 2021 13:26:58 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id be12so13244278plb.4
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jan 2021 13:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PmskyIaMk88uYv412rQo+RqT6ahH9Qh8QXZ0eT4+VoU=;
        b=kLgmxWU7X20w8ilSYV5Td3t6nSJIBW7huAC6e1olnMyHTDf6RfiSi9WttZe6GLhS0s
         H1ENVRxTAyHMa1bLq6FhUNJYZ6Z9c32zmYgT+UAFuRebyoFUOjgW1E+iYx/MlSGlnvDe
         qnJzUJfqe89DFps24nwDod0GWspKiiau5EJ7tEr62c6es8HEt4AK8JJ8+9oqYOtUviBx
         oMywWXhLvNc/uIiIJGvPL+I8xdillpMkCHyd76FfdHQ+DL388Y0Kv/By0s85oZ3qlTXG
         xqnyPKNccw/p1GFIVUyb8AfHl2W25TjKblK7ce8AybfnOzLLc/O3BRSAvt+P+JPBnrTW
         ZOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PmskyIaMk88uYv412rQo+RqT6ahH9Qh8QXZ0eT4+VoU=;
        b=cK5Mt5ZcfxSWp2nRnKN4I0DQ/xSlVqtTLIfprZP7mCcHHFXCngOnjhDzVsHL3jf9V3
         NaPbkMKt4zSDSNQoHdSyC+SGGKKO/oUdCrigwL/VRnUdR7r8XjFGF9BY4kXy8M3Xp0Xg
         fLo1zgYmQyNH/sdrRwc+ezS2YpxLJofi0oTL92uBvi5B/oRzXN3s6Bao6h+RdeP+t3MM
         J5fY5OmjK9Q/Xg4gbLBuTQfh5StWTPXxfhUnKl+dsj3X0dBy+SQHSlsAqK9HRxRm5/Vt
         shASJ+Bg/7R7ZJWYSBGrZII7lBAunwkasj+kJFdr08QLnNUEffW3KPjr3RWBeHEHL/D9
         8LpA==
X-Gm-Message-State: AOAM533wey7uXRB0pqO4NyZji9FVM4SewbWkd5ByQi6FAjExIrddpyOJ
        Fe+abQQ955E4t+PX8Ulrgd5J4Vn5NHc=
X-Google-Smtp-Source: ABdhPJx+ZWFPlLaJ6Rh/YVvTHarw7au5uXaWnjLhgk70flqdL8YHsLRal57yt08eS89WuakKWoD4FQ==
X-Received: by 2002:a17:90a:f692:: with SMTP id cl18mr2077520pjb.102.1611178018000;
        Wed, 20 Jan 2021 13:26:58 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id w1sm3396758pjt.23.2021.01.20.13.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 13:26:57 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <--global>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v3 10/15] e2fsck: add fast commit replay skeleton
Date:   Wed, 20 Jan 2021 13:26:36 -0800
Message-Id: <20210120212641.526556-11-user@harshads-520.kir.corp.google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210120212641.526556-1-user@harshads-520.kir.corp.google.com>
References: <20210120212641.526556-1-user@harshads-520.kir.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

This function adds the skeleton for the replay path. Following patches
in the series implement the handling for individual tags.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 e2fsck/journal.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index ba38124e..9d0637e3 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -390,11 +390,83 @@ static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
 {
 	e2fsck_t ctx = journal->j_fs_dev->k_ctx;
 	struct e2fsck_fc_replay_state *state = &ctx->fc_replay_state;
+	int ret = JBD2_FC_REPLAY_CONTINUE;
+	struct ext4_fc_tl *tl;
+	__u8 *start, *end;
 
 	if (pass == PASS_SCAN) {
 		state->fc_current_pass = PASS_SCAN;
 		return ext4_fc_replay_scan(journal, bh, off, expected_tid);
 	}
+
+	if (state->fc_replay_num_tags == 0)
+		goto replay_done;
+
+	if (state->fc_current_pass != pass) {
+		/* Starting replay phase */
+		state->fc_current_pass = pass;
+		/* We will reset checksums */
+		ctx->fs->flags |= EXT2_FLAG_IGNORE_CSUM_ERRORS;
+		ret = ext2fs_read_bitmaps(ctx->fs);
+		if (ret) {
+			jbd_debug(1, "Error %d while reading bitmaps\n", ret);
+			return ret;
+		}
+		state->fc_super_state = ctx->fs->super->s_state;
+		/*
+		 * Mark the file system to indicate it contains errors. That's
+		 * because the updates performed by fast commit replay code are
+		 * not atomic and may result in incosistent file system if it
+		 * crashes before the replay is complete.
+		 */
+		ctx->fs->super->s_state |= EXT2_ERROR_FS;
+		ctx->fs->super->s_state |= EXT4_FC_REPLAY;
+		ext2fs_mark_super_dirty(ctx->fs);
+		ext2fs_flush(ctx->fs);
+	}
+
+	start = (__u8 *)bh->b_data;
+	end = (__u8 *)bh->b_data + journal->j_blocksize - 1;
+
+	fc_for_each_tl(start, end, tl) {
+		if (state->fc_replay_num_tags == 0)
+			goto replay_done;
+		jbd_debug(3, "Replay phase processing %s tag\n",
+				tag2str(le16_to_cpu(tl->fc_tag)));
+		state->fc_replay_num_tags--;
+		switch (le16_to_cpu(tl->fc_tag)) {
+		case EXT4_FC_TAG_CREAT:
+		case EXT4_FC_TAG_LINK:
+		case EXT4_FC_TAG_UNLINK:
+		case EXT4_FC_TAG_ADD_RANGE:
+		case EXT4_FC_TAG_DEL_RANGE:
+		case EXT4_FC_TAG_INODE:
+		case EXT4_FC_TAG_TAIL:
+		case EXT4_FC_TAG_PAD:
+		case EXT4_FC_TAG_HEAD:
+			break;
+		default:
+			ret = -ECANCELED;
+			break;
+		}
+		if (ret < 0)
+			break;
+		ret = JBD2_FC_REPLAY_CONTINUE;
+	}
+	return ret;
+replay_done:
+	jbd_debug(1, "End of fast commit replay\n");
+	if (state->fc_current_pass != pass)
+		return JBD2_FC_REPLAY_STOP;
+
+	ext2fs_calculate_summary_stats(ctx->fs, 0 /* update bg also */);
+	ext2fs_write_block_bitmap(ctx->fs);
+	ext2fs_write_inode_bitmap(ctx->fs);
+	ext2fs_mark_super_dirty(ctx->fs);
+	ext2fs_set_gdt_csum(ctx->fs);
+	ctx->fs->super->s_state = state->fc_super_state;
+	ext2fs_flush(ctx->fs);
+
 	return JBD2_FC_REPLAY_STOP;
 }
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog

