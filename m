Return-Path: <linux-ext4+bounces-6962-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0A7A6D531
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Mar 2025 08:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42219169B66
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Mar 2025 07:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D798258CD8;
	Mon, 24 Mar 2025 07:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MjCgEcIg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447CE2586E0;
	Mon, 24 Mar 2025 07:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742801858; cv=none; b=tqrB3BMV47+AIpG+4cnF7sDcFD3fYLIrWAOjlC1yGcvoQjU3FZBEVaNhOwzfj3uJJzK3sU1mm1Fl2xVC8uCCnhm0FLHXv81SWVx5hte3jZzN/eAxD/EOWg1dZNfYbWvIoOJI6l6XK72LClWwWb7KbEs4v14PsZg01BEp9E1H99k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742801858; c=relaxed/simple;
	bh=24FeMYG6wq81DhPy8/5wr5797KIPubb6tdtskGIFS/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6IJ/3VrPXn19YjdtSScjhyjlU1eP0Lxnc63hfnAuNtqfV3xvlXj8VYyKcNNnJ5kktfHjkKukgJ2/bkN6nPgwr9gbm9HJmwtZzn8wCpVTupha1i0VUGVTldUZEQcbOQmEvzzQM+ZtDusqT0xLYsTsMl6RaiX4p1UMxlhKIlfTuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MjCgEcIg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O7R14X004873;
	Mon, 24 Mar 2025 07:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=juBr27iCuBDKuucZE
	x9JX6/rqy46tVT40wAvkBXBRZI=; b=MjCgEcIgnTqh67/j9Ov4V9nG4dAW0SN3R
	vZblybLN/ifiBUj5fnnfSg32ti7g+uZvOrNBfgPEgJHucj5OCWM5dakCvUBhBKfO
	JmDp+n/mV0b2cptAAcu6yhpwtAv8x5t47KDJn+tPf6k056dTRSnmQ3dCtEcsm6LG
	t19huqIicuocYRx7ThHuGgq8YibpnbFwfBBFIyS115JRa9YzPJDSRwFUsGadfy5G
	w7z+3XUb0tKDf5BT6HViWsaMrIj8AEmR+yXTe3HGdS2FZoEoUaCmgMnoc0ug2xfU
	QBRbpjHuWQxRHb2JbayfxA1DO1ViQfkrxHuY9x2VTGERG1rGa1ONg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jkqp368v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:22 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52O7Kcbx006882;
	Mon, 24 Mar 2025 07:37:21 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jkqp368q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52O508IL009718;
	Mon, 24 Mar 2025 07:37:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j9rkcxg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:20 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52O7bI7i6816176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Mar 2025 07:37:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D013120040;
	Mon, 24 Mar 2025 07:37:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A4EF2004B;
	Mon, 24 Mar 2025 07:37:17 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.29.200])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Mar 2025 07:37:16 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: John Garry <john.g.garry@oracle.com>, dchinner@redhat.com,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org
Subject: [RFC v3 03/11] ext4: support for extsize hint using FS_IOC_FS(GET/SET)XATTR
Date: Mon, 24 Mar 2025 13:07:01 +0530
Message-ID: <630bf8077b84d576462eb6d1e2a55b0471b324c1.1742800203.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-GUID: _7uT4si1rBPy6sVg8V_XbVSvTacieOjj
X-Proofpoint-ORIG-GUID: wzoo4Bmgxbc97NNZy7rRl5y6hN6qQ8e4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240053

This patch adds support for getting and setting extsize hint using
FS_IOC_GETXATTR and FS_IOC_SETXATTR interface. The extsize is stored
in xattr of type EXT4_XATTR_INDEX_SYSTEM.

Restrictions on setting extsize:

1. extsize can't be set on files with data
2. extsize can't be set on non regular files
3. extsize hint can't be used with bigalloc (yet)
4. extsize (in blocks) should be power-of-2 for simplicity.
5. extsize must be a multiple of block size

