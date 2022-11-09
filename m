Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950D4622F23
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Nov 2022 16:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiKIPjB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Nov 2022 10:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiKIPi7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Nov 2022 10:38:59 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EB2101FB
        for <linux-ext4@vger.kernel.org>; Wed,  9 Nov 2022 07:38:59 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so2204917pjk.2
        for <linux-ext4@vger.kernel.org>; Wed, 09 Nov 2022 07:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIaXH5TCVUoIVuKpAOENwTeFcBEwQmo86NDZlVj3CDQ=;
        b=EiFP8hOU6IkzfboF2APzBx2rcQbyeIyJ+kk6YiKqjTJBLaMg2kGfpFpPwogJoaL1Jy
         r8Y2+aKtlbDsqmRfxoSSoB7JgRa/QHpA3Yob+fTbRgoDWhnvdqeWIhZsWFQF4uXyKM/W
         d2i2v3oH8vEyDht1mWqz2E9h7qdAyt7StYiEJ40V1IwRHZ66EUFl0cDdk4w7kmZCn000
         7gFDhK0q5y9rLHQ8DmYsNR/6d0gundn9XPkBnmjfDzJASQ1ZbiYYADrXp2RLaSxSKJQo
         iljb9QVEp9uVQE+t7/DPSWL32x6HpaFP5K0HCVaMH9b67CqEBo7vgyeL9XnI8qNmYnO+
         LLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SIaXH5TCVUoIVuKpAOENwTeFcBEwQmo86NDZlVj3CDQ=;
        b=uMuuD7FplPwVRLiqFnI7K6qghlvwMWb5x/CS78pmMJTMFkNcUuPTaytdV2C4YZI3AV
         SsdNU+owpkA8XpTARD04M39W6uK27ZPgupPU5bAdOHD87RgpAdZqCaOfju+761zrnSQU
         2zDa674y+r+CEqH5Ldf4L/hwKnBfIku37AHVKueiRKvYWjhz0Q2yBB0UMolErHfqeCgC
         P82N4wmiUVRsn6nkpfQxXggVrIbwBIeox28PQjbn3uqz0PTNZxII7bs4mxeSon73KZih
         tvZyN440BBG2a9rVZdw6gjBpf0wxgFt3vtDAPxUZXAuqt5TQvgf5S0SfL/weKPUkz5K3
         IxhQ==
X-Gm-Message-State: ACrzQf16PgLp97dW3GQNhm8UHrJTQD/cU81TNZQWPoidwqgXhEfXnKm/
        KU9eBflJca9expuBuS+qcqKmnJm/gIWfRw==
X-Google-Smtp-Source: AMsMyM6B4JcJy64RY/Cb74VFcS9CQ6hzDEbDIbk/PUFcnfX3diWpJBuCLgionSLGWLJotXg1r3pLCQ==
X-Received: by 2002:a17:90a:8c7:b0:214:e1:cad0 with SMTP id 7-20020a17090a08c700b0021400e1cad0mr48612956pjn.3.1668008338346;
        Wed, 09 Nov 2022 07:38:58 -0800 (PST)
Received: from localhost ([101.224.161.1])
        by smtp.gmail.com with ESMTPSA id y2-20020a626402000000b005632f6490aasm8439574pfb.77.2022.11.09.07.38.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Nov 2022 07:38:57 -0800 (PST)
From:   JunChao Sun <sunjunchao2870@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        JunChao Sun <sunjunchao2870@gmail.com>
Subject: [PATCH] ext4: replace kmem_cache_create with KMEM_CACHE
Date:   Wed,  9 Nov 2022 07:38:22 -0800
Message-Id: <20221109153822.80250-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Replace kmem_cache_create with KMEM_CACHE macro that
guaranteed struct alignment

Signed-off-by: JunChao Sun <sunjunchao2870@gmail.com>
---
 fs/ext4/extents_status.c | 8 ++------
 fs/ext4/readpage.c       | 5 ++---
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index cd0a861853e3..97eccc0028a1 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -155,9 +155,7 @@ static void __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 
 int __init ext4_init_es(void)
 {
-	ext4_es_cachep = kmem_cache_create("ext4_extent_status",
-					   sizeof(struct extent_status),
-					   0, (SLAB_RECLAIM_ACCOUNT), NULL);
+	ext4_es_cachep = KMEM_CACHE(extent_status, SLAB_RECLAIM_ACCOUNT);
 	if (ext4_es_cachep == NULL)
 		return -ENOMEM;
 	return 0;
@@ -1807,9 +1805,7 @@ static void ext4_print_pending_tree(struct inode *inode)
 
 int __init ext4_init_pending(void)
 {
-	ext4_pending_cachep = kmem_cache_create("ext4_pending_reservation",
-					   sizeof(struct pending_reservation),
-					   0, (SLAB_RECLAIM_ACCOUNT), NULL);
+	ext4_pending_cachep = KMEM_CACHE(pending_reservation, SLAB_RECLAIM_ACCOUNT);
 	if (ext4_pending_cachep == NULL)
 		return -ENOMEM;
 	return 0;
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index 3d21eae267fc..773176e7f9f5 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -410,9 +410,8 @@ int ext4_mpage_readpages(struct inode *inode,
 
 int __init ext4_init_post_read_processing(void)
 {
-	bio_post_read_ctx_cache =
-		kmem_cache_create("ext4_bio_post_read_ctx",
-				  sizeof(struct bio_post_read_ctx), 0, 0, NULL);
+	bio_post_read_ctx_cache = KMEM_CACHE(bio_post_read_ctx, SLAB_RECLAIM_ACCOUNT);
+
 	if (!bio_post_read_ctx_cache)
 		goto fail;
 	bio_post_read_ctx_pool =
-- 
2.17.1

