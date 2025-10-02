Return-Path: <linux-ext4+bounces-10538-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAC4BB304D
	for <lists+linux-ext4@lfdr.de>; Thu, 02 Oct 2025 10:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08C4E7A18B9
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Oct 2025 08:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB5F312808;
	Thu,  2 Oct 2025 08:14:07 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1F630EF84;
	Thu,  2 Oct 2025 08:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392845; cv=none; b=R/xPXa1UrWladPapA/vASY5EOBZYMLEi02BFC03KccCRqpWQYZyw4uIWffhJpXD06KL3lW7RUdsB3DQwfScQUqM7QMaHtwapzoPXYPvscWwTzxVCGYxXh+ol5PJhwGV4mpfP0RA9NLqjmHM+wMrpA3nrB+0dZqzGK4urOFJPypI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392845; c=relaxed/simple;
	bh=HQb+FieD5UTtfcyEdgT0lo4GMUWAEhmBX2C4Cisefmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EtnR8ckZC9APCQL2aFYHg/IN3Y1G+O1NHTjwW4RFdeVsnexJXwQMa5AM2wjZlo5h9YZ9r+JXg7ENLs4nSXAkwaWBWbAjW0/IPe/yH78+910hQpMllbqphdfnYRPNenPSNPq6GbjKTrqWFFJgDxLy1jxTfYbeP/I6sbbLCP9xu5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-48-68de341288e5
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org
Cc: kernel_team@skhynix.com,
	torvalds@linux-foundation.org,
	damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	will@kernel.org,
	tglx@linutronix.de,
	rostedt@goodmis.org,
	joel@joelfernandes.org,
	sashal@kernel.org,
	daniel.vetter@ffwll.ch,
	duyuyang@gmail.com,
	johannes.berg@intel.com,
	tj@kernel.org,
	tytso@mit.edu,
	willy@infradead.org,
	david@fromorbit.com,
	amir73il@gmail.com,
	gregkh@linuxfoundation.org,
	kernel-team@lge.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	mhocko@kernel.org,
	minchan@kernel.org,
	hannes@cmpxchg.org,
	vdavydov.dev@gmail.com,
	sj@kernel.org,
	jglisse@redhat.com,
	dennis@kernel.org,
	cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	vbabka@suse.cz,
	ngupta@vflare.org,
	linux-block@vger.kernel.org,
	josef@toxicpanda.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	dan.j.williams@intel.com,
	hch@infradead.org,
	djwong@kernel.org,
	dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com,
	hamohammed.sa@gmail.com,
	harry.yoo@oracle.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	yunseong.kim@ericsson.com,
	ysk@kzalloc.com,
	yeoreum.yun@arm.com,
	netdev@vger.kernel.org,
	matthew.brost@intel.com,
	her0gyugyu@gmail.com,
	corbet@lwn.net,
	catalin.marinas@arm.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	luto@kernel.org,
	sumit.semwal@linaro.org,
	gustavo@padovan.org,
	christian.koenig@amd.com,
	andi.shyti@kernel.org,
	arnd@arndb.de,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	rppt@kernel.org,
	surenb@google.com,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	urezki@gmail.com,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	chuck.lever@oracle.com,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	kees@kernel.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	mark.rutland@arm.com,
	ada.coupriediaz@arm.com,
	kristina.martsenko@arm.com,
	wangkefeng.wang@huawei.com,
	broonie@kernel.org,
	kevin.brodsky@arm.com,
	dwmw@amazon.co.uk,
	shakeel.butt@linux.dev,
	ast@kernel.org,
	ziy@nvidia.com,
	yuzhao@google.com,
	baolin.wang@linux.alibaba.com,
	usamaarif642@gmail.com,
	joel.granados@kernel.org,
	richard.weiyang@gmail.com,
	geert+renesas@glider.be,
	tim.c.chen@linux.intel.com,
	linux@treblig.org,
	alexander.shishkin@linux.intel.com,
	lillian@star-ark.net,
	chenhuacai@kernel.org,
	francesco@valla.it,
	guoweikang.kernel@gmail.com,
	link@vivo.com,
	jpoimboe@kernel.org,
	masahiroy@kernel.org,
	brauner@kernel.org,
	thomas.weissschuh@linutronix.de,
	oleg@redhat.com,
	mjguzik@gmail.com,
	andrii@kernel.org,
	wangfushuai@baidu.com,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-i2c@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH v17 31/47] dept: assign dept map to mmu notifier invalidation synchronization
