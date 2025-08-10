Return-Path: <linux-ext4+bounces-9308-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D92E6B1FA25
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Aug 2025 15:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863F13AD99B
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Aug 2025 13:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411F725BEF2;
	Sun, 10 Aug 2025 13:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="prrCeoFw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C53335C7;
	Sun, 10 Aug 2025 13:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754833339; cv=none; b=KTzVg14ZHJtoCMPpvWjWMWi7RGzkjFWu6CxPOULr2tJHAvg39svQDzgUNcDYOxv8m+LsytgGiDrP9orX6zdhPVrvO3/DzunIv/RkRiNO4K8jOk4EH9uyONYhl8T4SsFf5xdLAiJcSyccrAI8J2Z7/uAWJa6z30/Ah77aCEGshDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754833339; c=relaxed/simple;
	bh=eBSdJbmxbZYL0Ditld2pAWjUEPM/2am4aaqO2klRFr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DdwtA0YPGNoMARBrVIYB3wXmqjs9ops2HhZhMwHeXSYqGZt+74MX70UTYfv164PHamyXl1t1Xs8TjYH9JDORuw1RLIGhyoFXEKb4MmrcvWYhRQTuAw0N4KJuKV6M2t/BurrRFyf4jpbraJ+TwgvZW2DSVaFrxwEbbERbw/JfE1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=prrCeoFw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57A8kmtZ013794;
	Sun, 10 Aug 2025 13:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=9MaeqQRmqCIb07g4pLtMVewudppB2WtsXzdJPTqQ4
	Ks=; b=prrCeoFw2bCaPbkzk+O+1Y06P1XlgRE1J5JWj8vzYFOZOdtKVIgDdhhq4
	Oqgm4ecQ9AOO06uc0oy/jBtv3WyelFMUjb3OAIzItbbUeN/6ttl5AeHdNF8SJtjB
	rc4+d5SHKBPa0ItL2Ww3450zJiBDEgvwnsvRQKdtbxS1LyT9c06s2sY0gZat4Eb5
	1By7AWmI2Qg0JY2wINn7bkvrcGWdNWaKF9vUHtCEBu+7+0gWQN1xBx3dxMHJKNQi
	LZ0WpRNkQFbmAwJSD55nFxo43kc7fGB2GcT22/etYpsx00ivcjoi7m9o+UDVJ5il
	JjO1tB3pcLJ2xVa4Q3cbYmQcmcA5w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48durtwjak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:42:09 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57ADg8d6006698;
	Sun, 10 Aug 2025 13:42:08 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48durtwjag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:42:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57ABqr6a010646;
	Sun, 10 Aug 2025 13:42:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48egnua5yk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:42:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57ADg66529098592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Aug 2025 13:42:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28C2C20043;
	Sun, 10 Aug 2025 13:42:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEDD220040;
	Sun, 10 Aug 2025 13:42:03 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.216.43])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 10 Aug 2025 13:42:03 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v4 00/11] Add more tests for multi fs block atomic writes
Date: Sun, 10 Aug 2025 19:11:51 +0530
Message-ID: <cover.1754833177.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QGujCYFCGKlwnUPWOj_iIG2jLeitjQnY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA5NyBTYWx0ZWRfX+4kTR010G2j3
 Q5RiFtBmYlEp/cvM7Nv38pd8Pmy61JsNbailFcLcPEoDsFrZamJH7euISJwqPA6DD9HU+z1u1YP
 EX1rYUeMv/f2nLgf2XqZ+iIINxb0bFy5Gp+STDFuDhKZFdfHW6Xd+6FpHMvQ11zrn4TYzCE+iLT
 HoBf1B9FoGSvUAt9g4e4Mn2ss8BD4tbfguHexCmcI85GXRd+oNz34UflaTdgb+ji57j0gTp+EGq
 qn5gGhnjUTdTsBm/lhAZbyYHrxEkpUhCHNFGVyfeZ7iB7zqAPinrUSqhzlARqdQ5gWh+TP/gPPP
 jty1B5Azxi80uv1EYgPE2Qn0RCconB/6BtEROYAjPb5QNxzILoWj1Vlx1HLkmYJdytlQtiVAOZf
 Duuacq+S7mELkKvQUpuyKqfkeKP+O/BqYO2AjB7vTXAckt6iIOYZwt7/OSDLuCaSYhqGF6fV
