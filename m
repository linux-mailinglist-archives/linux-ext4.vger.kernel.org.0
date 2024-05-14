Return-Path: <linux-ext4+bounces-2502-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3AE8C5281
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2024 13:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC6771C21707
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2024 11:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D545813DDA0;
	Tue, 14 May 2024 11:25:20 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD34C13D524;
	Tue, 14 May 2024 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715685920; cv=none; b=M0RdMwLBYYGtsHooLB1ycVjapsPfq2AV9EXPJxzf3u6rkJgSBnWKbxS2Fo935YMxZP6EWCj155zIR8qCXIbXVtWERa6Kr3AjWyMnMqkvDduR623RS+BTV7H0DkBVaHxKQ77ShE8+WP8GnBweczJsoEyJkbxcHpRXgKEYN4qQl9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715685920; c=relaxed/simple;
	bh=MOdQCa2xmwTzqBajmcQn1bVGzlKz6EvTWSqX4CYPmXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TXE31g8yx19R+s0f4+EBD+lgsNsY9aWHQjibn11zgqZD/GLhTBbLBcgHZZWJnjgxj/ghcHyUmEsX050JPKHfdX3nzWi2jgf6uWv/W0RchChCCESgybcZEqh8QX0PLXRDROXNy7wdzUp5dX076D4p+973SdY4gImVE4JNlWfO6xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VdvCk034jz4f3jdL;
	Tue, 14 May 2024 19:25:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 9B1BB1A01A7;
	Tue, 14 May 2024 19:25:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgCHSKAXSkNm4rTMMQ--.61831S6;
	Tue, 14 May 2024 19:25:14 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com,
	yi.zhang@huaweicloud.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/9] jbd2: jump to new copy_done tag when b_frozen_data is created concurrently
Date: Tue, 14 May 2024 19:24:33 +0800
Message-Id: <20240514112438.1269037-5-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240514112438.1269037-1-shikemeng@huaweicloud.com>
References: <20240514112438.1269037-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCHSKAXSkNm4rTMMQ--.61831S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr17XF18ZF47tw47GFWfXwb_yoW8Xw1Upr
	yfKF10g34vq342qr1kWa1DZrWjg3ykuFyUKFZxCrnxtFWak34kWr12v3409w15AFZ7G3yr
	XFWjqay8WwnIvFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9C14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU2NtxUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

If b_frozen_data is created concurrently, we can update new_folio and
new_offset with b_frozen_data and then move forward

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/jbd2/journal.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 714e2ef0115a..5fb5062cf7ae 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -351,7 +351,6 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 	atomic_set(&new_bh->b_count, 1);
 
 	spin_lock(&jh_in->b_state_lock);
-repeat:
 	/*
 	 * If a new transaction has already done a buffer copy-out, then
 	 * we use that version of the data for the commit.
@@ -399,22 +398,22 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 		spin_lock(&jh_in->b_state_lock);
 		if (jh_in->b_frozen_data) {
 			jbd2_free(tmp, bh_in->b_size);
-			goto repeat;
+			goto copy_done;
 		}
 
 		jh_in->b_frozen_data = tmp;
 		memcpy_from_folio(tmp, new_folio, new_offset, bh_in->b_size);
-
-		new_folio = virt_to_folio(tmp);
-		new_offset = offset_in_folio(new_folio, tmp);
-		done_copy_out = 1;
-
 		/*
 		 * This isn't strictly necessary, as we're using frozen
 		 * data for the escaping, but it keeps consistency with
 		 * b_frozen_data usage.
 		 */
 		jh_in->b_frozen_triggers = jh_in->b_triggers;
+
+copy_done:
+		new_folio = virt_to_folio(jh_in->b_frozen_data);
+		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
+		done_copy_out = 1;
 	}
 
 	/*
-- 
2.30.0


