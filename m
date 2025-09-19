Return-Path: <linux-ext4+bounces-10259-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 414D4B880D0
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 08:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 432837AD60B
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 06:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E31E2D3740;
	Fri, 19 Sep 2025 06:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dzRe8Sjt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392D72C11DB;
	Fri, 19 Sep 2025 06:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758264527; cv=none; b=NIseWR+e5xEkgNnKcpN6bULwdSoIMk4B6gz+CuyUiRftsSdiaLLT9VA/tvfbg0FjMlfNmDEn0MEcVjENWzM77W5zMS46bclIiSZo2bKEy9FL3k1RNACzGTJTXqaqhT3gXpMu52A63BP2rcBlIra2iUY9WVVpqsjpKiR0H55ubsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758264527; c=relaxed/simple;
	bh=LioGuSv8gh+FACLKetBabaA1JxM4E2bYxoWLiAjfvzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sIY16Cfaa+ykxss64tJTX1xDodQTYupP+Ohtaqh66tM+rAt5G1RXQO8bX4nF1BWm3gyNF0C5y4+g46Dmq+MQiDKsp+wr/f6qwMMjPwIVYCSULQlkyeWYW+dXBkrnhOsmT3+7G/VAHLwnfx0vXYcdARtJeRzccfcz2l3VBrzHuE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dzRe8Sjt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IKYRiQ012254;
	Fri, 19 Sep 2025 06:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=x4NGr1m/Xveh2pPYm
	VjLzXxjLOVjo2c7XJc+kcjJ/70=; b=dzRe8Sjt/8IAFSNjE8CuNj4EpvPSpPZ86
	QRo5Y6WQmiOtlD3RH6cGGjZFVzQfZG/A1ZiFJUQ7DQFIg0SRkN0/rDqWTiA0YeQ4
	pOnrozojl7wEif2XDBqzHRw3duLCJWemLKdp/rP0YqL+VUkyKguzF6Z0tisswvog
	p2Lz3b4WauctaIILb1VqMyNFkyPpHoHVJ88+yHh/2mzlFkCx90SuWBcKjUdGb8sD
	fa8jKs48BIjnzCOEu7gcBreObKzfPWVva93p5HJn1Lvo69PR+vD2ySV9uDTlq/5b
	3lKxm7P1dtugQeacPoHILKIiIbPn2k5oAeO9WAanDRi1qg8pGefJg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4jeya0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:48:30 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58J6mUOi019914;
	Fri, 19 Sep 2025 06:48:30 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4jey9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:48:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58J4mvsk029536;
	Fri, 19 Sep 2025 06:48:29 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kb1atpj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:48:28 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58J6mRTv51380576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 06:48:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0408D20043;
	Fri, 19 Sep 2025 06:48:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E86CB20040;
	Fri, 19 Sep 2025 06:48:23 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.215.51])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Sep 2025 06:48:23 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v7 04/12] ltp/fsx.c: Add atomic writes support to fsx
Date: Fri, 19 Sep 2025 12:17:57 +0530
Message-ID: <c3a040b249485b02b569b9269b649d02d721d995.1758264169.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1758264169.git.ojaswin@linux.ibm.com>
References: <cover.1758264169.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Qf5mvtbv c=1 sm=1 tr=0 ts=68ccfcbe cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=VnNF1IyMAAAA:8 a=oUtnbjD3gOVQiAq08lgA:9
X-Proofpoint-ORIG-GUID: lQfq2T531J8HqO0bs_vjtDuPYDZQz_ha
X-Proofpoint-GUID: FE9MHaDSlG2E1bQT-Z1BwvEg56If9nQ8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX72WePjYQfV1T
 zfG3PubLCjKuXILzQgZ/pvKLAn/YUsZPzHZU0wu8yb4zkD8GORLmveY6jfd+eXD4mLgy63D6j2n
 GGDEjvY75j9/h3d0dFoQVuiPP5CQXf1ejpkkfv24e4XQRG1UeItEcF68+0ux8lpLTaTaVBpbouO
 5/G5FU+i90KA3w+hB+XfR7uoO6pCCg64Wc9vFYwL8DZE+JHA3Vw4kweNjT4o8bujTD8L59zgJSe
 2R3w3WPyaRV/OQksB46aH6R8Jy0SNsGpNrhvhjtrzjUgTNSBEIAILxsBitE0rbQwP+0gYSy5eXZ
 QdC20z6borqb4eRZonsQNW7YIkFWHaCm0oDiMgYooq02ig5m4vv5L6n53LSudIkRJXdClWylHmG
 wuRejA/3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