X-Authority-Analysis: v=2.4 cv=QtNe3Uyd c=1 sm=1 tr=0 ts=6898a1b1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8
 a=jc9Yl3RBPp2OVu_FEiAA:9
X-Proofpoint-ORIG-GUID: 8vnx56vtEP_BQxVBtUwdmpvQiVLhhLrX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508100097

Changes in v4: (Thanks to Darrick, John and Zorro for the reviews)

- g/1226,1227: Modify fio threads to not issue overlapping atomic writes
- g/1228: Use xfs_io -c "shutdown" instead of _scratch_shutdown to avoid
          bash overhead
- g/1229: Remove FSX_AVOID handling for bigalloc from common/rc. It is
          part of the specific test now
- ext4/063: add more clearer extent diagram
- ext4/064: Drop the test for now as im taking sometime to understand
            the behavior better.
- Removed test numbers from commit message
- For tests with significant changes I've removed the RVBs

Changes in v3 [3]:

- (2/13) use dumpe2fs to figure out if FS is bigalloc
- (9/13) generic/1230: Detect device speeds for more accurate testing. ALso
  speeds up the test
- fio tests - switch to write followed by verify approach to avoid false
  failures due to fio verify reads splitting and racing with atomic
  writes. Discussion thread:

  https://lore.kernel.org/fstests/0430bd73-e6c2-4ce9-af24-67b1e1fa9b5b@oracle.com/

  [3] https://lore.kernel.org/fstests/cover.1752329098.git.ojaswin@linux.ibm.com/

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
  common/rc: Add a helper to run fsx on a given file
  ltp/fsx.c: Add atomic writes support to fsx
  generic: Add atomic write test using fio crc check verifier
  generic: Add atomic write test using fio verify on file mixed mappings
  generic: Add atomic write multi-fsblock O_[D]SYNC tests
  generic: Stress fsx with atomic writes enabled
  generic: Add sudden shutdown tests for multi block atomic writes
  ext4: Atomic write test for extent split across leaf nodes

Ritesh Harjani (IBM) (2):
  ext4: Atomic writes stress test for bigalloc using fio crc verifier
  ext4: Atomic writes test for bigalloc using fio crc verifier on
    multiple files

 common/rc              |  45 ++++-
 ltp/fsx.c              | 109 ++++++++++-
 tests/ext4/061         | 130 ++++++++++++++
 tests/ext4/061.out     |   2 +
 tests/ext4/062         | 176 ++++++++++++++++++
 tests/ext4/062.out     |   2 +
 tests/ext4/063         | 129 +++++++++++++
 tests/ext4/063.out     |   2 +
 tests/generic/1226     | 107 +++++++++++
 tests/generic/1226.out |   2 +
 tests/generic/1227     | 131 ++++++++++++++
 tests/generic/1227.out |   2 +
 tests/generic/1228     | 137 ++++++++++++++
 tests/generic/1228.out |   2 +
 tests/generic/1229     |  68 +++++++
 tests/generic/1229.out |   2 +
 tests/generic/1230     | 397 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/1230.out |   2 +
 18 files changed, 1437 insertions(+), 8 deletions(-)
 create mode 100755 tests/ext4/061
 create mode 100644 tests/ext4/061.out
 create mode 100755 tests/ext4/062
 create mode 100644 tests/ext4/062.out
 create mode 100755 tests/ext4/063
 create mode 100644 tests/ext4/063.out
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


