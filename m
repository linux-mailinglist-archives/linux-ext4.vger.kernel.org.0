Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0479760776
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jul 2019 16:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfGEOKU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Jul 2019 10:10:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52808 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbfGEOKU (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 5 Jul 2019 10:10:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6D943308427C;
        Fri,  5 Jul 2019 14:10:04 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (ovpn-116-58.sin2.redhat.com [10.67.116.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29EDC860E4;
        Fri,  5 Jul 2019 14:09:22 +0000 (UTC)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     dm-devel@redhat.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org,
        qemu-devel@nongnu.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Cc:     dan.j.williams@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com,
        jasowang@redhat.com, willy@infradead.org, rjw@rjwysocki.net,
        hch@infradead.org, lenb@kernel.org, jack@suse.cz, tytso@mit.edu,
        adilger.kernel@dilger.ca, darrick.wong@oracle.com,
        lcapitulino@redhat.com, kwolf@redhat.com, imammedo@redhat.com,
        jmoyer@redhat.com, nilal@redhat.com, riel@surriel.com,
        stefanha@redhat.com, aarcange@redhat.com, david@redhat.com,
        david@fromorbit.com, cohuck@redhat.com,
        xiaoguangrong.eric@gmail.com, pagupta@redhat.com,
        pbonzini@redhat.com, yuval.shaia@oracle.com, kilobyte@angband.pl,
        jstaron@google.com, rdunlap@infradead.org, snitzer@redhat.com
Subject: [PATCH v15 6/7] ext4: disable map_sync for async flush
Date:   Fri,  5 Jul 2019 19:33:27 +0530
Message-Id: <20190705140328.20190-7-pagupta@redhat.com>
In-Reply-To: <20190705140328.20190-1-pagupta@redhat.com>
References: <20190705140328.20190-1-pagupta@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 05 Jul 2019 14:10:19 +0000 (UTC)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Dont support 'MAP_SYNC' with non-DAX files and DAX files
with asynchronous dax_device. Virtio pmem provides
asynchronous host page cache flush mechanism. We don't
support 'MAP_SYNC' with virtio pmem and ext4.

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/file.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 98ec11f69cd4..dee549339e13 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -360,15 +360,17 @@ static const struct vm_operations_struct ext4_file_vm_ops = {
 static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct inode *inode = file->f_mapping->host;
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct dax_device *dax_dev = sbi->s_daxdev;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+	if (unlikely(ext4_forced_shutdown(sbi)))
 		return -EIO;
 
 	/*
-	 * We don't support synchronous mappings for non-DAX files. At least
-	 * until someone comes with a sensible use case.
+	 * We don't support synchronous mappings for non-DAX files and
+	 * for DAX files if underneath dax_device is not synchronous.
 	 */
-	if (!IS_DAX(file_inode(file)) && (vma->vm_flags & VM_SYNC))
+	if (!daxdev_mapping_supported(vma, dax_dev))
 		return -EOPNOTSUPP;
 
 	file_accessed(file);
-- 
2.20.1

