Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EED3A5D29
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jun 2021 08:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhFNGat (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Jun 2021 02:30:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54630 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232490AbhFNGap (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 14 Jun 2021 02:30:45 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15E6556X091388;
        Mon, 14 Jun 2021 02:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=7LV0U8ZOUT7CBrpPQI+6ZQum3VQOvtOSSR4egLHnqfw=;
 b=NxdfQ0jTS6+UyKuO4dEOmxq9emaApwgVDg8YdhE+GLZoNZj1T3+uCV9q5IcI//DolK6x
 m5v9R/hLwOO32UEcrEWdhH3P/ktvT0gNRGQL9KJb1T4eGQ9xBAKLExUuHRlus0Ge3v7K
 ByEAuWLXBoJ5D4No8myhJwAlpXb2+T4meyIY3FVZATPKaHJQu9z7xaxVq1WrmQNzz9Na
 LUTKeisGqs7gWaW/rIIOtSUavqd1f9MkY6gtcIImxR08kws9s56AiDvYoHu/ZUjAtzql
 v0pSRTWIAWZSQEt0ew5KTei///CiSdh7Fpp0xgRTQsyDd4V8DOntVoy5LWi1xV/YTpe7 WA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 395ypt2vxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 02:28:42 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15E6O8tb019523;
        Mon, 14 Jun 2021 06:28:40 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 394mj8rr65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 06:28:40 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15E6RcNw32833848
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 06:27:39 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99B1442049;
        Mon, 14 Jun 2021 06:28:37 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 477D742045;
        Mon, 14 Jun 2021 06:28:37 +0000 (GMT)
Received: from localhost (unknown [9.85.68.28])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Jun 2021 06:28:37 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 3/9] ext4/306: Add -b blocksize parameter too to avoid failure with DAX config
Date:   Mon, 14 Jun 2021 11:58:07 +0530
Message-Id: <280020a9d6791ad4fc1c51bef9c20771f6791d69.1623651783.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623651783.git.riteshh@linux.ibm.com>
References: <cover.1623651783.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Md0Ia6gMeqfZpEGyXQXoKt7ToSpgaupm
X-Proofpoint-ORIG-GUID: Md0Ia6gMeqfZpEGyXQXoKt7ToSpgaupm
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-13_11:2021-06-11,2021-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106140045
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

mkfs.ext4 by default uses 4K blocksize. On DAX config with a 64K
pagesize platform (PPC64), this will fail to mount since DAX requires bs
== ps.
Hence add the -b blocksize paramter in ext4/306.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 tests/ext4/306 | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/ext4/306 b/tests/ext4/306
index 146fdb39..1d45a9d0 100755
--- a/tests/ext4/306
+++ b/tests/ext4/306
@@ -38,7 +38,10 @@ features="^extents"
 if grep -q 64bit /etc/mke2fs.conf ; then
     features="^extents,^64bit"
 fi
-$MKFS_EXT4_PROG -F -O "$features" $SCRATCH_DEV 512m >> $seqres.full 2>&1
+
+blksz=$(get_page_size)
+
+$MKFS_EXT4_PROG -F -b $blksz -O "$features" $SCRATCH_DEV 512m >> $seqres.full 2>&1
 _scratch_mount
 
 # Create a small non-extent-based file
-- 
2.31.1

