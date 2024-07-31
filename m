Return-Path: <linux-ext4+bounces-3554-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D0094269C
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 08:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065111C23D68
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 06:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F9B16D9B1;
	Wed, 31 Jul 2024 06:25:33 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAA383CA1;
	Wed, 31 Jul 2024 06:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722407133; cv=none; b=h52pnyolBn7GEgGe/AyifwjFkseeRDGFWilLmbftVAwsfNftzZhQnRRdGGdbYcXNcjGqcVnRPihZxT/TzPX+C//wtMG9Jm/seitA6h710T7Of6C5lRWX4OqkDAUo15xIQWtMVg4Wwrn3qzQSwro3ybPRkavp8z/XCbKUiKKg5R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722407133; c=relaxed/simple;
	bh=/SY875lF/WxaEhkkK9bjvkqo1hDe3vsZWN51cif7RFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CMuOfMISYMgNvM2AWPDvAQRi3ykOR4GR9C97UDHZVH6QiNfuu2yMnqrTg14LKeTwsTmcnlyLrveOnEvJH56U5c/EPAYc2cQZgQP4e8rhtjGnh9dtA1pJGzia0UXxy3kspFZno7pwlqCePegSxvrhOc7PVlAl4hW1WhQsxb1AEXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WYhsh4lYmz4f3kv0;
	Wed, 31 Jul 2024 14:25:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 96BE41A018D;
	Wed, 31 Jul 2024 14:25:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgA3jE7T2KlmaFNcAQ--.8748S7;
	Wed, 31 Jul 2024 14:25:26 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] jbd2: remove unneeded done_copy_out variable in jbd2_journal_write_metadata_buffer
Date: Wed, 31 Jul 2024 14:22:44 +0800
Message-Id: <20240731062247.2380440-6-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgA3jE7T2KlmaFNcAQ--.8748S7
X-Coremail-Antispam: 1UD129KBjvJXoW7ur13Jr43Zr1kXw47tw47Jwb_yoW5JFy8pF
	WSkrZrtryvqry2yr4kXw4DZryUKrWDWryjkFsrCa4ayay3u3sF9F1jyw10k34jyrZ7J3W8
	XryUZFWxWwnIyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvKb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x07jeVbkUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

It's more intuitive to use jh_in->b_frozen_data directly instead of
done_copy_out variable. Simply remove unneeded done_copy_out variable
and use b_frozen_data instead.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/jbd2/journal.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 9c1ffb0dc740..f17d05bc61df 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -318,7 +318,6 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 				  struct buffer_head **bh_out,
 				  sector_t blocknr)
 {
-	int done_copy_out = 0;
 	int do_escape = 0;
 	char *mapped_data;
 	struct buffer_head *new_bh;
@@ -349,7 +348,6 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 	 * we use that version of the data for the commit.
 	 */
 	if (jh_in->b_frozen_data) {
-		done_copy_out = 1;
 		new_folio = virt_to_folio(jh_in->b_frozen_data);
 		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
 		mapped_data = jh_in->b_frozen_data;
@@ -357,17 +355,15 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 		new_folio = bh_in->b_folio;
 		new_offset = offset_in_folio(new_folio, bh_in->b_data);
 		mapped_data = kmap_local_folio(new_folio, new_offset);
-	}
-
-	/*
-	 * Fire data frozen trigger if data already wasn't frozen.  Do this
-	 * before checking for escaping, as the trigger may modify the magic
-	 * offset.  If a copy-out happens afterwards, it will have the correct
-	 * data in the buffer.
-	 */
-	if (!done_copy_out)
+		/*
+		 * Fire data frozen trigger if data already wasn't frozen. Do
+		 * this before checking for escaping, as the trigger may modify
+		 * the magic offset.  If a copy-out happens afterwards, it will
+		 * have the correct data in the buffer.
+		 */
 		jbd2_buffer_frozen_trigger(jh_in, mapped_data,
 					   jh_in->b_triggers);
+	}
 
 	/*
 	 * Check for escaping
@@ -380,7 +376,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 	/*
 	 * Do we need to do a data copy?
 	 */
-	if (do_escape && !done_copy_out) {
+	if (do_escape && !jh_in->b_frozen_data) {
 		char *tmp;
 
 		spin_unlock(&jh_in->b_state_lock);
@@ -408,7 +404,6 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 copy_done:
 		new_folio = virt_to_folio(jh_in->b_frozen_data);
 		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
-		done_copy_out = 1;
 	}
 
 	/*
-- 
2.30.0


