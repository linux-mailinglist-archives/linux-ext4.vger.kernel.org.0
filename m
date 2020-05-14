Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5421D283B
	for <lists+linux-ext4@lfdr.de>; Thu, 14 May 2020 08:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgENGxV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 May 2020 02:53:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:2893 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbgENGxU (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 14 May 2020 02:53:20 -0400
IronPort-SDR: bVdYOmAc+ImvTljnNUu5s3lkNOFBoJnw+I2OwvzUOGRadX5xQ8QJaQFtJGIWA6ZruaYJi1R7tP
 nTvdvvYaFuWA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 23:53:20 -0700
IronPort-SDR: GQ1hzhuh/TPZ67YOSApRWHc8Iy7TvflZ/UemSyzmBNp7CscHHJ8BwECoY2udEzrOPjGg9J75Hd
 Rl8goN+obTIQ==
X-IronPort-AV: E=Sophos;i="5.73,390,1583222400"; 
   d="scan'208";a="297929571"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 23:53:19 -0700
From:   ira.weiny@intel.com
To:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Cc:     Ira Weiny <ira.weiny@intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V1 1/9] fs/ext4: Narrow scope of DAX check in setflags
Date:   Wed, 13 May 2020 23:53:07 -0700
Message-Id: <20200514065316.2500078-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200514065316.2500078-1-ira.weiny@intel.com>
References: <20200514065316.2500078-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

When preventing DAX and journaling on an inode.  Use the effective DAX
check rather than the mount option.

This will be required to support per inode DAX flags.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/ext4/ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index bfc1281fc4cb..5813e5e73eab 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -393,9 +393,9 @@ static int ext4_ioctl_setflags(struct inode *inode,
 	if ((jflag ^ oldflags) & (EXT4_JOURNAL_DATA_FL)) {
 		/*
 		 * Changes to the journaling mode can cause unsafe changes to
-		 * S_DAX if we are using the DAX mount option.
+		 * S_DAX if the inode is DAX
 		 */
-		if (test_opt(inode->i_sb, DAX)) {
+		if (IS_DAX(inode)) {
 			err = -EBUSY;
 			goto flags_out;
 		}
-- 
2.25.1

