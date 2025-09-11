Return-Path: <linux-ext4+bounces-9927-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBB5B53A10
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Sep 2025 19:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02BD116E694
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Sep 2025 17:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8077369325;
	Thu, 11 Sep 2025 17:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JlHmvMoG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13D6362060;
	Thu, 11 Sep 2025 17:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610852; cv=none; b=VDA7VVNoHTiptq1kx9a6y0GvpDbkNqEOYbdYkKo4TPMiI9N93z7bdsLs4e6OLNJrl2a6Lv9MeiqxKH/tsyoKQSvR3vPKFn/blqqRsGBjW9ajdLFyoRpWm5H+YJ/gJYlOpS/+AUpiNeAr0au3KY4kEffL7ubc+ZLESLGEz9GTJ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610852; c=relaxed/simple;
	bh=6IuWXHYorbKtU5KjphGwTcVneKOi+9yl5hrmwhjpl5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjGv6r5gV3AJVKonmCmBFUgGXh4HmiJxmA9pVzEydZ5fdh00nfVlsvQ7RdUsQ3Ou87eawnjkNemPQOlZfn6iLKrjAd5IabjDJxUp0gmahrKs++LgXQUW7Jf1LQzADNtQgMlonLEZwqeUsQtpelEqPEhELnpZHVrJsW8CLtMvh3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JlHmvMoG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BBnATP021232;
	Thu, 11 Sep 2025 17:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=DN0Ra6Sl46iaxQ+Ne
	5dURRCrbnWTuvAamB6MEUibkRg=; b=JlHmvMoGBfVG7yLqbYiKLxuM1ty7UBHRa
	NVn9LY155KG1Ydiya+eSTaySIR/bgRY/bIuNt3FVw0B9jpp3RnmgpePoQ+0eqeE/
	mTiyxAU4jt5ZyZPnBXgqJqI4uor4QaabgXiymDi5HlJVnDeILIs31gd0NqPxgFNc
	Z8xCXx7UAuIcRMhkdKBOlMV8SJvpmOQco3DLMsAqTwgHeAqDQ2A/Bv7TmZ+/Ra+p
	/FAki/27xJnRBdlm18kfzh4FmEHCB/SUmh1az/2Y2bbUANz3+WtYNz1uTItTKvJr
	AT2au4K1fxnPn4sICYpjciomYggzd4rB3+QD10dx3cwubZpspd1Ow==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490uketu1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 17:14:03 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58BHCdPF010852;
	Thu, 11 Sep 2025 17:14:02 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490uketu1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 17:14:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58BGNBOF020499;
	Thu, 11 Sep 2025 17:14:01 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 490yp171tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 17:14:01 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58BHDxUx33423658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 17:13:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8D4F2004E;
	Thu, 11 Sep 2025 17:13:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B2F22005A;
	Thu, 11 Sep 2025 17:13:56 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.17.37])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Sep 2025 17:13:56 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v6 03/12] common/rc: Add a helper to run fsx on a given file
Date: Thu, 11 Sep 2025 22:43:34 +0530
Message-ID: <18c7546ebcb6dbf72d591f3c6f6b29101aa48b95.1757610403.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1757610403.git.ojaswin@linux.ibm.com>
References: <cover.1757610403.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDE5NSBTYWx0ZWRfX4K9UXJeFaGOQ
 GgnucfMrpjoW7rqAFQ6IdINU7RA6+PZp92f2Q4Rl8oYwqspBOdVhm7KaK9abZVCWLgMVtRT/+Hx
 A12LTyXAFyOqTO97V2KwjB6kN7D5n5nJxH05+jGKcqbBIhvWT+7zrg4ZOVdBhnOU63L5RUXtI6M
 5euP46jMwfNyPknL7bYrMmvgSFpPSVPLf5w5qt2JPXCBEcbIUHlvBBMsOxEfXQBmYgtKL+0wueS
 a2YLJhD38O/vECqXofrdLKdpNLKvymYByzRaFxHebfuhLojN3UYc6tXPQVP2Zy2ejOs/Y7G8q3I
 +JcQVFNAfZ/NoDXduTJX2pcGzYs2+7mte8FnAJtPynkMaIK0MJQ56odm3zhtzaGPdxOZeF7+bZE
 f4TEcRAh
X-Proofpoint-ORIG-GUID: aUsRPh8vz-wrOmch53l4wHefYSOFMP_t
X-Proofpoint-GUID: EeKEIUW_o4SiP1PyBIK6o7oWO9bFRYjp
X-Authority-Analysis: v=2.4 cv=StCQ6OO0 c=1 sm=1 tr=0 ts=68c3035b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=u_VYNAqGXo6OSSAA:21 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=EfcJlRrZmV05EoLhlkQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_02,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060195

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


