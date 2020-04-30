Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A481BF77E
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Apr 2020 14:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgD3MAL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Apr 2020 08:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726817AbgD3MAK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 30 Apr 2020 08:00:10 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3ACC08E859
        for <linux-ext4@vger.kernel.org>; Thu, 30 Apr 2020 05:00:08 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id o21so6212274qkm.4
        for <linux-ext4@vger.kernel.org>; Thu, 30 Apr 2020 05:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xb7ctfgBkT8MKaWibTzyhvK9qysU0rW7SMEIFQJPgjA=;
        b=j3MV8ehiEKFgagO26nEjNhVxO4Z3rfz3PgodR90MbmrOihzmftOVMN3dBSVjw6DwcH
         NwnboOih2ghd10oscPSB9TbkVyxMFmxTmRY9cfbQYPSStmlGMGHr4pXkNtCKksXqcReZ
         VmjTcKlNEs5zmmT5nzpxh8Q4oACZ2GFvoGqw5BcrCu7lRNJhLvd8n0p8WvM7/2zMhXRC
         MChmDritFxEmgy7hFU9O/trQyxIrq47yNSgUDXcWBXHbTrr6Hx7+nBsFawKzrqskLaa2
         vz8ZbhrtwnNrqNVciVFxtHPWdZimvNauQchtfjH7114FebUU3UGoR8rZ65ov0YMMRTqZ
         cTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xb7ctfgBkT8MKaWibTzyhvK9qysU0rW7SMEIFQJPgjA=;
        b=GbkT3j9ID1aE8VrlaMcxoJCrn088E68WjmuoCy0WjdhaAz72ylozr/d5boUKsMk2ze
         8waW2LpPaLsRgHBFKj2AI96p8Kg868wBxrsdhma8jqBHpwsDL2S0B/cPPlWHN+3o8RZk
         xmp39IoS9B7wyZGINxo9m8MzXonG0CJSYgNA3eS5BeBQUHKfZQF0d4MNIiXN+i5GNYs/
         ZaL3IX19898BMU2K9IkGQ/SPcP10TkPhMsx3kuYxJGbZZsBwwcCfjvVm5O9ZXOmMnKcS
         t5qYhXjUM4Qlk0A9+tPK3bMp0q4PSsFeNIaa5rRYCS1fKJYrMvxkF3HxqslThD90rljI
         6Gcw==
X-Gm-Message-State: AGi0PubvOobAq+iDQkfwIDOU3cQGqOilr89jk65TtuJV6nxpx+0SreUJ
        2bX+0TxkzRuA1nGAgUoDv3BPykHhKEE=
X-Google-Smtp-Source: APiQypJ0+JbtQIPsOVpdih60Wu/ehAdkUx4TBNQKmrynPl5SshZ274V1P85qpQJQSoRICJ+5d5v3BF8jgY8=
X-Received: by 2002:ad4:4f01:: with SMTP id fb1mr2711453qvb.162.1588248007896;
 Thu, 30 Apr 2020 05:00:07 -0700 (PDT)
Date:   Thu, 30 Apr 2020 11:59:51 +0000
In-Reply-To: <20200430115959.238073-1-satyat@google.com>
Message-Id: <20200430115959.238073-5-satyat@google.com>
Mime-Version: 1.0
References: <20200430115959.238073-1-satyat@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v12 04/12] block: Make blk-integrity preclude hardware inline encryption
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Whenever a device supports blk-integrity, make the kernel pretend that
the device doesn't support inline encryption (essentially by setting the
keyslot manager in the request queue to NULL).

There's no hardware currently that supports both integrity and inline
encryption. However, it seems possible that there will be such hardware
in the near future (like the NVMe key per I/O support that might support
both inline encryption and PI).

But properly integrating both features is not trivial, and without
real hardware that implements both, it is difficult to tell if it will
be done correctly by the majority of hardware that support both.
So it seems best not to support both features together right now, and
to decide what to do at probe time.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/bio-integrity.c   |  3 +++
 block/blk-integrity.c   |  7 +++++++
 block/keyslot-manager.c | 19 +++++++++++++++++++
 include/linux/blkdev.h  | 30 ++++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index bf62c25cde8f4..3579ac0f6ec1f 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -42,6 +42,9 @@ struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio,
 	struct bio_set *bs = bio->bi_pool;
 	unsigned inline_vecs;
 
