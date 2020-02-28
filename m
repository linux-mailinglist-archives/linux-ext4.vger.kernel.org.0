Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E95D61733C5
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Feb 2020 10:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgB1JXW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Feb 2020 04:23:22 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57354 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgB1JXW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Feb 2020 04:23:22 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01S9HnBx025435;
        Fri, 28 Feb 2020 09:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=2XF6ZOBCoWnr8ATklP4n3sz4SiQ/HWm0Y2hJayMjaao=;
 b=iCESF+ynmVsjWkTtzkJNcmdSeulR9nJ8jo4n76/Nrub8VCGjTktukZ5zWemJ0/wpfaH2
 fET1twL3Xssx04T38C1rOxdfgzcEHoYLUD6OMrsh8DgWs1fXFDf5+aogGWa8md7Qr6uE
 5FB2AAZzCKh+LMam4uI9cz7tsqEbvAm5MF/smrerH/SQMXlaO5waoqtuX2IWxfNOiHmJ
 AWEUIFnKF7GByFnUbO/0qsyUA4QUAyl2U6/PhvgNeMBdfyskq5OWweoRZU9uYBa/zgot
 RqhgjKEzmGIBlaS7ZGfSmMSvlpP5HMgJ+D3MFJx9u5VLpDsRcr0Q+rZjJY8Yfca95vR1 Vg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2yehxrw3rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 09:23:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01S9MKPX161034;
        Fri, 28 Feb 2020 09:23:11 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2ydcs803qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 09:23:11 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01S9N3Nk012879;
        Fri, 28 Feb 2020 09:23:03 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Feb 2020 01:23:03 -0800
Date:   Fri, 28 Feb 2020 12:22:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Suraj Jitindar Singh <surajjs@amazon.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Walter Harms <wharms@bfs.de>
Subject: [PATCH] ext4: potential crash on allocation error in
 ext4_alloc_flex_bg_array()
Message-ID: <20200228092142.7irbc44yaz3by7nb@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1011 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280077
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If sbi->s_flex_groups_allocated is zero and the first allocation fails
then this code will crash.  The problem is that "i--" will set "i" to
-1 but when we compare "i >= sbi->s_flex_groups_allocated" then the -1
is type promoted to unsigned and becomes UINT_MAX.  Since UINT_MAX
is more than zero, the condition is true so we call kvfree(new_groups[-1]).
The loop will carry on freeing invalid memory until it crashes.

Fixes: 7c990728b99e ("ext4: fix potential race between s_flex_groups online resizing and access")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I changed this from a -- loop to a ++ loop because I knew it would make
Walter Harms happy.  He hates -- loops and I don't when his birthday so
I'm celebrating it today.  :)

 fs/ext4/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ff1b764b0c0e..0c7c4adb664e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2391,7 +2391,7 @@ int ext4_alloc_flex_bg_array(struct super_block *sb, ext4_group_t ngroup)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct flex_groups **old_groups, **new_groups;
-	int size, i;
+	int size, i, j;
 
 	if (!sbi->s_log_groups_per_flex)
 		return 0;
@@ -2412,8 +2412,8 @@ int ext4_alloc_flex_bg_array(struct super_block *sb, ext4_group_t ngroup)
 					 sizeof(struct flex_groups)),
 					 GFP_KERNEL);
 		if (!new_groups[i]) {
-			for (i--; i >= sbi->s_flex_groups_allocated; i--)
-				kvfree(new_groups[i]);
+			for (j = sbi->s_flex_groups_allocated; j < i; j++)
+				kvfree(new_groups[j]);
 			kvfree(new_groups);
 			ext4_msg(sb, KERN_ERR,
 				 "not enough memory for %d flex groups", size);
-- 
2.11.0

