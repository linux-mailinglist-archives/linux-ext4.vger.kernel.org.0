Return-Path: <linux-ext4+bounces-8946-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27150B02B31
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 16:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0097B7B3965
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 14:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51B727AC36;
	Sat, 12 Jul 2025 14:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W8En35VF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67BD27584C;
	Sat, 12 Jul 2025 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752329597; cv=none; b=G8NVU/Udqgkpjx8KrRoR3yjS3smQVOD409NUHiL1FS9eoPA5gcDe6uv8S2UsFzwkU+cE7E1rUijlhUAK9jb4czzZLZylXXG9yCyf6ST7RUuUGdvCH+QwlAvhxufP5B/iEG9nIkNsxru34RnjhTfu+OerHMuQmOXKlx8VXQhgirA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752329597; c=relaxed/simple;
	bh=UBgltw/ei+nmEFK/sPnM8RFfUQBKHFKwghN9JOOwFbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ugaIUsM6wB1dtjXlh1SKNClxvaA5K+5TLev2T43k58DvNFqBp3m7HJHHvDKV3vFn/dcpcSl1hq1VulTPFzKS+wgOAcijtmF7Bo2AD51oH64mCr5sMCw/TrRz10pWfy9pKO9jMW9wasP5gMli1q6e9vK4kshWi8xb0xPNNHnMdLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W8En35VF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56C2kcW8017656;
	Sat, 12 Jul 2025 14:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=WksEKJoYlNBy0q4acWOfJAr6pGce6JJ0CTyXEvqHR
	gc=; b=W8En35VFr/mDH/RD1axAwGx79mw49BKSQLoCk5SLgGtVn2AM8kITfvjET
	1gnRtR5/vJiQ6eedtkhTC4WnUHLKwdBEVnmVQYFVIBIxrvHt11u3XghazyGOpczU
	z0o40sau79CLfUJgR5ascG+uHKVzVHweQodw3FWrTiWFht+QnpP83LTWnbGVDQm8
	WVVAea4Vs/hx2xEn6Mj+VQmDvLlVLIJm5Hx+nvh9NebZqSfIpOMERvlKE1UXyMFc
	fgWVo/mtg4JIG85JqV/38XPkeMtDpca/kdFBYZASTu4TcATtc0f/i9FSs3e10wt+
	SFOwk4Q39NQl156s7ijHJ91ASpdvw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47uf7chsgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:01 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56CED1hj005985;
	Sat, 12 Jul 2025 14:13:01 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47uf7chsgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56CBdNOG013616;
	Sat, 12 Jul 2025 14:13:00 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qgkmf63w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56CECw6K34406718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Jul 2025 14:12:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFAF720043;
	Sat, 12 Jul 2025 14:12:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D2E420040;
	Sat, 12 Jul 2025 14:12:56 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.215.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 12 Jul 2025 14:12:56 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v3 00/13] Add more tests for multi fs block atomic writes
Date: Sat, 12 Jul 2025 19:42:42 +0530
Message-ID: <cover.1752329098.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4fUhzFOtrIm1WdFAIJICMfiQc43sf12W
X-Authority-Analysis: v=2.4 cv=LoGSymdc c=1 sm=1 tr=0 ts=68726d6e cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8 a=A7lu236ylEKY-Kczj1UA:9
X-Proofpoint-GUID: OP9mqmgKS0PH-zxtES2XGkwmiS9ZHAp1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDEwNyBTYWx0ZWRfXyF8fclQjQrIj dVcCExqMo+gpYXaJfSfFq/3OLb1F7hvLSULSQxRhVcs/vGiLAuEQu2zM7MnQHZTGf3vmxVpdqtf WjsW4Kro3FTy4Vt7yUga5B1PgDZj3ajViYagarHyKTBAvI8gtyHzDrA7NAuEhnI4ivxb+9aSTy1
 cJE/b5otOo2zTqm5YnIJDSfmK6HghD1Ic1K2vk7tq7QUakRAE+CnCA4ZomWLp0lYbWFoD5Qkr7C lGQnZc9QfeVJK7u5kYiOSb8jX+5F2W8mYFSP+g/+xANsr5ShMEMpugknJaAfcOmG9dkDocCLh/r LBWPGkoJSAUSSZ7f8hitFla7p/XAZsI+J4/2vwpVJlvHXQGotF97YmK5N2yq3PztSPGvOmAhDts
 0/f3aiiWM1TfemGZWlW9sYwJCLUipGhCHiL+SXV3oW3Tgljn3221eW17OSde17gCFh7luqqn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-12_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 mlxscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507120107

