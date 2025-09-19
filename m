Return-Path: <linux-ext4+bounces-10274-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0B5B88E32
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 12:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 149187B0F06
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 10:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12A430AD02;
	Fri, 19 Sep 2025 10:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="NlDlJDDl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.75.33.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ED43081C0;
	Fri, 19 Sep 2025 10:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.75.33.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758277378; cv=none; b=B+P/GuDazwQOLtgTMMCM9EpY5KpciBg6BuppGFCbLppvC6cxWPptOc8b9c/OAb9rX3uNWtmihiW99l4kZv2fBpbWCJYRUkWbgJTOr2Q2lYjdDm61myQeOGNZcwoOtvRNqoq5y+yUrYZcUUdDJUbjSMz1n1SVNVeMbit8bw9Jqb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758277378; c=relaxed/simple;
	bh=JEYc4CItGCBWUkoOIUoWprHXQoWFFIqWm8tkxe6DE7s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pFepGGN7HIJIjJ8DhfD4a8seH6ZBJHB2Oq9xq+3V6ZYppqpdl0/G3xQGjEouYFnCe/iUFgCveo8PgYWjI/gPIqTfaiHNrpnPb6nn4xNhgFGn42d062Wf9F5DMchIUwVGnD/27Qn6luh4ksCxQrr03SEWCrv0RHPubvpDObfS1bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=NlDlJDDl; arc=none smtp.client-ip=3.75.33.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758277376; x=1789813376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UnBmV/SkhIg5SgTRTNSUlBFA6sgQ2eBqJGsC4N+ceR0=;
  b=NlDlJDDlBfL79FI3+7d+Ui/ZNtTF9YLJEnKjEqTMHe+s1fiLQucbR+nv
   b8LzIn9FjCtyF7cgGK+xI5OsZrT+VXVCavRRsU16ubRRGNZTefGGCaDkd
   JPgurZK1lsPXlf2KWAUaSRcMh/ULEIgCtqfA7rIcf5S8frYKpNAPBJ7qD
   RGU45WLUQyDpNXNxeiJt2uT3qBBbp9XAZipuapaJuYmIZuNFR6eXtNVEi
   rkijV1wmswD6QfyySBl9Njyo01eka+R9U9gasBOyl075OemhfFM5wbnBS
   qhA00QBYNPZENiydIkNUdZ+cQYbs3zx0j2JiHfSg0EPq9P2AVkWvTZUS4
   g==;
X-CSE-ConnectionGUID: mhNxtiATSFaNQF5p9yxMNw==
X-CSE-MsgGUID: v25n3sAITvu7P3edO5vr3Q==
X-IronPort-AV: E=Sophos;i="6.18,277,1751241600"; 
   d="scan'208";a="2370736"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 10:22:44 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.234:28724]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.8.212:2525] with esmtp (Farcaster)
 id a93198f1-1106-4301-b601-52214bd42f8b; Fri, 19 Sep 2025 10:22:44 +0000 (UTC)
X-Farcaster-Flow-ID: a93198f1-1106-4301-b601-52214bd42f8b
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 19 Sep 2025 10:22:39 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 19 Sep 2025
 10:22:10 +0000
