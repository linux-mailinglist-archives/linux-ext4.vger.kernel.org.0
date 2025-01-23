Return-Path: <linux-ext4+bounces-6221-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E57CEA19F6A
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2025 08:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFADF7A56EC
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2025 07:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA20B20C496;
	Thu, 23 Jan 2025 07:53:12 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6E720101E;
	Thu, 23 Jan 2025 07:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737618792; cv=none; b=peVlmS54svKcmZAOfmSUBliAHtpRXfvu7lROR05cDXDD48j3V+1pbNEC7jwVLrvCIOXH57lKmu/5BGYUL0+I7z9aBdyg+kwmdMmfv980Af4VZ0HyJcRSvxEuk9ke51AvXGvzjCDwAdVjfo5vDnWhPSMdiJYY1bkmq8n2Yo5VZDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737618792; c=relaxed/simple;
	bh=Z1ZnOHNc7bIf0P1S0Yx1+jCVp2pGNMAg/nWoy+83C1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eRa9GXKQ2ANRpoRVm3NYBYImrqQS6MkADzZDyr44o4wV6PUyiz2lrcYKdXAspk0MOg+wUc6SWcEGFTzUdLMJKAG/WblWXjLXmEapfSNjq2dVVvrnZyqqApPJ9cub13KHr0+flyG0XCxgZ925Zv0+FEGQ1BRm2RxOCIYhDqFSZTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YdtTT6q17z4f3jY4;
	Thu, 23 Jan 2025 15:52:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 9822A1A0F9D;
	Thu, 23 Jan 2025 15:53:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgCnR8Jf9ZFnizDkBg--.43540S6;
	Thu, 23 Jan 2025 15:53:06 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com,
	yi.zhang@huaweicloud.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] jbd2: remove stale comment of update_t_max_wait
Date: Thu, 23 Jan 2025 23:50:12 +0800
Message-Id: <20250123155014.2097920-5-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250123155014.2097920-1-shikemeng@huaweicloud.com>
References: <20250123155014.2097920-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCnR8Jf9ZFnizDkBg--.43540S6
X-Coremail-Antispam: 1UD129KBjvdXoWrKFWfJF45Jr1DKF18Xw4kXrb_yoWDKwc_Xr
	4IkrsxXwnIgr17Zw4fGr13Wrn5ur1Uur1qq3Zaya1jkr1DtanrWrWvvrZ5u3sxua93Wr13
	ta18Z340grnIvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb9AYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
	xGYIkIc2x26280x7IE14v26r126s0DM28IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC
	64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM2
	8EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0D
	M28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4
	CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
	s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
	1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
	JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r
	1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
	YxBIdaVFxhVjvjDU0xZFpf9x0pixn5_UUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Commit 2d44292058828 ("jbd2: remove CONFIG_JBD2_DEBUG to update
t_max_wait") removed jbd2_journal_enable_debug, just remove stale comment
about jbd2_journal_enable_debug.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/transaction.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 66513c18ca29..cebf0859048f 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -114,12 +114,9 @@ static void jbd2_get_transaction(journal_t *journal,
  */
 
 /*
- * Update transaction's maximum wait time, if debugging is enabled.
- *
  * t_max_wait is carefully updated here with use of atomic compare exchange.
  * Note that there could be multiplre threads trying to do this simultaneously
  * hence using cmpxchg to avoid any use of locks in this case.
- * With this t_max_wait can be updated w/o enabling jbd2_journal_enable_debug.
  */
 static inline void update_t_max_wait(transaction_t *transaction,
 				     unsigned long ts)
-- 
2.30.0


