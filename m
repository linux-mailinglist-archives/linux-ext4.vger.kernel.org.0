Return-Path: <linux-ext4+bounces-5407-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EDF9D9183
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Nov 2024 06:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF749B242DA
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Nov 2024 05:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EF0156F5D;
	Tue, 26 Nov 2024 05:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A9wiF3kt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AFB539A;
	Tue, 26 Nov 2024 05:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732600513; cv=none; b=qFrHz//ARBoXwRGzlDFQIloHzj70Rn8B7jvl83mS5ydTNKKwDoMP8r3nUmIjbmF9aRHcV2ChYddnkEHUGhfDnFmjvHkvwTrB9634zYrAKb9B4R0GfC5nv5P6YsJh4XvxDcfmSxDVmhhCftUwaKpgckfj/EXuCnCDf4Tt2fUshQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732600513; c=relaxed/simple;
	bh=CaDVMohoxXn84V9gWdgX+JbjRuVIoYjz3Wnqdi9essk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sZNdTqm8dTShlkhvl7jzw3wLpmiu57kQs+c1DKOuX/q1UafbtHI7dUBusFhqpIrrUAHul1AgN63/7N7e4dU7xGQ21DXZjuPJVHYtr4sOe611EcDu5XaqZcnlXSTddVYS2o1K4Yi3Z43ZbSSdA8y9EAnNJ1n7OKTu1hB1xr4NkNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A9wiF3kt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APG7wW0002608;
	Tue, 26 Nov 2024 05:55:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=tu0eXTi7TcyDUYy0S9bMr8I1EpCoMgqFPMlBxDsOf
	mo=; b=A9wiF3ktiYYL6FrYXVPrP/OZrjd5CPPC3bsOX9Sza5UvKJjI4zS7rwBns
	QJzJ3mf0dyiUyFNBsUfkBjdxf5+CwWmxHulOV/xMB0qtxccI+dz5MqUY0rve7ybE
	cGptvuVG9yECay2USgKcf2OeYoKevLTRbEh90Id1PBlkH/FyWznqWT3TegpWesq3
	yWJkgPVo+fEmpLTQeRpnBje4oPhhdvPqJKB38Yoe8/HbxgfOg0gcjWqNZDNmPNIK
	gO5rtO3nKqSkHjPhjY7Mvl5RdUyPFC4eSJZb51QGLiF8UXenPBM/GahEzVPAOBd+
	AJeH9ZM77G1n9so2yNSd7q4XT64zg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43387bv6eq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 05:55:08 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AQ5t79x002212;
	Tue, 26 Nov 2024 05:55:07 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43387bv6ep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 05:55:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ4c7AS000875;
	Tue, 26 Nov 2024 05:55:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 433sry7dxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 05:55:06 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AQ5t2V760096950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 05:55:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 899812004B;
	Tue, 26 Nov 2024 05:55:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0EC520043;
	Tue, 26 Nov 2024 05:55:00 +0000 (GMT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com.com (unknown [9.124.222.125])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Nov 2024 05:55:00 +0000 (GMT)
From: Nirjhar Roy <nirjhar@linux.ibm.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
        zlang@kernel.org, nirjhar@linux.ibm.com
Subject: [PATCH v4 0/3] Addition of new tests for extsize hints
Date: Tue, 26 Nov 2024 11:24:05 +0530
Message-ID: <cover.1732599868.git.nirjhar@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QUwUk2eWbTEiwy7LF8NN_YT-dgj54vKh
X-Proofpoint-ORIG-GUID: P8_drfJVxsOUvJqtPAOV2gNeKLe0OaNa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=972 impostorscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411260043

This test checks the behaviour of xfs/ext4 filesystems when extsize
hint is set on files with inode size as 0, non-empty
files with allocated and delalloc extents and so on. 
This test set also tests one of the scenarios where setting extsize
hints on files with delayed allocation incorrectly succeeds and there is 
a recent patch series[1] that got merged[2] which fixes this.

Currently this test only runs in xfs but there is a patch series[3] in review 
that adds support for the extsize hints for ext4 as well.

I have tested it on ppc64le (with page size 64k) and x86_64 (with page size 4k).
The block sizes I have tested with are 2k, 4k, 8k, 16k, 32k, 64k with extsize being 
twice of the block size or 4 * block size(if the default extsize is 2 * blocksize). 
I have also tested with configurations where I added extszinherit mkfs option  
on the root. I had to enable CONFIG_TRANSPARENT_HUGEPAGE to enable block size 
greater than 4k on x86_64.

Changes since [v3]
 - Added RBs from Darrick on Patch-1 & 3
 - Added _require_xfs_io_command "extsize" in _require_scratch_extsize() in patch 2/3.
 - Renamed tests/generic/366 to tests/generic/367 since the former is now taken.
 - Removed an extra blank line in patch 2/3.

Changes since [v2]
 - Renamed _test_fsx_xflags_field() to _test_fsxattr_xflag().
 - Changed the definition of _test_fsx_xflags_field (now renamed to _test_fsxattr_xflag)
   to accept xflag names (like extsize, cowextsize) instead of single characters (like 'e') and 
   modified the callers of this function accordingly (in xfs/207 and generic/366)
 - Some changes in the comments in the setup() function of tests/generic/366.
 - Added another helper function _require_scratch_extsize(). 
 - Replaced the usage of _require_scratch() with _require_scratch_extsize() in tests/generic/366.
 - Fixed some indentation issues in the test scripts(xfs/207, generic/366) and the commit messages.

Changes since [v1]
 - Making the definition of _test_xfs_xflags_field() more compact and renamed 
   _test_xfs_xflags_field() to _test_fsx_xflags_field() since I moved it to common/rc.
 - Removed the explicit import of common/xfs from the test script.
 - Renamed the test file from generic/365 to generic/366 since generic/365 was taken.
 - Made the following functions in tests/generic/366 accept a second parameter (extsize)
     a) check_extsz_xflag_across_remount()
	 b) check_extsz_and_xflag()
	 c) read_file_extsize()
	 d) filter_extsz
	 This will help filter out any extsize that the test wants. This is required because, this 
	 version no longer assumes any particular fixed value of the default extsize.  
 - Removed the check for xflags in test_data_allocated() and test_data_delayed() test 
 - Added an extra line in output that denotes that we are checking that the extent size 
   hasn't changed if the xfs_io command fails (in test_data_allocated() and test_data_delayed() test).
 - Changed the new extsize to 4*blocksize if default extsize size is 2*blocksize to make 
   sure that the new extsize is not the same as the default extsize so that we can observe it changing.

[1] https://lore.kernel.org/all/20241015094509.678082-1-ojaswin@linux.ibm.com/
[2] kernel commit - 2a492ff66673
[3] https://lore.kernel.org/linux-ext4/cover.1726034272.git.ojaswin@linux.ibm.com/
[v1] https://lore.kernel.org/all/cover.1729624806.git.nirjhar@linux.ibm.com/
[v2] https://lore.kernel.org/all/cover.1731597226.git.nirjhar@linux.ibm.com/
[v3] https://lore.kernel.org/all/cover.1732126365.git.nirjhar@linux.ibm.com/

Nirjhar Roy (3):
  common/rc,xfs/207: Add a common helper function to check xflag bits
  common/rc: Add a new _require_scratch_extsize helper function
  generic: Addition of new tests for extsize hints

 common/rc             |  24 ++++++
 tests/generic/367     | 175 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/367.out |  26 +++++++
 tests/xfs/207         |  15 +---
 4 files changed, 229 insertions(+), 11 deletions(-)
 create mode 100755 tests/generic/367
 create mode 100644 tests/generic/367.out

-- 
2.43.5


