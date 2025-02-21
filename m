Return-Path: <linux-ext4+bounces-6526-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED50A3F38B
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Feb 2025 12:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281FD19C29BA
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Feb 2025 11:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A134209F27;
	Fri, 21 Feb 2025 11:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y1U7+FSX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421EC202F65
	for <linux-ext4@vger.kernel.org>; Fri, 21 Feb 2025 11:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740138970; cv=none; b=uCCF+R8glS/bLTNTCrytL+o35c3T/zTrS2t/hpv89yNSPbgMWReFJJJ6JPWWGVnXd+dS6+w6WGJuQ9FlH4zWu1Orcl8kmIdyq4P7On8KyegXlafCbLwwJh+DqnQIew87tyVuryJt6gTfg5fFzegFqQWOGNfET8Od4Kx5G2obQO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740138970; c=relaxed/simple;
	bh=6ZRpVG4Q3DUcw7u5TvKv4as2r8ddBs+x1Tf6XXIVnnU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=U3QTMwe7FUNgHw9jxBrxSHomMLmnXCEQhC/7jawuxfGwVKZG0zA3yuXc6P7OpZZC97MqNIbYMooQms23juiUp+Fw7GIMhdJDucuvkqpeMH4N2pJl2SdmKi8VIOkxdVPO+dVAWFJPgO+LuVoYjYYKvvG7WJJWYen0+dyQybAA2J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y1U7+FSX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L7Won2025057;
	Fri, 21 Feb 2025 11:56:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=cYx19BmLigT2xPiJCxioseEB8K9yNZdqTGAl2QLS9
	zw=; b=Y1U7+FSXCRK3893REnkaeTaEqkEbLrLSxTgO86jN8NTalUUq2zTuyox/C
	dacAI6kvk13wzNPiX80hsDpPcZ/HWTtfavDk+RqnzylbGFVkIi1HVHtqihp3dWRi
	28zGS4o7/UoN7KvxlBCf1fnN6I1BAubTA7qjJv8FIROuDG/GCUUGaWbTnwdTjWmI
	FtW0Bo6J4e12NLpPCVkM6xx/UYxNLHNf7M2TQZJ1Je4xYvbSm4VHsyU6r8rs7Pev
	DEHjSgcRONVd1sKz/bwwt37LL2jg7CF83SExuLybUJ9PCYEDzrpOrJ9mRu+tstyD
	pWj6f0fVlsEXv+c4/8XENg4TuXVtQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44xn6q17kt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 11:56:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51L93Ohu027066;
	Fri, 21 Feb 2025 11:56:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w025fsah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 11:56:04 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51LBu3N934800112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 11:56:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2641420040;
	Fri, 21 Feb 2025 11:56:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B8F22004E;
	Fri, 21 Feb 2025 11:56:02 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.29.169])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Feb 2025 11:56:02 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] kvm-xfstests: fix wget progress bar support
Date: Fri, 21 Feb 2025 17:26:01 +0530
Message-ID: <20250221115601.170674-1-ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: caxe5ycI406yRtmqK0iRYGDIrAPzt1aN
X-Proofpoint-ORIG-GUID: caxe5ycI406yRtmqK0iRYGDIrAPzt1aN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 phishscore=0 mlxlogscore=856 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210085

On fedora 41, running kvm-xfstest for the first time throws the
following error:

  Unknown option 'show-progress'

This is because fedora uses wget2 where the --show-progress flag
has been replaced with --force-progress [1]. Hence modify the code
to detect the wget version and use the appropriate flag.

[1] https://gitlab.com/gnuwget/wget2/-/wikis/Home#differing-cli-options-wgetwget2

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 run-fstests/kvm-xfstests | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/run-fstests/kvm-xfstests b/run-fstests/kvm-xfstests
index a53cc89..99e504b 100755
--- a/run-fstests/kvm-xfstests
+++ b/run-fstests/kvm-xfstests
@@ -60,7 +60,19 @@ if test -z "$EXPLICIT_ROOT_FS" ; then
 	f=root_fs.img.$ARCH
 	ROOT_FS="$(dirname $DIR)/test-appliance/$f"
 	echo "Downloading $f..."
-	wget -nv --show-progress -O "$ROOT_FS.new" "$DOWNLOAD_BASE_URL/$f"
+
+	# wget1 and 2 have different flags to show progress bar
+	WGET_VERSION=$(wget --version | head -n1 | awk '{print $3}' | cut -d. -f1)
+	if [[ "$WGET_VERSION" -eq 1 ]]; then
+			PROGRESS_FLAG="--show-progress"
+	elif [[ "$WGET_VERSION" -eq 2 ]]; then
+			PROGRESS_FLAG="--force-progress"
+	else
+			# don't show progress bar if we can't determine version
+			PROGRESS_FLAG=""
+	fi
+	wget -nv $PROGRESS_FLAG -O "$ROOT_FS.new" "$DOWNLOAD_BASE_URL/$f"
+
 	mv "$ROOT_FS.new" "$ROOT_FS"
     fi
 fi
-- 
2.48.1


