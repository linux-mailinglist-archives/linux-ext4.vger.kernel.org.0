Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B0F4FE3FB
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Apr 2022 16:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238645AbiDLOlL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Apr 2022 10:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbiDLOlK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Apr 2022 10:41:10 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA185F4C5
        for <linux-ext4@vger.kernel.org>; Tue, 12 Apr 2022 07:38:52 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Kd7XT4bY3zBs86;
        Tue, 12 Apr 2022 22:34:33 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 12 Apr
 2022 22:38:50 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>, <yebin10@huawei.com>,
        <liuzhiqiang26@huawei.com>, <liangyun2@huawei.com>
Subject: [RFC PATCH] ext4: add unmount filesystem message
Date:   Tue, 12 Apr 2022 22:53:20 +0800
Message-ID: <20220412145320.2669897-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Now that we have kernel message at mount time, system administrator
could acquire the mount time, device and options easily. But we don't
have corresponding unmounting message at umount time, so we cannot know
if someone umount a filesystem easily. Some of the modern filesystems
(e.g. xfs) have the umounting kernel message, so add one for ext4
filesystem for convenience.

 EXT4-fs (sdb): mounted filesystem with ordered data mode. Quota mode: none.
 EXT4-fs (sdb): unmounting filesystem.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 81749eaddf4c..bdecf62f4b55 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1199,6 +1199,9 @@ static void ext4_put_super(struct super_block *sb)
 	int aborted = 0;
 	int i, err;
 
+	if (___ratelimit(&ext4_mount_msg_ratelimit, "EXT4-fs unmount"))
+		ext4_msg(sb, KERN_INFO, "unmounting filesystem.");
+
 	ext4_unregister_li_request(sb);
 	ext4_quota_off_umount(sb);
 
-- 
2.31.1

