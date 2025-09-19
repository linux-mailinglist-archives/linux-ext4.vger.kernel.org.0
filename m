Return-Path: <linux-ext4+bounces-10256-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BEAB880A0
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 08:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72FF9567845
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 06:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201782BEC42;
	Fri, 19 Sep 2025 06:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CTZrBG3k"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359AC2BEC26;
	Fri, 19 Sep 2025 06:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758264517; cv=none; b=cOgojQ4va2ryyvafJIYhj7a8HL/FgoWmrClYVCMuPxPsAzXww3qLGIBIP3/8O+abVkSaNOXbqJNGYK2H2pPcMQq12NUU9ZKENGT1s8QMBdXVjWzcqPBLUfIqlt7GadXEXlPU6ssjoCancyCCJ4Q757wwsbxYmPVQXqirSnQ03yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758264517; c=relaxed/simple;
	bh=eLun/YRHHykazaVnn6i45Z+pzdc3kn72i/dVNUgTmwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XjIwOTuKNlOZgIKmRWwOVdCxGKHSp6EvHapkC8MyC8dXZ00cCq4YHcHjlGQftBFNgRrZlufja+jJjNHeE5a9+1HwB5WAuNyhMI5MjdmzeuXxODTPhvpz4nV8nZ54CigaErjjYPFw6R5I/MAqlEVl/sUlN4TPbQ/kT8vEWFUH7QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CTZrBG3k; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58J4tQs9011358;
	Fri, 19 Sep 2025 06:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=se562Xeeq4/F+TqKO
	yQTZeEEX6qaNTC32TSkbPlkRY0=; b=CTZrBG3kGXeToviSzNujvI6Az8gFTxaYL
	KefFludfpTi+F3SXxOd2Zy8rLDj69PnP1tNgzz0NZH8ibYkxvuWG5ZKoexAeKN5m
	HbHmZa3lX2NP5vx4dxNoaQxq8X50bNMv8gaBbcl4xxhubnfA7l+gR77vVKi00N06
	vU78wGYhVPiDg68GOEIch8aaMgm71bsgGIVrC8TOUiHB3edNGjKNLAw7YZch5rGI
	5YUoosSplQoloNw/K+/hVq7s6NYWiXB9hsFtGxgdOC2/RBbTW/Eh90twOOFjHuoB
	oX0j5QMDTbJN2cE5Nwmh7wsDqOA3UTGu76b3U5pu9fvgQVJf2HE5w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4npbt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:48:26 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58J6khrv024091;
	Fri, 19 Sep 2025 06:48:26 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4npbt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:48:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58J6QrCJ027393;
	Fri, 19 Sep 2025 06:48:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495menjhch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:48:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58J6mNew52429298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 06:48:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5323520043;
	Fri, 19 Sep 2025 06:48:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DA8C20040;
	Fri, 19 Sep 2025 06:48:20 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.215.51])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Sep 2025 06:48:19 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v7 03/12] common/rc: Add a helper to run fsx on a given file
Date: Fri, 19 Sep 2025 12:17:56 +0530
Message-ID: <c229849b48ed3b4ca0757c9d61042a42161e4721.1758264169.git.ojaswin@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=MN5gmNZl c=1 sm=1 tr=0 ts=68ccfcba cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=u_VYNAqGXo6OSSAA:21 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=VnNF1IyMAAAA:8 a=EfcJlRrZmV05EoLhlkQA:9
X-Proofpoint-GUID: E_nYEFYF7MOoCdpq2kOjIs9U6dyr0psM
X-Proofpoint-ORIG-GUID: cZ-G_5miBbkywdq8494acneFJAUwTcUL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX/twCDT4VFxaW
 WAlG8lXJUMKfaF2Zrhx8vI0gGidpfarc/ccJL+ttZABAD1dVsChu/6M8QJnsTODZBtj9D1yk2Js
 LWjIkERTlm/Gs5h3wZ1Y7wqvxCWC6wUMBiDY0kSIAB4qqO3KFFW3CTmjUxwsnlSjMb5aULWBH7z
 CmuWOTrY+A5/Bz2N7pR3ceg4/sHZyhnbn7gyiahZ6/51YZ49jak0ijtcVAUONW76yMJYqCrRnXu
 mHC6j2h4BqqbgEr+nb7XffBmkiwfIi1AJdrQ1E1wKaivCTm9tBHCT/VKuAAI/L9enGG1zZC8DjC
 mPBMFX101beqlK9qgylBLXQv1rwqLb+sNOLoIwaB98BMo8UETsKxkMHbqDQ4n504isc6aRk3DTD
 MK6wpVlm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

Currently run_fsx is hardcoded to run on a file in $TEST_DIR.
Add a helper _run_fsx_on_file so that we can run fsx on any
given file including in $SCRATCH_MNT. Also, refactor _run_fsx
to use this helper.

No functional change is intended in this patch.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 common/rc | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/common/rc b/common/rc
index 8a023b9d..ac77a650 100644
--- a/common/rc
+++ b/common/rc
@@ -5203,13 +5203,24 @@ _require_hugepage_fsx()
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
@@ -5221,6 +5232,12 @@ _run_fsx()
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


