Return-Path: <linux-ext4+bounces-11864-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DD8C5C4D8
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Nov 2025 10:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99945500967
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Nov 2025 09:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B8F3081D2;
	Fri, 14 Nov 2025 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="h6fojIGy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A0D3074BC
	for <linux-ext4@vger.kernel.org>; Fri, 14 Nov 2025 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112152; cv=none; b=Z5TbFb+KbNhIl8QWZNjR6MbtiFn5w79+v7flk7bHT2PmcboFH5nhDJba5FGqXOnmgGEQB4r8EyKf1LL09Tk9qdNFEw8sdQxu/zaIKLzi9j6cVpWtoZ3LWXosGZlnQrQNLct4eim/WGgG78c+3WZkAeen+RljxnHwmdySqWnFkjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112152; c=relaxed/simple;
	bh=UIab7wtwL7MJOqUh9OsFCLgRkvtJ87T6L6S86OEG8/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IR77KP5gq81fsiFCY8+XS0wRTpINniQmy6/TTa8rNE31X0AakcJtEkqvYnze8Ehhm6s9SfdXXqt92XEVF/ir5zQKhCmi7QvYuH75xHWKKGd6CHxoDsCK2/2BQNkj1EyWk1AORxcMl02gzkydgsFEd8UjaEyK1fV8/qNyAqHdkTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=h6fojIGy; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2958db8ae4fso17395735ad.2
        for <linux-ext4@vger.kernel.org>; Fri, 14 Nov 2025 01:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1763112150; x=1763716950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuX17fCzmjSlKD2oTV0BAVWCX3GMVQ03UEsOj2aXO/w=;
        b=h6fojIGym1MMNKbJRIEDjGtNAPDQ2j1OghWgSnZEzYaWtO4DGTWcizz33YWHJQoDA6
         mH2mNbY1SEWYykiLBC/8l1JW9NVbY6uca56/EnWLhVjSvXjNXZ/EK54PjSIG78+v7uN6
         rA/IQPg6xou2bxRZzeHsxdd6UePdam1uPREkOGjPQ1MVT8DOMBD2b7WHYgGzUESpghQB
         4ASIxx6kPC3ovxKFie51S/IMGRjismQY/aJAx7QWSQfKkR6CuCK15wbnD9mUijpBnlLs
         kw5vdS3MFxBWGw3wyL3kajwzX9zYWUYwZKaxRYT2tRcX/OLlelxp1Au8hjAbrUGmT2i4
         1nKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763112150; x=1763716950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QuX17fCzmjSlKD2oTV0BAVWCX3GMVQ03UEsOj2aXO/w=;
        b=WAMG1otR9znxNnXPLrkaLT+VkhM/jLVQVmXvH4WAm9ReR7NlVhw5C3eH2n51L0kZ2h
         9st29EunfWncbBvt05YTZMp98n597cI1A8cxDujHEuii7NDTJ3xSE1V8WyR9Rv4rW9VS
         0/ZvF4bmJVt/KHHaTD8eh8Rg47Vx1v5371UUXuivpq44gcoIgws5CE5zVwp4sPSbletY
         eAv1TLV5ueZQ0VBiOc2454a9fwgwATwO7tKV4PYfGLqmuUC/75YYQ1sO5zJ1zw29PCjF
         CF05tNhIcr+v0Y1te82Y7EwSxrtBp642H7N1ND81lHSmHbsKjx2NXiG2XKKFRv/SJEzo
         0M5A==
X-Forwarded-Encrypted: i=1; AJvYcCWRiCIe9ezjukRD8gO7i38/Y2XLnOBOyAenc7S+UKljpNcLc1z82PgpnT5aDI+/H+j8h/oMT832QT0l@vger.kernel.org
X-Gm-Message-State: AOJu0YwkDajfP0GSjxRDWxi+4ZRwbOBaHr5pwXb1XDfoue9N+WS/uuIh
	x+nMjCmsvp1ISBynNIn7/Khmfiv6atuj3298xfdIh5rh49nIhuRHRWkU89TzqHcqf7w=
