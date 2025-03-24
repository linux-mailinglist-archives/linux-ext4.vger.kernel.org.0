Return-Path: <linux-ext4+bounces-6966-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D38A6D536
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Mar 2025 08:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5457816C8AD
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Mar 2025 07:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689A025A2A0;
	Mon, 24 Mar 2025 07:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="piXf25Ke"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF03259C8C;
	Mon, 24 Mar 2025 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742801864; cv=none; b=DmYSjmkBgnINXPw7YusUb0BsJDzUreue/ew8mRo6UwtRy0yrclAQF92d7qDURqUgcjIP0kMdL5GPbdxfqfYHts30ByFtvPUhct/AfdneKzYOvnxxu/b2YxaMffd6ASCtqM3Gbv7cfxVL5oemDRgNihMQnqVXX6a4Oa+o4eJjx3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742801864; c=relaxed/simple;
	bh=Z8x7JO0VofSlC3TbkezEDpvpOsVLT4H1Oy3WGKrUpb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XxAxXVygQydUEUG1FxOqOv4FVtmTNtg5uwtzZRzUbsY044ejJTpjvQLFh46d8o5L9PIU/bYR76HfFAA/mt/zmdpCVuAo86H6QTP+bhuds8QdU+PC9uj9djqxYP49VN1H8H56Ga5gz++qMXbb86beYPYY0OTt1GoQZhAWy8olcUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=piXf25Ke; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52NKaUq4030364;
	Mon, 24 Mar 2025 07:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KX2ntTwlFPBFs4Q7T
	8vUNpejMJZ4JnENg735S80/MrU=; b=piXf25Ke7vRp27eXckKZdo9L1fVbWAVJG
	x0Miag10HyaexJf1YDwgsD3hOHUAAOFmw14Ox/Bj6CBCT/O2k0Kbb7aLZRtF+26F
	VLBjKzGDPfhBu5ila83ogXHxtEGApB/pecsoFtogsEVWEIQVXicDSF7A9LFwF5L+
	ReIdvNWg7TWtHfZoWL6GbkeHHmpiOdJ5KpqM4f0EePYo3Od39OwlQQXLX+S84vM+
	8Wydc1RbNy+9e7MF42JnseLIUnYz7hUfGkLFxjxLmrCOFLeUFyQPNdNZqgwCc5Zx
	Pi5HP5BswwHsoMDslinxfaeIYtm5ZyAUI3TzAdbuEMYFtOR8LhUKw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jsfpa174-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:26 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52O7bQfb009120;
	Mon, 24 Mar 2025 07:37:26 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jsfpa170-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52O4xcnP005969;
	Mon, 24 Mar 2025 07:37:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ja824u34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52O7bNP958130742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Mar 2025 07:37:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B3BF20043;
	Mon, 24 Mar 2025 07:37:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 965CC20040;
	Mon, 24 Mar 2025 07:37:21 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.29.200])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Mar 2025 07:37:21 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: John Garry <john.g.garry@oracle.com>, dchinner@redhat.com,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org
Subject: [RFC v3 05/11] ext4: add extsize hint support
Date: Mon, 24 Mar 2025 13:07:03 +0530
Message-ID: <cdf246f00613d238c776da87996e312147d3d5fe.1742800203.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 66s0PSszIdzaf62E1zH9u8Kab-GWcmrO
X-Proofpoint-GUID: UR77XDEzEmhjInA3x8ZkAjxZAvgkuDrF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503240053

Now that the ioctl is in place, add the underlying infrastructure
to support extent size hints.

** MOTIVATION **

1. This feature allows us to ask the allocator for blocks that are
logically AS WELL AS physically aligned to an extent size hint (aka
extsize), that is generally a power of 2.

2. This means both start and the length of the physical and logical range
should be aligned to the extsize.

3. This sets up the infra we'll eventually need for supporting
  non-torn/atomic writes that need to follow a certain alignment as
  required by hardware.

4. This can also be extent to other use cases like stripe alignment

** DESIGN NOTES **

* Physical Alignment *

1. Since the extsize is always a power-of-2 (for now) in fs blocks, we
leverage CR_POWER2_ALIGNED allocation to get the blocks. This ensures the
blocks are physically aligned

2. Since this is just a hint, incase we are not able to get any aligned
blocks we simply drop back to non aligned allocation.

* Logical Alignment *

The flow of extsize aligned allocation with buffered and
direct IO:

            +--------------------------------------------------------+
            |                     Buffered IO                        |
            +--------------------------------------------------------+
            |    ext4_map_blocks() call with extsize allocation      |
            +--------------------------------------------------------+
                                       |
                 +--------------------------------------------+
                 |  Adjust lblk and len to align to extsize   |
                 +--------------------------------------------+
                                       |
            +--------------------------------------------------------+
            |Pre-existing written/unwritten blocks in extsize range? |
            +--------------------------+-----------------------------+
                   YES                                      NO
                    |                                        |
    +---------------v---------------+      +-----------------v------------------+
    |     Covers orig range?        |      |      Allocate extsize range        |
    +---------------+---------------+      +---------------------+--------------+
         |                    |                              |
        YES                  NO                              |
         |                    |              +---------------v------------------+
+--------v-------+    +-------v---------+    |   Mark allocated extent as       |
| Return blocks  |    | Fallback to     |    |           unwritten              |
+----------------+    | non-extsize     |    +----------------+-----------------+
                      | allocation      |                     |
                      +-----------------+    +----------------v-----------------+
                                             |   Insert extsize extent          |
                                             |         into tree                |
                                             +----------------+-----------------+
                                                              |
                                             +----------------v-----------------+
                                             |     Return allocated blocks      |
                                             +----------------------------------+

                   +--------------------------------------------+
                   |           During writeback:                |
                   +--------------------------------------------+
                   |  Use PRE_IO to split only the dirty extent |
                   +--------------------------------------------+

                   +--------------------------------------------+
                   |              After IO:                     |
                   +--------------------------------------------+
                   |    Convert the extent under IO to written  |
                   +--------------------------------------------+

