Return-Path: <linux-ext4+bounces-5187-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F6B9CD62B
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Nov 2024 05:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51D4A1F22750
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Nov 2024 04:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF8316F851;
	Fri, 15 Nov 2024 04:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g1PIQslr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CD77346D;
	Fri, 15 Nov 2024 04:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731644215; cv=none; b=hduYMA6DevUEk8t2B4v8OsCjXAhkarKSuMhiF4peJIoWIds17zjrGO3MRwZkQ7dZn2pYNuozRkK+SnC1r4hUGhEa114/kqtvSliso0vTOm7dzNBHgcZF7NuQ81Z1l6k/uZPkhBrWblcCIga6ceSNISqz89xeBJ5dfx83I8DXtTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731644215; c=relaxed/simple;
	bh=zUwUQ6296LnhvKe+0j91GW7QnWaEy76/ViYEQGVUE6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TtYsmvrtER3yU+fB+p662eQHDIy97Z414j/NscKkJKbwyfnJIaVgjWBXW/P5jBAU8QwUXVWEaJu5q776Hvlr6MClv1op2PY7DG9glYYTjxfgnUGo0/U0Yq4WSqLrzn1ZMer5S6wHRAaSi9rSaAQWgtn+jpkI4WOf8nwf94lSjdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g1PIQslr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF0lD8d022286;
	Fri, 15 Nov 2024 04:16:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=XDMovU2AT3WfbmNft0fKfFIg/ZR2ouN8wYKRSdDX6
	vo=; b=g1PIQslrs9eOn+p+hXWMvqq6G5au8fBF3nfJKRBSnQkhsdBB/XHO8A0HZ
	QlFn55YxSocl+UxiAGjV2Dh15poFjI2iPWwsGJn+Ijo9hj5KNxqkGUpdb2PdOmgq
	5K2jRvGPbvJv19hEY0/uUAIraTo2yzS70znoEMcAULZRwI/g3h0gCX+0EZ0YXh9P
	ZD8MEksx5vDkEGx8SveLEvLIKiODEK3cz0dr5GprQ67DM+yebX7M5zc1xavQbdKE
	xFxx2EHBCmp4qx7AK8RD9I7Y5sJw4mGTtpFXt8xZWpLaIS+vkzNLfdHRC+EuGJlO
	EKSSimghI7bawAEFYtsddsxGxBXug==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wt6w959f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 04:16:50 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AF4GnBk006517;
	Fri, 15 Nov 2024 04:16:49 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wt6w959e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 04:16:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF3ZDso029721;
	Fri, 15 Nov 2024 04:16:49 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tkjmp7fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 04:16:48 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AF4Gk4w55116176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 04:16:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE35D20043;
	Fri, 15 Nov 2024 04:16:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68F8D20040;
	Fri, 15 Nov 2024 04:16:45 +0000 (GMT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com.com (unknown [9.124.220.5])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Nov 2024 04:16:45 +0000 (GMT)
From: Nirjhar Roy <nirjhar@linux.ibm.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
        zlang@kernel.org
Subject: [PATCH v2 0/2] Addition of new tests for extsize hints
Date: Fri, 15 Nov 2024 09:45:57 +0530
Message-ID: <cover.1731597226.git.nirjhar@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zOTH0oAMtuIHhEopzcOMbuh5TLq1Hj7T
X-Proofpoint-GUID: SdJJhn1pohiUH84k80-reJwawGnrZIBW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150032

This test checks the behaviour of xfs/ext4 filesystems when extsize
hint is set on files with inode size as 0, non-empty
files with allocated and delalloc extents and so on. 
This test set also tests one of the scenarios where setting extsize
hints on files with delayed allocation (incorrectly) succeeds and there is 
a recent patch series[1] that got merged[2] which fixes this.

Currently this test only runs in xfs but there is a patch series[3] in review 
that adds support for the extsize hints for ext4 as well.

I have tested it on ppc64le (with page size 64k) and x86_64 (with page size 4k).
The block sizes I have tested with are 2k, 4k, 8k, 16k, 32k, 64k with extsize being 
twice of the block size or 4 * block size(if the default extsize is 2*blocksize). 
I have also tested with configurations where I added extszinherit mkfs option  
on the root. I had to enable CONFIG_TRANSPARENT_HUGEPAGE to enable block size 
greater than 4k on x86_64.

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
   hasn't changed if the xfs_io command fails (xflags in test_data_allocated() and test_data_delayed() test)
 - Changing the new extsize to 4*blocksize if default extsize size is 2*blocksize

[1] https://lore.kernel.org/all/20241015094509.678082-1-ojaswin@linux.ibm.com/
[2] kernel commit - 2a492ff66673
[3] https://lore.kernel.org/linux-ext4/cover.1726034272.git.ojaswin@linux.ibm.com/
[v1] https://lore.kernel.org/all/cover.1729624806.git.nirjhar@linux.ibm.com/

Nirjhar Roy (2):
  common/rc,xfs/207: Adding a common helper function to check xflag bits
    on a given file
  generic: Addition of new tests for extsize hints

 common/rc             |   7 ++
 tests/generic/366     | 172 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/366.out |  26 +++++++
 tests/xfs/207         |  13 +---
 4 files changed, 207 insertions(+), 11 deletions(-)
 create mode 100755 tests/generic/366
 create mode 100644 tests/generic/366.out

-- 
2.43.5


