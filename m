Return-Path: <linux-ext4+bounces-9924-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600AAB53A07
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Sep 2025 19:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF232168DE2
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Sep 2025 17:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E5435CEAD;
	Thu, 11 Sep 2025 17:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aKh+U673"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19CD35FC31;
	Thu, 11 Sep 2025 17:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610841; cv=none; b=JWAzIgzK5pXbRtkxIQ6x5Wobr/jEvr3qJXQSKsm684PM7VJsZLaLNDZJkd3xeSkL86WdnPVrfI5jdQkcAhgeffC9aK8D5a+o2M3q8fYpai+9/1iofnENkeNXgpjiKImXLriOJRH4qWkHgfbJ+MmPeXHxJ6XgKgIxFLgpQlhWJOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610841; c=relaxed/simple;
	bh=BDNsQNrPBpe6rfThQpsBF4iMqAFLVxJBmag/eQC9jYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r/+LaJAUuS5sK54ciDJGBmJ9xOY19IuGcLBbOfhKyNFfccugTv9MjCTXW9F1jHKA4G3GLZ1Qa3OoHxd5aISy/eFzUaDuqEax/Ge3Wuvma3x/Wqxf9uyQVeoqtD7TDTltCsQP0a7r8vj9M9umvZ4mVNwBVCobAuUXmcOluzq8z8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aKh+U673; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BFvYQN012236;
	Thu, 11 Sep 2025 17:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=dIErtpctXFxEtC9xE8yUjQnLMrRNq72psn2XMdQ3t
	6E=; b=aKh+U673jfe1z9GJ8VkREVdGg61mpK0nYUqpjYc570KhpYIHEN2mtzGXl
	5zl7RGmjXR3mf+p9kqf/yZwQqP19jH9i94UqsvRZ25BTLLYZ+12tBYBHZwhIXbbT
	la5JlSuuUAoTLvyDDKvH5oiJ9RWYLcowOoqh29z+rm2ai+7kFDZMz1DhpmJ2nrTn
	5uyDNu/aXa1ZUA9Jh08zpcFgBqhpuocGOSJS5+NH7OFRQSRDlk963wUaBOdkZiba
	FEqypt21vUtXR4cm1N0ZSb1rCTtERWHpbT1w+xt1dBG65juMEIHLgwtKSQ53yqZg
	H6Fqqtt+X/S5XTyxazqTE4bAytK3g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmx66dk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 17:13:51 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58BH6M2L030605;
	Thu, 11 Sep 2025 17:13:51 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmx66de-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 17:13:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58BGVI6W020495;
	Thu, 11 Sep 2025 17:13:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 490yp171t4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 17:13:49 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58BHDl6Q32637440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 17:13:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC7572004F;
	Thu, 11 Sep 2025 17:13:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1D6920040;
	Thu, 11 Sep 2025 17:13:44 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.17.37])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Sep 2025 17:13:44 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v6 00/11] Add more tests for multi fs block atomic writes
Date: Thu, 11 Sep 2025 22:43:31 +0530
Message-ID: <cover.1757610403.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lNGX7BwFNhIo7Mdjm_f9f7m4N1elrfqv
X-Proofpoint-ORIG-GUID: aRGL50xYY8qATjYKgMym6s2uv-Bko6C2
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68c3034f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8
 a=RhRxWBKHx9l-Qd8VlncA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfX8bvEQpOLDLzC
 8dfugEwjzt661d9bwfzce56c+BzUFcFzXrRCV058idPqLKDBrJqcXEcqILtVLAAfExXRc4jval1
 EKMnAtchWpy+cUyF3BgovTuCoxWOw9ACnYC4cgqmpNaKQoWljhJabKnA0y+IbEXpxNZd7dBDAy9
 Vbdze1UWb1wVZIUJsfxvJMQ0a1gCypd6Mty94P+wqXtbcslNTND+JKTX/bvnVUIyaBJYxlH7R8R
 Qd+VGhWDdJUCrd0uzFERW+6CV9jon3Id6TH2ctpjCpVPghFC4PbUe8LnHL0RjsnzYatotHT7b1x
 2AiySlhkZ6DMCiB+pqXqHdEf3LxuxNUXxj/NWi6kUKSOJmeAHdHEVldbyBUAayvM1z4KtXuTDmP
 Rxfw8D+8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_02,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025

Changes in v6:
- Picked up reviews from Darrick, Zorro and John! (Thanks)
- Added _require_fio_atomic_writes helper in patch 3 as a wrapper arounc
  __require_fio_version
- minor spelling and refactors

Changes in v5: (Thanks to John & Darrick for reviews)
- commor/rc: Add a _require_fio_version helper
- fsx: Switch atomic writes off if direct IO (-Z) not passed
- fio tests: better commit messages to explain what we are testing
- ext4/06{1..2}: Refactor code, also test only a few combinations of bs
  clustersize rather than every single

Changes in v4: (Thanks to Darrick, John and Zorro for the reviews) [4]

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

[4] https://lore.kernel.org/fstests/0eb2703b-a862-4a40-b271-6b8bb27b4ad4@oracle.com/T/#mef34a8c13cbee466bfc162db637d6e1cf0a8b06d

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
- (2/13) remove setup_fs_options and add fsx specific helper
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


Ojaswin Mujoo (10):
  common/rc: Add _min() and _max() helpers
  common/rc: Add fio atomic write helpers
  common/rc: Add a helper to run fsx on a given file
  ltp/fsx.c: Add atomic writes support to fsx
  generic: Add atomic write test using fio crc check verifier
  generic: Add atomic write test using fio verify on file mixed mappings
  generic: Add atomic write multi-fsblock O_[D]SYNC tests
  generic: Stress fsx with atomic writes enabled
  generic: Add sudden shutdown tests for multi block atomic writes
  ext4: Atomic write test for extent split across leaf nodes

Ritesh Harjani (IBM) (2):
  ext4: Test atomic write and ioend codepaths with bigalloc
  ext4: Test atomic writes allocation and write codepaths with bigalloc

 common/rc              |  88 +++++++++-
 ltp/fsx.c              | 115 ++++++++++++-
 tests/ext4/061         | 155 +++++++++++++++++
 tests/ext4/061.out     |   2 +
 tests/ext4/062         | 203 +++++++++++++++++++++++
 tests/ext4/062.out     |   2 +
 tests/ext4/063         | 129 +++++++++++++++
 tests/ext4/063.out     |   2 +
 tests/generic/1226     | 108 ++++++++++++
 tests/generic/1226.out |   2 +
 tests/generic/1227     | 132 +++++++++++++++
 tests/generic/1227.out |   2 +
 tests/generic/1228     | 139 ++++++++++++++++
 tests/generic/1228.out |   2 +
 tests/generic/1229     |  68 ++++++++
 tests/generic/1229.out |   2 +
 tests/generic/1230     | 368 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/1230.out |   2 +
 18 files changed, 1513 insertions(+), 8 deletions(-)
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


