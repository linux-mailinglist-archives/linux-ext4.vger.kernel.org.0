Return-Path: <linux-ext4+bounces-5847-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4D39FBD47
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2024 13:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBCD2188068D
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2024 12:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A371C3050;
	Tue, 24 Dec 2024 12:29:17 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A4519D074;
	Tue, 24 Dec 2024 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735043357; cv=none; b=fXIqLLaNvyOhFmb25iInJGtJGRJss9lFwogrxX9Q8JMTL+pUcNNGONcuftO02XfOXEq9GIpdZ3PqPzOkq23LXz/voMz+/924n+WmnpRneLFkTdUtVqhpQ0dWx26qNuI4y3vhWIWMccLIHd7y30S2BuR/7NnONTqswBMbfNpXYnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735043357; c=relaxed/simple;
	bh=atB4dRZMSOHVr7DLzVptGOngY5Ny58C1nKvtaWArVHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n+L2slgiXK+r5T5K56Qaveeqp7fTPi9/8i3dB9iftAsx1b5R3AwRKGo6BboXNDT5i6u+4Iro0MJGsfbQ+T5vSAlgX1l+PzUvaQtCwM+X2SAlrS/z7z1O0kYW/+CoOwRwuoZAR+pplnvxJ4f960Iqtq4AJ6Q8EuSF9yBgUsk4XxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YHZ1w2x7tz4f3jcr;
	Tue, 24 Dec 2024 20:28:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 1BBFF1A018D;
	Tue, 24 Dec 2024 20:29:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgDXs8AWqWpnruNnFQ--.3177S4;
	Tue, 24 Dec 2024 20:29:12 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] jbd2: remove unused return value of jbd2_journal_cancel_revoke
Date: Wed, 25 Dec 2024 04:27:03 +0800
Message-Id: <20241224202707.1530558-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241224202707.1530558-1-shikemeng@huaweicloud.com>
References: <20241224202707.1530558-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDXs8AWqWpnruNnFQ--.3177S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4Uur4xGrykZFW5uF4fuFg_yoW8urW8pF
	98G34rurWvkFyjvF1DWa15JFW2qr97Ca42gFWq93s7Kw42gr93tr4UGr1jqFyYqFZFga15
	Zr4UGwsYkw18K3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j-BMNUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Remove unused return value of jbd2_journal_cancel_revoke.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/jbd2/revoke.c     | 5 +----
 include/linux/jbd2.h | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
index 4556e4689024..af0208ed3619 100644
--- a/fs/jbd2/revoke.c
+++ b/fs/jbd2/revoke.c
@@ -420,12 +420,11 @@ int jbd2_journal_revoke(handle_t *handle, unsigned long long blocknr,
  * do not trust the Revoked bit on buffers unless RevokeValid is also
  * set.
  */
-int jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
+void jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
 {
 	struct jbd2_revoke_record_s *record;
 	journal_t *journal = handle->h_transaction->t_journal;
 	int need_cancel;
-	int did_revoke = 0;	/* akpm: debug */
 	struct buffer_head *bh = jh2bh(jh);
 
 	jbd2_debug(4, "journal_head %p, cancelling revoke\n", jh);
@@ -450,7 +449,6 @@ int jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
 			list_del(&record->hash);
 			spin_unlock(&journal->j_revoke_lock);
 			kmem_cache_free(jbd2_revoke_record_cache, record);
-			did_revoke = 1;
 		}
 	}
 
@@ -473,7 +471,6 @@ int jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
 			__brelse(bh2);
 		}
 	}
-	return did_revoke;
 }
 
 /*
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index c7fdb2b1b9a6..e2d1426d3e06 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1635,7 +1635,7 @@ extern int __init jbd2_journal_init_revoke_table_cache(void);
 
 extern void	   jbd2_journal_destroy_revoke(journal_t *);
 extern int	   jbd2_journal_revoke (handle_t *, unsigned long long, struct buffer_head *);
-extern int	   jbd2_journal_cancel_revoke(handle_t *, struct journal_head *);
+extern void	   jbd2_journal_cancel_revoke(handle_t *, struct journal_head *);
 extern void	   jbd2_journal_write_revoke_records(transaction_t *transaction,
 						     struct list_head *log_bufs);
 
-- 
2.30.0


