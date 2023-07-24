Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05B475F25B
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jul 2023 12:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjGXKM4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Jul 2023 06:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjGXKMi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Jul 2023 06:12:38 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9417A87
        for <linux-ext4@vger.kernel.org>; Mon, 24 Jul 2023 03:05:01 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b9de4b0c1aso640380a34.1
        for <linux-ext4@vger.kernel.org>; Mon, 24 Jul 2023 03:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690193080; x=1690797880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GawUpWYlbps61zw2RmUByoW60pYFIoQHHGKJRm38EOk=;
        b=Q5busZKo2JsqBB6sp1Hl4bQr9gW7KkwVGMBFtUqswcnHnfloBZqlxC60ounM08/Wzt
         6fksm++5yvAjyfVU/LrVhUzjwdhecR2dPzSHuj8B2zcQG4CwVuemZVr3/nt9ZM/RXs6k
         ibkbNogkYxJpFfLRXD7xQ78aBrVT2ZH7DxAWHCBLq75RtOxR4fKNaQOzIcqpGBOr3eq5
         CCFywD/M9n3dgNgrdsxQtzGzFmH53Vv9k8qtU90OFqkxYtJq40io39iw8hv0HAJ/cICZ
         8UP4vvS5xy0eOmd8m7rJ3oSZpLGO1XZ64FtF+Iy6jW/YlqasTyf5mDDUs5fPHUEA/6W3
         gSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690193080; x=1690797880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GawUpWYlbps61zw2RmUByoW60pYFIoQHHGKJRm38EOk=;
        b=CyG5bygsVob0WkaV1CIzgjzxjoSAUnj2qIT1XywAObHjT63ug1UhRqBhCPj/Agqnlw
         Kx/0rJhHNWRxsuD9VlqbnmQWRMGgSr4AVqs8T9qPYotDxyreD8EkVq9aUqH8JfnDU4ag
         iZPf3j9XQ4u1ByvoR1ElncOJoehwLQB5Fv+LOoNWK8ea2ZP9FuNybtwWDgP7iIbfM25j
         eGcGOIPEgBWZqpMrckuvmULRKj20I8BxydkzU4//KCVOUMKGwq8sEz/4gIVV9PFHxs3Y
         q7c65OofwEVnyQxoHh7tAinkjDmhp5YoC7ZAVR0TXIUshg8lKnc0skXRlmHpm8+xdbi+
         5y2Q==
X-Gm-Message-State: ABy/qLYTnArFo8CDl3Kq+Ikvo+PovyQDXLTF9rUi8vX5SePdGPFngABA
        RULy8naKVtGwWY7V1pZWRD+bqkXuKV7CCT6CK/s=
X-Google-Smtp-Source: APBJJlEU/vgKmw8Um+e668RIawiv+P3qp/KwZZ/g6Y9wgpINkkaMr3bzWEnObMTDhnOi0EmMOvkuLQ==
X-Received: by 2002:a17:903:41cd:b0:1bb:9e6e:a9f3 with SMTP id u13-20020a17090341cd00b001bb9e6ea9f3mr4118075ple.4.1690192301770;
        Mon, 24 Jul 2023 02:51:41 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001bb20380bf2sm8467233pld.13.2023.07.24.02.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:51:41 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 33/47] jbd2,ext4: dynamically allocate the jbd2-journal shrinker
Date:   Mon, 24 Jul 2023 17:43:40 +0800
Message-Id: <20230724094354.90817-34-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the jbd2-journal shrinker, so that it can be freed
asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
read-side critical section when releasing the struct journal_s.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 fs/jbd2/journal.c    | 27 +++++++++++++++++----------
 include/linux/jbd2.h |  2 +-
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index fbce16fedaa4..a7d555ea06e3 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1301,7 +1301,7 @@ static int jbd2_min_tag_size(void)
 static unsigned long jbd2_journal_shrink_scan(struct shrinker *shrink,
 					      struct shrink_control *sc)
 {
-	journal_t *journal = container_of(shrink, journal_t, j_shrinker);
+	journal_t *journal = shrink->private_data;
 	unsigned long nr_to_scan = sc->nr_to_scan;
 	unsigned long nr_shrunk;
 	unsigned long count;
@@ -1327,7 +1327,7 @@ static unsigned long jbd2_journal_shrink_scan(struct shrinker *shrink,
 static unsigned long jbd2_journal_shrink_count(struct shrinker *shrink,
 					       struct shrink_control *sc)
 {
-	journal_t *journal = container_of(shrink, journal_t, j_shrinker);
+	journal_t *journal = shrink->private_data;
 	unsigned long count;
 
 	count = percpu_counter_read_positive(&journal->j_checkpoint_jh_count);
@@ -1415,19 +1415,26 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	journal->j_superblock = (journal_superblock_t *)bh->b_data;
 
 	journal->j_shrink_transaction = NULL;
-	journal->j_shrinker.scan_objects = jbd2_journal_shrink_scan;
-	journal->j_shrinker.count_objects = jbd2_journal_shrink_count;
-	journal->j_shrinker.seeks = DEFAULT_SEEKS;
-	journal->j_shrinker.batch = journal->j_max_transaction_buffers;
 
 	if (percpu_counter_init(&journal->j_checkpoint_jh_count, 0, GFP_KERNEL))
 		goto err_cleanup;
 
-	if (register_shrinker(&journal->j_shrinker, "jbd2-journal:(%u:%u)",
-			      MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev))) {
+	journal->j_shrinker = shrinker_alloc(0, "jbd2-journal:(%u:%u)",
+					     MAJOR(bdev->bd_dev),
+					     MINOR(bdev->bd_dev));
+	if (!journal->j_shrinker) {
 		percpu_counter_destroy(&journal->j_checkpoint_jh_count);
 		goto err_cleanup;
 	}
+
+	journal->j_shrinker->scan_objects = jbd2_journal_shrink_scan;
+	journal->j_shrinker->count_objects = jbd2_journal_shrink_count;
+	journal->j_shrinker->seeks = DEFAULT_SEEKS;
+	journal->j_shrinker->batch = journal->j_max_transaction_buffers;
+	journal->j_shrinker->private_data = journal;
+
+	shrinker_register(journal->j_shrinker);
+
 	return journal;
 
 err_cleanup:
@@ -2190,9 +2197,9 @@ int jbd2_journal_destroy(journal_t *journal)
 		brelse(journal->j_sb_buffer);
 	}
 
-	if (journal->j_shrinker.flags & SHRINKER_REGISTERED) {
+	if (journal->j_shrinker) {
 		percpu_counter_destroy(&journal->j_checkpoint_jh_count);
-		unregister_shrinker(&journal->j_shrinker);
+		shrinker_unregister(journal->j_shrinker);
 	}
 	if (journal->j_proc_entry)
 		jbd2_stats_proc_exit(journal);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index d860499e15e4..9fdc02565c24 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -897,7 +897,7 @@ struct journal_s
 	 * Journal head shrinker, reclaim buffer's journal head which
 	 * has been written back.
 	 */
-	struct shrinker		j_shrinker;
+	struct shrinker		*j_shrinker;
 
 	/**
 	 * @j_checkpoint_jh_count:
-- 
2.30.2

