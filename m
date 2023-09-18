Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51867A477C
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Sep 2023 12:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239696AbjIRKrA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Sep 2023 06:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241220AbjIRKqi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Sep 2023 06:46:38 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9031A2;
        Mon, 18 Sep 2023 03:46:29 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38IAbjLR002153;
        Mon, 18 Sep 2023 10:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VDKC0IgCtueKNyujpoZMuLZLOeOtYSFtTCp33XEvMbQ=;
 b=ndUBAxmZzSSO5fJPfKvfp428YzhVQO2nlhMHzCR20zdUEty4+sD5FGBsO/Q/scBtRw1i
 aKHS97alJEB/kAixgMOnmLn3qg13EC/MjQi8dn7fwH6BSzR+YWHa077/LnsRyaC0mb+q
 CDI4oWPcTU0zeiVypFzFBNO7YHa3hrX7mksU0zbIPt4suvh/tZEKw0u+A050sSsWlZcP
 S/RE52wjBrpzhZh897MmhzOJ7JnShZOzP/xfSsENGHo2sSllJNL3ocZ7D1pEHy1fQhuL
 KINXH13aNBKQkl+jRSj0jThDd6RVKqiOJtlE6MAcUbKQemrzOWsvF71MDg54waYDX0Dj Hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t6mqhrj49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 10:46:25 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38IAbt7Q003407;
        Mon, 18 Sep 2023 10:46:24 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t6mqhrj44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 10:46:24 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38I9FfR1016455;
        Mon, 18 Sep 2023 10:46:23 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t5sd1hbup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 10:46:23 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38IAkMtK63635934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 10:46:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A8D42004B;
        Mon, 18 Sep 2023 10:46:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B7F920043;
        Mon, 18 Sep 2023 10:46:13 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.43.103.37])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 18 Sep 2023 10:46:12 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: [PATCH v3 1/1] ext4: Mark buffer new if it is unwritten to avoid stale data exposure
Date:   Mon, 18 Sep 2023 16:15:50 +0530
Message-Id: <d0ed09d70a9733fbb5349c5c7b125caac186ecdf.1695033645.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1695033645.git.ojaswin@linux.ibm.com>
References: <cover.1695033645.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jzQaErfWEcJamkHNs8YUyaO-4GHM4Mm6
X-Proofpoint-GUID: LIezmvTrat85M1iO0KxBRGJrTWMfJ6VW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_02,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=980 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309180092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

** Short Version **

In ext4 with dioread_nolock, we could have a scenario where the bh returned by
get_blocks (ext4_get_block_unwritten()) in __block_write_begin_int() has
UNWRITTEN and MAPPED flag set. Since such a bh does not have NEW flag set we
never zero out the range of bh that is not under write, causing whatever stale
data is present in the folio at that time to be written out to disk. To fix this
mark the buffer as new, in case it is unwritten, in ext4_get_block_unwritten().

** Long Version **

The issue mentioned above was resulting in two different bugs:

1. On block size < page size case in ext4, generic/269 was reliably
failing with dioread_nolock. The state of the write was as follows:

  * The write was extending i_size.
  * The last block of the file was fallocated and had an unwritten extent
  * We were near ENOSPC and hence we were switching to non-delayed alloc
    allocation.

In this case, the back trace that triggers the bug is as follows:

  ext4_da_write_begin()
    /* switch to nodelalloc due to low space */
    ext4_write_begin()
      ext4_should_dioread_nolock() // true since mount flags still have delalloc
      __block_write_begin(..., ext4_get_block_unwritten)
        __block_write_begin_int()
          for(each buffer head in page) {
            /* first iteration, this is bh1 which contains i_size */
            if (!buffer_mapped)
              get_block() /* returns bh with only UNWRITTEN and MAPPED */
            /* second iteration, bh2 */
              if (!buffer_mapped)
                get_block() /* we fail here, could be ENOSPC */
          }
          if (err)
            /*
             * this would zero out all new buffers and mark them uptodate.
             * Since bh1 was never marked new, we skip it here which causes
             * the bug later.
             */
            folio_zero_new_buffers();
      /* ext4_wrte_begin() error handling */
      ext4_truncate_failed_write()
        ext4_truncate()
          ext4_block_truncate_page()
            __ext4_block_zero_page_range()
              if(!buffer_uptodate())
                ext4_read_bh_lock()
                  ext4_read_bh() -> ... ext4_submit_bh_wbc()
                    BUG_ON(buffer_unwritten(bh)); /* !!! */

2. The second issue is stale data exposure with page size >= blocksize
with dioread_nolock. The conditions needed for it to happen are same as
the previous issue ie dioread_nolock around ENOSPC condition. The issue
is also similar where in __block_write_begin_int() when we call
ext4_get_block_unwritten() on the buffer_head and the underlying extent
is unwritten, we get an unwritten and mapped buffer head. Since it is
not new, we never zero out the partial range which is not under write,
thus writing stale data to disk. This can be easily observed with the
following reproducer:

 fallocate -l 4k testfile
 xfs_io -c "pwrite 2k 2k" testfile
 # hexdump output will have stale data in from byte 0 to 2k in testfile
 hexdump -C testfile

NOTE: To trigger this, we need dioread_nolock enabled and write happening via
ext4_write_begin(), which is usually used when we have -o nodealloc. Since
dioread_nolock is disabled with nodelalloc, the only alternate way to call
ext4_write_begin() is to ensure that delayed alloc switches to nodelalloc ie
ext4_da_write_begin() calls ext4_write_begin(). This will usually happen when
ext4 is almost full like the way generic/269 was triggering it in Issue 1 above.
This might make the issue harder to hit. Hence, for reliable replication, I used
the below patch to temporarily allow dioread_nolock with nodelalloc and then
mount the disk with -o nodealloc,dioread_nolock. With this you can hit the stale
data issue 100% of times:

@@ -508,8 +508,8 @@ static inline int ext4_should_dioread_nolock(struct inode *inode)
  if (ext4_should_journal_data(inode))
    return 0;
  /* temporary fix to prevent generic/422 test failures */
- if (!test_opt(inode->i_sb, DELALLOC))
-   return 0;
+ // if (!test_opt(inode->i_sb, DELALLOC))
+ //  return 0;
  return 1;
 }

After applying this patch to mark buffer as NEW, both the above issues are
fixed.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 6c490f05e2ba..8b286a800193 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -789,10 +789,22 @@ int ext4_get_block(struct inode *inode, sector_t iblock,
 int ext4_get_block_unwritten(struct inode *inode, sector_t iblock,
 			     struct buffer_head *bh_result, int create)
 {
+	int ret = 0;
+
 	ext4_debug("ext4_get_block_unwritten: inode %lu, create flag %d\n",
 		   inode->i_ino, create);
-	return _ext4_get_block(inode, iblock, bh_result,
+	ret = _ext4_get_block(inode, iblock, bh_result,
 			       EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT);
+
+	/*
+	 * If the buffer is marked unwritten, mark it as new to make sure it is
+	 * zeroed out correctly in case of partial writes. Otherwise, there is
+	 * a chance of stale data getting exposed.
+	 */
+	if (ret == 0 && buffer_unwritten(bh_result))
+		set_buffer_new(bh_result);
+
+	return ret;
 }
 
 /* Maximum number of blocks we map for direct IO at once. */
-- 
2.39.3

