Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD96200575
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Jun 2020 11:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731874AbgFSJjt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Jun 2020 05:39:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21524 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729255AbgFSJjr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 19 Jun 2020 05:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592559586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=owa0qFAPsKpu74jXgvEbAGd5tDvX5jYwWR6WKxTC83E=;
        b=CzuMDJKrIk4NcOZh/icmX3Kuzi/b+3kayq7WRD0/HO22uZw6dJjERw5tdLkD1tfEkdL0W1
        aJTybG7PLn+r2nVQUKvhDTfPYBrSWQC3I4Uq2lsskm75po+wM/v2rmAOH3QpHY0Fjk+vdW
        0hqfGw2h4p7mV5YR9YCJsr9RTVh7vXw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-E2DQ6Q59N3WWMbSJVCOn4A-1; Fri, 19 Jun 2020 05:39:29 -0400
X-MC-Unique: E2DQ6Q59N3WWMbSJVCOn4A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE7B8107B265;
        Fri, 19 Jun 2020 09:39:26 +0000 (UTC)
Received: from max.home.com (unknown [10.40.195.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E9A15D9E8;
        Fri, 19 Jun 2020 09:39:18 +0000 (UTC)
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
Subject: [RFC PATCH 0/2] gfs2 readahead regression in v5.8-rc1
Date:   Fri, 19 Jun 2020 11:39:14 +0200
Message-Id: <20200619093916.1081129-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

can the two patches in this set still be considered for v5.8?

Commit d4388340ae0b ("fs: convert mpage_readpages to mpage_readahead")
which converts gfs2 and other filesystems to use the new ->readahead
address space operation is leading to deadlocks between the inode glocks
and page locks: ->readahead is called with the pages to readahead
already locked.  When gfs2_readahead then tries to lock the associated
inode glock, another process already holding the inode glock may be
trying to lock the same pages.

We could work around this in gfs by using a LM_FLAG_TRY lock in
->readahead for now.  The real reason for this deadlock is that gfs2
shouldn't be taking the inode glock in ->readahead in the first place
though, so I'd prefer to fix this "properly" instead.  Unfortunately,
this depends on a new IOCB_CACHED flag for generic_file_read_iter.

A previous version was posted in November:

https://lore.kernel.org/linux-fsdevel/20191122235324.17245-1-agruenba@redhat.com/

Thanks,
Andreas

Andreas Gruenbacher (2):
  fs: Add IOCB_CACHED flag for generic_file_read_iter
  gfs2: Rework read and page fault locking

 fs/gfs2/aops.c     | 27 ++------------------
 fs/gfs2/file.c     | 61 ++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/fs.h |  1 +
 mm/filemap.c       | 16 ++++++++++--
 4 files changed, 76 insertions(+), 29 deletions(-)


base-commit: af42d3466bdc8f39806b26f593604fdc54140bcb
-- 
2.26.2

