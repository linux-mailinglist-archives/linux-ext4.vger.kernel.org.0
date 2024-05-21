Return-Path: <linux-ext4+bounces-2615-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D9B8CA56F
	for <lists+linux-ext4@lfdr.de>; Tue, 21 May 2024 02:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8F11F2265B
	for <lists+linux-ext4@lfdr.de>; Tue, 21 May 2024 00:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248BA8BF8;
	Tue, 21 May 2024 00:45:33 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115573D68
	for <linux-ext4@vger.kernel.org>; Tue, 21 May 2024 00:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716252332; cv=none; b=j52fywpbSFgvkP/piuAzdrK9y8tQVketjm8SjU725dTM0WFoDZaEDqfS7OJZ1jPPNCg3YHy7k62cZig580StzzbvM9YkZysm5z8OOLCoFo2HIpqx9sUZ8M+mO2+hvm3t2AmkL7TURqDGOHNvYJRqzh6peOyhndF+RQ5AXKUpYhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716252332; c=relaxed/simple;
	bh=M3IGua52fbiYvVXmDO9/O5jfEFfSwxKvM3kbq6LZ/ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWMJZPYMuD/NBzZiHYVh71PSgmWE/wUqrUvzlYhFKq3pctUvUIRbFlIZixk1uCV2e5Fgbsvx6b1DbHf0IQMVo2hhthkyQ5eYy511+bZpknDsGkUr/zxvDMd7jnT9L5ZwddhoIwRU8ORSVERF8EPmUN+k7RFu/F5scv2hzJDzf/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c99e6b8b1fso2372502b6e.1
        for <linux-ext4@vger.kernel.org>; Mon, 20 May 2024 17:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716252330; x=1716857130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAQ7EZw2gT8mUoiA62o4QOdC/XHNNwGQwfkkzt04Rds=;
        b=n3NmtxVIPnBLHaNfsEoclzZ8w/m3sogc1MHWBdJc3H03bAouzC3DPli6UyN91bjB7S
         q6T92Y0ubQ9x3Ej3NPPHyjfoBc9+ZXhohpdqPi8p8Vnr8RsSJWLIyrxO2dWt2TN2esu1
         QKagw5806hP7Y/j5C+M/Unl4GgLX/BePTryGu0nMch5QVvTD/4ndObmBRttDJ8Jr995i
         bmkXL4pWpCPEFt9LkjH1KKFHq+Z0Iq9mQKWFaOOAeJ86vxk6QseYeGLY4BnKVk/+NtGN
         BeXSfyYRSjrj5I9PsgjMTvLdF8LOOmtM7BlS8jfUE/KivRbCwJqTRliFyn6R+syJxqZx
         Px3A==
X-Forwarded-Encrypted: i=1; AJvYcCVyw2+AIqhmS2l4w188imCjSThQE3YavneMnSFIWTpTMbVj0bkX5zrVTiYB8vI1hM3GB3tNE3DOl1fxE9kF0b3KsGx7NCdQOeKOvA==
X-Gm-Message-State: AOJu0YyvHpOWOMNJro2pUCsT5CA2OM3KrHi4T6W+OuSLTufZqIFJR/M4
	l7VjLnlwkWLG8QRASQ8hJnOIS2LmSmqd1GxuV5GADg/pevb2NjxcGBqM7S3LwOB565615/Fa9l1
	gZRUIKA==
X-Google-Smtp-Source: AGHT+IGMn6xjydCtb38kyKvLjZDgFdGue2uUOR537cPk5ZgFt4ChObkqOmoaYUFS+4P+IGBFARHGTQ==
X-Received: by 2002:a05:6808:18a8:b0:3c9:c3ad:53b9 with SMTP id 5614622812f47-3c9c3ad58ddmr21150431b6e.26.1716252330121;
        Mon, 20 May 2024 17:45:30 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2757b5sm1237989085a.17.2024.05.20.17.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 17:45:29 -0700 (PDT)
