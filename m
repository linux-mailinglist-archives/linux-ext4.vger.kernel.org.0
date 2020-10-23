Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6AE296D88
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Oct 2020 13:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462897AbgJWLWr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Oct 2020 07:22:47 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34102 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462867AbgJWLWq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Oct 2020 07:22:46 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09NBIx4p008635;
        Fri, 23 Oct 2020 11:22:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=+sblqvGd80WfgejjfdQ8nRmFdnwwzyKpFdZ6XX17bls=;
 b=of21bWOg4thSPkzXrWViq3pBU2ygFKB4kOYgA9/lAQ/p/W8VJd7OCCDpBxTZ4tnQj8UA
 LZ19M3LaZosk8mxZt0itZ7C81lbLmMM8/zQ/nL8kWwZHOURP9PYgeKUbAp4MMJiaUdVc
 d+tb1ROAPLrPPoKwMVvlViceZjtXvzz9yy3OKxHO0vy3pCoD/WzYPI5KgSyTu+WEEgMh
 7ztX1m+QGsIcT1uuMhFyJ1499eFBtks1u4KOSSStpW2xz6oBSuCG1s9UHjpxUkLG40L/
 P93lhb+3ocrR9ywy1xPpJ9iNKAn1hwV5gLZ2FlfRIXvAvnKQtCLdcM5EjwQfjsYbzdVd tg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 347p4baqs7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Oct 2020 11:22:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09NBKC3E099035;
        Fri, 23 Oct 2020 11:22:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 348a6rne6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Oct 2020 11:22:40 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09NBMcBe006059;
        Fri, 23 Oct 2020 11:22:38 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 23 Oct 2020 04:22:38 -0700
Date:   Fri, 23 Oct 2020 14:22:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ext4: Fix an IS_ERR() vs NULL check
Message-ID: <20201023112232.GB282278@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9782 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010230080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9782 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 priorityscore=1501
 clxscore=1011 malwarescore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010230080
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The ext4_find_extent() function never returns NULL, it returns error
pointers.

Fixes: 44059e503b03 ("ext4: fast commit recovery path")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/ext4/extents.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 6b33b9c86b00..a19d0e3a4126 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5820,8 +5820,8 @@ int ext4_ext_replay_update_ex(struct inode *inode, ext4_lblk_t start,
 	int ret;
 
 	path = ext4_find_extent(inode, start, NULL, 0);
-	if (!path)
-		return -EINVAL;
+	if (IS_ERR(path))
+		return PTR_ERR(path);
 	ex = path[path->p_depth].p_ext;
 	if (!ex) {
 		ret = -EFSCORRUPTED;
-- 
2.28.0

