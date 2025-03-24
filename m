Return-Path: <linux-ext4+bounces-6968-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2524CA6D54C
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Mar 2025 08:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD2003B4FBC
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Mar 2025 07:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7786525A2CE;
	Mon, 24 Mar 2025 07:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Es7V9iDA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53147257AF1;
	Mon, 24 Mar 2025 07:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742801869; cv=none; b=B6j1M9dhZIfc8p5+sWFY6oumX53q19KKh3f9o2TdCQ+64P0L6Lkg4zUjiYxqBj4ljCK9BpgtcbcQB+p6PxcgD71N/7rcLhjklIoG++lTj+4f8dRYnqXLygN3VOzWMDEYlFQ8bm6v0oj5AQjijtsRDXVNstb3a28KTfmvNf0rQnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742801869; c=relaxed/simple;
	bh=Y7Ul2jyT3cWVzT8RfDz+X63lcuEoa8dpMdFyToo3qIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YyNmGhG0UXm/NHN08Avqtejmc6XG0Nf3NQM7SpJ2falgunutodfQGjflGEHiLdHtUVdYsWZ/5ZPaL56qnqYcs3er+LcRd0jAMWXNkwpGvUmXypv1AZ0SCpO8n8I+HISLLt2lVnSC3/qIIUpYSPH4cLa85WbZ5sN/0K9+Zo4290c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Es7V9iDA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O6UKWC023812;
	Mon, 24 Mar 2025 07:37:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HJnGTQ2UZ8x8a3YyI
	v7zxS8nbxG22mpw5d8hfomK1+Q=; b=Es7V9iDA2X20UrrjNOKT0lF2DKvoXUPqX
	hocLcVCEiNSPp9xhxOI327ZHlt0on3lDwOqQirW+/Xctwo7HVptHvaV4s1SYrDVY
	kAVy496kdTGf3oAN8EPTBo7vzO9MPPThIAG1OZzv7mGP2v8xB4m/278iK1Cwybw7
	HM41Jk75rk3JW9uj/eVR4FoaXCVkJE6ik7YLovUbQ9c4R04nb/ezybXdqlHuaEe3
	mvmsVpvM5LOALdclnxwkO2fOrBEivrwb9Ijdo6RWY+XgWqLWK2QqzCvExBsAxS11
	MIpS9OOTnpQfrN8BIFOsjA6gsLzQZFf2+R6TMtP50YRowwlUbjZEQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jkqp36a2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:38 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52O7bcFG006996;
	Mon, 24 Mar 2025 07:37:38 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jkqp369w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52O3UQpw020082;
	Mon, 24 Mar 2025 07:37:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j8hnn5k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:36 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52O7bZgM52691448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Mar 2025 07:37:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E93F32004E;
	Mon, 24 Mar 2025 07:37:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D58D20040;
	Mon, 24 Mar 2025 07:37:33 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.29.200])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Mar 2025 07:37:32 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: John Garry <john.g.garry@oracle.com>, dchinner@redhat.com,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org
Subject: [RFC v3 10/11] ext4: add support for adding focealign via SETXATTR ioctl
Date: Mon, 24 Mar 2025 13:07:08 +0530
Message-ID: <c7ac23316807de400c2c162f3778bf02178b869a.1742800203.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742800203.git.ojaswin@linux.ibm.com>
References: <cover.1742800203.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 09b_xKBoMvY7Lc6OKt8aS7q7JDKOJNcf
X-Proofpoint-ORIG-GUID: 3r--c8yug3Q5VsFAltr6EX8juwP-iZBb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240053

With forcealign set on an inode, we should always either get an extent
physically aligned to the extsize or we should error out. This is
suitable for hardware accelerated atomic writes since it allows us to
exit early rather than sending the bio and then getting an error from
the device.

This patch adds the SET/GETXATTR ioctl level support to set/get this
flag. Right now, this can only be set if extsize is set on an inode.

