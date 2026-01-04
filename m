Return-Path: <linux-ext4+bounces-12548-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB7FCF0E60
	for <lists+linux-ext4@lfdr.de>; Sun, 04 Jan 2026 13:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6302C30012CB
	for <lists+linux-ext4@lfdr.de>; Sun,  4 Jan 2026 12:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DBE2C08C4;
	Sun,  4 Jan 2026 12:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SABWv0GB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F40827586C;
	Sun,  4 Jan 2026 12:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767529180; cv=none; b=VFktjWrNYN5S+r64gr2Tchipovjbb4PEt1EzK6IbMk+ouitk3+r3LSWrt+QyECG28Ww1NT+AlIWqiBas4gWbRhAN6RlmcMFOvR5Ba1lumlPXsXEgI5+F647PC1yQQobJzRvISoxuq/1dNkyiLAW2FwQRrr1EMEv9wL8tx+szuYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767529180; c=relaxed/simple;
	bh=ynq8fSojQ08iVT66EJ4Ko2PlqDVUbk0XlS/ehdovl6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DyUAjM+rPgE1r3lNIQyaYZl935s8hDqM9ly/kKhMZY73aSAMF+X7SX0TQne0C3ZosJElQXGYyWnx7nZ/ESmyjvkwJjkUMNybZAHfrNCqvLsO2PugjLdRVY/8HBotmx9pqQ+L6fTz58iqtkjWEqt0uapDvkUa+Y8mOOP4TODW0MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SABWv0GB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6042j4NY017142;
	Sun, 4 Jan 2026 12:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=O9E0+1Gj7KynBMVTKF9CObFIrjDeQQzLJfW3aKEFd
	Mo=; b=SABWv0GB0aPH6nsZkZeRofJyoUnFHbTdKVHlB3D0NEx2okQzuZVyU0L/Y
	mHIFmn7shb0YH0rWujCgRpE6ejj3Fhs4o0M8s3KsoSIR6b30BkkidKDSR4ezfTNX
	im6gg2ObRvHaimmfFPwZylzv3347A5poPY7JI44XpsiNgts8WkWJRu23PwADZGiS
	rDWL3LnxG5vLJ16ElqU2SN/Ma4WixS5YoMTGHhaQqHr4kmH5CN+ZN33WklofcitC
	G6G8nqVvmuAeHenZK2zkYzl9N9+8j+AA7GPOqh6jdelnzGJ9nxO1yzFHJjYK+5sy
	/T6j1y2onD3H8oOFe9xPm46PVBh6w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4berhjufvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 12:19:26 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 604CJQ3F015883;
	Sun, 4 Jan 2026 12:19:26 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4berhjufvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 12:19:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 604ABGwH019161;
	Sun, 4 Jan 2026 12:19:25 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bfg50s67y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 12:19:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 604CJNsL23593250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 4 Jan 2026 12:19:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F22B20043;
	Sun,  4 Jan 2026 12:19:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5336F20040;
	Sun,  4 Jan 2026 12:19:21 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.29.49])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  4 Jan 2026 12:19:21 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, libaokun1@huawei.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] ext4 extent split/convert refactor and kunit tests
Date: Sun,  4 Jan 2026 17:49:13 +0530
Message-ID: <cover.1767528171.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=P4s3RyAu c=1 sm=1 tr=0 ts=695a5ace cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=AiHppB-aAAAA:8
 a=fWUuOSH5oNmgzx4cXQoA:9
X-Proofpoint-ORIG-GUID: 0t4EgO9tosc584GBtxSWtqBAoL1Uj5ne
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA0MDExMyBTYWx0ZWRfX+3gRPziebyeL
 zR1Y4My/UgHkRS3++4Z7E5v4bbwix7bvt0XvYiMV0e2zW8qINa5KIqYZ7uZaDEiqLrDOrFU/CVt
 vhwL9d3Xgs/3WOX9RZDqyQY1thdfKiWJI2frBVXmrI9pUxGZNaN8kn+skuD2oTN4rGhl3WvEPI4
 a5eVNJPfxla1JCjIoCk7cUrdEQgSXQYW0jRkpWVwaUOp6VqwPMLsemvG5yAXHHZmVyrS09Ut7g8
 jQ2V2KNXctrYAOcuFcrR6RpEBO5sBp+U8x89lOBjUB9ZqAyFVLUw9vh3Iy1ocHWDSOb3Hw1xISz
 7e6AI1yVZHK+u415EeyXe1bQ7G67LSMJCJ/F01V0rrhF34g82exrI6bGpf2BMVKLtwx016q4KdZ
 qka/OFAo92Tst4hEuOnpuxOOygqshhICiGVkd5EWyikL/TcvXh/4+5ehrTludwCpMCvdWVXvcHU
 1hsZGlK8nFACNOwoBpA==
X-Proofpoint-GUID: yuTTkHg1MQvzKG6j1UPgojD_qBAM2Ptt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_04,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601040113

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

Testing:
- I've run kvm-xfstests for 4k, 1k and bigalloc_4k with -g quick and I
  see no failures.
- Some new kunit tests that were failing due to inconsistencies are not
  passing
- Due to dev servers being down for eoy maintanence I couldn't run more
  rigourous tests. In the coming week I'll run stress and auto group as
  well.

Thoughts and comments are welcome.

Ojaswin Mujoo (7):
  ext4: kunit tests for extent splitting and conversion
  ext4: kunit tests for higher level extent manipulation functions
  ext4: propagate flags to convert_initialized_extent()
  ext4: propagate flags to ext4_convert_unwritten_extents_endio()
  ext4: Refactor zeroout path and handle all cases
  ext4: Refactor split and convert extents
  ext4: Allow zeroout when doing written to unwritten split

 fs/ext4/extents-test.c   | 871 +++++++++++++++++++++++++++++++++++++++
 fs/ext4/extents.c        | 591 +++++++++++++++-----------
 fs/ext4/extents_status.c |   3 +
 fs/ext4/inode.c          |   4 +
 4 files changed, 1226 insertions(+), 243 deletions(-)
 create mode 100644 fs/ext4/extents-test.c

-- 
2.51.0


