Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E95E3997D9
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Jun 2021 04:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhFCCFY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Jun 2021 22:05:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28440 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229541AbhFCCFY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Jun 2021 22:05:24 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1531nBjT150011;
        Wed, 2 Jun 2021 22:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=8z+3qpbB6INYKmlfsOTwCs0Dugxbcrv+ZOeXNWZYauQ=;
 b=kALmNRGKiCaTVHxkGklv82+2njh9zd6RJMkub7eqKcaZXsgocv4NnE05ex9UMO/h0v6j
 YV+2/QD/cn5MlSy3PWnxigHsgGNvFIv1ZVKss7Adp8fSksEv3sl2zFFcJCNeLDJwiyaK
 CbxQhob81HqPQ5D56dEi3bs4y+20/Iht9rV7fVQEurrndmgEhLnOYLR7V7ZZrVzq/2i9
 Na8u47eM9WT9fUeun56tNwU9frex0yn+fgNzGgW0gf2Z5WDX2L2IvWe5/iteM26vy5a3
 lJlVSP6TXUcqnLpLQ+gn41lkS17XVDeDAfW9j6m60u5nQQ1zjrj4wc1xpf8ZmAYIGZ3Y 4w== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38xnrk8a64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Jun 2021 22:03:38 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15322loX024252;
        Thu, 3 Jun 2021 02:03:36 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 38ucvh9fst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Jun 2021 02:03:36 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15323XMB8978818
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Jun 2021 02:03:33 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D72F04C062;
        Thu,  3 Jun 2021 02:03:32 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62F5D4C050;
        Thu,  3 Jun 2021 02:03:32 +0000 (GMT)
Received: from localhost (unknown [9.85.75.172])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Jun 2021 02:03:32 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH] ext4: Remove duplicate definition of ext4_xattr_ibody_inline_set()
Date:   Thu,  3 Jun 2021 07:33:02 +0530
Message-Id: <fd566b799bbbbe9b668eb5eecde5b5e319e3694f.1622685482.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rBE-wvZNpzHs9w0bYeMjVCt1htUG6TQj
X-Proofpoint-ORIG-GUID: rBE-wvZNpzHs9w0bYeMjVCt1htUG6TQj
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-02_11:2021-06-02,2021-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=898 malwarescore=0 suspectscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106030008
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4_xattr_ibody_inline_set() & ext4_xattr_ibody_set() have the exact
same definition. Hence remove ext4_xattr_ibody_set() and all it's call
references. Convert the callers of it to call ext4_xattr_ibody_inline_set()
instead.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/xattr.c | 32 ++++----------------------------
 1 file changed, 4 insertions(+), 28 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 10ba4b24a0aa..88bb5d0fb9fc 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2214,30 +2214,6 @@ int ext4_xattr_ibody_inline_set(handle_t *handle, struct inode *inode,
 	return 0;
 }

-static int ext4_xattr_ibody_set(handle_t *handle, struct inode *inode,
-				struct ext4_xattr_info *i,
-				struct ext4_xattr_ibody_find *is)
-{
-	struct ext4_xattr_ibody_header *header;
-	struct ext4_xattr_search *s = &is->s;
-	int error;
-
-	if (EXT4_I(inode)->i_extra_isize == 0)
-		return -ENOSPC;
-	error = ext4_xattr_set_entry(i, s, handle, inode, false /* is_block */);
-	if (error)
-		return error;
-	header = IHDR(inode, ext4_raw_inode(&is->iloc));
-	if (!IS_LAST_ENTRY(s->first)) {
-		header->h_magic = cpu_to_le32(EXT4_XATTR_MAGIC);
-		ext4_set_inode_state(inode, EXT4_STATE_XATTR);
-	} else {
-		header->h_magic = cpu_to_le32(0);
-		ext4_clear_inode_state(inode, EXT4_STATE_XATTR);
-	}
-	return 0;
-}
-
 static int ext4_xattr_value_same(struct ext4_xattr_search *s,
 				 struct ext4_xattr_info *i)
 {
@@ -2365,7 +2341,7 @@ ext4_xattr_set_handle(handle_t *handle, struct inode *inode, int name_index,

 	if (!value) {
 		if (!is.s.not_found)
-			error = ext4_xattr_ibody_set(handle, inode, &i, &is);
+			error = ext4_xattr_ibody_inline_set(handle, inode, &i, &is);
 		else if (!bs.s.not_found)
 			error = ext4_xattr_block_set(handle, inode, &i, &bs);
 	} else {
@@ -2381,7 +2357,7 @@ ext4_xattr_set_handle(handle_t *handle, struct inode *inode, int name_index,
 			EXT4_XATTR_MIN_LARGE_EA_SIZE(inode->i_sb->s_blocksize)))
 			i.in_inode = 1;
 retry_inode:
-		error = ext4_xattr_ibody_set(handle, inode, &i, &is);
+		error = ext4_xattr_ibody_inline_set(handle, inode, &i, &is);
 		if (!error && !bs.s.not_found) {
 			i.value = NULL;
 			error = ext4_xattr_block_set(handle, inode, &i, &bs);
@@ -2396,7 +2372,7 @@ ext4_xattr_set_handle(handle_t *handle, struct inode *inode, int name_index,
 			error = ext4_xattr_block_set(handle, inode, &i, &bs);
 			if (!error && !is.s.not_found) {
 				i.value = NULL;
-				error = ext4_xattr_ibody_set(handle, inode, &i,
+				error = ext4_xattr_ibody_inline_set(handle, inode, &i,
 							     &is);
 			} else if (error == -ENOSPC) {
 				/*
@@ -2591,7 +2567,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 		goto out;

 	/* Remove the chosen entry from the inode */
-	error = ext4_xattr_ibody_set(handle, inode, &i, is);
+	error = ext4_xattr_ibody_inline_set(handle, inode, &i, is);
 	if (error)
 		goto out;

--
2.31.1

