Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071D72BB50A
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Nov 2020 20:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732241AbgKTTQh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Nov 2020 14:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732200AbgKTTQg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Nov 2020 14:16:36 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B84C0613CF
        for <linux-ext4@vger.kernel.org>; Fri, 20 Nov 2020 11:16:36 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id q5so8795100pfk.6
        for <linux-ext4@vger.kernel.org>; Fri, 20 Nov 2020 11:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q8YFlbQ7XWrwAN2Ryud5370lyN2Z5xoaPuyNNSOvt/c=;
        b=pmn2iyhwp7pIKK5JeMJKkfpJ4/nmwFweQpO4LQs+uLb99O9qiANMXPZtNDLGcGgy4B
         Zo6fBhWijhrYVsOETHZjSngI8X3jJ0zKsA/IJx++aPBmq5xXBO+/1krjh8hd0z8Q1GS/
         tc4RUt/1NDUdC17SK1b7plz9K7pP4uZtddZpudTDETtF6ApMDVF+Tytke63BrOtV8S5J
         M9ATyxKl8al7dtggle/+ISKxPhWRciXIVSlC3kE3YqiOTa0hLoBOPBMothcj+j0HAQlr
         RF+i5XpFEbnmMkXmU/y0T6USvmSoKUL3llQCAZz+TDFGbh3YKD1hpvPHQeQxyEGXstBy
         nxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q8YFlbQ7XWrwAN2Ryud5370lyN2Z5xoaPuyNNSOvt/c=;
        b=qGZRIDQxMCoDw0xeQa6huMdyZeOe4vVuEeN3XwQuyMIE/i/MPCUdAaTe/yaN61BiL7
         PCCbPCTwiYxwaUqi04mlI255Z6CJFj3K7054lSSbki4wBaR+OOq+gS6J+3Wpx+vG2ara
         8jGJaOHU2AZ4jLMZ8PV7FDBVNdgC4x2G3QKh1D9fcdjkcAjaUq8peAbZ/CbvrUtHkvaA
         G1MG+ZfdfEKSKkQVCPHWk67rpu/OitM595baoKvoIOccdYz6+OVAspOwGKTfhHEcHXxx
         6+NbcTtn8SRRI1XC4T2yyaLqJ9RGH0aZwUmM6EzEukrnXCC9nsfkGCzlyLvvT8tQD1Gg
         Xwbw==
X-Gm-Message-State: AOAM531OqtQKAR/L60+1eY1ureFrRw9BGuLbMesprx/S7QflPGffO8Nr
        oXIq5N1bj59hdCklBlnRib87awiUvrk=
X-Google-Smtp-Source: ABdhPJwPBhwfDbX5+iLcuK3P5DKTGXGcPZNp/mAJIHUU3MtsIBezcBTLgE0eBu5SFXniQ8C4WOrHeQ==
X-Received: by 2002:a17:90a:5518:: with SMTP id b24mr6063098pji.138.1605899794461;
        Fri, 20 Nov 2020 11:16:34 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id o9sm4370480pjr.2.2020.11.20.11.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 11:16:33 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 09/15] e2fsck: add fast commit scan pass
Date:   Fri, 20 Nov 2020 11:16:00 -0800
Message-Id: <20201120191606.2224881-10-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201120191606.2224881-1-harshadshirwadkar@gmail.com>
References: <20201120191606.2224881-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add fast commit scan pass. Scan pass is responsible for following
things:

* Count total number of fast commit tags that need to be replayed
  during the replay phase.

* Validate whether the fast commit area is valid for a given
  transaction ID.

* Verify the CRC of fast commit area.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 e2fsck/journal.c | 107 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index 2c8e3441..1072dfe8 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -278,6 +278,106 @@ static int process_journal_block(ext2_filsys fs,
 	return 0;
 }
 
