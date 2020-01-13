Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9891138FB5
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2020 12:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgAMLEc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Jan 2020 06:04:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46514 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725992AbgAMLEc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 13 Jan 2020 06:04:32 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00DAvkSD121645
        for <linux-ext4@vger.kernel.org>; Mon, 13 Jan 2020 06:04:30 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xfbs7n5d6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Mon, 13 Jan 2020 06:04:30 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Mon, 13 Jan 2020 11:04:28 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 13 Jan 2020 11:04:26 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00DB3a2B35127708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 11:03:37 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 535874204C;
        Mon, 13 Jan 2020 11:04:25 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B27F42045;
        Mon, 13 Jan 2020 11:04:24 +0000 (GMT)
Received: from dhcp-9-199-159-93.in.ibm.com (unknown [9.199.159.93])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 13 Jan 2020 11:04:24 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 0/2] ext4: Fix stale data read exposure problem with DIO read/page_mkwrite
Date:   Mon, 13 Jan 2020 16:34:20 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20011311-0020-0000-0000-000003A034CA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011311-0021-0000-0000-000021F7A37B
Message-Id: <cover.1578907890.git.riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_03:2020-01-13,2020-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=969 suspectscore=0 adultscore=0
 clxscore=1011 bulkscore=0 malwarescore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001130094
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello All, 

Sorry for the delay on this patchset. I guess it's because there were
lot of other context switches while working at it.

Please note that this is a RFC patch and also a WIP (due to a open problem
listed below).
There is also another thread going on where making dioread_nolock as default
mount opt [1] is being discussed. That approach should also solve the given
race at hand. But since nothing is finalized yet, so I wanted to get this patch
out for early review/discussion.

About patch
===========

Currently there is a small race window as pointed out by Jan [2] where, when
ext4 tries to allocate a written block for mapped files and if DIO read is in
progress, then this may result into stale data read exposure problem.

This patch tries to fix the mentioned issue by:
1. For non-delalloc path, page_mkwrite will use unwritten blocks by
   default for extent based files.

2. For delalloc path, we check if DIO is in progress during writeback.
   If yes, then we use unwritten blocks method to avoid this race.

Patch-1: This moves the inode_dio_begin() call before calling for
filemap_write_and_wait_range.

Patch-2: This implementes the points (1) & (2) mentioned above.

Testing:
========
xfstests "-g auto" ran fine except one warn_on issue.

Below tests are giving kernel WARN_ON from "ext4_journalled_invalidatepage()",
with 1024 blocksize, 4K pagesize & with "nodelalloc,data=journal" mount opt.
- generic/013, generic/269, generic/270

In case if someone has any pointers around this, I could dig more deeper into
this. 

References
==========
[1] https://www.spinics.net/lists/linux-ext4/msg69224.html
[2] https://lore.kernel.org/linux-ext4/20190926134726.GA28555@quack2.suse.cz/ 


Ritesh Harjani (2):
  iomap: direct-io: Move inode_dio_begin before
    filemap_write_and_wait_range
  ext4: Fix stale data read issue with DIO read & ext4_page_mkwrite path

 fs/ext4/inode.c      | 45 +++++++++++++++++++++++++++++++-------------
 fs/iomap/direct-io.c | 17 +++++++++++++----
 2 files changed, 45 insertions(+), 17 deletions(-)

-- 
2.21.0

