Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984B91B540E
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Apr 2020 07:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgDWFPu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Apr 2020 01:15:50 -0400
Received: from mail.fudan.edu.cn ([202.120.224.10]:43584 "EHLO fudan.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725562AbgDWFPu (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 23 Apr 2020 01:15:50 -0400
X-Greylist: delayed 350 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Apr 2020 01:15:48 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=3OYx4GBLe0XanFHFYKCyXCxotnUqJEh9x+Y95HIWd0M=; b=Q
        DzZXq817hTPuDr3a6/hxsgWr/1JzvVxYn6lYgtnxbVTGRT6VENaHpmV0pnJr6azO
        +g7xnsi3oWmDINi8cL0OjoChh323LIW0bKE5r2cF1Ev+Otfy3MQTiVLRAeGZR1My
        CllCg2jrsVn3V4ZhEVyIwK/rHzhXjfUCSFrK6hQqR4=
Received: from localhost.localdomain (unknown [120.229.255.80])
        by app1 (Coremail) with SMTP id XAUFCgCX33cfI6Fe3Js8AA--.30847S3;
        Thu, 23 Apr 2020 13:09:52 +0800 (CST)
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH] ext4: Fix buffer_head refcnt leak when ext4_iget() fails
Date:   Thu, 23 Apr 2020 13:09:27 +0800
Message-Id: <1587618568-13418-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XAUFCgCX33cfI6Fe3Js8AA--.30847S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKFy7Zw4ktF1fZw4kZr4ktFb_yoWkZrX_WF
        1ktF48ur90vwsaka4UXrZ8Aw4Yk3W8ta1DWrZavr13X3s0ya9rCr9YvFy3Ar47WrW2yFn8
        CrnxGr9xA3ySvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbskFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
        1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v
        4I1lc2xSY4AK67AK6r4rMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
        8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
        xVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
        8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E
        87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
        IFyTuYvjfUO2NtUUUUU
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4_orphan_get() invokes ext4_read_inode_bitmap(), which returns a
reference of the specified buffer_head object to "bitmap_bh" with
increased refcnt.

When ext4_orphan_get() returns, local variable "bitmap_bh" becomes
invalid, so the refcount should be decreased to keep refcount balanced.

The reference counting issue happens in one exception handling path of
ext4_orphan_get(). When ext4_iget() fails, the function forgets to
decrease the refcnt increased by ext4_read_inode_bitmap(), causing a
refcnt leak.

Fix this issue by calling brelse() when ext4_iget() fails.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 fs/ext4/ialloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index f95ee99091e4..2e4729ba17e6 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1234,6 +1234,7 @@ struct inode *ext4_orphan_get(struct super_block *sb, unsigned long ino)
 		ext4_set_errno(sb, -err);
 		ext4_error(sb, "couldn't read orphan inode %lu (err %d)",
 			   ino, err);
+		brelse(bitmap_bh);
 		return inode;
 	}
 
-- 
2.7.4

