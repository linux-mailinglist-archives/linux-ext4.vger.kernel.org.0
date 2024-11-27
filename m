Return-Path: <linux-ext4+bounces-5428-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8573D9DA181
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Nov 2024 05:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BA6D284F17
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Nov 2024 04:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899E513AA4C;
	Wed, 27 Nov 2024 04:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YtccUxTo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A576B1946B;
	Wed, 27 Nov 2024 04:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732681733; cv=none; b=ir12pYgSN5qC5cTmpJ3X+2a/j92OntJd2Tkn/5XSWYXo6FZzg/ZByzt0Pn2owTIN8fSW+DkXlJLfX5JA9mNCEq6odro8Y2tBPW3zVlUc6vzKfDBMYN+7kF4AoWquXQpc2HSUvEWj6fXfdmdzBdJ4iuW9koK4eHq7I5dJBlGX6JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732681733; c=relaxed/simple;
	bh=zIZUtccjQaXuP1DNrGBbAlK0knIHTFq1Wi6GDqRu/iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYSsZ1CLJ2Sg2n9/Nbasf+aW2g4EKNDvVVtdHKmbrNy5oamye7aJJ9GjIkMy2Un/L6JBepTFhJrHYsVxxk8XusETppmwSVp9L07xRdBXTXBjgjEClrMHzRBHa5UhF9MmYyqtMaTeh5Azu/Q7mNqiZtdiLp0m3msC1GNa9ymCRt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YtccUxTo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR1hA8C010828;
	Wed, 27 Nov 2024 04:28:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lyn5ZLAQU9i3GjR0R
	e6XvqZfaGJ+de974m+KxoDH57o=; b=YtccUxTogS9LsXvbDBuXgM/VvAvR4UTIi
	DkxducslMDQ7RwX10CJaKIvx2P+a0ZpigavvvhcEP5Nldq2jfdok6WsPQQdQmxrR
	2megdgmyBOO2Hy2G3QrK06az/lLhbESA0uHsvz1IavYirwbYgYn4O0dj1b/opmve
	vrRzKCg+U30gnvZUEbYg3DlyC55iC+vsR+tzRz9FpgXYDl+kfIzuw0lXueLSbhwI
	oOzGsY0n1qaV7+3mnMbrcLGCv0c+sdjm0qmwXSiSdEk0Z4H/K+3BIqaichfyFkfR
	x0ytmDjUzWBONy5LHbZctpbA3lTEdXxb31b0qhjVqOJIqXGLfG2Uw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386k1bmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 04:28:48 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AR4SlRw032157;
	Wed, 27 Nov 2024 04:28:47 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386k1bmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 04:28:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR15eYB026351;
	Wed, 27 Nov 2024 04:28:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 433v30wm95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 04:28:46 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AR4Shl113959626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Nov 2024 04:28:43 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DB982004B;
	Wed, 27 Nov 2024 04:28:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D68B820043;
	Wed, 27 Nov 2024 04:28:41 +0000 (GMT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com.com (unknown [9.39.20.219])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Nov 2024 04:28:41 +0000 (GMT)
From: Nirjhar Roy <nirjhar@linux.ibm.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
        zlang@kernel.org, nirjhar@linux.ibm.com
Subject: [PATCH v5 2/3] common/rc: Add a new _require_scratch_extsize helper function
Date: Wed, 27 Nov 2024 09:58:00 +0530
Message-ID: <fbc317332fb3d76680f65eb0c697f8c16b958bc4.1732681064.git.nirjhar@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1732681064.git.nirjhar@linux.ibm.com>
References: <cover.1732681064.git.nirjhar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZNX7PZgBj2G9z9LCTOj9rUofZryeQ8fd
X-Proofpoint-GUID: bTPwXHm5bKdFVjFwCO4KAPX7Ow2uonHr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxlogscore=867 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411270035

_require_scratch_extsize helper function will be used in the
the next patch to make the test run only on filesystems with
extsize support.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


