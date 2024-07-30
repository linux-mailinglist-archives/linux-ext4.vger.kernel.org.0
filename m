Return-Path: <linux-ext4+bounces-3522-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 261A39410A5
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 13:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAF3628571A
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 11:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8751A0724;
	Tue, 30 Jul 2024 11:36:21 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F0F1A00E8;
	Tue, 30 Jul 2024 11:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339381; cv=none; b=qob+L0zFmAwksP0krAYH2je6mAyPqNw0i9oGMN37qJwLODScF5JrxDAw5ZaJniVTgQJUq9+y7zeqxWNpGQ49CEBSDnw6fQTCB1x8cZ4WyxZCkZ1WTXIYEXcGYED7wrbYGF8rwiGtRpwxHfuOUSwCQpC5KlPQrJBM3e2E8FhhMFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339381; c=relaxed/simple;
	bh=awNkFWM4dpEhLJQBdcyW/+EP6ZU4SxzM2blDy3GxHec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BN2OVJHa3zUsXTg9oVtEoi5ODFimgdcWzJWfQZP5vLzDOTSTH0IjtnedSA/RA+vhrKiD5LWrrGQYUdumGG17qJEJW7NRiDJMCR5ySmLttktl56OnhUA7vB2SqgBH9Vy/JGfBbakbMKKRtbGigPOD+lRvG1+ciXpCT6EhkXT9++k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WYCpl6LBCz4f3m6t;
	Tue, 30 Jul 2024 19:35:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C34B81A0568;
	Tue, 30 Jul 2024 19:36:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgCH2kwq0Khmm+QUAQ--.5153S9;
	Tue, 30 Jul 2024 19:36:13 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] jbd2: remove unneeded check of ret in jbd2_fc_get_buf
Date: Tue, 30 Jul 2024 19:33:35 +0800
Message-Id: <20240730113335.2365290-8-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240730113335.2365290-1-shikemeng@huaweicloud.com>
References: <20240730113335.2365290-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCH2kwq0Khmm+QUAQ--.5153S9
X-Coremail-Antispam: 1UD129KBjvdXoWruF4rZr1rWFyDGry8CFykXwb_yoWxKwb_Xr
	W8Z3srZrZxWr13ArWrC3y8urnIqws7ur1ku34xt392kF1UJ3W5Jw1DJrW5Jr9rWFWvqFy3
	Gw1q9rWFkF9rCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s
	0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Simply return -EINVAL if j_fc_off is invalid to avoid repeated check of
ret.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/jbd2/journal.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index dc18b9f7c999..6f90f7b8e9e5 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -842,12 +842,8 @@ int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out)
 		fc_off = journal->j_fc_off;
 		blocknr = journal->j_fc_first + fc_off;
 		journal->j_fc_off++;
-	} else {
-		ret = -EINVAL;
-	}
-
-	if (ret)
-		return ret;
+	} else
+		return -EINVAL;
 
 	ret = jbd2_journal_bmap(journal, blocknr, &pblock);
 	if (ret)
-- 
2.30.0


