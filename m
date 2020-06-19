Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8864200574
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Jun 2020 11:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731924AbgFSJjt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Jun 2020 05:39:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47271 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731369AbgFSJjs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 19 Jun 2020 05:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592559586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lrk5imypRvlh6Xm/35IKdaRrF7e1DPYFegz850ZqocU=;
        b=Ct+O4on4TZ8YUaTjf34acZCB0jrgMlFDiwN0/KD16r55wbBTVVsOgw8m3tV5LaYSTLkjHn
        RNIjcfv+NrW7VlEcqXWsm50So+wFD6gO2u5M/B9CA6DESEGIJPCGL+AULOAgc3TkeTxnG5
        Uru9hMyLX5rp790drHUAWKtGM4Yd+2s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-jYi5da2QMoKUefxLZ_07RQ-1; Fri, 19 Jun 2020 05:39:43 -0400
X-MC-Unique: jYi5da2QMoKUefxLZ_07RQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7066107B274;
        Fri, 19 Jun 2020 09:39:40 +0000 (UTC)
Received: from max.home.com (unknown [10.40.195.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 494C05D9CA;
        Fri, 19 Jun 2020 09:39:35 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, ocfs2-devel@oss.oracle.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] gfs2: Rework read and page fault locking
Date:   Fri, 19 Jun 2020 11:39:16 +0200
Message-Id: <20200619093916.1081129-3-agruenba@redhat.com>
In-Reply-To: <20200619093916.1081129-1-agruenba@redhat.com>
References: <20200619093916.1081129-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The cache consistency model of filesystems like gfs2 is such that if
data is found in the page cache, the data is up to date and can be used
without taking any filesystem locks.  If a page is not cached,
filesystem locks must be taken before populating the page cache.

Thus far,  gfs2 has taken the filesystem locks inside the ->readpage and
->readpages address space operations.  This was already causing lock
ordering problems, but commit d4388340ae0b ("fs: convert mpage_readpages
to mpage_readahead") made things worse: the ->readahead operation is
called with the pages to readahead locked, so grabbing the inode's glock
can now deadlock with processes which are holding the inode glock while
trying to lock the same pages.

Fix this by taking the inode glock in the ->read_iter file and ->fault
vm operations.  To avoid taking the inode glock when the data is already
cached, the ->read_iter file operation first tries to read the data with
the IOCB_CACHED flag set.  If that fails, the inode glock is locked and
the operation is repeated without the IOCB_CACHED flag.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/aops.c | 27 ++--------------------
 fs/gfs2/file.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 61 insertions(+), 27 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 72c9560f4467..73c2fe768a3f 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -513,26 +513,10 @@ static int __gfs2_readpage(void *file, struct page *page)
 
 static int gfs2_readpage(struct file *file, struct page *page)
 {
-	struct address_space *mapping = page->mapping;
-	struct gfs2_inode *ip = GFS2_I(mapping->host);
-	struct gfs2_holder gh;
 	int error;
 
-	unlock_page(page);
-	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
-	error = gfs2_glock_nq(&gh);
-	if (unlikely(error))
-		goto out;
-	error = AOP_TRUNCATED_PAGE;
-	lock_page(page);
-	if (page->mapping == mapping && !PageUptodate(page))
-		error = __gfs2_readpage(file, page);
-	else
-		unlock_page(page);
-	gfs2_glock_dq(&gh);
-out:
-	gfs2_holder_uninit(&gh);
-	if (error && error != AOP_TRUNCATED_PAGE)
+	error = __gfs2_readpage(file, page);
+	if (error)
 		lock_page(page);
 	return error;
 }
@@ -598,16 +582,9 @@ static void gfs2_readahead(struct readahead_control *rac)
 {
 	struct inode *inode = rac->mapping->host;
 	struct gfs2_inode *ip = GFS2_I(inode);
-	struct gfs2_holder gh;
 
-	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
-	if (gfs2_glock_nq(&gh))
-		goto out_uninit;
 	if (!gfs2_is_stuffed(ip))
 		mpage_readahead(rac, gfs2_block_map);
-	gfs2_glock_dq(&gh);
-out_uninit:
-	gfs2_holder_uninit(&gh);
 }
 
 /**
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index fe305e4bfd37..f729b0ff2a3c 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -558,8 +558,29 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 	return block_page_mkwrite_return(ret);
 }
 
+static vm_fault_t gfs2_fault(struct vm_fault *vmf)
+{
+	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct gfs2_inode *ip = GFS2_I(inode);
+	struct gfs2_holder gh;
+	vm_fault_t ret;
+	int err;
+
+	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
+	err = gfs2_glock_nq(&gh);
+	if (err) {
+		ret = block_page_mkwrite_return(err);
+		goto out_uninit;
+	}
+	ret = filemap_fault(vmf);
+	gfs2_glock_dq(&gh);
+out_uninit:
+	gfs2_holder_uninit(&gh);
+	return ret;
+}
+
 static const struct vm_operations_struct gfs2_vm_ops = {
-	.fault = filemap_fault,
+	.fault = gfs2_fault,
 	.map_pages = filemap_map_pages,
 	.page_mkwrite = gfs2_page_mkwrite,
 };
@@ -824,15 +845,51 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
 
 static ssize_t gfs2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
+	struct gfs2_inode *ip;
+	struct gfs2_holder gh;
+	size_t written = 0;
 	ssize_t ret;
 
+	gfs2_holder_mark_uninitialized(&gh);
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		ret = gfs2_file_direct_read(iocb, to);
 		if (likely(ret != -ENOTBLK))
 			return ret;
 		iocb->ki_flags &= ~IOCB_DIRECT;
 	}
-	return generic_file_read_iter(iocb, to);
+	iocb->ki_flags |= IOCB_CACHED;
+	ret = generic_file_read_iter(iocb, to);
+	iocb->ki_flags &= ~IOCB_CACHED;
+	if (ret >= 0) {
+		if (!iov_iter_count(to))
+			return ret;
+		written = ret;
+	} else {
+		switch(ret) {
+		case -EAGAIN:
+			if (iocb->ki_flags & IOCB_NOWAIT)
+				return ret;
+			break;
+		case -ECANCELED:
+			break;
+		default:
+			return ret;
+		}
+	}
+	ip = GFS2_I(iocb->ki_filp->f_mapping->host);
+	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
+	ret = gfs2_glock_nq(&gh);
+	if (ret)
+		goto out_uninit;
+	ret = generic_file_read_iter(iocb, to);
+	if (ret > 0)
+		written += ret;
+	if (gfs2_holder_initialized(&gh))
+		gfs2_glock_dq(&gh);
+out_uninit:
+	if (gfs2_holder_initialized(&gh))
+		gfs2_holder_uninit(&gh);
+	return written ? written : ret;
 }
 
 /**
-- 
2.26.2

