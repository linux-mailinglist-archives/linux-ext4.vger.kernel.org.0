Return-Path: <linux-ext4+bounces-3518-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 104F294109B
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 13:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 418471C22A7C
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 11:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DFF19EEC5;
	Tue, 30 Jul 2024 11:36:18 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5214118FC82;
	Tue, 30 Jul 2024 11:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339378; cv=none; b=bil/kmjTGOfgNvIp6R8pKU6KU8E23YM5HKfxrieo7nU6ej+I0YfWSq4FmAYB8BbLLL7adgFRPNup8GoietsKYk1+eNCEeb6UpOt9vPwS8PaDD1PRdybxUkUbtdSTb8UaJfzEU5qTjH/ySOKbt+vNiSp99Icvok7IIKg7dxGUFcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339378; c=relaxed/simple;
	bh=K4bcvploTiB4OXavITZyJIzrJK6bKOatjJn8dE+Ihfk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MQES7D807Mcck3H19kQM0pRc8UHE3k1zgbJGd9NroLQfPHSq8gV5opEGDIZBu7IiRjf3cMNM3FdzshtBbrhga6PqG8dfk6/Fss30CuiHwfoQJ/OeucHASI6YBgxB54gJ0cEM5NXr1gawHZ7Z6ObfjLBgBKIMiNzixYDTDl5y5Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WYCpk1wP9z4f3lfZ;
	Tue, 30 Jul 2024 19:35:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2CAEB1A12D1;
	Tue, 30 Jul 2024 19:36:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgCH2kwq0Khmm+QUAQ--.5153S3;
	Tue, 30 Jul 2024 19:36:12 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] jbd2: correctly compare tids with tid_geq function in jbd2_fc_begin_commit
Date: Tue, 30 Jul 2024 19:33:29 +0800
Message-Id: <20240730113335.2365290-2-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgCH2kwq0Khmm+QUAQ--.5153S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XFWUJF1fAFW3AF43JF1rCrg_yoWxCFb_XF
	18Ar47u39IgFn8A3y8C3yY9rnaqws7urn5Gw1xtw42kr4UKF1rtFnrtas0krn8W3yvqrW3
	W3yI9w40qF9xJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r18M2
	8IrcIa0xkI8VCY1x0267AKxVWUXVWUCwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl
	6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x
	IIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_
	Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0x
	ZFpf9x07UAEfrUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Use tid_geq to compare tids to work over sequence number wraps.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/jbd2/journal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 1ebf2393bfb7..da5a56d700f1 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -710,7 +710,7 @@ int jbd2_fc_begin_commit(journal_t *journal, tid_t tid)
 		return -EINVAL;
 
 	write_lock(&journal->j_state_lock);
-	if (tid <= journal->j_commit_sequence) {
+	if (tid_geq(journal->j_commit_sequence, tid)) {
 		write_unlock(&journal->j_state_lock);
 		return -EALREADY;
 	}
-- 
2.30.0


