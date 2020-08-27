Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473BD253DBC
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Aug 2020 08:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgH0G3C (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Aug 2020 02:29:02 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:10086 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726266AbgH0G3C (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 27 Aug 2020 02:29:02 -0400
Received: from localhost.localdomain (unknown [210.32.144.184])
        by mail-app4 (Coremail) with SMTP id cS_KCgCXD3ubUkdfExdgAQ--.30382S4;
        Thu, 27 Aug 2020 14:28:46 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: Fix memleak in add_new_gdb
Date:   Thu, 27 Aug 2020 14:28:43 +0800
Message-Id: <20200827062843.10188-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cS_KCgCXD3ubUkdfExdgAQ--.30382S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CF43KF4xCw17tw45Wr4Durg_yoW8GFy5pr
        yjkF1kCrykCFyqgFZay3WUX3W8C3WxKryUWrZ7GryfZrZxX3Z3KFyUt34fCF45ArWrua12
        qF4Ut34Yyr1qg3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvI1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8AwCF04k20xvY0x0EwIxG
        rwCF04k20xvE74AGY7Cv6cx26r4fKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r12
        6r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x0JU-J5rUUUUU=
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAg0EBlZdtPrBDAATsW
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When ext4_journal_get_write_access() fails, we should release
n_group_desc, iloc.bh, dind and gdb_bh to prevent memleak.
It's the same when ext4_handle_dirty_super() fails, but we
don't need to release dind here because it has been released
before.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 fs/ext4/resize.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index a50b51270ea9..efc0a022ca8e 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -843,8 +843,10 @@ static int add_new_gdb(handle_t *handle, struct inode *inode,
 
 	BUFFER_TRACE(dind, "get_write_access");
 	err = ext4_journal_get_write_access(handle, dind);
-	if (unlikely(err))
+	if (unlikely(err)) {
 		ext4_std_error(sb, err);
+		goto errout;
+	}
 
 	/* ext4_reserve_inode_write() gets a reference on the iloc */
 	err = ext4_reserve_inode_write(handle, inode, &iloc);
@@ -899,13 +901,17 @@ static int add_new_gdb(handle_t *handle, struct inode *inode,
 
 	le16_add_cpu(&es->s_reserved_gdt_blocks, -1);
 	err = ext4_handle_dirty_super(handle, sb);
-	if (err)
+	if (err) {
 		ext4_std_error(sb, err);
+		goto errsuper;
+	}
+
 	return err;
 errout:
+	brelse(dind);
+errsuper:
 	kvfree(n_group_desc);
 	brelse(iloc.bh);
-	brelse(dind);
 	brelse(gdb_bh);
 
 	ext4_debug("leaving with error %d\n", err);
-- 
2.17.1

