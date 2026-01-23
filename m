Return-Path: <linux-ext4+bounces-13254-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HrmD9oUc2l3sAAAu9opvQ
	(envelope-from <linux-ext4+bounces-13254-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jan 2026 07:27:38 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2611370F73
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jan 2026 07:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 023CE30133AA
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jan 2026 06:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E4025487C;
	Fri, 23 Jan 2026 06:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cQweTKot"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0315360742;
	Fri, 23 Jan 2026 06:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769149564; cv=none; b=GfGc9HQ4qg+aUMtNEAHaDVPn/JLaM6jrRvToPiQp7rx/jb26HfbN9k/mbPqi0qAxYUlxiU21KCi/wQ8n6g8u/BucCkgLFjgx11AHKm4khyYyNk+erxk5MqZ13qsE5OCtf4/5lY/5xSz3RJm0vzm0nuPQ32GBCZeH/H/xmbEGpCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769149564; c=relaxed/simple;
	bh=M00pgA4pjEpwK0faYQilmLhN/J4R4dstIYYP638KpDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nzFmADxXgkwFZMdCFvqJFoJC3OuaLr0VRWauvHN0FGFkyWTWXFK3C93qQPRc59tDMKY+YXt7jgplzTRppRbRYGghQe6h5gJEO0GjQM5O/+YdhXPQsCilsB+xYNYTEKKYGw26+qUzvzaAPvh046RAi9AkGQLJ2M89CjFkn2jNVjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cQweTKot; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60N1EdL7006245;
	Fri, 23 Jan 2026 06:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=bieN1U06SwaFEnzr5Ujj+k845Mq3kBFv6Gs4I64r/
	C4=; b=cQweTKotQb2fYy9j1AZO8p/GLBRvqyR4wspLX4a7Ya6TnSRQLTgwl+NQG
	SMIjfoOsminQV5c1GCylFilvKs29Oj9X1Llbfk55ExovbDGhhjUqjqahhqY1j3J2
	l45XnD0Oix7el/nO9yslXIirqV31L4ttsNB/VWA6lOgR2sipXx9I3oDr04r9tPd6
	tzpTnpQ2R20a8X5dT+lXI7JsXl+QHP8aO4HN3lKGOPYuKmgqRai9nYK3sdkAAWvs
	crFXkhUkXRAhRKH4KTI+5BZNnhquPhrOJUkXMN/0IyajhoI3Mb1PvcqgMXZzRkco
	tgmMP7Zn5OtKd2gnV90fITxpUdoYA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23sec78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 06:25:45 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60N6ONsv021409;
	Fri, 23 Jan 2026 06:25:45 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23sec70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 06:25:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60N43tpB027274;
	Fri, 23 Jan 2026 06:25:44 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brnrnfg3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 06:25:44 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60N6Pgx244368138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 06:25:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDF2820043;
	Fri, 23 Jan 2026 06:25:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A56E20040;
	Fri, 23 Jan 2026 06:25:40 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.26.206])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Jan 2026 06:25:39 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, libaokun1@huawei.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/8] ext4 extent split/convert refactor and kunit tests
Date: Fri, 23 Jan 2026 11:55:31 +0530
Message-ID: <cover.1769149131.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fxsqMXx9jNwXMEAiGu0rYUul-gezpPiq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA0NiBTYWx0ZWRfX3XYo14I38O+J
 w05M/WBscszAvAZIOt9cwT3V67i5f5VR8+4EsWc5D3390yAgeX5LnIpvcwTImZWDI5lKVH2PzE3
 YsbQR/xrIn1+KFE0EX5etCTW2q8V5Gc0RyZK/YnVoHFLs/FzFQR/366tQfm1/818GI+wOHcVNEj
 Vw0TaKNZQ5eHFApWlSktHBOvNLPDMjN+mJyqDkon9HrMOP18wCWkR+UW7+AYJ+cRGxR6TJGu6/j
 gEL1tHBCdxRI5ECUK5v3US/j/kHe2Eot1zT654eDVOxjgrmDKcaeOQw1APgDhx6Pnol4bFfmj91
 1lndJPiAy9aP+yDuFP343BPoNEkjO2e+ubXHuWorsX+1/H6p+5A6rvK0mRTTfE3yqCPQtFmdaER
 A+buefWjggcfYAJKmQHxKYqvZodT+HOuV6svEbzeIJs4sM94sdIGhyIWCROu2tysV9HVkmgrO3l
 o0xtHf3X2sC1d8rOQTQ==
X-Authority-Analysis: v=2.4 cv=J9SnLQnS c=1 sm=1 tr=0 ts=69731469 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=AiHppB-aAAAA:8 a=Qc_3MFns3oNTAPYizdMA:9
X-Proofpoint-ORIG-GUID: hkL6U1i0HGVPFZK9Y35WjNSFaZSayKRj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_06,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601230046
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13254-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,huawei.com,suse.cz,vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[13];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2611370F73
X-Rspamd-Action: no action

@Ted, I've rebased it over

   3574c322b1d0 -  ext4: use optimized mballoc scanning regardless of inode format

in your dev branch. 

Changes in v4:
- Rename EX_DATA_* -> EXT_DATA_* in kunit tests 
  to avoid build warnings on s390 arch due to redefining 
  symbols
- In kunit tests, fix a couple places to use le32_to_cpu() when
  accessing ex->ee_block

v3: https://lore.kernel.org/linux-ext4/cover.1768844021.git.ojaswin@linux.ibm.com/

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
 fs/ext4/extents-test.c   | 1027 ++++++++++++++++++++++++++++++++++++++
 fs/ext4/extents.c        |  568 +++++++++++----------
 fs/ext4/extents_status.c |    1 +
 fs/ext4/inode.c          |   12 +-
 5 files changed, 1357 insertions(+), 255 deletions(-)
 create mode 100644 fs/ext4/extents-test.c

-- 
2.52.0


