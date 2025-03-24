Return-Path: <linux-ext4+bounces-6958-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE8DA6D52F
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Mar 2025 08:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C853AA069
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Mar 2025 07:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB06B257459;
	Mon, 24 Mar 2025 07:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WzsoDhti"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DDF25742D;
	Mon, 24 Mar 2025 07:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742801852; cv=none; b=m3EXv9qG1EkttTZgKniCM+bRKd/JfmEZb5gcVse/B7+bbP4UiksCGFDSiS0gwUwJNYcOePXw/mBZ2m6iSGRUSB1lD7fZwkEkvlncvqN1d6gxtNgk7xd/YV7+h2BUxQZn6EpvLvHGcZ+Txwqgph+n+ep0ChVxcQfEzCfleJhKqXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742801852; c=relaxed/simple;
	bh=e3AoWLYNPTFZnz86iaVTUGPwvS+iqfeIOPNwxgo7smE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F4G3/OrQ2HvKXh8O+13kZZ9TUQ66HzkkHQBd16IcLwN+KIxcroZaeD8bC/S6Sf4RfNFfFRBOpTkHlehb6mopB+q2FVNiZSFSZye9CmAIcWvbAfRcWJfDGyIJSWp65ylcg/z9jRG74thMcPcqfTbxnNV6BKcO9n5ISEtjYrvjgVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WzsoDhti; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52NNSmSp009728;
	Mon, 24 Mar 2025 07:37:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=G+8DRrZFR05yC73toKSnJnS0F8v+CsMnumFAJhpHp
	Io=; b=WzsoDhtiGfPl95yzEH+wsahiBNzaVHXXgrL1s0J84e6NpjCI0xzd/4JmC
	KojQt71R2Ykksa9sHE0+KSSGFn8vTo90TEBVZk4E2lgFyv7SGXX3z3+TltINJOIA
	2/5ALV9sQKv92R59kElB7MIDAAvFL/W0lgXAQeaZYpHEcSW3IYA0XQ+mgSc39hYl
	nhffPhfQ502MjrRgsssbpiKiXNxImi4uk+ccAzLOKJj7BG0+zxkuyvnH8Pr1RNYm
	k4apNvY2VclysByiEfsE+SjR6IaU2JuYuaOTSCE86ZferiovxXvMzHSp71Wj1XzK
	C0zmyrcd41OOBqAN7hq3a5AQm99Ng==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jsfpa15g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:15 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52O7bFSm008864;
	Mon, 24 Mar 2025 07:37:15 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jsfpa15b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52O3uOgt012245;
	Mon, 24 Mar 2025 07:37:14 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j91kw3cn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52O7bC1055116112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Mar 2025 07:37:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DD2020043;
	Mon, 24 Mar 2025 07:37:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 022062004E;
	Mon, 24 Mar 2025 07:37:11 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.29.200])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Mar 2025 07:37:10 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: John Garry <john.g.garry@oracle.com>, dchinner@redhat.com,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org
Subject: [RFC v3 00/11] ext4: Add extsize and forcealign support (groundwork for multi block atomic writes)
Date: Mon, 24 Mar 2025 13:06:58 +0530
Message-ID: <cover.1742800203.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: E4qrm2tcfPhpdfBV4k5bDL5Epyk8einZ
X-Proofpoint-GUID: QZ490p1iBWt23sZaVpaIwFuPY1p9T7N1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 malwarescore=0
 mlxlogscore=764 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503240053

These patches lay the ground work for supporting multi block
HW-accelerated atomic writes without the use of bigalloc. Multiblock
atomic write support with bigalloc is already posted as an RFC here [3].
Without bigalloc, we need a mechanism to get aligned blocks from the
allocator so that HW accelerated atomic writes can be performed. extsize
+ forcealign provide this mechanism in ext4.

[3] https://lore.kernel.org/linux-ext4/cover.1742699765.git.ritesh.list@gmail.com/

- extsize is a per inode hint to physically and logically align blocks
  to a certain value.

- forcealign gives a **strict guarantee** that allocator will physically
  as well as logically align blocks to the extsize value