NOTE: This patch series is based on: 
https://lore.kernel.org/fstests/20250626002735.22827-1-catherine.hoang@oracle.com/T/#t

Changes in v3:

- (2/13) use dumpe2fs to figure out if FS is bigalloc
- (9/13) generic/1230: Detect device speeds for more accurate testing. ALso
  speeds up the test
- fio tests - switch to write followed by verify approach to avoid false
  failures due to fio verify reads splitting and racing with atomic
  writes. Discussion thread:

  https://lore.kernel.org/fstests/0430bd73-e6c2-4ce9-af24-67b1e1fa9b5b@oracle.com/

Changes in v2 [1]:

- (1/13) new patch with _min and _max helpers
- (2/13) remove setup_fs_options and add fsx specifc helper 
- (4/13) skip atomic write instead of falling back to normal write (fsx)
- (4/13) make atomic write default on instead of default off (fsx)
- (5,6/13) refactor and cleanup fio tests
- (7/13) refactored common code
- (8/13) dont ignore mmap writes for fsx with atomic writes
- (9/13) use od instead of xxd. handle cleanup of bg threads in _cleanup()
- (10-13/13) minor refactors
- change all tests use _fail for better consistency
- use higher tests numbers for easier merging 

 [1] https://lore.kernel.org/fstests/cover.1750924903.git.ojaswin@linux.ibm.com/

* Original cover [2] * 

These are the tests we were using to verify that filesystems are not
tearing multi fs block atomic writes. Infact some of the tests like
generic/772 (now: g/1230) actually helped us catch and fix issues in
ext4's early implementations of multi fs block atomic writes and hence
we feel these tests are useful to have in xfstests.

We have tested these with scsi debug as well as a real nvme device
supporting multi fs block atomic writes.

Thoughts and suggestions are welcome!

[2] rfc: https://lore.kernel.org/fstests/cover.1749629233.git.ojaswin@linux.ibm.com/


Ojaswin Mujoo (9):
  common/rc: Add _min() and _max() helpers
  common/rc: Fix fsx for ext4 with bigalloc
  common/rc: Add a helper to run fsx on a given file
  ltp/fsx.c: Add atomic writes support to fsx
  generic/1228: Add atomic write multi-fsblock O_[D]SYNC tests
  generic/1229: Stress fsx with atomic writes enabled
  generic/1230: Add sudden shutdown tests for multi block atomic writes
  ext4/063: Atomic write test for extent split across leaf nodes
  ext4/064: Add atomic write tests for journal credit calculation

Ritesh Harjani (IBM) (4):
  generic/1226: Add atomic write test using fio crc check verifier
  generic/1227: Add atomic write test using fio verify on file mixed
    mappings
  ext4/061: Atomic writes stress test for bigalloc using fio crc
    verifier
  ext4/062: Atomic writes test for bigalloc using fio crc verifier on
    multiple files

 common/rc              |  71 +++++++-
 ltp/fsx.c              | 109 ++++++++++-
 tests/ext4/061         | 130 ++++++++++++++
 tests/ext4/061.out     |   2 +
 tests/ext4/062         | 176 ++++++++++++++++++
 tests/ext4/062.out     |   2 +
 tests/ext4/063         | 125 +++++++++++++
 tests/ext4/063.out     |   2 +
 tests/ext4/064         |  75 ++++++++
 tests/ext4/064.out     |   2 +
 tests/generic/1226     | 101 +++++++++++
 tests/generic/1226.out |   2 +
 tests/generic/1227     | 123 +++++++++++++
 tests/generic/1227.out |   2 +
 tests/generic/1228     | 139 +++++++++++++++
 tests/generic/1228.out |   2 +
 tests/generic/1229     |  41 +++++
 tests/generic/1229.out |   2 +
 tests/generic/1230     | 397 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/1230.out |   2 +
 20 files changed, 1497 insertions(+), 8 deletions(-)
 create mode 100755 tests/ext4/061
 create mode 100644 tests/ext4/061.out
 create mode 100755 tests/ext4/062
 create mode 100644 tests/ext4/062.out
 create mode 100755 tests/ext4/063
 create mode 100644 tests/ext4/063.out
 create mode 100755 tests/ext4/064
 create mode 100644 tests/ext4/064.out
 create mode 100755 tests/generic/1226
 create mode 100644 tests/generic/1226.out
 create mode 100755 tests/generic/1227
 create mode 100644 tests/generic/1227.out
 create mode 100755 tests/generic/1228
 create mode 100644 tests/generic/1228.out
 create mode 100755 tests/generic/1229
 create mode 100644 tests/generic/1229.out
 create mode 100755 tests/generic/1230
 create mode 100644 tests/generic/1230.out

-- 
2.49.0


