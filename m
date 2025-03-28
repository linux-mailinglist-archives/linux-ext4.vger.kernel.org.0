Return-Path: <linux-ext4+bounces-7004-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E116A743FD
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Mar 2025 07:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28174189E661
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Mar 2025 06:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D47B20E024;
	Fri, 28 Mar 2025 06:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZxTshFlK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCC979CF;
	Fri, 28 Mar 2025 06:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743143114; cv=none; b=QgT2i01TzSwccHKtfpn2cNqQjCb8Ijsl7kVH7wn0V6bmY0nel3b54CQVGTL+GtxhsicuqYSajleCRk0wwviVZPciqkJbtpUlRazsl76PSQ21dzv7nyMnd288KM/2OOuYk2UYqdQocVeMrxicfDYsE4xzJo0ERiykDggbm560h1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743143114; c=relaxed/simple;
	bh=LhiZSXy12dCNmbQ4MrC6Zmzr2tg8/TBSWMffYdINIJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sU0UfoVRPVH48UQhmYlzO979ZePBdGmKe5scFxuvbd3OIcIljXUmJyet+l+jZbxhtwidYPc0e/QEmRyNM2JFHoCDgc7x1qzLyvMpFpTKu8cBWv7e4q2tCpjzjH2YKo1QR89egSWUskc8jw2yNxRsT+b1cUN+hsG3303ZGpdVlS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZxTshFlK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RKZhge028163;
	Fri, 28 Mar 2025 06:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=EMUvFjaXLxWnHzFxpQj98QZKEzRT2DIRyfzMuVh8b
	Bg=; b=ZxTshFlK/dY5iaC8FnJqJUYX3VA1dFnAP5wNa3T+A6DtNpA1F2srjkGTU
	aH465ELV62u1gX3sKDpucy96Tvn8L4eZbDDWETxy2X3Wqi1HjL59zwxYRbvijJhv
	CJNWKsqC16fjxeTVkp1Gqw7bv1lxhoTra64NnofL8kkrcaOdXZLnZ/D4SXLj6xZ8
	l8lCXHgyy+lYPO9BF2XNF6uavQt8JY1GQKcGmvZJ5vhIIhm+QFqC+miH/BL7SCWo
	GZt6Nxrs/6Vm99KlbAktJ95kWAnpXkhc0nCyFTKoZVAd8TjPZDCA/bM0bJd9RyQs
	the3dJ5sW8MaQ/iBLhH+laT0rbSfA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ndupt1mw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Mar 2025 06:24:59 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52S6NS2O021090;
	Fri, 28 Mar 2025 06:24:58 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ndupt1mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Mar 2025 06:24:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52S5OUFq005796;
	Fri, 28 Mar 2025 06:24:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ja82rtyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Mar 2025 06:24:57 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52S6OuTp57606464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Mar 2025 06:24:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E44120043;
	Fri, 28 Mar 2025 06:24:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23CD620040;
	Fri, 28 Mar 2025 06:24:54 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.16.221])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Mar 2025 06:24:53 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] ext4: Make block validity check resistent to sb bh corruption
Date: Fri, 28 Mar 2025 11:54:52 +0530
Message-ID: <0c06bc9ebfcd6ccfed84a36e79147bf45ff5adc1.1743142920.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oVZXVLlMJF-zU0TfMA4ndE75MJIqPnNA
X-Proofpoint-ORIG-GUID: 7V4fsORfxZcNvZCW5t0tJNxY-AQLd0W2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_03,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 suspectscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503280039

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
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---

** Changes since v1 [2] **
 - minor indentation fix
 - RVBs from Yi, Baokun & Jan (Thanks!)

[2] https://lore.kernel.org/linux-ext4/c434eb50ee5161e23036d58a6166a7e216f6d6a0.1743097281.git.ojaswin@linux.ibm.com/

** Changes since v1 [1] **

- instead of using an sbi field direction check against jorunal->j_inode
- let block validity perform basic checks on journal blocks as well
	during init path
- kvm-xfstests quick tests are passing
- commit header changed

[1] https://lore.kernel.org/linux-ext4/d1a9328a41029f6210a1924b192a59afcd3c5cee.1741952406.git.ojaswin@linux.ibm.com/

 fs/ext4/block_validity.c | 5 ++---
 fs/ext4/inode.c          | 7 ++++---
 2 files changed, 6 insertions(+), 6 deletions(-)

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
index 365d31004bd0..67429c50e5a0 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -384,10 +384,11 @@ static int __check_block_validity(struct inode *inode, const char *func,
 				unsigned int line,
 				struct ext4_map_blocks *map)
 {
-	if (ext4_has_feature_journal(inode->i_sb) &&
-	    (inode->i_ino ==
-	     le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
+	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
+
+	if (journal && inode == journal->j_inode)
 		return 0;
+
 	if (!ext4_inode_block_valid(inode, map->m_pblk, map->m_len)) {
 		ext4_error_inode(inode, func, line, map->m_pblk,
 				 "lblock %lu mapped to illegal pblock %llu "
-- 
2.48.1


