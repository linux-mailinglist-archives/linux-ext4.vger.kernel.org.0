Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C402689ECE
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Aug 2019 14:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfHLMwn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Aug 2019 08:52:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39212 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfHLMwn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Aug 2019 08:52:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so49429662pgi.6
        for <linux-ext4@vger.kernel.org>; Mon, 12 Aug 2019 05:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gPjaH2fUTTn2N9Byg8b2jgMVfdxwJ42T3PCavreKxJs=;
        b=MYGIotYHwCklC0ZcqBySvuLpu+hiUBefSuzXd+5v5LxQDt+iXxdLZLMz+Qnlm/nHIC
         19TuRpu9auup7t6XgghwXNAgc5KNCUvjIViVXfLMrQKRuWeTi0Ijt2KS0R2hY5Rzy7A0
         aijLeKfBWlI4XaZcb8oPb8jFfwhaVti5iRpVLpWVJPkIsz/Te7p46T9pXLiR9oQkqkhj
         4Rz/zv9T6OT/TUcJ/TQ3ZgW+ggbrMXUbPJy8tKAKmt+rhbBYrfRQFUivKbpWcHKJFOwj
         GJFgBaBRjiCM2lcS3AW/NVnDUkDVc/29We2hmW0eRAe28/nS8yTaiNh/D9GDKJNqGDbH
         qUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gPjaH2fUTTn2N9Byg8b2jgMVfdxwJ42T3PCavreKxJs=;
        b=VLKSllWAWng+ovLffrBqESCaSS1BRk+I2c1XeP9lHGEMtWnwNXkQUlB3Uu0hILWVdp
         NqDABRcyZDm/C/g3AS9zd3b6zC4xhvoJ5D2z6uI3KzvI/WsaJEyN6rNta/7LuUqnEggr
         aIDXGcUGfgfc1rpsu/Q0Evwx5uqYisSA+kBOn5gRwZZxD96phv3dNNUhQsirNdvCj18s
         gCksiabBRNAPHIzkZfRR+cSvyDzRqQtptcb9LwT4NTObKIf//Qw9gFGzY+kSzBunxM9M
         g91AR2haDkTtwi/lVgQqh2VEG3rIGcEWd79phym76E7ucmC420Xe3xF4egej/um02kha
         zotw==
X-Gm-Message-State: APjAAAXTyT4aaaP8czlD/K3eYU1bWf6464nAH3XJCAeOtdWjsc6M6LtA
        jAdOWiqte2+fA76HrGQrlfuPtKvc7g==
X-Google-Smtp-Source: APXvYqxj+ur625Lz7Nx3k2CIuDCZ5ucZJUzNFowTkJdbk+Vrc2WhK55xRs2jvZxK691T0cZp0kjPdQ==
X-Received: by 2002:a63:d301:: with SMTP id b1mr29642686pgg.379.1565614362028;
        Mon, 12 Aug 2019 05:52:42 -0700 (PDT)
Received: from neo.home (n1-42-37-191.mas1.nsw.optusnet.com.au. [1.42.37.191])
        by smtp.gmail.com with ESMTPSA id w129sm3522432pfd.89.2019.08.12.05.52.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 05:52:41 -0700 (PDT)
Date:   Mon, 12 Aug 2019 22:52:35 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        riteshh@linux.ibm.com
Subject: [PATCH 1/5] ext4: introduce direct IO read code path using iomap
 infrastructure
Message-ID: <3e83a70c4442c6aeb15b7913c39f853e7386a3c3.1565609891.git.mbobrowski@mbobrowski.org>
References: <cover.1565609891.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1565609891.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch introduces a new direct IO read code path implementation
that makes use of the iomap infrastructure.

The new function ext4_dio_read_iter() is responsible for calling into the
iomap infrastructure via iomap_dio_rw(). If the inode in question does not
pass preliminary checks in ext4_dio_checks(), then we simply fallback to
buffered IO and try to take that path. Prior to doing so, we drop the
IOCB_DIRECT flag from iocb->ki_flags to prevent generic_file_read_iter() from
taking the direct IO code path once again.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
---
 fs/ext4/file.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 70b0438dbc94..360eff7b6aa2 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -34,6 +34,53 @@
 #include "xattr.h"
 #include "acl.h"
 
+static bool ext4_dio_checks(struct inode *inode)
+{
+#ifdef CONFIG_FS_ENCRYPTION
+	if (IS_ENCRYPTED(inode))
+		return false;
+#endif
+	if (ext4_should_journal_data(inode))
+		return false;
+	if (ext4_has_inline_data(inode))
+		return false;
+	return true;
+}
+
+static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	ssize_t ret;
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	/*
+	 * Get exclusion from truncate and other inode operations.
+	 */
+	if (!inode_trylock_shared(inode)) {
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			return -EAGAIN;
+		inode_lock_shared(inode);
+	}
+
+	if (!ext4_dio_checks(inode)) {
+		inode_unlock_shared(inode);
+		/*
+		 * Fallback to buffered IO if the operation being
+		 * performed on the inode is not supported by direct
+		 * IO. The IOCB_DIRECT flag from iocb->ki_flags needs
+		 * to be cleared here to ensure that the direct IO
+		 * code path in generic_file_read_iter() is not taken.
+		 */
+		iocb->ki_flags &= ~IOCB_DIRECT;
+		return generic_file_read_iter(iocb, to);
+	}
+
+	ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL);
+	inode_unlock_shared(inode);
+
+	file_accessed(iocb->ki_filp);
+	return ret;
+}
+
 #ifdef CONFIG_FS_DAX
 static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
@@ -64,16 +111,20 @@ static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 static ssize_t ext4_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(file_inode(iocb->ki_filp)->i_sb))))
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
 		return -EIO;
 
 	if (!iov_iter_count(to))
 		return 0; /* skip atime */
 
 #ifdef CONFIG_FS_DAX
-	if (IS_DAX(file_inode(iocb->ki_filp)))
+	if (IS_DAX(inode))
 		return ext4_dax_read_iter(iocb, to);
 #endif
+	if (iocb->ki_flags & IOCB_DIRECT)
+		return ext4_dio_read_iter(iocb, to);
 	return generic_file_read_iter(iocb, to);
 }
 
-- 
2.16.4


-- 
Matthew Bobrowski
