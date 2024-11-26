Return-Path: <linux-ext4+bounces-5409-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311509D9187
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Nov 2024 06:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC3216A92D
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Nov 2024 05:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3FC15B980;
	Tue, 26 Nov 2024 05:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I6tmprIe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2825539A;
	Tue, 26 Nov 2024 05:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732600560; cv=none; b=drFWC1h/LTjtxsjiifwKsnwB59tWrvSy8CTYLW6hiuelFwrogpTIxzgFLtyA0eQiNdPeTgnH8eFMJzfZb/CgK9Vt0B5MjBndCVIEwVXjWJFYK/XDfPdjkUtXg3KNXG6GKtnYWrgy+ilY+wCKTMdOFMk9onfRiE4GmGzaq8YmAQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732600560; c=relaxed/simple;
	bh=pvppd3h9pCl9h4dpqbvMB+ifgtYwrZyeQ6DwhyhLjrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBRUNNq4ZBlV1qSagfxxK8OMx486R2WEhbpIeMGq0PrqFiRMeQ5MtsHZxoASmSesAlGviN8JcTMw46vSkOH+UrxpKFA3FDnCmP8W84d/c6xe1VHIGHipSvyYQVqyxD7cvPTJRayrSvc/iEhdNdrW0cgBTFmOqP/88iS3mngQvdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I6tmprIe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APKwlpj026544;
	Tue, 26 Nov 2024 05:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6ED8R97tlLHAmmgOY
	NT1jH2BosysRwUomKhW/sf6xEE=; b=I6tmprIeJiDCDfV19bOKQyasNAMFF06f7
	hqF8LyJUErhdeDFaZrl+Gm+6dX9NMTuBbjaYtA7IaTCbetVBQwVDYL/4Fpus4z3v
	6TxuES7XJadmj3VhPYO8vEbWbtCtt1FUbDroh5k+Ot4ys2BcbeEAFjXboLy6Y1bz
	h3EcAd9KSEFMIGtfowRo1rQ3PKB49RjiqS1Q1GT7TV38+HakXt1qXOY8w907mJJA
	g+RqbBYMs/wywskI5JsMavsD/41QCpd2UDk9mFookhvFwyWV77pEtd1llmvvRXIk
	ueCZpDgf8tVxlx8O3YRai0u81cgIBmh6szN+RSI99xETgkvRCbUZA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4350rhhnf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 05:55:55 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AQ5r3Z6008388;
	Tue, 26 Nov 2024 05:55:55 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4350rhhnf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 05:55:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ4HTlQ026308;
	Tue, 26 Nov 2024 05:55:54 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 433v30upyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 05:55:54 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AQ5tpk865274302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 05:55:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66E2A2004B;
	Tue, 26 Nov 2024 05:55:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FC6C20043;
	Tue, 26 Nov 2024 05:55:49 +0000 (GMT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com.com (unknown [9.124.222.125])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Nov 2024 05:55:49 +0000 (GMT)
From: Nirjhar Roy <nirjhar@linux.ibm.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
        zlang@kernel.org, nirjhar@linux.ibm.com
Subject: [PATCH v4 2/3] common/rc: Add a new _require_scratch_extsize helper function
Date: Tue, 26 Nov 2024 11:24:07 +0530
Message-ID: <3e0f7be0799a990e2f6856f884e527a92585bf56.1732599868.git.nirjhar@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1732599868.git.nirjhar@linux.ibm.com>
References: <cover.1732599868.git.nirjhar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WIPaQ-w3hfkuM4gkioqIsFjYphsMcdql
X-Proofpoint-ORIG-GUID: dnTadOUWDLZEFZZMFQuJ2glAqycvYb5E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=903 bulkscore=0
 spamscore=0 impostorscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411260043

_require_scratch_extsize helper function will be used in the
the next patch to make the test run only on filesystems with
extsize support.

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
---
 common/rc | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/common/rc b/common/rc
index f94bee5e..e6c6047d 100644
--- a/common/rc
+++ b/common/rc
@@ -48,6 +48,23 @@ _test_fsxattr_xflag()
 	grep -q "fsxattr.xflags.*\[.*$2.*\]" <($XFS_IO_PROG -c "stat -v" "$1")
 }
 
+# This test requires extsize support on the  filesystem
+_require_scratch_extsize()
+{
+	_require_scratch
+	_require_xfs_io_command "extsize"
+	_scratch_mkfs > /dev/null
+	_scratch_mount
+	local filename=$SCRATCH_MNT/$RANDOM
+	local blksz=$(_get_block_size $SCRATCH_MNT)
+	local extsz=$(( blksz*2 ))
+	local res=$($XFS_IO_PROG -c "open -f $filename" -c "extsize $extsz" \
+		-c "extsize")
+	_scratch_unmount
+	grep -q "\[$extsz\] $filename" <(echo $res) || \
+		_notrun "this test requires extsize support on the filesystem"
+}
+
 # Write a byte into a range of a file
 _pwrite_byte() {
 	local pattern="$1"
-- 
2.43.5


