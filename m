Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81D21183463
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Mar 2020 16:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgCLPTp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Mar 2020 11:19:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38480 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbgCLPTp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Mar 2020 11:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=39tT0OaEKs+SldBNXJomJ786zlNa0gY40ejPQEQMio4=; b=g4U/44sO4BPPbyhpZEzGz422ow
        RJ2+HAqJuUWeNdVmlczT3DYeTU9DXfSF1gNgVehKiY55UP2yAmsUi4lyoFzyqFjAU2hiuRM6VFql6
        K1Sr081QEobpqYGa3c28ajvEeN3UA5djaNaRIMI7LqHuPZ8niMaRZ9YY1VgyL2SJIt0F02Qp+l+5M
        mMO7jJO1oTLdGv4BcLALa6Sr5LHI9DlHuRBZhicTl4TlipKdN3PqSYIardmJr6ugOhWaZI1+MkDol
        QET92HOYtb2IQv69RmkDlhB0xOo4+dkQoE/AjrWpbZHLPsQykwgJ6Jf43h9mp+/qvjlc6zXqDEVSE
        wQO/idQA==;
Received: from [2001:4bb8:184:5cad:8026:d98c:a056:3e33] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCPce-0006UI-Kr; Thu, 12 Mar 2020 15:19:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-ext4@vger.kernel.org,
        reiserfs-devel@vger.kernel.org
Subject: [PATCH 01/21] block: remove the blk_lookup_devt export
Date:   Thu, 12 Mar 2020 16:19:19 +0100
Message-Id: <20200312151939.645254-2-hch@lst.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200312151939.645254-1-hch@lst.de>
References: <20200312151939.645254-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This function is only used by init/do_mounts.c, which can't be modular.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index ff6268970ddc..56e9547870ee 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1463,7 +1463,6 @@ dev_t blk_lookup_devt(const char *name, int partno)
 	class_dev_iter_exit(&iter);
 	return devt;
 }
-EXPORT_SYMBOL(blk_lookup_devt);
 
 struct gendisk *__alloc_disk_node(int minors, int node_id)
 {
-- 
2.24.1

