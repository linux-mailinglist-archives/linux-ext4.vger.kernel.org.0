Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18C64C0075
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Feb 2022 18:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbiBVRvj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Feb 2022 12:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234336AbiBVRvh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 22 Feb 2022 12:51:37 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EC61693AB;
        Tue, 22 Feb 2022 09:51:12 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21MHNWwW001378;
        Tue, 22 Feb 2022 17:51:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=I5vFQCQ1LOaNO7pe2bax5zL+cmBKQg9ccjLI914Diog=;
 b=W5o2ZHcjaLj+UhTAHJwB5NlMkE3MAQFZxbRLxtiLqDUXgoF8ntn5XzGtr5wyNxQ+/Y+h
 7YpQLSgQECDb1uyerV0RjnSX4VK2AJyWE1kiAk14WBWxEipStXkH5PH0UdJtD5+sYKF/
 F/HltqNMGMfAJ3LibERfOaGRGFzjpB6+zM5sJKspRa0JUUi1SOlj9RlWL9D+CQZnX2ut
 skhLKZhewio9X202RclFeS43V82ej40Brbi1b7zyBCN0IgNvsntufl86SZUS/283BzFe
 1JvWvpBMzK2M1hQPdFjasyaQhaFoRneHylqXshnGDnEbTnEWC2+GO9C8Ha8RG14xHQLd jQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ed2pqugh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 17:51:11 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21MHldhb026632;
        Tue, 22 Feb 2022 17:51:09 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3ear694vxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 17:51:09 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21MHp0bn42664364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 17:51:00 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B56C4A405D;
        Tue, 22 Feb 2022 17:51:00 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3474FA4051;
        Tue, 22 Feb 2022 17:50:59 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.41.242])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 22 Feb 2022 17:50:58 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     riteshh@linux.ibm.com
Subject: [PATCH v2 1/2] src/ext4_resize.c: Refactor code and ensure accurate errno is returned
Date:   Tue, 22 Feb 2022 23:20:52 +0530
Message-Id: <02805202a6a3d57d0c5c7a97da4eca50b40bbd91.1645549521.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1645549521.git.ojaswin@linux.ibm.com>
References: <cover.1645549521.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: w-_SqNSfXu-k7D4u8TpTZaqqMiyehI-K
X-Proofpoint-GUID: w-_SqNSfXu-k7D4u8TpTZaqqMiyehI-K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_05,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202220107
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The current implementation of ext4_resize returned 1 whenever
there was an error. Modify this to return the correct error code.
This is important for tests that rely on correct error reporting, by
the kernel, for ext4 resize functionality.

Additionaly, perform some code cleanup.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 src/ext4_resize.c | 46 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/src/ext4_resize.c b/src/ext4_resize.c
index 39e16529..78b66432 100644
--- a/src/ext4_resize.c
+++ b/src/ext4_resize.c
@@ -10,6 +10,7 @@
 #include <unistd.h>
 #include <stdint.h>
 #include <stdlib.h>
+#include <string.h>
 #include <sys/ioctl.h>
 #include <sys/mount.h>
 
@@ -19,33 +20,50 @@ typedef unsigned long long __u64;
 #define EXT4_IOC_RESIZE_FS		_IOW('f', 16, __u64)
 #endif
 
+#define pr_error(fmt, ...) do { \
+	fprintf (stderr, "ext4_resize.c: " fmt, ##__VA_ARGS__); \
+} while (0)
+
+static void usage(void)
+{
+	fprintf(stdout, "\nUsage: ext4_resize [mnt_path] [new_size(blocks)]\n");
+}
+
 int main(int argc, char **argv)
 {
 	__u64	new_size;
 	int	error, fd;
-	char	*tmp = NULL;
+	char	*mnt_dir = NULL, *tmp = NULL;
 
 	if (argc != 3) {
-		fputs("insufficient arguments\n", stderr);
-		return 1;
-	}
-	fd = open(argv[1], O_RDONLY);
-	if (!fd) {
-		perror(argv[1]);
-		return 1;
+		error = EINVAL;
+		pr_error("insufficient arguments\n");
+		usage();
+		return error;
 	}
 
+	mnt_dir = argv[1];
+
 	errno = 0;
 	new_size = strtoull(argv[2], &tmp, 10);
 	if ((errno) || (*tmp != '\0')) {
-		fprintf(stderr, "%s: invalid new size\n", argv[0]);
-		return 1;
+		error = errno;
+		pr_error("invalid new size\n");
+		return error;
+	}
+
+	fd = open(mnt_dir, O_RDONLY);
+	if (fd < 0) {
+		error = errno;
+		pr_error("open() failed with error: %s\n", strerror(error));
+		return error;
 	}
 
-	error = ioctl(fd, EXT4_IOC_RESIZE_FS, &new_size);
-	if (error < 0) {
-		perror("EXT4_IOC_RESIZE_FS");
-		return 1;
+	if(ioctl(fd, EXT4_IOC_RESIZE_FS, &new_size) < 0) {
+		error = errno;
+		pr_error("EXT4_IOC_RESIZE_FS ioctl() failed with error: %s\n", strerror(error));
+		return error;
 	}
+
 	return 0;
 }
-- 
2.27.0

