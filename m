Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D2952B99E
	for <lists+linux-ext4@lfdr.de>; Wed, 18 May 2022 14:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbiERMCH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 May 2022 08:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236107AbiERMCD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 May 2022 08:02:03 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1663E4B1C8;
        Wed, 18 May 2022 05:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=HXUvj
        Tt6xQKMPXhXGTlq1+sgzSQ6z/GSsDelQk+UmYk=; b=gVbXlRS3vcCu0NxbwM6JO
        LWLDfe+pwL2rrciHD7NWcC0p4EoWW4DlKKweWsfmygekWcoF8c7ekymE1WKRO2sI
        6fq9LX+abnmaXprmzQxIsxTcx1DUFnbb1XUfS8h5haUK/ahpZzdma4S9szdjqA7K
        MJbcTOORz3r4Qv1HYVL+m4=
Received: from loongson-PC.loongson.cn (unknown [114.242.206.180])
        by smtp4 (Coremail) with SMTP id HNxpCgAXfdEh4IRiqpxdDA--.16275S3;
        Wed, 18 May 2022 20:01:43 +0800 (CST)
From:   Liu Peibao <liupeibao@163.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        liupeibao@163.com
Subject: [PATCH 2/2] ext4: rename temporary variables in ext4_finish_bio()
Date:   Wed, 18 May 2022 20:01:37 +0800
Message-Id: <20220518120137.2544-2-liupeibao@163.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220518120137.2544-1-liupeibao@163.com>
References: <20220518120137.2544-1-liupeibao@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgAXfdEh4IRiqpxdDA--.16275S3
X-Coremail-Antispam: 1Uf129KBjvJXoWrtw18uw1DWFykXF1rXr4fKrg_yoW8Jr15p3
        s5Ka4YyrW0yr109anrGFn7XF93J3yvg348AFW3K34Utr9IqrnYgay2kr109r18ArZ7CFyx
        CrWa9rnruw43t3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRTmh7UUUUU=
X-Originating-IP: [114.242.206.180]
X-CM-SenderInfo: xolx1vpled0qqrwthudrp/1tbiXwcFbF154g4dSAAAss
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

The temporary variable bio_start and bio_end are confusingly
misnamed. Rename them with bvec_ instead of bio_ to indicate
what they really are.

Signed-off-by: Liu Peibao <liupeibao@163.com>
---
 fs/ext4/page-io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index fd55e11c8391..dd0a7f734d7f 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -106,8 +106,8 @@ static void ext4_finish_bio(struct bio *bio)
 		struct page *page = bvec->bv_page;
 		struct page *bounce_page = NULL;
 		struct buffer_head *bh, *head;
-		unsigned int bio_start = bvec->bv_offset;
-		unsigned int bio_end = bio_start + bvec->bv_len;
+		unsigned int bvec_start = bvec->bv_offset;
+		unsigned int bvec_end = bvec_start + bvec->bv_len;
 		unsigned int under_io = 0;
 		unsigned long flags;
 
@@ -127,8 +127,8 @@ static void ext4_finish_bio(struct bio *bio)
 		 */
 		spin_lock_irqsave(&head->b_uptodate_lock, flags);
 		do {
-			if (bh_offset(bh) < bio_start ||
-			    bh_offset(bh) + bh->b_size > bio_end) {
+			if (bh_offset(bh) < bvec_start ||
+			    bh_offset(bh) + bh->b_size > bvec_end) {
 				if (buffer_async_write(bh))
 					under_io++;
 				continue;
-- 
2.20.1

