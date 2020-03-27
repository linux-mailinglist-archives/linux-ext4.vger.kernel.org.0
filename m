Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94844195F6C
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Mar 2020 21:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgC0UIF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Mar 2020 16:08:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726959AbgC0UIF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 27 Mar 2020 16:08:05 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02RK2cHs070731
        for <linux-ext4@vger.kernel.org>; Fri, 27 Mar 2020 16:08:04 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3017jun4vw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Fri, 27 Mar 2020 16:08:04 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Fri, 27 Mar 2020 20:07:55 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 27 Mar 2020 20:07:51 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02RK7vmX29163866
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Mar 2020 20:07:57 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 079BA11C05B;
        Fri, 27 Mar 2020 20:07:57 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C69DE11C054;
        Fri, 27 Mar 2020 20:07:55 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.203.175.61])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 27 Mar 2020 20:07:55 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Y . Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, Ritesh Harjani <riteshh@linux.ibm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH] ext4: Don't set dioread_nolock by default for blocksize < pagesize
Date:   Sat, 28 Mar 2020 01:37:44 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <87pndagw7s.fsf@linux.ibm.com>
References: <87pndagw7s.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20032720-4275-0000-0000-000003B494B1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032720-4276-0000-0000-000038C9DD19
Message-Id: <20200327200744.12473-1-riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-27_07:2020-03-27,2020-03-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 suspectscore=0
 mlxscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 mlxlogscore=402 bulkscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003270161
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Currently on calling echo 3 > drop_caches on host machine, we see
FS corruption in the guest. This happens on Power machine where
blocksize < pagesize.

So as a temporary workaound don't enable dioread_nolock by default
for blocksize < pagesize until we identify the root cause.

Also emit a warning msg in case if this mount option is manually
enabled for blocksize < pagesize.

Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/super.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 27ab130a40d1..6873d9ffa352 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2186,6 +2186,14 @@ static int parse_options(char *options, struct super_block *sb,
 		}
 	}
 #endif
+	if (test_opt(sb, DIOREAD_NOLOCK)) {
+		int blocksize =
+			BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
+		if (blocksize < PAGE_SIZE)
+			ext4_msg(sb, KERN_WARNING, "Warning: mounting with an "
+				 "experimental mount option 'dioread_nolock' "
+				 "for blocksize < PAGE_SIZE");
+	}
 	return 1;
 }
 
@@ -3792,7 +3800,6 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		set_opt(sb, NO_UID32);
 	/* xattr user namespace & acls are now defaulted on */
 	set_opt(sb, XATTR_USER);
-	set_opt(sb, DIOREAD_NOLOCK);
 #ifdef CONFIG_EXT4_FS_POSIX_ACL
 	set_opt(sb, POSIX_ACL);
 #endif
@@ -3842,6 +3849,10 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->s_li_wait_mult = EXT4_DEF_LI_WAIT_MULT;
 
 	blocksize = BLOCK_SIZE << le32_to_cpu(es->s_log_block_size);
+
+	if (blocksize == PAGE_SIZE)
+		set_opt(sb, DIOREAD_NOLOCK);
+
 	if (blocksize < EXT4_MIN_BLOCK_SIZE ||
 	    blocksize > EXT4_MAX_BLOCK_SIZE) {
 		ext4_msg(sb, KERN_ERR,
-- 
2.20.1

