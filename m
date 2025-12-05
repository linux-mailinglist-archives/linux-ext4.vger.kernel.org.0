Return-Path: <linux-ext4+bounces-12171-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 84890CA6B89
	for <lists+linux-ext4@lfdr.de>; Fri, 05 Dec 2025 09:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A3DD3453CF7
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Dec 2025 08:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8C92FFFB2;
	Fri,  5 Dec 2025 07:19:47 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D84D3002D4;
	Fri,  5 Dec 2025 07:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919178; cv=none; b=etCaDRQLfkiL9L8K9VdLse+UESH1rWm8Rxi6E/o42WMcZ1K8mfhOMPIYNPfwZ3IP+QOsgvMQMO4xvE0za5HSQjO23Jdah+hqBvE+FVAD/fJ5404bX+qPKoID53NLp+Wi5KN0//gNAyu/GbVdjic7bfMHWD0h3RKCfa1JztTn89c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919178; c=relaxed/simple;
	bh=mVczWw5AJvTGaUa2k+kGuAdITLqzYAqLiO2CNQ+CNGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EAoprLGvYfOdaumGSmZkIG4Cx/LSgznS3Nbv4sHmj/tzSpu4By04K6OZtEBxcOUzoiarOXF3Niscmk0qqWG0XZe1oVZP+vE1rvYYF261ujSkYSTXqGVOTSyI8aTL3qNKVypnPKGO99+4PUEcsNCsoSZrSIubw3Od/JB4PAQCrzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-26-6932876cfc06
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
	linux-rt-devel@lists.linux.dev,
	2407018371@qq.com,
	dakr@kernel.org,
	miguel.ojeda.sandonis@gmail.com,
	neilb@ownmail.net,
	bagasdotme@gmail.com,
	wsa+renesas@sang-engineering.com,
	dave.hansen@intel.com,
	geert@linux-m68k.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v18 10/42] dept: apply sdt_might_sleep_{start,end}() to wait_for_completion()/complete()
Date: Fri,  5 Dec 2025 16:18:23 +0900
Message-Id: <20251205071855.72743-11-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251205071855.72743-1-byungchul@sk.com>
References: <20251205071855.72743-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSeUiTcRzG+73nXK3e1sI3I4yFRUV2YPH9o0PoeomIIIjosK18zbemxiyP
	KDLzLpcos3Ie88hsRswt7RTWSqtpNTtXnnR4tNYxZ55o0/C/D8/D8/nrEeFSB+knEiJP8OpI
	pUpOiQmxa1rJsojUVcIKww0ZpCWfhT5PGgGewWYatOcQ5DZl49BrHKWgp24rjLV2YfDVkorA
	mfubgstaOwJ3TweC2/VtCL5lVePw5ut0cDXlY5BbYCKgyTmCQUtuNgbt5Z0ENGSVeIsqX9Bd
	Po9BY2kLAeUJATCmj4JbrlckPG97T4KzM5uC9qcpJNxJ6KCh9tNSKE4pI+BqYQsFF43VJNgt
	DSS8rrR7hfXPCDC/aMQh52cnAmNSHg3usr8EpPSOkvA004JBavcDClLKqjDoyivAIOe1ngKz
	SYvDUOtdEt5nF1HwosZGg23IhsFnjcsrKPButSNpFFTX9dNwrrcdwfBAPgWal1thwPiFBE+l
	gYKfWR4SdHVtdHAw15+sITiDuQbjbhbeRFySOZa71vCD4mwlLHcvr5Xm9KaTXNITF8mZK5Zw
	pQ97MK7Y3Udyn5zrOJMhneKKh7txLsP1Ftsp3yteG8qrhBhevXy9Qhw+bM3AjtfOjOt+Z0cJ
	yDw9A/mIWCaIHbySh03yhfs6cpwpZhHrcAzi4yxj5rPmzE5vLhbhzBt/NnVQM1HMYsLZR7XN
	1DgTTADr1GnocZYwa9gPQ9/x/1J/ttJomWAfb679MDTBUmY1W5TRPyFlmVIf9rz1Evo/mMM+
	qnAQWUiiR1MMSCpExkQoBVVQYHh8pBAXeDgqwoS8fys/M7LvLnLbd1kRI0LyaRJL7EpBSipj
	ouMjrIgV4XKZ5IdqhSCVhCrjT/HqqIPqkyo+2ormigi5r2TV39hQKXNEeYI/xvPHefVki4l8
	/BLQjURFmcyx+pvQ526crff/GPbHsXmArtlzqAQL8FV2yH45MpeOSYqm8oqDi20hoxc0cTrZ
	AtWMxyF7d++7v/jKRlfpwg11yQ93KKqbhfqgLUefHEjXhWyyflccEpZvvn77jC5si63w+sWp
	M4p+kffCujzb/LSBibO27381b0eV5LTfBjkRHa5cuQRXRyv/AccYB45rAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0xScRTH+917uSALu5Krm9UstlYrH9lrp8d6/OXtYfVPq9UfRXWXJKiD
	Qm290EjT8sEGrvBdslQqk8qosYiW056YGWaZYkSamD18DJQMbf1z9jnf7znfnT8ODxfe54Tx
	JInHWHmiWCoi+QR/+9qMSGnmMsnSRmcUZKnPwMdOFwfeqawEDA1mEVB0y0iCX1/Phay6yxxo
	dKQTYL9Zg6BzKAvByKgeB7V5nAC/poELg94PXNCqEIxbGhDomjU4tNkf4WC8o8Lgd+0fEvqe
	/EKgdbpIKOxVETBguIjgilvPhd6nsdDf+ZAD4x1fMXAMexAYXH8wcFkzEfh1CVBaYQqs636Q
	MPryNQ6FWjuCcmcHDr96uxDcafiEwHI9nYQv+XdxaHEFw9uhARKatDkk9DcXYfC9loSydAsH
	ml/0ISjWaxC42y0YZFy9RYKuuI4Ac9cDLjT3jWHwUafBoKYuDjoNbgKe51dggXMDU7dngr4w
	AwuUHgy0Nx5i4DVUczdWImZEnUsw1aZ7GKN+4ycZY4kRMaM+DWIGKzNwRp0faJ94BnDmnCmF
	qXzuIRnfUCvJWIbLCOZZBc1cu+DDmIKXkYz5Sgd356a9/HWHWalEycqj1x/gx4/asrFkS0hq
	T6sdnUWm4GwUxKOpFXTOAz1ngklqId3W5sUnOJSaR5suuQM6n4dTLeF0pjd30phOxdOPLR/I
	CSaoBXSfPpc7wQJqFe3wfcP/hYbTNbXWSQ4K6FqHb5KF1Eq6NHuEk4/4ZWhKNQqVJCplYol0
	ZZQiIT4tUZIadShJVocC/2Q4NVZwHw22xNoQxUOiqQJrSoxEyBErFWkyG6J5uChU4JEulQgF
	h8VpJ1h50n75cSmrsKHZPEI0U7BlN3tASB0RH2MTWDaZlf93MV5Q2Fl0dEl9knqOLa87aVrB
	Dr45TzVPtpgWtRelaPrfl3itqze01+oiTz7euk8Ys2bLdQ9efFqaXL8rr7DE6WvtXu8OyUzV
	fQ6PcLzSh8maFjl75nYFn/fPj6iyW29vi3Ziyu6D0dde7YlLL1HOmHW8a/mijhkVm29GTHeZ
	q4psQeU/jWtFhCJeHLMYlyvEfwHk5RxMSwMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

