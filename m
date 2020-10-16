Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455F028FD05
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Oct 2020 05:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394325AbgJPD4I (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Oct 2020 23:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394317AbgJPD4F (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Oct 2020 23:56:05 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62249C061755
        for <linux-ext4@vger.kernel.org>; Thu, 15 Oct 2020 20:56:05 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id j18so716516pfa.0
        for <linux-ext4@vger.kernel.org>; Thu, 15 Oct 2020 20:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yXU/MqBPj3mvgTMYLaZ63PpolhXc6mLjM3ETWa5F6N0=;
        b=V0roP42REy3e9hwHDMWRnUlwtHuH8BwRi2OuAu0wPo8uOGyddK4m7dOewgGa4UeUXI
         c77VIfBa2Xs+l8eG0ax4N6cvRgDdgmnqxRanNW1G/TlqDWGkGqaSQsbmizUVlpUHoYko
         kVNlbe4B75xUyKjBWR53CNq6v3uEdtDb8N0nFEDB3+DCZMfSYl0FdZzbDldHHqMgACO7
         eHv/nkU1PkxMpT8uhV5n3fhPIfCg5qoYarCuSk/O4eUcg6nnubqOL2YS1QnzKXSgQTSr
         VM2oTL3yxBhTis2/ZTlRL/JMMKlLN1ajB46F+C7TjzCX1itqzO2zxtPEHGVCYlQuWpzx
         3Vaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yXU/MqBPj3mvgTMYLaZ63PpolhXc6mLjM3ETWa5F6N0=;
        b=ModO05dykAADMqBGS73efTV81GbBymnK6/IayzC5Jzsg/40J71E00OOqhX4Ni/t9Yu
         BEmMEscTb1z8JpKV34K+F4BZpZcrlgqgFKO7UUHG52pHqldQTYgsiH7PydYR4fQWnv2y
         BPDFQY5PC9cBg7z8osddVR/SrhM9TCkIlpPdNYbL1wPh95kKj0mpW5hXv/Y0UXBK2vRE
         nHOefmcA7lzFf0bGOqMnhPk6+6iuW3kvukxACV47dhZOed6v6vCxa1xvZTT+YoAbPrL9
         cIVG9ngTzOuNTmbCcRGTW6CP693KeE5ZUjFy8quAMiAm02UOPBUihWKxUrIZpIJQFiMQ
         qcxg==
X-Gm-Message-State: AOAM532Y7NqieJ9EfQL3YOb8TgsT/SwuddAGxrizHFBai0OHhLPbtsOy
        ht11ZbXaSmcImaVZz4acIZ8=
X-Google-Smtp-Source: ABdhPJw5ilKfd33RNpNIbn6jGqO3gDnhs7q6EfziOzb2WQtqxPSikQCd7T6NDC3REyFs9N3OxgdM8A==
X-Received: by 2002:a63:1c4e:: with SMTP id c14mr1461260pgm.98.1602820564952;
        Thu, 15 Oct 2020 20:56:04 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id v12sm861555pgr.4.2020.10.15.20.56.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2020 20:56:04 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH 4/8] ext4: simplify the code of mb_find_order_for_block
Date:   Fri, 16 Oct 2020 11:55:48 +0800
Message-Id: <1602820552-4082-4-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1602820552-4082-1-git-send-email-brookxu@tencent.com>
References: <1602820552-4082-1-git-send-email-brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

The code of mb_find_order_for_block is a bit obscure, but we can
simplify it with mb_find_buddy(), make the code more concise.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/ext4/mballoc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 5b8ce76..2eead37 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1289,22 +1289,18 @@ static void ext4_mb_unload_buddy(struct ext4_buddy *e4b)
 
 static int mb_find_order_for_block(struct ext4_buddy *e4b, int block)
 {
-	int order = 1;
-	int bb_incr = 1 << (e4b->bd_blkbits - 1);
+	int order = 1, max;
 	void *bb;
 
 	BUG_ON(e4b->bd_bitmap == e4b->bd_buddy);
 	BUG_ON(block >= (1 << (e4b->bd_blkbits + 3)));
 
-	bb = e4b->bd_buddy;
 	while (order <= e4b->bd_blkbits + 1) {
-		block = block >> 1;
-		if (!mb_test_bit(block, bb)) {
+		bb = mb_find_buddy(e4b, order, &max);
+		if (!mb_test_bit(block >> order, bb)) {
 			/* this block is part of buddy of order 'order' */
 			return order;
 		}
-		bb += bb_incr;
-		bb_incr >>= 1;
 		order++;
 	}
 	return 0;
-- 
1.8.3.1

