Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82DF2D6435
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Dec 2020 18:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393003AbgLJR6I (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Dec 2020 12:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392987AbgLJR5r (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Dec 2020 12:57:47 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2404DC061794
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 09:56:50 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id bj5so3162909plb.4
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 09:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/1TrnKM1yif1L/httOO/yLUrYfS2TFf5HBbaynBMCBY=;
        b=ePUgpB+s+Qsr1fZAH3tdzgkRrvJV/yyjLNvUwxxRorN5hk+XqZqVk45KkV9kt5U7Ja
         O7hAHfhmaeFsfYWLGku6big29xkq6qV95gk/RnKkGT1jbwKm2EipYjc5HEiwI4U1G1TM
         1xGUJJ2ClS/9bTb3e1iTQ/etW4JgXPDXbxWAkq2zoP+IB3U7zXrkV8mSX86tNYfZ6GHQ
         2gQHiMUv174helKG4+o+6TMRZRYf4CFYsGFdxVt7sGT2dBgPlQXiljEBYaB1Qv/TjFL9
         By0kXN83wFZP3m3wRGMqkeL9KfywkD+T+RcN2BU6Ue823b0WGETn3lXl/C+lHqokzXiy
         CNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/1TrnKM1yif1L/httOO/yLUrYfS2TFf5HBbaynBMCBY=;
        b=gx2Wr0Mb+9RQqKQSwYIMQ+VByX17wPMqE46SnbaLciVhZ1UbXK9HM7J/4LUCPRRc2e
         JeiSkCQxtKzfylAspnukFfHIMPCFAjYo1czYActeIjJNNnWP6SPu3wxri6jdUpLucfP6
         9izWON0xPhJ13lvn8FQ0xWFuvID/fhhd3BgN9drkVx2YsBQAneTb9llZ2QMSbneaiDjg
         VKsnRN/MXd0IeBK6rbVIMBZhUaKrQdPlJTbjFIYLy3avuITy1o9Ya+2836ODxszEr+Dn
         IT2NgRKP1g6Z8POUhqffpQGgXc0mDKTIP9Xj99B5HVX5anLQJ8hzyorCy3YGrwKs/Iq+
         DAxA==
X-Gm-Message-State: AOAM531zY7VJL1YCxcwrUdYOoBHP8UvaWOxHMPK29wYNYa5jU/BcrZ/E
        Dq/8PaeZJO/oBMq6EuRU7ABkPp1jC48=
X-Google-Smtp-Source: ABdhPJyrhLKDTcTljqd1aiANfYu0L+3VsGJeuNyUJ66d+u2iPov9XXCdSYdjhpTSEnQJ6DO/8NB57g==
X-Received: by 2002:a17:902:fe91:b029:da:6bf3:7ba0 with SMTP id x17-20020a170902fe91b02900da6bf37ba0mr5216576plm.2.1607623009307;
        Thu, 10 Dec 2020 09:56:49 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id u24sm7433517pfm.81.2020.12.10.09.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 09:56:48 -0800 (PST)
From:   harshadshirwadkar@gmail.com
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 10/15] e2fsck: add fast commit replay skeleton
Date:   Thu, 10 Dec 2020 09:56:03 -0800
Message-Id: <20201210175608.3265541-11-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201210175608.3265541-1-harshadshirwadkar@gmail.com>
References: <20201210175608.3265541-1-harshadshirwadkar@gmail.com>
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
index f1aa0fd6..007c32c6 100644
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
2.29.2.576.ga3fc446d84-goog

