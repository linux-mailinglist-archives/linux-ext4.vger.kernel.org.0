Return-Path: <linux-ext4+bounces-12829-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 505E4D1F928
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jan 2026 15:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C9C92300D80F
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jan 2026 14:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716053112AD;
	Wed, 14 Jan 2026 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T78Xo8cc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6F93101BA;
	Wed, 14 Jan 2026 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768402692; cv=none; b=WVUpcfqvBCPxUOurLDAlY/0L83IXl5A7cyWi0h0L2adzZz7q5/zgAW1q6F1uHrImRubw1rVsKRW/S68mlw1Q6glwVeONbLgt1mJzSSK0jO4Rk7LivI4eMcGDwerz88+L5GHOarpLV1bCsNh13S7ShumbT9O6H3TlC+QTcFBvdcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768402692; c=relaxed/simple;
	bh=FtFBhEPV6uqvQyxDiaelH5ZvVC+kXsge+5QKzW+Fe9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VV08ibTAEECgWCHVwS1l1XOXRtL0g/49eIr/pzzq7EOM43m9Ce0rZjCD8xh5M0m6U1xbPkxRh5xPJsRIC4IqJh/AmvYxUILanmHg52QCqTJH9SY8yZv8U5UOxHH9YXrLm0vu05sLRD6gmnL3kA73gSIH0mN6sEvNu58lFXym7NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T78Xo8cc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60E6MNHg022598;
	Wed, 14 Jan 2026 14:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=pSfMjvOjw4imc9OLMoaP7FGzdBDU0zJTKTY8/4Hv1
	aw=; b=T78Xo8ccZbiwU/G3IJ7wYiSUpSiApRouGScA4cKyWi1XVP/ix6aMNYywL
	8K+f2VzQyLewiGRpobb28fuG4GMoLKuIWXLfBUJN2JQZbijhUKsMzj1nt0dR0Zk6
	WLk7IB285W/Yx2fx5+mLtsrQR/xlvUpQMskutWwvOv8zSQgvetNg40Ou8FTlmS8s
	GuzczxrdzqAB74R6AsJzKcuWL1Y5jDwA5Qm00ZMZju101he5uLqwP60YXEx1mxRC
	JHjbqmGCr5g1Q3SRZxOpvrUPh1gR0acq0m+qT6+U9S5tib1moIU+b7l/zpZk2eRH
	rWQhUSVMpWmlBc76cZV2hPsCDpz5Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkc6h9q86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 14:57:58 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60EEX6Fm027766;
	Wed, 14 Jan 2026 14:57:58 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkc6h9q81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 14:57:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60EDIkeG002493;
	Wed, 14 Jan 2026 14:57:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm13stta6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 14:57:57 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60EEvttU45744456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 14:57:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95CFB20043;
	Wed, 14 Jan 2026 14:57:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F172220040;
	Wed, 14 Jan 2026 14:57:53 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.19.170])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Jan 2026 14:57:53 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, libaokun1@huawei.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] ext4 extent split/convert refactor and kunit tests
Date: Wed, 14 Jan 2026 20:27:44 +0530
Message-ID: <cover.1768402426.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: a4zxwjR1SW7CE4H4ns5-elN_LS2PAKnd
X-Proofpoint-ORIG-GUID: fSxTXk2JpsPldCr9MDyAs9hbXZnVf9Cu
X-Authority-Analysis: v=2.4 cv=TaibdBQh c=1 sm=1 tr=0 ts=6967aef6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=AiHppB-aAAAA:8 a=Qc_3MFns3oNTAPYizdMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEyMyBTYWx0ZWRfX4oo4wEYj16Gb
 LLz2uSBZ28m5f68jzpI5lLKdzzbS5U/h/RloJrPAkxDxWnMcGvJI12LYRoEjyjumLNtBm9oJY0Z
 Nd/TKrlwcSyhwdKcvrxbl/gDOpkg04ytR8uV4r2305bloU6RG0NzXm8b4+K8J6rZvnvJfVd2Tlb
 yLiTqDNs9sYkDgku5hYDOelcehcRnsCoezuXQ3XKIsq+ji/Egyi2U0GBPWt+/3UrNVGZNIgo9E8
 IolkfQvCWymjjgcVLqm6ycCdEe42Nyx4cei61Zx6FyHCQgfEmQ2bzI/chuEPS1FJ6tmnmGarK42
 Y9wAXNzjBOVE9xzsNi3AZq3eCvftW6QUBwKVHivH0oZ3laiKmZ+29pUIdcV7Y1WD48uUg4kcpIN
 5RC5a9jyN5Y09D0fK0uC5lMykypU6+y8RZdiOzKVQOvfY2jDk1CioK3sXoyNpSb8TnQXX4a1eWj
 iSr8SAI1TvS0l02bcmg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601140123

