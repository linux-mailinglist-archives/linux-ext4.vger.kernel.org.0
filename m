Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6050F127C
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2019 10:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbfKFJiX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Nov 2019 04:38:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28998 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726143AbfKFJiW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Nov 2019 04:38:22 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA69baKg117189
        for <linux-ext4@vger.kernel.org>; Wed, 6 Nov 2019 04:38:21 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w3st7vj1y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Wed, 06 Nov 2019 04:38:21 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 6 Nov 2019 09:38:19 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 6 Nov 2019 09:38:16 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA69cFp518546916
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Nov 2019 09:38:15 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78D2AAE055;
        Wed,  6 Nov 2019 09:38:15 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1804EAE051;
        Wed,  6 Nov 2019 09:38:14 +0000 (GMT)
Received: from dhcp-9-199-158-77.in.ibm.com (unknown [9.199.158.77])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  6 Nov 2019 09:38:13 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     dan.carpenter@oracle.com, tytso@mit.edu, jack@suse.cz
Cc:     linux-ext4@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 1/1] ext4: Add error handling for io_end_vec struct allocation
Date:   Wed,  6 Nov 2019 15:08:09 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191106082505.GA31923@mwanda>
References: <20191106082505.GA31923@mwanda>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19110609-0008-0000-0000-0000032C0349
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110609-0009-0000-0000-00004A4B036C
Message-Id: <20191106093809.10673-1-riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-06_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911060099
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch adds the error handling in case of any memory allocation
failure for io_end_vec. This was missing in original
patch series which enables dioread_nolock for blocksize < pagesize.

Fixes: c8cc88163f40 ("ext4: Add support for blocksize < pagesize in dioread_nolock")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/inode.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 381813205f99..de70f19bfa7e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2240,6 +2240,10 @@ static int mpage_process_page(struct mpage_da_data *mpd, struct page *page,
 				err = 0;
 			if (!err && mpd->map.m_len && mpd->map.m_lblk > lblk) {
 				io_end_vec = ext4_alloc_io_end_vec(io_end);
+				if (IS_ERR(io_end_vec)) {
+					err = PTR_ERR(io_end_vec);
+					goto out;
+				}
 				io_end_vec->offset = mpd->map.m_lblk << blkbits;
 			}
 			*map_bh = true;
@@ -2405,8 +2409,11 @@ static int mpage_map_and_submit_extent(handle_t *handle,
 	loff_t disksize;
 	int progress = 0;
 	ext4_io_end_t *io_end = mpd->io_submit.io_end;
-	struct ext4_io_end_vec *io_end_vec = ext4_alloc_io_end_vec(io_end);
+	struct ext4_io_end_vec *io_end_vec;
 
+	io_end_vec = ext4_alloc_io_end_vec(io_end);
+	if (IS_ERR(io_end_vec))
+		return PTR_ERR(io_end_vec);
 	io_end_vec->offset = ((loff_t)map->m_lblk) << inode->i_blkbits;
 	do {
 		err = mpage_map_one_extent(handle, mpd);
-- 
2.21.0