Date: Thu,  2 Oct 2025 17:12:31 +0900
Message-Id: <20251002081247.51255-32-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUhTYRTHe+7uvZvDxW2aXjUo1osgqRVah6zog9TzwaD3oNBceW3DqTHN
	l6CycKmBZkaSmm46W8us1hb4ktrUTMz3sjVlajUzrSzSzBSzpuW3H7/z53/OhyPgiVMpT4E8
	Jp5TxkgVElpICseci31dAgZkG/SNq8Fy0UzC4GQ6AlXVHxImDHM0jDbthrHBJxTohuYIGDKn
	IVCXmGgYMTioVn+JhldDS0FzqZaCwoIcBLmFRkeHbpiE3EfuMK0r40Ob1kbCH00sPBjrpGCw
	+TIFxt4mBEa7hYK8IhsNzyvfE9CSf5eEzur7FJja23hgzf6A4P7XEhp0k9/48NKsIeC5xg2a
	M80EtBd0UGDL+kRCXfpbAozlFhosOWoaXsy8IGC8cI6Ce90k3JhNpyH92U8epNoC4ZfBTu30
	x1OqLBKrXv6mcXlROcK3W7/Q+Fq7L67K7+fj1Lo+PjbpfbC2ZpTAfZ+3Y2NZBo1tlhoaF7Xs
	w6bSC1ibdZ3C3z/0kXuXHxVui+AU8gRO6b8jXCjrKDOj02+2JDXb1HQKGvC9gpwELBPAVpfW
	EYvcr++k5plmvFmrdZo3z67MKtaUObzgeUzrCtbSvX6eXZhQ9nVdxoInmbVsfVvXQl7EbGYr
	GtX8f50r2XsG84J3cvhX71rJeRYzgazqW6pjr9CRKXBif5Qb/h/hwdbrrWQ2EmnQkjIklsck
	REvligA/WXKMPMnvZGy0ETl+Q3du9lglGu860IAYAZI4i7rW9svElDQhLjm6AbECnsRVFK63
	ycSiCGnyWU4Ze1x5RsHFNSAvASlxF236mRghZk5J47kojjvNKRenhMDJMwUF7+qZsm51iyLs
	xYnCq2yP3evhHaxu8VJjibOp2zvSwIYsz6ydnBnSzMKJwcTZda6HUE/SNpc1QZejjp6v77k1
	PXNrXe+5JPepm0EVYR4fQ576ZS87mxPmblEdnHjsIeDtsY84B6dsyfvckFZyJHJ/oXa4L1Kt
	9QpUhBoObwqLl5BxMulGH54yTvoXAfXoHxcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSeUiTcRjH+73nHC1eptGLFtXI7LL7eOgigvAtqPwjsAPJVW9teLaVR6em
	SzvVwZSc5jIaMs3ZZqs1jKW1DjOdq+zYPGJpoSaUM7yyafTPw+f5fB8enj8eAS62kMECecIJ
	XpEgjZNQQkK4a0NmuHh1m2z5JWsgvM+wE+AbyCGg2FhJQY7pBgnNVRUI2n05CH6PaHFQWccJ
	GFM7aBgY+kzDeK0DQYFTjUNlTQYGv6r/UNBT/xOBptNLQeH3DAL69VcRFHVpafj+LAL62m0k
	jHu6MWgd7EWg9/7BwGvPRjBWEAulZWYKRhqbcCjUNCO41enB4Vu1P6xxtCGoLb9Awde8+zi4
	vNPgra+fgpeaKxT0OYsx+FFNge5CLQklWjWCzNtGCgpKTARYOx7R4OwZxcBdoMagwrQT2vVd
	BDTklWH++/xT92aAtjAT85dvGGju2jAY0htoeH3bTYA+PRS0jS4SvpQX0TDauQLGdYngqOim
	wZOrIaCqr4ncokHcb9V1gjOYLRinahmjuMqblYgbGVYjbuBOJs6p8vxtfW8/zmWZU7g7Db0U
	N+x7R3G1gzqCe1XGcvmN4Zy1yENzWY8/0ZHr9ws3HuHj5Mm8YtnmGKHsjcGOklrXpT53l1Lp
	qC38MgoQsMxq1lPeRE4wxYSxHz4M4RMcxMxhzde6Jj3ONMxk3zuXTHAgE82+e3xp0hNMKPvk
	dfPkvIhZyz6oL6X/7ZzNVlTbJ32A37s6G4gJFjNrWFV/FpaHhDo0xYCC5AnJ8VJ53JqlylhZ
	WoI8denhxHgT8n+T/uxo/kM04IqoQ4wASaaKnKEemZiUJivT4usQK8AlQaKYcrdMLDoiTTvF
	KxIPKk7G8co6FCIgJDNEO6L4GDFzTHqCj+X5JF7xP8UEAcHpaFaJ/VhSyPytTuJwGDR3sDZL
	7qbwQ1ZPYLbF1hI0+HHevp5I80JjVNjui4Gti1uCu3Sy0W0j2Wlf9p6hUlOYHwbLhpXH64/X
	RESdXOmaPW3VMDw94z0dct2tNW1P2WNzFK76SB7NzVd8HjzPRYcuOJBz1djdMb343NxnVb4X
	0cadEkIpk65YhCuU0r+So2tVSQMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

