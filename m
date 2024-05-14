Return-Path: <linux-ext4+bounces-2505-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEEC8C5288
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2024 13:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1D9FB2278F
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2024 11:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68AC13E3E4;
	Tue, 14 May 2024 11:25:21 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A933513D51C;
	Tue, 14 May 2024 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715685921; cv=none; b=RBWeZT5xDfk3iGR+4J29WH9H8Fsi9j7ycg9KNibfGf/I35xPJILPPz9tpHCFLL8ZReHNfSkmczRb+xQp2fSIHQwFZjJyj2GI71Co8ynRD4gcMRZGRWlEryrl2rbh3+sVQLvMxlI+d59KQ0rRHqBJeGW/BIEpkO84NoQVxWXQN8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715685921; c=relaxed/simple;
	bh=FfSePsSXjLJytBres+xSbLhMmjiek/V0yA78ash8meA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fsweK9a5kxQ0eURav2F9MeLr6hZjWle4sbNhuMExGprypjA9bXKhdRElO64EFSD+GU5NnrZkpCKDEPdfzUBWh29sIepyWKE0X8SPOvhTq+YAq2ajqahkmgR5EQ/DX1eC4nXlNoS9qyxdfJugsBE9BOxFaivEKcniV8KmYDnPgNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VdvCj5PZBz4f3jdX;
	Tue, 14 May 2024 19:25:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 594CE1A0572;
	Tue, 14 May 2024 19:25:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgCHSKAXSkNm4rTMMQ--.61831S5;
	Tue, 14 May 2024 19:25:14 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com,
	yi.zhang@huaweicloud.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/9] jbd2: remove unnedded "need_copy_out" in jbd2_journal_write_metadata_buffer
Date: Tue, 14 May 2024 19:24:32 +0800
Message-Id: <20240514112438.1269037-4-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgCHSKAXSkNm4rTMMQ--.61831S5
X-Coremail-Antispam: 1UD129KBjvJXoWrZFWxuF4fXr47Gw4UJryrZwb_yoW8JrWUpF
	97Ka18XF9YqryjvF1kWanrJrWj9FZ7WF1UKFZrCasxGFW3WrnruF1jvF1Fgw4jqF9rK3y8
	AryqkFykGr4Yv3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUc18PUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

As we only need to copy out when we should do escape, need_copy_out
could be simply replaced by "do_escape".

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/journal.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 2dca2f613a8e..714e2ef0115a 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -325,7 +325,6 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 				  struct buffer_head **bh_out,
 				  sector_t blocknr)
 {
-	int need_copy_out = 0;
 	int done_copy_out = 0;
 	int do_escape = 0;
 	char *mapped_data;
@@ -380,16 +379,14 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 	/*
 	 * Check for escaping
 	 */
-	if (*((__be32 *)mapped_data) == cpu_to_be32(JBD2_MAGIC_NUMBER)) {
-		need_copy_out = 1;
+	if (*((__be32 *)mapped_data) == cpu_to_be32(JBD2_MAGIC_NUMBER))
 		do_escape = 1;
-	}
 	kunmap_local(mapped_data);
 
 	/*
 	 * Do we need to do a data copy?
 	 */
-	if (need_copy_out && !done_copy_out) {
+	if (do_escape && !done_copy_out) {
 		char *tmp;
 
 		spin_unlock(&jh_in->b_state_lock);
-- 
2.30.0