The ioctl behavior has been kept as close to the XFS equivalent
as possible.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/ext4.h  |   6 +++
 fs/ext4/inode.c |  89 +++++++++++++++++++++++++++++++++++
 fs/ext4/ioctl.c | 122 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ext4/super.c |   1 +
 4 files changed, 218 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 2c83275d2ad4..75c1c70f7815 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1173,6 +1173,8 @@ struct ext4_inode_info {
 	__u32 i_csum_seed;
 
 	kprojid_t i_projid;
+	/* The extentsize hint for the inode in blocks */
+	ext4_grpblk_t i_extsize;
 };
 
 /*
@@ -3051,6 +3053,10 @@ extern void ext4_da_update_reserve_space(struct inode *inode,
 					int used, int quota_claim);
 extern int ext4_issue_zeroout(struct inode *inode, ext4_lblk_t lblk,
 			      ext4_fsblk_t pblk, ext4_lblk_t len);
+int ext4_inode_xattr_get_extsize(struct inode *inode);
+int ext4_inode_xattr_set_extsize(struct inode *inode, ext4_grpblk_t extsize);
+ext4_grpblk_t ext4_inode_get_extsize(struct ext4_inode_info *ei);
+void ext4_inode_set_extsize(struct ext4_inode_info *ei, ext4_grpblk_t extsize);
 
 /* indirect.c */
 extern int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index aede80fa1781..00d8e9065a02 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4976,6 +4976,20 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 		}
 	}
 
+	ret = ext4_inode_xattr_get_extsize(&ei->vfs_inode);
+	if (ret >= 0) {
+		ei->i_extsize = ret;
+	} else if (ret == -ENODATA) {
+		/* extsize is not set */
+		ei->i_extsize = 0;
+	} else {
+		ext4_error_inode(
+			inode, function, line, 0,
+			"iget: error while retrieving extsize from xattr: %ld", ret);
+		ret = -EFSCORRUPTED;
+		goto bad_inode;
+	}
+
 	EXT4_INODE_GET_CTIME(inode, raw_inode);
 	EXT4_INODE_GET_ATIME(inode, raw_inode);
 	EXT4_INODE_GET_MTIME(inode, raw_inode);
@@ -6311,3 +6325,78 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	ext4_journal_stop(handle);
 	goto out;
 }
+
+/*
+ * Returns positive extsize if set, 0 if not set else error
+ */
+ext4_grpblk_t ext4_inode_xattr_get_extsize(struct inode *inode)
+{
+	char *buf;
+	int size, ret = 0;
+	ext4_grpblk_t extsize = 0;
+
+	size = ext4_xattr_get(inode, EXT4_XATTR_INDEX_SYSTEM, "extsize", NULL, 0);
+
+	if (size == -ENODATA || size == 0) {
+		return 0;
+	} else if (size < 0) {
+		ret = size;
+		goto exit;
+	}
+
+	buf = (char *)kmalloc(size + 1, GFP_KERNEL);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	size = ext4_xattr_get(inode, EXT4_XATTR_INDEX_SYSTEM, "extsize", buf,
+			      size);
+	if (size == -ENODATA)
+		/* No extsize is set */
+		extsize = 0;
+	else if (size < 0)
+		ret = size;
+	else {
+		buf[size] = '\0';
+		ret = kstrtoint(buf, 10, &extsize);
+	}
+
+	kfree(buf);
+exit:
+	if (ret)
+		return ret;
+	return extsize;
+}
+
+int ext4_inode_xattr_set_extsize(struct inode *inode, ext4_grpblk_t extsize)
+{
+	int err = 0;
+	/* max value of extsize should fit within 11 chars */
+	char extsize_str[11];
+
+	err = snprintf(extsize_str, 10, "%u", extsize);
+	if (err < 0)
+		return err;
+
+	/* Try to replace the xattr if it exists, else try to create it */
+	err = ext4_xattr_set(inode, EXT4_XATTR_INDEX_SYSTEM, "extsize",
+			     extsize_str, strlen(extsize_str), XATTR_REPLACE);
+
+	if (err == -ENODATA)
+		err = ext4_xattr_set(inode, EXT4_XATTR_INDEX_SYSTEM, "extsize",
+				     extsize_str, strlen(extsize_str),
+				     XATTR_CREATE);
+
+	return err;
+}
+
+ext4_grpblk_t ext4_inode_get_extsize(struct ext4_inode_info *ei)
+{
+	return ei->i_extsize;
+}
+
+void ext4_inode_set_extsize(struct ext4_inode_info *ei, ext4_grpblk_t extsize)
+{
+	ei->i_extsize = extsize;
+}
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index d17207386ead..48f62d7c27e6 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -708,6 +708,93 @@ static int ext4_ioctl_setflags(struct inode *inode,
 	return err;
 }
 
