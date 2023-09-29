Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834817B3458
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Sep 2023 16:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbjI2OLM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 Sep 2023 10:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbjI2OLJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 29 Sep 2023 10:11:09 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61931B2;
        Fri, 29 Sep 2023 07:11:05 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TE9vFa031221;
        Fri, 29 Sep 2023 14:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=/MJo3EBySglF0dpjswUzhDX1+E3ul8XFL5YMWvHDjOE=;
 b=ClyEUSukJLtC8MQucAef2XrzV2fJ8q+8J5uJPcHkN16d9LRJA6fIi137AkPzXT/bMl5w
 KCWBtCWUE3xJoBUAX5SUXFj8fyjO1n622C1IH/+nO4O+YozI2C24Zton7ywUOt8X6V1W
 tubiPsytmqZlQGcLCMIfmi79CWWeflaPUL4yF0uLh/G0CaBb9DDPdLWOLvtLQdB75jKn
 zWgZpNtFpI1lvMd29/eRNkEK9N5xEhy9gW80/rdRLm+ArQltVKpf8VQAA8hlj+1Gw+t5
 KskR0fi12+LdWRyiE6AchhcY9DfC7db+T/yO93DNwDBLmVRiP+y68O+hty5kNSx8zQlx fA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdw5uvyp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 14:10:59 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38TEAxuN003610;
        Fri, 29 Sep 2023 14:10:59 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdw5uvynp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 14:10:59 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38TCOnKK008234;
        Fri, 29 Sep 2023 14:10:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tabbnw47r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 14:10:58 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38TEAutc19399208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 14:10:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 596D42004B;
        Fri, 29 Sep 2023 14:10:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C46E320040;
        Fri, 29 Sep 2023 14:10:54 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.43.84.228])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 29 Sep 2023 14:10:54 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: [PATCH 3/3] ext4: Skip unwritten buffers in __ext4_block_zero_page_range()
Date:   Fri, 29 Sep 2023 19:40:45 +0530
Message-Id: <143d41362a57e453f5a2cb00dc71e38e020c1c20.1695987265.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1695987265.git.ojaswin@linux.ibm.com>
References: <cover.1695987265.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3cq2_C6yRHtd3NCt_JcnXW6tzwBTPs7a
X-Proofpoint-ORIG-GUID: tlX1vHivoJaFdXqACsLF9u4Od2_qYlOg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_11,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290120
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If the buffer is unwritten then the underlying block should already return zero
for reads. Further, if it is not dirty then we can be sure that there is no data
on the folio that might get written back later. Hence we skip zeroing out the
folio and underlying block in this case.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index de8ea8430d30..75a951ffa3cb 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3659,6 +3659,10 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 		BUFFER_TRACE(bh, "freed: skip");
 		goto unlock;
 	}
+	if (buffer_unwritten(bh) && !buffer_dirty(bh)) {
+		BUFFER_TRACE(bh, "unwritten and non-dirty: skip");
+		goto unlock;
+	}
 	if (!buffer_mapped(bh)) {
 		BUFFER_TRACE(bh, "unmapped");
 		ext4_get_block(inode, iblock, bh, 0);
-- 
2.39.3

