Return-Path: <linux-ext4+bounces-3587-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B24E9440CB
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Aug 2024 04:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083BB1F25262
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Aug 2024 02:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2255B1B995C;
	Thu,  1 Aug 2024 01:41:02 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C881A76CD;
	Thu,  1 Aug 2024 01:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722476461; cv=none; b=fzm4SPsd4I5SLmwrbd10nIMg30V0w77JpbS0ibQUxoXicMgVqo/QN6JLHW7MjHisk/XJGtSZkfyDwKD+ULtTRDtmdfMTTOEZWrPCymronBYfkmceQ5vJ6x+7uGcjGKhJSyGzRtqajYTMx4LSkJbverB1Kuq3U9la+Kwcs3KI0nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722476461; c=relaxed/simple;
	bh=hujcKdi4UOZjWLNzjrHHHXL34zyK8iq4RSrnUJBOrWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fjqkBC6QVgLo/gIDTJElhOVtY/QNJhlsjAcg4AP32wEdEcAEM7gh2d1Vv6Zju5N22LgQjX2jLESJ/FZCoqq9+K5jUHbBJXeT71GSVU5unD0MIt4itkF4Ewvl44lEhLWlmAZEfU6olHohCg/87WUA4PjELbyLPWjSsGAaKFBE/dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WZBW34y90z4f3jYm;
	Thu,  1 Aug 2024 09:40:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 628F01A0568;
	Thu,  1 Aug 2024 09:40:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP2 (Coremail) with SMTP id Syh0CgBnnr2l56pmr3OyAQ--.24249S8;
	Thu, 01 Aug 2024 09:40:56 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/8] jbd2: move escape handle to futher improve jbd2_journal_write_metadata_buffer
Date: Thu,  1 Aug 2024 09:38:13 +0800
Message-Id: <20240801013815.2393869-7-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240801013815.2393869-1-shikemeng@huaweicloud.com>
References: <20240801013815.2393869-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBnnr2l56pmr3OyAQ--.24249S8
X-Coremail-Antispam: 1UD129KBjvJXoWxuF1UJr1rtrWfur1DtF1DZFb_yoW5ZFW5pr
	93Kr4ftFyvqr9Fyrn7Xw4DZry5KrWkWr1UKFW7Gas3tFW5u3srKF4jvw18Ka4jyrykKa18
	XFyjqFW8WwnxKFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Move escape handle to futher improve code readability and remove some
repeat check.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
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


