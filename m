Return-Path: <linux-ext4+bounces-8708-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E5BAEDEBE
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 15:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF195188F4B6
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 13:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33AC28C034;
	Mon, 30 Jun 2025 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjjR2m6w"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E30B28B519;
	Mon, 30 Jun 2025 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751289208; cv=none; b=hyCRXcklHj7sIZlMjxuxKnFuyJIRlDlfcJwKZIsNKbNf9dvPPCmB9KGddhDrS5301l3rEdicCOxLz9Bdak8s2Hk7GTg1xM1fEApqLrg7HjJiEW93kRY8jHUzXVgI7OlQ1bO6Zo9UbRhG3UjUpXxhBjNg7Z/Cl08D11dAAV154Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751289208; c=relaxed/simple;
	bh=oJRu8E8wcaqBMHFOS5BZfM24plB5VjY1CkIOzjkM+fE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XzNEl1OBh5oMuL3FSYbFy9WvXth3zsikm/ylu6otEEugM+EKYVSN8CvjOksJJ8YmbtBsTEO51LTMTfIMwdKfTMVTFw/oxHxBJwiJHW1s6UYoAqukCNC6MJDb5cCWeX7DkmlIx+3kO/qKL+/cACleaLQ0IwZLEmzEhY/Iy9ceS2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjjR2m6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22CCC4CEEF;
	Mon, 30 Jun 2025 13:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751289207;
	bh=oJRu8E8wcaqBMHFOS5BZfM24plB5VjY1CkIOzjkM+fE=;
	h=From:To:Cc:Subject:Date:From;
	b=RjjR2m6wSBY0rZZrCZFhmKNWvsjzerQnlwdSGZaUStNrxj09Wvy+WRpD14QO+NyUY
	 tGJRL+wurZ5nUbE/ryQP55Wv900pWoHYeRq7zbORXDalvJ8DulTOveta74apaNE0P2
	 ky2LqK4BElPtrsKZjVcq1xfzNh8xkBaZEcPWRUZAwKaDYHM1TQUYQDvG1h5p1Z5HxP
	 0lJUvuvYMkQ7QfBm0GkuLPGBtLc1cfpbxMVfJ8cztNhnUjwG8GRM2nrZ2lmdfnNgc7
	 06/AEyu2RFk5BReaZeu2aObgrNXdbZwJKGI6+WymzxhSeqvyT6XOTthUiKG6fsIxPn
	 O8HHRm4a+Y6QQ==
From: Sasha Levin <sashal@kernel.org>
To: tytso@mit.edu
Cc: yi.zhang@huawei.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] ext4: fix JBD2 credit overflow with large folios
Date: Mon, 30 Jun 2025 09:13:24 -0400
Message-Id: <20250630131324.1253313-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When large folios are enabled, the blocks-per-folio calculation in
ext4_da_writepages_trans_blocks() can overflow the journal transaction
limits, causing the writeback path to fail with errors like:

  JBD2: kworker/u8:0 wants too many credits credits:416 rsv_credits:21 max:334

This occurs with small block sizes (1KB) and large folios (32MB), where
the calculation results in 32768 blocks per folio. The transaction credit
calculation then requests more credits than the journal can handle, leading
to the following warning and writeback failure:

  WARNING: CPU: 1 PID: 43 at fs/jbd2/transaction.c:334 start_this_handle+0x4c0/0x4e0
  EXT4-fs (loop0): ext4_do_writepages: jbd2_start: 9223372036854775807 pages, ino 14; err -28

Call trace leading to the issue:
  ext4_do_writepages()
    ext4_da_writepages_trans_blocks()
      bpp = ext4_journal_blocks_per_folio() // Returns 32768 for 32MB folio with 1KB blocks
      ext4_meta_trans_blocks(inode, MAX_WRITEPAGES_EXTENT_LEN + bpp - 1, bpp)
        // With bpp=32768, lblocks=34815, pextents=32768
        // Returns credits=415, but with overhead becomes 416 > max 334
    ext4_journal_start_with_reserve()
      jbd2_journal_start_reserved()
        start_this_handle()
          // Fails with warning when credits:416 > max:334

