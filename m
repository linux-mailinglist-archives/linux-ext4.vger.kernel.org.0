Return-Path: <linux-ext4+bounces-9311-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6B0B1FA2E
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Aug 2025 15:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE3737A4E70
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Aug 2025 13:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E6926B2CE;
	Sun, 10 Aug 2025 13:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cnGefzni"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC852267B90;
	Sun, 10 Aug 2025 13:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754833346; cv=none; b=OZ5dZ5SamryKKkG6+RZw1O0Ejp1ud1OnjRdMvwsVYXCX+wHFN6PI+1FDa2Hy7x0grVTGflPca0Yyc/1o8QcCqkDGJjBCmSAL5o79elERM+e9OnfKRtj81jmGi+6QasCll/v5aNkg34OJKBdzl20u62MFtI/ff3U4PYECQtyS9A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754833346; c=relaxed/simple;
	bh=79qiw2SuzQ0NKfic8XwozhS2RgMiI+8hAc54bqoPj8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HzP2gfCZNeI9DF3CkEfXjFmGbq9j2W5VACUhzaq+mfhjKuJQU87YBgeOCBNmtZIJ4tPTP2/bZFlxI8a10F9xozD7EgJ0r66rhHnksPwOrKJk5x17tlKGuz8ibcYF4wauC1VQzfBlZCx+y52QjabdhFnps0ag3And5TKIXbS9Hds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cnGefzni; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57A8FjHZ000957;
	Sun, 10 Aug 2025 13:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qJnJXz1zUXhVLAvTx
	8/OljTBRqYdDL4cPrJBW4g2sIo=; b=cnGefznirgigd+HltdssMutrHMK7VHDfm
	Lckx1uB0qhJ0at8LZ+18NzBhx9qSjTAg8yHYllThcKlGlmUjOkeH4WgjR8Hs07PU
	jlPEDXUQvKtre+w7iRYxpKqdigk6hNZIdc3V9S0t34hKo9UjtsvQ5B0zTrqNCwdC
	P1L6vA0tZ2fEqS2T0YS+rbxWLlk9Mo8rs9ZbsRCyFFZ4QTKWJNvDDL1luWtHig/M
	fQiS4gori9skCwqU7MqLuDMwJYXTiTNB/LhN5lVZ2x+Llke7iacoKp5rjPkDM2a1
	FBbOJifrgrxcl0nTYNg3l+HnIvImdy07vESqOww692A/9+ndlRyeQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48eha9ssdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:42:17 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57ADgGXM023891;
	Sun, 10 Aug 2025 13:42:16 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48eha9ssdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:42:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57AD2skc020615;
	Sun, 10 Aug 2025 13:42:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48ehnphyyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:42:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57ADgEA954264164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Aug 2025 13:42:14 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C8F12004B;
	Sun, 10 Aug 2025 13:42:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A92FC20043;
	Sun, 10 Aug 2025 13:42:11 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.216.43])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 10 Aug 2025 13:42:11 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v4 03/11] ltp/fsx.c: Add atomic writes support to fsx
Date: Sun, 10 Aug 2025 19:11:54 +0530
Message-ID: <8b3c42eb321b4a1a4850b7e76d53191cb20ffa41.1754833177.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754833177.git.ojaswin@linux.ibm.com>
References: <cover.1754833177.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KPRaDEFo c=1 sm=1 tr=0 ts=6898a1b9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=T5_vRgAD47iBWrMonTEA:9
X-Proofpoint-ORIG-GUID: hiTZ9WUWmqOzPGQDaYLIzb7kPPfQ-Lmx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA5NyBTYWx0ZWRfXx02IJk0UmYf6
 vdvA5t53CDyuuNaCrdyccd+SKTredkfE087P5iYmqrI1Rnqdcgrc4JAe9qC1W5TidET4bFGO9YX
 dL45xCM8egX3wHanKREXBQRB08Gl4j2F78zD72zL/y7FbOY+/TfvoacslOccm6vrJ+GQtU015u8
 3FGt3Ehwi26sfI+OfZYVD1TKUsj32mcVf2YY0qLrT8n5oOym9NIkxPULEo2+/VvTFGkqjQQPMAJ
 2C4+zh0SKTB0gYzpNC8887K47qPob0ylqoL8tKXlsSDv1CTyVHtvW9sqLsrksaTNtpg1UMV4L5o
 SvcVcDie2Dn5YCepyJv2McmSX78xOGa+yVq4Hv/k7NOULNv2zyo4q4E2C++eIgJx8tBHcrz04ql
 N8hx9jqrWLi/QmKwRLKlN/4q/ATYXU7OOIQVYIXH//MhXh/d1O7EX1hqCKhj9SK3rPBdtpJP
X-Proofpoint-GUID: 37sJOD_7IDZNY1Hdd11t9L3Is5yFJW1z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508100097

Implement atomic write support to help fuzz atomic writes
with fsx.

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
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