Implement atomic write support to help fuzz atomic writes
with fsx.

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 ltp/fsx.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 110 insertions(+), 5 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 163b9453..bdb87ca9 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -40,6 +40,7 @@
 #include <liburing.h>
 #endif
 #include <sys/syscall.h>
+#include "statx.h"
 
 #ifndef MAP_FILE
 # define MAP_FILE 0
@@ -49,6 +50,10 @@
 #define RWF_DONTCACHE	0x80
 #endif
 
+#ifndef RWF_ATOMIC
+#define RWF_ATOMIC	0x40
+#endif
+
 #define NUMPRINTCOLUMNS 32	/* # columns of data to print on each line */
 
 /* Operation flags (bitmask) */
@@ -110,6 +115,7 @@ enum {
 	OP_READ_DONTCACHE,
 	OP_WRITE,
 	OP_WRITE_DONTCACHE,
+	OP_WRITE_ATOMIC,
 	OP_MAPREAD,
 	OP_MAPWRITE,
 	OP_MAX_LITE,
@@ -200,6 +206,11 @@ int	uring = 0;
 int	mark_nr = 0;
 int	dontcache_io = 1;
 int	hugepages = 0;                  /* -h flag */
+int	do_atomic_writes = 1;		/* -a flag disables */
+
+/* User for atomic writes */
+int awu_min = 0;
+int awu_max = 0;
 
 /* Stores info needed to periodically collapse hugepages */
 struct hugepages_collapse_info {
@@ -288,6 +299,7 @@ static const char *op_names[] = {
 	[OP_READ_DONTCACHE] = "read_dontcache",
 	[OP_WRITE] = "write",
 	[OP_WRITE_DONTCACHE] = "write_dontcache",
+	[OP_WRITE_ATOMIC] = "write_atomic",
 	[OP_MAPREAD] = "mapread",
 	[OP_MAPWRITE] = "mapwrite",
 	[OP_TRUNCATE] = "truncate",
@@ -422,6 +434,7 @@ logdump(void)
 				prt("\t***RRRR***");
 			break;
 		case OP_WRITE_DONTCACHE:
+		case OP_WRITE_ATOMIC:
 		case OP_WRITE:
 			prt("WRITE    0x%x thru 0x%x\t(0x%x bytes)",
 			    lp->args[0], lp->args[0] + lp->args[1] - 1,
@@ -1073,6 +1086,25 @@ update_file_size(unsigned offset, unsigned size)
 	file_size = offset + size;
 }
 
+static int is_power_of_2(unsigned n) {
+	return ((n & (n - 1)) == 0);
+}
+
+/*
+ * Round down n to nearest power of 2.
+ * If n is already a power of 2, return n;
+ */
+static int rounddown_pow_of_2(int n) {
+	int i = 0;
+
+	if (is_power_of_2(n))
+		return n;
+
+	for (; (1 << i) < n; i++);
+
+	return 1 << (i - 1);
+}
+
 void
 dowrite(unsigned offset, unsigned size, int flags)
 {
@@ -1081,6 +1113,27 @@ dowrite(unsigned offset, unsigned size, int flags)
 	offset -= offset % writebdy;
 	if (o_direct)
 		size -= size % writebdy;
+	if (flags & RWF_ATOMIC) {
+		/* atomic write len must be between awu_min and awu_max */
+		if (size < awu_min)
+			size = awu_min;
+		if (size > awu_max)
+			size = awu_max;
+
+		/* atomic writes need power-of-2 sizes */
+		size = rounddown_pow_of_2(size);
+
+		/* atomic writes need naturally aligned offsets */
+		offset -= offset % size;
+
+		/* Skip the write if we are crossing max filesize */
+		if ((offset + size) > maxfilelen) {
+			if (!quiet && testcalls > simulatedopcount)
+				prt("skipping atomic write past maxfilelen\n");
+			log4(OP_WRITE_ATOMIC, offset, size, FL_SKIPPED);
+			return;
+		}
+	}
 	if (size == 0) {
 		if (!quiet && testcalls > simulatedopcount && !o_direct)
 			prt("skipping zero size write\n");
@@ -1088,7 +1141,10 @@ dowrite(unsigned offset, unsigned size, int flags)
 		return;
 	}
 
-	log4(OP_WRITE, offset, size, FL_NONE);
+	if (flags & RWF_ATOMIC)
+		log4(OP_WRITE_ATOMIC, offset, size, FL_NONE);
+	else
+		log4(OP_WRITE, offset, size, FL_NONE);
 
 	gendata(original_buf, good_buf, offset, size);
 	if (offset + size > file_size) {
@@ -1108,8 +1164,9 @@ dowrite(unsigned offset, unsigned size, int flags)
 		       (monitorstart == -1 ||
 			(offset + size > monitorstart &&
 			(monitorend == -1 || offset <= monitorend))))))
-		prt("%lld write\t0x%x thru\t0x%x\t(0x%x bytes)\tdontcache=%d\n", testcalls,
-		    offset, offset + size - 1, size, (flags & RWF_DONTCACHE) != 0);
+		prt("%lld write\t0x%x thru\t0x%x\t(0x%x bytes)\tdontcache=%d atomic_wr=%d\n", testcalls,
+		    offset, offset + size - 1, size, (flags & RWF_DONTCACHE) != 0,
+		    (flags & RWF_ATOMIC) != 0);
 	iret = fsxwrite(fd, good_buf + offset, size, offset, flags);
 	if (iret != size) {
 		if (iret == -1)
@@ -1785,6 +1842,36 @@ do_dedupe_range(unsigned offset, unsigned length, unsigned dest)
 }
 #endif
 
+int test_atomic_writes(void) {
+	int ret;
+	struct statx stx;
+
+	if (o_direct != O_DIRECT) {
+		fprintf(stderr, "main: atomic writes need O_DIRECT (-Z), "
+				"disabling!\n");
+		return 0;
+	}
+
+	ret = xfstests_statx(AT_FDCWD, fname, 0, STATX_WRITE_ATOMIC, &stx);
+	if (ret < 0) {
+		fprintf(stderr, "main: Statx failed with %d."
+			" Failed to determine atomic write limits, "
+			" disabling!\n", ret);
+		return 0;
+	}
+
+	if (stx.stx_attributes & STATX_ATTR_WRITE_ATOMIC &&
+	    stx.stx_atomic_write_unit_min > 0) {
+		awu_min = stx.stx_atomic_write_unit_min;
+		awu_max = stx.stx_atomic_write_unit_max;
+		return 1;
+	}
+
+	fprintf(stderr, "main: IO Stack does not support "
+			"atomic writes, disabling!\n");
+	return 0;
+}
+
 #ifdef HAVE_COPY_FILE_RANGE
 int
 test_copy_range(void)
@@ -2356,6 +2443,12 @@ have_op:
 			goto out;
 		}
 		break;
+	case OP_WRITE_ATOMIC:
+		if (!do_atomic_writes) {
+			log4(OP_WRITE_ATOMIC, offset, size, FL_SKIPPED);
+			goto out;
+		}
+		break;
 	}
 
 	switch (op) {
@@ -2385,6 +2478,11 @@ have_op:
 			dowrite(offset, size, 0);
 		break;
 
+	case OP_WRITE_ATOMIC:
+		TRIM_OFF_LEN(offset, size, maxfilelen);
+		dowrite(offset, size, RWF_ATOMIC);
+		break;
+
 	case OP_MAPREAD:
 		TRIM_OFF_LEN(offset, size, file_size);
 		domapread(offset, size);
@@ -2511,13 +2609,14 @@ void
 usage(void)
 {
 	fprintf(stdout, "usage: %s",
-		"fsx [-dfhknqxyzBEFHIJKLORWXZ0]\n\
+		"fsx [-adfhknqxyzBEFHIJKLORWXZ0]\n\
 	   [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid]\n\
 	   [-l flen] [-m start:end] [-o oplen] [-p progressinterval]\n\
 	   [-r readbdy] [-s style] [-t truncbdy] [-w writebdy]\n\
 	   [-A|-U] [-D startingop] [-N numops] [-P dirpath] [-S seed]\n\
 	   [--replay-ops=opsfile] [--record-ops[=opsfile]] [--duration=seconds]\n\
 	   ... fname\n\
+	-a: disable atomic writes\n\
 	-b opnum: beginning operation number (default 1)\n\
 	-c P: 1 in P chance of file close+open at each op (default infinity)\n\
 	-d: debug output for all operations\n\
@@ -3059,9 +3158,13 @@ main(int argc, char **argv)
 	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
 
 	while ((ch = getopt_long(argc, argv,
-				 "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
+				 "0ab:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
 				 longopts, NULL)) != EOF)
 		switch (ch) {
+		case 'a':
+			prt("main(): Atomic writes disabled\n");
+			do_atomic_writes = 0;
+			break;
 		case 'b':
 			simulatedopcount = getnum(optarg, &endp);
 			if (!quiet)
@@ -3475,6 +3578,8 @@ main(int argc, char **argv)
 		exchange_range_calls = test_exchange_range();
 	if (dontcache_io)
 		dontcache_io = test_dontcache_io();
+	if (do_atomic_writes)
+		do_atomic_writes = test_atomic_writes();
 
 	while (keep_running())
 		if (!test())
-- 
2.49.0


