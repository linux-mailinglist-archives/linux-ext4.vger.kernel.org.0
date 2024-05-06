Return-Path: <linux-ext4+bounces-2322-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE0A8BCFF0
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 16:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2ADC1F22AD5
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 14:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B2B13D897;
	Mon,  6 May 2024 14:18:31 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D9D13D2AF;
	Mon,  6 May 2024 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005110; cv=none; b=irOuzwVkLgeIQm8BrdD2pCNX+6fxp8GjfKDJc+HY/jiY8YLCw1HVYX6xlHQ5iA9Wo+3vIyC4LwlrMwGRltW3g/S2xEKdKa2s+ibrMPUgltxwo52JaDo8Z8NNh0tn7zO534ViZgKB+PARRFR6TwMk6B1TA4bD49wbYQM+8BWgqUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005110; c=relaxed/simple;
	bh=QrspUrPk06krE5j4K4ZtIjkNYx6SkjKwoJSbQNtTDOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JLQy1NXkI5klnf5vuFNp/WisX+5gTFrZfmPzHYvBFlMIAtMgkjQXiuPHXnWjY7qXKrXF0aKr6jXoej8THEd/lmeinPxCAT81w2dQRxnFa3rnyN+5L5lOkN+nh9eRw3ohDAXIcSfUvICrxSuiIsY2J3f8gPrhGSV8+HInmzltlxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VY3RH6B5Cz4f3lXC;
	Mon,  6 May 2024 22:18:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 232281A0572;
	Mon,  6 May 2024 22:18:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgAH2RGu5jhmGgSzLw--.22965S6;
	Mon, 06 May 2024 22:18:25 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] jbd2: move repeat tag around to remove a repeat check of b_frozen_data
Date: Mon,  6 May 2024 22:17:56 +0800
Message-Id: <20240506141801.1165315-5-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAH2RGu5jhmGgSzLw--.22965S6
X-Coremail-Antispam: 1UD129KBjvdXoW7XF1kAr17tFy3ury5Aw1UZFb_yoWfZrX_Xr
	WkArs7Xws8X3ZrJw4Fka1avrn3K395ur1ku3WxJF9rCF1YqFn5XrnIqrWvqr9rWa1FqrW3
	ZrnYgF4FyasxXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s
	0DM28IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26F4UJVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7IU8SfO7UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

We make sure b_frozen_data is not NULL before jump to "repeat" tag, move
"repeat" tag around to remove repeat check of b_frozen_data.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/jbd2/journal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 9a35d0c5b38c..77fcdc76fdfd 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -353,12 +353,12 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 	atomic_set(&new_bh->b_count, 1);
 
 	spin_lock(&jh_in->b_state_lock);
-repeat:
 	/*
 	 * If a new transaction has already done a buffer copy-out, then
 	 * we use that version of the data for the commit.
 	 */
 	if (jh_in->b_frozen_data) {
+repeat:
 		done_copy_out = 1;
 		new_folio = virt_to_folio(jh_in->b_frozen_data);
 		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
-- 
2.30.0


