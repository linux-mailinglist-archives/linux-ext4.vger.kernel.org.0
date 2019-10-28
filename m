Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D48DE6FE4
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Oct 2019 11:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388328AbfJ1KvC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Oct 2019 06:51:02 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41290 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388321AbfJ1KvB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Oct 2019 06:51:01 -0400
Received: by mail-pf1-f194.google.com with SMTP id p26so2507799pfq.8
        for <linux-ext4@vger.kernel.org>; Mon, 28 Oct 2019 03:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=adn4gOH9wM1yK1i3uZc/QwdCwMT/Epp1BBGQLJPWPVM=;
        b=G9Md5Kat3ZszJ6WvVofzucKe1kR+H5u+O0+UtzEYZIgJOgKbina+CIMx7USP3hYliB
         5f+BUq26w57DXOCHzwjIe9LuGD+6Bu2VqhuJI+K2dRDNX1FNYQ/sgBuk0wP0m1JwOaCZ
         vOko0PQBkDVdh5mekf6tVVelrUCXtjEhT1AHa5Z/tfHx5VlMEpRkPqD865pdlyCbxsI+
         yVPyYnTzTnzlqh/2iwK7Ccm0dS2ijXW4ilvpsHClehDQw0vy5gkDM5Ha8KfdUbyEG2o4
         TQG8wHL2YgziVGM83VU+gFjg7czeqAN0AhzeLaMDix+EB7Sjh85rPKeJqvNMY1zvK2EG
         Dduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=adn4gOH9wM1yK1i3uZc/QwdCwMT/Epp1BBGQLJPWPVM=;
        b=VO9gWiIA8UFODFG1hbLD2b0FyLcJP7WcUuh4ILvaom/Q9+RYRfyb0Mfien43AZhgPY
         2z0NOaecOiDQPI8j7lyXuH7DbFXtngu15GbXobNXuWSYT+sZ4GIHELnYXjeMn4HaIpNA
         rO2bkzUzMll1f2m7oacvc59/G8oUcg5/PsdhNI58x3Q5rpARoGCPBOJLvK6U07kSc5rU
         JY3hGM39QJVG7Qzivz27i+p9Bs0vXCBsBr4Map5cBOVKzTQGxslqh9CXNbruDl1Anx6Q
         cbuJuoacXwfSW8mktZZhURy4IWf7h8M8Z6h2N+2+liMXF5usmnGAfVcvLeztG4cw/IQ4
         S2qg==
X-Gm-Message-State: APjAAAWx2s8uZYS7Tel57lKLoJOP8kk7D/3H4ratLuDVWgGPe/5RbDPg
        5D67kRbfaEspVYB0d9RDKvgP
X-Google-Smtp-Source: APXvYqxxGA+x43l4hHBehKoNsCBRa2AermBDxa/8TQql01AraTK0RxXJ7Iu0d7PBH7mRoW5CoEHAYQ==
X-Received: by 2002:a62:5ac3:: with SMTP id o186mr19860150pfb.20.1572259861132;
        Mon, 28 Oct 2019 03:51:01 -0700 (PDT)
Received: from poseidon.bobrowski.net (d114-78-127-22.bla803.nsw.optusnet.com.au. [114.78.127.22])
        by smtp.gmail.com with ESMTPSA id 21sm2820419pfa.170.2019.10.28.03.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 03:51:00 -0700 (PDT)
Date:   Mon, 28 Oct 2019 21:50:54 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: [PATCH v6 02/11] ext4: update direct I/O read lock pattern for
 IOCB_NOWAIT
Message-ID: <17824b863511c87c3b4ea36531ca3c1430d30660.1572255425.git.mbobrowski@mbobrowski.org>
References: <cover.1572255424.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572255424.git.mbobrowski@mbobrowski.org>
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
index ee116344c420..0a9ea291cfab 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3837,7 +3837,13 @@ static ssize_t ext4_direct_IO_read(struct kiocb *iocb, struct iov_iter *iter)
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