Date: Mon, 20 May 2024 20:45:28 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Theodore Ts'o <tytso@mit.edu>
Cc: dm-devel@lists.linux.dev, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, regressions@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: Re: dm: use queue_limits_set
Message-ID: <ZkvuqNXaNOMe6Gfj@kernel.org>
References: <20240518022646.GA450709@mit.edu>
 <ZkmIpCRaZE0237OH@kernel.org>
 <ZkmRKPfPeX3c138f@kernel.org>
 <20240520150653.GA32461@lst.de>
 <ZktuojMrQWH9MQJO@kernel.org>
 <20240520154425.GB1104@lst.de>
 <ZktyTYKySaauFcQT@kernel.org>
 <ZkuFuqo3dNw8bOA2@kernel.org>
 <20240520201237.GA6235@lst.de>
 <ZkvIn73jAqz94LjI@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkvIn73jAqz94LjI@kernel.org>

On Mon, May 20, 2024 at 06:03:11PM -0400, Mike Snitzer wrote:
> On Mon, May 20, 2024 at 10:12:37PM +0200, Christoph Hellwig wrote:
> > On Mon, May 20, 2024 at 01:17:46PM -0400, Mike Snitzer wrote:
> > > Doubt there was anything in fstests setting max discard user limit
> > > (max_user_discard_sectors) in Ted's case. blk_set_stacking_limits()
> > > sets max_user_discard_sectors to UINT_MAX, so given the use of
> > > min(lim->max_hw_discard_sectors, lim->max_user_discard_sectors) I
> > > suspect blk_stack_limits() stacks up max_discard_sectors to match the
> > > underlying storage's max_hw_discard_sectors.
> > > 
> > > And max_hw_discard_sectors exceeds BIO_PRISON_MAX_RANGE, resulting in
> > > dm_cell_key_has_valid_range() triggering on:
> > > WARN_ON_ONCE(key->block_end - key->block_begin > BIO_PRISON_MAX_RANGE)
> > 
> > Oh, that makes more sense.
> > 
> > I think you just want to set the max_hw_discard_sectors limit before
> > stacking in the lower device limits so that they can only lower it.
> > 
> > (and in the long run we should just stop stacking the limits except
> > for request based dm which really needs it)
> 
> This is what I staged, I cannot send a patch out right now.. 
> 
> Ted if you need the patch in email (rather than from linux-dm.git) I
> can send it later tonight.  Please see:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-6.10&id=825d8bbd2f32cb229c3b6653bd454832c3c20acb

From: Mike Snitzer <snitzer@kernel.org>
Date: Mon, 20 May 2024 13:34:06 -0400
Subject: [PATCH] dm: always manage discard support in terms of max_hw_discard_sectors

