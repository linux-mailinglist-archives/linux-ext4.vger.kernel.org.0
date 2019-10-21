Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66990DE7D6
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2019 11:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfJUJSf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Oct 2019 05:18:35 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42360 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfJUJSf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Oct 2019 05:18:35 -0400
Received: by mail-pl1-f196.google.com with SMTP id c16so2576933plz.9
        for <linux-ext4@vger.kernel.org>; Mon, 21 Oct 2019 02:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1pJVjMi2M0WiIX7tanRv1QumHpvd2YITa3EWIKSYzT4=;
        b=v2WZxYreX0Hy0Ie1QtRqpucc5YVFJXH6zRRlAMqUPIChqGPHKYOyIon9Hsh1EKaM1e
         pZwoJ+4CO6Femwn2FgSV7h4Y/Z3Wwt/BhP2O/rqYj2ICMXWlPo3dkEhfT6JHttkOltEZ
         nIjs4CCrd7mQGUn+noJoOewRn7ktHuh+KEoVbaqZ91twWgUFH9MynyLeCFwSyY9bF7dD
         tBTuVSUZN36ZFZ/Z5Zxn7XpsWYtqkGw9/EXxZreLB73ETF2aJz5uZi3aXpMGHJIM7vgr
         RojZLsH3D+aaS7T5rt+CZc64QiMRKGDk4LoE8Z5/ZoFDvFYF/1tZvgIXavzsFuxnLPwl
         la9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1pJVjMi2M0WiIX7tanRv1QumHpvd2YITa3EWIKSYzT4=;
        b=p8QvaNHd6dpF0TQV666sH38iLc++uUGFsNwZIIwXN9P+YGaBfU74HGygLvUHAedPYh
         35658UCbXw8h7KktJcfiLZGpjaI+025Hc6yeuM6SyEDWuuHc4QTBnAsb9oxGBpBkbDT/
         X89T4zcTLaNlkHrJYmdSZ7OUA9R+xyDTHgP/c2pCXGFMXrA2CL6IlPEuJPENDCMFINkg
         k/tLbwpI0SQlKsylSxB2omCFS+ZgeOYgPW7bD9wzHCrSJwgRyO6EhYr/RGWT2aTZDsIA
         Pduzovn7eHKQ+W5/aXiFETmdT9jjIZXBk3hpRiOqDr43yZM8faA+PVT2N96Z4vgV46tV
         J84g==
X-Gm-Message-State: APjAAAXD6VqVZZhGBbjLEu+eNFNNykcpEU7KXgenINDRICt22WX9XdWO
        0ii9SJUQ4XUCm3Zg6vTbWEza
X-Google-Smtp-Source: APXvYqyyCzn8BEzXGW/AKafjzMn7+ovt4ch62BSkyFDtAXWyrCrzxAqu1v4Avz6lDKHi7YeGF9sSZw==
X-Received: by 2002:a17:902:8bc7:: with SMTP id r7mr24160232plo.333.1571649513991;
        Mon, 21 Oct 2019 02:18:33 -0700 (PDT)
Received: from athena.bobrowski.net (n1-41-199-60.bla2.nsw.optusnet.com.au. [1.41.199.60])
        by smtp.gmail.com with ESMTPSA id w6sm17042420pfj.17.2019.10.21.02.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 02:18:33 -0700 (PDT)
Date:   Mon, 21 Oct 2019 20:18:27 +1100
From:   mbobrowski@mbobrowski.org
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: [PATCH v5 06/12] xfs: Use iomap_dio_rw_wait()
Message-ID: <78aac4cedf43825b3535a0d35dbba179ecbdffeb.1571647179.git.mbobrowski@mbobrowski.org>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571647178.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Use iomap_dio_rw() to wait for unaligned direct IO instead of opencoding
the wait.

Signed-off-by: Jan Kara <jack@suse.cz>
---

This patch has already been posted through by Jan, but I've just
included it within this patch series to mark that it's a clear
dependency.

 fs/xfs/xfs_file.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 0739ba72a82e..c0620135a279 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -547,16 +547,12 @@ xfs_file_dio_aio_write(
 	}
 
 	trace_xfs_file_direct_write(ip, count, iocb->ki_pos);
-	ret = iomap_dio_rw(iocb, from, &xfs_iomap_ops, &xfs_dio_write_ops,
-			   is_sync_kiocb(iocb));
-
 	/*
-	 * If unaligned, this is the only IO in-flight. If it has not yet
-	 * completed, wait on it before we release the iolock to prevent
-	 * subsequent overlapping IO.
+	 * If unaligned, this is the only IO in-flight. Wait on it before we
+	 * release the iolock to prevent subsequent overlapping IO.
 	 */
-	if (ret == -EIOCBQUEUED && unaligned_io)
-		inode_dio_wait(inode);
+	ret = iomap_dio_rw(iocb, from, &xfs_iomap_ops, &xfs_dio_write_ops,
+			   is_sync_kiocb(iocb) || unaligned_io);
 out:
 	xfs_iunlock(ip, iolock);
 
-- 
2.20.1

--<M>--
