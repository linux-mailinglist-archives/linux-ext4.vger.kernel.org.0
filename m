Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772B93CCDB5
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jul 2021 07:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbhGSGC1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Jul 2021 02:02:27 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:52474
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S234187AbhGSGC1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 19 Jul 2021 02:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=Ljg4WLub9QHWm4GrWNCvNrAqcmp4JsSqjNQ2EP2ANOM=; b=v
        T824+xX0yplmxTG8ZS3lVAfElADQLXmbIppGy2XnFbaaF2nHYL1THDJwmPo1vy1P
        mtcPHV5ilmSwEazM5CODALEc7Z65/TiaICmFR7F1iKAYyy46k6b6RFfhUKC89FJ/
        0ixGn+/SmqmOZEqhbBILZ/lTQt0JmJ+NopiOmGTtP0=
Received: from localhost.localdomain (unknown [10.162.86.133])
        by app1 (Coremail) with SMTP id XAUFCgBXX0+1FPVgdxSJAA--.1776S3;
        Mon, 19 Jul 2021 13:59:17 +0800 (CST)
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH] ext4: Convert from atomic_t to refcount_t on ext4_io_end->count
Date:   Mon, 19 Jul 2021 13:59:14 +0800
Message-Id: <1626674355-55795-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XAUFCgBXX0+1FPVgdxSJAA--.1776S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Wry3tF17ZrWxKrWftr4xJFb_yoW8tFyfpF
        yq9FWUGFWxZwn2krW7GanrZr1UJ34Iy3y8W347GFWjyr93WFs0q3WFqF15JF18ZrWxCF17
        XF48WF98ZF13GrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
        648v4I1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
        8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
        xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
        8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Gr0_Zr1lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
        ZEXa7VUbZmitUUUUU==
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

refcount_t type and corresponding API can protect refcounters from
accidental underflow and overflow and further use-after-free situations.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 fs/ext4/ext4.h    | 3 ++-
 fs/ext4/page-io.c | 8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 3c51e243450d..e5b3575da7e9 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -17,6 +17,7 @@
 #ifndef _EXT4_H
 #define _EXT4_H
 
+#include <linux/refcount.h>
 #include <linux/types.h>
 #include <linux/blkdev.h>
 #include <linux/magic.h>
@@ -241,7 +242,7 @@ typedef struct ext4_io_end {
 	struct bio		*bio;		/* Linked list of completed
 						 * bios covering the extent */
 	unsigned int		flag;		/* unwritten or not */
-	atomic_t		count;		/* reference counter */
+	refcount_t		count;		/* reference counter */
 	struct list_head	list_vec;	/* list of ext4_io_end_vec */
 } ext4_io_end_t;
 
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index f038d578d8d8..9cb261714991 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -279,14 +279,14 @@ ext4_io_end_t *ext4_init_io_end(struct inode *inode, gfp_t flags)
 		io_end->inode = inode;
 		INIT_LIST_HEAD(&io_end->list);
 		INIT_LIST_HEAD(&io_end->list_vec);
-		atomic_set(&io_end->count, 1);
+		refcount_set(&io_end->count, 1);
 	}
 	return io_end;
 }
 
 void ext4_put_io_end_defer(ext4_io_end_t *io_end)
 {
-	if (atomic_dec_and_test(&io_end->count)) {
+	if (refcount_dec_and_test(&io_end->count)) {
 		if (!(io_end->flag & EXT4_IO_END_UNWRITTEN) ||
 				list_empty(&io_end->list_vec)) {
 			ext4_release_io_end(io_end);
@@ -300,7 +300,7 @@ int ext4_put_io_end(ext4_io_end_t *io_end)
 {
 	int err = 0;
 
-	if (atomic_dec_and_test(&io_end->count)) {
+	if (refcount_dec_and_test(&io_end->count)) {
 		if (io_end->flag & EXT4_IO_END_UNWRITTEN) {
 			err = ext4_convert_unwritten_io_end_vec(io_end->handle,
 								io_end);
@@ -314,7 +314,7 @@ int ext4_put_io_end(ext4_io_end_t *io_end)
 
 ext4_io_end_t *ext4_get_io_end(ext4_io_end_t *io_end)
 {
-	atomic_inc(&io_end->count);
+	refcount_inc(&io_end->count);
 	return io_end;
 }
 
-- 
2.7.4

