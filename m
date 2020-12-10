Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572B22D6434
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Dec 2020 18:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393001AbgLJR55 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Dec 2020 12:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392980AbgLJR5r (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Dec 2020 12:57:47 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EBBC0611CA
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 09:56:48 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id bj5so3162874plb.4
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 09:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uYEGK3agLiMcvqw2Jsl9oGwQ+1WxMbQ9sHcvsvmOS3k=;
        b=RW05OgX8vjD0t8UcX5ZLTcQMaAUavLeMVX3VNZlleeONMYg4Gzq9Vy1j1U9sOk8N4T
         G5y/znHwYV8y3ZS0Uh6bo8aXLbpJEC7aKv/ZiD8hWFbg2LXIApUPNVOBeGEsr0EELBb9
         0w21LjfnM76Pv3opmSSPOYbYcgeb66wME4M8vPWInegKM25j91y5Erk9C4uFGEyuMciT
         JvityrqiG2DMANJpafIQIRNSKIb/3teptVmcZrJHy84LqO7FE7ZouseFNnPqp92z6Ncd
         RLC8sxJwOAiXsB+yaPYz0lWInUc2rWmMNOIE5l4h7Losq6KJVIIFU4Oz8ZaEgfi+yAIf
         UAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uYEGK3agLiMcvqw2Jsl9oGwQ+1WxMbQ9sHcvsvmOS3k=;
        b=uGUito0OSGZiK6v5/C3WV5DabXN8RB7PuAxj0mhLHIIc6BkyQC8IdfW3IhJzxET9U7
         Qs/hd6TYZcLHi1EpRjr/+6ELeP5bm3RjQo46n0aO0kPqpFOV0f9L2tvPqt3HNBvdUhoP
         mxG8X/k+31+hLPN4DqUmsLakmVCx2+TF5uLv+7eSefd3+nuEDxiD6l70gPNyB37EW+Lf
         dP4WY1xW5uDxZ9WLlAaqwzroSNEY+W9nDJVKaA+77NRcKpt4avGfzOQPQS219EpI77Aw
         cXidXld/15DnRte+y+DwrAW6LTv8WOpOj8tXOeKnZhFM3KPV9hbsZT/fyMTsl3HJYBnW
         NdOg==
X-Gm-Message-State: AOAM530Dyi62U1cX/RP4baEH8L+0p8Cfkvs0UeUitA4Mei+e/QFRyXhW
        cmec63SO+ZB6hKs+Et7htyu3rXyK/aA=
X-Google-Smtp-Source: ABdhPJxM2pjlAidikZhyShZKcYHQiLmZywziFtpEf8RUFsmbUvGLEKZRvnhWeoEAtxbLoMY+swHVow==
X-Received: by 2002:a17:902:ee0b:b029:db:c808:ccef with SMTP id z11-20020a170902ee0bb02900dbc808ccefmr7477913plb.85.1607623008051;
        Thu, 10 Dec 2020 09:56:48 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id u24sm7433517pfm.81.2020.12.10.09.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 09:56:47 -0800 (PST)
From:   harshadshirwadkar@gmail.com
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 09/15] e2fsck: add fast commit scan pass
Date:   Thu, 10 Dec 2020 09:56:02 -0800
Message-Id: <20201210175608.3265541-10-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201210175608.3265541-1-harshadshirwadkar@gmail.com>
References: <20201210175608.3265541-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Add fast commit scan pass. Scan pass is responsible for following
things:

* Count total number of fast commit tags that need to be replayed
  during the replay phase.

* Validate whether the fast commit area is valid for a given
  transaction ID.

* Verify the CRC of fast commit area.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 e2fsck/journal.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index 2c8e3441..f1aa0fd6 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -278,6 +278,108 @@ static int process_journal_block(ext2_filsys fs,
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
+			ret = ext2fs_decode_extent(&ext2fs_ex, (void *)&ext->fc_ex,
+						   sizeof(ext->fc_ex));
+			if (ret)
+				ret = JBD2_FC_REPLAY_STOP;
+			else
+				ret = JBD2_FC_REPLAY_CONTINUE;
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
@@ -286,6 +388,13 @@ static int process_journal_block(ext2_filsys fs,
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
2.29.2.576.ga3fc446d84-goog