Same flow for direct IO:

+----------------------------------------------------------------------+
|                              Direct IO                               |
+----------------------------------------------------------------------+
|   ext4_map_blocks() called with extsize allocation and PRE-IO        |
+----------------------------------------------------------------------+
                                   |
+----------------------------------------------------------------------+
|         Adjust lblk and len to align to extsize                      |
+----------------------------------------------------------------------+
                                   |
+----------------------------------------------------------------------+
|        Pre-existing written blocks in extsize range?                 |
+----------------------------------+-----------------------------------+
             YES                                       NO
              |                                         |
    +---------v----------+           +------------------v-----------------+
    | Covers orig range? |           | Unwritten blocks in extsize range? |
    +---------+----------+           +------------------+-----------------+
        |            |                        |                    |
       YES          NO                       YES                  NO
        |            |                        |                    |
+-------v----+ +-----v--------+    +----------v----------+ +-------v----------+
|   Return   | | Fallback to  |    | Call ext4_ext_map_  | | Allocate extsize |
|   blocks   | | non-extsize  |    | blocks() ->ext4_ext | |      range       |
+------------+ | allocation   |    | _handle_unwritten_  | +-------+----------+
               +--------------+    |     extents()       |         |
                                   +----------+----------+ +-------v----------+
                                              |            |  Mark complete   |
                                   +----------v----------+ | range unwritten  |
                                   | Split orig range    | |  & insert in     |
                                   | from bigger         | |      tree        |
                                   | unwritten extent    | +-------+----------+
                                   +----------+----------+         |
                                              |            +-------v----------+
                                   +----------v----------+ | Split orig range |
                                   | Mark split extent   | | from bigger      |
                                   |    as unwritten     | | allocated extent |
                                   +----------+----------+ +-------+----------+
                                              |                    |
                                   +----------v----------+ +-------v----------+
                                   | Return split extent | | Mark split extent|
                                   |      to user        | |   as unwritten   |
                                   +---------------------+ +-------+----------+
                                                                   |
                                                           +-------v----------+
                                                           | Return split     |
                                                           | extent to user   |
                                                           +------------------+

              +--------------------------------------------+
              |              After IO:                     |
              +--------------------------------------------+
              |    Convert the extent under IO to written  |
              +--------------------------------------------+

** IMPLEMENTATION NOTES **

* Callers of ext4_map_blocks work under the assumption that
  ext4_map_blocks will always only return as much as requested or less
  but now we might end up allocating more so make changes to
  ext4_map_blocks to make sure we adjust the allocated map to only
  return as much as user requested.

* Further, we now maintain 2 maps in ext4_map_blocks - the original map
  and the extsize map that is used when extsize hint allocation is taking
  place. We also pass these 2 maps down because some functions might now
  need information of the original map as well as the extsize map.
  * For example, when we go for direct IO and there's a hole in the orig
    range requested, we allocate based on extsize range and then split the
    bigger unwritten extent onto smaller unwritten extents based on orig
    range. (Needed so we dont have to split after IO). For this, we need
    the information of extsize range as well as orig range hence 2 maps.

* Since now we allocate more than the user requested, to avoid stale
  data exposure, we mark the bigger extsize extent as unwritten and then
  use the similar flow of dioread_nolock to only mark the extent under
  write as written.

* We disable extsize hints when writes are beyond EOF (for now)

