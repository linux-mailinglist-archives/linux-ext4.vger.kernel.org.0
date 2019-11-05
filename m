Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D862CEFCCD
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2019 12:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730900AbfKEL73 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Nov 2019 06:59:29 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35222 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730848AbfKEL73 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 Nov 2019 06:59:29 -0500
Received: by mail-pg1-f196.google.com with SMTP id q22so6370906pgk.2
        for <linux-ext4@vger.kernel.org>; Tue, 05 Nov 2019 03:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LcQBmC1CbJ1RDhTAUWqHhOSwn0GfYhx2KOpxTYNCMvg=;
        b=nPiHZ8jxM0wm48aejSLVJS+siylmp4UzJPTDZ0tM8pI1kBrxL+mTorpO1hXya2RnU5
         NDOl7ihkPddhpC3A3fGEG3HjokZgjfieDehIVEM9m4MiI2ChQrIVj089FWqqW4X24RRN
         j6Q/o3cARG6v3bcaDN3yWhvWounx8mVaHXMw+EQXemwL/HxMXdlw5cqLyPNdbEBNypvs
         D4G4YSp8+KdperEVTAD6/rrtbdBx6pnebGPBGTixbX6FvM739DVOIj1gOaG2eeVcDydF
         gwTmmqMs7rKp2W1yuntfL2ZKGzFtgVd4asoA6QMSyCUU4yF+K4Ialyi0JrN0Xsl0Fr6C
         chnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LcQBmC1CbJ1RDhTAUWqHhOSwn0GfYhx2KOpxTYNCMvg=;
        b=byWftw1yy49iEqkQRYkzNubruR0iQiMJzzYG8T6kRz3BnHV92Nryy2P5xkAZxNhu9F
         Jxb25ye7js8SD/gx7ekzMrmF+CZKymp7hBgmeGPKIC4QKWBySHUHdkwGpSjqL51b/ntx
         zaNvGtwQaUubiooyubUah+GpoOMHaZ1SUw9X9v8w4wHv5iZvzMmUjH6xUOd4umXmMzXQ
         D1eYfa09EXgl7W+Kp6v8rfyQld9vNErzX+CBzzqEJo0KJLit+zKnvzsLbGXvIZYHmeSW
         yBVAhJtyv/f6HpTrdXoYqA3sMWCzuuGkCaMt4emfAOnbdXHyoeDRKJNnfIbXh4s7tKhT
         hxZA==
X-Gm-Message-State: APjAAAWv+sjjizBDoR76Oa7qIa1kELR0qc7s/0TvGpI+/kax6HSU3/5i
        Wo4ZqasVY0WcrFwne8Owb7lbNVh27A==
X-Google-Smtp-Source: APXvYqxBk8sFHdjCziZsEkA4GQBpYmWh6FCuVbjKthvUyG44q3eE3nYGCpwaYtq7dWkBaOrzjRbc7g==
X-Received: by 2002:a17:90a:6d27:: with SMTP id z36mr6215476pjj.38.1572955168558;
        Tue, 05 Nov 2019 03:59:28 -0800 (PST)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id k20sm13102609pgn.40.2019.11.05.03.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 03:59:27 -0800 (PST)
Date:   Tue, 5 Nov 2019 22:59:22 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        riteshh@linux.ibm.com
Subject: [PATCH v7 02/11] ext4: update direct I/O read lock pattern for
 IOCB_NOWAIT
Message-ID: <c5d5e759f91747359fbd2c6f9a36240cf75ad79f.1572949325.git.mbobrowski@mbobrowski.org>
References: <cover.1572949325.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572949325.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch updates the lock pattern in ext4_direct_IO_read() to not
block on inode lock in cases of IOCB_NOWAIT direct I/O reads. The
locking condition implemented here is similar to that of 942491c9e6d6
("xfs: fix AIM7 regression").

Fixes: 16c54688592c ("ext4: Allow parallel DIO reads")
Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/inode.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e4b0722717b3..f33fa86fff67 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3881,7 +3881,13 @@ static ssize_t ext4_direct_IO_read(struct kiocb *iocb, struct iov_iter *iter)
 	 * writes & truncates and since we take care of writing back page cache,
 	 * we are protected against page writeback as well.
 	 */
-	inode_lock_shared(inode);
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!inode_trylock_shared(inode))
+			return -EAGAIN;
+	} else {
+		inode_lock_shared(inode);
+	}
+
 	ret = filemap_write_and_wait_range(mapping, iocb->ki_pos,
 					   iocb->ki_pos + count - 1);
 	if (ret)
-- 
2.20.1