Since we are almost out of inode flags, we reuse the unused
EXT4_EOFBLOCKS_FL.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/ext4.h          |  5 ++-
 fs/ext4/ext4_jbd2.h     |  8 +++++
 fs/ext4/extents.c       |  7 ++++-
 fs/ext4/inode.c         | 16 ++++++++--
 fs/ext4/ioctl.c         | 69 +++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fs.h |  6 ++--
 6 files changed, 104 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index a7429797c1d2..690caad50cb6 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -514,6 +514,9 @@ struct flex_groups {
 #define EXT4_CASEFOLD_FL		0x40000000 /* Casefolded directory */
 #define EXT4_RESERVED_FL		0x80000000 /* reserved for ext4 lib */
 
+/* Extended flags, can only be set via FS_SETXATTR ioctl */
+#define EXT4_FORCEALIGN_XFL		0x00400000 /* Inode must do algined allocation */
+
 /* User modifiable flags */
 #define EXT4_FL_USER_MODIFIABLE		(EXT4_SECRM_FL | \
 					 EXT4_UNRM_FL | \
@@ -528,7 +531,6 @@ struct flex_groups {
 					 EXT4_DIRSYNC_FL | \
 					 EXT4_TOPDIR_FL | \
 					 EXT4_EXTENTS_FL | \
-					 0x00400000 /* EXT4_EOFBLOCKS_FL */ | \
 					 EXT4_DAX_FL | \
 					 EXT4_PROJINHERIT_FL | \
 					 EXT4_CASEFOLD_FL)
@@ -605,6 +607,7 @@ enum {
 	EXT4_INODE_VERITY	= 20,	/* Verity protected inode */
 	EXT4_INODE_EA_INODE	= 21,	/* Inode used for large EA */
 /* 22 was formerly EXT4_INODE_EOFBLOCKS */
+	EXT4_INODE_FORCEALIGN	= 22,	/* Inode should do aligned allocation */
 	EXT4_INODE_DAX		= 25,	/* Inode is DAX */
 	EXT4_INODE_INLINE_DATA	= 28,	/* Data in inode. */
 	EXT4_INODE_PROJINHERIT	= 29,	/* Create with parents projid */
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 53b930f6c797..f88149ff0033 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -467,6 +467,14 @@ static inline int ext4_should_use_extsize(struct inode *inode)
 	return (ext4_inode_get_extsize(EXT4_I(inode)) > 0);
 }
 
+static inline int ext4_should_use_forcealign(struct inode *inode)
+{
+	if (!ext4_should_use_extsize(inode))
+		return 0;
+
+	return (ext4_test_inode_flag(inode, EXT4_INODE_FORCEALIGN));
+}
+
 static inline int ext4_should_use_unwrit_extents(struct inode *inode)
 {
 	return (ext4_should_dioread_nolock(inode) ||
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 25c1368b49bb..1835e18f0eef 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4855,9 +4855,14 @@ static long ext4_do_fallocate(struct file *file, loff_t offset,
 	}
 
 	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
-	if (ext4_should_use_extsize(inode))
+	if (ext4_should_use_extsize(inode)) {
 		flags |= EXT4_GET_BLOCKS_EXTSIZE;
 
+		if (ext4_should_use_forcealign(inode)) {
+			flags |= EXT4_GET_BLOCKS_FORCEALIGN;
+		}
+	}
+
 	ret = ext4_alloc_file_blocks(file, start_lblk, len_lblk, new_size,
 				     flags);
 	if (ret)
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 93ab76cb4818..5b36e62872d6 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -922,7 +922,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 			 * deallocation both respect extsize. If
 			 * not, something has gone terribly wrong.
 			 */
-			if (WARN_ON((map->m_lblk != extsize_mlblk) ||
+			if (WARN_ON_ONCE((map->m_lblk != extsize_mlblk) ||
 				    (map->m_len != extsize_mlen))) {
 				ext4_error_adjust_map(map, orig_map);
 				ext4_warning(
@@ -1138,9 +1138,14 @@ int ext4_get_block_unwritten(struct inode *inode, sector_t iblock,
 	int ret = 0;
 	int flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
 
-	if (ext4_should_use_extsize(inode))
+	if (ext4_should_use_extsize(inode)) {
 		flags |= EXT4_GET_BLOCKS_EXTSIZE;
 
+		if (ext4_should_use_forcealign(inode)) {
+			flags |= EXT4_GET_BLOCKS_FORCEALIGN;
+		}
+	}
+
 	ext4_debug("ext4_get_block_unwritten: inode %lu, create flag %d\n",
 		   inode->i_ino, create);
 	ret = _ext4_get_block(inode, iblock, bh_result, flags);
@@ -3720,8 +3725,13 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
 	else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
 		m_flags = EXT4_GET_BLOCKS_IO_CREATE_EXT;
 
-		if (ext4_should_use_extsize(inode))
+		if (ext4_should_use_extsize(inode)) {
 			m_flags |= EXT4_GET_BLOCKS_EXTSIZE;
+
+			if (ext4_should_use_forcealign(inode)) {
+				m_flags |= EXT4_GET_BLOCKS_FORCEALIGN;
+			}
+		}
 	}
 
 	if (ext4_should_use_extsize(inode))
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 48f62d7c27e6..5c3cdbe17e2b 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -795,6 +795,67 @@ static int ext4_ioctl_setextsize(struct inode *inode, u32 extsize, u32 xflags)
 	return err;
 }
 
+/*
+ * If forcealign = 0 then caller wants to unset it.
+ */
+static int ext4_ioctl_setforcealign(struct inode *inode, bool forcealign)
+{
+	int err = 0;
+	char *msg = NULL;
+	handle_t *handle;
+
+	bool has_forcealign = ext4_test_inode_flag(inode, EXT4_INODE_FORCEALIGN);
+	bool set_forcealign = (forcealign && !has_forcealign);
+	bool unset_forcealign = (!forcealign && has_forcealign);
+
+	bool modify_forcealign = ((set_forcealign && !has_forcealign) || unset_forcealign);
+	if (!modify_forcealign)
+		return 0;
+
+	if (set_forcealign && !ext4_inode_get_extsize(EXT4_I(inode))) {
+		msg = "forcealign can't be used without extsize set";
+		err = -EINVAL;
+		goto error;
+	}
+
+	handle = ext4_journal_start(inode, EXT4_HT_INODE, 1);
+	if (IS_ERR(handle)) {
+		err = PTR_ERR(handle);
+		goto error;
+	}
+
+	struct ext4_iloc iloc;
+	err = ext4_reserve_inode_write(handle, inode, &iloc);
+	if (err < 0)
+		goto error_journal;
+
+	if (set_forcealign) {
+		ext4_set_inode_flag(inode, EXT4_INODE_FORCEALIGN);
+	} else if (unset_forcealign)
+		ext4_clear_inode_flag(inode, EXT4_INODE_FORCEALIGN);
+
+	inode_set_ctime_current(inode);
+	inode_inc_iversion(inode);
+
+	err = ext4_mark_iloc_dirty(handle, inode, &iloc);
+	if (err < 0)
+		goto error_journal;
+
+	err = ext4_journal_stop(handle);
+	if (err < 0)
+		goto error;
+
+	return 0;
+error_journal:
+	if (handle)
+		ext4_journal_stop(handle);
+error:
+	if (msg)
+		ext4_warning_inode(inode, "%s\n", msg);
+
+	return err;
+}
+
 #ifdef CONFIG_QUOTA
 static int ext4_ioctl_setproject(struct inode *inode, __u32 projid)
 {
@@ -1088,6 +1149,9 @@ int ext4_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 		fa->fsx_xflags |= FS_XFLAG_EXTSIZE;
 	}
 
+	if (ext4_test_inode_flag(inode, EXT4_INODE_FORCEALIGN))
+		fa->fsx_xflags |= FS_XFLAG_FORCEALIGN;
+
 	return 0;
 }
 
@@ -1144,6 +1208,11 @@ int ext4_fileattr_set(struct mnt_idmap *idmap,
 			goto out;
 		fa->fsx_xflags = 0;
 	}
+
+	err = ext4_ioctl_setforcealign(inode,
+				       (fa->fsx_xflags & FS_XFLAG_FORCEALIGN));
+	if (err)
+		goto out;
 out:
 	return err;
 }
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 2bbe00cf1248..944fa77ce18e 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -167,7 +167,9 @@ struct fsxattr {
 #define FS_XFLAG_FILESTREAM	0x00004000	/* use filestream allocator */
 #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
 #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
-#define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
+/* data extent mappings for regular files must be aligned to extent size hint */
+#define FS_XFLAG_FORCEALIGN 	0x00020000
+#define FS_XFLAG_HASATTR 	0x80000000 	/* no DIFLAG for this	*/
 
 /* the read-only stuff doesn't really belong here, but any other place is
    probably as bad and I don't want to create yet another include file. */
@@ -295,7 +297,7 @@ struct fsxattr {
 #define FS_EXTENT_FL			0x00080000 /* Extents */
 #define FS_VERITY_FL			0x00100000 /* Verity protected inode */
 #define FS_EA_INODE_FL			0x00200000 /* Inode used for large EA */
-#define FS_EOFBLOCKS_FL			0x00400000 /* Reserved for ext4 */
+/* Was previously FS_EOFBLOCKS_FL (reserved for ext4) */
 #define FS_NOCOW_FL			0x00800000 /* Do not cow file */
 #define FS_DAX_FL			0x02000000 /* Inode is DAX */
 #define FS_INLINE_DATA_FL		0x10000000 /* Reserved for ext4 */
-- 
2.48.1