From: Eliav Farber <farbere@amazon.com>
To: <linux@armlinux.org.uk>, <jdike@addtoit.com>, <richard@nod.at>,
	<anton.ivanov@cambridgegreys.com>, <dave.hansen@linux.intel.com>,
	<luto@kernel.org>, <peterz@infradead.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>, <hpa@zytor.com>,
	<tony.luck@intel.com>, <qiuxu.zhuo@intel.com>, <mchehab@kernel.org>,
	<james.morse@arm.com>, <rric@kernel.org>, <harry.wentland@amd.com>,
	<sunpeng.li@amd.com>, <alexander.deucher@amd.com>,
	<christian.koenig@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
	<evan.quan@amd.com>, <james.qian.wang@arm.com>, <liviu.dudau@arm.com>,
	<mihail.atanassov@arm.com>, <brian.starkey@arm.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <robdclark@gmail.com>, <sean@poorly.run>,
	<jdelvare@suse.com>, <linux@roeck-us.net>, <fery@cypress.com>,
	<dmitry.torokhov@gmail.com>, <agk@redhat.com>, <snitzer@redhat.com>,
	<dm-devel@redhat.com>, <rajur@chelsio.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <peppe.cavallaro@st.com>, <alexandre.torgue@st.com>,
	<joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>, <malattia@linux.it>,
	<hdegoede@redhat.com>, <mgross@linux.intel.com>, <intel-linux-scu@intel.com>,
	<artur.paszkiewicz@intel.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <sakari.ailus@linux.intel.com>,
	<gregkh@linuxfoundation.org>, <clm@fb.com>, <josef@toxicpanda.com>,
	<dsterba@suse.com>, <jack@suse.com>, <tytso@mit.edu>,
	<adilger.kernel@dilger.ca>, <dushistov@mail.ru>,
	<luc.vanoostenryck@gmail.com>, <rostedt@goodmis.org>, <pmladek@suse.com>,
	<sergey.senozhatsky@gmail.com>, <andriy.shevchenko@linux.intel.com>,
	<linux@rasmusvillemoes.dk>, <minchan@kernel.org>, <ngupta@vflare.org>,
	<akpm@linux-foundation.org>, <kuznet@ms2.inr.ac.ru>,
	<yoshfuji@linux-ipv6.org>, <pablo@netfilter.org>, <kadlec@netfilter.org>,
	<fw@strlen.de>, <jmaloy@redhat.com>, <ying.xue@windriver.com>,
	<willy@infradead.org>, <farbere@amazon.com>, <sashal@kernel.org>,
	<ruanjinjie@huawei.com>, <David.Laight@ACULAB.COM>,
	<herve.codina@bootlin.com>, <Jason@zx2c4.com>, <bvanassche@acm.org>,
	<keescook@chromium.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-um@lists.infradead.org>,
	<linux-edac@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
	<freedreno@lists.freedesktop.org>, <linux-hwmon@vger.kernel.org>,
	<linux-input@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
	<linux-staging@lists.linux.dev>, <linux-btrfs@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <linux-sparse@vger.kernel.org>,
	<linux-mm@kvack.org>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, <tipc-discussion@lists.sourceforge.net>,
	<stable@vger.kernel.org>
CC: <jonnyc@amazon.com>, Christoph Hellwig <hch@infradead.org>, Linus Torvalds
	<torvalds@linux-foundation.org>
Subject: [PATCH 08/27 5.10.y] minmax: allow min()/max()/clamp() if the arguments have the same signedness.
Date: Fri, 19 Sep 2025 10:17:08 +0000
Message-ID: <20250919101727.16152-9-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919101727.16152-1-farbere@amazon.com>
References: <20250919101727.16152-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC004.ant.amazon.com (10.13.139.205) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

From: David Laight <David.Laight@ACULAB.COM>

[ Upstream commit d03eba99f5bf7cbc6e2fdde3b6fa36954ad58e09 ]

The type-check in min()/max() is there to stop unexpected results if a
negative value gets converted to a large unsigned value.  However it also
rejects 'unsigned int' v 'unsigned long' compares which are common and
never problematc.

Replace the 'same type' check with a 'same signedness' check.

The new test isn't itself a compile time error, so use static_assert() to
report the error and give a meaningful error message.

Due to the way builtin_choose_expr() works detecting the error in the
'non-constant' side (where static_assert() can be used) also detects
errors when the arguments are constant.

Link: https://lkml.kernel.org/r/fe7e6c542e094bfca655abcd323c1c98@AcuMS.aculab.com
Signed-off-by: David Laight <david.laight@aculab.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 include/linux/minmax.h | 60 ++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 28 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 2a197f54fe05..8718fd71a793 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -12,9 +12,8 @@
  *
  * - avoid multiple evaluations of the arguments (so side-effects like
  *   "x++" happen only once) when non-constant.
- * - perform strict type-checking (to generate warnings instead of
- *   nasty runtime surprises). See the "unnecessary" pointer comparison
- *   in __typecheck().
+ * - perform signed v unsigned type-checking (to generate compile
+ *   errors instead of nasty runtime surprises).
  * - retain result as a constant expressions when called with only
  *   constant expressions (to avoid tripping VLA warnings in stack
  *   allocation usage).
@@ -22,23 +21,30 @@
 #define __typecheck(x, y) \
 	(!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
 
-#define __no_side_effects(x, y) \
-		(__is_constexpr(x) && __is_constexpr(y))
+/* is_signed_type() isn't a constexpr for pointer types */
+#define __is_signed(x) 								\
+	__builtin_choose_expr(__is_constexpr(is_signed_type(typeof(x))),	\
+		is_signed_type(typeof(x)), 0)
 
-#define __safe_cmp(x, y) \
-		(__typecheck(x, y) && __no_side_effects(x, y))
+#define __types_ok(x, y) \
+	(__is_signed(x) == __is_signed(y))
 
-#define __cmp(x, y, op)	((x) op (y) ? (x) : (y))
+#define __cmp_op_min <
+#define __cmp_op_max >
 
-#define __cmp_once(x, y, unique_x, unique_y, op) ({	\
+#define __cmp(op, x, y)	((x) __cmp_op_##op (y) ? (x) : (y))
+
+#define __cmp_once(op, x, y, unique_x, unique_y) ({	\
 		typeof(x) unique_x = (x);		\
 		typeof(y) unique_y = (y);		\
-		__cmp(unique_x, unique_y, op); })
+		static_assert(__types_ok(x, y),		\
+			#op "(" #x ", " #y ") signedness error, fix types or consider u" #op "() before " #op "_t()"); \
+		__cmp(op, unique_x, unique_y); })
 
