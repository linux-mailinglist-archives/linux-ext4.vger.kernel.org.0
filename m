Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E116A5291
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Feb 2023 06:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjB1FNg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Feb 2023 00:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjB1FNc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Feb 2023 00:13:32 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6ACC147
        for <linux-ext4@vger.kernel.org>; Mon, 27 Feb 2023 21:13:30 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 31S5DOrJ002520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 00:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1677561206; bh=nLztm898n4WV8BJn4dMNe0MEMUwkb/2JGezxEYn6LlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=BbBV6AUavANRH/Kn+zRLxIBC8TEQ0+mD3u5R/nFt2T41pHamTH8SxJXeQb2xDCbNp
         e23aZIGL3skObrcGZA44ct+EV9AJVsGGhjNBG7i+SatYn1LSjf7G+IGCUI16F15BE8
         nquTRe1ALne3+nbgDqq7QOrFg6F12HcAJzXF/o94fESfy2iE3WdJ794sbfoD99fQdB
         VIoZsH+pHdN5UUGIc2i3cazw5kRFcm6a9lEloOuRRDTgGGn2vCGuNHEId95TSKUob5
         f7A+y2lxtSWJYN1D8DEY4r/S8u4/pjet6wL4uKbRiFW2pVfYbL7onYlNEde28d+vE/
         YkRHE2uGvLgKw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3168F15C5827; Tue, 28 Feb 2023 00:13:24 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 4/7] ext4: Don't unlock page in ext4_bio_write_page()
Date:   Tue, 28 Feb 2023 00:13:16 -0500
Message-Id: <20230228051319.4085470-5-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230228051319.4085470-1-tytso@mit.edu>
References: <20230228051319.4085470-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Jan Kara <jack@suse.cz>

Do not unlock the written page in ext4_bio_write_page(). Instead leave
the page locked and unlock it in the callers. We'll need to keep the
page locked for data=journal writeback for a bit longer.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/inode.c   |  2 ++
 fs/ext4/page-io.c | 10 +++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5c1d1b0bf5ee..27a11bed897e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2076,6 +2076,7 @@ static int ext4_writepage(struct page *page,
 		return -ENOMEM;
 	}
 	ret = ext4_bio_write_page(&io_submit, page, len);
+	unlock_page(page);
 	ext4_io_submit(&io_submit);
 	/* Drop io_end reference we got from init */
 	ext4_put_io_end_defer(io_submit.io_end);
@@ -2110,6 +2111,7 @@ static int mpage_submit_page(struct mpage_da_data *mpd, struct page *page)
 	else
 		len = PAGE_SIZE;
 	err = ext4_bio_write_page(&mpd->io_submit, page, len);
+	unlock_page(page);
 	if (!err)
 		mpd->wbc->nr_to_write--;
 	mpd->first_page++;
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index beaec6d81074..3bc7c7c5b99d 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -500,7 +500,7 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 
 	/* Nothing to submit? Just unlock the page... */
 	if (!nr_to_submit)
-		goto unlock;
+		return 0;
 
 	bh = head = page_buffers(page);
 
@@ -548,7 +548,8 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 				}
 				bh = bh->b_this_page;
 			} while (bh != head);
-			goto unlock;
+
+			return ret;
 		}
 	}
 
@@ -564,7 +565,6 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 		io_submit_add_bh(io, inode,
 				 bounce_page ? bounce_page : page, bh);
 	} while ((bh = bh->b_this_page) != head);
-unlock:
-	unlock_page(page);
-	return ret;
+
+	return 0;
 }
-- 
2.31.0

