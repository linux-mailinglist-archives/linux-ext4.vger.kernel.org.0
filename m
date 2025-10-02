Return-Path: <linux-ext4+bounces-10517-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B40BB2DD4
	for <lists+linux-ext4@lfdr.de>; Thu, 02 Oct 2025 10:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B7A19C82E5
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Oct 2025 08:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688E82EC09C;
	Thu,  2 Oct 2025 08:13:28 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B382EA475;
	Thu,  2 Oct 2025 08:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392808; cv=none; b=J2gkCY646Jzkl6YwGD51FmPO7AfwlRE0DF6shu9sE3+pVqd2VFwSKenf7nBuurm3Fi1aHnPNO7du/OI9miFa71WNX5SeU3jbt2CiCLHI5qGZrcx089G3LAcljBZPkCNvhJQe9Nht7qN3l5CPxR4mmdyQpjSe+NlQvabd8jvcn3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392808; c=relaxed/simple;
	bh=h//iPHlnVuvuWZaoIOCavmQljq7ds4KVfkx9Jf/hjms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=J5ZFhCfYT2pzUw+OWmgf4ZwIpNkpwChLE3a6VZCFLEeNGshXuWMtlvQ/d400WWTsUTN0l3iybAgJH1GPNKhdcdbmODDcxLD6ahSGsNXdKDL5e0u86rBCRPnlU+63GhVklxvSoKwQ2wHsnoabZXmLv7/fjgAIRfQ44mPgfJvBUdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-35-68de340d30f6
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
Subject: [PATCH v17 09/47] arm64, dept: add support CONFIG_ARCH_HAS_DEPT_SUPPORT to arm64
Date: Thu,  2 Oct 2025 17:12:09 +0900
Message-Id: <20251002081247.51255-10-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa2xLcRjG/c/5n3O6ZuWkxM5GkMYixC4YeYlb4oO/EBE+4YPVdqKN7pJu
	ysRkyy5uw4wNG0tZutlazClJZ4KVdexS3ViVtJjENpl1YTUxrNqJL29+ed7nfZ4vr4xWljAx
	Mm16tqhPV+tUrBzLhyOvxSmS3mkSi0/OBnf+YwzfA8cxXLltYcF1y4xgtHGCheH3zQx8Kr1H
	w9WqMgTeijIKLn5moeJOFFRdLKBCY5CCzhovhqAxAxzmAQ4sJf00XK72suCwfaSgpPEeAz1m
	F4bbAx4KOhzPMDyvrMdget1NgbWrk4ab/ussDI3V0pDfUoPBYZwJZf3fOCgenWDAFPDTcGyw
	mYWuKicDksXNQrtvlIPzPUYWrFI5DeM+GwPjda0IzN0YThVVYDj+dIyGxq91LOSPvkdw848b
	gb80wKxPJD+KzmBS1POHJZZqCyIBUwFNCq0HianjC0vGv/ey5FxXHGmq9HHEKB0ghU+HGfJ2
	aA2RGk6wxOt+wBK/08mRZ5d+4W0xu+SrU0Wd1iDqE9YmyzXFzjo6877yUOspP5OHglNPogiZ
	wCcJtQ+D+D+7WnuZMLP8AsHj+UmHeQY/T7Ce7p/Uab5jtuDuXhzm6fxOwfj6BRdmzMcKgbMj
	VJgV/ArB+eQV9S9zrmBufDyZExHSX/Z1THYp+eVC0UhhyCMPeaoiBGuejft3EC203PDgUqQw
	oikNSKlNN6SptbqkeE1OuvZQfEpGmoRCP1Kb+3u3DX1z7bAjXoZUkQpXrE+jZNSGrJw0OxJk
	tGqGIvmGV6NUpKpzDov6jD36Azoxy45mybAqSrF07GCqkt+nzhb3i2KmqP+/pWQRMXlIF2kJ
	Jryx2DcmbzaUb9/5CM9Zd6QtYeX2RUdLvsoXVp9ZlvZ7mufDhvZgNLchhrumrk1IIk1S/d4F
	I52mlHljUluvrzv3w4RtfnabYbdUP7PygtS/d8/zhvJX26brUzatmtO3dUsFZ7gbZ00NJm4d
	j1po17+tueNoKGhuaeqNX9+mwlka9ZJFtD5L/RfhAN+LHwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+5/rHK4OS+p0gWIg0U0rKl5MoojwkFT2oSwJ8pCHNryylWUQ
	aLqU1mUNpuW0puISt8xcVkss0RzUMl2W3ZxzskxRG9SmmZe1FX15+b3P8/LwfHhFuPQRuVyk
	yDotKLP4DBklJsQHdhRujNw6IN/kdMZDX0EbAQF/CQEV9y0UlDTdIqGnwYzAHShBMDVjwEFt
	CxIwp7PT4J/+QkOw1Y6g1KnDwfKwAIOfjfMUjHX8QKD3eCkoGy0gwGe6gqB82EDDaGcCTLhb
	SAi6vmHwYXIcgck7j4G3rRjBXGk63Km2UjDT1Y1Dmb4HQZXHhcNIY8h8aB9A0Fp3kYKv2mYc
	er0L4V3AR8FLvYaCCWcFBt8bKTBebCWh0qBDUFhzn4LSyiYCbINPaXCOzWLQX6rDwNy0H9ym
	YQIc2mos1C909WApGMoKsdAYwUB/rwWDaVM9Da9r+gkw5UeDoauXhKG6chpmPZshaMwGu/kb
	Da7regIaJrrJXXrETamvEVy99RHGqd/OUZzltgVxM791iPPXFuKcWhtaO8Z9OFdkPcvVOsYp
	7nfgPcW1ThoJ7lU1y93o2sjZyl00V/TsM50UlyKOTxMyFLmCMnZnqlh+6c1dPOep9Fyn5juZ
	j4ILL6MIEctsZXs635Nhppg17MeP03iYo5jVrPXq8F8dZxwr2T7nhjAvZo6xxg/ddJgJJpr1
	X/dhYZYw29k3He+wf5mrWHNj29+ciJDe63EQYZYy21i1rwjTIrERLahHUYqs3ExekbEtRpUu
	z8tSnIs5mZ3ZhELfZLowe+MJ8vcmtCNGhGSREme0Sy4l+VxVXmY7YkW4LEqSWtcvl0rS+Lzz
	gjL7hPJMhqBqRytEhGypZF+ykCplTvGnhXRByBGU/11MFLE8H1XHP/5xaTrtS0rC0bhjY4mj
	OQNWR17S8b2Et2L9nqOJh7GzaGTDfGX9p1jvQa1Fk/LrfPMi0ZZAM286kmiLrJpNWuUZinuh
	ObnJ9/xrjX+Snhp6bI6y7WlJXsv33TzkLR7/uWTlbvv2B37NMtu64gsRybGDn3piqlxu42CJ
	29swIyNUcn7zOlyp4v8Aa9MXtkkDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

