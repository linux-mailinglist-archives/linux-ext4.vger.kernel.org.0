Return-Path: <linux-ext4+bounces-2325-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F968BCFF4
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 16:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0C1A1C22824
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 14:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF4713DBBD;
	Mon,  6 May 2024 14:18:31 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB8F13D2AC;
	Mon,  6 May 2024 14:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005111; cv=none; b=SaOo9ho5bVFN4Ywd9+dIIGl82dP/CbwdygiK6CIGPY8042QKNuxGh0Nkl3f6qdAT9YHMhdnbHGbTMm8bT0UhcDmvr1duwYt//JsTjzuYE4ggPeEQOUFjjVGIgGE2GsVAe8Dgn8wB2dez1cET5Yt431i17AOjQE9YvugXgaAoL84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005111; c=relaxed/simple;
	bh=77qTtS6Jogk44/Y3eC+likpnpEUBBYFYti4g42k7vQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fvfe8OZ4nlcmtHWl/vBFalLcyHPxunyfB3992NPagEh8SC+hi5dtZFl6EPhVjvKsNNFh+EWkLhQfCj1TI+OIagEuUrtrv0WOpXvlaeHTN6U4jKU4ZlQW7nFKuNgVBCv2ow9qGd2JGTaPIBychWjqVLYfa8tfqv7Uw5sJqk6iyt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VY3RD361Tz4f3kFZ;
	Mon,  6 May 2024 22:18:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9D4A31A016E;
	Mon,  6 May 2024 22:18:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgAH2RGu5jhmGgSzLw--.22965S4;
	Mon, 06 May 2024 22:18:24 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] jbd2: remove unused return info from jbd2_journal_write_metadata_buffer
Date: Mon,  6 May 2024 22:17:54 +0800
Message-Id: <20240506141801.1165315-3-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAH2RGu5jhmGgSzLw--.22965S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw18AF4UtrykurWkWF1Utrb_yoWfZrb_Xr
	Z7ur43Z3sxXr47J3yY934Uur93KFs3ur1kAwn7Kayj9Fy5t3WrGrsrJrn5JryDZa92yrsr
	tw109w48KasxKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r15M2
	8IrcIa0xkI8VCY1x0267AKxVWUCVW8JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F
	4UJVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
	oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7V
	C0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j
	6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU1ZmRUUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

The done_copy_out info from jbd2_journal_write_metadata_buffer is not
used. Simply remove it.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/jbd2/journal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 207b24e12ce9..068031f35aea 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -320,7 +320,6 @@ static void journal_kill_thread(journal_t *journal)
  *
  * On success:
  * Bit 0 set == escape performed on the data
- * Bit 1 set == buffer copy-out performed (kfree the data after IO)
  */
 
 int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
@@ -455,7 +454,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 	set_buffer_shadow(bh_in);
 	spin_unlock(&jh_in->b_state_lock);
 
-	return do_escape | (done_copy_out << 1);
+	return do_escape;
 }
 
 /*
-- 
2.30.0