Resolved the following false positive by introducing explicit dept map
and annotations for dealing with this case:

   *** DEADLOCK ***
   context A
       [S] (unknown)(<sched>:0)
       [W] lock(&mm->mmap_lock:0)
       [E] try_to_wake_up(<sched>:0)

   context B
       [S] lock(&mm->mmap_lock:0)
       [W] mmu_interval_read_begin(<sched>:0)
       [E] unlock(&mm->mmap_lock:0)

   [S]: start of the event context
   [W]: the wait blocked
   [E]: the event not reachable

dept already tracks dependencies between scheduler sleep and ttwu based
on internal timestamp called wgen.  However, in case that more than one
event contexts are overwrapped, dept has chance to wrongly guess the
start of the event context like the following:

   <before this patch>

   context A: lock L
   context A: mmu_notifier_invalidate_range_start()

   context B: lock L'
   context B: mmu_interval_read_begin() : wait
   <- here is the start of the event context of C.
   context B: unlock L'

   context C: lock L''
   context C: mmu_notifier_invalidate_range_start()

   context A: mmu_notifier_invalidate_range_end()
   context A: unlock L

   context C: mmu_notifier_invalidate_range_end() : ttwu
   <- here is the end of the event context of C.  dept observes a wait,
      lock L'' within the event context of C.  Which causes a false
      positive dept report.

   context C: unlock L''

By explicitly annotating the interesting event context range, make dept
work with more precise information like:

   <after this patch>

   context A: lock L
   context A: mmu_notifier_invalidate_range_start()

   context B: lock L'
   context B: mmu_interval_read_begin() : wait
   context B: unlock L'

   context C: lock L''
   context C: mmu_notifier_invalidate_range_start()
   <- here is the start of the event context of C.

   context A: mmu_notifier_invalidate_range_end()
   context A: unlock L

   context C: mmu_notifier_invalidate_range_end() : ttwu
   <- here is the end of the event context of C.  dept doesn't observe
      the wait, lock L'' within the event context of C.  context C is
      responsible only for the range delimited by
      mmu_notifier_invalidate_range_{start,end}().

   context C: unlock L''

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/mmu_notifier.h | 26 ++++++++++++++++++++++++++
 mm/mmu_notifier.c            | 31 +++++++++++++++++++++++++++++--
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index d1094c2d5fb6..2b70dce149f0 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -428,6 +428,14 @@ static inline int mmu_notifier_test_young(struct mm_struct *mm,
 	return 0;
 }
 
+#ifdef CONFIG_DEPT
+void mmu_notifier_invalidate_dept_ecxt_start(struct mmu_notifier_range *range);
+void mmu_notifier_invalidate_dept_ecxt_end(struct mmu_notifier_range *range);
+#else
+static inline void mmu_notifier_invalidate_dept_ecxt_start(struct mmu_notifier_range *range) {}
+static inline void mmu_notifier_invalidate_dept_ecxt_end(struct mmu_notifier_range *range) {}
+#endif
+
 static inline void
 mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
 {
@@ -439,6 +447,12 @@ mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
 		__mmu_notifier_invalidate_range_start(range);
 	}
 	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
