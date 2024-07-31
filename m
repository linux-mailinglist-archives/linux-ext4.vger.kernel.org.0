Return-Path: <linux-ext4+bounces-3551-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6529942697
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 08:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D84B283A8B
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 06:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119B016D4CD;
	Wed, 31 Jul 2024 06:25:33 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AA059B71;
	Wed, 31 Jul 2024 06:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722407132; cv=none; b=k8XR/BbUvRGqNKo/Ys287dho4lkMkyCz0bDmLFN+437HbmEdDa9/Do5i+GRtDKicadGVe1a23e00mF83EoJIpZehbb7tsGN7nNu0C93LUwWVXsT9gTr5/507VC9PgfqhB7KiXwVRWFtmpD5AEDwDOFCMOu4hPJme1c1+Cx2hxZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722407132; c=relaxed/simple;
	bh=fGqjXpho8/V/ZOniZpc+yXMwF5tvsR0FdVit8Nojf6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RiAc4mzoYU+yOrnMdr+BOst62nTUjvXvNfD7AL6a9b+SQuK7pQxZN8f7YZWuo9ECenUqk5JqojtMR3oenLgGF0jTkdmUgbQRTtrQsj7t9KcRvhmOn+xCV7P6MfMkcCIk4wtFFuYuIz5YGEQUHWNGHDEyPhb5wUR9rQRraOWu2T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WYhsj6PQ9z4f3jrx;
	Wed, 31 Jul 2024 14:25:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C6A751A07B6;
	Wed, 31 Jul 2024 14:25:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgA3jE7T2KlmaFNcAQ--.8748S8;
	Wed, 31 Jul 2024 14:25:26 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] ext4: move escape handle to futher improve jbd2_journal_write_metadata_buffer
Date: Wed, 31 Jul 2024 14:22:45 +0800
Message-Id: <20240731062247.2380440-7-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240731062247.2380440-1-shikemeng@huaweicloud.com>
References: <20240731062247.2380440-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3jE7T2KlmaFNcAQ--.8748S8
X-Coremail-Antispam: 1UD129KBjvJXoWxuF1UGF18Wr4UZr43Xw4kCrg_yoW5ZrWrpr
	93Kr4ftFyvqr9Fyrn7Xw4DZry5KrWkWryUKFy7Gas3tFW5u3srKF4jvw18Ka4jyrykKa18
	XFyjqFW8WwnxK3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvKb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Move escape handle to futher improve code readability and remove some
repeat check.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Suggested-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/journal.c | 49 +++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index f17d05bc61df..85273fb1accb 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -281,6 +281,16 @@ static void journal_kill_thread(journal_t *journal)
 	write_unlock(&journal->j_state_lock);
 }
 
+static inline bool jbd2_data_needs_escaping(char *data)
+{
+	return *((__be32 *)data) == cpu_to_be32(JBD2_MAGIC_NUMBER);
+}
+
+static inline void jbd2_data_do_escape(char *data)
+{
+	*((unsigned int *)data) = 0;
+}
+
 /*
  * jbd2_journal_write_metadata_buffer: write a metadata buffer to the journal.
  *
@@ -319,7 +329,6 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 				  sector_t blocknr)
 {
 	int do_escape = 0;
-	char *mapped_data;
 	struct buffer_head *new_bh;
 	struct folio *new_folio;
 	unsigned int new_offset;
@@ -350,8 +359,13 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 	if (jh_in->b_frozen_data) {
 		new_folio = virt_to_folio(jh_in->b_frozen_data);
 		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
-		mapped_data = jh_in->b_frozen_data;
+		do_escape = jbd2_data_needs_escaping(jh_in->b_frozen_data);
+		if (do_escape)
+			jbd2_data_do_escape(jh_in->b_frozen_data);
 	} else {
+		char *tmp;
+		char *mapped_data;
+
 		new_folio = bh_in->b_folio;
 		new_offset = offset_in_folio(new_folio, bh_in->b_data);
 		mapped_data = kmap_local_folio(new_folio, new_offset);
@@ -363,21 +377,13 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 		 */
 		jbd2_buffer_frozen_trigger(jh_in, mapped_data,
 					   jh_in->b_triggers);
-	}
-
-	/*
-	 * Check for escaping
-	 */
-	if (*((__be32 *)mapped_data) == cpu_to_be32(JBD2_MAGIC_NUMBER))
-		do_escape = 1;
-	if (!jh_in->b_frozen_data)
+		do_escape = jbd2_data_needs_escaping(mapped_data);
 		kunmap_local(mapped_data);
-
-	/*
-	 * Do we need to do a data copy?
-	 */
-	if (do_escape && !jh_in->b_frozen_data) {
-		char *tmp;
+		/*
+		 * Do we need to do a data copy?
+		 */
+		if (!do_escape)
+			goto escape_done;
 
 		spin_unlock(&jh_in->b_state_lock);
 		tmp = jbd2_alloc(bh_in->b_size, GFP_NOFS);
@@ -404,17 +410,10 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 copy_done:
 		new_folio = virt_to_folio(jh_in->b_frozen_data);
 		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
+		jbd2_data_do_escape(jh_in->b_frozen_data);
 	}
 
-	/*
-	 * Did we need to do an escaping?  Now we've done all the
-	 * copying, we can finally do so.
-	 * b_frozen_data is from jbd2_alloc() which always provides an
-	 * address from the direct kernels mapping.
-	 */
-	if (do_escape)
-		*((unsigned int *)jh_in->b_frozen_data) = 0;
-
+escape_done:
 	folio_set_bh(new_bh, new_folio, new_offset);
 	new_bh->b_size = bh_in->b_size;
 	new_bh->b_bdev = journal->j_dev;
-- 
2.30.0


