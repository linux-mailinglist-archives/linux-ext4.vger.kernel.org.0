Return-Path: <linux-ext4+bounces-12226-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01214CAC814
	for <lists+linux-ext4@lfdr.de>; Mon, 08 Dec 2025 09:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3041E3048420
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Dec 2025 08:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E822D7D2F;
	Mon,  8 Dec 2025 08:32:51 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650542D0C60;
	Mon,  8 Dec 2025 08:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765182771; cv=none; b=GsllTLU+2YTh2yjWXJbW7eWqVBG0lNbKRrGaKY8XHcuEXIDTaBjm7eVdBKN2/Lm++d8JE5PZeYntesSTtxeWyOmG+gzwGXvNGJe7Dj0xtIglOgZqEff7fwt7xTQwY3UqjQ5LPYOmvMsHDgP8Mj3P5hj6iwoP1Nn/a9AgmhrZ86I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765182771; c=relaxed/simple;
	bh=NVXY/7yw3fhThO8b14OnLKgQtJK4BM0MuhUnD4nGMkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owlQDc1UYAtkU0nwaGxqCyNqPI7JloYnR48FnLh6W+uV9+HejBTZTPeNglBb8OaLGM4uIrFgLnwW77lSkAOrVBZh+SphAG0Szq/CVMZwuUwVhdmbYlYqCCj/1u4yzHvD7vc/4Jbb5FYrhxnF/kHHoRjU7HIlwhBTEc2KTeUiD9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B702C116B1;
	Mon,  8 Dec 2025 08:32:49 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	yukuai@fnnas.com
Subject: [PATCH 1/2] ext4: refactor size prediction into helper functions
Date: Mon,  8 Dec 2025 16:32:45 +0800
Message-ID: <20251208083246.320965-2-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251208083246.320965-1-yukuai@fnnas.com>
References: <20251208083246.320965-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ext4_mb_normalize_request() function contains a large if-else
ladder for predicting file size and uses a macro NRL_CHECK_SIZE.
Factor these out into proper helper functions to improve code
readability and maintainability.

This patch introduces:
- ext4_mb_check_size(): static inline function replacing NRL_CHECK_SIZE macro
- ext4_mb_predict_file_size(): extracts size prediction logic

No functional change.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 fs/ext4/mballoc.c | 101 +++++++++++++++++++++++++++-------------------
 1 file changed, 60 insertions(+), 41 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 9087183602e4..eb46a4f5fb4f 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4489,6 +4489,63 @@ ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
 	*end = new_end;
 }
 
