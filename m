Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A6F6A6BC8
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Mar 2023 12:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjCALf6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Mar 2023 06:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCALf4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Mar 2023 06:35:56 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E322FCE5;
        Wed,  1 Mar 2023 03:35:54 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PRXHB0sl3z4f3jYp;
        Wed,  1 Mar 2023 19:35:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgDHcyGVOP9jOXabEA--.39702S6;
        Wed, 01 Mar 2023 19:35:52 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH v4 2/2] ext4: make sure fs error flag setted before clear journal error
Date:   Wed,  1 Mar 2023 19:59:09 +0800
Message-Id: <20230301115909.184772-3-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230301115909.184772-1-yebin@huaweicloud.com>
References: <20230301115909.184772-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDHcyGVOP9jOXabEA--.39702S6
X-Coremail-Antispam: 1UD129KBjvdXoWrtryDXF13GrW7XryxXryrZwb_yoWkZrcEq3
        yIyan5WrsxAw1xK3WrCan8WwnYvws2vr15X3ZayF15uryDXas5Ca4DWr93urn8urWrKrZ8
        tF17ZF1fG3ykXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbsAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r15M2
        8IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
        021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F
        4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
        oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7V
        C0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j
        6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
        UI43ZEXa7IU86wZ7UUUUU==
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

Now, jounral error number maybe cleared even though ext4_commit_super()
failed. This may lead to error flag miss, then fsck will miss to check
file system deeply.

Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 9df8fada2dce..7736c96d5a78 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6152,11 +6152,13 @@ static int ext4_clear_journal_err(struct super_block *sb,
 		errstr = ext4_decode_error(sb, j_errno, nbuf);
 		ext4_warning(sb, "Filesystem error recorded "
 			     "from previous mount: %s", errstr);
-		ext4_warning(sb, "Marking fs in need of filesystem check.");
 
 		EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
 		es->s_state |= cpu_to_le16(EXT4_ERROR_FS);
-		ext4_commit_super(sb);
+		j_errno = ext4_commit_super(sb);
+		if (j_errno)
+			return j_errno;
+		ext4_warning(sb, "Marked fs in need of filesystem check.");
 
 		jbd2_journal_clear_err(journal);
 		jbd2_journal_update_sb_errno(journal);
-- 
2.31.1

