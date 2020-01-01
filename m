Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C76CD12DE59
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Jan 2020 10:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbgAAJgp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Jan 2020 04:36:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33672 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725783AbgAAJgp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Jan 2020 04:36:45 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0019WN5m072296
        for <linux-ext4@vger.kernel.org>; Wed, 1 Jan 2020 04:36:44 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2x869rmhg3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Wed, 01 Jan 2020 04:36:44 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 1 Jan 2020 09:36:43 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 Jan 2020 09:36:41 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0019aead49873084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Jan 2020 09:36:40 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19B8211C04C;
        Wed,  1 Jan 2020 09:36:40 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A341711C04A;
        Wed,  1 Jan 2020 09:36:38 +0000 (GMT)
Received: from dhcp-9-199-159-72.in.ibm.com (unknown [9.199.159.72])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  1 Jan 2020 09:36:38 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     ebiggers@kernel.org, jack@suse.cz, tytso@mit.edu,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 1/1] ext4: remove unsed macro MPAGE_DA_EXTENT_TAIL
Date:   Wed,  1 Jan 2020 15:06:31 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191231180444.46586-1-ebiggers@kernel.org>
References: <20191231180444.46586-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20010109-0012-0000-0000-00000379A630
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010109-0013-0000-0000-000021B5B3CA
Message-Id: <20200101093631.24339-1-riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-01_02:2019-12-30,2020-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=544 bulkscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=5 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001010089
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Remove unsed macro MPAGE_DA_EXTENT_TAIL which
is no more used after below commit
4e7ea81d ("ext4: restructure writeback path")

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 748a9e6baab1..b1249e82e57c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -48,8 +48,6 @@
 
 #include <trace/events/ext4.h>
 
-#define MPAGE_DA_EXTENT_TAIL 0x01
-
 static __u32 ext4_inode_csum(struct inode *inode, struct ext4_inode *raw,
 			      struct ext4_inode_info *ei)
 {
-- 
2.21.0

