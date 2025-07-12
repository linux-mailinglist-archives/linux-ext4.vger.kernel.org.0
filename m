Return-Path: <linux-ext4+bounces-8948-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD47B02B3A
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 16:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B2B7A477A0
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 14:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F0427F00C;
	Sat, 12 Jul 2025 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WVMPybpy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F3027E052;
	Sat, 12 Jul 2025 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752329601; cv=none; b=RXJ17eTVcKIYc/9v7lpLG3w5muMOMYjCYtnf1h7SHmDuCHYzPdcqHdH87cnM4j44b5TFm67FEYhdvHkBY5vktGL5GGTjrbHa7Ipkmjt821IeIuDhTeVpDUi/bcnmlEw8ZefdnXxH3cKaHStMiDpyY0dg4XYktxsbOm6cyutLDDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752329601; c=relaxed/simple;
	bh=d7Zgw8QUj1NAkq/4ExPCxrIx++FdxvLpdzEAi4p1Hoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X7LeF7SIkEGF2SHATSvDsafzTAxPEz6/lWklB3J3bQs/XihWzH3L/bMBwhIoJ3z5BZD4IwsJZxtmTrz5oYQyLV4fljO9pUhltcFu3JRp8oBqcG/krA8NeiMiTy91EyoRyD+PFFCQYdQ+x9f4muWD0jUNOI2k0IUPgefIXmidfnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WVMPybpy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56C0PiMT024270;
	Sat, 12 Jul 2025 14:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+KKpbQs87NanNdRjU
	BLA8pJrlXjlbz/3c7g89DS6dS4=; b=WVMPybpyjEPR6hndhuS/qpBJNtea6BaDq
	usVJ7YY/ZOSuEZMwsyJniBZ9yPSspqLQ/g9BTlsgKD555ukX5AX15TLwiMvJt+cd
	9yBDeYQY17c6dZkXMz6Q6GAjkSyeeRu2puwLQ10WT2q5mWML4X2vfg4ttwXyPuRv
	E5SLbkWlKlm9GbH+YQLTB3NuRqDh/Fgmqub9ruKgs6S+m5v4avJfzI2Z7jDpRcUM
	etI2FxUY/TGjTPGo3toAQLMUGgau0TcFtY+yJm2C4ydi3+QIJgV5Q28GazNSQiRx
	Q0aoYt4YfmXM3m7xukwox3TPql5corFdCjGKr9PzNYo+hbXDzdraw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ud4st2ym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:13 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56CEDCCP004443;
	Sat, 12 Jul 2025 14:13:12 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ud4st2yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56CA1uSg025593;
	Sat, 12 Jul 2025 14:13:11 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfcpqe4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:11 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56CED9cZ54198630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Jul 2025 14:13:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D09E920043;
	Sat, 12 Jul 2025 14:13:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 761AF20040;
	Sat, 12 Jul 2025 14:13:07 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.215.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 12 Jul 2025 14:13:07 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v3 04/13] ltp/fsx.c: Add atomic writes support to fsx
Date: Sat, 12 Jul 2025 19:42:46 +0530
Message-ID: <5bbd19e1615ca2a485b3b430c92f0260ee576f5e.1752329098.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1752329098.git.ojaswin@linux.ibm.com>
References: <cover.1752329098.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDEwNCBTYWx0ZWRfXz6BBk2hcdQjm hXqEKZ+L+p9aoG4hJhg8P9VG6yqKj5SWzGBTZVAvruGMt+5vy3SIMLCJt31ps7AwQZv1pJzWUww PzCPn5bVmmUyK0dNN3fGgUD78+sHbR3LwqxfGxPP3diC5mOa6RVkriId1or67Jb3+EkT//ozOqG
 5Q6HacI4fqB5AvoAbwYJa79629ycZ6pRGnqvEtXO6lC5NgTCgEZfFrjf67pbXipizeMWZYKjuh9 MbmDpeIE1LZ+n7j92tpe89IpbINUKV2Tj0sKeEYrijQBJf8/bssLa+y4VjhV/ELxqGbn4YF59hu W+wK4n951c3SgBPdoNYtncAN+9u5yXUrj9EtaylCz06YnuMVpCH9J/4Cjcz3z3Tk+RuMfuD7U+S
 tswfLNYhNVotsA5HliwKYS90Efe3VN7DoH3pEzJ1qhsQmmKIOxseDMe4XqUcX3YbK6tLcxhn
X-Proofpoint-GUID: giGXp_R72a6TqscCI9uyzRTn-Hk13kcs
X-Proofpoint-ORIG-GUID: PpW8O8N-NFvxeXerkaDbs9h7882uNFKe
X-Authority-Analysis: v=2.4 cv=KezSsRYD c=1 sm=1 tr=0 ts=68726d79 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=T5_vRgAD47iBWrMonTEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-12_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 clxscore=1015 suspectscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507120104

Implement atomic write support to help fuzz atomic writes
with fsx.

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 ltp/fsx.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 104 insertions(+), 5 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 163b9453..ea39ca29 100644
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
+		/* atomic write len must be inbetween awu_min and awu_max */
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
@@ -1785,6 +1842,30 @@ do_dedupe_range(unsigned offset, unsigned length, unsigned dest)
 }
 #endif
 
+int test_atomic_writes(void) {
+	int ret;
+	struct statx stx;
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
@@ -2356,6 +2437,12 @@ have_op:
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
@@ -2385,6 +2472,11 @@ have_op:
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
@@ -2511,13 +2603,14 @@ void
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
@@ -3059,9 +3152,13 @@ main(int argc, char **argv)
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
@@ -3475,6 +3572,8 @@ main(int argc, char **argv)
 		exchange_range_calls = test_exchange_range();
 	if (dontcache_io)
 		dontcache_io = test_dontcache_io();
+	if (do_atomic_writes)
+		do_atomic_writes = test_atomic_writes();
 
 	while (keep_running())
 		if (!test())
-- 
2.49.0


