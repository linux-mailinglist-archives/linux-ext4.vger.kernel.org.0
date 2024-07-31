Return-Path: <linux-ext4+bounces-3562-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0DE942A8A
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 11:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09E21B22EDA
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 09:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A261AAE22;
	Wed, 31 Jul 2024 09:31:54 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4D51A8C06;
	Wed, 31 Jul 2024 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722418314; cv=none; b=SWD2wzYSeglNQSlTMb3mzQRNFjufRycigtjzckTsQDBjDLXLslANB+KiCNU5hS4RZnk+x9t9dWNE4Oaf+SYYMQEKR1F+Pr7VoKaAiK76MRo2ZQgjTamhu8slcLhNrXpxMp989YRwQNT6rWIoEqxSIzctn/DuW8Yfgko10Nj5NI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722418314; c=relaxed/simple;
	bh=/SY875lF/WxaEhkkK9bjvkqo1hDe3vsZWN51cif7RFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KgmGPDK0u2wDOhOio9JreRtnYZjrRhwPlE/UdA5P5iSUc4/ar88IxQR1c2rar1V7hI5jo/iTPjO+Q1oEaE2XaYUaGS5QI2vMNNX/yNo4JTkW5gCuZE/exAM3D5Dgn0qAfer+oIX0kTDQH9AQf/3akvLVy1EIEQXV164M++i7rMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WYn0m4bH2z4f3jsD;
	Wed, 31 Jul 2024 17:31:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 866FA1A0568;
	Wed, 31 Jul 2024 17:31:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP2 (Coremail) with SMTP id Syh0CgC3oL+CBKpm5KxyAQ--.8660S7;
	Wed, 31 Jul 2024 17:31:49 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/8] jbd2: remove unneeded done_copy_out variable in jbd2_journal_write_metadata_buffer
Date: Wed, 31 Jul 2024 17:29:07 +0800
Message-Id: <20240731092910.2383048-6-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgC3oL+CBKpm5KxyAQ--.8660S7
X-Coremail-Antispam: 1UD129KBjvJXoW7ur13Jr43Zr1kXw47tw47Jwb_yoW5JFy8pF
	WSkrZrtryvqry2yr4kXw4DZryUKrWDWryjkFsrCa4ayay3u3sF9F1jyw10k34jyrZ7J3W8
	XryUZFWxWwnIyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjxU2CJmUUUUU
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


