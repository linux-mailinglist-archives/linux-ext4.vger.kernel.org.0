Return-Path: <linux-ext4+bounces-6802-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA93A61035
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Mar 2025 12:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F51F1887B34
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Mar 2025 11:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA9C1FDE00;
	Fri, 14 Mar 2025 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OEoHZK24"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E39D1FDA82;
	Fri, 14 Mar 2025 11:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952528; cv=none; b=iLzB6WRXV04Oxjj6bh/Q9OMsyC6ZOnbwwViQljXoDIl9/6YpMRZnsjExbL2+SOBBdKsC+IpjOsYpl5zn1KGRuH3WSnlllC4bspVaWl2NKbdmHUGNDpZmL6+pCQQpUCFxNRgCOeteBemOOPNtCEDGiSbo7Ut2nYSk2Sp9/JV83go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952528; c=relaxed/simple;
	bh=nVOcPJg81+ypVYooo5YBQ0LvK+/ZjYvHXezBn4qqtAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B6+x+SDvpPpk2ZG7EArCb8XhD4o3zWRgZrTuHF3ji/dNekeS1gWPyncso4BDuBAqN+6p0QdXGhyn5j6y0VXQvKRfroF0HVyvluJavfVWMbYMUxlhk3cGKvyp7ieoSPvIrWtkg17E00NKaiLyjFxYfqebGOD0I12b/hzCUjDJ1NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OEoHZK24; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EAeDIH014198;
	Fri, 14 Mar 2025 11:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=QMHbiVdF4O6NsMrpAke9v18+Iz0kX6/uRd/3dGnJP
	Lg=; b=OEoHZK24FkzBYLZauUS2BA+PzTr/2mDinByo8jks48auT0neSZDFPJzDG
	LKNd0t6Vo2zGVfeQKkXx5aM8hU2JT9++lSz/0lh42Ayxb2urRF5QZwy4DAvu+qIq
	pC2RvmbDIETL77iSIYKwRo9/G6mQqj1hKnkURKSKMhRQPc7ZI1Fj/mt2TiN09BjE
	uvFwqiEEwHtFQg/ICXVH+QCZF5b2CwMGt9qxzi0jz+q5MHjuJ98aOV3Z0+/IO+Tb
	Dc4owZ242nPxijb7gH51Q1JGHzBTseOg5vSJDoqEph1LndppZgf/Lf5NVj9rb8gR
	sxabdJapZ1AYC3p8cAa/8aE+Vz5Kg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6k03c2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 11:41:49 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52EBfdQN021972;
	Fri, 14 Mar 2025 11:41:49 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6k03c2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 11:41:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52E8rENB015368;
	Fri, 14 Mar 2025 11:41:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atspppy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 11:41:48 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52EBfkIc57278972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 11:41:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CE5920043;
	Fri, 14 Mar 2025 11:41:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 079F620040;
	Fri, 14 Mar 2025 11:41:45 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.24.194])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Mar 2025 11:41:44 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: cache es->s_journal_inum in ext4_sb_info
Date: Fri, 14 Mar 2025 17:11:43 +0530
Message-ID: <d1a9328a41029f6210a1924b192a59afcd3c5cee.1741952406.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F3LawNexBkdp0jJNdrlxSwR1Il06KrhQ
X-Proofpoint-ORIG-GUID: _AQLMt3fWaMY2sYl2EUJSpid7b0Mar7U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_04,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 adultscore=0 spamscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2503140091

Currently, we access journal ino through sbi->s_es->s_journal_inum,
which directly reads from the ext4 sb buffer head. If someone modifies
this underneath us then the s_journal_inum field might get corrupted.

Although direct block device modifications can be expected to cause
issues in the FS, let's cache s_journal_inum in sbi->s_journal_ino so
our checks can be more resillient.

