Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C637936E8FD
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Apr 2021 12:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbhD2Koj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Apr 2021 06:44:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232261AbhD2Koj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 29 Apr 2021 06:44:39 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13TAYvVW036860;
        Thu, 29 Apr 2021 06:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=8STbRIY62LhQpQThHTVKXSch/4HvrnwvDKjzDSGw7bg=;
 b=WpOVlH9plBTlV781lyLjGvHxZH9VLirOftQY569EKNsZQM+kcdwrM9evisHZ9eMKCRa5
 7awMMMVdoXGkqrJE89Az7+AE6wYbXWde5JgOrVUOU+cGLYKIEBhfAVdF8x1GvsstSpr8
 UpfPsin7LpobxOCWzROhBT67PXjCCFFQf2R/iftFowaIYWmWEhVQUlR219WItBxynEih
 3pnMHMPSevlyNdAsE/JpfpEA6Dr/xa36OzSUl33zzs2NhGRFg6yAkBdVBstCDuJ5QEgR
 xo7tcCcV+ds4M/qOEzrPtJ0LVU5G4hWu651x/WkUMSjNN6Gi503ECBQFZhqtrusVHtN+ rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 387tuurs16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Apr 2021 06:43:52 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13TAYmcS035918;
        Thu, 29 Apr 2021 06:43:51 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 387tuurs0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Apr 2021 06:43:51 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13TAcPok013221;
        Thu, 29 Apr 2021 10:43:49 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 384ay8say6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Apr 2021 10:43:48 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13TAhLH628770636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 10:43:21 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7F775204E;
        Thu, 29 Apr 2021 10:43:45 +0000 (GMT)
Received: from localhost (unknown [9.85.71.45])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6719152051;
        Thu, 29 Apr 2021 10:43:45 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, harshadshirwadkar@gmail.com,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH] ext4: Fix accessing uninit percpu counter variable with fast_commit
Date:   Thu, 29 Apr 2021 16:13:44 +0530
Message-Id: <6cceb9a75c54bef8fa9696c1b08c8df5ff6169e2.1619692410.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: c1Bv-rcGWFRN4y1Ik9le-aiNj60sw0er
X-Proofpoint-ORIG-GUID: VJyeSBY-WM9nJxKXgFudmoVAT0pbavMN
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-29_06:2021-04-28,2021-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104290070
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When running generic/527 with fast_commit configuration, below issue is
seen on Power.
With fast_commit, during ext4_fc_replay() (which can be called from
ext4_fill_super()), if inode eviction happens then it can access an
uninitialized percpu counter variable.

This patch adds the check b4 accessing the counters in ext4_free_inode() path.

[  321.165371] run fstests generic/527 at 2021-04-29 08:38:43
[  323.027786] EXT4-fs (dm-0): mounted filesystem with ordered data mode. Opts: block_validity. Quota mode: none.
[  323.618772] BUG: Unable to handle kernel data access on read at 0x1fbd80000
[  323.619767] Faulting instruction address: 0xc000000000bae78c
cpu 0x1: Vector: 300 (Data Access) at [c000000010706ef0]
    pc: c000000000bae78c: percpu_counter_add_batch+0x3c/0x100
    lr: c0000000006d0bb0: ext4_free_inode+0x780/0xb90
    pid   = 5593, comm = mount
	ext4_free_inode+0x780/0xb90
	ext4_evict_inode+0xa8c/0xc60
	evict+0xfc/0x1e0
	ext4_fc_replay+0xc50/0x20f0
	do_one_pass+0xfe0/0x1350
	jbd2_journal_recover+0x184/0x2e0
	jbd2_journal_load+0x1c0/0x4a0
	ext4_fill_super+0x2458/0x4200
	mount_bdev+0x1dc/0x290
	ext4_mount+0x28/0x40
	legacy_get_tree+0x4c/0xa0
	vfs_get_tree+0x4c/0x120
	path_mount+0xcf8/0xd70
	do_mount+0x80/0xd0
	sys_mount+0x3fc/0x490
	system_call_exception+0x384/0x3d0
	system_call_common+0xec/0x278

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/ialloc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 755a68bb7e22..e4a92642e487 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -322,14 +322,16 @@ void ext4_free_inode(handle_t *handle, struct inode *inode)
 	if (is_directory) {
 		count = ext4_used_dirs_count(sb, gdp) - 1;
 		ext4_used_dirs_set(sb, gdp, count);
-		percpu_counter_dec(&sbi->s_dirs_counter);
+		if (percpu_counter_initialized(&sbi->s_dirs_counter))
+			percpu_counter_dec(&sbi->s_dirs_counter);
 	}
 	ext4_inode_bitmap_csum_set(sb, block_group, gdp, bitmap_bh,
 				   EXT4_INODES_PER_GROUP(sb) / 8);
 	ext4_group_desc_csum_set(sb, block_group, gdp);
 	ext4_unlock_group(sb, block_group);

-	percpu_counter_inc(&sbi->s_freeinodes_counter);
+	if (percpu_counter_initialized(&sbi->s_freeinodes_counter))
+		percpu_counter_inc(&sbi->s_freeinodes_counter);
 	if (sbi->s_log_groups_per_flex) {
 		struct flex_groups *fg;

--
2.30.2

