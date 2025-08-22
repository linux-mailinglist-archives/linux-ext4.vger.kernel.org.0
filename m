Return-Path: <linux-ext4+bounces-9552-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF883B3111F
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Aug 2025 10:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A2C7211DD
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Aug 2025 08:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B220C2E9EB8;
	Fri, 22 Aug 2025 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ixiS5U08"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9970A2D2493;
	Fri, 22 Aug 2025 08:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755849749; cv=none; b=kyBNIh8E2ctDaajtleGchuw1gsRqOlR6Z/EGcoix4OalM/1uRdoHwMy8WOWerRHOPsLrCdJY4xEFofSXBeUJaw/hSQ6iTK5J/pjVvYxGPE3oXXQliBY/fL/VZDuE9a1PFsSzMsciOKYAG3IgyIBXcplzC9IlK/hpICdolDNLUwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755849749; c=relaxed/simple;
	bh=cO/3U/eefNmuV0fkpHHB06UIQw41o5saDF/+2uVAL3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UjHVw31EWLwhGlOivAHsWFgYMqnQ8qKF3iF2DL5fdVp7EDT8wTZPC7v0t/9t9HdhXafC6+GzdF3wAxCcLeTkDuRpe7Jls5mgrkxX4/89qqkdMfK6XVfxsaOzt3uiifRXX/cANPj6zrr26plmm9t8a+dbure1tMUdiqq0/k1RL2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ixiS5U08; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M2nYfD011680;
	Fri, 22 Aug 2025 08:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=i1FlfvV7amyG5SGfRy/i7C5UBw2YHvXvVtCx8KKM3
	Qw=; b=ixiS5U080SAz54ra5hDt0urv2ZaUYRnUltmpgGGevPqLFKRfdnjHFxXPL
	6YV7EhuOB1wTnsEcYLPchLoyY3AsIxRVwoeVEdUBID014XgHvzA9eFTotwr7VIXZ
	X0FFT7gRivrD6DTkshKRMHN9u+aFF+0uGWf2f3VQESQXZnDk3vfeSkWZbT3F5p06
	sHGON4FKbp3/RxNLby+y45tRBKvrY0G20zBhEFgQ1GxeaYtT6NW+U6plsPZPxbtY
	n7D7/LuHjVQC7XPTi5jkiqJsqYxr/Kqo5xqDYK85q5TLQYn5Zpt4Y8YzjoHEx2G3
	H1VPMJG44qENQL+lMo6GQNo/gMxJA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vw4ce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:02:18 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57M7aPRB029953;
	Fri, 22 Aug 2025 08:02:17 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vw4ca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:02:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57M3ZA3F031905;
	Fri, 22 Aug 2025 08:02:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my5ycaff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:02:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57M82EJ134013750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 08:02:14 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C71472005A;
	Fri, 22 Aug 2025 08:02:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F5B820040;
	Fri, 22 Aug 2025 08:02:12 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.210.10])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Aug 2025 08:02:12 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v5 00/11] Add more tests for multi fs block atomic writes
Date: Fri, 22 Aug 2025 13:31:59 +0530
Message-ID: <cover.1755849134.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX7YbSbCZpSyS+
 zBQEQyB6vKs7rkNp6bHlrt6c1Og+wg2CEqzeDfVVgcSHRwKOTzDw+peDuB0eychi4vkf8puJQuP
 IPzg3bjgWVtybOiOWYcgUqyphlGywqysdMqBTIKDXMgczbCuczhK4fh57vF0LxoBiEVfCHTZr2w
 zVqNLE+AsDl7UtGPPsL2nNGlG5ThBKPPFZUUIVJs5eCpMmxWQjPrJoMZjEcAukpY1lSNESj8a8R
 1HWEMgVIscS9LeBYUy43EcJycy+u60KGR+wokdWts698aB/AXsKRNtnbULDO1ktkAgZqyUE9EH6
 ev53OWayUHP1BiVQ9bc9RHyn7PoedEQay8nd5f+k6HMkCHUlevbNQjlH9FXUavhVNh+ogk+Pk1P
 jvVE/JPd6AzPW3U0awvZ1bFf0jjWfA==
X-Proofpoint-ORIG-GUID: XmTOaExi3ApobZ8XMQTKLeIqiEP4PKqs
X-Authority-Analysis: v=2.4 cv=T9nVj/KQ c=1 sm=1 tr=0 ts=68a8240a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8
 a=otfDAVWHr6qse-eGaWMA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: tTXTE9KQuxt13TkyuQq2xW-6S0HdQceP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190222

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



Ojaswin Mujoo (10):
  common/rc: Add _min() and _max() helpers
  common/rc: Add _require_fio_version helper
  common/rc: Add a helper to run fsx on a given file
  ltp/fsx.c: Add atomic writes support to fsx
  generic: Add atomic write test using fio crc check verifier
  generic: Add atomic write test using fio verify on file mixed mappings
  generic: Add atomic write multi-fsblock O_[D]SYNC tests
  generic: Stress fsx with atomic writes enabled
  generic: Add sudden shutdown tests for multi block atomic writes
  ext4: Atomic write test for extent split across leaf nodes

Ritesh Harjani (IBM) (2):
  ext4: test atomic write and ioend codepaths with bigalloc
  ext4: Test atomic writes allocation and write codepaths with bigalloc

 common/rc              |  77 +++++++-
 ltp/fsx.c              | 115 +++++++++++-
 tests/ext4/061         | 155 ++++++++++++++++
 tests/ext4/061.out     |   2 +
 tests/ext4/062         | 203 +++++++++++++++++++++
 tests/ext4/062.out     |   2 +
 tests/ext4/063         | 129 +++++++++++++
 tests/ext4/063.out     |   2 +
 tests/generic/1226     | 108 +++++++++++
 tests/generic/1226.out |   2 +
 tests/generic/1227     | 132 ++++++++++++++
 tests/generic/1227.out |   2 +
 tests/generic/1228     | 137 ++++++++++++++
 tests/generic/1228.out |   2 +
 tests/generic/1229     |  68 +++++++
 tests/generic/1229.out |   2 +
 tests/generic/1230     | 397 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/1230.out |   2 +
 18 files changed, 1529 insertions(+), 8 deletions(-)
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