+static u32 ext4_ioctl_getextsize(struct inode *inode)
+{
+	ext4_grpblk_t extsize;
+
+	extsize = ext4_inode_get_extsize(EXT4_I(inode));
+
+	return (u32) extsize << inode->i_blkbits;
+}
+
+
+static int ext4_ioctl_setextsize(struct inode *inode, u32 extsize, u32 xflags)
+{
+	int err;
+	ext4_grpblk_t extsize_blks = extsize >> inode->i_blkbits;
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	int blksize = 1 << inode->i_blkbits;
+	char *msg = NULL;
+
+	if (!S_ISREG(inode->i_mode)) {
+		msg = "Cannot set extsize on non regular file";
+		err = -EOPNOTSUPP;
+		goto error;
+	}
+
+	/*
+	 *  We are okay with a non-zero i_size as long as there is no data.
+	 */
+	if (ext4_has_inline_data(inode) ||
+	    READ_ONCE(EXT4_I(inode)->i_disksize) ||
+	    EXT4_I(inode)->i_reserved_data_blocks) {
+		msg = "Cannot set extsize on file with data";
+		err = -EINVAL;
+		goto error;
+	}
+
+	if (extsize % blksize) {
+		msg = "extsize must be multiple of blocksize";
+		err = -EINVAL;
+		goto error;
+	}
+
+	if (sbi->s_cluster_ratio > 1) {
+		msg = "Can't use extsize hint with bigalloc";
+		err = -EINVAL;
+		goto error;
+	}
+
+	if ((xflags & FS_XFLAG_EXTSIZE) && extsize == 0) {
+		msg = "fsx_extsize can't be 0 if FS_XFLAG_EXTSIZE is passed";
+		err = -EINVAL;
+		goto error;
+	}
+
+	if (extsize_blks > sbi->s_blocks_per_group) {
+		msg = "extsize cannot exceed number of bytes in block group";
+		err = -EINVAL;
+		goto error;
+	}
+
+	if (extsize && !is_power_of_2(extsize_blks)) {
+		msg = "extsize must be either power-of-2 in fs blocks or 0";
+		err = -EINVAL;
+		goto error;
+	}
+
+	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
+		msg = "extsize can't be set on non-extent based files";
+		err = -EINVAL;
+		goto error;
+	}
+
+	/* update the extsize in inode xattr */
+	err = ext4_inode_xattr_set_extsize(inode, extsize_blks);
+	if (err < 0)
+		return err;
+
+	/* Update the new extsize in the in-core inode */
+	ext4_inode_set_extsize(EXT4_I(inode), extsize_blks);
+	return 0;
+
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
@@ -985,6 +1072,7 @@ int ext4_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 	struct inode *inode = d_inode(dentry);
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	u32 flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
+	u32 extsize = 0;
 
 	if (S_ISREG(inode->i_mode))
 		flags &= ~FS_PROJINHERIT_FL;
@@ -993,6 +1081,13 @@ int ext4_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 	if (ext4_has_feature_project(inode->i_sb))
 		fa->fsx_projid = from_kprojid(&init_user_ns, ei->i_projid);
 
+	extsize = ext4_ioctl_getextsize(inode);
+	/* Flag is only set if extsize is non zero */
+	if (extsize > 0) {
+		fa->fsx_extsize = extsize;
+		fa->fsx_xflags |= FS_XFLAG_EXTSIZE;
+	}
+
 	return 0;
 }
 
@@ -1022,6 +1117,33 @@ int ext4_fileattr_set(struct mnt_idmap *idmap,
 	if (err)
 		goto out;
 	err = ext4_ioctl_setproject(inode, fa->fsx_projid);
+	if (err)
+		goto out;
+
+	if (fa->fsx_xflags & FS_XFLAG_EXTSIZE) {
+		err = ext4_ioctl_setextsize(inode, fa->fsx_extsize,
+					    fa->fsx_xflags);
+		if (err)
+			goto out;
+	} else if (fa->fsx_extsize == 0) {
+		/*
+		 * Even when user explicitly passes extsize=0 the flag is cleared in
+		 * fileattr_set_prepare().
+		 */
+		if (ext4_inode_get_extsize(EXT4_I(inode)) != 0) {
+			err = ext4_ioctl_setextsize(inode, fa->fsx_extsize,
+						    fa->fsx_xflags);
+			if (err)
+				goto out;
+		}
+
+	} else {
+		/* Unexpected usage, reset extsize to 0 */
+		err = ext4_ioctl_setextsize(inode, 0, fa->fsx_xflags);
+		if (err)
+			goto out;
+		fa->fsx_xflags = 0;
+	}
 out:
 	return err;
 }
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 8122d4ffb3b5..250479a1d237 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1413,6 +1413,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 	spin_lock_init(&ei->i_completed_io_lock);
 	ei->i_sync_tid = 0;
 	ei->i_datasync_tid = 0;
+	ei->i_extsize = 0;
 	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
 	ext4_fc_init_inode(&ei->vfs_inode);
 	mutex_init(&ei->i_fc_lock);
-- 
2.48.1


