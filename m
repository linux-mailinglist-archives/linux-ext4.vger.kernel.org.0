Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE0626B3C9
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Sep 2020 01:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgIOXKV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Sep 2020 19:10:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52574 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727266AbgIOXKP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 15 Sep 2020 19:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600211403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uWKYiEAPj6B80xN73l3vGOeVXB3aKVd90dDHnSd2jCM=;
        b=EnnYxoOtkRnJ5NEBoXvulxlYlNnoyMgnNG4Dvsj0169VQWdKT92gds+jd22aV9T7//vUXY
        cV5zJREZ8GSsxzS5Iw6cWXjWnFE5OvA0PmxACGZfeHvia61hKH6xK6f33MbJqUM7gJASRj
        4MTiGQ/1pd7rmGsaAHaGsFyQh+AhkPw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-3dInkon8OGiQEyPC67N2Zg-1; Tue, 15 Sep 2020 19:09:59 -0400
X-MC-Unique: 3dInkon8OGiQEyPC67N2Zg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC2CB1074648;
        Tue, 15 Sep 2020 23:09:57 +0000 (UTC)
Received: from T590 (ovpn-12-18.pek2.redhat.com [10.72.12.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C10A60E1C;
        Tue, 15 Sep 2020 23:09:51 +0000 (UTC)
Date:   Wed, 16 Sep 2020 07:09:41 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ext4@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: REGRESSION: 37f4a24c2469: blk-mq: centralise related handling
 into blk_mq_get_driver_tag
Message-ID: <20200915230941.GA791425@T590>
References: <20200822143326.GC199705@mit.edu>
 <aff250ad-4c31-15c2-fa1d-3f3945cb7aa5@kernel.dk>
 <7f0e2d99-5da2-237e-a894-0afddc0ace1e@kernel.dk>
 <049a97db-c362-bcfb-59e5-4b1d2df59383@kernel.dk>
 <5140ba6c-779c-2a71-b7f2-3c3220cdf19c@kernel.dk>
 <68510957-c887-8e26-4a1a-a7a93488586a@kernel.dk>
 <20200904035528.GE558530@mit.edu>
 <20200915044519.GA38283@mit.edu>
 <20200915073303.GA754106@T590>
 <20200915224541.GB38283@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915224541.GB38283@mit.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 15, 2020 at 06:45:41PM -0400, Theodore Y. Ts'o wrote:
> On Tue, Sep 15, 2020 at 03:33:03PM +0800, Ming Lei wrote:
> > Hi Theodore,
> > 
> > On Tue, Sep 15, 2020 at 12:45:19AM -0400, Theodore Y. Ts'o wrote:
> > > On Thu, Sep 03, 2020 at 11:55:28PM -0400, Theodore Y. Ts'o wrote:
> > > > Worse, right now, -rc1 and -rc2 is causing random crashes in my
> > > > gce-xfstests framework.  Sometimes it happens before we've run even a
> > > > single xfstests; sometimes it happens after we have successfully
> > > > completed all of the tests, and we're doing a shutdown of the VM under
> > > > test.  Other times it happens in the middle of a test run.  Given that
> > > > I'm seeing this at -rc1, which is before my late ext4 pull request to
> > > > Linus, it's probably not an ext4 related bug.  But it also means that
> > > > I'm partially blind in terms of my kernel testing at the moment.  So I
> > > > can't even tell Linus that I've run lots of tests and I'm 100%
> > > > confident your one-line change is 100% safe.
> > > 
> > > I was finally able to bisect it down to the commit:
> > > 
> > > 37f4a24c2469: blk-mq: centralise related handling into blk_mq_get_driver_tag
> > 
> > 37f4a24c2469 has been reverted in:
> > 
> > 	4e2f62e566b5 Revert "blk-mq: put driver tag when this request is completed"
> > 
> > And later the patch is committed as the following after being fixed:
> > 
> > 	568f27006577 blk-mq: centralise related handling into blk_mq_get_driver_tag
> > 
> > So can you reproduce the issue by running kernel of commit 568f27006577?
> 
> Yes.  And things work fine if I try 4e2f62e566b5.
> 
> > If yes, can the issue be fixed by reverting 568f27006577?
> 
> The problem is it's a bit tricky to revert 568f27006577, since there
> is a merge conflict in blk_kick_flush().  I attempted to do the bisect
> manually here, but it's clearly not right since the kernel is not
> booting after the revert:
> 
> https://github.com/tytso/ext4/commit/1e67516382a33da2c9d483b860ac4ec2ad390870
> 
> branch:
> 
> https://github.com/tytso/ext4/tree/manual-revert-of-568f27006577
> 
> Can you send me a patch which correctly reverts 568f27006577?  I can
> try it against -rc1 .. -rc4, whichever is most convenient.

Please test the following revert patch against -rc4.

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 53abb5c73d99..24c208d21793 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -219,6 +219,7 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 	struct request *rq, *n;
 	unsigned long flags = 0;
 	struct blk_flush_queue *fq = blk_get_flush_queue(q, flush_rq->mq_ctx);
+	struct blk_mq_hw_ctx *hctx;
 
 	blk_account_io_flush(flush_rq);
 
@@ -234,11 +235,13 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 	if (fq->rq_status != BLK_STS_OK)
 		error = fq->rq_status;
 
+	hctx = flush_rq->mq_hctx;
 	if (!q->elevator) {
-		flush_rq->tag = BLK_MQ_NO_TAG;
+		blk_mq_tag_set_rq(hctx, flush_rq->tag, fq->orig_rq);
+		flush_rq->tag = -1;
 	} else {
 		blk_mq_put_driver_tag(flush_rq);
-		flush_rq->internal_tag = BLK_MQ_NO_TAG;
+		flush_rq->internal_tag = -1;
 	}
 
 	running = &fq->flush_queue[fq->flush_running_idx];
@@ -309,16 +312,12 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 	flush_rq->mq_hctx = first_rq->mq_hctx;
 
 	if (!q->elevator) {
+		fq->orig_rq = first_rq;
 		flush_rq->tag = first_rq->tag;
-
-		/*
-		 * We borrow data request's driver tag, so have to mark
-		 * this flush request as INFLIGHT for avoiding double
-		 * account of this driver tag
-		 */
-		flush_rq->rq_flags |= RQF_MQ_INFLIGHT;
-	} else
+		blk_mq_tag_set_rq(flush_rq->mq_hctx, first_rq->tag, flush_rq);
+	} else {
 		flush_rq->internal_tag = first_rq->internal_tag;
+	}
 
 	flush_rq->cmd_flags = REQ_OP_FLUSH | REQ_PREFLUSH;
 	flush_rq->cmd_flags |= (flags & REQ_DRV) | (flags & REQ_FAILFAST_MASK);
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index b1acac518c4e..3945c7f5b944 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -101,6 +101,18 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 	return atomic_read(&hctx->nr_active) < depth;
 }
 
