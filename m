Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBAA2BB509
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Nov 2020 20:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732229AbgKTTQh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Nov 2020 14:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732220AbgKTTQg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Nov 2020 14:16:36 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8343FC061A04
        for <linux-ext4@vger.kernel.org>; Fri, 20 Nov 2020 11:16:36 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id c66so8802498pfa.4
        for <linux-ext4@vger.kernel.org>; Fri, 20 Nov 2020 11:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w6NifX4iyXWjBWv9C/Mie0NhiSo4YnyHhwT58ryktRw=;
        b=mG7lmfYF3r1Kw95GFmVthu51HD10i1wRo5UeVpKxdfInbo4nphujsSFLdr2VTkdZtw
         1k06H+CWjXs7XPymW9ZyBK9La7DQ2vwmhdUxCrnWjS30OsNNdagTVesxpVW+blBiG5uW
         uaRRacAUy60eiqCYY6yU4vdmReO++1CFTaviSMu3opKCsvp/pIBNSI4MDANaPSgW11aL
         UPV+l1yy4OKcFR7rp+9RVJ7gsMUr+YB81Y2K0eioOXkUXacblRtdYGXmOUBAtq/leN79
         3U6Wr8wiOVnA97yCM6NAujSojTj+h/ZjfUVQKh3CtmWE5c9Qnxp/rqUxHBhg5wAX2qkl
         +TnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w6NifX4iyXWjBWv9C/Mie0NhiSo4YnyHhwT58ryktRw=;
        b=HG3XuIA5Luo/QSizPF2rE+G8jQKwcCykHNY7txrc2XgPPmMDCG42Lx58jACNvnjlAB
         K020foZr3Xk9bc1rG1T3IQVPQllcjQR2dviEaGmNWlaeXmSAGk+W4/VTb4Otd6+FeVHK
         NSE6fhLR8RJXY28z26j/2lf0oqMKGdd4uzkz9pg2j50WD1I940wat77yJ2ZV5OUuAthE
         oxb1/devJpvgaODmFqApxcUPNj1mxes3OuubRXaYQyn6YbwOInqDRSyDsE6AzNo1z5sb
         4HSFK8oIZoTniwUGNkM92a5it5C17MloKII0SkS1iU5wgPIml3SAl7A66HQpWzhWTL1S
         wL8Q==
X-Gm-Message-State: AOAM532GJsPNnnoTG0TqYKpL0aVYDcxIquF6YN8it6vKTDrfsam0BjjD
        1fMz8oqL2S+W81bfEHbBj2Ka9m/u+hk=
X-Google-Smtp-Source: ABdhPJyi/cmfZzcxhK39U7zBg4bJx39V1lcSERRFtEDXg67Rm5PqQablGTS9JejrVB49bYvNa/t3cA==
X-Received: by 2002:a63:1541:: with SMTP id 1mr18403000pgv.429.1605899795559;
        Fri, 20 Nov 2020 11:16:35 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id o9sm4370480pjr.2.2020.11.20.11.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 11:16:34 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 10/15] e2fsck: add fast commit replay skeleton
Date:   Fri, 20 Nov 2020 11:16:01 -0800
Message-Id: <20201120191606.2224881-11-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201120191606.2224881-1-harshadshirwadkar@gmail.com>
References: <20201120191606.2224881-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This function adds the skeleton for the replay path. Following patches
in the series implement the handling for individual tags.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 e2fsck/journal.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index 1072dfe8..d44f777b 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -388,11 +388,83 @@ static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
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
2.29.2.454.gaff20da3a2-goog