X-Gm-Gg: ASbGncs6Jm0Zg9/FP/Ge9exIm204rUXYOcL4qydlIIzJ6sIY7m7wU7w7Hjun6sgiHZb
	+xB3eOlW5jUhn24JwhwqSqf4/7UlWb3nikq7rJ9fzNvgudiJVsO7ZGNvHYnywA78j9RrmPfkE3s
	OmBSod0NW/QZcf/1RBLLLsXdxrakOfL3Nvxe/Dx9gnSzZVKmetD6MIRogf400xQMF7VrxwPEoQh
	YkX5yMU74/KKdypwKeC+7Gq/LDDCvX3jMlCTKK6rTuaF6DnBkU2MaLejyEE1Bqa4fTPI5R2R7oP
	ATtnS8/ncnHsDaiy9mTKv2NFNzXACYO8L01+xC6v8Nb6o4M5jw2xFMTQa3xmbxEX+11fxMllUBs
	r/N67In9E6qgw0Ehq6zh1M9HaxBlW2l+Yre2Wu3W4JL2LejfeIK8JtT0EuMfSRV8+GB596BxK7b
	lQ+lKphll9nYaZ1B7hlH6CgUiuZ6ihRVM4XQ==
X-Google-Smtp-Source: AGHT+IE5EpOKhzEVc2rBcafP7dwFxgYiV1vDTAUPbL2qqYMIRb4HDnxBwlI0YiLG3+RKWslwz123UA==
X-Received: by 2002:a17:903:380b:b0:297:dd7f:f1e0 with SMTP id d9443c01a7336-2986a751eb6mr23592765ad.43.1763112149863;
        Fri, 14 Nov 2025 01:22:29 -0800 (PST)
