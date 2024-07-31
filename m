Return-Path: <linux-ext4+bounces-3566-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 715B1942A92
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 11:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E978E1F22131
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 09:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4049624;
	Wed, 31 Jul 2024 09:31:55 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE541A8C12;
	Wed, 31 Jul 2024 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722418315; cv=none; b=Z86L5OH9CFmEjpe5K26KcthbqIJiU/CEAAUWYlENaI6oEYGaC7tDYI5AKrQa6SLPSavKTopr6NaPCUI+by2NBZA3nXF8/MtOHMWopdB5s26zxx/yR75ih4nWpuVP2j8h7qcFhp+gXPfBfhO1apNlqCReDhDETofMM/cHnL8F9v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722418315; c=relaxed/simple;
	bh=YsR3kJn0r/Nk16+L8NbyXZx4aiBckH9T6bmSA1Uo2pE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NyG+hZQFNZHS7oceTIBEW7c4cyJE/EPCjVhpKHNnZjY2Vc6aKCxUs++4HCSVUg5xpAn4Ljv6XMw371ggDATszn+E6fGatOl68XU8Fi6IkOmPflAeID4bQSrGbSo+D4M4XGXHkhz2yieV4PXxKSR1vXZ33v3S9DtkMeZUIRRNgT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WYn0l5vWsz4f3lWF;
	Wed, 31 Jul 2024 17:31:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id BF2391A13E9;
	Wed, 31 Jul 2024 17:31:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP2 (Coremail) with SMTP id Syh0CgC3oL+CBKpm5KxyAQ--.8660S8;
	Wed, 31 Jul 2024 17:31:49 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/8] ext4: move escape handle to futher improve jbd2_journal_write_metadata_buffer
Date: Wed, 31 Jul 2024 17:29:08 +0800
Message-Id: <20240731092910.2383048-7-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240731092910.2383048-1-shikemeng@huaweicloud.com>
References: <20240731092910.2383048-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgC3oL+CBKpm5KxyAQ--.8660S8
X-Coremail-Antispam: 1UD129KBjvJXoWxuF1UGF18Wr4UZr43Xw4kCrg_yoW5Cw4kpr
	93Kr4ftFyvqr9Fyrn7Xw4DZry5KrWkWr1UKFy7Gas3tFW5u3srKF4jvw18Ka4jyrykKa18
	XFyjqFW8WwsxKFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Move escape handle to futher improve code readability and remove some
repeat check.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
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


