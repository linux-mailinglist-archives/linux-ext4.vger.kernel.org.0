Return-Path: <linux-ext4+bounces-3555-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF87594269F
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 08:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7A6286CD9
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 06:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FE916DC1C;
	Wed, 31 Jul 2024 06:25:34 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5118289C;
	Wed, 31 Jul 2024 06:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722407134; cv=none; b=IhUI6ZMVhUmxeEuu3sStR9HNRZq6vlGm8rdCmM7eEkkGVpZTYcIXABokOxl/97Fu3RW2iscU4EmmrNhth7ADS3jjAYLtBZX47jQtPT+sOvYgxoGiwf8jwnqlE7UOMw5Mrp62Qu2/nhnKJM8PYMfbCDWYjDqQmxOWL780b7caHCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722407134; c=relaxed/simple;
	bh=VY5Sb68aQNAfC82SoknebxDDu2vIjufBgVDCn/uHZT4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bx8YJ0tQzPb0OOWbEhi0fPsfJZPTHO1VWDCJvcrAqZWCVxKm4Mv7gNo7ZIgtFdExoqi/Pta6dEbggrBMV6RNWiCFzx8wXDNwNFD1QsnEXvpFvNs5vQYNuWtlS39YLZP+cxE8kf1uRae+kktmit2N8v4NS/pYFOUEejlpxh/dqBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WYhsh2ZVMz4f3kv8;
	Wed, 31 Jul 2024 14:25:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4E0311A1865;
	Wed, 31 Jul 2024 14:25:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgA3jE7T2KlmaFNcAQ--.8748S6;
	Wed, 31 Jul 2024 14:25:26 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] jbd2: remove unneeded kmap for jh_in->b_frozen_data in jbd2_journal_write_metadata_buffer
Date: Wed, 31 Jul 2024 14:22:43 +0800
Message-Id: <20240731062247.2380440-5-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgA3jE7T2KlmaFNcAQ--.8748S6
X-Coremail-Antispam: 1UD129KBjvJXoW7tr47Zr47Xw4UGry7tFy7Jrb_yoW8Gw13pr
	9a9rykKFyvqryqyr1kWan7ZrWjg3yDWFWUKFWDCa4ayFW3W3sFkr1jva1xK3WjyFZ7Jay8
	XryqvFWxWwnIyrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvKb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x07jeVbkUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Remove kmap for page of b_frozen_data from jbd2_alloc() which always
provides an address from the direct kernel mapping.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/journal.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 312c7575b54f..9c1ffb0dc740 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -352,12 +352,13 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 		done_copy_out = 1;
 		new_folio = virt_to_folio(jh_in->b_frozen_data);
 		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
+		mapped_data = jh_in->b_frozen_data;
 	} else {
 		new_folio = bh_in->b_folio;
 		new_offset = offset_in_folio(new_folio, bh_in->b_data);
+		mapped_data = kmap_local_folio(new_folio, new_offset);
 	}
 
-	mapped_data = kmap_local_folio(new_folio, new_offset);
 	/*
 	 * Fire data frozen trigger if data already wasn't frozen.  Do this
 	 * before checking for escaping, as the trigger may modify the magic
@@ -373,7 +374,8 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 	 */
 	if (*((__be32 *)mapped_data) == cpu_to_be32(JBD2_MAGIC_NUMBER))
 		do_escape = 1;
-	kunmap_local(mapped_data);
+	if (!jh_in->b_frozen_data)
+		kunmap_local(mapped_data);
 
 	/*
 	 * Do we need to do a data copy?
-- 
2.30.0


