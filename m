Return-Path: <linux-ext4+bounces-6222-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC98AA19F6D
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2025 08:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 767DC188E77E
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2025 07:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246F220CCD3;
	Thu, 23 Jan 2025 07:53:13 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D311820B7F0;
	Thu, 23 Jan 2025 07:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737618792; cv=none; b=HwufFM5hzEcsgmij5U036UcleyTQ8omowaiYL7kw0KbAH9C+8Io4AZv5zXx865fzGkrlvGupkTm2mfDLCKErq2Z4eKLt/C/DBJrlrzQN36XczVu/RpiMHe9aSPUl7L3aEqTszDeA4qkxq05UEvafyCLcL7OJKJ15TpuUF299Egc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737618792; c=relaxed/simple;
	bh=jEfUzUTuz945vlcfLss62pN7icJSk8ncE5kGXCGUzXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uqNbx2lJJuIv+qlFKOuajTyQyFlj/bxebzkgl4LV9JHQ3G86fdUjGGGXio/dEjOW0RjxLSkLPjJfJsV4DVGimhpb4uv8FDY2E48ufxxNidct5gusuDatmlkiumL5ESoG8sUeEbQlOO3jX3rbF1OpPtKEETTgQNzDqPPOnUSVHD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YdtTS0zcnz4f3lVg;
	Thu, 23 Jan 2025 15:52:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 113DC1A018C;
	Thu, 23 Jan 2025 15:53:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgCnR8Jf9ZFnizDkBg--.43540S4;
	Thu, 23 Jan 2025 15:53:05 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com,
	yi.zhang@huaweicloud.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] jbd2: remove unused return value of jbd2_journal_cancel_revoke
Date: Thu, 23 Jan 2025 23:50:10 +0800
Message-Id: <20250123155014.2097920-3-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgCnR8Jf9ZFnizDkBg--.43540S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AF18WF47KFyrWw17ZF15CFg_yoW8tr17pF
	98G34rurWvkFyjvF1DWa15JFW2qr97C342gFWq93s7Kw42gr93tr4UGr1jqF1YqFZFga15
	Zr4UGwsYkw1UKFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmj14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_Jryl82xGYIkIc2x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2
	F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjx
	v20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E
	87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
	kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYx
	C7MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7sR_6RRtUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Remove unused return value of jbd2_journal_cancel_revoke.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
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


