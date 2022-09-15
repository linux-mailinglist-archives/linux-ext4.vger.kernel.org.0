Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B23A5B9FE4
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Sep 2022 18:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiIOQs7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Sep 2022 12:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiIOQsp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Sep 2022 12:48:45 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3E572B5B
        for <linux-ext4@vger.kernel.org>; Thu, 15 Sep 2022 09:48:43 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o70-20020a17090a0a4c00b00202f898fa86so8547830pjo.2
        for <linux-ext4@vger.kernel.org>; Thu, 15 Sep 2022 09:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=5ygvmrZPI1WDIMPoH4fryGIYobUzr2vUUota+pvSXgQ=;
        b=OwhGbST3lN2j4BrNnqLh+crZoPJ17algWOozP9/QDV6cINmVxBuZv1MnjIOEEBVuFZ
         w03zVHy7wVCYe2BrUXeeMOC/7qE2nTIBh3IWd//tWn1griPA5IqsGx1fBFnIny8polm4
         OTKZRylYH/i3WSS8517Mp1igJHBaaHCpQZJLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5ygvmrZPI1WDIMPoH4fryGIYobUzr2vUUota+pvSXgQ=;
        b=lMF0yw/sVMk9/hi17NtUx46/qpqqo347J7LQ+n8M4E3f9CPcVfW6VUOmMu5gWKi/0O
         GBf3DvBVC1nEqZiw054/fCBFQ6MTauO4hdIapABvwwt11YgVVTprAtXjAJ5lYyStazgA
         KZDuW24vDRzNhFBzCHG6SY6v+PU1H9/AQE2J5jlbV2D4bbA3K4vzSRZNFLlRmFNhCUkB
         9ZEOjz1qc20ybo2qZ8XuHWDEdEmoHbGU1maPRb/Uuw9MjD69ow+W0N9Cl1x/zeOejFYO
         XOz698qtGoTuP4a5pXhah0pUe8EAJmk+wilnBR2fY5lI4kpucxDFB42JghvoxNCv4GP0
         H7xw==
X-Gm-Message-State: ACrzQf0jN/EkO2Ch4TuZJBcXCUXIuJLp+I9+mIoYSjVGMBJoaRYF/bVa
        w1uNqDqnREY3GDnk23yLMtOA+Q==
X-Google-Smtp-Source: AMsMyM7uREf6rExESlC9UOz0czMJ3vqna+akFJyuGIrevbbq1rAo01SAxEamvT9aPhybE8cjhGavpQ==
X-Received: by 2002:a17:90b:4f8d:b0:202:dd39:c03a with SMTP id qe13-20020a17090b4f8d00b00202dd39c03amr11917187pjb.71.1663260522760;
        Thu, 15 Sep 2022 09:48:42 -0700 (PDT)
Received: from sarthakkukreti-glaptop.hsd1.ca.comcast.net ([2601:647:4200:b5b0:3af2:34b2:a98a:a652])
        by smtp.gmail.com with ESMTPSA id o4-20020a170902bcc400b00177ee563b6dsm13174970pls.33.2022.09.15.09.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 09:48:41 -0700 (PDT)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
X-Google-Original-From: Sarthak Kukreti <sarthakkukreti@google.com>
To:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        Evan Green <evgreen@google.com>,
        Gwendal Grignou <gwendal@google.com>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>
Subject: [PATCH RFC 2/8] dm: Add support for block provisioning
Date:   Thu, 15 Sep 2022 09:48:20 -0700
Message-Id: <20220915164826.1396245-3-sarthakkukreti@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220915164826.1396245-1-sarthakkukreti@google.com>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Sarthak Kukreti <sarthakkukreti@chromium.org>

