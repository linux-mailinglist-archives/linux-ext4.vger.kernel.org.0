Return-Path: <linux-ext4+bounces-3588-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 277E39440CC
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Aug 2024 04:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8761F255DD
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Aug 2024 02:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC441B9B2C;
	Thu,  1 Aug 2024 01:41:02 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5071DA58;
	Thu,  1 Aug 2024 01:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722476462; cv=none; b=pncoHAIiw0G1qreCDnoM1OxWLcXjq/wjUxpuPPaLZDangN9vNMYhV8SUYsXnOTozpIdjnwe+1t1VGU8Q4IpleEBgct/es/Q3yaS+UV55adRReJsxxxITbnBScoNGrRqNrqaIiK5ipCuW5davnwhVhWMf+TeVZq6JhKHKrPN0Yjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722476462; c=relaxed/simple;
	bh=5I/Sh/Gj4gK1RlwP8a1JR08fvBvDeanWUWCWoSUVCVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LB5ro9H0R6VKeG6ONYXUEsQsGCkWtL9uzSUuw8GdbWK5ntZ62IjmwIG1ldKua2QgE7OJH2VPQr8rxaoJn/lkGvP8kmbJLuKcupyMNp/rnlrDQqhzsRqBtxhg2lNtIHyS0PBkVxGhojhmyH69/Nnz0wRnFzmp7+QVZIX8Xg7T3qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WZBVz6ypbz4f3jsB;
	Thu,  1 Aug 2024 09:40:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E79F11A1533;
	Thu,  1 Aug 2024 09:40:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP2 (Coremail) with SMTP id Syh0CgBnnr2l56pmr3OyAQ--.24249S10;
	Thu, 01 Aug 2024 09:40:56 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 8/8] jbd2: remove unneeded check of ret in jbd2_fc_get_buf
Date: Thu,  1 Aug 2024 09:38:15 +0800
Message-Id: <20240801013815.2393869-9-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgBnnr2l56pmr3OyAQ--.24249S10
X-Coremail-Antispam: 1UD129KBjvJXoWruF45GF43WFyxCFW7trW5ZFb_yoW8JF48pr
	W3Kas8AFy8ZrW7WF1xXrZ5Jayjv392kFyUGFZ8CwnYkw42yrn7J3Z8Jw18Wa98ArWrK3W8
	Zr17Za95Cw4YyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Simply return -EINVAL if j_fc_off is invalid to avoid repeated check of
ret.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
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