The issue was introduced by commit d6bf294773a47 ("ext4/jbd2: convert
jbd2_journal_blocks_per_page() to support large folio"), which added
support for large folios but didn't account for the journal credit limits.

Fix this by capping the blocks-per-folio value at 8192 in the writeback
path. This is the value we'd get with 32MB folios and 4KB blocks, or 8MB
folios with 1KB blocks, which is reasonable and safe for typical journal
configurations.

Fixes: d6bf294773a4 ("ext4/jbd2: convert jbd2_journal_blocks_per_page() to support large folio")
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/inode.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index be9a4cba35fd5..860e59a176c97 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2070,6 +2070,14 @@ static int mpage_submit_folio(struct mpage_da_data *mpd, struct folio *folio)
  */
 #define MAX_WRITEPAGES_EXTENT_LEN 2048
 
+/*
+ * Maximum blocks per folio to avoid JBD2 credit overflow.
+ * This is the value we'd get with 32MB folios and 4KB blocks,
+ * or 8MB folios with 1KB blocks, which is reasonable and safe
+ * for typical journal configurations.
+ */
+#define MAX_BLOCKS_PER_FOLIO_FOR_WRITEBACK 8192
+
 /*
  * mpage_add_bh_to_extent - try to add bh to extent of blocks to map
  *
@@ -2481,6 +2489,18 @@ static int ext4_da_writepages_trans_blocks(struct inode *inode)
 {
 	int bpp = ext4_journal_blocks_per_folio(inode);
 
+	/*
+	 * With large folios, blocks per folio can get excessively large,
+	 * especially with small block sizes. For example, with 32MB folios
+	 * (order 11) and 1KB blocks, we get 32768 blocks per folio. This
+	 * leads to credit requests that overflow the journal's transaction
+	 * limit.
+	 *
+	 * Limit the value to avoid excessive credit requests.
+	 */
+	if (bpp > MAX_BLOCKS_PER_FOLIO_FOR_WRITEBACK)
+		bpp = MAX_BLOCKS_PER_FOLIO_FOR_WRITEBACK;
+
 	return ext4_meta_trans_blocks(inode,
 				MAX_WRITEPAGES_EXTENT_LEN + bpp - 1, bpp);
 }
@@ -2559,6 +2579,13 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 	handle_t *handle = NULL;
 	int bpp = ext4_journal_blocks_per_folio(mpd->inode);
 
+	/*
+	 * With large folios, blocks per folio can get excessively large,
+	 * especially with small block sizes. Cap it to avoid credit overflow.
+	 */
+	if (bpp > MAX_BLOCKS_PER_FOLIO_FOR_WRITEBACK)
+		bpp = MAX_BLOCKS_PER_FOLIO_FOR_WRITEBACK;
+
 	if (mpd->wbc->sync_mode == WB_SYNC_ALL || mpd->wbc->tagged_writepages)
 		tag = PAGECACHE_TAG_TOWRITE;
 	else
@@ -6179,6 +6206,13 @@ int ext4_writepage_trans_blocks(struct inode *inode)
 	int bpp = ext4_journal_blocks_per_folio(inode);
 	int ret;
 
+	/*
+	 * With large folios, blocks per folio can get excessively large,
+	 * especially with small block sizes. Cap it to avoid credit overflow.
+	 */
+	if (bpp > MAX_BLOCKS_PER_FOLIO_FOR_WRITEBACK)
+		bpp = MAX_BLOCKS_PER_FOLIO_FOR_WRITEBACK;
+
 	ret = ext4_meta_trans_blocks(inode, bpp, bpp);
 
 	/* Account for data blocks for journalled mode */
-- 
2.39.5