Add support to dm devices for REQ_OP_PROVISION. The default mode
is to pass through the request and dm-thin will utilize it to provision
blocks.

Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
---
 drivers/md/dm-crypt.c         |  4 +-
 drivers/md/dm-linear.c        |  1 +
 drivers/md/dm-table.c         | 17 +++++++
 drivers/md/dm-thin.c          | 86 +++++++++++++++++++++++++++++++++--
 drivers/md/dm.c               |  4 ++
 include/linux/device-mapper.h |  6 +++
 6 files changed, 113 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 159c6806c19b..357f0899cfb6 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -3081,6 +3081,8 @@ static int crypt_ctr_optional(struct dm_target *ti, unsigned int argc, char **ar
 	if (ret)
 		return ret;
 
+	ti->num_provision_bios = 1;
+
 	while (opt_params--) {
 		opt_string = dm_shift_arg(&as);
 		if (!opt_string) {
@@ -3384,7 +3386,7 @@ static int crypt_map(struct dm_target *ti, struct bio *bio)
 	 * - for REQ_OP_DISCARD caller must use flush if IO ordering matters
 	 */
 	if (unlikely(bio->bi_opf & REQ_PREFLUSH ||
-	    bio_op(bio) == REQ_OP_DISCARD)) {
+	    bio_op(bio) == REQ_OP_DISCARD || bio_op(bio) == REQ_OP_PROVISION)) {
 		bio_set_dev(bio, cc->dev->bdev);
 		if (bio_sectors(bio))
 			bio->bi_iter.bi_sector = cc->start +
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 3212ef6aa81b..1aa782149428 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -61,6 +61,7 @@ static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	ti->num_discard_bios = 1;
 	ti->num_secure_erase_bios = 1;
 	ti->num_write_zeroes_bios = 1;
+	ti->num_provision_bios = 1;
 	ti->private = lc;
 	return 0;
 
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 332f96b58252..b7f9cb66b7ba 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1853,6 +1853,18 @@ static bool dm_table_supports_write_zeroes(struct dm_table *t)
 	return true;
 }
 
+static bool dm_table_supports_provision(struct dm_table *t)
+{
+	for (unsigned int i = 0; i < t->num_targets; i++) {
+		struct dm_target *ti = dm_table_get_target(t, i);
+
+		if (ti->num_provision_bios)
+			return true;
+	}
+
+	return false;
+}
+
 static int device_not_nowait_capable(struct dm_target *ti, struct dm_dev *dev,
 				     sector_t start, sector_t len, void *data)
 {
@@ -1989,6 +2001,11 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 	if (!dm_table_supports_write_zeroes(t))
 		q->limits.max_write_zeroes_sectors = 0;
 
+	if (dm_table_supports_provision(t))
+		blk_queue_max_provision_sectors(q, UINT_MAX >> 9);
+	else
+		q->limits.max_provision_sectors = 0;
+
 	dm_table_verify_integrity(t);
 
 	/*
diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index e76c96c760a9..fd3eb306c823 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -908,7 +908,8 @@ static void __inc_remap_and_issue_cell(void *context,
 	struct bio *bio;
 
 	while ((bio = bio_list_pop(&cell->bios))) {
-		if (op_is_flush(bio->bi_opf) || bio_op(bio) == REQ_OP_DISCARD)
+		if (op_is_flush(bio->bi_opf) || bio_op(bio) == REQ_OP_DISCARD ||
+		    bio_op(bio) == REQ_OP_PROVISION)
 			bio_list_add(&info->defer_bios, bio);
 		else {
 			inc_all_io_entry(info->tc->pool, bio);
@@ -1012,6 +1013,9 @@ static void process_prepared_mapping(struct dm_thin_new_mapping *m)
 		goto out;
 	}
 
+	if (bio && bio_op(bio) == REQ_OP_PROVISION)
+		return;
+
 	/*
 	 * Release any bios held while the block was being provisioned.
 	 * If we are processing a write bio that completely covers the block,
@@ -1388,6 +1392,9 @@ static void schedule_zero(struct thin_c *tc, dm_block_t virt_block,
 	m->data_block = data_block;
 	m->cell = cell;
 
+	if (bio && bio_op(bio) == REQ_OP_PROVISION)
+		m->bio = bio;
+
 	/*
 	 * If the whole block of data is being overwritten or we are not
 	 * zeroing pre-existing data, we can issue the bio immediately.
@@ -1897,7 +1904,7 @@ static void provision_block(struct thin_c *tc, struct bio *bio, dm_block_t block
 	/*
 	 * Fill read bios with zeroes and complete them immediately.
 	 */
-	if (bio_data_dir(bio) == READ) {
+	if (bio_data_dir(bio) == READ && bio_op(bio) != REQ_OP_PROVISION) {
 		zero_fill_bio(bio);
 		cell_defer_no_holder(tc, cell);
 		bio_endio(bio);
@@ -1980,6 +1987,69 @@ static void process_cell(struct thin_c *tc, struct dm_bio_prison_cell *cell)
 	}
 }
 
+static void process_provision_cell(struct thin_c *tc, struct dm_bio_prison_cell *cell)
+{
+	int r;
+	struct pool *pool = tc->pool;
+	struct bio *bio = cell->holder;
+	dm_block_t begin, end;
+	struct dm_thin_lookup_result lookup_result;
+
+	if (tc->requeue_mode) {
+		cell_requeue(pool, cell);
+		return;
+	}
+
+	get_bio_block_range(tc, bio, &begin, &end);
+
+	while (begin != end) {
+		r = ensure_next_mapping(pool);
+		if (r)
+			/* we did our best */
+			return;
+
+		r = dm_thin_find_block(tc->td, begin, 1, &lookup_result);
+		switch (r) {
+		case 0:
+			begin++;
+			break;
+		case -ENODATA:
+			provision_block(tc, bio, begin, cell);
+			begin++;
+			break;
+		default:
+			DMERR_LIMIT(
+				"%s: dm_thin_find_block() failed: error = %d",
+				__func__, r);
+			cell_defer_no_holder(tc, cell);
+			bio_io_error(bio);
+			begin++;
+			break;
+		}
+	}
+	bio_endio(bio);
+	cell_defer_no_holder(tc, cell);
+}
+
+static void process_provision_bio(struct thin_c *tc, struct bio *bio)
+{
+	dm_block_t begin, end;
+	struct dm_cell_key virt_key;
+	struct dm_bio_prison_cell *virt_cell;
+
+	get_bio_block_range(tc, bio, &begin, &end);
+	if (begin == end) {
+		bio_endio(bio);
+		return;
+	}
+
+	build_key(tc->td, VIRTUAL, begin, end, &virt_key);
+	if (bio_detain(tc->pool, &virt_key, bio, &virt_cell))
+		return;
+
+	process_provision_cell(tc, virt_cell);
+}
+
 static void process_bio(struct thin_c *tc, struct bio *bio)
 {
 	struct pool *pool = tc->pool;
@@ -2024,7 +2094,7 @@ static void __process_bio_read_only(struct thin_c *tc, struct bio *bio,
 	case -ENODATA:
 		if (cell)
 			cell_defer_no_holder(tc, cell);
-		if (rw != READ) {
+		if (rw != READ || bio_op(bio) == REQ_OP_PROVISION) {
 			handle_unserviceable_bio(tc->pool, bio);
 			break;
 		}
@@ -2200,6 +2270,8 @@ static void process_thin_deferred_bios(struct thin_c *tc)
 
 		if (bio_op(bio) == REQ_OP_DISCARD)
 			pool->process_discard(tc, bio);
+		else if (bio_op(bio) == REQ_OP_PROVISION)
+			process_provision_bio(tc, bio);
 		else
 			pool->process_bio(tc, bio);
 
@@ -2716,7 +2788,8 @@ static int thin_bio_map(struct dm_target *ti, struct bio *bio)
 		return DM_MAPIO_SUBMITTED;
 	}
 
-	if (op_is_flush(bio->bi_opf) || bio_op(bio) == REQ_OP_DISCARD) {
+	if (op_is_flush(bio->bi_opf) || bio_op(bio) == REQ_OP_DISCARD ||
+	    bio_op(bio) == REQ_OP_PROVISION) {
 		thin_defer_bio_with_throttle(tc, bio);
 		return DM_MAPIO_SUBMITTED;
 	}
@@ -3353,6 +3426,7 @@ static int pool_ctr(struct dm_target *ti, unsigned argc, char **argv)
 	pt->low_water_blocks = low_water_blocks;
 	pt->adjusted_pf = pt->requested_pf = pf;
 	ti->num_flush_bios = 1;
+	ti->num_provision_bios = 1;
 
 	/*
 	 * Only need to enable discards if the pool should pass
@@ -4043,6 +4117,7 @@ static void pool_io_hints(struct dm_target *ti, struct queue_limits *limits)
 		blk_limits_io_opt(limits, pool->sectors_per_block << SECTOR_SHIFT);
 	}
 
+
 	/*
 	 * pt->adjusted_pf is a staging area for the actual features to use.
 	 * They get transferred to the live pool in bind_control_target()
@@ -4233,6 +4308,8 @@ static int thin_ctr(struct dm_target *ti, unsigned argc, char **argv)
 		ti->num_discard_bios = 1;
 	}
 
+	ti->num_provision_bios = 1;
+
 	mutex_unlock(&dm_thin_pool_table.mutex);
 
 	spin_lock_irq(&tc->pool->lock);
@@ -4447,6 +4524,7 @@ static void thin_io_hints(struct dm_target *ti, struct queue_limits *limits)
 
 	limits->discard_granularity = pool->sectors_per_block << SECTOR_SHIFT;
 	limits->max_discard_sectors = 2048 * 1024 * 16; /* 16G */
+	limits->max_provision_sectors = 2048 * 1024 * 16; /* 16G */
 }
 
 static struct target_type thin_target = {
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 60549b65c799..3fe524800f5a 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1600,6 +1600,7 @@ static bool is_abnormal_io(struct bio *bio)
 		case REQ_OP_DISCARD:
 		case REQ_OP_SECURE_ERASE:
 		case REQ_OP_WRITE_ZEROES:
+		case REQ_OP_PROVISION:
 			return true;
 		default:
 			break;
@@ -1624,6 +1625,9 @@ static blk_status_t __process_abnormal_io(struct clone_info *ci,
 	case REQ_OP_WRITE_ZEROES:
 		num_bios = ti->num_write_zeroes_bios;
 		break;
+	case REQ_OP_PROVISION:
+		num_bios = ti->num_provision_bios;
+		break;
 	default:
 		break;
 	}
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 04c6acf7faaa..edeb47195b6f 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -333,6 +333,12 @@ struct dm_target {
 	 */
 	unsigned num_write_zeroes_bios;
 
+	/*
+	 * The number of PROVISION bios that will be submitted to the target.
+	 * The bio number can be accessed with dm_bio_get_target_bio_nr.
+	 */
+	unsigned num_provision_bios;
+
 	/*
 	 * The minimum number of extra bytes allocated in each io for the
 	 * target to use.
-- 
2.31.0

