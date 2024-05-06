Return-Path: <linux-ext4+bounces-2327-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3806C8BCFF7
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 16:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 603E1B27754
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 14:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D5313E036;
	Mon,  6 May 2024 14:18:32 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5537B13CFAD;
	Mon,  6 May 2024 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005112; cv=none; b=VKArqGe++OAbXH8ZmC7Umr/0hOY43idfKUq/dmE7cICzUvZOARiMK78Tyc5iZn+APm+UQEk2K6sQelt9sBM5TmYTIgEQssRkyOyITBw5mi396QC65KrkFoOpKi3iD6nfWRgzP3jFwcUvHmTW2hdawfZDeFiOkqR2ntQ7u9viuTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005112; c=relaxed/simple;
	bh=Zm86qt6RdF+YDOSKq5gre7uYNIr5q4CDZPa9kGDuJIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G1X106iIrK501kR8bEB17ktDlskLRMPoHkRojYh49zftV6PKG2dhSNd3Huq23PQ0wun2mSNMoVqnHja47Xr9l0BzMTD26qpWex3xTcsGsYX/jq7VHyERWAsFDGFMi/M3z30iuv5jCWtYNNr7Vy6/XWfz2jxbW4VeWyKcAxQdOaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VY3RD1Ljhz4f3n6g;
	Mon,  6 May 2024 22:18:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id EA30B1A0568;
	Mon,  6 May 2024 22:18:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgAH2RGu5jhmGgSzLw--.22965S9;
	Mon, 06 May 2024 22:18:25 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] jbd2: remove dead equality check of j_commit_[sequence/request] in kjournald2
Date: Mon,  6 May 2024 22:17:59 +0800
Message-Id: <20240506141801.1165315-8-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAH2RGu5jhmGgSzLw--.22965S9
X-Coremail-Antispam: 1UD129KBjvdXoWrur4DKw4kZr17Cr4UCw1kAFb_yoWkKwb_Wr
	WSyrnF9rWftr15Ja1kCw15ur1aqrn7Zrn5J3Z7ta1UKr1jyan2kFWkJay5Wwnru3yFqr45
	A39akw48trnavjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s
	0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26F4UJVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

In kjournald2, two equality checks of j_commit_[sequence/request] are
under the same j_state_lock. As j_commit_[sequence/request] are updated
concurrently with j_state_lock held during runtime, the second check is
unnecessary.
The j_commit_sequence is only updated concurrently in
jbd2_journal_commit_transaction with j_state_lock held.
The j_commit_request is only updated concurrently in
__jbd2_log_start_commit with j_state_lock held.
Also see comment in struct journal_s about lock rule of j_commit_sequence
and j_commit_request.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/jbd2/journal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 01e33b643e4d..e8f592fbd6e1 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -224,8 +224,6 @@ static int kjournald2(void *arg)
 
 		prepare_to_wait(&journal->j_wait_commit, &wait,
 				TASK_INTERRUPTIBLE);
-		if (journal->j_commit_sequence != journal->j_commit_request)
-			should_sleep = 0;
 		transaction = journal->j_running_transaction;
 		if (transaction && time_after_eq(jiffies,
 						transaction->t_expires))
-- 
2.30.0


