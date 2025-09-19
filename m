Return-Path: <linux-ext4+bounces-10255-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6311CB88097
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 08:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF431C83442
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 06:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B7C2C2372;
	Fri, 19 Sep 2025 06:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DTMyF5nn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7027D2C21F2;
	Fri, 19 Sep 2025 06:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758264512; cv=none; b=Mg1fKGmUpIMG3ZOtrj3TyIyPhB8HVnbdCLp5ExqETkA6a+W+j8p4AteW09U8al78PUyK3JCQTweukkuyVx7pu1vGbEmFL3LXxbqleKZD9WhiTo7yq3icF3GHf1t5AwPWvzLfgngg8W+PkBhUkg9201BdUPieF4W9QaXn5OrKCbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758264512; c=relaxed/simple;
	bh=2JqvJ/NmK7Vl8fIu8O+3jE4mt2NGdF8erJY3mQhxTPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoAqee9OffZkz7P/QRayIOYVZuuU2s+eTHbh9VBLX9gMh+qa9sjW38kBUM3/j24elEPxtc3fQ5dtSzFxwM5rncqWryH9HwsSLZHUlhlxBbMrpMlq8ofXA2qRze2k7h6EOXJrpUEka7/E0qJGWzcKgdY0YbrtCDT/j4h58oqVRtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DTMyF5nn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ILtVgX011259;
	Fri, 19 Sep 2025 06:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=DuIzAiNFOh2JfC6oT
	8Q9P797UvbN9UNxjQc+oYLCF3Q=; b=DTMyF5nnGsGMzt3833oTdaWtO+doEaE5b
	XepCA2wVMYpMEw1NFBG7gu8AwWGyWCVkFxI4+p0jNJwBYoE0UGxyoGdNEopvazqz
	t8BrcldgqowLHdNJIAZ+5fRPcYscnPfUP4YEs41lvwqmZ7JUOpcEYrOFmOzm3Lg9
	LwStFgUsOWmrX6dwX89TAVTSWetkQoOyY4ZisK7pF1PzD2If0yxDClTLvhE40V59
	LAbgH8zWn1n7PCQZFUvh0xT7zBt5UhU8whKPbflVQGclSIEseNVi02w2rO527/k+
	Fi1Xod4znGb7FgEXaUIfT7WUCwlPTybCMtfSdZbohqspQLp/X+gpw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4npbsr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:48:22 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58J6gH9W015223;
	Fri, 19 Sep 2025 06:48:22 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4npbsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:48:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58J5YZEQ027308;
	Fri, 19 Sep 2025 06:48:21 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495menjhcc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:48:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58J6mJUP57016726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 06:48:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A9242004B;
	Fri, 19 Sep 2025 06:48:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C231D20040;
	Fri, 19 Sep 2025 06:48:15 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.215.51])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Sep 2025 06:48:15 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v7 02/12] common/rc: Add fio atomic write helpers
Date: Fri, 19 Sep 2025 12:17:55 +0530
Message-ID: <8e87c6c800f6ca53f0c89af554b85197c7e397f1.1758264169.git.ojaswin@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=MN5gmNZl c=1 sm=1 tr=0 ts=68ccfcb6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8
 a=nFHpeJSrNhMDmVjzN9sA:9
X-Proofpoint-GUID: WO0zhzJyxN9gPLEM8QrMEPOlC41qcHCQ
X-Proofpoint-ORIG-GUID: w3W7rvgRaH8eT618dXO1MWaAxNKzBZsW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX9chtEZFALBsE
 q4+0ccx3a7XLzdVxejNUo6/1jEoAMYiFIqe/TRSfaVtAYzPi5r3jbbvX2/s8IDu1f/8CuSjXR1r
 hxfCqSRTSR39Gq8N02Yv9jw+MwhfuSFWVa5Pz14VdP5k6gchrdrX2CkDSQAlCqsZxHXqSfkSEvh
 69C/atzlxcXQptsS9iVB8/J/6DfFwiSKsWw6dxOKRr55to4jCHQLLV4SWBDJlreYpgoFxk+/Czm
 e806pwjVZdOKBBKc9//3gWsaiV2aTIl+tfZaoZGIr0TFnFW0La8yJWiN0SJoIW9xvHI8JgfByPM
 3vWkP8zhyM6boLXkR8Eq+wDaZVCapIHcn0Dl0yaVdy9SsSmemtzIzQ9fxybysysTJ0Jx7os9eaI
 R8/UIzam
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

The main motivation of adding this function on top of _require_fio is
that there has been a case in fio where atomic= option was added but
later it was changed to noop since kernel didn't yet have support for
atomic writes. It was then again utilized to do atomic writes in a later
version, once kernel got the support. Due to this there is a point in
fio where _require_fio w/ atomic=1 will succeed even though it would
not be doing atomic writes.

Hence, add an internal helper __require_fio_version to require specific
versions of fio to work past such issues. Further, add the high level
_require_fio_atomic_writes helper which tests can use to ensure fio
has the right version for atomic writes.

Reviewed-by: Zorro Lang <zlang@redhat.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 common/rc | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/common/rc b/common/rc
index 28fbbcbb..8a023b9d 100644
--- a/common/rc
+++ b/common/rc
@@ -6000,6 +6000,49 @@ _max() {
 	echo $ret
 }
 
+# Due to reasons explained in fio commit 40f1fc11d, fio version between
+# v3.33 and v3.38 have atomic= feature but it is a no-op and doesn't do
+# RWF_ATOMIC write. Hence, use this helper to ensure fio has the
+# required support. Currently, the simplest way we have is to ensure
+# the version.
+_require_fio_atomic_writes() {
+	__require_fio_version "3.38+"
+}
+
+# Check the required fio version. Examples:
+#   __require_fio_version 3.38 (matches 3.38 only)
+#   __require_fio_version 3.38+ (matches 3.38 and above)
+#   __require_fio_version 3.38- (matches 3.38 and below)
+#
+# Internal helper, avoid using directly in tests.
+__require_fio_version() {
+	local req_ver="$1"
+	local fio_ver
+
+	_require_fio
+	_require_math
+
+	fio_ver=$(fio -v | cut -d"-" -f2)
+
+	case "$req_ver" in
+	*+)
+		req_ver=${req_ver%+}
+		test $(_math "$fio_ver >= $req_ver") -eq 1 || \
+			_notrun "need fio >= $req_ver (found $fio_ver)"
+		;;
+	*-)
+		req_ver=${req_ver%-}
+		test $(_math "$fio_ver <= $req_ver") -eq 1 || \
+			_notrun "need fio <= $req_ver (found $fio_ver)"
+		;;
+	*)
+		req_ver=${req_ver%-}
+		test $(_math "$fio_ver == $req_ver") -eq 1 || \
+			_notrun "need fio = $req_ver (found $fio_ver)"
+		;;
+	esac
+}
+
 ################################################################################
 # make sure this script returns success
 /bin/true
-- 
2.49.0


