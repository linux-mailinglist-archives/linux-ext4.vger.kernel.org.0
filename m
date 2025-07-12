Return-Path: <linux-ext4+bounces-8949-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0E5B02B3F
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 16:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FE1F4A14C8
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 14:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA2627FB1E;
	Sat, 12 Jul 2025 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nEcxT5n1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0A027E7DE;
	Sat, 12 Jul 2025 14:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752329602; cv=none; b=ihLClI0l/mxoWEVsi0/KPza20JoYfVN/IfAyRcC+ay03LaFgIX9DooBPmpB7bcuU/+bCUiFDnXi2maYX4Fz7vuIi0qZ/bxSzLwgnZDjc0CAdcRF7gG7wjhgLs/FH64PzGsrNxvmGDLxC5ga+e6egbFEb3f0by/3GW+4G9ONOeqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752329602; c=relaxed/simple;
	bh=L65ns+3OHyXvWJnP/IHECk63yip6LPqKKecJne2Bbt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WH7t6bCRh0YpGr8aivbiXDm/VuUBpWrDOTiDFpwOzlOsxfbmr56njfkYC9MvZptw5JpSdd+gAwIAUqedqVWhvJa5nSglP8D6OMdliSJF+9p//nfrvX+gsT/3m2xLIvR3MCN9cJ+dGCsHuqXQMObdk4iE2oOpimOhE2UVV9BD0/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nEcxT5n1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56CDsafk011353;
	Sat, 12 Jul 2025 14:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2r62yGIrPPaKZ7oFj
	2c6pL63818SyYbPJ5gyNw4/7yQ=; b=nEcxT5n18CQAxIaByNvyi2m6AEtoRXpl6
	6bEsphSzzopw/85iyksd20TZYTymTDRhTNi4+sKd/n8xNeK5ptOZlLJV8b+I+2wE
	zHc7NKMzhBKQqlkMICpYJuuNBEj9weirLKa+2Vr+wWYWyssTJyMvwcFo8l5x6/q5
	l/NwmaNhpJvRAs8gritK1HASIIvB8vYQYvVcE0TLJiAUlgLvja3AasY9lKGRD3fh
	wICoB/6BudphC2G9YHCCIGqzjQ37MRB3KK/f5Qv2Xy9bKHLuxGG6clgJeFb8gIKt
	8unh9U4gndI/QpiOtRm7De8rq4rmu9W3CXiUJP4OXwMnLduHn9aXQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4thv41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:07 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56CE9W5i003156;
	Sat, 12 Jul 2025 14:13:06 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4thv3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56C9u6AP021566;
	Sat, 12 Jul 2025 14:13:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qecu7kx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56CED4tx17170730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Jul 2025 14:13:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48ED020043;
	Sat, 12 Jul 2025 14:13:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC4D220040;
	Sat, 12 Jul 2025 14:13:01 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.215.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 12 Jul 2025 14:13:01 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v3 02/13] common/rc: Fix fsx for ext4 with bigalloc
Date: Sat, 12 Jul 2025 19:42:44 +0530
Message-ID: <84a1820482419a1f1fb599bc35c2b7dcc1abbcb9.1752329098.git.ojaswin@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=baBrUPPB c=1 sm=1 tr=0 ts=68726d73 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=SMpRl3u3EVCsjR3gKCoA:9
X-Proofpoint-GUID: wPYYBxaqqJzXEf40DcdhiFLFC1O8moGX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDEwNyBTYWx0ZWRfX0FmcW4qSAKYz ZWj09QziqfQehNSM3gigI9mk0ik+4IzJZTX8CjvJesrFntJPQBVVTRyF7yU+QHKdOs0M0B2JIBl eFMEWXdYiU3QGuDRjPmQfp5NP9GADcL8vFgcKWUMmvk/yOArm6nEtpq62LHWuSnBIo/LPDDDugN
 NHSbhiBzcFdu3mgS8GUcjrtSI8NTus/E4Nsc/pHbdGRfbY/z2MTkcB/Y9tls2aOdWxgwhxybI6+ 69ePpA+PQEheDWLQiutS6FiMo2NgHa2BKF28n0CKgyFptdU6Z5u8xTQ7XQy6XUry58wKRFr8qbS WycDZ3dkw1faJN5nPPVgQFOJUFquvK+YzYAJ1cc0/RWLZT8OGD7G42tGGZotjrJ27f/jsXnhzXS
 o7UytiC5uTJl2rP7mZ1cU0hacEa6B9AxkXReWbKQlUwUHexMZxGKHJHvU3mjU+wt0PC37eve
X-Proofpoint-ORIG-GUID: Etm8vHtN0NX0TiSLUp5xPbW51wo9OnR7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-12_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507120107

Insert range and collapse range only works with bigalloc in case
the range is cluster size aligned, which fsx doesnt take care. To
work past this, disable insert range and collapse range on ext4, if
bigalloc is enabled.

This is achieved by defining a new function _set_default_fsx_avoid
called via run_fsx helper. This can be used to selectively disable
fsx options based on the configuration.

Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 common/rc | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/common/rc b/common/rc
index 9a9d3cc8..218cf253 100644
--- a/common/rc
+++ b/common/rc
@@ -5113,10 +5113,37 @@ _require_hugepage_fsx()
 		_notrun "fsx binary does not support MADV_COLLAPSE"
 }
 
+_set_default_fsx_avoid() {
+	local file=$1
+
+	case "$FSTYP" in
+	"ext4")
+		local dev=$(findmnt -n -o SOURCE --target $file)
+
+		# open code instead of _require_dumpe2fs cause we don't
+		# want to _notrun if dumpe2fs is not available
+		if [ -z "$DUMPE2FS_PROG" ]; then
+			echo "_set_default_fsx_avoid: dumpe2fs not found, skipping bigalloc check." >> $seqres.full
+			return
+		fi
+
+		$DUMPE2FS_PROG -h $dev 2>&1 | grep -q bigalloc && {
+			export FSX_AVOID+=" -I -C"
+		}
+		;;
+	# Add other filesystem types here as needed
+	*)
+		;;
+	esac
+}
+
 _run_fsx()
 {
 	echo "fsx $*"
 	local args=`echo $@ | sed -e "s/ BSIZE / $bsize /g" -e "s/ PSIZE / $psize /g"`
+
+	_set_default_fsx_avoid $testfile
+
 	set -- $FSX_PROG $args $FSX_AVOID $TEST_DIR/junk
 	echo "$@" >>$seqres.full
 	rm -f $TEST_DIR/junk
-- 
2.49.0


