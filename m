Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710AC49086D
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Jan 2022 13:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239736AbiAQMMZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 17 Jan 2022 07:12:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2720 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239675AbiAQMMT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 17 Jan 2022 07:12:19 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20HBRa2H007005;
        Mon, 17 Jan 2022 12:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=HsE4aLSVM6oYTBPiNsSr7HXhxm/uWaDlAdWNIyUTwB8=;
 b=UDddKH8N49LpWakG65CkLy2gZ682cfhH09L/28c9rzZdYmP9TYWPlSK/UQLutNLiPcfh
 RApuGFXHqJhxec2wR9nbfkG+ZbV6mV6Aj4XVs4wYL1ovo1kZXnXnRwb86xIWQG2LbuJ2
 5bLXQIz4A/2b7BcNpn3sqR5diuroTjSjV3rVH4c2x8mia3i4qlaXVR1rz6fanOIlTF4c
 7BgTo1r2dmeKjmS403RIRMYeiLg4c38EmQl6JaDXfdXc8dS5UMrdFOxrXyH4NCi1Wldd
 h0/LKe2Ju4ro8UiiXKRyccXIzkC+IVcdKcjFOxES5uVT0QE0PNL1o3NEgvx+vNM1W17o IQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dn7krrwv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jan 2022 12:12:09 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20HBhUSF032119;
        Mon, 17 Jan 2022 12:12:09 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dn7krrwub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jan 2022 12:12:08 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20HC75kl000391;
        Mon, 17 Jan 2022 12:12:06 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3dknhj3skr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jan 2022 12:12:06 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20HCC4fG43188728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jan 2022 12:12:04 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2274BA4040;
        Mon, 17 Jan 2022 12:12:04 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF68BA405B;
        Mon, 17 Jan 2022 12:12:03 +0000 (GMT)
Received: from localhost (unknown [9.43.45.117])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Jan 2022 12:12:03 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, tytso@mit.edu,
        Eric Whitney <enwlinux@gmail.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        luo penghao <luo.penghao@zte.com.cn>,
        Lukas Czerner <lczerner@redhat.com>, Jan Kara <jack@suse.cz>
Subject: [PATCHv2 3/5] ext4: Fix error handling in ext4_fc_record_modified_inode()
Date:   Mon, 17 Jan 2022 17:41:49 +0530
Message-Id: <62e8b6a1cce9359682051deb736a3c0953c9d1e9.1642416995.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642416995.git.riteshh@linux.ibm.com>
References: <cover.1642416995.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TyFVMtcTfbQ0ZSkfRzTn7Ru8DR9yvrce
X-Proofpoint-GUID: Q1-Gj92BCqluQ8Lpgp-ri9zi_ctk2N2M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-17_05,2022-01-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 mlxlogscore=884
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201170077
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Current code does not fully takes care of krealloc() error case,
which could lead to silent memory corruption or a kernel bug.
This patch fixes that.

Also it cleans up some duplicated error handling logic from various functions
in fast_commit.c file.

Reported-by: luo penghao <luo.penghao@zte.com.cn>
Suggested-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/fast_commit.c | 64 ++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 35 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 5ae8026a0c56..4541c8468c01 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1392,14 +1392,15 @@ static int ext4_fc_record_modified_inode(struct super_block *sb, int ino)
 		if (state->fc_modified_inodes[i] == ino)
 			return 0;
 	if (state->fc_modified_inodes_used == state->fc_modified_inodes_size) {
-		state->fc_modified_inodes_size +=
-			EXT4_FC_REPLAY_REALLOC_INCREMENT;
 		state->fc_modified_inodes = krealloc(
-					state->fc_modified_inodes, sizeof(int) *
-					state->fc_modified_inodes_size,
-					GFP_KERNEL);
+				state->fc_modified_inodes,
+				sizeof(int) * (state->fc_modified_inodes_size +
+				EXT4_FC_REPLAY_REALLOC_INCREMENT),
+				GFP_KERNEL);
 		if (!state->fc_modified_inodes)
 			return -ENOMEM;
+		state->fc_modified_inodes_size +=
+			EXT4_FC_REPLAY_REALLOC_INCREMENT;
 	}
 	state->fc_modified_inodes[state->fc_modified_inodes_used++] = ino;
 	return 0;