+
+	/*
+	 * From now on, waiters could be there by this start until
+	 * mmu_notifier_invalidate_range_end().
+	 */
+	mmu_notifier_invalidate_dept_ecxt_start(range);
 }
 
 /*
@@ -459,6 +473,12 @@ mmu_notifier_invalidate_range_start_nonblock(struct mmu_notifier_range *range)
 		ret = __mmu_notifier_invalidate_range_start(range);
 	}
 	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
+
+	/*
+	 * From now on, waiters could be there by this start until
+	 * mmu_notifier_invalidate_range_end().
+	 */
+	mmu_notifier_invalidate_dept_ecxt_start(range);
 	return ret;
 }
 
@@ -470,6 +490,12 @@ mmu_notifier_invalidate_range_end(struct mmu_notifier_range *range)
 
 	if (mm_has_notifiers(range->mm))
 		__mmu_notifier_invalidate_range_end(range);
+
+	/*
+	 * The event context that has been started by
+	 * mmu_notifier_invalidate_range_start() ends.
+	 */
+	mmu_notifier_invalidate_dept_ecxt_end(range);
 }
 
 static inline void mmu_notifier_arch_invalidate_secondary_tlbs(struct mm_struct *mm,
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 8e0125dc0522..31af5ea54a0c 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -46,6 +46,7 @@ struct mmu_notifier_subscriptions {
 	unsigned long active_invalidate_ranges;
 	struct rb_root_cached itree;
 	wait_queue_head_t wq;
+	struct dept_map dmap;
 	struct hlist_head deferred_list;
 };
 
@@ -165,6 +166,25 @@ static void mn_itree_inv_end(struct mmu_notifier_subscriptions *subscriptions)
 	wake_up_all(&subscriptions->wq);
 }
 
+#ifdef CONFIG_DEPT
+void mmu_notifier_invalidate_dept_ecxt_start(struct mmu_notifier_range *range)
+{
+	struct mmu_notifier_subscriptions *subscriptions =
+		range->mm->notifier_subscriptions;
+
+	if (subscriptions)
+		sdt_ecxt_enter(&subscriptions->dmap);
+}
+void mmu_notifier_invalidate_dept_ecxt_end(struct mmu_notifier_range *range)
+{
+	struct mmu_notifier_subscriptions *subscriptions =
+		range->mm->notifier_subscriptions;
+
+	if (subscriptions)
+		sdt_ecxt_exit(&subscriptions->dmap);
+}
+#endif
+
 /**
  * mmu_interval_read_begin - Begin a read side critical section against a VA
  *                           range
@@ -246,9 +266,12 @@ mmu_interval_read_begin(struct mmu_interval_notifier *interval_sub)
 	 */
 	lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
 	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
-	if (is_invalidating)
+	if (is_invalidating) {
+		sdt_might_sleep_start(&subscriptions->dmap);
 		wait_event(subscriptions->wq,
 			   READ_ONCE(subscriptions->invalidate_seq) != seq);
+		sdt_might_sleep_end();
+	}
 
 	/*
 	 * Notice that mmu_interval_read_retry() can already be true at this
@@ -625,6 +648,7 @@ int __mmu_notifier_register(struct mmu_notifier *subscription,
 
 		INIT_HLIST_HEAD(&subscriptions->list);
 		spin_lock_init(&subscriptions->lock);
+		sdt_map_init(&subscriptions->dmap);
 		subscriptions->invalidate_seq = 2;
 		subscriptions->itree = RB_ROOT_CACHED;
 		init_waitqueue_head(&subscriptions->wq);
@@ -1070,9 +1094,12 @@ void mmu_interval_notifier_remove(struct mmu_interval_notifier *interval_sub)
 	 */
 	lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
 	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
-	if (seq)
+	if (seq) {
+		sdt_might_sleep_start(&subscriptions->dmap);
 		wait_event(subscriptions->wq,
 			   mmu_interval_seq_released(subscriptions, seq));
+		sdt_might_sleep_end();
+	}
 
 	/* pairs with mmgrab in mmu_interval_notifier_insert() */
 	mmdrop(mm);
-- 
2.17.1


