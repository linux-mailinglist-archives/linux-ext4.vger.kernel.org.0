Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05B8211EAB9
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2019 19:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfLMSuc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Dec 2019 13:50:32 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53844 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbfLMSub (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 13 Dec 2019 13:50:31 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDIiRWW187198;
        Fri, 13 Dec 2019 18:50:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2019-08-05; bh=Y1W2wi3uXxlBeN2Xb66vsyWVJ11ZNi5rfxBm2aRFNdI=;
 b=qH8GQaQ9A5ldy3f7YV+ZezQxhrS7cy54VmVQT4+2IK2go0JKck0rcJgkLWX7gOu7LsHa
 4s5f6uYn+2gIDd5lZsz37RtPUknmFiaEnJuBbguQ3VmRoqxxBliU0oQRonB7ZZe8ZRBE
 SJinH6NtlLTaI1XSaEiOOg58B6HmTUQHxIuwSp/WpMJaE5lDy0xZeZxSRv5QZNQoEfd5
 NYZHi+2QJd0kvPxESpPZtbDZijZ3sjP/KOawB3IJcrZRy/VAvs/CWwU8wJ+rEe0Ot1VN
 Ts9nGC3cabUgliNRmGs3MG8iYP7cPu3p+7wTSDdwqh99CC7Ex8na+JqR+71WGPFtlEnP cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2wr41qts3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 18:50:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDIlpXD185434;
        Fri, 13 Dec 2019 18:50:20 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2wvb99px40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 18:50:20 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBDIoIQ7023057;
        Fri, 13 Dec 2019 18:50:19 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Dec 2019 10:50:18 -0800
Date:   Fri, 13 Dec 2019 21:50:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Theodore Ts'o" <tytso@mit.edu>, Miao Xie <miaoxie@huawei.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ext4: unlock on error in ext4_expand_extra_isize()
Message-ID: <20191213185010.6k7yl2tck3wlsdkt@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213113237.GF15474@quack2.suse.cz>
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9470 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=845
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912130145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9470 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=904 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912130145
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We need to unlock the xattr before returning on this error path.

Fixes: c03b45b853f5 ("ext4, project: expand inode extra size if possible")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/ext4/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 28f28de0c1b6..629a25d999f0 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5692,7 +5692,7 @@ int ext4_expand_extra_isize(struct inode *inode,
 	error = ext4_journal_get_write_access(handle, iloc->bh);
 	if (error) {
 		brelse(iloc->bh);
-		goto out_stop;
+		goto out_unlock;
 	}
 
 	error = __ext4_expand_extra_isize(inode, new_extra_isize, iloc,
@@ -5702,8 +5702,8 @@ int ext4_expand_extra_isize(struct inode *inode,
 	if (!error)
 		error = rc;
 
+out_unlock:
 	ext4_write_unlock_xattr(inode, &no_expand);
-out_stop:
 	ext4_journal_stop(handle);
 	return error;
 }
-- 
2.11.0