@@ -1431,7 +1432,9 @@ static int ext4_fc_replay_inode(struct super_block *sb, struct ext4_fc_tl *tl,
 	}
 	inode = NULL;
 
-	ext4_fc_record_modified_inode(sb, ino);
+	ret = ext4_fc_record_modified_inode(sb, ino);
+	if (ret)
+		goto out;
 
 	raw_fc_inode = (struct ext4_inode *)
 		(val + offsetof(struct ext4_fc_inode, fc_raw_inode));
@@ -1621,6 +1624,8 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 	}
 
 	ret = ext4_fc_record_modified_inode(sb, inode->i_ino);
+	if (ret)
+		goto out;
 
 	start = le32_to_cpu(ex->ee_block);
 	start_pblk = ext4_ext_pblock(ex);
@@ -1638,18 +1643,14 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 		map.m_pblk = 0;
 		ret = ext4_map_blocks(NULL, inode, &map, 0);
 
-		if (ret < 0) {
-			iput(inode);
-			return 0;
-		}
+		if (ret < 0)
+			goto out;
 
 		if (ret == 0) {
 			/* Range is not mapped */
 			path = ext4_find_extent(inode, cur, NULL, 0);
-			if (IS_ERR(path)) {
-				iput(inode);
-				return 0;
-			}
+			if (IS_ERR(path))
+				goto out;
 			memset(&newex, 0, sizeof(newex));
 			newex.ee_block = cpu_to_le32(cur);
 			ext4_ext_store_pblock(
@@ -1663,10 +1664,8 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 			up_write((&EXT4_I(inode)->i_data_sem));
 			ext4_ext_drop_refs(path);
 			kfree(path);
-			if (ret) {
-				iput(inode);
-				return 0;
-			}
+			if (ret)
+				goto out;
 			goto next;
 		}
 
@@ -1679,10 +1678,8 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 			ret = ext4_ext_replay_update_ex(inode, cur, map.m_len,
 					ext4_ext_is_unwritten(ex),
 					start_pblk + cur - start);
-			if (ret) {
-				iput(inode);
-				return 0;
-			}
+			if (ret)
+				goto out;
 			/*
 			 * Mark the old blocks as free since they aren't used
 			 * anymore. We maintain an array of all the modified
@@ -1702,10 +1699,8 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 			ext4_ext_is_unwritten(ex), map.m_pblk);
 		ret = ext4_ext_replay_update_ex(inode, cur, map.m_len,
 					ext4_ext_is_unwritten(ex), map.m_pblk);
-		if (ret) {
-			iput(inode);
-			return 0;
-		}
+		if (ret)
+			goto out;
 		/*
 		 * We may have split the extent tree while toggling the state.
 		 * Try to shrink the extent tree now.
@@ -1717,6 +1712,7 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 	}
 	ext4_ext_replay_shrink_inode(inode, i_size_read(inode) >>
 					sb->s_blocksize_bits);
+out:
 	iput(inode);
 	return 0;
 }
@@ -1746,6 +1742,8 @@ ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl,
 	}
 
 	ret = ext4_fc_record_modified_inode(sb, inode->i_ino);
+	if (ret)
+		goto out;
 
 	jbd_debug(1, "DEL_RANGE, inode %ld, lblk %d, len %d\n",
 			inode->i_ino, le32_to_cpu(lrange.fc_lblk),
@@ -1755,10 +1753,8 @@ ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl,
 		map.m_len = remaining;
 
 		ret = ext4_map_blocks(NULL, inode, &map, 0);
-		if (ret < 0) {
-			iput(inode);
-			return 0;
-		}
+		if (ret < 0)
+			goto out;
 		if (ret > 0) {
 			remaining -= ret;
 			cur += ret;
@@ -1773,15 +1769,13 @@ ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl,
 	ret = ext4_ext_remove_space(inode, lrange.fc_lblk,
 				lrange.fc_lblk + lrange.fc_len - 1);
 	up_write(&EXT4_I(inode)->i_data_sem);
-	if (ret) {
-		iput(inode);
-		return 0;
-	}
+	if (ret)
+		goto out;
 	ext4_ext_replay_shrink_inode(inode,
 		i_size_read(inode) >> sb->s_blocksize_bits);
 	ext4_mark_inode_dirty(NULL, inode);
+out:
 	iput(inode);
-
 	return 0;
 }
 
-- 
2.31.1

