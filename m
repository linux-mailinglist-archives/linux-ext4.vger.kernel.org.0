Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8B62936D9
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Oct 2020 10:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388914AbgJTIcw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 20 Oct 2020 04:32:52 -0400
Received: from smtp.h3c.com ([60.191.123.56]:23469 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388905AbgJTIcw (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 20 Oct 2020 04:32:52 -0400
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam01-ex.h3c.com with ESMTPS id 09K8WBTY041663
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Oct 2020 16:32:11 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 20 Oct 2020 16:32:14 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Xianting Tian <tian.xianting@h3c.com>
Subject: [PATCH] ext4: remove the null check of bio_vec page
Date:   Tue, 20 Oct 2020 16:22:01 +0800
Message-ID: <20201020082201.34257-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 09K8WBTY041663
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

bv_page can't be NULL in a valid bio_vec, so we can remove the NULL check,
as we did in other places when calling bio_for_each_segment_all() to go
through all bio_vec of a bio.

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 fs/ext4/page-io.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index defd2e10d..cb135a944 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -111,9 +111,6 @@ static void ext4_finish_bio(struct bio *bio)
 		unsigned under_io = 0;
 		unsigned long flags;
 
-		if (!page)
-			continue;
-
 		if (fscrypt_is_bounce_page(page)) {
 			bounce_page = page;
 			page = fscrypt_pagecache_page(bounce_page);
-- 
2.17.1

