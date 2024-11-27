Return-Path: <linux-ext4+bounces-5426-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EC29DA17D
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Nov 2024 05:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 585D0284E90
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Nov 2024 04:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9913813A89A;
	Wed, 27 Nov 2024 04:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ifeQe8xQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B2E1946B;
	Wed, 27 Nov 2024 04:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732681703; cv=none; b=BHtTS0Y3VprOQ2W7JSuFjU7U4CTHny/UEMU5WgTTrjVItmAGHB1gYkx4qpOD8Yr7HgfZyYfYrXUyJ8fyjfnXB3fVI82ySA/xVcwU7fos5ywNOTpFCAzRKvtQry3zvnnJkt03i6APb0k4TYj++Sd93khUSffjyidzMVcZx3XYXmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732681703; c=relaxed/simple;
	bh=D0QOn/yFXXCPwLCA2XvhZ/MzB8REVgkkUs4EB2ofEEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dqWHFRbU45ioEJRZFzRjOqaLZK6QeL1w9C8WRRUrxStp4cXjPpLC/4yCY2zU1ix83092jyPWb7m8eX3MQCoTr5uUt+geSgzryfxq0TkbEFG/wgcjcUb33ih8oQdyX+hJtFlpAluDnz7j8Cne3t5fA7yNC7XjNsLWVLo9wJHfjA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ifeQe8xQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR1hNjt028731;
	Wed, 27 Nov 2024 04:28:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=2LnoRW8+TX9Xdf8kBZl6GkWPco4DyYLsYO7zJrKWj
	Hw=; b=ifeQe8xQCjaAW34Sy1/DI9z8plX+wT7RllItLr8PUa6qP/uZPFJchwWvk
	R3ymdjwsQpACQVzISaR66kp2tr44WboIrVOrmzDKwuOUrhBTJ32AR+XoUeXXek7+
	Zujx7EMWZY5j0iDRc+EURTKdf7yLcDFj9Y5gMB4TGJFKmSpnkkFZxPtOGcx9iG31
	/BrFMpk9I6ZuPuogXj04zPW+WryOwS1bW4vcIpjQTG5i+iCPYTTRTTRSro4YFzhT
	jGmhCtQsOMvXM2OA4bOw2rGxk1PMSMr0nMQ79UI0YNXP5LPwujShWewSeGN1l+NW
	vbPmHAQTVIvNt4X249NFQVNP4WJHA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43387c1rhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 04:28:18 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AR4Rsx6021027;
	Wed, 27 Nov 2024 04:28:18 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43387c1rhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 04:28:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR3p7Ds000840;
	Wed, 27 Nov 2024 04:28:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 433sryjhq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 04:28:16 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AR4SCmD34210324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Nov 2024 04:28:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C42FD2004B;
	Wed, 27 Nov 2024 04:28:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32F3320043;
	Wed, 27 Nov 2024 04:28:11 +0000 (GMT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com.com (unknown [9.39.20.219])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Nov 2024 04:28:11 +0000 (GMT)
From: Nirjhar Roy <nirjhar@linux.ibm.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
        zlang@kernel.org, nirjhar@linux.ibm.com
Subject: [PATCH v5 0/3] Addition of new tests for extsize hints
Date: Wed, 27 Nov 2024 09:57:58 +0530
Message-ID: <cover.1732681064.git.nirjhar@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: onG-3Tsj1EG2I0qX4zi5EzRaNkDGWc5_
X-Proofpoint-ORIG-GUID: L2THMHMJo3DlaGRllwLwSBaWQvli3vRv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411270035

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

Changes since [v4]
 - Added RBs from Darrick on Patch-2.
 - Added RBs from Christoph on all the patches.
 - Correcting test id in the comment section of the test added. 
 - Correction in the parameter arrangement in _fixed_by_kernel_commit in the test added. 

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
[v4] https://lore.kernel.org/all/cover.1732599868.git.nirjhar@linux.ibm.com/

Nirjhar Roy (3):
  common/rc,xfs/207: Add a common helper function to check xflag bits
  common/rc: Add a new _require_scratch_extsize helper function
  generic: Addition of new tests for extsize hints

 common/rc             |  24 ++++++
 tests/generic/367     | 174 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/367.out |  26 +++++++
 tests/xfs/207         |  15 +---
 4 files changed, 228 insertions(+), 11 deletions(-)
 create mode 100755 tests/generic/367
 create mode 100644 tests/generic/367.out

-- 
2.43.5


