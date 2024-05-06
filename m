Return-Path: <linux-ext4+bounces-2318-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB898BCFE6
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 16:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 173C5B26EBD
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 14:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F77A13D52B;
	Mon,  6 May 2024 14:18:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D5613D2AE;
	Mon,  6 May 2024 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005110; cv=none; b=nfGMpBwsUng2aNsS2n9TZnOUwf/DFxt8+hFi1ZJpMsuEBtmydjeS3Dg6/4OH+kqQO57YG84CiHZEITqJrXFVZy06FMTOCe8iux2MAYwK9EWXG5MZ1u42cSR+mEXLARs5YPNotOkkk/L9/hucez05HISGdSbyuA9w7aK/rGMw0Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005110; c=relaxed/simple;
	bh=yo4UQv80bwbIuxJeT32Enec3aco3lrSNLp7+M9jeqls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=szRmJypAyiQapm+ZfKcVh0ljVntoKUWvjsEy4O15jc/2R6XZAMIcVEusMUr8x9YbtX79ZTUKWBaMADp2tLLRB/XS55AkE/toWraiKaHp2lvSCEVVLhCh1wVpYoO+HDCp7sLsyn6Y2ItjYig82rURX8oypGpjlzLP1PcBhNXGRVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VY3RH0NDJz4f3jkn;
	Mon,  6 May 2024 22:18:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4F96F1A08D3;
	Mon,  6 May 2024 22:18:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgAH2RGu5jhmGgSzLw--.22965S3;
	Mon, 06 May 2024 22:18:24 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] jbd2: avoid memleak in jbd2_journal_write_metadata_buffer
Date: Mon,  6 May 2024 22:17:53 +0800
Message-Id: <20240506141801.1165315-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240506141801.1165315-1-shikemeng@huaweicloud.com>
References: <20240506141801.1165315-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAH2RGu5jhmGgSzLw--.22965S3
X-Coremail-Antispam: 1UD129KBjvdXoWrXrWfAw43Gw4xtFWrGw4xCrg_yoWxWrg_WF
	WkZryxZ39xXFnrA3Wru3429rn8Kws5ur1kAw1fKw17Kr1Ut3y3JFnrJrnI9r9ruan2grW5
	uwn2k3y8tr9xJjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r18M2
	8IrcIa0xkI8VCY1x0267AKxVWUXVWUCwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F
	4UJVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
	oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7V
	C0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j
	6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU14CJJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

The new_bh is from alloc_buffer_head, we should call free_buffer_head to
free it in error case.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/jbd2/journal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index b6c114c11b97..207b24e12ce9 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -399,6 +399,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 		tmp = jbd2_alloc(bh_in->b_size, GFP_NOFS);
 		if (!tmp) {
 			brelse(new_bh);
+			free_buffer_head(new_bh);
 			return -ENOMEM;
 		}
 		spin_lock(&jh_in->b_state_lock);
-- 
2.30.0