* When extsize is set on an inode, we drop to no delalloc allocations
  similar to XFS.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/ext4.h              |   4 +-
 fs/ext4/ext4_jbd2.h         |  15 ++
 fs/ext4/extents.c           | 174 ++++++++++++++++--
 fs/ext4/inode.c             | 354 ++++++++++++++++++++++++++++++++----
 include/trace/events/ext4.h |   1 +
 5 files changed, 495 insertions(+), 53 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 75c1c70f7815..ab4f10f9031a 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -727,6 +727,7 @@ enum {
 #define EXT4_GET_BLOCKS_IO_SUBMIT		0x0400
 	/* Caller is in the atomic contex, find extent if it has been cached */
 #define EXT4_GET_BLOCKS_CACHED_NOWAIT		0x0800
+#define EXT4_GET_BLOCKS_EXTSIZE			0x1000
 
 /*
  * The bit position of these flags must not overlap with any of the
@@ -3708,7 +3709,8 @@ struct ext4_extent;
 extern void ext4_ext_tree_init(handle_t *handle, struct inode *inode);
 extern int ext4_ext_index_trans_blocks(struct inode *inode, int extents);
 extern int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
-			       struct ext4_map_blocks *map, int flags);
+			       struct ext4_map_blocks *orig_map,
+			       struct ext4_map_blocks *extsize_map, int flags);
 extern int ext4_ext_truncate(handle_t *, struct inode *);
 extern int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 				 ext4_lblk_t end);
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 3221714d9901..53b930f6c797 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -458,4 +458,19 @@ static inline int ext4_journal_destroy(struct ext4_sb_info *sbi, journal_t *jour
 	return err;
 }
 
+static inline int ext4_should_use_extsize(struct inode *inode)
+{
+	if (!S_ISREG(inode->i_mode))
+		return 0;
+	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
+		return 0;
+	return (ext4_inode_get_extsize(EXT4_I(inode)) > 0);
+}
+
+static inline int ext4_should_use_unwrit_extents(struct inode *inode)
+{
+	return (ext4_should_dioread_nolock(inode) ||
+		ext4_should_use_extsize(inode));
+}
+
 #endif	/* _EXT4_JBD2_H */
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 4e604ce6ce35..a86cc3e76f14 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3889,15 +3889,24 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 
 static struct ext4_ext_path *
 ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
-			struct ext4_map_blocks *map,
+			struct ext4_map_blocks *orig_map,
+			struct ext4_map_blocks *extsize_map,
 			struct ext4_ext_path *path, int flags,
 			unsigned int *allocated, ext4_fsblk_t newblock)
 {
+	struct ext4_map_blocks *map;
 	int err = 0;
 
-	ext_debug(inode, "logical block %llu, max_blocks %u, flags 0x%x, allocated %u\n",
-		  (unsigned long long)map->m_lblk, map->m_len, flags,
-		  *allocated);
+	if (flags & EXT4_GET_BLOCKS_EXTSIZE) {
+		BUG_ON(extsize_map == NULL);
+		map = extsize_map;
+	} else
+		map = orig_map;
+
+	ext_debug(
+		inode,
+		"logical block %llu, max_blocks %u, flags 0x%x, allocated %u\n",
+		(unsigned long long)map->m_lblk, map->m_len, flags, *allocated);
 	ext4_ext_show_leaf(inode, path);
 
 	/*
@@ -3906,13 +3915,14 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 	 */
 	flags |= EXT4_GET_BLOCKS_METADATA_NOFAIL;
 
-	trace_ext4_ext_handle_unwritten_extents(inode, map, flags,
-						*allocated, newblock);
+	trace_ext4_ext_handle_unwritten_extents(inode, map, flags, *allocated,
+						newblock);
 
 	/* get_block() before submitting IO, split the extent */
 	if (flags & EXT4_GET_BLOCKS_PRE_IO) {
+		/* Split should always happen based on original mapping */
 		path = ext4_split_convert_extents(
-			handle, inode, map->m_lblk, map->m_len, path,
+			handle, inode, orig_map->m_lblk, orig_map->m_len, path,
 			flags | EXT4_GET_BLOCKS_CONVERT, allocated);
 		if (IS_ERR(path))
 			return path;
@@ -3927,11 +3937,19 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 			err = -EFSCORRUPTED;
 			goto errout;
 		}
+
+		/*
+		 * For extsize case we need to adjust lblk to start of split
+		 * extent because the m_len will be set to len of split extent.
+		 * No change for non extsize case
+		 */
+		map->m_lblk = orig_map->m_lblk;
 		map->m_flags |= EXT4_MAP_UNWRITTEN;
 		goto out;
 	}
 	/* IO end_io complete, convert the filled extent to written */
 	if (flags & EXT4_GET_BLOCKS_CONVERT) {
+		BUG_ON(map == extsize_map);
 		path = ext4_convert_unwritten_extents_endio(handle, inode,
 							    map, path);
 		if (IS_ERR(path))
@@ -4189,7 +4207,8 @@ static ext4_lblk_t ext4_ext_determine_insert_hole(struct inode *inode,
  * return < 0, error case.
  */
 int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
-			struct ext4_map_blocks *map, int flags)
+			struct ext4_map_blocks *orig_map,
+			struct ext4_map_blocks *extsize_map, int flags)
 {
 	struct ext4_ext_path *path = NULL;
 	struct ext4_extent newex, *ex, ex2;
@@ -4200,6 +4219,17 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	unsigned int allocated_clusters = 0;
 	struct ext4_allocation_request ar;
 	ext4_lblk_t cluster_offset;
+	struct ext4_map_blocks *map;
+#ifdef CONFIG_EXT4_DEBUG
+	struct ext4_ext_path *test_path = NULL;
+#endif
+
+	if (flags & EXT4_GET_BLOCKS_EXTSIZE) {
+		BUG_ON(extsize_map == NULL);
+		map = extsize_map;
+	} else
+		map = orig_map;
+
 
 	ext_debug(inode, "blocks %u/%u requested\n", map->m_lblk, map->m_len);
 	trace_ext4_ext_map_blocks_enter(inode, map->m_lblk, map->m_len, flags);
@@ -4256,6 +4286,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 			 */
 			if ((!ext4_ext_is_unwritten(ex)) &&
 			    (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN)) {
+				BUG_ON(map == extsize_map);
 				path = convert_initialized_extent(handle,
 					inode, map, path, &allocated);
 				if (IS_ERR(path))
@@ -4272,8 +4303,8 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 			}
 
 			path = ext4_ext_handle_unwritten_extents(
-				handle, inode, map, path, flags,
-				&allocated, newblock);
+				handle, inode, orig_map, extsize_map, path,
+				flags, &allocated, newblock);
 			if (IS_ERR(path))
 				err = PTR_ERR(path);
 			goto out;