+	if (WARN_ON_ONCE(bio_has_crypt_ctx(bio)))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if (!bs || !mempool_initialized(&bs->bio_integrity_pool)) {
 		bip = kmalloc(struct_size(bip, bip_inline_vecs, nr_vecs), gfp_mask);
 		inline_vecs = nr_vecs;
diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index ff1070edbb400..c03705cbb9c9f 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -409,6 +409,13 @@ void blk_integrity_register(struct gendisk *disk, struct blk_integrity *template
 	bi->tag_size = template->tag_size;
 
 	disk->queue->backing_dev_info->capabilities |= BDI_CAP_STABLE_WRITES;
+
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+	if (disk->queue->ksm) {
+		pr_warn("blk-integrity: Integrity and hardware inline encryption are not supported together. Disabling hardware inline encryption.\n");
+		blk_ksm_unregister(disk->queue);
+	}
+#endif
 }
 EXPORT_SYMBOL(blk_integrity_register);
 
diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
index 69f51909fc8ad..8d388cdbcd5d0 100644
--- a/block/keyslot-manager.c
+++ b/block/keyslot-manager.c
@@ -25,6 +25,9 @@
  * Upper layers will call blk_ksm_get_slot_for_key() to program a
  * key into some slot in the inline encryption hardware.
  */
+
+#define pr_fmt(fmt) "blk-crypto: " fmt
+
 #include <linux/keyslot-manager.h>
 #include <linux/atomic.h>
 #include <linux/mutex.h>
@@ -376,3 +379,19 @@ void blk_ksm_destroy(struct blk_keyslot_manager *ksm)
 	memzero_explicit(ksm, sizeof(*ksm));
 }
 EXPORT_SYMBOL_GPL(blk_ksm_destroy);
+
+bool blk_ksm_register(struct blk_keyslot_manager *ksm, struct request_queue *q)
+{
+	if (blk_integrity_queue_supports_integrity(q)) {
+		pr_warn("Integrity and hardware inline encryption are not supported together. Disabling hardware inline encryption.\n");
+		return false;
+	}
+	q->ksm = ksm;
+	return true;
+}
+EXPORT_SYMBOL_GPL(blk_ksm_register);
+
+void blk_ksm_unregister(struct request_queue *q)
+{
+	q->ksm = NULL;
+}
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 98aae4638fda9..17738dab8ae04 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1562,6 +1562,12 @@ struct blk_integrity *bdev_get_integrity(struct block_device *bdev)
 	return blk_get_integrity(bdev->bd_disk);
 }
 
+static inline bool
+blk_integrity_queue_supports_integrity(struct request_queue *q)
+{
+	return q->integrity.profile;
+}
+
 static inline bool blk_integrity_rq(struct request *rq)
 {
 	return rq->cmd_flags & REQ_INTEGRITY;
@@ -1642,6 +1648,11 @@ static inline struct blk_integrity *blk_get_integrity(struct gendisk *disk)
 {
 	return NULL;
 }
+static inline bool
+blk_integrity_queue_supports_integrity(struct request_queue *q)
+{
+	return false;
+}
 static inline int blk_integrity_compare(struct gendisk *a, struct gendisk *b)
 {
 	return 0;
@@ -1693,6 +1704,25 @@ static inline struct bio_vec *rq_integrity_vec(struct request *rq)
 
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+
+bool blk_ksm_register(struct blk_keyslot_manager *ksm, struct request_queue *q);
+
+void blk_ksm_unregister(struct request_queue *q);
+
+#else /* CONFIG_BLK_INLINE_ENCRYPTION */
+
+static inline bool blk_ksm_register(struct blk_keyslot_manager *ksm,
+				    struct request_queue *q)
+{
+	return true;
+}
+
+static inline void blk_ksm_unregister(struct request_queue *q) { }
+
+#endif /* CONFIG_BLK_INLINE_ENCRYPTION */
+
+
 struct block_device_operations {
 	int (*open) (struct block_device *, fmode_t);
 	void (*release) (struct gendisk *, fmode_t);
-- 
2.26.2.303.gf8c07b1a785-goog