-#define __careful_cmp(x, y, op) \
-	__builtin_choose_expr(__safe_cmp(x, y), \
-		__cmp(x, y, op), \
-		__cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
+#define __careful_cmp(op, x, y)					\
+	__builtin_choose_expr(__is_constexpr((x) - (y)),	\
+		__cmp(op, x, y),				\
+		__cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
 
 #define __clamp(val, lo, hi)	\
 	((val) >= (hi) ? (hi) : ((val) <= (lo) ? (lo) : (val)))
@@ -47,17 +53,15 @@
 		typeof(val) unique_val = (val);				\
 		typeof(lo) unique_lo = (lo);				\
 		typeof(hi) unique_hi = (hi);				\
+		static_assert(__builtin_choose_expr(__is_constexpr((lo) > (hi)), 	\
+				(lo) <= (hi), true),					\
+			"clamp() low limit " #lo " greater than high limit " #hi);	\
+		static_assert(__types_ok(val, lo), "clamp() 'lo' signedness error");	\
+		static_assert(__types_ok(val, hi), "clamp() 'hi' signedness error");	\
 		__clamp(unique_val, unique_lo, unique_hi); })
 
-#define __clamp_input_check(lo, hi)					\
-        (BUILD_BUG_ON_ZERO(__builtin_choose_expr(			\
-                __is_constexpr((lo) > (hi)), (lo) > (hi), false)))
-
 #define __careful_clamp(val, lo, hi) ({					\
-	__clamp_input_check(lo, hi) +					\
-	__builtin_choose_expr(__typecheck(val, lo) && __typecheck(val, hi) && \
-			      __typecheck(hi, lo) && __is_constexpr(val) && \
-			      __is_constexpr(lo) && __is_constexpr(hi),	\
+	__builtin_choose_expr(__is_constexpr((val) - (lo) + (hi)),	\
 		__clamp(val, lo, hi),					\
 		__clamp_once(val, lo, hi, __UNIQUE_ID(__val),		\
 			     __UNIQUE_ID(__lo), __UNIQUE_ID(__hi))); })
@@ -67,14 +71,14 @@
  * @x: first value
  * @y: second value
  */
-#define min(x, y)	__careful_cmp(x, y, <)
+#define min(x, y)	__careful_cmp(min, x, y)
 
 /**
  * max - return maximum of two values of the same or compatible types
  * @x: first value
  * @y: second value
  */
-#define max(x, y)	__careful_cmp(x, y, >)
+#define max(x, y)	__careful_cmp(max, x, y)
 
 /**
  * umin - return minimum of two non-negative values
@@ -83,7 +87,7 @@
  * @y: second value
  */
 #define umin(x, y)	\
-	__careful_cmp((x) + 0u + 0ul + 0ull, (y) + 0u + 0ul + 0ull, <)
+	__careful_cmp(min, (x) + 0u + 0ul + 0ull, (y) + 0u + 0ul + 0ull)
 
 /**
  * umax - return maximum of two non-negative values
@@ -91,7 +95,7 @@
  * @y: second value
  */
 #define umax(x, y)	\
-	__careful_cmp((x) + 0u + 0ul + 0ull, (y) + 0u + 0ul + 0ull, >)
+	__careful_cmp(max, (x) + 0u + 0ul + 0ull, (y) + 0u + 0ul + 0ull)
 
 /**
  * min3 - return minimum of three values
@@ -143,7 +147,7 @@
  * @x: first value
  * @y: second value
  */
-#define min_t(type, x, y)	__careful_cmp((type)(x), (type)(y), <)
+#define min_t(type, x, y)	__careful_cmp(min, (type)(x), (type)(y))
 
 /**
  * max_t - return maximum of two values, using the specified type
@@ -151,7 +155,7 @@
  * @x: first value
  * @y: second value
  */
-#define max_t(type, x, y)	__careful_cmp((type)(x), (type)(y), >)
+#define max_t(type, x, y)	__careful_cmp(max, (type)(x), (type)(y))
 
 /*
  * Do not check the array parameter using __must_be_array().
-- 
2.47.3