@@ -4306,6 +4337,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	 */
 	if (cluster_offset && ex &&
 	    get_implied_cluster_alloc(inode->i_sb, map, ex, path)) {
+		BUG_ON(map == extsize_map);
 		ar.len = allocated = map->m_len;
 		newblock = map->m_pblk;
 		goto got_allocated_blocks;
@@ -4325,6 +4357,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	 * cluster we can use. */
 	if ((sbi->s_cluster_ratio > 1) && err &&
 	    get_implied_cluster_alloc(inode->i_sb, map, &ex2, path)) {
+		BUG_ON(map == extsize_map);
 		ar.len = allocated = map->m_len;
 		newblock = map->m_pblk;
 		err = 0;
@@ -4379,6 +4412,8 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 		ar.flags |= EXT4_MB_DELALLOC_RESERVED;
 	if (flags & EXT4_GET_BLOCKS_METADATA_NOFAIL)
 		ar.flags |= EXT4_MB_USE_RESERVED;
+	if (flags & EXT4_GET_BLOCKS_EXTSIZE)
+		ar.flags |= EXT4_MB_HINT_ALIGNED;
 	newblock = ext4_mb_new_blocks(handle, &ar, &err);
 	if (!newblock)
 		goto out;
@@ -4400,9 +4435,114 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 		map->m_flags |= EXT4_MAP_UNWRITTEN;
 	}
 
-	path = ext4_ext_insert_extent(handle, inode, path, &newex, flags);
-	if (IS_ERR(path)) {
-		err = PTR_ERR(path);
+	if ((flags & EXT4_GET_BLOCKS_EXTSIZE) &&
+	    (flags & EXT4_GET_BLOCKS_PRE_IO)) {
+		/*
+		 * With EXTSIZE and PRE-IO (direct io case) we have to be careful
+		 * because we want to insert the complete extent but split only the
+		 * originally requested range.
+		 *
+		 * Below are the different (S)cenarios and the (A)ction we take:
+		 *
+		 * S1: New extent covers the original range completely/partially.
+		 * A1: Insert new extent, allow merges. Then split the original
+		 * range from this. Adjust the length of split if new extent only
+		 * partially covers original.
+		 *
+		 * S2: New extent doesn't cover original range at all
+		 * A2: Just insert this range and return. Rest is handled in
+		 * ext4_map_blocks()
+		 * NOTE: We can handle this as an error with EAGAIN in future.
+		 */
+		ext4_lblk_t newex_lblk = le32_to_cpu(newex.ee_block);
+		loff_t newex_len = ext4_ext_get_actual_len(&newex);
+
+		if (in_range(orig_map->m_lblk, newex_lblk, newex_len)) {
+			/* S1 */
+			loff_t split_len = 0;
+
+			BUG_ON(!ext4_ext_is_unwritten(&newex));
+
+			if (newex_lblk + newex_len >=
+			    orig_map->m_lblk + (loff_t)orig_map->m_len)
+				split_len = orig_map->m_len;
+			else
+				split_len = newex_len -
+					    (orig_map->m_lblk - newex_lblk);
+
+			path = ext4_ext_insert_extent(
+				handle, inode, path, &newex,
+				(flags & ~EXT4_GET_BLOCKS_PRE_IO));
+			if (IS_ERR(path)) {
+				err = PTR_ERR(path);
+				goto insert_error;
+			}
+
+			/*
+			 * Update path before split
+			 * NOTE: This might no longer be needed with recent
+			 * changes in ext4_ext_insert_extent()
+			 */
+			path = ext4_find_extent(inode, orig_map->m_lblk, path, 0);
+			if (IS_ERR(path)) {
+				err = PTR_ERR(path);
+				goto insert_error;
+			}
+
+			/*
+			 * GET_BLOCKS_CONVERT is needed to make sure split
+			 * extent is marked unwritten although the flags itself
+			 * means that the extent should be converted to written.
+			 *
+			 * TODO: This is because ext4_split_convert_extents()
+			 * doesn't respect the flags at all but fixing this
+			 * needs more involved design changes.
+			 */
+			path = ext4_split_convert_extents(
+				handle, inode, orig_map->m_lblk, split_len,
+				path, flags | EXT4_GET_BLOCKS_CONVERT, NULL);
+			if (IS_ERR(path)) {
+				err = PTR_ERR(path);
+				goto insert_error;
+			}
+
+#ifdef CONFIG_EXT4_DEBUG
+			test_path = ext4_find_extent(inode, orig_map->m_lblk,
+						     NULL, 0);
+			if (!IS_ERR(test_path)) {
+				/* Confirm we've correctly split and marked the extent unwritten */
+				struct ext4_extent *test_ex =
+					test_path[ext_depth(inode)].p_ext;
+				WARN_ON(!ext4_ext_is_unwritten(test_ex));
+				WARN_ON(test_ex->ee_block != orig_map->m_lblk);
+				WARN_ON(ext4_ext_get_actual_len(test_ex) !=
+					orig_map->m_len);
+				kfree(test_path);
+			}
+#endif
+		} else {
+			/* S2 */
+			BUG_ON(orig_map->m_lblk < newex_lblk + newex_len);
+
+			path = ext4_ext_insert_extent(
+				handle, inode, path, &newex,
+				(flags & ~EXT4_GET_BLOCKS_PRE_IO));
+			if (IS_ERR(path)) {
+				err = PTR_ERR(path);
+				goto insert_error;
+			}
+		}
+	} else {
+		path = ext4_ext_insert_extent(handle, inode, path, &newex,
+					      flags);
+		if (IS_ERR(path)) {
+			err = PTR_ERR(path);
+			goto insert_error;
+		}
+	}
+
+insert_error:
+	if (err) {
 		if (allocated_clusters) {
 			int fb_flags = 0;
 
@@ -4672,7 +4812,7 @@ static long ext4_do_fallocate(struct file *file, loff_t offset,
 	loff_t end = offset + len;
 	loff_t new_size = 0;
 	ext4_lblk_t start_lblk, len_lblk;
-	int ret;
+	int ret, flags;
 
 	trace_ext4_fallocate_enter(inode, offset, len, mode);
 	WARN_ON_ONCE(!inode_is_locked(inode));
@@ -4694,8 +4834,12 @@ static long ext4_do_fallocate(struct file *file, loff_t offset,
 			goto out;
 	}
 
+	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
+	if (ext4_should_use_extsize(inode))
+		flags |= EXT4_GET_BLOCKS_EXTSIZE;
+
 	ret = ext4_alloc_file_blocks(file, start_lblk, len_lblk, new_size,
-				     EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT);
+				     flags);
 	if (ret)
 		goto out;
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 00d8e9065a02..53724b7cb9e0 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -435,7 +435,7 @@ static void ext4_map_blocks_es_recheck(handle_t *handle,
 	 */
 	down_read(&EXT4_I(inode)->i_data_sem);
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
-		retval = ext4_ext_map_blocks(handle, inode, map, 0);
+		retval = ext4_ext_map_blocks(handle, inode, map, NULL, 0);
 	} else {
 		retval = ext4_ind_map_blocks(handle, inode, map, 0);
 	}
@@ -460,15 +460,33 @@ static void ext4_map_blocks_es_recheck(handle_t *handle,
 #endif /* ES_AGGRESSIVE_TEST */
 
 static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
-				 struct ext4_map_blocks *map)
+				 struct ext4_map_blocks *orig_map,
+				 struct ext4_map_blocks *extsize_map,
+				 bool should_extsize)
 {
 	unsigned int status;
 	int retval;
+	struct ext4_map_blocks *map;
+
+	if (should_extsize) {
+		BUG_ON(extsize_map == NULL);
+		map = extsize_map;
+	} else
+		map = orig_map;
 
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
-		retval = ext4_ext_map_blocks(handle, inode, map, 0);
-	else
+		if (should_extsize) {
+			retval = ext4_ext_map_blocks(handle, inode, orig_map,
+						     map,
+						     EXT4_GET_BLOCKS_EXTSIZE);
+		} else {
+			retval = ext4_ext_map_blocks(handle, inode, map, NULL,
+						     0);
+		}
+	else {
+		BUG_ON(should_extsize);
 		retval = ext4_ind_map_blocks(handle, inode, map, 0);
+	}
 
 	if (retval <= 0)
 		return retval;
@@ -489,11 +507,20 @@ static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
 }
 
 static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
-				  struct ext4_map_blocks *map, int flags)
+				  struct ext4_map_blocks *orig_map,
+				  struct ext4_map_blocks *extsize_map, int flags,
+				  bool should_extsize)
 {
 	struct extent_status es;
 	unsigned int status;
 	int err, retval = 0;
+	struct ext4_map_blocks *map;
+
+	if (should_extsize) {
+		BUG_ON(extsize_map == NULL);
+		map = extsize_map;
+	} else
+		map = orig_map;
 
 	/*
 	 * We pass in the magic EXT4_GET_BLOCKS_DELALLOC_RESERVE
@@ -514,8 +541,15 @@ static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
 	 * changed the inode type in between.
 	 */
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
-		retval = ext4_ext_map_blocks(handle, inode, map, flags);
+		if (should_extsize) {
+			retval = ext4_ext_map_blocks(handle, inode, orig_map,
+						     map, flags);
+		} else {
+			retval = ext4_ext_map_blocks(handle, inode, map, NULL,
+						     flags);
+		}
 	} else {
+		BUG_ON(should_extsize);
 		retval = ext4_ind_map_blocks(handle, inode, map, flags);
 
 		/*
@@ -570,6 +604,80 @@ static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
 	return retval;
 }
 
+/**
+ * Extsize hint will change the mapped range and hence we'll end up mapping more.
+ * To not confuse the caller, adjust the struct ext4_map_blocks to reflect the
+ * original mapping requested by them.
+ *
+ * @cur_map:		The block mapping we are working with (for sanity check)
+ * @orig_map:		The originally requested mapping
+ * @extsize_map:	The mapping after adjusting for extsize hint
+ * @flags		Get block flags (for sanity check)
+ *
+ * This function assumes that the orig_mlblk is contained within the mapping
+ * held in extsize_map. Caller must make sure this is true.
+ */
+static inline unsigned int ext4_extsize_adjust_map(struct ext4_map_blocks *cur_map,
+					   struct ext4_map_blocks *orig_map,
+					   struct ext4_map_blocks *extsize_map,
+					   int flags)
+{
+	__u64 map_end = (__u64)extsize_map->m_lblk + extsize_map->m_len;
+
+	BUG_ON(cur_map != extsize_map || !(flags & EXT4_GET_BLOCKS_EXTSIZE));
+
+	orig_map->m_len = min(orig_map->m_len, map_end - orig_map->m_lblk);
+	orig_map->m_pblk =
+		extsize_map->m_pblk + (orig_map->m_lblk - extsize_map->m_lblk);
+	orig_map->m_flags = extsize_map->m_flags;
+
+	return orig_map->m_len;
+}
+
+/**
+ * ext4_error_adjust_map - Adjust map returned upon error in ext4_map_blocks()
+ *
+ * @cur_map: current map we are working with
+ * @orig_map: original map that would be returned to the user.
+ *
+ * Most of the callers of ext4_map_blocks() ignore the map on error, however
+ * some use it for debug logging. In this case, they log state of the map just
+ * before the error, hence this function ensures that map returned to caller is
+ * the one we were working with when error happened. Mostly useful when extsize
+ * hints are enabled.
+ */
+static inline void ext4_error_adjust_map(struct ext4_map_blocks *cur_map,
+					 struct ext4_map_blocks *orig_map)
+{
+	if (cur_map != orig_map)
+		memcpy(orig_map, cur_map, sizeof(*cur_map));
+}
+
+/*
+ * This functions resets the mapping to it's original state after it has been
+ * modified due to extent size hint and drops the extsize hint. To be used
+ * incase we want to fallback from extsize based aligned allocation to normal
+ * allocation
+ *
+ * @map:		The block mapping where lblk and len have been modified
+ *			because	of extsize hint
+ * @flags:		The get_block flags
+ * @orig_mlblk:		The originally requested logical block to map
+ * @orig_mlen:		The originally requested len to map
+ * @orig_flags:		The originally requested get_block flags
+ */
+static inline void ext4_extsize_reset_map(struct ext4_map_blocks *map,
+					  int *flags, ext4_lblk_t orig_mlblk,
+					  unsigned int orig_mlen,
+					  int orig_flags)
+{
+	/* Drop the extsize hint from original flags */
+	*flags = orig_flags & ~EXT4_GET_BLOCKS_EXTSIZE;
+	map->m_lblk = orig_mlblk;
+	map->m_len = orig_mlen;
+	map->m_flags = 0;
+}
+
 /*
  * The ext4_map_blocks() function tries to look up the requested blocks,
  * and returns if the blocks are already mapped.
@@ -594,31 +702,111 @@ static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
  * It returns the error in case of allocation failure.
  */
 int ext4_map_blocks(handle_t *handle, struct inode *inode,
-		    struct ext4_map_blocks *map, int flags)
+		    struct ext4_map_blocks *orig_map, int flags)
 {
 	struct extent_status es;
 	int retval;
 	int ret = 0;
+
+	ext4_lblk_t orig_mlblk, extsize_mlblk;
+	unsigned int orig_mlen, extsize_mlen;
+	int orig_flags;
+
+	struct ext4_map_blocks *map = NULL;
+	struct ext4_map_blocks extsize_map = {0};
+
+	__u32 extsize = ext4_inode_get_extsize(EXT4_I(inode));
+	bool should_extsize = false;
+
 #ifdef ES_AGGRESSIVE_TEST
-	struct ext4_map_blocks orig_map;
+	struct ext4_map_blocks test_map;
 
-	memcpy(&orig_map, map, sizeof(*map));
+	memcpy(&test_map, map, sizeof(*map));
 #endif
 
-	map->m_flags = 0;
-	ext_debug(inode, "flag 0x%x, max_blocks %u, logical block %lu\n",
-		  flags, map->m_len, (unsigned long) map->m_lblk);
+	orig_map->m_flags = 0;
+	ext_debug(inode, "flag 0x%x, max_blocks %u, logical block %lu\n", flags,
+		  orig_map->m_len, (unsigned long)orig_map->m_lblk);
 
 	/*
 	 * ext4_map_blocks returns an int, and m_len is an unsigned int
 	 */
-	if (unlikely(map->m_len > INT_MAX))
-		map->m_len = INT_MAX;
+	if (unlikely(orig_map->m_len > INT_MAX))
+		orig_map->m_len = INT_MAX;
 
 	/* We can handle the block number less than EXT_MAX_BLOCKS */
-	if (unlikely(map->m_lblk >= EXT_MAX_BLOCKS))
+	if (unlikely(orig_map->m_lblk >= EXT_MAX_BLOCKS))
 		return -EFSCORRUPTED;
 
+	orig_mlblk = orig_map->m_lblk;
+	orig_mlen = orig_map->m_len;
+	orig_flags = flags;
+
+set_map:
+	should_extsize = (extsize && (flags & EXT4_GET_BLOCKS_CREATE) &&
+			       (flags & EXT4_GET_BLOCKS_EXTSIZE));
+	if (should_extsize) {
+		/*
+		 * We adjust the extent size here but we still return the
+		 * original lblk and len while returning to keep the behavior
+		 * compatible.
+		 */
+		int len, align;
+		/*
+		 * NOTE: Should we import EXT_UNWRITTEN_MAX_LEN from
+		 * ext4_extents.h here?
+		 */
+		int max_unwrit_len = ((1UL << 15) - 1);
+		loff_t end;
+
+		align = orig_map->m_lblk % extsize;
+		len = orig_map->m_len + align;
+
+		extsize_map.m_lblk = orig_map->m_lblk - align;
+		extsize_map.m_len =
+			max_t(unsigned int, roundup_pow_of_two(len), extsize);
+
+		/*
+		 * For now allocations beyond EOF don't use extsize hints so
+		 * that we can avoid dealing with extra blocks allocated past
+		 * EOF. We have inode lock since extsize allocations are
+		 * non-delalloc so i_size can be accessed safely
+		 */
+		end = (extsize_map.m_lblk + (loff_t)extsize_map.m_len) << inode->i_blkbits;
+		if (end > inode->i_size) {
+			flags = orig_flags & ~EXT4_GET_BLOCKS_EXTSIZE;
+			goto set_map;
+		}
+
+		/* Fallback to normal allocation if we go beyond max len */
+		if (extsize_map.m_len >= max_unwrit_len) {
+			flags = orig_flags & ~EXT4_GET_BLOCKS_EXTSIZE;
+			goto set_map;
+		}
+
+		/*
+		 * We are allocating more than requested. We'll have to convert
+		 * the extent to unwritten and then convert only the part
+		 * requested to written. For now we are using the same flow as
+		 * dioread nolock to achieve this. Hence the caller has to pass
+		 * CREATE_UNWRIT with EXTSIZE
+		 */
+		if (!(flags | EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT)) {
+			WARN_ON(true);
+
+			/* Fallback to non extsize allocation */
+			flags = orig_flags & ~EXT4_GET_BLOCKS_EXTSIZE;
+			goto set_map;
+		}
+
+		extsize_mlblk = extsize_map.m_lblk;
+		extsize_mlen = extsize_map.m_len;
+
+		extsize_map.m_flags = orig_map->m_flags;
+		map = &extsize_map;
+	} else
+		map = orig_map;
+
 	/* Lookup extent status tree firstly */
 	if (!(EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY) &&
 	    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
@@ -648,7 +836,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 			return retval;
 #ifdef ES_AGGRESSIVE_TEST
 		ext4_map_blocks_es_recheck(handle, inode, map,
-					   &orig_map, flags);
+					   &test_map, flags);
 #endif
 		goto found;
 	}
@@ -664,19 +852,60 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 	 * file system block.
 	 */
 	down_read(&EXT4_I(inode)->i_data_sem);
-	retval = ext4_map_query_blocks(handle, inode, map);
+	if (should_extsize) {
+		BUG_ON(map != &extsize_map);
+		retval = ext4_map_query_blocks(handle, inode, orig_map, map,
+					       should_extsize);
+	} else {
+		BUG_ON(map != orig_map);
+		retval = ext4_map_query_blocks(handle, inode, map, NULL,
+					       should_extsize);
+	}
 	up_read((&EXT4_I(inode)->i_data_sem));
 
 found:
 	if (retval > 0 && map->m_flags & EXT4_MAP_MAPPED) {
 		ret = check_block_validity(inode, map);
-		if (ret != 0)
+		if (ret != 0) {
+			ext4_error_adjust_map(map, orig_map);
 			return ret;
+		}
 	}
 
 	/* If it is only a block(s) look up */
-	if ((flags & EXT4_GET_BLOCKS_CREATE) == 0)
+	if ((flags & EXT4_GET_BLOCKS_CREATE) == 0) {
+		BUG_ON(flags & EXT4_GET_BLOCKS_EXTSIZE);
 		return retval;
+	}
+
+	/* Handle some special cases when extsize based allocation is needed */
+	if (retval >= 0 && flags & EXT4_GET_BLOCKS_EXTSIZE) {
+		bool orig_in_range =
+			in_range(orig_mlblk, (__u64)map->m_lblk, map->m_len);
+		/*
+		 * Special case: if the extsize range is mapped already and
+		 * covers the original start, we return it.
+		 */
+		if (map->m_flags & EXT4_MAP_MAPPED && orig_in_range) {
+			/*
+			 * We don't use EXTSIZE with CONVERT_UNWRITTEN so
+			 * we can directly return the written extent
+			 */
+			return ext4_extsize_adjust_map(map, orig_map, &extsize_map, flags);
+		}
+
+		/*
+		 * Fallback case: if the found mapping (or hole) doesn't cover
+		 * the extsize required, then just fall back to normal
+		 * allocation to keep things simple.
+		 */
+
+		if (map->m_lblk != extsize_mlblk ||
+		    map->m_len != extsize_mlen) {
+			flags = orig_flags & ~EXT4_GET_BLOCKS_EXTSIZE;
+			goto set_map;
+		}
+	}
 
 	/*
 	 * Returns if the blocks have already allocated
@@ -700,12 +929,22 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 	 * with create == 1 flag.
 	 */
 	down_write(&EXT4_I(inode)->i_data_sem);
-	retval = ext4_map_create_blocks(handle, inode, map, flags);
+	if (should_extsize) {
+		BUG_ON(map != &extsize_map);
+		retval = ext4_map_create_blocks(handle, inode, orig_map, map, flags,
+						should_extsize);
+	} else {
+		BUG_ON(map != orig_map);
+		retval = ext4_map_create_blocks(handle, inode, map, NULL, flags,
+					       should_extsize);
+	}
 	up_write((&EXT4_I(inode)->i_data_sem));
 	if (retval > 0 && map->m_flags & EXT4_MAP_MAPPED) {
 		ret = check_block_validity(inode, map);
-		if (ret != 0)
+		if (ret != 0) {
+			ext4_error_adjust_map(map, orig_map);
 			return ret;
+		}
 
 		/*
 		 * Inodes with freshly allocated blocks where contents will be
@@ -727,16 +966,38 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 			else
 				ret = ext4_jbd2_inode_add_write(handle, inode,
 						start_byte, length);
-			if (ret)
+			if (ret) {
+				ext4_error_adjust_map(map, orig_map);
 				return ret;
+			}
 		}
 	}
 	if (retval > 0 && (map->m_flags & EXT4_MAP_UNWRITTEN ||
 				map->m_flags & EXT4_MAP_MAPPED))
 		ext4_fc_track_range(handle, inode, map->m_lblk,
 					map->m_lblk + map->m_len - 1);
-	if (retval < 0)
+
+	if (retval > 0 && flags & EXT4_GET_BLOCKS_EXTSIZE) {
+		/*
+		 * In the rare case that we have a short allocation and orig
+		 * lblk doesn't lie in mapped range just try to retry with
+		 * actual allocation. This is not ideal but this should be an
+		 * edge case near ENOSPC.
+		 *
+		 * NOTE: This has a side effect that blocks are allocated but
+		 * not used. Can we avoid that?
+		 */
+		if (!in_range(orig_mlblk, (__u64)map->m_lblk, map->m_len)) {
+			flags = orig_flags & ~EXT4_GET_BLOCKS_EXTSIZE;
+			goto set_map;
+		}
+		return ext4_extsize_adjust_map(map, orig_map, &extsize_map, flags);
+	}
+
+	if (retval < 0) {
+		ext4_error_adjust_map(map, orig_map);
 		ext_debug(inode, "failed with err %d\n", retval);
+	}
 	return retval;
 }
 
