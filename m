Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA634034C4
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Sep 2021 09:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347410AbhIHHIF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Sep 2021 03:08:05 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:36537
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1347071AbhIHHID (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Sep 2021 03:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=9ngNbiGDsxISmmYfAEEQV1JCjxzN4OZTP8qa0hqYH78=; b=V
        25+5mCt4Jy+WjDnri8g/dHZnmjxZyx/EVgGX7RwE4TtxTqQTKGj6hFem1/MvRhX/
        mBgnYWMHJaDAu1bVu41NIPCEME8q0y/YkMFTC6nqlR3bAL9GMATClQWfmaodSdyk
        Ctw5Yz8FbcaJNago61TjGVio++HdiVpGSG4ZjUhNbU=
Received: from t640 (unknown [10.176.36.8])
        by app1 (Coremail) with SMTP id XAUFCgDX3V0LYThh3dI1AA--.13518S3;
        Wed, 08 Sep 2021 15:06:51 +0800 (CST)
From:   Chenyuan Mi <cymi20@fudan.edu.cn>
Cc:     yuanxzhang@fudan.edu.cn, Chenyuan Mi <cymi20@fudan.edu.cn>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: Fix handle refcount leak in ext4_write_begin()
Date:   Wed,  8 Sep 2021 15:06:40 +0800
Message-Id: <20210908070640.7135-1-cymi20@fudan.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: XAUFCgDX3V0LYThh3dI1AA--.13518S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XFy3uryDCF4fJrWfZw4Utwb_yoW3ZFg_Ga
        48WF4rurnYvws29w4rGwsIqw1a9Fn5Ww1rWwn7tr18Xa4jvaykGrZ5Aa47ArWUWr429ry5
        CFnrWrySk34xXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j
        6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
        YxC7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
        026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
        Jw0_GFylx4CE04Ijxs4lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1U
        MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
        VFxhVjvjDU0xZFpf9x0pRcAw7UUUUU=
X-CM-SenderInfo: isqsiiisuqikmt6i3vldqovvfxof0/
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The reference counting issue happens when ret is zero,
the function forgets to decrease the refcount of handle
increased by ext4_journal_start().

Fix this issue by using ext4_journal_stop() to decrease
the refcount of handle.

Signed-off-by: Chenyuan Mi <cymi20@fudan.edu.cn>
Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 fs/ext4/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d18852d6029c..90c57d8e3de1 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1249,6 +1249,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 		put_page(page);
 		return ret;
 	}
+	ext4_journal_stop(handle);
 	*pagep = page;
 	return ret;
 }
-- 
2.17.1