dept needs to notice every entrance from user to kernel mode to treat
every kernel context independently when tracking wait-event dependencies.
Roughly, system call and user oriented fault are the cases.

Make dept aware of the entrances of arm64 and add support
CONFIG_ARCH_HAS_DEPT_SUPPORT to arm64.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/arm64/Kconfig          | 1 +
 arch/arm64/kernel/syscall.c | 7 +++++++
 arch/arm64/mm/fault.c       | 7 +++++++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e9bbfacc35a6..a8fab2c052dc 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -281,6 +281,7 @@ config ARM64
 	select USER_STACKTRACE_SUPPORT
 	select VDSO_GETRANDOM
 	select VMAP_STACK
+	select ARCH_HAS_DEPT_SUPPORT
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index c442fcec6b9e..bbd306335179 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -7,6 +7,7 @@
 #include <linux/ptrace.h>
 #include <linux/randomize_kstack.h>
 #include <linux/syscalls.h>
+#include <linux/dept.h>
 
 #include <asm/debug-monitors.h>
 #include <asm/exception.h>
@@ -96,6 +97,12 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 	 * (Similarly for HVC and SMC elsewhere.)
 	 */
 
+	/*
+	 * This is a system call from user mode.  Make dept work with a
+	 * new kernel mode context.
+	 */
+	dept_update_cxt();
+
 	if (flags & _TIF_MTE_ASYNC_FAULT) {
 		/*
 		 * Process the asynchronous tag check fault before the actual
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index d816ff44faff..96827b999d18 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -26,6 +26,7 @@
 #include <linux/pkeys.h>
 #include <linux/preempt.h>
 #include <linux/hugetlb.h>
+#include <linux/dept.h>
 
 #include <asm/acpi.h>
 #include <asm/bug.h>
@@ -622,6 +623,12 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 	if (!(mm_flags & FAULT_FLAG_USER))
 		goto lock_mmap;
 
+	/*
+	 * This fault comes from user mode.  Make dept work with a new
+	 * kernel mode context.
+	 */
+	dept_update_cxt();
+
 	vma = lock_vma_under_rcu(mm, addr);
 	if (!vma)
 		goto lock_mmap;
-- 
2.17.1


