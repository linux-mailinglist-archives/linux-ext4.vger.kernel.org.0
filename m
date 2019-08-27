Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD0E29E32C
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2019 10:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfH0Iwj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Aug 2019 04:52:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45388 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfH0Iwi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Aug 2019 04:52:38 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7R8mnou135868;
        Tue, 27 Aug 2019 08:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=bSF9FeAxhVkI0MFxm9TIMwM291/MWgLqiQOkLqwX08Q=;
 b=SSk9TDHSCp1vks7AFi3QbmwLTPNS0c5g7ELEd9Xo2jIdO7Jy6j7EtL9OLC4kq6M5I1bf
 3YDc9CrFi9Wi1pSJ1bq23p6yoEKimlUaTEgK8j0dyrKdhLGS7uGNP1c3qkV3h+wh8vq3
 qpn23OS3w/bOJrq2N1S7l8+OUCSMxbam9YuNUiDxT6ER1aOR1NMrfJhOmNpTbuD9KG6E
 4BZURKtOR5kEOLgiDSFdA7tsqctFXZxHmRZXdlLN0ejSml52g5jTXZAoJdRdP0U5wwEE
 K3Z8zijiFH9EH444Iqqr0rHLNcBr97Qr3ckb+PKihvmh7vrIEKLS6i51mZb23TaWgGuY yQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2umyvt0vcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 08:52:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7R8gTDn144206;
        Tue, 27 Aug 2019 08:47:33 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2umj281576-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 08:47:33 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7R8lWhs032722;
        Tue, 27 Aug 2019 08:47:32 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Aug 2019 01:47:32 -0700
Date:   Tue, 27 Aug 2019 11:47:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Theodore Ts'o" <tytso@mit.edu>, Eric Whitney <enwlinux@gmail.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ext4: tidy up white space in count_rsvd()
Message-ID: <20190827084725.GA22301@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9361 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908270098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9361 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908270099
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This line was indented one tab too far.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/ext4/extents_status.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index dc28a9642452..f17e3f521a17 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -1089,7 +1089,7 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
 	 */
 	if ((i + sbi->s_cluster_ratio - 1) <= end) {
 		nclu = (end - i + 1) >> sbi->s_cluster_bits;
-			rc->ndelonly += nclu;
+		rc->ndelonly += nclu;
 		i += nclu << sbi->s_cluster_bits;
 	}
 
-- 
2.20.1

