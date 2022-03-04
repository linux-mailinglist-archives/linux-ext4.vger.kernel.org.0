Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E354CDB95
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Mar 2022 19:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241488AbiCDSCZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Mar 2022 13:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241458AbiCDSCO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Mar 2022 13:02:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498801C4B2A;
        Fri,  4 Mar 2022 10:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/DgQnFlNZ9XU3MUiWD3W/xSOCpM12Wnovh2/HHtJAns=; b=gFJUv/iqGPUrFqOo4zKYr7SM6n
        0HB+IUMBpdrhBvNbI24UPggkNktOF69JinOcS8v+LK33M36D7afdoQCU7H2YyfU7GDwl3fq3nKa7b
        4Yu+dZUy8FBkP6Ac4RE50C4a2dsHnn9Y3bGhugN40FAe4qojkeu8A5t6AbF4Hb24QsTOkTeCNE1k9
        C8SD2sMpW2RQya1hRm+22AC/MHC0yhcrUCajz0XcF/l4IKT08uHCZN6agm1+x+U3t72kpaFE0gsS0
        DnwVH4lsUfw5kgiBgXPYc4ZT7Y2Lb1BJEsYKLa1TCbzQoMV9dIeCutamH6V9SvAruUbpL0cElRPJS
        5Pmiz80A==;
Received: from [2001:4bb8:180:5296:cded:8d4b:ace6:f3c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQCEz-00BUpr-2n; Fri, 04 Mar 2022 18:01:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH 05/10] dm-integrity: stop using bio_devname
Date:   Fri,  4 Mar 2022 19:01:00 +0100
Message-Id: <20220304180105.409765-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220304180105.409765-1-hch@lst.de>
References: <20220304180105.409765-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Use the %pg format specifier to save on stack consuption and code size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm-integrity.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index eb4b5e52bd6ff..c58a5111cb575 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1788,12 +1788,11 @@ static void integrity_metadata(struct work_struct *w)
 						checksums_ptr - checksums, dio->op == REQ_OP_READ ? TAG_CMP : TAG_WRITE);
 			if (unlikely(r)) {
 				if (r > 0) {
-					char b[BDEVNAME_SIZE];
 					sector_t s;
 
 					s = sector - ((r + ic->tag_size - 1) / ic->tag_size);
-					DMERR_LIMIT("%s: Checksum failed at sector 0x%llx",
-						    bio_devname(bio, b), s);
+					DMERR_LIMIT("%pg: Checksum failed at sector 0x%llx",
+						    bio->bi_bdev, s);
 					r = -EILSEQ;
 					atomic64_inc(&ic->number_of_mismatches);
 					dm_audit_log_bio(DM_MSG_PREFIX, "integrity-checksum",
-- 
2.30.2

