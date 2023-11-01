Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E617DE4B8
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Nov 2023 17:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344051AbjKAQia (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Nov 2023 12:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343951AbjKAQi3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Nov 2023 12:38:29 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81F9FD;
        Wed,  1 Nov 2023 09:38:26 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1Fwpwh019007;
        Wed, 1 Nov 2023 16:38:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ZVedtaOaVC97Rhh5vSLPSrceQPvJ9fAP7KFDc7AhsoY=;
 b=OOpS8yBSTijsAfATOMoIDhiEyHEa9rrLQIq7A0FfI9/KKVzUNJt/o1FRsGtOGq+cfZWD
 mXUGYmtqrEizYgOcG/UloCsC1dfzr8mi+ihZ6KKXkaOMlENV5XbGDrCFhUPXSiYa79wn
 VsgG7idsm7SqrZOwVu9WOz1BVLyf5UHyy4prnKsQonpR9nXuneTE898BWkHHFGZJx7mZ
 kqBjANHLwr0ByFl58x/06HTtiuUAAdVS+eg0bU5nm1/CCTVjq+Zp92R5QM7uZX5uKo8T
 1prjfJ3qqAHPaRGIbGid7puMJf/NqKXThmojSROvr0s1MLTRhGM9AZ4ONWjvxuRUpTpy qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u3sk4190b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 16:38:22 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A1GUPGn016996;
        Wed, 1 Nov 2023 16:38:22 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u3sk418yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 16:38:22 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1DtZep011389;
        Wed, 1 Nov 2023 16:38:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u1euk8bwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 16:38:21 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A1GcJlo61997364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Nov 2023 16:38:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D0A720043;
        Wed,  1 Nov 2023 16:38:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C1DB20040;
        Wed,  1 Nov 2023 16:38:18 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.43.9.163])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  1 Nov 2023 16:38:17 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: [PATCH v2 2/2] ext4: Clarify handling of unwritten bh in __ext4_block_zero_page_range()
Date:   Wed,  1 Nov 2023 22:08:11 +0530
Message-Id: <d859b7ae5fe42e6626479b91ed9f4da3aae4c597.1698856309.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1698856309.git.ojaswin@linux.ibm.com>
References: <cover.1698856309.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GM2nldUHusUGxg3L1SLGrKHw1nEQPPCn
X-Proofpoint-GUID: MVbzxiprsSTy2WCvqHD8p7H58rxUrWFO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_15,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311010131
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

As an optimization, I was trying to work on exiting early from this
function if dealing with unwritten extent since they anyways read 0.
However, it was realised that there are certain code paths that can
end up calling ext4_block_zero_page_range() for an unwritten bh that
might still have data in pagecache. In this case, we can't exit early
and we do require to process the bh and zero out the pagecache to ensure
that a writeback can't kick in at a later time and flush the stale
pagecache to disk.

Since, adding the logic to exit early for unwritten bh was turning out
to be much more nuanced and the current code already handles it well,
just add a comment to explicitly document this behavior.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d7732320431a..76921e834dd4 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3632,6 +3632,12 @@ void ext4_set_aops(struct inode *inode)
 		inode->i_mapping->a_ops = &ext4_aops;
 }
 
+/*
+ * Here we can't skip an unwritten buffer even though it usually reads zero
+ * because it might have data in pagecache (eg, if called from ext4_zero_range,
+ * ext4_punch_hole, etc) which needs to be properly zeroed out. Otherwise a
+ * racing writeback can come later and flush the stale pagecache to disk.
+ */
 static int __ext4_block_zero_page_range(handle_t *handle,
 		struct address_space *mapping, loff_t from, loff_t length)
 {
-- 
2.39.3

