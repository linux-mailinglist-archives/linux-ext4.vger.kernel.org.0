Return-Path: <linux-ext4+bounces-9557-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9430B3111E
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Aug 2025 10:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A8075A6218
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Aug 2025 08:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A1F2EBDF2;
	Fri, 22 Aug 2025 08:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GH64L5LO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745DA2EAB8E;
	Fri, 22 Aug 2025 08:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755849761; cv=none; b=dbpEKkFDYdXph9UuuYROczaOMqBlyLSJQyyxTH1oqkYpTho71FI6c34rpINFDU8fivm1LNh2zK0jmhaAdxme3LfAEvK+63sZZ1XjkVcr/26Rcr6x40VXG2lCCo6GxG9DPS/7/41zfTxRqDQwjrb9OPaulu/akVPvwpc26UhS7s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755849761; c=relaxed/simple;
	bh=PGymx0PrCWx0rSx5jirmfScMWFXcrc17cbYCRh65R8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIAdNnJnFjTkWK6nqHjVhIL256RZZq3da9mL+rsIMV+soeMM3jrM5+oz4uMr4XipjZu/NAuQV/We33RgtFkhnknettq7t+ZCZf8a57cSQXKUoexcDVNNVm5j1iqj4mtvlMhmZ6vF79Vm0deuhwIIVm74eT6fUN6hUKIhu83//FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GH64L5LO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M7cxEO026013;
	Fri, 22 Aug 2025 08:02:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Ydj4+7gOr5w73AX63
	sXYfyK96HWJzRLoYcAq068iRWI=; b=GH64L5LOaDHopeW7OJMhxUt6uSNEm6NTL
	Bu0bbc71/kdYd1NcEigLfH0PvFqb2tBEa8PB74KAFyzUZW/ahUloqml79dpKQyrn
	LONxuF57oxvQPBho5x5I8LM2oL1/NXn2qy4HlNeHVNbHOfAse8VevPJVX4SfCA76
	BJkOoCQ53mAZNo58HXuD6pS4lv2wv307nFmt7OkKRZycTSU4M4iRa8nXfXvpN/VZ
	GrIR+LnatbEQWkJ8Po3yNkNfMSMRTEke4jV2vS/hosJHfIbOpMx47th/9S934UVS
	84+4MfCA/cJmHxSbrz1QHYpJtQ1uHIKaqxCdNHaSdO+0hsphUiMlA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vnbpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:02:25 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57M82Pqw031133;
	Fri, 22 Aug 2025 08:02:25 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vnbp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:02:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57M7dJR1016047;
	Fri, 22 Aug 2025 08:02:24 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my42cace-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:02:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57M82MAl53412202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 08:02:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C336420040;
	Fri, 22 Aug 2025 08:02:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 848AA2004B;
	Fri, 22 Aug 2025 08:02:20 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.210.10])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Aug 2025 08:02:20 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v5 03/12] common/rc: Add a helper to run fsx on a given file
Date: Fri, 22 Aug 2025 13:32:02 +0530
Message-ID: <f47d83fe7651afde6575e4f5e3b4aafa42f723a6.1755849134.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755849134.git.ojaswin@linux.ibm.com>
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfXwsQrW6ALsu+k
 dJ2LpZieupJ0leTUo+Z2EzRq8Q30oppXvBlf/+aBBuvRVReENKeHKhPp99CsO5LKZ5oJRAjvcVA
 KQYg4agw2MOR856oZrfJcrTVsFFHunKrRAO8IRvvfa+yu5/wrEDL4s4bgznbDYEU54LcUDupl4r
 CdQjaALYMKwvdAn0Qc615j33hnc2RAA0oODlpSMPxHk/AXlfgqQAihxMU399jf1DgAyjvmWqk7B
 CdVyAsV3+OeKQpI5zd/BbCmnWvcNBhg1xPfI8cwcwJNtXRPQnOptK1Ql+mlEt2qMGI0ff5exL+P
 W9iamVb0aqC0zaidLHaaPCh+FfYxLfCvICGXPbeOpuZHxgs6mCia5EYNn7XLCpck2zclNTpbYue
 2dAP9UdTWZQMAoB1RXBBp9A62iasaA==
X-Authority-Analysis: v=2.4 cv=PMlWOfqC c=1 sm=1 tr=0 ts=68a82412 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=u_VYNAqGXo6OSSAA:21 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=EfcJlRrZmV05EoLhlkQA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: cbwpB5PbxV34VfShdcjJEKjsx1MpRGmQ
X-Proofpoint-ORIG-GUID: BIW_vhtrVPiD9Uz1f_C9WJxVB0rwskoS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190222

Currently run_fsx is hardcoded to run on a file in $TEST_DIR.
Add a helper _run_fsx_on_file so that we can run fsx on any
given file including in $SCRATCH_MNT. Also, refactor _run_fsx
to use this helper.

No functional change is intended in this patch.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 common/rc | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/common/rc b/common/rc
index f45b9a38..85baa677 100644
--- a/common/rc
+++ b/common/rc
@@ -5200,13 +5200,24 @@ _require_hugepage_fsx()
 		_notrun "fsx binary does not support MADV_COLLAPSE"
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
-	set -- $FSX_PROG $args $FSX_AVOID $TEST_DIR/junk
+
+	set -- $FSX_PROG $args $FSX_AVOID $testfile
+
 	echo "$@" >>$seqres.full
-	rm -f $TEST_DIR/junk
+	rm -f $testfile
 	"$@" 2>&1 | tee -a $seqres.full >$tmp.fsx
 	local res=${PIPESTATUS[0]}
 	if [ $res -ne 0 ]; then
@@ -5218,6 +5229,12 @@ _run_fsx()
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


