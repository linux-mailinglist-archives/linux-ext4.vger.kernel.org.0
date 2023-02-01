Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A79A686555
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Feb 2023 12:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjBALXF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Feb 2023 06:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjBALXB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Feb 2023 06:23:01 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CF44EE8;
        Wed,  1 Feb 2023 03:22:59 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4P6KKB6w1vz4f3nTZ;
        Wed,  1 Feb 2023 19:22:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgDn4R+NS9pj_j45Cg--.57546S9;
        Wed, 01 Feb 2023 19:22:57 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH 5/5] ext4: make sure fs error flag setted before clear journal error
Date:   Wed,  1 Feb 2023 19:46:51 +0800
Message-Id: <20230201114651.4090446-6-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230201114651.4090446-1-yebin@huaweicloud.com>
References: <20230201114651.4090446-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDn4R+NS9pj_j45Cg--.57546S9
X-Coremail-Antispam: 1UD129KBjvdXoWrtryDXF13GrW7XryxXryrZwb_yoWkXwbEq3
        yxZan5Wrs3Ar1xK3WrCan8WwnYvws2vrnYqasayF15uryDXa4kCa4kWryfurn8urWrKrZ8
        JF18ZFn7KFWkZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbVAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s
        0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
        Y2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14
        v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
        0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
        VjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
---
 fs/ext4/super.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ab136d08d93d..c36cc9708258 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6146,11 +6146,13 @@ static int ext4_clear_journal_err(struct super_block *sb,
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

