Return-Path: <linux-ext4+bounces-13049-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F82FD3B4B4
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jan 2026 18:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C671C303835B
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jan 2026 17:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDF532D450;
	Mon, 19 Jan 2026 17:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DUKSSIWZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FFB328B63;
	Mon, 19 Jan 2026 17:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768844602; cv=none; b=h1uawwbmTexossFRsChWWYit9D47ZByrktBdU00OC5Ttn4py95UytTHDSWLU8/BeBFIUbupCckB82Zd8zOEudHFkrRTL/no2TE8Nxce2FTDOI8PDtkG9XKXfNLhUW9ZjeTkdVyJ977cEE/roVmhS85R3BF6ydQjmqlMTYKfVI98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768844602; c=relaxed/simple;
	bh=BDQ/6s+CZJg4fezMvZxztZynw17b1CqFm+Q1pBsAJxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UqtS0EPvffnKcky0Y1oDwcSN3lL4uzBT8SlAzz2tnKZIjV4Qz5Xd28/OtfAG/K83WhoErJbk5Il92tvnzsEePe1UssnGy4PfMFnY5HwHZQL2BtlV3AMlx2M5XJq9PAWRpeie+8/6BX8B7CFcUH2A/cxaMihvYsWk+UCzt7fSPAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DUKSSIWZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60JEGQLa020077;
	Mon, 19 Jan 2026 17:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Z4lf9qZnMlklyOd0UTmw1u/fzD8lJG6ZNCTfjoHPR
	fM=; b=DUKSSIWZ9Ah2DZJ++mkROT2iSLwJD4nSJuk3X6okwZthMbWL+4xkX/YTJ
	EXXrblklwGXe3OXft0CunsyPUfndmRIyxEpcVf07H6sDB/boSRa1Z4u+Ee2KTKWc
	XCQDveIPb11ig00RNgyHnxdrAyZJnPaZKJlR7imG8PJPl91yW4hvMwJUKvuwSE/6
	CLMiYaOxWmSXCWaYLB36foxrd46ROSQ6zxHA2Hmk6c07FBopFvmgnIJuy/PLDVtk
	GOZN13+etPsC3a5d50orEw6BWPwyW1tXg/2t805Hu1r16QIB2PDN/iZ/he+8dsFQ
	heAEIEreph7+HedlF6b835/WniCUg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br255spbf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 17:43:11 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60JHepvi025181;
	Mon, 19 Jan 2026 17:43:11 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br255spbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 17:43:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60JGGvds024640;
	Mon, 19 Jan 2026 17:43:10 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brxarejx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 17:43:09 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60JHh8HY56361366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 17:43:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FFE720040;
	Mon, 19 Jan 2026 17:43:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5340E20043;
	Mon, 19 Jan 2026 17:43:06 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.220.173])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Jan 2026 17:43:05 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, libaokun1@huawei.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/8] ext4 extent split/convert refactor and kunit tests
Date: Mon, 19 Jan 2026 23:12:56 +0530
Message-ID: <cover.1768844021.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE0NCBTYWx0ZWRfX5qo6TKoxZ9+3
 ZHRcD1q6DRpHUC4R8rSe94AHRB/lJE32GWgKuRVgmyz7AbHzUKuOQBnrXlgk1B575ddmyA4hoGc
 ZomTSxcLrPMSgVTLiTuWtlRsmS4jlABpq+i+TVUq+g7QlFRLmPBrswRjxLWmZsogoXGYsXLE+9p
 ZZBz4EJEM2a/7JQZXFvy9dOOkhX6SsLSopfhKKjHdtz1Wr0eXIyS0QpTI5QUOPXy12AeiZv1iue
 YU0bjaXSPWRK4WDy9oOwuor2HZS4DdtbAac1sL4x01cOSu3TrNQ1KleIwuJfD8tDhxlaSN4S2+N
 sAVZ+psBnoSRB875QWeGqmto16BJ35iharALb7zvr0vIGZRI5gvAkwlovzjv3agKLrDiN+1JZU8
 yj7bzUYZbONep+M29mLfK6SAe1DbIEJzB7pvvUt8xlL2MVTN+f18Xx+koKRqfFpX+SWU6RB/Z3b
 sSXme2dUXK1ogUUhrfA==
X-Authority-Analysis: v=2.4 cv=BpSQAIX5 c=1 sm=1 tr=0 ts=696e6d2f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=AiHppB-aAAAA:8 a=Qc_3MFns3oNTAPYizdMA:9
X-Proofpoint-GUID: ulM3ERUJEaBljEcVXZr1al4Af__UYcw9
X-Proofpoint-ORIG-GUID: legssOJ5tIaAdJosrKwvvkag4y9WmamF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_04,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601190144

Hi everyone, 
thanks for the reviews, the patches are now looking in a good shap
I see no new regressions in 4k, 64k and nodioread_nolock for -g auto
group.

@Ted, I see you have tentatively picked v2 in dev branch for your
testing, so I've rebased this one over commit 1aaa8643dca3 in the dev
branch. Hope it applied smoothly :)

Changes in v3:

- Use EX_DATA_LBLK/LEN instead of hard-coding in extents-test.c
- RVBs of Jan and Yi (Thanks!)
- Patch 6/8 - update orig_* after first split
- Minor fixes

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

 fs/ext4/ext4.h           |    4 +
 fs/ext4/extents-test.c   | 1025 ++++++++++++++++++++++++++++++++++++++
 fs/ext4/extents.c        |  568 +++++++++++----------
 fs/ext4/extents_status.c |    1 +
 fs/ext4/inode.c          |   12 +-
 5 files changed, 1355 insertions(+), 255 deletions(-)
 create mode 100644 fs/ext4/extents-test.c

-- 
2.52.0