+static int ext4_fc_replay_scan(journal_t *j, struct buffer_head *bh,
+				int off, tid_t expected_tid)
+{
+	e2fsck_t ctx = j->j_fs_dev->k_ctx;
+	struct e2fsck_fc_replay_state *state;
+	int ret = JBD2_FC_REPLAY_CONTINUE;
+	struct ext4_fc_add_range *ext;
+	struct ext4_fc_tl *tl;
+	struct ext4_fc_tail *tail;
+	__u8 *start, *end;
+	struct ext4_fc_head *head;
+	struct ext3_extent *ex;
+	struct ext2fs_extent ext2fs_ex;
+
+	state = &ctx->fc_replay_state;
+
+	start = (__u8 *)bh->b_data;
+	end = (__u8 *)bh->b_data + j->j_blocksize - 1;
+
+	jbd_debug(1, "Scan phase starting, expected %d", expected_tid);
+	if (state->fc_replay_expected_off == 0) {
+		memset(state, 0, sizeof(*state));
+		/* Check if we can stop early */
+		if (le16_to_cpu(((struct ext4_fc_tl *)start)->fc_tag)
+			!= EXT4_FC_TAG_HEAD) {
+			jbd_debug(1, "Ending early!, not a head tag");
+			return 0;
+		}
+	}
+
+	if (off != state->fc_replay_expected_off) {
+		ret = -EFSCORRUPTED;
+		goto out_err;
+	}
+
+	state->fc_replay_expected_off++;
+	fc_for_each_tl(start, end, tl) {
+		jbd_debug(3, "Scan phase, tag:%s, blk %lld\n",
+			  tag2str(le16_to_cpu(tl->fc_tag)), bh->b_blocknr);
+		switch (le16_to_cpu(tl->fc_tag)) {
+		case EXT4_FC_TAG_ADD_RANGE:
+			ext = (struct ext4_fc_add_range *)ext4_fc_tag_val(tl);
+			ex = (struct ext3_extent *)&ext->fc_ex;
+			ext2fs_convert_extent(&ext2fs_ex, ex);
+			ret = JBD2_FC_REPLAY_CONTINUE;
+		case EXT4_FC_TAG_DEL_RANGE:
+		case EXT4_FC_TAG_LINK:
+		case EXT4_FC_TAG_UNLINK:
+		case EXT4_FC_TAG_CREAT:
+		case EXT4_FC_TAG_INODE:
+		case EXT4_FC_TAG_PAD:
+			state->fc_cur_tag++;
+			state->fc_crc = jbd2_chksum(j, state->fc_crc, tl,
+					sizeof(*tl) + ext4_fc_tag_len(tl));
+			break;
+		case EXT4_FC_TAG_TAIL:
+			state->fc_cur_tag++;
+			tail = (struct ext4_fc_tail *)ext4_fc_tag_val(tl);
+			state->fc_crc = jbd2_chksum(j, state->fc_crc, tl,
+						sizeof(*tl) +
+						offsetof(struct ext4_fc_tail,
+						fc_crc));
+			jbd_debug(1, "tail tid %d, expected %d\n",
+					le32_to_cpu(tail->fc_tid),
+					expected_tid);
+			if (le32_to_cpu(tail->fc_tid) == expected_tid &&
+				le32_to_cpu(tail->fc_crc) == state->fc_crc) {
+				state->fc_replay_num_tags = state->fc_cur_tag;
+			} else {
+				ret = state->fc_replay_num_tags ?
+					JBD2_FC_REPLAY_STOP : -EFSBADCRC;
+			}
+			state->fc_crc = 0;
+			break;
+		case EXT4_FC_TAG_HEAD:
+			head = (struct ext4_fc_head *)ext4_fc_tag_val(tl);
+			if (le32_to_cpu(head->fc_features) &
+				~EXT4_FC_SUPPORTED_FEATURES) {
+				ret = -EOPNOTSUPP;
+				break;
+			}
+			if (le32_to_cpu(head->fc_tid) != expected_tid) {
+				ret = -EINVAL;
+				break;
+			}
+			state->fc_cur_tag++;
+			state->fc_crc = jbd2_chksum(j, state->fc_crc, tl,
+					sizeof(*tl) + ext4_fc_tag_len(tl));
+			break;
+		default:
+			ret = state->fc_replay_num_tags ?
+				JBD2_FC_REPLAY_STOP : -ECANCELED;
+		}
+		if (ret < 0 || ret == JBD2_FC_REPLAY_STOP)
+			break;
+	}
+
+out_err:
+	return ret;
+}
 /*
  * Main recovery path entry point. This function returns JBD2_FC_REPLAY_CONTINUE
  * to indicate that it is expecting more fast commit blocks. It returns
@@ -286,6 +386,13 @@ static int process_journal_block(ext2_filsys fs,
 static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
 				enum passtype pass, int off, tid_t expected_tid)
 {
+	e2fsck_t ctx = journal->j_fs_dev->k_ctx;
+	struct e2fsck_fc_replay_state *state = &ctx->fc_replay_state;
+
+	if (pass == PASS_SCAN) {
+		state->fc_current_pass = PASS_SCAN;
+		return ext4_fc_replay_scan(journal, bh, off, expected_tid);
+	}
 	return JBD2_FC_REPLAY_STOP;
 }
 
-- 
2.29.2.454.gaff20da3a2-goog

