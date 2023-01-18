Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9F367132C
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Jan 2023 06:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjARFZX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Jan 2023 00:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjARFZU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Jan 2023 00:25:20 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413B251C50;
        Tue, 17 Jan 2023 21:25:18 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NxZ104Jvgz16Mkp;
        Wed, 18 Jan 2023 13:23:32 +0800 (CST)
Received: from huawei.com (10.113.189.238) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 18 Jan
 2023 13:25:15 +0800
From:   Wang Jianjian <wangjianjian3@huawei.com>
To:     <fstests@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <lczerner@redhat.com>
CC:     <wangjianjian3@huawei.com>, <zhangzhikang1@huawei.com>
Subject: [PATCH] ext4: Add default commit interval test
Date:   Wed, 18 Jan 2023 13:25:15 +0800
Message-ID: <20230118052515.3966391-1-wangjianjian3@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.113.189.238]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Signed-off-by: Wang Jianjian <wangjianjian3@huawei.com>
---
 tests/ext4/053 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/ext4/053 b/tests/ext4/053
index 4f20d217..edd8ee0c 100755
--- a/tests/ext4/053
+++ b/tests/ext4/053
@@ -450,6 +450,7 @@ for fstype in ext2 ext3 ext4; do
 	mnt bh removed
 	mnt nobh removed
 	not_ext2 mnt commit=7
+	not_ext2 mnt commit=0 commit=5
 	mnt min_batch_time=200
 	mnt max_batch_time=10000
 	only_ext4 mnt journal_checksum
-- 
2.32.0

