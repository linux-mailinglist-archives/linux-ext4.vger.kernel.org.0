Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49253A5D2C
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jun 2021 08:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbhFNGav (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Jun 2021 02:30:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38828 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232501AbhFNGas (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 14 Jun 2021 02:30:48 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15E65P6N029960;
        Mon, 14 Jun 2021 02:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dBuup0iFVekXUotKJXJporfakU/ZNXShyd+uI3H4cGM=;
 b=ICA3tvspuLSFEHzSjU1zWzFwOnIbxgThMC8jBVYmR15+LrMKjUJKTxQW9P8zdg1tNAz9
 xzWWyfdtI9+wshSH7BXwlhpu4y32aecN3r90QAP6d9xbBOQYaMLSWr1LVP8mGOxT/0nF
 U5tj2L2+wqcseZeNXTfefzfJ8q1SQTwWJ2jIb6evWfSX1G6nKDmHBrkgYINtRA4RFg3I
 hexsdjcZbhDaNmFxh408F5L8jkVUvcYotHKhx4Lg2A5ZgnF9fcghhLkhvuS5d98fTsAP
 VeH0njId8mq1FLzLThsIBJGgMocBM2h6eWLIKkfL1EiGFQr8wGUP8+c6c3zz+Lqz8q28 EQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 395xmjvaxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 02:28:45 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15E6Nn9q002952;
        Mon, 14 Jun 2021 06:28:44 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 394m6hrrbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 06:28:44 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15E6SfFE34079192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 06:28:41 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4303D4204B;
        Mon, 14 Jun 2021 06:28:41 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E648442042;
        Mon, 14 Jun 2021 06:28:40 +0000 (GMT)
Received: from localhost (unknown [9.85.68.28])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Jun 2021 06:28:40 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 6/9] gitignore: Add 031.out file to .gitignore
Date:   Mon, 14 Jun 2021 11:58:10 +0530
Message-Id: <1e987bceb2aca7c38dc375fd68cae0ac12b6d00c.1623651783.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623651783.git.riteshh@linux.ibm.com>
References: <cover.1623651783.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: akYWahMtLES16yhyZk6I6HQL0kS5lP-4
X-Proofpoint-ORIG-GUID: akYWahMtLES16yhyZk6I6HQL0kS5lP-4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-13_11:2021-06-11,2021-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=768 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 clxscore=1015 adultscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106140045
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add 031.out file to .gitignore

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index d3194e76..7a3be5e3 100644
--- a/.gitignore
+++ b/.gitignore
@@ -191,6 +191,7 @@ tags
 # Symlinked files
 /tests/generic/035.out
 /tests/generic/050.out
+/tests/generic/031.out
 /tests/xfs/033.out
 /tests/xfs/071.out
 /tests/xfs/096.out
-- 
2.31.1

