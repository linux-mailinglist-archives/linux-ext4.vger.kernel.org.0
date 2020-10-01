Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5D42809F3
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Oct 2020 00:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgJAWV4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Oct 2020 18:21:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45146 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgJAWVz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Oct 2020 18:21:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 091MJBan041222;
        Thu, 1 Oct 2020 22:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=dfCTaCO4TrPwxugpG8F1lbVYngmLQpQdeoMPR/WGz5s=;
 b=w/T955uy5f6Gf1qS9GpTnjye+4RVaVEIUMMkGId8/ddGnyKReJ5gISTgNI6ya7slFVTD
 XZ+scnFJB6yvLwL7tLgRl9XG/RGYTq9SGBthpoTdGQMl44Q980EsbkF2gFRbIQayVnYa
 F1lRLJmZI/hIXhkwt8M7w52tUcH9fpVvEgOKsvTyLD7cu/Y452jFmBtLNnyEz2uZ7EHu
 kwQPjlMooCfvuygAjhpCPDW0KfPyPVlhwevUiq0Qh2w5TOrlRDDnifLyHohgC+rcuXwN
 FF2z7rxYxt93l7oPKGoQfO1n55Bdl36SP2t40ehExIA99BM9nR1rNkil64S/qnrIDxKx vg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33sx9ngkvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 01 Oct 2020 22:21:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 091MKYtf149846;
        Thu, 1 Oct 2020 22:21:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 33tfj2805b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Oct 2020 22:21:50 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 091MLnHZ010500;
        Thu, 1 Oct 2020 22:21:49 GMT
Received: from localhost (/10.159.236.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 01 Oct 2020 15:21:49 -0700
Date:   Thu, 1 Oct 2020 15:21:48 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Subject: [PATCH] ext4: limit entries returned when counting fsmap records
Message-ID: <20201001222148.GA49520@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9761 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=1 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010010178
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9761 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=1
 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010010178
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

If userspace asked fsmap to try to count the number of entries, we cannot
return more than UINT_MAX entries because fmh_entries is u32.
Therefore, stop counting if we hit this limit or else we will waste time
to return truncated results.

Fixes: 0c9ec4beecac ("ext4: support GETFSMAP ioctls")
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/ext4/fsmap.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
index dbccf46f1770..37347ba868b7 100644
--- a/fs/ext4/fsmap.c
+++ b/fs/ext4/fsmap.c
@@ -108,6 +108,9 @@ static int ext4_getfsmap_helper(struct super_block *sb,
 
 	/* Are we just counting mappings? */
 	if (info->gfi_head->fmh_count == 0) {
+		if (info->gfi_head->fmh_entries == UINT_MAX)
+			return EXT4_QUERY_RANGE_ABORT;
+
 		if (rec_fsblk > info->gfi_next_fsblk)
 			info->gfi_head->fmh_entries++;
 
