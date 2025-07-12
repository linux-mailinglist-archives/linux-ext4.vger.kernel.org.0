Return-Path: <linux-ext4+bounces-8950-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D57CDB02B3E
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 16:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9737189CD20
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 14:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504E2281531;
	Sat, 12 Jul 2025 14:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qH0fs1RS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B71F27F19B;
	Sat, 12 Jul 2025 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752329604; cv=none; b=F6FvnkOA51qdTj8eNdkcSPDRa844YQvbJEMW3OKmFkOKqbHN6tVeLISkGWiwL6V7vPLaSeG8v6wDxL3g6c1rUvEghqJnu8yDHINjP3N1NAR7MKSm/nPHTJN6a9Y0/gYFP10bBsz7obFiY4A9FtQMlxWTZ3me8Ai7MMNkWwTiSG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752329604; c=relaxed/simple;
	bh=JhF6Y6fJZhdiYaNs6VV47lmoUmyn0ue7rO4KOjdZttI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmLFU0X6NBxKVY0OiBxwZpjL02oXZ+EHWpLVh1B46O01fw9n1YJVT8uZgViipnIWK+ZLv+OFtnfcvq+vmUywfFM0E859YtNX8qQkL3On/AR6LYBgwrGakYmeUALIS+FTkGaYxx0SF1b0J4Xx+Sm8O3lwDZJQBvLuMnX3kNOp9mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qH0fs1RS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56C5tlQc024712;
	Sat, 12 Jul 2025 14:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rR9isvtN7ai/NIAtB
	zCznRhNhwv7hZuUJH4LTrJyRAI=; b=qH0fs1RS7ErerAVBPDED0AVW6MK9+PlQ4
	hvef/ox+lSQQ5pX0oJNWChDqirpeMHB2xD8rgkXoYlNx6cTT1XWKGg1gtNJTPVHl
	FAOGqZL88oNtk8zyA9ZXTOMIbB01tOF4vtzd0MhETuBlrgz7a1HEQvV6GQ7kIW9S
	hIoAAjYDtrUZqPHCzoCmhyI0Sd4oi/nSIvmWKH6xANrYFY5iwF4bRDi4dXnv5koi
	cy+j+oY01b+k2+ywbZ29LiE2LcF+O1uMrz19pLYXoUyMViuTU1ilCXD95IWZNS8+
	wf+bakG9tKAisiqjpt9oNJ40YeWEHXc3jVeq58U2acvJCDFtbu0fw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ud4st2yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:10 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56CED9mn004363;
	Sat, 12 Jul 2025 14:13:09 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ud4st2ye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56CAjAlZ025623;
	Sat, 12 Jul 2025 14:13:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfcpqe4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:09 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56CED7Bs18481598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Jul 2025 14:13:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12ABF20043;
	Sat, 12 Jul 2025 14:13:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C581B20040;
	Sat, 12 Jul 2025 14:13:04 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.215.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 12 Jul 2025 14:13:04 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v3 03/13] common/rc: Add a helper to run fsx on a given file
Date: Sat, 12 Jul 2025 19:42:45 +0530
Message-ID: <5334e25feda819fdc91e533d2ceaba05d9f711ac.1752329098.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDEwNCBTYWx0ZWRfX/B9QOG68Y1rP +RwGEzL/EGJkf940fCLkfie7sRc7G36AtgylnjQtEkcszCWeYOENgvpggSmw62QX1R/BWQyxUzR 3IzwbmeZ6itVjfL+9SRNAwZ1RajbbDgS1JI8jawsbCfsjdaOpEIYqVa2hppXiawo58o/gS88CkL
 M+zoEMcJHUy/0nD+nm6aI8LdPxiGdOobKPMU8sqvdziT4lrZeaQhW8mi5zGd+jGEQoVCuS3zg8G BFLTXFZ7u1fEpJ1pp71JqUBXGMEwuIGGvTG5dy1HTsUIL3V9G7z+UNWB1rRjhUxPUOtjNYRwB7d AWe66rZri2gDtuNJv2lxXbgcGtA6Suzndt/4DiQQbqe0g9tZpvpjke1mI3oqKnxUPEgabM+PLiR
 0mzKKPyiFdgv1O0P75emBhKRnOJ9NsWlm2+lWJgZsKlTVWTMAtZuVrgcYQyhYsKXyX9/CvfH
X-Proofpoint-GUID: wZbtfa2c4j2n5vgGTM6LuHWCaEHiFLZl
X-Proofpoint-ORIG-GUID: I0VXMQmKLIE6CoYSOhFxATCge8ZshRsa
X-Authority-Analysis: v=2.4 cv=KezSsRYD c=1 sm=1 tr=0 ts=68726d76 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=u_VYNAqGXo6OSSAA:21 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=EfcJlRrZmV05EoLhlkQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-12_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 clxscore=1015 suspectscore=0 phishscore=0 mlxlogscore=920 mlxscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507120104

Currently run_fsx is hardcoded to run on a file in $TEST_DIR.
Add a helper _run_fsx_on_file so that we can run fsx on any
given file including in $SCRATCH_MNT. Also, refactor _run_fsx
to use this helper.

No functional change is intended in this patch.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 common/rc | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/common/rc b/common/rc
index 218cf253..2d4592b6 100644
--- a/common/rc
+++ b/common/rc
@@ -5137,16 +5137,26 @@ _set_default_fsx_avoid() {
 	esac
 }
 
-_run_fsx()
+_run_fsx_on_file()
 {
+	local testfile=$1
+	shift
+
+	if ! [ -f $testfile ]
+	then
+		echo "_run_fsx_on_file: $testfile doesn't exist. Creating" >> $seqres.full
+		touch $testfile
+	fi
+
 	echo "fsx $*"
 	local args=`echo $@ | sed -e "s/ BSIZE / $bsize /g" -e "s/ PSIZE / $psize /g"`
 
 	_set_default_fsx_avoid $testfile
 
-	set -- $FSX_PROG $args $FSX_AVOID $TEST_DIR/junk
+	set -- $FSX_PROG $args $FSX_AVOID $testfile
+
 	echo "$@" >>$seqres.full
-	rm -f $TEST_DIR/junk
+	rm -f $testfile
 	"$@" 2>&1 | tee -a $seqres.full >$tmp.fsx
 	local res=${PIPESTATUS[0]}
 	if [ $res -ne 0 ]; then
@@ -5158,6 +5168,12 @@ _run_fsx()
 	return 0
 }
 
+_run_fsx()
+{
+	_run_fsx_on_file $TEST_DIR/junk $@
+	return $?
+}
+
 # Run fsx with -h(ugepage buffers).  If we can't set up a hugepage then skip
 # the test, but if any other error occurs then exit the test.
 _run_hugepage_fsx() {
-- 
2.49.0