Changes in v2:

** KUnit **

- Added new patch 3 to add support for tracking extent status cache in 
  kunit tests
- Kunit tests in patch 2 now test ext4_map_create_blocks() since the
  final es cachine is done here.
- Also refactored the patch 2 to avoid duplicate code.

** extent handling code **

- Fixed some issues detected by extent status Kunit tests where we were
  going out of sync when zeroout fallback was taken.
- We no longer handle unwrit to unwrit split as there are no users of
  that anymore
- Made sure to propogate flags to ext4_find_extent() as well in patch 4,5.
  Also remove some duplication of flags.
- Cleaned up the code flow of ext4_split_extent() in patch 6.
- Picked up RVBs by Jan.

v1: https://lore.kernel.org/linux-ext4/cover.1767528171.git.ojaswin@linux.ibm.com/T/#t

** Testing **

- Run xfstests for 4k, 64k and nodioread_nolock for -g auto with no new
  regressions.
- All new kunit tests in patch 1-3 that were failing due to issues are now
  passing with the patches

** Original Cover **

Offlate we've have seen multiple issues and inconsistencies in the
our extent splitting and conversion logic causing subtle bugs. Recent
patches by Yhang Zi [1] helped address some of the issues however
the messy use of EXT4_EXT_DATA_VALID* and EXT4_EXT_MARK_UNWRIT* flags
made the implementation confusing and error prone.

This patchset aims to refactor the explent split and convert code paths
to make the code simpler and the behavior consistent and easy to
understand. It also adds several Kunit tests to stress various
permutations of extent splitting and conversion.

I've rebased this over [2] since it seems like it'll go in first. 

Another idea I want to try out after this is proactively zeroout
before even trying to split, as Jan suggested here [3], but before
trying to do that I wanted to refactor and add some tests hence sending
these patches out first.

[1] https://lore.kernel.org/linux-ext4/20251129103247.686136-1-yi.zhang@huaweicloud.com/
[2] https://lore.kernel.org/linux-ext4/20251223011802.31238-1-yi.zhang@huaweicloud.com/T/#t
[3] https://lore.kernel.org/linux-ext4/yro4hwpttmy6e2zspvwjfdbpej6qvhlqjvlr5kp3nwffqgcnfd@z6qual55zhfq/

Rest of the details can be found in the commit messages.

Patch 1-2: new kunit tests
Patch 3-4: minor fixes
Patch 5: refactoring zeroout and making sure zeroout handles all
        permutations correctly
Patch 6: Refactoring ext4_split_* functions.
Patch 7: Enable zeroout for writ to unwrit case

*****

Ojaswin Mujoo (8):
  ext4: kunit tests for extent splitting and conversion
  ext4: kunit tests for higher level extent manipulation functions
  ext4: Add extent status cache support to kunit tests
  ext4: propagate flags to convert_initialized_extent()
  ext4: propagate flags to ext4_convert_unwritten_extents_endio()
  ext4: Refactor zeroout path and handle all cases
  ext4: Refactor split and convert extents
  ext4: Allow zeroout when doing written to unwritten split

 fs/ext4/ext4.h           |   4 +
 fs/ext4/extents-test.c   | 894 +++++++++++++++++++++++++++++++++++++++
 fs/ext4/extents.c        | 571 ++++++++++++++-----------
 fs/ext4/extents_status.c |   1 +
 fs/ext4/inode.c          |  12 +-
 5 files changed, 1227 insertions(+), 255 deletions(-)
 create mode 100644 fs/ext4/extents-test.c

-- 
2.52.0


