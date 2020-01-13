Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6644138FB7
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2020 12:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgAMLEe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Jan 2020 06:04:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52596 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726193AbgAMLEe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 13 Jan 2020 06:04:34 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00DAvcuT062347
        for <linux-ext4@vger.kernel.org>; Mon, 13 Jan 2020 06:04:33 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xfa255uup-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Mon, 13 Jan 2020 06:04:33 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Mon, 13 Jan 2020 11:04:31 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 13 Jan 2020 11:04:29 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00DB4SpM47251938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 11:04:28 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CE304204D;
        Mon, 13 Jan 2020 11:04:28 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39B3F4204B;
        Mon, 13 Jan 2020 11:04:27 +0000 (GMT)
Received: from dhcp-9-199-159-93.in.ibm.com (unknown [9.199.159.93])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 13 Jan 2020 11:04:27 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 2/2] ext4: Fix stale data read issue with DIO read & ext4_page_mkwrite path
Date:   Mon, 13 Jan 2020 16:34:22 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1578907890.git.riteshh@linux.ibm.com>
References: <cover.1578907890.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20011311-0028-0000-0000-000003D09D9A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011311-0029-0000-0000-00002494BB3A
Message-Id: <1c2da3cf5e0d90e8650e81f07976629c7d87e8ca.1578907891.git.riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_03:2020-01-13,2020-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=5 mlxscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=872
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001130094
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Currently there is a small race window where ext4 tries to allocate
a written block for mapped files and if DIO read is in progress, then
this may result into stale data read exposure problem.

This patch fixes the mentioned issue by:
1. For non-delalloc path, page_mkwrite will use unwritten blocks by
   default for extent based files.

2. For delalloc path, we check if DIO is in progress during writeback.
   If yes, then we use unwritten blocks method to avoid this race.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/inode.c | 45 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d035acab5b2a..07f66782335b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1529,6 +1529,7 @@ struct mpage_da_data {
 	struct ext4_map_blocks map;
 	struct ext4_io_submit io_submit;	/* IO submission data */
 	unsigned int do_map:1;
+	bool dio_in_progress:1;
 };
 
 static void mpage_release_unused_pages(struct mpage_da_data *mpd,
@@ -2359,7 +2360,7 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
 			   EXT4_GET_BLOCKS_METADATA_NOFAIL |
 			   EXT4_GET_BLOCKS_IO_SUBMIT;
 	dioread_nolock = ext4_should_dioread_nolock(inode);
-	if (dioread_nolock)
+	if (dioread_nolock || mpd->dio_in_progress)
 		get_blocks_flags |= EXT4_GET_BLOCKS_IO_CREATE_EXT;
 	if (map->m_flags & (1 << BH_Delay))
 		get_blocks_flags |= EXT4_GET_BLOCKS_DELALLOC_RESERVE;
@@ -2367,7 +2368,8 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
 	err = ext4_map_blocks(handle, inode, map, get_blocks_flags);
 	if (err < 0)
 		return err;
-	if (dioread_nolock && (map->m_flags & EXT4_MAP_UNWRITTEN)) {
+	if ((dioread_nolock || mpd->dio_in_progress) &&
+	    (map->m_flags & EXT4_MAP_UNWRITTEN)) {
 		if (!mpd->io_submit.io_end->handle &&
 		    ext4_handle_valid(handle)) {
 			mpd->io_submit.io_end->handle = handle->h_rsv_handle;
@@ -2626,6 +2628,7 @@ static int ext4_writepages(struct address_space *mapping,
 	bool done;
 	struct blk_plug plug;
 	bool give_up_on_write = false;
+	bool dio_in_progress = false;
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
 		return -EIO;
@@ -2680,15 +2683,6 @@ static int ext4_writepages(struct address_space *mapping,
 		ext4_journal_stop(handle);
 	}
 
-	if (ext4_should_dioread_nolock(inode)) {
-		/*
-		 * We may need to convert up to one extent per block in
-		 * the page and we may dirty the inode.
-		 */
-		rsv_blocks = 1 + ext4_chunk_trans_blocks(inode,
-						PAGE_SIZE >> inode->i_blkbits);
-	}
-
 	if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
 		range_whole = 1;
 
@@ -2712,6 +2706,26 @@ static int ext4_writepages(struct address_space *mapping,
 	done = false;
 	blk_start_plug(&plug);
 
+	/*
+	 * If DIO is in progress, then we use unwritten blocks for allocation.
+	 * This is to avoid a small window of race (stale read) with
+	 * ext4_page_mkwrite path in delalloc case & with DIO read in parallel.
+	 *
+	 * Let's check for i_dio_count after we have tagged pages for writeback.
+	 */
+	smp_mb__before_atomic();
+	dio_in_progress = !!atomic_read(&inode->i_dio_count);
+	mpd.dio_in_progress = dio_in_progress;
+
+	if (ext4_should_dioread_nolock(inode) || dio_in_progress) {
+		/*
+		 * We may need to convert up to one extent per block in
+		 * the page and we may dirty the inode.
+		 */
+		rsv_blocks = 1 + ext4_chunk_trans_blocks(inode,
+						PAGE_SIZE >> inode->i_blkbits);
+	}
+
 	/*
 	 * First writeback pages that don't need mapping - we can avoid
 	 * starting a transaction unnecessarily and also avoid being blocked
@@ -5965,8 +5979,13 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 		}
 	}
 	unlock_page(page);
-	/* OK, we need to fill the hole... */
-	if (ext4_should_dioread_nolock(inode))
+	/*
+	 * OK, we need to fill the hole...
+	 * By default use unwritten block allocation here to avoid a small
+	 * window of race (stale data read) with DIO read path.
+	 */
+	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS) &&
+	    !ext4_should_journal_data(inode))
 		get_block = ext4_get_block_unwritten;
 	else
 		get_block = ext4_get_block;
-- 
2.21.0

