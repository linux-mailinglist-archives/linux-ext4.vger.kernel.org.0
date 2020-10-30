Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088632A04A5
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Oct 2020 12:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgJ3Lqf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 30 Oct 2020 07:46:35 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:55526 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgJ3Lqe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 30 Oct 2020 07:46:34 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09UBjktJ151431;
        Fri, 30 Oct 2020 11:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=IP8KAf+VKVAVn1VgSu2fLjdVudPJ1EuYRy8qQhlPJvs=;
 b=Qm2Et2ASP/AxCaoxFNalaoxBf7ElMUTUkecZLq+mSoMMxY5W23z+E6pECcjFzmVEuE4g
 lSM4n5wXVDGOZ1u5/wDZCXYKhRABB12QjVHpxoTeSaqP6JkIo8VIyJhDpveY6g9FG0rn
 VJD721wDnFL5Gt20l/EhKlux2mWAR0+YbCuK9JTzeWkKwdsRfTt223Zz/uU7ytn/qZPU
 n+cWKUywYKIXddRnTNS7P89EjS1RGbwyNzCxsD00IlYpAFaKAj+vb3G/dv+acqXhQE9x
 vYWNrkhvIkxTPaumdzv2NsBZT5zFo64FxOzfxvOlNaf9soME9SuVbLZ5bc3ea1QSwOdU 4Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 34c9sb9exp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Oct 2020 11:46:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09UBkR5O065036;
        Fri, 30 Oct 2020 11:46:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 34cx1uchd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Oct 2020 11:46:29 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09UBkRvW013767;
        Fri, 30 Oct 2020 11:46:27 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Oct 2020 04:46:26 -0700
Date:   Fri, 30 Oct 2020 14:46:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ext4: silence an uninitialized variable warning
Message-ID: <20201030114620.GB3251003@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010300091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010300091
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Smatch complains that "i" can be uninitialized if we don't enter the
loop.  I don't know if it's possible but we may as well silence this
warning.

Fixes: 8016e29f4362 ("ext4: fast commit recovery path")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/ext4/mballoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 85abbfb98cbe..9e8faf851c59 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5167,7 +5167,7 @@ static ext4_fsblk_t ext4_mb_new_blocks_simple(handle_t *handle,
 	struct super_block *sb = ar->inode->i_sb;
 	ext4_group_t group;
 	ext4_grpblk_t blkoff;
-	int  i;
+	int i = 0;
 	ext4_fsblk_t goal, block;
 	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
 
-- 
2.28.0

