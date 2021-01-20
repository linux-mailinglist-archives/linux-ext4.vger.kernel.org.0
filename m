Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB0D2FDE08
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Jan 2021 01:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731915AbhAUAdC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Jan 2021 19:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733122AbhATVb6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Jan 2021 16:31:58 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD7AC0617B0
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jan 2021 13:26:57 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id c22so16048726pgg.13
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jan 2021 13:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3k+x5N3594IvVfqWc3JHgjye0SXsK1QHbI04+5erJM8=;
        b=mIUNgXKJp4PV2sErvzq95/mM/c8gkKJ2UQKlAkEQw0wj0rA3BXadvT4W4uZeX5Q8VU
         UAnVpgrA49Uw3DmFvCYmHUs7Zee33EigFGJvjHR3m7yltZGecz2rUXBVvVuUaHsBk+My
         rkCLMrAHSvVSkCaI9p1XLDKp2yqc67XUAakxyOEGFMUgKY7ptIMw2Bo93AJMQ8ufysor
         2iaorQW4bnNlGqbm1AuinWuS0gLp8hlKdmBfJhlKeQ5F2ffYh+6Kjs+9rFCNDOmGB3da
         k8wCZszgGaVUWgzg/JueWDY2C98RmrftDW6428FWUkxw2UFzThL80En1mz1j8KDutk88
         KBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3k+x5N3594IvVfqWc3JHgjye0SXsK1QHbI04+5erJM8=;
        b=WJKuFs1UGbuc2LNmMkyEenjK41clfOHqV9p4AvHTirWkd/0lkBhavJ4rgDBDfVoETj
         oPaoqlH130RCyeY/QPuniaOvhiznhfVCPwVfa4KQKDEgmE2Rtb4o3LGF1EixtSNo3pS/
         a/T1SCSaImq3FqQ6I1TZyjjD0JT+r6FzHpQmGlSF6QWVKSXJwzBNPELG4DRhDIsSAs4D
         cmxmoMK+k8Yl0V9guu1C7cmya5D2Ic+yNW4yEUozfTwaGtZbiZ7KV1qicePT5J6St/Mq
         1MuvIOT5LLErL9AxgTivx2fLnulKoAImT2anx8rceeS35MTjKvTDpLlk1TGL6JTqUbeV
         Gv+Q==
X-Gm-Message-State: AOAM532rJZnpQaV/UDGdiOGm4c0i02kjMYMoOreqGYZmdocTTz9yHMQA
        Gmmjy+UfKUPuctn3VWvHs7M7ON73l5c=
X-Google-Smtp-Source: ABdhPJwY4NXDyQYx0UUk34OkZq79qhwV+2aYeOVya2iLRDOFEb7tBy46GRpCHs+Uf0bZb2gywrRydg==
X-Received: by 2002:a62:4e47:0:b029:1b6:6197:7b53 with SMTP id c68-20020a624e470000b02901b661977b53mr11117879pfb.65.1611178016819;
        Wed, 20 Jan 2021 13:26:56 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id w1sm3396758pjt.23.2021.01.20.13.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 13:26:55 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <--global>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v3 09/15] e2fsck: add fast commit scan pass
Date:   Wed, 20 Jan 2021 13:26:35 -0800
Message-Id: <20210120212641.526556-10-user@harshads-520.kir.corp.google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210120212641.526556-1-user@harshads-520.kir.corp.google.com>
References: <20210120212641.526556-1-user@harshads-520.kir.corp.google.com>
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
index 56e48385..ba38124e 100644
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
2.30.0.284.gd98b1dd5eaa7-goog