Make dept able to track dependencies by wait_for_completion()/complete().

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/completion.h | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index fb2915676574..bd2c207481d6 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -10,6 +10,7 @@
  */
 
 #include <linux/swait.h>
+#include <linux/dept_sdt.h>
 
 /*
  * struct completion - structure used to maintain state for a "completion"
@@ -26,14 +27,33 @@
 struct completion {
 	unsigned int done;
 	struct swait_queue_head wait;
+	struct dept_map dmap;
 };
 
+#define init_completion(x)				\
+do {							\
+	sdt_map_init(&(x)->dmap);			\
+	__init_completion(x);				\
+} while (0)
+
+/*
+ * XXX: No use cases for now. Fill the body when needed.
+ */
 #define init_completion_map(x, m) init_completion(x)
-static inline void complete_acquire(struct completion *x) {}
-static inline void complete_release(struct completion *x) {}
+
+static inline void complete_acquire(struct completion *x)
+{
+	sdt_might_sleep_start(&x->dmap);
+}
+
+static inline void complete_release(struct completion *x)
+{
+	sdt_might_sleep_end();
+}
 
 #define COMPLETION_INITIALIZER(work) \
-	{ 0, __SWAIT_QUEUE_HEAD_INITIALIZER((work).wait) }
+	{ 0, __SWAIT_QUEUE_HEAD_INITIALIZER((work).wait), \
+	  .dmap = DEPT_MAP_INITIALIZER(work, NULL), }
 
 #define COMPLETION_INITIALIZER_ONSTACK_MAP(work, map) \
 	(*({ init_completion_map(&(work), &(map)); &(work); }))
@@ -75,13 +95,13 @@ static inline void complete_release(struct completion *x) {}
 #endif
 
 /**
- * init_completion - Initialize a dynamically allocated completion
+ * __init_completion - Initialize a dynamically allocated completion
  * @x:  pointer to completion structure that is to be initialized
  *
  * This inline function will initialize a dynamically created completion
  * structure.
  */
-static inline void init_completion(struct completion *x)
+static inline void __init_completion(struct completion *x)
 {
 	x->done = 0;
 	init_swait_queue_head(&x->wait);
-- 
2.17.1


