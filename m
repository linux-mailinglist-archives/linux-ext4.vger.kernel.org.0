Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DECE82FFC52
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jan 2021 06:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbhAVFqI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jan 2021 00:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbhAVFqF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jan 2021 00:46:05 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD24C06178A
        for <linux-ext4@vger.kernel.org>; Thu, 21 Jan 2021 21:45:25 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id i5so2978561pgo.1
        for <linux-ext4@vger.kernel.org>; Thu, 21 Jan 2021 21:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vrofo34Z06TV0exyRoYDM8FaIHgtMtKJSkG6PKivnCE=;
        b=ZCvVrJ4Hjc909sDJuoFEIv2IXxc48G8gDpywSeZ377hqwlu1+HUL1xpo4vn2DsMaWo
         47n/Q8cpOk1ECZIgFgyjNzWYJnsTd/he7Yna1LB2plXkuFBdvaJILZ075Ues4V543bof
         jGg5LPxyDyiOosdXqD8hy98CJeTlcAN2PKN8SSj8jOHMewAYt96Ek67JLzxG58pQuFRd
         oJYMPhWE6/4TP9fxJhUdXskXSS9feWPxlI0uhaQDca8Zl4xZ7rc2YHmYOsI4by30kQuw
         fjaD9839aehsm6MBAnS14U/k4bTPSaBpghx9MriD0BJk4g5w/xb0UNwW1I1i79vPr9oS
         0BSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vrofo34Z06TV0exyRoYDM8FaIHgtMtKJSkG6PKivnCE=;
        b=OcqFtQotg1ygll5TpLP7OevcMXvi7MZcxKp5Ywi4UmTv3BZoHuTZeWNjeyfJ+/gLvM
         bN6EjpDOm9RocAj01AGb9/+sfVI5kLgA3iZslCI9dH7xAOxW9yYqnEUTgF11Lzgx0Xhc
         TTrLAQQ/U1LR1LfUpSqOynIxfTLVj2w3uzP7yYsIvJ3hLn6x6Y5ybEQVVQVfV5MZtKfn
         Z6FqUgZyfbCIZII+LvuG+ut2AqTspsY43uZd+cEfSmUHPMegt9hlWDFluZBQBGLQ3Kbn
         zSWz2g7ANDrkg11nBHWSpSrhjCngLctmA0ub13qkuFv9Eo5WiTLO8QQ2/bKudibzaJOh
         XvWw==
X-Gm-Message-State: AOAM530xeN2N4mXJB2iVnOrl+frJf136W1H9mNEYjAsODY8s2L5i8TBK
        5eHgjLDo7r2nzwyfuFyLRrDQPaXXPy4=
X-Google-Smtp-Source: ABdhPJz0B5VDH0N8nCk6U0p1kMMKoazC2HEnfJ3G/dO1TMrq7AZfW1NQl5JUY0u+y78/TuK46DsIhw==
X-Received: by 2002:a05:6a00:2296:b029:1b6:6972:2f2a with SMTP id f22-20020a056a002296b02901b669722f2amr3118216pfe.69.1611294324226;
        Thu, 21 Jan 2021 21:45:24 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id gg6sm12245827pjb.2.2021.01.21.21.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 21:45:23 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <--global>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v4 5/8] e2fsck: add fast commit replay skeleton
Date:   Thu, 21 Jan 2021 21:45:01 -0800
Message-Id: <20210122054504.1498532-6-user@harshads-520.kir.corp.google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210122054504.1498532-1-user@harshads-520.kir.corp.google.com>
References: <20210122054504.1498532-1-user@harshads-520.kir.corp.google.com>
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
2.30.0.280.ga3ce27912f-goog