Suggested-by: Baokun Li <libaokun1@huawei.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/block_validity.c | 23 ++++++++++++++++-------
 fs/ext4/ext4.h           |  1 +
 fs/ext4/inode.c          | 19 +++++++++++++++----
 fs/ext4/super.c          |  5 ++++-
 4 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 87ee3a17bd29..54e6f3499263 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -247,9 +247,9 @@ int ext4_setup_system_zone(struct super_block *sb)
 		if (ret)
 			goto err;
 	}
-	if (ext4_has_feature_journal(sb) && sbi->s_es->s_journal_inum) {
+	if (ext4_has_feature_journal(sb) && sbi->s_journal_ino) {
 		ret = ext4_protect_reserved_inode(sb, system_blks,
-				le32_to_cpu(sbi->s_es->s_journal_inum));
+						  sbi->s_journal_ino);
 		if (ret)
 			goto err;
 	}
@@ -351,11 +351,20 @@ int ext4_check_blockref(const char *function, unsigned int line,
 {
 	__le32 *bref = p;
 	unsigned int blk;
-
-	if (ext4_has_feature_journal(inode->i_sb) &&
-	    (inode->i_ino ==
-	     le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
-		return 0;
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+
+	if (ext4_has_feature_journal(inode->i_sb)) {
+		/* If we are called from journal init path then
+		 * sbi->s_journal_ino would be 0
+		 */
+		u32 journal_ino = sbi->s_journal_ino ?
+					  sbi->s_journal_ino :
+					  sbi->s_es->s_journal_inum;
+		WARN_ON_ONCE(journal_ino == 0);
+
+		if (inode->i_ino == journal_ino)
+			return 0;
+	}
 
 	while (bref < p+max) {
 		blk = le32_to_cpu(*bref++);
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 2b7d781bfcad..648b0459e9fd 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1556,6 +1556,7 @@ struct ext4_sb_info {
 	u32 s_max_batch_time;
 	u32 s_min_batch_time;
 	struct file *s_journal_bdev_file;
+	u32 s_journal_ino;
 #ifdef CONFIG_QUOTA
 	/* Names of quota files with journalled quota */
 	char __rcu *s_qf_names[EXT4_MAXQUOTAS];
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 365d31004bd0..50961bc0c94d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -384,10 +384,21 @@ static int __check_block_validity(struct inode *inode, const char *func,
 				unsigned int line,
 				struct ext4_map_blocks *map)
 {
-	if (ext4_has_feature_journal(inode->i_sb) &&
-	    (inode->i_ino ==
-	     le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
-		return 0;
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+
+	if (ext4_has_feature_journal(inode->i_sb)) {
+		/*
+		 * If we are called from journal init path then
+		 * sbi->s_journal_ino would be 0
+		 */
+		u32 journal_ino = sbi->s_journal_ino ?
+					  sbi->s_journal_ino :
+					  sbi->s_es->s_journal_inum;
+		WARN_ON_ONCE(journal_ino == 0);
+
+		if (inode->i_ino == journal_ino)
+			return 0;
+	}
 	if (!ext4_inode_block_valid(inode, map->m_pblk, map->m_len)) {
 		ext4_error_inode(inode, func, line, map->m_pblk,
 				 "lblock %lu mapped to illegal pblock %llu "
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index a963ffda692a..44e79db7f12a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4162,7 +4162,8 @@ int ext4_calculate_overhead(struct super_block *sb)
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_super_block *es = sbi->s_es;
 	struct inode *j_inode;
-	unsigned int j_blocks, j_inum = le32_to_cpu(es->s_journal_inum);
+	unsigned int j_blocks;
+	u32 j_inum = sbi->s_journal_ino;
 	ext4_group_t i, ngroups = ext4_get_groups_count(sb);
 	ext4_fsblk_t overhead = 0;
 	char *buf = (char *) get_zeroed_page(GFP_NOFS);
@@ -6091,6 +6092,8 @@ static int ext4_load_journal(struct super_block *sb,
 		ext4_commit_super(sb);
 	}
 
+	EXT4_SB(sb)->s_journal_ino = le32_to_cpu(es->s_journal_inum);
+
 	return 0;
 
 err_out:
-- 
2.48.1


