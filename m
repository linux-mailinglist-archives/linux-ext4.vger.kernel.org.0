Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4938484F6C
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Jan 2022 09:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbiAEIhH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Jan 2022 03:37:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32672 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232134AbiAEIhH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Jan 2022 03:37:07 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205564iq021309;
        Wed, 5 Jan 2022 08:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=38OQLH2L0HU9u4CdLDOTvwAu1FNjGrmCbF4NmnohvR8=;
 b=ieWcrTpAgzyaKw/C4WyhBNERgqGcxs2uOvBLJ7uQBNjfWaeTSDW2EEKFYrMP8d5xlBRp
 aqjNmYtLK1lcHlk8bV5dT/iAu7QQ8bWgBuC0Y9Aw8KrM+33UHDsF6LJibVrFDpvqiXhg
 cug4+waiViK3XBLls8UGdXo2SXZXhxF5Klhv6VyLvYehm3TRsxUUpZtznL7FxsrQ5Qc+
 j99fQTVPBdC2MTYrdNNYxtiNSV3Jya4weYwfPk6cwvdE5u6i7jhQoJaHDkHv3+Y2Kqgz
 afkH3iLcwWWzWcSKnjjfsFYlJ34Awz4HW8RZtI6cVlrPcKe3GWnMhIxlZpOiTYhgDCbU bg== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dckxsvyrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jan 2022 08:37:06 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2058YlYU002366;
        Wed, 5 Jan 2022 08:37:04 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 3daek9egmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jan 2022 08:37:04 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2058b01H40894820
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Jan 2022 08:37:00 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58638A4065;
        Wed,  5 Jan 2022 08:37:00 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6F04A405F;
        Wed,  5 Jan 2022 08:36:59 +0000 (GMT)
Received: from localhost (unknown [9.43.73.10])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  5 Jan 2022 08:36:59 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     xu.xin16@zte.com.cn, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH] ext4: Simplify !page_bufs logic with simple BUG_ON()
Date:   Wed,  5 Jan 2022 14:06:56 +0530
Message-Id: <4088b190f4367763c447f22e39ecb35de324f19e.1641371169.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211228073252.580296-1-xu.xin16@zte.com.cn>
References: <20211228073252.580296-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Tjw7P1MDfWz2uxWEg93GRUTFZNSnUTSQ
X-Proofpoint-ORIG-GUID: Tjw7P1MDfWz2uxWEg93GRUTFZNSnUTSQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-05_02,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201050056
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Simplify !page_bufs logic with simple BUG_ON().

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
Noticed a bug_on() related patch while reviewing, hence felt, this
below trivial change could be included along with it.

 fs/ext4/inode.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index bfd3545f1e5d..5656b4a9007b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1879,10 +1879,7 @@ static int __ext4_journalled_writepage(struct page *page,
 			goto out;
 	} else {
 		page_bufs = page_buffers(page);
-		if (!page_bufs) {
-			BUG();
-			goto out;
-		}
+		BUG_ON(!page_bufs);
 		ext4_walk_page_buffers(handle, inode, page_bufs, 0, len,
 				       NULL, bget_one);
 	}
--
2.31.1

