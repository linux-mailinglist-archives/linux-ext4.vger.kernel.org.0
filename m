Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2558D39C5F3
	for <lists+linux-ext4@lfdr.de>; Sat,  5 Jun 2021 07:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhFEFLf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 5 Jun 2021 01:11:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14090 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229544AbhFEFLf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 5 Jun 2021 01:11:35 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15552dpt060160;
        Sat, 5 Jun 2021 01:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=O3VpHXa5F77We2V3Rj9gOooJ2oW7Lvf1fzYPq00k/vI=;
 b=ZqAFXfupvlVXzRvgaIXzL+isLAo4HgqMiqHdp7xwFEocNldw0NhcZmaUyAprfIImBp3B
 iBy9dyVpOvo6lokf5bj4JUfYpaK3RBEiR5wT7DNqar4M2JqhkzFf7ETJqkT56dAVoxTK
 2Eg83+CFBwV8zS5kJIWIr2+aKKlFXUb8LQHzyf9ZfFFyfCI2aF3eQK9s/A1EBwx+jXCr
 d7zEbMTW67Cp6Ic5AijwxrDaarc1G8faCS0MASIQRL+Jc6fQYMvJQDFfr3dJyGkxV4bF
 tAm9rsI4cvafgLWrcDMC1ZLIHENYt9PH/3YHKt5JI0bnDt5lvl/tTUFZE3R/WkAswZpm rg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39024wgsft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Jun 2021 01:09:43 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15553HLa013772;
        Sat, 5 Jun 2021 05:09:41 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3900w880ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Jun 2021 05:09:41 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15559d1V23003544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 5 Jun 2021 05:09:39 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D9C9A405B;
        Sat,  5 Jun 2021 05:09:39 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC638A4054;
        Sat,  5 Jun 2021 05:09:38 +0000 (GMT)
Received: from localhost (unknown [9.85.75.172])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  5 Jun 2021 05:09:38 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH] ext4: Fix loff_t overflow in ext4_max_bitmap_size()
Date:   Sat,  5 Jun 2021 10:39:32 +0530
Message-Id: <594f409e2c543e90fd836b78188dfa5c575065ba.1622867594.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IJw-dyJLkQgpRgafN2WIaFxL42rekuNk
X-Proofpoint-ORIG-GUID: IJw-dyJLkQgpRgafN2WIaFxL42rekuNk
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-05_01:2021-06-04,2021-06-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106050035
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We should use unsigned long long rather than loff_t to avoid
overflow in ext4_max_bitmap_size() for comparison before returning.
w/o this patch sbi->s_bitmap_maxbytes was becoming a negative
value due to overflow of upper_limit (with has_huge_files as true)

Below is a quick test to trigger it on a 64KB pagesize system.

sudo mkfs.ext4 -b 65536 -O ^has_extents,^64bit /dev/loop2
sudo mount /dev/loop2 /mnt
sudo echo "hello" > /mnt/hello 	-> This will error out with
				"echo: write error: File too large"

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/super.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 7dc94f3e18e6..bedb66386966 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3189,17 +3189,17 @@ static loff_t ext4_max_size(int blkbits, int has_huge_files)
  */
 static loff_t ext4_max_bitmap_size(int bits, int has_huge_files)
 {
-	loff_t res = EXT4_NDIR_BLOCKS;
+	unsigned long long upper_limit, res = EXT4_NDIR_BLOCKS;
 	int meta_blocks;
-	loff_t upper_limit;
-	/* This is calculated to be the largest file size for a dense, block
+
+	/*
+	 * This is calculated to be the largest file size for a dense, block
 	 * mapped file such that the file's total number of 512-byte sectors,
 	 * including data and all indirect blocks, does not exceed (2^48 - 1).
 	 *
 	 * __u32 i_blocks_lo and _u16 i_blocks_high represent the total
 	 * number of 512-byte sectors of the file.
 	 */
-
 	if (!has_huge_files) {
 		/*
 		 * !has_huge_files or implies that the inode i_block field
@@ -3242,7 +3242,7 @@ static loff_t ext4_max_bitmap_size(int bits, int has_huge_files)
 	if (res > MAX_LFS_FILESIZE)
 		res = MAX_LFS_FILESIZE;
 
-	return res;
+	return (loff_t)res;
 }
 
 static ext4_fsblk_t descriptor_loc(struct super_block *sb,
-- 
2.31.1

