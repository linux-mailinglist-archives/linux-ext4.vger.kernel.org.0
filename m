Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E087686944
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Aug 2019 21:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390307AbfHHTDE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Aug 2019 15:03:04 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42663 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733248AbfHHTDE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Aug 2019 15:03:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id t132so44529952pgb.9
        for <linux-ext4@vger.kernel.org>; Thu, 08 Aug 2019 12:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=YaDw968sYZinLHwfTVtmoWadaU+xxvDOnKy5RkNnHhY=;
        b=HIQxeRJULmhNEAqcWiiIVZr0UAHZw/vMZ/YXLmvIkXIat0A1z75P9Q0d/P74XRw3do
         R7+ctJwPKZUsckjeTNvykCKZsWrBGUXA5z5ZhyRNBYXd8H4O6Fr/Cfh1Tgcp0VtQSpzQ
         sHkoTTEtlwzMapLsx/9XmEPsqlkUGcTTXFX0+zFyl6atF/lOxErRKyNsY876FIdy4kom
         iHrVYxjJMl+rUFyMB+98d2/kmsgt03t7E0C/Gw5ePaTD8Sis0vFdJXbU/8NWpzUYzFd/
         +GAdy2lZyujaVYVCBCBCH4QSjJMb3LYnJxKiTOIRpKMlA/KjrXwRHyDPiu3C/9kVghl3
         PqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=YaDw968sYZinLHwfTVtmoWadaU+xxvDOnKy5RkNnHhY=;
        b=l+QUhFhLnT97aSZMIJ8B/2ancU7TgYnQq3MaCGGgco0uxsLV6hoCsJ5H1ak/hUZqDf
         YNl91sQXlrmaYg0OjdNaKlDS6A26LDqvYRx1G3JFD54cJVA9OZWv3Y6zkcOcfSdeAHcR
         4cEBpfDPZtZ5BTZm0e0bvyHbsInMORdDAinyWpIwDogVReguZ42MGfW9Q8EIKnI8Z5oS
         xQtJk2yXGmAAMbJAA7lIoEz2VIrRl4Zz/Rq+5JPY0cCW2BRdlItv5LgS7+A24mabfr7r
         9C/MlRll4y0RAaKr8mRhtcP0GLUjgpOZZ4O8RsqQkK9xA884aOVa6KWo4tv6T2HosNG1
         Kshw==
X-Gm-Message-State: APjAAAXWIVXQP/+8LTuiSwlnZOVfyGxqrPhltEOPsjlK42lCy+L0h2Wy
        MUZFLUMVHaOqUqzMiTMAYh6z8Lcx1yo=
X-Google-Smtp-Source: APXvYqyauxFlil+jXyg34wXrmqepCBj1OqcfC1/2Gy4eTEI53he4OQNjlsbx5piBhi7v9zETXwpdnA==
X-Received: by 2002:a17:90a:8b98:: with SMTP id z24mr5545969pjn.77.1565290983429;
        Thu, 08 Aug 2019 12:03:03 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:e15f])
        by smtp.gmail.com with ESMTPSA id t6sm22068113pgu.23.2019.08.08.12.03.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 12:03:02 -0700 (PDT)
Date:   Thu, 8 Aug 2019 15:03:00 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Dave Chinner <david@fromorbit.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] block: annotate refault stalls from IO submission
Message-ID: <20190808190300.GA9067@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

psi tracks the time tasks wait for refaulting pages to become
uptodate, but it does not track the time spent submitting the IO. The
submission part can be significant if backing storage is contended or
when cgroup throttling (io.latency) is in effect - a lot of time is
spent in submit_bio(). In that case, we underreport memory pressure.

Annotate submit_bio() to account submission time as memory stall when
the bio is reading userspace workingset pages.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 block/bio.c               |  3 +++
 block/blk-core.c          | 23 ++++++++++++++++++++++-
 include/linux/blk_types.h |  1 +
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 299a0e7651ec..4196865dd300 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -806,6 +806,9 @@ void __bio_add_page(struct bio *bio, struct page *page,
 
 	bio->bi_iter.bi_size += len;
 	bio->bi_vcnt++;
+
+	if (!bio_flagged(bio, BIO_WORKINGSET) && unlikely(PageWorkingset(page)))
+		bio_set_flag(bio, BIO_WORKINGSET);
 }
 EXPORT_SYMBOL_GPL(__bio_add_page);
 
diff --git a/block/blk-core.c b/block/blk-core.c
index d0cc6e14d2f0..1b1705b7dde7 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -36,6 +36,7 @@
 #include <linux/blk-cgroup.h>
 #include <linux/debugfs.h>
 #include <linux/bpf.h>
+#include <linux/psi.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/block.h>
@@ -1128,6 +1129,10 @@ EXPORT_SYMBOL_GPL(direct_make_request);
  */
 blk_qc_t submit_bio(struct bio *bio)
 {
+	bool workingset_read = false;
+	unsigned long pflags;
+	blk_qc_t ret;
+
 	if (blkcg_punt_bio_submit(bio))
 		return BLK_QC_T_NONE;
 
@@ -1146,6 +1151,8 @@ blk_qc_t submit_bio(struct bio *bio)
 		if (op_is_write(bio_op(bio))) {
 			count_vm_events(PGPGOUT, count);
 		} else {
+			if (bio_flagged(bio, BIO_WORKINGSET))
+				workingset_read = true;
 			task_io_account_read(bio->bi_iter.bi_size);
 			count_vm_events(PGPGIN, count);
 		}
@@ -1160,7 +1167,21 @@ blk_qc_t submit_bio(struct bio *bio)
 		}
 	}
 
-	return generic_make_request(bio);
+	/*
+	 * If we're reading data that is part of the userspace
+	 * workingset, count submission time as memory stall. When the
+	 * device is congested, or the submitting cgroup IO-throttled,
+	 * submission can be a significant part of overall IO time.
+	 */
+	if (workingset_read)
+		psi_memstall_enter(&pflags);
+
+	ret = generic_make_request(bio);
+
+	if (workingset_read)
+		psi_memstall_leave(&pflags);
+
+	return ret;
 }
 EXPORT_SYMBOL(submit_bio);
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 1b1fa1557e68..a9dadfc16a92 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -209,6 +209,7 @@ enum {
 	BIO_BOUNCED,		/* bio is a bounce bio */
 	BIO_USER_MAPPED,	/* contains user pages */
 	BIO_NULL_MAPPED,	/* contains invalid user pages */
+	BIO_WORKINGSET,		/* contains userspace workingset pages */
 	BIO_QUIET,		/* Make BIO Quiet */
 	BIO_CHAIN,		/* chained bio, ->bi_remaining in effect */
 	BIO_REFFED,		/* bio has elevated ->bi_cnt */
-- 
2.22.0