Received: from localhost.localdomain ([203.208.167.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0fe9sm48725735ad.65.2025.11.14.01.22.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Nov 2025 01:22:29 -0800 (PST)
From: Fengnan Chang <changfengnan@bytedance.com>
To: axboe@kernel.dk,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	asml.silence@gmail.com,
	willy@infradead.org,
	djwong@kernel.org,
	hch@infradead.org,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org,
	ming.lei@redhat.com,
	linux-nvme@lists.infradead.org
Cc: Fengnan Chang <changfengnan@bytedance.com>
Subject: [PATCH v3 2/2] block: enable per-cpu bio cache by default
Date: Fri, 14 Nov 2025 17:21:49 +0800
Message-Id: <20251114092149.40116-3-changfengnan@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251114092149.40116-1-changfengnan@bytedance.com>
References: <20251114092149.40116-1-changfengnan@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since after commit 12e4e8c7ab59 ("io_uring/rw: enable bio caches for
IRQ rw"), bio_put is safe for task and irq context, bio_alloc_bioset is
safe for task context and no one calls in irq context, so we can enable
per cpu bio cache by default.

Benchmarked with t/io_uring and ext4+nvme:
taskset -c 6 /root/fio/t/io_uring  -p0 -d128 -b4096 -s1 -c1 -F1 -B1 -R1
-X1 -n1 -P1  /mnt/testfile
base IOPS is 562K, patch IOPS is 574K. The CPU usage of bio_alloc_bioset
decrease from 1.42% to 1.22%.

The worst case is allocate bio in CPU A but free in CPU B, still use
t/io_uring and ext4+nvme:
base IOPS is 648K, patch IOPS is 647K.

Also use fio test ext4/xfs with libaio/sync/io_uring on null_blk and
nvme, no obvious performance regression.

Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
---
 block/bio.c        | 26 ++++++++++++--------------
 block/fops.c       |  4 ----
 include/linux/fs.h |  3 ---
 io_uring/rw.c      |  1 -
 4 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index b3a79285c278..64a1599a5930 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -516,20 +516,18 @@ struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
 	if (WARN_ON_ONCE(!mempool_initialized(&bs->bvec_pool) && nr_vecs > 0))
 		return NULL;
 
-	if (opf & REQ_ALLOC_CACHE) {
-		if (bs->cache && nr_vecs <= BIO_INLINE_VECS) {
-			bio = bio_alloc_percpu_cache(bdev, nr_vecs, opf,
-						     gfp_mask, bs);
-			if (bio)
-				return bio;
-			/*
-			 * No cached bio available, bio returned below marked with
-			 * REQ_ALLOC_CACHE to particpate in per-cpu alloc cache.
-			 */
-		} else {
-			opf &= ~REQ_ALLOC_CACHE;
-		}
-	}
+	if (bs->cache && nr_vecs <= BIO_INLINE_VECS) {
+		opf |= REQ_ALLOC_CACHE;
+		bio = bio_alloc_percpu_cache(bdev, nr_vecs, opf,
+					     gfp_mask, bs);
+		if (bio)
+			return bio;
+		/*
+		 * No cached bio available, bio returned below marked with
+		 * REQ_ALLOC_CACHE to participate in per-cpu alloc cache.
+		 */
+	} else
+		opf &= ~REQ_ALLOC_CACHE;
 
 	/*
 	 * submit_bio_noacct() converts recursion to iteration; this means if
diff --git a/block/fops.c b/block/fops.c
index 5e3db9fead77..7ef2848244b1 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -184,8 +184,6 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	loff_t pos = iocb->ki_pos;
 	int ret = 0;
 
-	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
-		opf |= REQ_ALLOC_CACHE;
 	bio = bio_alloc_bioset(bdev, nr_pages, opf, GFP_KERNEL,
 			       &blkdev_dio_pool);
 	dio = container_of(bio, struct blkdev_dio, bio);
@@ -333,8 +331,6 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	loff_t pos = iocb->ki_pos;
 	int ret = 0;
 
-	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
-		opf |= REQ_ALLOC_CACHE;
 	bio = bio_alloc_bioset(bdev, nr_pages, opf, GFP_KERNEL,
 			       &blkdev_dio_pool);
 	dio = container_of(bio, struct blkdev_dio, bio);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c895146c1444..1be899ac8b5a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -365,8 +365,6 @@ struct readahead_control;
 /* iocb->ki_waitq is valid */
 #define IOCB_WAITQ		(1 << 19)
 #define IOCB_NOIO		(1 << 20)
-/* can use bio alloc cache */
-#define IOCB_ALLOC_CACHE	(1 << 21)
 /*
  * IOCB_DIO_CALLER_COMP can be set by the iocb owner, to indicate that the
  * iocb completion can be passed back to the owner for execution from a safe
@@ -399,7 +397,6 @@ struct readahead_control;
 	{ IOCB_WRITE,		"WRITE" }, \
 	{ IOCB_WAITQ,		"WAITQ" }, \
 	{ IOCB_NOIO,		"NOIO" }, \
-	{ IOCB_ALLOC_CACHE,	"ALLOC_CACHE" }, \
 	{ IOCB_DIO_CALLER_COMP,	"CALLER_COMP" }, \
 	{ IOCB_AIO_RW,		"AIO_RW" }, \
 	{ IOCB_HAS_METADATA,	"AIO_HAS_METADATA" }
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 5b2241a5813c..c0c59eb358a8 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -862,7 +862,6 @@ static int io_rw_init_file(struct io_kiocb *req, fmode_t mode, int rw_type)
 	ret = kiocb_set_rw_flags(kiocb, rw->flags, rw_type);
 	if (unlikely(ret))
 		return ret;
-	kiocb->ki_flags |= IOCB_ALLOC_CACHE;
 
 	/*
 	 * If the file is marked O_NONBLOCK, still allow retry for it if it
-- 
2.39.5 (Apple Git-154)


