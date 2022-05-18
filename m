Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F091452B9BF
	for <lists+linux-ext4@lfdr.de>; Wed, 18 May 2022 14:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbiERMCD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 May 2022 08:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbiERMCC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 May 2022 08:02:02 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16B604B1C9;
        Wed, 18 May 2022 05:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=BJuVW
        m4vNOLr/lddgYmzMm8zeWY7p7QGhdRjZbrZA5A=; b=K8CXAVaXCBGnEnlODIvsc
        yIHEiQ6JWnJzR3ymetShmLGwMNwGAIC05CNk057q0fNE0i5lGkgi6lAZm78ac36Q
        cuBJqsqDIwhUjtAPaFx8nZin+zhzU5A4JLrVUnhCF32qmpTY+Pj9Vcxon3EN3s/g
        ntZ2tGZUtdpJ6arSHwL46M=
Received: from loongson-PC.loongson.cn (unknown [114.242.206.180])
        by smtp4 (Coremail) with SMTP id HNxpCgAXfdEh4IRiqpxdDA--.16275S2;
        Wed, 18 May 2022 20:01:43 +0800 (CST)
From:   Liu Peibao <liupeibao@163.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        liupeibao@163.com
Subject: [PATCH 1/2] ext4: page-io: use 'unsigned int' to bare use of 'unsigned'
Date:   Wed, 18 May 2022 20:01:36 +0800
Message-Id: <20220518120137.2544-1-liupeibao@163.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgAXfdEh4IRiqpxdDA--.16275S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw15CF17XFW3uF48WrW8tFb_yoW8GFyfpr
        yrKa4ftrW3Jr109anrWFs7ZFn5tr4qy34xAFW7J34UtF9xXFnYqa47KryFvF1UCFZ3CF9F
        vFWSkF17Jw43t37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziHq2iUUUUU=
X-Originating-IP: [114.242.206.180]
X-CM-SenderInfo: xolx1vpled0qqrwthudrp/xtbCbgcFbGBbDx3MqwAAsO
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fix warnings by checkpatch.

Signed-off-by: Liu Peibao <liupeibao@163.com>
---
 fs/ext4/page-io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 14695e2b5042..fd55e11c8391 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -106,9 +106,9 @@ static void ext4_finish_bio(struct bio *bio)
 		struct page *page = bvec->bv_page;
 		struct page *bounce_page = NULL;
 		struct buffer_head *bh, *head;
-		unsigned bio_start = bvec->bv_offset;
-		unsigned bio_end = bio_start + bvec->bv_len;
-		unsigned under_io = 0;
+		unsigned int bio_start = bvec->bv_offset;
+		unsigned int bio_end = bio_start + bvec->bv_len;
+		unsigned int under_io = 0;
 		unsigned long flags;
 
 		if (fscrypt_is_bounce_page(page)) {
@@ -329,7 +329,7 @@ static void ext4_end_bio(struct bio *bio)
 	if (WARN_ONCE(!io_end, "io_end is NULL: %pg: sector %Lu len %u err %d\n",
 		      bio->bi_bdev,
 		      (long long) bio->bi_iter.bi_sector,
-		      (unsigned) bio_sectors(bio),
+		      (unsigned int) bio_sectors(bio),
 		      bio->bi_status)) {
 		ext4_finish_bio(bio);
 		bio_put(bio);
@@ -435,7 +435,7 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 {
 	struct page *bounce_page = NULL;
 	struct inode *inode = page->mapping->host;
-	unsigned block_start;
+	unsigned int block_start;
 	struct buffer_head *bh, *head;
 	int ret = 0;
 	int nr_submitted = 0;
-- 
2.20.1

