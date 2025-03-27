Return-Path: <linux-ext4+bounces-6996-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 383FAA73CB4
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Mar 2025 18:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1398B189BB6B
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Mar 2025 17:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEB315B102;
	Thu, 27 Mar 2025 17:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MFNMyCtZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F169C1A3150;
	Thu, 27 Mar 2025 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743097711; cv=none; b=JhAC4apw1Mno1KWJ0Q3Aca8XkFvquleS1uYH29ZEO+yFeK9m2DhluPhrH8T/YhIP63nQ2IoazXoLSr3uzjfXyw947aolYa/q/LmQXfee003WgvHzV+BakCLe2KT1443SPTiBBhe3o++3JiPLFBEQ3nyJ54+99hqj4Paxjw7jHLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743097711; c=relaxed/simple;
	bh=n5Fgyxwm/3OJhV9wcL6Q3xhIZkO171ATh9/xVS/7iCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dbfcgBhgcjTS1hv4ofyMPb0XM2S3p+7mui/T45GamQykMvUsF3uMk900lW23HJWTP0eKd+406zFpq9zli0dc1EXqM1iI3sfajPgFYifqfwfthl3TdfHXPFaHLeSDmAuM1FFv04Z6vX2wxYVN+Euwliu65AzMk21HkzwcpLcxt2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MFNMyCtZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RDLLC3029908;
	Thu, 27 Mar 2025 17:48:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=49rk5v8MEFhz//kPC0D7Mb2Oyq2KyjRDj30MErMoW
	mM=; b=MFNMyCtZycV5O2cQpkygJsTeLycyZUtMHkGH914bnOphaWIen71xkpvhN
	l6Ug4L7Elq9kqzf0ds/nGWKdCnnM2C4lvx0BhNHy7lzKUCMGt7sbeB+YPOagtfOL
	2xCoXAM4zusQu0AuJBIYGsoNhYSBvbGqceb9QVZKzjbCPLF+ukfVRL8TRlekE/EB
	1vulaan+UGSU54LZ+oAx5gMasYHdGkUzh141vPEyH0WL9Z9CADbau6bD8rvEIhF+
	cJz08HmCBkSWk7c3iKv6ow16B+gv/aOWDpUKzD0mZ7syVR0iZtCuzakKBLyoEfyC
	ssuDW0o++slxrYqgqLWS8WHBQ4wHQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45my29c9mh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 17:48:15 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52RHmF5E022686;
	Thu, 27 Mar 2025 17:48:15 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45my29c9me-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 17:48:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52REbqOd030325;
	Thu, 27 Mar 2025 17:48:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j7htpq81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 17:48:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52RHmCSG46268900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 17:48:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 754AD20043;
	Thu, 27 Mar 2025 17:48:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2E8120040;
	Thu, 27 Mar 2025 17:48:10 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.215.70])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Mar 2025 17:48:10 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ext4: Make block validity check resistent to sb bh corruption
Date: Thu, 27 Mar 2025 23:18:09 +0530
Message-ID: <c434eb50ee5161e23036d58a6166a7e216f6d6a0.1743097281.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NS8pO99WOpbBs9d1vwYYBuBlxRyP6Q1n
X-Proofpoint-ORIG-GUID: B7eaVkTv9x_7fArkdXN1_QQlY7GkXAf5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_02,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=948 suspectscore=0 impostorscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503270116

Block validity checks need to be skipped in case they are called
for journal blocks since they are part of system's protected
zone.

Currently, this is done by checking inode->ino against
sbi->s_es->s_journal_inum, which is a direct read from the ext4 sb
buffer head. If someone modifies this underneath us then the
s_journal_inum field might get corrupted. To prevent against this,
change the check to directly compare the inode with journal->j_inode.

**Slight change in behavior**: During journal init path,
check_block_validity etc might be called for journal inode when
sbi->s_journal is not set yet. In this case we now proceed with
ext4_inode_block_valid() instead of returning early. Since systems zones
have not been set yet, it is okay to proceed so we can perform basic
checks on the blocks.

Suggested-by: Baokun Li <libaokun1@huawei.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---

** Changes since v1 [1] **

- instead of using an sbi field direction check against jorunal->j_inode
- let block validity perform basic checks on journal blocks as well
	during init path
- kvm-xfstests quick tests are passing

[1] https://lore.kernel.org/linux-ext4/d1a9328a41029f6210a1924b192a59afcd3c5cee.1741952406.git.ojaswin@linux.ibm.com/

 fs/ext4/block_validity.c | 5 ++---
 fs/ext4/inode.c          | 9 +++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 87ee3a17bd29..e8c5525afc67 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -351,10 +351,9 @@ int ext4_check_blockref(const char *function, unsigned int line,
 {
 	__le32 *bref = p;
 	unsigned int blk;
+	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
 
-	if (ext4_has_feature_journal(inode->i_sb) &&
-	    (inode->i_ino ==
-	     le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
+	if (journal && inode == journal->j_inode)
 		return 0;
 
 	while (bref < p+max) {
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 365d31004bd0..8b048be14008 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -384,10 +384,11 @@ static int __check_block_validity(struct inode *inode, const char *func,
 				unsigned int line,
 				struct ext4_map_blocks *map)
 {
-	if (ext4_has_feature_journal(inode->i_sb) &&
-	    (inode->i_ino ==
-	     le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
-		return 0;
+	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
+
+	if (journal && inode == journal->j_inode)
+			return 0;
+
 	if (!ext4_inode_block_valid(inode, map->m_pblk, map->m_len)) {
 		ext4_error_inode(inode, func, line, map->m_pblk,
 				 "lblock %lu mapped to illegal pblock %llu "
-- 
2.48.1


