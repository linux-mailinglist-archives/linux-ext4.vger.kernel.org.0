Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09E11AF6D6
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Apr 2020 06:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgDSEqT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 Apr 2020 00:46:19 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40704 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725763AbgDSEqS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 19 Apr 2020 00:46:18 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 03J4kCT4021519
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Apr 2020 00:46:13 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A725642013B; Sun, 19 Apr 2020 00:46:12 -0400 (EDT)
Date:   Sun, 19 Apr 2020 00:46:12 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] ext4: validate fiemap iomap begin offset and length value
Message-ID: <20200419044612.GB311394@mit.edu>
References: <20200418233231.z767yvfiupy7hwgp@xzhoux.usersys.redhat.com>
 <20200419015654.F2061A4051@d06av23.portsmouth.uk.ibm.com>
 <20200419044224.GA311394@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419044224.GA311394@mit.edu>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Apr 19, 2020 at 12:42:24AM -0400, Theodore Y. Ts'o wrote:
> I think we need to take his patch, and make a simialr change to
> ext4_iomap_begin().   Ritesh, do you agree?

For example...

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2a4aae6acdcb..adce3339d697 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3424,8 +3424,10 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	int ret;
 	struct ext4_map_blocks map;
 	u8 blkbits = inode->i_blkbits;
+	ext4_lblk_t lblk = offset >> blkbits;
+	ext4_lblk_t last_lblk = (offset + length - 1) >> blkbits;
 
-	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
+	if (lblk > EXT4_MAX_LOGICAL_BLOCK)
 		return -EINVAL;
 
 	if (WARN_ON_ONCE(ext4_has_inline_data(inode)))
@@ -3434,9 +3436,15 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	/*
 	 * Calculate the first and last logical blocks respectively.
 	 */
-	map.m_lblk = offset >> blkbits;
-	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
-			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
+	if (last_lblk >= EXT4_MAX_LOGICAL_BLOCK)
+		last_lblk = EXT4_MAX_LOGICAL_BLOCK - 1;
+	if (lblk >= EXT4_MAX_LOGICAL_BLOCK)
+		lblk = EXT4_MAX_LOGICAL_BLOCK - 1;
+
+	map.m_lblk = lblk;
+	map.m_len = last_lblk - lblk + 1;
+	if (map.m_len == 0 )
+		map.m_len = 1;
 
 	if (flags & IOMAP_WRITE)
 		ret = ext4_iomap_alloc(inode, &map, flags);
@@ -3524,8 +3532,10 @@ static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
 	bool delalloc = false;
 	struct ext4_map_blocks map;
 	u8 blkbits = inode->i_blkbits;
+	ext4_lblk_t lblk = offset >> blkbits;
+	ext4_lblk_t last_lblk = (offset + length - 1) >> blkbits;
 
-	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
+	if (lblk > EXT4_MAX_LOGICAL_BLOCK)
 		return -EINVAL;
 
 	if (ext4_has_inline_data(inode)) {
@@ -3540,9 +3550,15 @@ static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
 	/*
 	 * Calculate the first and last logical block respectively.
 	 */
-	map.m_lblk = offset >> blkbits;
-	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
-			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
+	if (last_lblk >= EXT4_MAX_LOGICAL_BLOCK)
+		last_lblk = EXT4_MAX_LOGICAL_BLOCK - 1;
+	if (lblk >= EXT4_MAX_LOGICAL_BLOCK)
+		lblk = EXT4_MAX_LOGICAL_BLOCK - 1;
+
+	map.m_lblk = lblk;
+	map.m_len = last_lblk - lblk + 1;
+	if (map.m_len == 0 )
+		map.m_len = 1;
 
 	/*
 	 * Fiemap callers may call for offset beyond s_bitmap_maxbytes.