Commit 4f563a64732d ("block: add a max_user_discard_sectors queue
limit") changed block core to set max_discard_sectors to:
 min(lim->max_hw_discard_sectors, lim->max_user_discard_sectors)

Since commit 1c0e720228ad ("dm: use queue_limits_set") it was reported
dm-thinp was failing in a few fstests (generic/347 and generic/405)
with the first WARN_ON_ONCE in dm_cell_key_has_valid_range() being
reported, e.g.:
WARNING: CPU: 1 PID: 30 at drivers/md/dm-bio-prison-v1.c:128 dm_cell_key_has_valid_range+0x3d/0x50

blk_set_stacking_limits() sets max_user_discard_sectors to UINT_MAX,
so given how block core now sets max_discard_sectors (detailed above)
it follows that blk_stack_limits() stacks up the underlying device's
max_hw_discard_sectors and max_discard_sectors is set to match it. If
max_hw_discard_sectors exceeds dm's BIO_PRISON_MAX_RANGE, then
dm_cell_key_has_valid_range() will trigger the warning with:
WARN_ON_ONCE(key->block_end - key->block_begin > BIO_PRISON_MAX_RANGE)

Aside from this warning, the discard will fail.  Fix this and other DM
issues by governing discard support in terms of max_hw_discard_sectors
instead of max_discard_sectors.

Reported-by: Theodore Ts'o <tytso@mit.edu>
Fixes: 1c0e720228ad ("dm: use queue_limits_set")
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-cache-target.c | 5 ++---
 drivers/md/dm-clone-target.c | 4 ++--
 drivers/md/dm-log-writes.c   | 2 +-
 drivers/md/dm-snap.c         | 2 +-
 drivers/md/dm-target.c       | 1 -
 drivers/md/dm-thin.c         | 4 ++--
 drivers/md/dm-zero.c         | 1 -
 drivers/md/dm-zoned-target.c | 1 -
 drivers/md/dm.c              | 2 +-
 9 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 911f73f7ebba..1f0bc1173230 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -3394,8 +3394,8 @@ static void set_discard_limits(struct cache *cache, struct queue_limits *limits)
 
 	if (!cache->features.discard_passdown) {
 		/* No passdown is done so setting own virtual limits */
-		limits->max_discard_sectors = min_t(sector_t, cache->discard_block_size * 1024,
-						    cache->origin_sectors);
+		limits->max_hw_discard_sectors = min_t(sector_t, cache->discard_block_size * 1024,
+						       cache->origin_sectors);
 		limits->discard_granularity = cache->discard_block_size << SECTOR_SHIFT;
 		return;
 	}
@@ -3404,7 +3404,6 @@ static void set_discard_limits(struct cache *cache, struct queue_limits *limits)
 	 * cache_iterate_devices() is stacking both origin and fast device limits
 	 * but discards aren't passed to fast device, so inherit origin's limits.
 	 */
-	limits->max_discard_sectors = origin_limits->max_discard_sectors;
 	limits->max_hw_discard_sectors = origin_limits->max_hw_discard_sectors;
 	limits->discard_granularity = origin_limits->discard_granularity;
 	limits->discard_alignment = origin_limits->discard_alignment;
diff --git a/drivers/md/dm-clone-target.c b/drivers/md/dm-clone-target.c
index 94b2fc33f64b..2332d9798141 100644
--- a/drivers/md/dm-clone-target.c
+++ b/drivers/md/dm-clone-target.c
@@ -2050,7 +2050,8 @@ static void set_discard_limits(struct clone *clone, struct queue_limits *limits)
 	if (!test_bit(DM_CLONE_DISCARD_PASSDOWN, &clone->flags)) {
 		/* No passdown is done so we set our own virtual limits */
 		limits->discard_granularity = clone->region_size << SECTOR_SHIFT;
-		limits->max_discard_sectors = round_down(UINT_MAX >> SECTOR_SHIFT, clone->region_size);
+		limits->max_hw_discard_sectors = round_down(UINT_MAX >> SECTOR_SHIFT,
+							    clone->region_size);
 		return;
 	}
 
@@ -2059,7 +2060,6 @@ static void set_discard_limits(struct clone *clone, struct queue_limits *limits)
 	 * device limits but discards aren't passed to the source device, so
 	 * inherit destination's limits.
 	 */
-	limits->max_discard_sectors = dest_limits->max_discard_sectors;
 	limits->max_hw_discard_sectors = dest_limits->max_hw_discard_sectors;
 	limits->discard_granularity = dest_limits->discard_granularity;
 	limits->discard_alignment = dest_limits->discard_alignment;
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index f17a6cf2284e..8d7df8303d0a 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -871,7 +871,7 @@ static void log_writes_io_hints(struct dm_target *ti, struct queue_limits *limit
 	if (!bdev_max_discard_sectors(lc->dev->bdev)) {
 		lc->device_supports_discard = false;
 		limits->discard_granularity = lc->sectorsize;
-		limits->max_discard_sectors = (UINT_MAX >> SECTOR_SHIFT);
+		limits->max_hw_discard_sectors = (UINT_MAX >> SECTOR_SHIFT);
 	}
 	limits->logical_block_size = bdev_logical_block_size(lc->dev->bdev);
 	limits->physical_block_size = bdev_physical_block_size(lc->dev->bdev);
diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index 0ace06d1bee3..f40c18da4000 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -2410,7 +2410,7 @@ static void snapshot_io_hints(struct dm_target *ti, struct queue_limits *limits)
 
 		/* All discards are split on chunk_size boundary */
 		limits->discard_granularity = snap->store->chunk_size;
-		limits->max_discard_sectors = snap->store->chunk_size;
+		limits->max_hw_discard_sectors = snap->store->chunk_size;
 
 		up_read(&_origins_lock);
 	}
diff --git a/drivers/md/dm-target.c b/drivers/md/dm-target.c
index 0c4efb0bef8a..652627aea11b 100644
--- a/drivers/md/dm-target.c
+++ b/drivers/md/dm-target.c
@@ -249,7 +249,6 @@ static int io_err_iterate_devices(struct dm_target *ti,
 
 static void io_err_io_hints(struct dm_target *ti, struct queue_limits *limits)
 {
-	limits->max_discard_sectors = UINT_MAX;
 	limits->max_hw_discard_sectors = UINT_MAX;
 	limits->discard_granularity = 512;
 }
diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 4793ad2aa1f7..e0528a4f809c 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -4100,7 +4100,7 @@ static void pool_io_hints(struct dm_target *ti, struct queue_limits *limits)
 	if (pt->adjusted_pf.discard_enabled) {
 		disable_discard_passdown_if_not_supported(pt);
 		if (!pt->adjusted_pf.discard_passdown)
-			limits->max_discard_sectors = 0;
+			limits->max_hw_discard_sectors = 0;
 		/*
 		 * The pool uses the same discard limits as the underlying data
 		 * device.  DM core has already set this up.
@@ -4497,7 +4497,7 @@ static void thin_io_hints(struct dm_target *ti, struct queue_limits *limits)
 
 	if (pool->pf.discard_enabled) {
 		limits->discard_granularity = pool->sectors_per_block << SECTOR_SHIFT;
-		limits->max_discard_sectors = pool->sectors_per_block * BIO_PRISON_MAX_RANGE;
+		limits->max_hw_discard_sectors = pool->sectors_per_block * BIO_PRISON_MAX_RANGE;
 	}
 }
 
diff --git a/drivers/md/dm-zero.c b/drivers/md/dm-zero.c
index 3b13e6eb1aa4..9a0bb623e823 100644
--- a/drivers/md/dm-zero.c
+++ b/drivers/md/dm-zero.c
@@ -61,7 +61,6 @@ static int zero_map(struct dm_target *ti, struct bio *bio)
 
 static void zero_io_hints(struct dm_target *ti, struct queue_limits *limits)
 {
-	limits->max_discard_sectors = UINT_MAX;
 	limits->max_hw_discard_sectors = UINT_MAX;
 	limits->discard_granularity = 512;
 }
diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
index 621794a9edd6..12236e6f46f3 100644
--- a/drivers/md/dm-zoned-target.c
+++ b/drivers/md/dm-zoned-target.c
@@ -1001,7 +1001,6 @@ static void dmz_io_hints(struct dm_target *ti, struct queue_limits *limits)
 
 	limits->discard_alignment = 0;
 	limits->discard_granularity = DMZ_BLOCK_SIZE;
-	limits->max_discard_sectors = chunk_sectors;
 	limits->max_hw_discard_sectors = chunk_sectors;
 	limits->max_write_zeroes_sectors = chunk_sectors;
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 7d0746b37c8e..3adfc6b83c01 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1086,7 +1086,7 @@ void disable_discard(struct mapped_device *md)
 	struct queue_limits *limits = dm_get_queue_limits(md);
 
 	/* device doesn't really support DISCARD, disable it */
-	limits->max_discard_sectors = 0;
+	limits->max_hw_discard_sectors = 0;
 }
 
 void disable_write_zeroes(struct mapped_device *md)
-- 
2.44.0


