Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4032043AF7B
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Oct 2021 11:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbhJZJzI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Oct 2021 05:55:08 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:47271 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231963AbhJZJzH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 26 Oct 2021 05:55:07 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Utltwsb_1635241961;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Utltwsb_1635241961)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 Oct 2021 17:52:42 +0800
Date:   Tue, 26 Oct 2021 17:52:41 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH] Revert "ext4: enforce buffer head state assertion in
 ext4_da_map_blocks"
Message-ID: <YXfP6Z/fyNwU/jfv@B-P7TQMD6M-0146.local>
References: <20211012171901.5352-1-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211012171901.5352-1-enwlinux@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

On Tue, Oct 12, 2021 at 01:19:01PM -0400, Eric Whitney wrote:
> This reverts commit 948ca5f30e1df0c11eb5b0f410b9ceb97fa77ad9.
> 
> Two crash reports from users running variations on 5.15-rc4 kernels
> suggest that it is premature to enforce the state assertion in the
> original commit.  Both crashes were triggered by BUG calls in that
> code, indicating that under some rare circumstance the buffer head
> state did not match a delayed allocated block at the time the
> block was written out.  No reproducer is available.  Resolving this
> problem will require more time than remains in the current release
> cycle, so reverting the original patch for the time being is necessary
> to avoid any instability it may cause.
> 
> Signed-off-by: Eric Whitney <enwlinux@gmail.com>

I noticed another problem related to commit 948ca5f30e1d
("ext4: enforce buffer head state assertion in ext4_da_map_blocks")
due to memory failure fault injection.

I think because buffer head and page can be removed due to
memory failure in generic_error_remove_page(). So it becomes
inconsistent with the extent status.

When such condition happens, it prints:

[   33.879505] Injecting memory failure for pfn 0x10f57e at process virtual address 0x20000000
[   33.881523] gx: mapping ffff995684f686f8 page->index 0 blocknr ffffffffffff0000 delay 1 new 0 dirty 1 mapped 1
[   33.881530] Memory failure: 0x10f57e: recovery action for dirty LRU page: Recovered

...

[   34.310151] ------------[ cut here ]------------
[   34.311972] mapping ffff995684f686f8 iblock 0 b_blocknr ffffffffffffffff invalid_block ffffffffffff0000 buffer_new 0 buffer_delay 0
[   34.315107] WARNING: CPU: 1 PID: 729 at fs/ext4/inode.c:1721 ext4_da_get_block_prep+0x30e/0x440

Anyway, revert the commit can avoid the memory fault injection
problem as well. I think if such patch re-lands, it needs to
consider memory failure condition too....

Thanks,
Gao Xiang


p.s. here is my debugging patch:
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0f06305167d5..d20553ac523a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1718,6 +1718,9 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
                 * initially delayed allocated
                 */
                if (ext4_es_is_delonly(&es)) {
+                       WARN(1, "mapping %px iblock %llu b_blocknr %llx buffer_new %u buffer_delay %u\n",
+                              inode->i_mapping, iblock, bh->b_blocknr, buffer_new(bh), buffer_delay(bh));
+
                        BUG_ON(bh->b_blocknr != invalid_block);
                        BUG_ON(!buffer_new(bh));
                        BUG_ON(!buffer_delay(bh));
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 3e6449f2102a..8bf2affe03fd 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -33,6 +33,7 @@
  * are rare we hope to get away with this. This avoids impacting the core
  * VM.
  */
+#include <linux/buffer_head.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/page-flags.h>
@@ -779,7 +780,17 @@ static int truncate_error_page(struct page *p, unsigned long pfn,
        int ret = MF_FAILED;

        if (mapping->a_ops->error_remove_page) {
-               int err = mapping->a_ops->error_remove_page(mapping, p);
+               int err;
+
+               if (page_has_buffers(p)) {
+                       struct buffer_head *bh;
+
+                       bh = page_buffers(p);
+                       pr_err("gx: mapping %px page->index %lu blocknr %llx delay %u new %u dirty %u mapped %u", mapping, p->index,
+                              bh->b_blocknr, buffer_delay(bh), buffer_new(bh), buffer_dirty(bh), buffer_mapped(bh));
+               }
+
+               err = mapping->a_ops->error_remove_page(mapping, p);

                if (err != 0) {
                        pr_info("Memory failure: %#lx: Failed to punch page: %d\n",

