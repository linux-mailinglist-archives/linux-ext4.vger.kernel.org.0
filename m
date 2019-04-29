Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF18E91C
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Apr 2019 19:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfD2Rcb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Apr 2019 13:32:31 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:58668 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728798AbfD2Rca (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 29 Apr 2019 13:32:30 -0400
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3THW7lU029960;
        Mon, 29 Apr 2019 18:32:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=jan2016.eng; bh=sS7DrQAgbihdhID9iWJw9oN4UHyGdasArGXMZWDAwSA=;
 b=DMT5kV5/nEua4sy5xPmHLK+2L55ki5959TcXOes5jGvXG6YBXHR6llG6wbUq1BGB/ELm
 SSgDEWKOPNsmG05b8+oWFkYHWdA+99RbWudDzExCAPwKyNXAyP58uWf6cMuNjMjcBOSE
 Cz77p70tP+sv0qTvy9xqkWQf2FhC5Pt6xHE4Lvf5KmzlIu1GGE39q7/L5c3HvF4O/cuC
 UBKAtSOiWWWQmI3q5aTuM9gkXSyATMS9/YfqjRAmoIazBvixNv0/iLiOWcmIFITlDdg9
 hby+mAhXqCt9OtUBycivVy0OarUVt3pIi85lsaDFCXfflk0nIAMoion4H3rSdvNu7rPq OA== 
Received: from prod-mail-ppoint3 (prod-mail-ppoint3.akamai.com [96.6.114.86] (may be forged))
        by mx0a-00190b01.pphosted.com with ESMTP id 2s4eb6jcux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Apr 2019 18:32:19 +0100
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
        by prod-mail-ppoint3.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x3THWFRc004727;
        Mon, 29 Apr 2019 13:32:18 -0400
Received: from prod-mail-relay15.akamai.com ([172.27.17.40])
        by prod-mail-ppoint3.akamai.com with ESMTP id 2s4jdvcg8r-1;
        Mon, 29 Apr 2019 13:32:18 -0400
Received: from bos-lpxjs (bos-lpxjs.kendall.corp.akamai.com [172.29.171.194])
        by prod-mail-relay15.akamai.com (Postfix) with ESMTP id 377C420064;
        Mon, 29 Apr 2019 17:32:18 +0000 (GMT)
Received: from dbanerje by bos-lpxjs with local (Exim 4.86_2)
        (envelope-from <dbanerje@akamai.com>)
        id 1hLA8I-0000OJ-DQ; Mon, 29 Apr 2019 13:32:02 -0400
From:   Debabrata Banerjee <dbanerje@akamai.com>
To:     Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Dmitry Monakhov <dmonakhov@openvz.org>,
        linux-kernel@vger.kernel.org
Cc:     dbanerje@akamai.com
Subject: [PATCH v2] ext4: bad mount opts in no journal mode
Date:   Mon, 29 Apr 2019 13:31:58 -0400
Message-Id: <20190429173158.1463-1-dbanerje@akamai.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-29_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904290120
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-29_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904290120
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fixes:
commit 1e381f60dad9 ("ext4: do not allow journal_opts for fs w/o journal")

Instead of removing EXT4_MOUNT_JOURNAL_CHECKSUM from s_def_mount_opt as
I assume was intended, all other options were blown away leading to
_ext4_show_options() output being incorrect.

Signed-off-by: Debabrata Banerjee <dbanerje@akamai.com>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 6ed4eb81e674..5cdf1d88b5c3 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4238,7 +4238,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 				 "data=, fs mounted w/o journal");
 			goto failed_mount_wq;
 		}
-		sbi->s_def_mount_opt &= EXT4_MOUNT_JOURNAL_CHECKSUM;
+		sbi->s_def_mount_opt &= ~EXT4_MOUNT_JOURNAL_CHECKSUM;
 		clear_opt(sb, JOURNAL_CHECKSUM);
 		clear_opt(sb, DATA_FLAGS);
 		sbi->s_journal = NULL;
-- 
2.21.0

