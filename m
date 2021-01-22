Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1D42FFC50
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jan 2021 06:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbhAVFqG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jan 2021 00:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbhAVFqF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jan 2021 00:46:05 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF473C061788
        for <linux-ext4@vger.kernel.org>; Thu, 21 Jan 2021 21:45:23 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 11so2996918pfu.4
        for <linux-ext4@vger.kernel.org>; Thu, 21 Jan 2021 21:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y8FEya9F82d3BwvY3u7CtPk69VhCAk4vc3wNgvlyZPw=;
        b=R4UjS0MVg3AtZ7UlCYkm+hjEr/TMFUTfeHg8qUEP0cRIpc/7XrsBa8THC70LHdnpC0
         StDPbXqTfeZSGsZwQLaCRx7QN/9XcaLk2rbcItpHKPV88X/BqJnNkvq+nB/RisS2hCw4
         DMynMLwK5T/LC5zzL7ZMtUn6crKZs15XakZ7szveCY0VYoBKpA6aT8v7AnxYx80kfnwb
         TtuQIzsvz1SKznHAVA2OYrUx3J6M5Zm1pGfYa9klwP5XwnHp50us7hqnChMiNH27X0Vn
         o7Ev3484eOYgSrs+aT7+n4pMJgs3CJU/XVahkzsn87x7s3ME6p22boyynIvlysitoxyY
         O19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y8FEya9F82d3BwvY3u7CtPk69VhCAk4vc3wNgvlyZPw=;
        b=pdo9a/yiXKue2ZfzdDrjgx6tobRy2DdPXVaPaQak+bxHkzpnARhqglxXwRZ0xHqpH/
         S3pKnj9MhplhXWF+/rYf4PlbOzcwovmaGUfoIvVLcQpcSmZBvfy0zJlEj5mw7cbsiXlb
         xPHm9JHn73wiC6BHbcVMlWN/ZmGr86t9ShJzP6UO+UDcVh7Y4vUcvhyCmOpppomfMt6S
         Mra53P2c7T4/pA4a9pGzrqhFdUNUUFz3q9fIcCP/HyupUE5Dyz84zyic2E0/tj+uOfiK
         nJrgM5jbrwPy5zwj8Cqhz+b1KmNhp6P9Hhk3Jf/SrCmjjhJolXugXl7/5sZ976vrRLCz
         oKNg==
X-Gm-Message-State: AOAM531eBax7+V3LHuinHO/VxR37gqSc3gaIqrUkbXWTCSzunJF31zkO
        HihR5/u3hAoSUvnJHni7Ngqr04u2os8=
X-Google-Smtp-Source: ABdhPJxYOvf30jnXfeuWO39u5ede4NyhXTyPgn1ZQEoPt7HrJuZc6gff77qv6azZV6L66edH9ARNwg==
X-Received: by 2002:a62:9248:0:b029:1ae:8b24:34c8 with SMTP id o69-20020a6292480000b02901ae8b2434c8mr3090889pfd.67.1611294322966;
        Thu, 21 Jan 2021 21:45:22 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id gg6sm12245827pjb.2.2021.01.21.21.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 21:45:22 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <--global>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v4 4/8] e2fsck: add fast commit scan pass
Date:   Thu, 21 Jan 2021 21:45:00 -0800
Message-Id: <20210122054504.1498532-5-user@harshads-520.kir.corp.google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210122054504.1498532-1-user@harshads-520.kir.corp.google.com>
References: <20210122054504.1498532-1-user@harshads-520.kir.corp.google.com>
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
2.30.0.280.ga3ce27912f-goog