+/*
+ * Check if request size allows for chunk-based allocation
+ */
+static inline bool ext4_mb_check_size(loff_t req, loff_t size,
+				      int max, int chunk_size)
+{
+	return (req <= size) || (max <= chunk_size);
+}
+
+/*
+ * Predict file size for preallocation. Returns the predicted size
+ * in bytes and sets start_off if alignment is needed for large files.
+ */
+static loff_t ext4_mb_predict_file_size(struct ext4_sb_info *sbi,
+					struct ext4_allocation_context *ac,
+					loff_t size, loff_t *start_off)
+{
+	int bsbits = ac->ac_sb->s_blocksize_bits;
+	int max = 2 << bsbits;
+
+	*start_off = 0;
+
+	if (size <= 16 * 1024) {
+		size = 16 * 1024;
+	} else if (size <= 32 * 1024) {
+		size = 32 * 1024;
+	} else if (size <= 64 * 1024) {
+		size = 64 * 1024;
+	} else if (size <= 128 * 1024) {
+		size = 128 * 1024;
+	} else if (size <= 256 * 1024) {
+		size = 256 * 1024;
+	} else if (size <= 512 * 1024) {
+		size = 512 * 1024;
+	} else if (size <= 1024 * 1024) {
+		size = 1024 * 1024;
+	} else if (ext4_mb_check_size(size, 4 * 1024 * 1024, max, 2 * 1024)) {
+		*start_off = ((loff_t)ac->ac_o_ex.fe_logical >>
+						(21 - bsbits)) << 21;
+		size = 2 * 1024 * 1024;
+	} else if (ext4_mb_check_size(size, 8 * 1024 * 1024, max, 4 * 1024)) {
+		*start_off = ((loff_t)ac->ac_o_ex.fe_logical >>
+							(22 - bsbits)) << 22;
+		size = 4 * 1024 * 1024;
+	} else if (ext4_mb_check_size(EXT4_C2B(sbi, ac->ac_o_ex.fe_len),
+					(8<<20)>>bsbits, max, 8 * 1024)) {
+		*start_off = ((loff_t)ac->ac_o_ex.fe_logical >>
+							(23 - bsbits)) << 23;
+		size = 8 * 1024 * 1024;
+	} else {
+		*start_off = (loff_t)ac->ac_o_ex.fe_logical << bsbits;
+		size = (loff_t)EXT4_C2B(sbi, ac->ac_o_ex.fe_len) << bsbits;
+	}
+
+	return size;
+}
+
 /*
  * Normalization means making request better in terms of
  * size and alignment
@@ -4500,7 +4557,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	struct ext4_super_block *es = sbi->s_es;
 	int bsbits, max;
-	loff_t size, start_off, end;
+	loff_t size, start_off = 0, end;
 	loff_t orig_size __maybe_unused;
 	ext4_lblk_t start;
 
@@ -4533,47 +4590,9 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 		size = i_size_read(ac->ac_inode);
 	orig_size = size;
 
-	/* max size of free chunks */
-	max = 2 << bsbits;
+	/* Predict file size for preallocation */
+	size = ext4_mb_predict_file_size(sbi, ac, size, &start_off);
 
-#define NRL_CHECK_SIZE(req, size, max, chunk_size)	\
-		(req <= (size) || max <= (chunk_size))
-
-	/* first, try to predict filesize */
-	/* XXX: should this table be tunable? */
-	start_off = 0;
-	if (size <= 16 * 1024) {
-		size = 16 * 1024;
-	} else if (size <= 32 * 1024) {
-		size = 32 * 1024;
-	} else if (size <= 64 * 1024) {
-		size = 64 * 1024;
-	} else if (size <= 128 * 1024) {
-		size = 128 * 1024;
-	} else if (size <= 256 * 1024) {
-		size = 256 * 1024;
-	} else if (size <= 512 * 1024) {
-		size = 512 * 1024;
-	} else if (size <= 1024 * 1024) {
-		size = 1024 * 1024;
-	} else if (NRL_CHECK_SIZE(size, 4 * 1024 * 1024, max, 2 * 1024)) {
-		start_off = ((loff_t)ac->ac_o_ex.fe_logical >>
-						(21 - bsbits)) << 21;
-		size = 2 * 1024 * 1024;
-	} else if (NRL_CHECK_SIZE(size, 8 * 1024 * 1024, max, 4 * 1024)) {
-		start_off = ((loff_t)ac->ac_o_ex.fe_logical >>
-							(22 - bsbits)) << 22;
-		size = 4 * 1024 * 1024;
-	} else if (NRL_CHECK_SIZE(EXT4_C2B(sbi, ac->ac_o_ex.fe_len),
-					(8<<20)>>bsbits, max, 8 * 1024)) {
-		start_off = ((loff_t)ac->ac_o_ex.fe_logical >>
-							(23 - bsbits)) << 23;
-		size = 8 * 1024 * 1024;
-	} else {
-		start_off = (loff_t) ac->ac_o_ex.fe_logical << bsbits;
-		size	  = (loff_t) EXT4_C2B(sbi,
-					      ac->ac_o_ex.fe_len) << bsbits;
-	}
 	size = size >> bsbits;
 	start = start_off >> bsbits;
 
-- 
2.51.0


