Return-Path: <linux-ext4+bounces-12180-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 858A3CA7574
	for <lists+linux-ext4@lfdr.de>; Fri, 05 Dec 2025 12:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E31534F4F03
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Dec 2025 08:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3890D3195F3;
	Fri,  5 Dec 2025 07:20:31 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16F130F7E2;
	Fri,  5 Dec 2025 07:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919222; cv=none; b=slJ5l7/npB+XlmWohCeBuemZyE7FX2/f3BIjPWvwwrlNELFc2D4rQWApTZMc5Q3eRkS+Peg6Vnsj783bpnmlGERNLbHpd0iWySpLeU0iz+AjXSMbY/ImVhwJeeHveex9dJ7LJFF9EF9DxL2E8p77wY56YzRMcvUqwteuXMGrCns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919222; c=relaxed/simple;
	bh=9o9SI0ONdb1WbiIWXrCSb5nX53qir4UGX5Gt0IQgpYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ikoHNgdXo01/YA3slp/+2sJxHCxjXigOaRHG4EyZWhJmBIjsHd/kXLAf9SZQo4meV9SPJHQXax5ruBFwWqIsOmzR3qG62RepF4gmDwLN9bkqD9Qf5cBTaJrgZ291kKPvWZyKavFUmWuccKurzRvprCtlQKxrSz9PBP6/b2Qs77Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-00-6932876e9f6b
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
Subject: [PATCH v18 17/42] dept: apply timeout consideration to swait
Date: Fri,  5 Dec 2025 16:18:30 +0900
Message-Id: <20251205071855.72743-18-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251205071855.72743-1-byungchul@sk.com>
References: <20251205071855.72743-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0xTZxjHfc+1NHQ5qbejyyKpURcTtSVenkW6MBOTk7hlmmVfZuJo5CAn
	lNYURDDRFbMONFhJkXYDhNNpGqAVsF64iSJK4w3oKJMK9YKW6kYRhxVH7WC1xm+//G95PjwS
	XB4gl0sEXT5v0Gm0CkpKSCeT7ev0JamC8vK/n0DgcZAEb5MTwX8WDw2R2VEa5rs8CFwXizF4
	3TJHwcSNaQTDM2EEjuAcBsHuknjYmgN1v1+Im9ZXFLzrG8Bh6M0UBeLRLhL+mIhhELBaMHC6
	v4HHjhAB1vNLofJcJwb3zgQIqO7zkTAv6sHjfE5D0+QACRMhCwWtxic0uB/0IogMjWHgKgvh
	8FttgAJP21MMfB01FJS1XCLhkWs+fnT3XRIGnV4C7npuETD2xE+Cv3wcwQNbmAbHmyka6v+x
	kRD68xcMGrr64iviEmj5uYqGkhedFPRV95MQMP9NwM3mVgzcrvsUVAyKFEQftpFw31JHwfTp
	ORJMZbM0VMZKKaguNiM4HVHBy/IImZ7OvTWZCc5V60Lcu6gFcabyON0IT+Fce9VDmhPdB7gz
	V/7CuJEJNeduPEZx7mkLzb3s76e59rEvuOCQDePsxkqcq729a2fKD9K0TF4rFPCGDV9mSLOb
	g8Vo/2uq0NZ7ljSiO+RxlCRhmY2so8xGf+TR6LWETjFrWL9/Fn/Pi5gU9sKJUFyXSnDGt4It
	mTUnjIXMdnag0Y69Z4JZxTZbTyXKMmYzaw7biQ+jK1hnS3cinxTXK4ejCZYzm9i6428ToyxT
	ncQa+03oQ2EZe73eT5QjmYgWNCK5oCvI1Qjajeuzi3RC4fq9+lw3iv+c43Bsdxua9n7XgxgJ
	UiTLug+qBDmpKcgryu1BrARXLJKFtUpBLsvUFB3iDfofDQe0fF4P+lRCKJbKUmcOZsqZfZp8
	Pofn9/OGjy4mSVpuRKbVKxvG4KjatBPfcmyzuj7n5PaVaV93Ek31X3k7KpJlvuYq1fCC1TWf
	ize3tMZ6Da6th18plfygmlin6rDH2nu8Wb0VyqsnxpfQ3wrB1JRdWenjupTJZ+pfMwpzbn02
	sgy7nbVqVFn60+LoDuORNP2cOGL/viaydZtsz3xFqehTEHnZGtVa3JCn+R82OI86bwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUhTcRTG+9+3zdHqsgQv9aFYpBBoGiUnktIgvAVJRVTUB73VJYdzymaW
	QdS0ofYia7SNtkqdOmJavpdmI1Oymvky30lNo2WZM61csqnZWvTl8DvP85zD+XCEuKSBXCuU
	KTJ4pYKTSykRIUrYmROuyN0qi/SVhUGe5jKMjLlIGFA3E+CZyyPgbmUFBUvmJwLIq7lDwuvB
	bAK6H5UjGPPkIZhfMOOgaVwmYEnXJoA577AA9GoEy/Y2BAanDoeh7uc4VNSpMfhZ9ZuCqdYf
	CPQfXBQYJ9UEzFhvIDBNmAUw+TIepseaSFge/YzB4C83AqvrNwau5lwES4YUKLTU+scNsxQs
	dHThYNR3Iyj+MIrDj8lxBHVt7xHYH2RT8Elbj0OvaxX0eWYoeKO/TsG08y4G36ooKMq2k+B8
	O4XgnlmHYOKdHYOckkoKDPdqCGgcfyoA59QiBiMGHQblNQdgzDpBQLvWgvnP9aeqQ8BszMH8
	5QsG+odNGHitNkFsGWLnNQUEa6t9jLGaniWKrbhfgdgFnw6xc2U5OKvR+ttW9wzOXq09z5a1
	uynW5+mnWPuvIoJ1WBi2NN+Hsbc6wtlG06jgYNwJUcwZXi7L5JVbdiWJkitdapT+k7pgfFlK
	XkEO8hoKEjL0NmbY9zzAFB3GDA158b8cTG9gam9O+HWREKd71zO53oKAsYbey3TZirG/TNCb
	mErD7cCwmI5mCtzFxL+l65nyquZAPsiv6wd9AZbQ25nCa/OkFomK0AobCpYpMlM5mXx7hCol
	OUshuxBxOi21Bvn/yXpp8VYDmuuNb0G0EElXipvPR8kkJJepykptQYwQlwaL3fJImUR8hsu6
	yCvTEpXn5LyqBa0TEtIQ8f5jfJKEPstl8Ck8n84r/7uYMGjtFXTI+7nAuVJUnWif6frKhTvC
	NsqjYxQeh0m3Of52qGVDf8xibtuhLaUhxtmj1fV79p7y9A0822fc2kmvTniRaioaWZ1V8oqP
	jp3KfNNRXtp3RNt52LI40H39OxO1wzHN5Q+H1uc7ZocLdx9P2P1xU8MDg+lEj2R6wTXZejK8
	ZzzuopRQJXNRm3GlivsDMmueF0sDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to swait, assuming an input 'ret' in ___swait_event()
macro is used as a timeout value.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/swait.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/swait.h b/include/linux/swait.h
index 277ac74f61c3..233acdf55e9b 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -162,7 +162,7 @@ extern void finish_swait(struct swait_queue_head *q, struct swait_queue *wait);
 	struct swait_queue __wait;					\
 	long __ret = ret;						\
 									\
-	sdt_might_sleep_start(NULL);					\
+	sdt_might_sleep_start_timeout(NULL, __ret);			\
 	INIT_LIST_HEAD(&__wait.task_list);				\
 	for (;;) {							\
 		long __int = prepare_to_swait_event(&wq, &__wait, state);\
-- 
2.17.1


