Return-Path: <linux-ext4+bounces-3565-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A33942A91
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 11:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8D881C219B0
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 09:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A541AD3E1;
	Wed, 31 Jul 2024 09:31:55 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DFA1AAE05;
	Wed, 31 Jul 2024 09:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722418315; cv=none; b=d4xP8boBzlK7/kE20sAynrTBwdocIuorKxin3stGsfGLIIWNfIl/zfLcTKQFRZ8Wdt78fIL2CD7uv23+7eSbBidtQv0JUSEiNMayNVgzZuuvTlUYfzZ5vyWNP+9jNCN3b47NHCUUd3Vy4uyD5e9gzfV9DPtFgXdizk9wTBvbUt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722418315; c=relaxed/simple;
	bh=kw6SGK+E2GWOuV47kjsbqDx331VwA9aPNO9ngoMgLZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rR9qBA5yNwIHmnDHch2YWi/eARZqr9EataOZCxDG1hR1gkODRFae6bVQbqAa9eMjw26B9hQxy3r73e2dTApMBQVc9zDBS+x0Ekpc4bMQzrWHw1XvaBjTLTVJlWLo/OTal16HsU9/C5m4UhZGeSEnQNzlEFuJcWY4+05aobu4DBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WYn0n3KV4z4f3jsH;
	Wed, 31 Jul 2024 17:31:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 60FFC1A18C2;
	Wed, 31 Jul 2024 17:31:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP2 (Coremail) with SMTP id Syh0CgC3oL+CBKpm5KxyAQ--.8660S10;
	Wed, 31 Jul 2024 17:31:50 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/8] jbd2: remove unneeded check of ret in jbd2_fc_get_buf
Date: Wed, 31 Jul 2024 17:29:10 +0800
Message-Id: <20240731092910.2383048-9-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgC3oL+CBKpm5KxyAQ--.8660S10
X-Coremail-Antispam: 1UD129KBjvJXoWruF4rtF17Cr15Kw47Gr47CFg_yoW8Jr48pr
	W5Kr98AFy8ZrW7XF1xXrZ5Jayjv3yvkFy5GFZ8CwnYkw47trn7J3Z8Jw18Wa98ArWrK3W8
	Zr17Za95Ca1YyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Simply return -EINVAL if j_fc_off is invalid to avoid repeated check of
ret.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/journal.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index e89d777ded34..c5179aa38111 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -837,17 +837,12 @@ int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out)
 
 	*bh_out = NULL;
 
-	if (journal->j_fc_off + journal->j_fc_first < journal->j_fc_last) {
-		fc_off = journal->j_fc_off;
-		blocknr = journal->j_fc_first + fc_off;
-		journal->j_fc_off++;
-	} else {
-		ret = -EINVAL;
-	}
-
-	if (ret)
-		return ret;
+	if (journal->j_fc_off + journal->j_fc_first >= journal->j_fc_last)
+		return -EINVAL;
 
+	fc_off = journal->j_fc_off;
+	blocknr = journal->j_fc_first + fc_off;
+	journal->j_fc_off++;
 	ret = jbd2_journal_bmap(journal, blocknr, &pblock);
 	if (ret)
 		return ret;
@@ -856,7 +851,6 @@ int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out)
 	if (!bh)
 		return -ENOMEM;
 
-
 	journal->j_fc_wbuf[fc_off] = bh;
 
 	*bh_out = bh;
-- 
2.30.0