@@ -772,18 +1033,20 @@ static int _ext4_get_block(struct inode *inode, sector_t iblock,
 {
 	struct ext4_map_blocks map;
 	int ret = 0;
+	unsigned int orig_mlen = bh->b_size >> inode->i_blkbits;
 
 	if (ext4_has_inline_data(inode))
 		return -ERANGE;
 
 	map.m_lblk = iblock;
-	map.m_len = bh->b_size >> inode->i_blkbits;
+	map.m_len = orig_mlen;
 
 	ret = ext4_map_blocks(ext4_journal_current_handle(), inode, &map,
 			      flags);
 	if (ret > 0) {
 		map_bh(bh, inode->i_sb, map.m_pblk);
 		ext4_update_bh_state(bh, map.m_flags);
+		WARN_ON(map.m_len != orig_mlen);
 		bh->b_size = inode->i_sb->s_blocksize * map.m_len;
 		ret = 0;
 	} else if (ret == 0) {
@@ -809,11 +1072,14 @@ int ext4_get_block_unwritten(struct inode *inode, sector_t iblock,
 			     struct buffer_head *bh_result, int create)
 {
 	int ret = 0;
+	int flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
+
+	if (ext4_should_use_extsize(inode))
+		flags |= EXT4_GET_BLOCKS_EXTSIZE;
 
 	ext4_debug("ext4_get_block_unwritten: inode %lu, create flag %d\n",
 		   inode->i_ino, create);
-	ret = _ext4_get_block(inode, iblock, bh_result,
-			       EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT);
+	ret = _ext4_get_block(inode, iblock, bh_result, flags);
 
 	/*
 	 * If the buffer is marked unwritten, mark it as new to make sure it is
@@ -1164,7 +1430,8 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	from = pos & (PAGE_SIZE - 1);
 	to = from + len;
 
-	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)) {
+	if (!ext4_should_use_extsize(inode) &&
+	    ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)) {
 		ret = ext4_try_to_write_inline_data(mapping, inode, pos, len,
 						    foliop);
 		if (ret < 0)
@@ -1212,7 +1479,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	/* In case writeback began while the folio was unlocked */
 	folio_wait_stable(folio);
 
-	if (ext4_should_dioread_nolock(inode))
+	if (ext4_should_use_unwrit_extents(inode))
 		ret = ext4_block_write_begin(handle, folio, pos, len,
 					     ext4_get_block_unwritten);
 	else
@@ -1802,7 +2069,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map)
 	if (ext4_has_inline_data(inode))
 		retval = 0;
 	else
-		retval = ext4_map_query_blocks(NULL, inode, map);
+		retval = ext4_map_query_blocks(NULL, inode, map, NULL, false);
 	up_read(&EXT4_I(inode)->i_data_sem);
 	if (retval)
 		return retval < 0 ? retval : 0;
@@ -1825,7 +2092,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map)
 			goto found;
 		}
 	} else if (!ext4_has_inline_data(inode)) {
-		retval = ext4_map_query_blocks(NULL, inode, map);
+		retval = ext4_map_query_blocks(NULL, inode, map, NULL, false);
 		if (retval) {
 			up_write(&EXT4_I(inode)->i_data_sem);
 			return retval < 0 ? retval : 0;
@@ -2199,6 +2466,7 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
 	struct ext4_map_blocks *map = &mpd->map;
 	int get_blocks_flags;
 	int err, dioread_nolock;
+	int extsize = ext4_should_use_extsize(inode);
 
 	trace_ext4_da_write_pages_extent(inode, map);
 	/*
@@ -2217,11 +2485,14 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
 	dioread_nolock = ext4_should_dioread_nolock(inode);
 	if (dioread_nolock)
 		get_blocks_flags |= EXT4_GET_BLOCKS_IO_CREATE_EXT;
+	if (extsize)
+		get_blocks_flags |= EXT4_GET_BLOCKS_PRE_IO;
 
 	err = ext4_map_blocks(handle, inode, map, get_blocks_flags);
 	if (err < 0)
 		return err;
-	if (dioread_nolock && (map->m_flags & EXT4_MAP_UNWRITTEN)) {
+	if ((extsize || dioread_nolock) &&
+	    (map->m_flags & EXT4_MAP_UNWRITTEN)) {
 		if (!mpd->io_submit.io_end->handle &&
 		    ext4_handle_valid(handle)) {
 			mpd->io_submit.io_end->handle = handle->h_rsv_handle;
@@ -2643,10 +2914,11 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 	}
 	mpd->journalled_more_data = 0;
 
-	if (ext4_should_dioread_nolock(inode)) {
+	if (ext4_should_use_unwrit_extents(inode)) {
 		/*
-		 * We may need to convert up to one extent per block in
-		 * the page and we may dirty the inode.
+		 * For extsize allocation or dioread_nolock, we may need to
+		 * convert up to one extent per block in the page and we may
+		 * dirty the inode.
 		 */
 		rsv_blocks = 1 + ext4_chunk_trans_blocks(inode,
 						PAGE_SIZE >> inode->i_blkbits);
@@ -2924,7 +3196,8 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 
 	index = pos >> PAGE_SHIFT;
 
-	if (ext4_nonda_switch(inode->i_sb) || ext4_verity_in_progress(inode)) {
+	if (ext4_nonda_switch(inode->i_sb) || ext4_verity_in_progress(inode) ||
+	    ext4_should_use_extsize(inode)) {
 		*fsdata = (void *)FALL_BACK_TO_NONDELALLOC;
 		return ext4_write_begin(file, mapping, pos,
 					len, foliop, fsdata);
@@ -3371,12 +3644,19 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
 	 * can complete at any point during the I/O and subsequently push the
 	 * i_disksize out to i_size. This could be beyond where direct I/O is
 	 * happening and thus expose allocated blocks to direct I/O reads.
+	 *
+	 * NOTE for extsize hints: We only support it for writes inside
+	 * EOF (for now) to not have to deal with blocks past EOF
 	 */
 	else if (((loff_t)map->m_lblk << blkbits) >= i_size_read(inode))
 		m_flags = EXT4_GET_BLOCKS_CREATE;
-	else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
+	else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
 		m_flags = EXT4_GET_BLOCKS_IO_CREATE_EXT;
 
+		if (ext4_should_use_extsize(inode))
+			m_flags |= EXT4_GET_BLOCKS_EXTSIZE;
+	}
+
 	ret = ext4_map_blocks(handle, inode, map, m_flags);
 
 	/*
@@ -6270,7 +6550,7 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	}
 	folio_unlock(folio);
 	/* OK, we need to fill the hole... */
-	if (ext4_should_dioread_nolock(inode))
+	if (ext4_should_use_unwrit_extents(inode))
 		get_block = ext4_get_block_unwritten;
 	else
 		get_block = ext4_get_block;
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 79cc4224fbbd..d9464ee764af 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -50,6 +50,7 @@ struct partial_cluster;
 	{ EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,	"CONVERT_UNWRITTEN" },  \
 	{ EXT4_GET_BLOCKS_ZERO,			"ZERO" },		\
 	{ EXT4_GET_BLOCKS_IO_SUBMIT,		"IO_SUBMIT" },		\
+	{ EXT4_GET_BLOCKS_EXTSIZE,		"EXTSIZE" },		\
 	{ EXT4_EX_NOCACHE,			"EX_NOCACHE" })
 
 /*
-- 
2.48.1


