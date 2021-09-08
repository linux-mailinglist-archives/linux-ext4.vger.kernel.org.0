Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14F74032BA
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Sep 2021 04:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbhIHCrh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Sep 2021 22:47:37 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:48656
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1347310AbhIHCrb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Sep 2021 22:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=PsXa71UXnfiO14JeLWnPycns9htCDk4qLO1l0LXQQhQ=; b=h
        JS0M2gc1aGJAEYRWjelO2a9DF6e0teObK8AvsAt3ZodxoZZ4HqUexDqLzXfxGZBg
        XTYesEvE4yzK3s+HGwHzWyL9Gb4f0GCtSMY9FXCtZmToQ6Pbo1FsBS8mTass8Po3
        PyYYG1elmm+pXLrjLXUHtOk4fRx9WiZPMd8bbDLOfg=
Received: from t640 (unknown [10.176.36.8])
        by app1 (Coremail) with SMTP id XAUFCgBnyGXvIzhhVhY0AA--.49807S3;
        Wed, 08 Sep 2021 10:46:07 +0800 (CST)
From:   Chenyuan Mi <cymi20@fudan.edu.cn>
Cc:     yuanxzhang@fudan.edu.cn, Chenyuan Mi <cymi20@fudan.edu.cn>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: Fix refcount leak bug in __ext4_new_inode()
Date:   Wed,  8 Sep 2021 10:46:05 +0800
Message-Id: <20210908024605.16857-1-cymi20@fudan.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: XAUFCgBnyGXvIzhhVhY0AA--.49807S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1rCF1fWw15ZFy7Kr4rKrg_yoW8Zr4fpr
        Wakr17Crs8WasF9rWvka18Zr17Ka48GrW7JrWIk3s0qasxZw1SyFykKF1vyF13ArWruayY
        qF4Yvw15CF42k37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl
        6s0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
        YxC7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
        026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
        Jw0_GFylx4CE04Ijxs4lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWI
        evJa73UjIFyTuYvjTRAl1kUUUUU
X-CM-SenderInfo: isqsiiisuqikmt6i3vldqovvfxof0/
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

After successfully creating handle by __ext4_journal_start_sb(),
the function forgets to decrease the refcount of handle in several
paths, causing refcount leak.

Fix this issue by recording a flag when successfully getting handle
by __ext4_journal_start_sb(), and decrease the refcount of handle
when exiting this function if holding the flag.

Signed-off-by: Chenyuan Mi <cymi20@fudan.edu.cn>
Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>

---
 fs/ext4/ialloc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index f73e5eb43eae..7563b892c64f 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -944,6 +944,7 @@ struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
 	ext4_group_t flex_group;
 	struct ext4_group_info *grp = NULL;
 	bool encrypt = false;
+	bool create_handle = false;
 
 	/* Cannot create files in a deleted directory */
 	if (!dir || !dir->i_nlink)
@@ -1085,6 +1086,7 @@ struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
 				ext4_std_error(sb, err);
 				goto out;
 			}
+			create_handle = true;
 		}
 		BUFFER_TRACE(inode_bitmap_bh, "get_write_access");
 		err = ext4_journal_get_write_access(handle, sb, inode_bitmap_bh,
@@ -1345,7 +1347,8 @@ struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
 		ext4_std_error(sb, err);
 		goto fail_free_drop;
 	}
-
+	if (create_handle)
+		ext4_journal_stop(handle);
 	ext4_debug("allocating inode %lu\n", inode->i_ino);
 	trace_ext4_allocate_inode(inode, dir, mode);
 	brelse(inode_bitmap_bh);
@@ -1357,6 +1360,8 @@ struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
 	clear_nlink(inode);
 	unlock_new_inode(inode);
 out:
+	if (create_handle)
+		ext4_journal_stop(handle);
 	dquot_drop(inode);
 	inode->i_flags |= S_NOQUOTA;
 	iput(inode);
-- 
2.17.1

