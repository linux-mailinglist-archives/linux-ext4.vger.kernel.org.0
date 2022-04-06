Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8047C4F63BA
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Apr 2022 17:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbiDFPjN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Apr 2022 11:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236956AbiDFPi0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Apr 2022 11:38:26 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AAC1DDFF6
        for <linux-ext4@vger.kernel.org>; Wed,  6 Apr 2022 05:52:56 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KYPYP5XMzz1HBP5
        for <linux-ext4@vger.kernel.org>; Wed,  6 Apr 2022 20:52:25 +0800 (CST)
Received: from huawei.com (10.113.189.238) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 6 Apr
 2022 20:52:52 +0800
From:   Wang Jianjian <wangjianjian3@huawei.com>
To:     <linux-ext4@vger.kernel.org>
Subject: [PATCH] ext4: Should ext4_bio_end_io be ext4_end_io_end ?
Date:   Wed, 6 Apr 2022 20:52:51 +0800
Message-ID: <20220406125251.2135346-1-wangjianjian3@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.113.189.238]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There is no ext4_bio_end_io, should it be ext4_end_io_end ?

Signed-off-by: Wang Jianjian <wangjianjian3@huawei.com>
---
 fs/ext4/page-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 495ce59fb4ad..f9273acc4629 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -463,7 +463,7 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 	/*
 	 * In the first loop we prepare and mark buffers to submit. We have to
 	 * mark all buffers in the page before submitting so that
-	 * end_page_writeback() cannot be called from ext4_bio_end_io() when IO
+	 * end_page_writeback() cannot be called from ext4_end_io_end() when IO
 	 * on the first buffer finishes and we are still working on submitting
 	 * the second buffer.
 	 */
-- 
2.32.0