+/*
+ * This helper should only be used for flush request to share tag
+ * with the request cloned from, and both the two requests can't be
+ * in flight at the same time. The caller has to make sure the tag
+ * can't be freed.
+ */
+static inline void blk_mq_tag_set_rq(struct blk_mq_hw_ctx *hctx,
+		unsigned int tag, struct request *rq)
+{
+	hctx->tags->rqs[tag] = rq;
+}
+
 static inline bool blk_mq_tag_is_reserved(struct blk_mq_tags *tags,
 					  unsigned int tag)
 {
diff --git a/block/blk-mq.c b/block/blk-mq.c
index b3d2785eefe9..feb3d5c0a1c6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -277,20 +277,26 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 {
 	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
 	struct request *rq = tags->static_rqs[tag];
+	req_flags_t rq_flags = 0;
 
 	if (data->q->elevator) {
 		rq->tag = BLK_MQ_NO_TAG;
 		rq->internal_tag = tag;
 	} else {
+		if (data->hctx->flags & BLK_MQ_F_TAG_SHARED) {
+			rq_flags = RQF_MQ_INFLIGHT;
+			atomic_inc(&data->hctx->nr_active);
+		}
 		rq->tag = tag;
 		rq->internal_tag = BLK_MQ_NO_TAG;
+		data->hctx->tags->rqs[rq->tag] = rq;
 	}
 
 	/* csd/requeue_work/fifo_time is initialized before use */
 	rq->q = data->q;
 	rq->mq_ctx = data->ctx;
 	rq->mq_hctx = data->hctx;
-	rq->rq_flags = 0;
+	rq->rq_flags = rq_flags;
 	rq->cmd_flags = data->cmd_flags;
 	if (data->flags & BLK_MQ_REQ_PREEMPT)
 		rq->rq_flags |= RQF_PREEMPT;
@@ -1098,10 +1104,9 @@ static bool __blk_mq_get_driver_tag(struct request *rq)
 {
 	struct sbitmap_queue *bt = &rq->mq_hctx->tags->bitmap_tags;
 	unsigned int tag_offset = rq->mq_hctx->tags->nr_reserved_tags;
+	bool shared = blk_mq_tag_busy(rq->mq_hctx);
 	int tag;
 
-	blk_mq_tag_busy(rq->mq_hctx);
-
 	if (blk_mq_tag_is_reserved(rq->mq_hctx->sched_tags, rq->internal_tag)) {
 		bt = &rq->mq_hctx->tags->breserved_tags;
 		tag_offset = 0;
@@ -1114,23 +1119,19 @@ static bool __blk_mq_get_driver_tag(struct request *rq)
 		return false;
 
 	rq->tag = tag + tag_offset;
+	if (shared) {
+		rq->rq_flags |= RQF_MQ_INFLIGHT;
+		atomic_inc(&rq->mq_hctx->nr_active);
+	}
+	rq->mq_hctx->tags->rqs[rq->tag] = rq;
 	return true;
 }
 
 static bool blk_mq_get_driver_tag(struct request *rq)
 {
-	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
-
-	if (rq->tag == BLK_MQ_NO_TAG && !__blk_mq_get_driver_tag(rq))
-		return false;
-
-	if ((hctx->flags & BLK_MQ_F_TAG_SHARED) &&
-			!(rq->rq_flags & RQF_MQ_INFLIGHT)) {
-		rq->rq_flags |= RQF_MQ_INFLIGHT;
-		atomic_inc(&hctx->nr_active);
-	}
-	hctx->tags->rqs[rq->tag] = rq;
-	return true;
+	if (rq->tag != BLK_MQ_NO_TAG)
+		return true;
+	return __blk_mq_get_driver_tag(rq);
 }
 
 static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
diff --git a/block/blk.h b/block/blk.h
index 49e2928a1632..5ed35a02bc7f 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -25,6 +25,11 @@ struct blk_flush_queue {
 	struct list_head	flush_data_in_flight;
 	struct request		*flush_rq;
 
+	/*
+	 * flush_rq shares tag with this rq, both can't be active
+	 * at the same time
+	 */
+	struct request		*orig_rq;
 	struct lock_class_key	key;
 	spinlock_t		mq_flush_lock;
 };


thanks, 
Ming