The extsize support is almost same as v2 with rebase to latest ext4 dev
branch. Patches 7 - 11 adds the new forcealign feature that can be
seen like a sort of per file bigalloc. Some points about forcealign:

 * Allocation on a forcealign inode is guaranteed to get an extent
   aligned to extsize physicall and logically, else error is returned. 
   This mimicks bigalloc but on a per file level

 * Deallocations are also only allowed in extsize aligned units. This is
   pretty strict and can be relaxed in later revisions.

 * FS_XFLAG_FORCEALIGN can be set via FS_IOC_GET/SETXATTR ioctl to
   enable forcealign. As of now, we can only enable forcealign if
   extsize is set on the inode

 * Reused the EXT4_EOFBLOCKS_FL flag for forcealig since it is no longer
   used. Incase this is not feasible, we can explore other ways to set
   the flag (eg xattr or overriding a field)

Some of the TODOs and open questions regarding the design:

1. I want to design forcealign in such a way that FS formatting is not
  required. For that Im exploring 2 options:

  - Add an RO_COMPAT feature flag. tune2fs can be used to enable it on
    existing filesystems without formatting. Simplest but this has a
    drawback that even for a single forcealign file, the FS would become
    RO on older kernels

  - To avoid that, we can instead expose an ioctl to fix a misaligned
    forcealign file. However this is an overhead for sys admins/end
    users. Maybe fsck can help with this?

2. For extsize, I'm not planning to support FS-wide tunable since we
   already have bigalloc for that.

3. Also, we are not supporting non-power-of-2 extsizes (atleast for now)
   as there are no clear use cases to justify the added complexity 

4. directory wide extsize is not yet supported however can be added in 
   future revision

We are passing quick xfstests with these patches along with a lot of
custom allocation scenarios that I'll eventually add to xfstest, however
this series is still largely an RFC and might have bugs.

Posting this here for review and suggestions on the design as well as
implementation. 


** Changes since rfc v2 [2] **

 - Patch 0-6 are same as v2 just rebased. Patch 7-11 are new in this
   series.
 - Patch 7 adds a wrapper on ext4_map_blocks to better handle some
   allocation scenarios
 - Patch 8-11 Add a new called forcealign. More about it below.

[2] https://lore.kernel.org/linux-ext4/cover.1733901374.git.ojaswin@linux.ibm.com/

** Changes since rfc v1 [1] **

1. Allocations beyond EOF also respect extsize hint however we 
   unlink XFS, we don't trim the blocks allocated beyond EOF due
   to extsize hints. The reasoning behind this is explained in 
   patch 6/6.

2. Minor fixes in extsize ioctl handling logic.

Rest of the design detials can be in individual patches as well as
the original cover leter which can be found here:

[1]
https://lore.kernel.org/linux-ext4/cover.1726034272.git.ojaswin@linux.ibm.com/

Comments and suggestions are welcome!

Regards,
ojaswin

Ojaswin Mujoo (11):
  ext4: add aligned allocation hint in mballoc
  ext4: allow inode preallocation for aligned alloc
  ext4: support for extsize hint using FS_IOC_FS(GET/SET)XATTR
  ext4: pass lblk and len explicitly to ext4_split_extent*()
  ext4: add extsize hint support
  ext4: make extsize work with EOF allocations
  ext4: add ext4_map_blocks_extsize() wrapper to handle overwrites
  ext4: add forcealign support of mballoc
  ext4: add forcealign support to ext4_map_blocks
  ext4: add support for adding focealign via SETXATTR ioctl
  ext4: disallow unaligned deallocations on forcealign inodes

 fs/ext4/ext4.h              |  20 +-
 fs/ext4/ext4_jbd2.h         |  23 ++
 fs/ext4/extents.c           | 294 ++++++++++++++++---
 fs/ext4/inode.c             | 543 +++++++++++++++++++++++++++++++++---
 fs/ext4/ioctl.c             | 191 +++++++++++++
 fs/ext4/mballoc.c           | 141 ++++++++--
 fs/ext4/super.c             |   1 +
 include/trace/events/ext4.h |   3 +
 include/uapi/linux/fs.h     |   6 +-
 9 files changed, 1111 insertions(+), 111 deletions(-)

-- 
2.48.1


