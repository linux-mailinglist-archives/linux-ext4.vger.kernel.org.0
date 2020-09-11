Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC06C26649B
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Sep 2020 18:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgIKQmu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Sep 2020 12:42:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31348 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726316AbgIKQl5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 11 Sep 2020 12:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599842516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dCCYRHJfCs9q7+pn8+1DMUQvWPREwMeHDgZW4MhyNFI=;
        b=B8PKEE/1gWxSFtGvpiobBIBjz4SOX/hs4EDvbr8KCcclvtf4meexZr3BPKSD6ax2mMOpMv
        BktVdQhESKtoMs+bPTxko0RaAX2DKqxpkZjAfTBKXoMRmKY8HGCZFhnru581Ty6bbdi1Hx
        pB6tKVnt3FW32iLHH8H9iQtc1Zcx5Zk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-ioDUguKaNDO_8rEqEDUcWA-1; Fri, 11 Sep 2020 12:41:51 -0400
X-MC-Unique: ioDUguKaNDO_8rEqEDUcWA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AB601084CA4;
        Fri, 11 Sep 2020 16:41:48 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 68F247B7D2;
        Fri, 11 Sep 2020 16:41:28 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 08BGfRwA030406;
        Fri, 11 Sep 2020 12:41:27 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 08BGfQ8M030402;
        Fri, 11 Sep 2020 12:41:26 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 11 Sep 2020 12:41:26 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>,
        Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [PATCH 2/2] xfs: don't update mtime on COW faults
In-Reply-To: <20200910060626.GA7964@magnolia>
Message-ID: <alpine.LRH.2.02.2009111232210.29958@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2009031328040.6929@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2009041200570.27312@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2009050805250.12419@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009050812060.12419@file01.intranet.prod.int.rdu2.redhat.com> <20200905153652.GA7955@magnolia> <alpine.LRH.2.02.2009051229180.542@file01.intranet.prod.int.rdu2.redhat.com> <20200910060626.GA7964@magnolia>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On Wed, 9 Sep 2020, Darrick J. Wong wrote:

> On Sat, Sep 05, 2020 at 01:02:33PM -0400, Mikulas Patocka wrote:
> > > > 
> > 
> > I've written this program that tests it - you can integrate it into your 
> > testsuite.
> 
> I don't get it.  You're a filesystem maintainer too, which means you're
> a regular contributor.  Do you:
> 
> (a) not use fstests?  If you don't, I really hope you use something else
> to QA hpfs.

I don't use xfstests on HPFS. I was testing it just by using it. Now I use 
it just a little, but I don't modify it much.

> (b) really think that it's my problem to integrate and submit your
> regression tests for you?
> 
> and (c) what do you want me to do with a piece of code that has no 
> signoff tag, no copyright, and no license?  This is your patch, and 
> therefore your responsibility to develop enough of an appropriate 
> regression test in a proper form that the rest of us can easily 
> determine we have the rights to contribute to it.


If you want a full patch (I copied the script from test 313), I send it 
here.

Mikulas


From: Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH] check ctime and mtime vs mmap

Check ctime and mtime are not updated on COW faults
and that they are updated on shared faults

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 src/Makefile          |    3 +-
 src/mmap-timestamp.c  |   53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/609     |   40 +++++++++++++++++++++++++++++++++++++
 tests/generic/609.out |    2 +
 tests/generic/group   |    1 
 5 files changed, 98 insertions(+), 1 deletion(-)

Index: xfstests-dev/src/Makefile
===================================================================
--- xfstests-dev.orig/src/Makefile	2020-09-06 12:38:40.000000000 +0200
+++ xfstests-dev/src/Makefile	2020-09-11 17:39:04.000000000 +0200
@@ -17,7 +17,8 @@ TARGETS = dirstress fill fill2 getpagesi
 	t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_write_ro \
 	t_ext4_dax_journal_corruption t_ext4_dax_inline_corruption \
 	t_ofd_locks t_mmap_collision mmap-write-concurrent \
-	t_get_file_time t_create_short_dirs t_create_long_dirs
+	t_get_file_time t_create_short_dirs t_create_long_dirs \
+	mmap-timestamp
 
 LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
Index: xfstests-dev/src/mmap-timestamp.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ xfstests-dev/src/mmap-timestamp.c	2020-09-11 18:21:40.000000000 +0200
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2020 Red Hat, Inc. All Rights reserved.
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+
+#define FILE_NAME	argv[1]
+
+static struct stat st1, st2;
+
+int main(int argc, char *argv[])
+{
+	int h, r;
+	char *map;
+	unlink(FILE_NAME);
+	h = creat(FILE_NAME, 0600);
+	if (h == -1) perror("creat"), exit(1);
+	r = write(h, "x", 1);
+	if (r != 1) perror("write"), exit(1);
+	if (close(h)) perror("close"), exit(1);
+	h = open(FILE_NAME, O_RDWR);
+	if (h == -1) perror("open"), exit(1);
+
+	map = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_PRIVATE, h, 0);
+	if (map == MAP_FAILED) perror("mmap"), exit(1);
+	if (fstat(h, &st1)) perror("fstat"), exit(1);
+	sleep(2);
+	*map = 'y';
+	if (fstat(h, &st2)) perror("fstat"), exit(1);
+	if (st1.st_mtime != st2.st_mtime) fprintf(stderr, "BUG: COW fault changed mtime!\n"), exit(1);
+	if (st1.st_ctime != st2.st_ctime) fprintf(stderr, "BUG: COW fault changed ctime!\n"), exit(1);
+	if (munmap(map, 4096)) perror("munmap"), exit(1);
+
+	map = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, h, 0);
+	if (map == MAP_FAILED) perror("mmap"), exit(1);
+	if (fstat(h, &st1)) perror("fstat"), exit(1);
+	sleep(2);
+	*map = 'z';
+	if (msync(map, 4096, MS_SYNC)) perror("msync"), exit(1);
+	if (fstat(h, &st2)) perror("fstat"), exit(1);
+	if (st1.st_mtime == st2.st_mtime) fprintf(stderr, "BUG: Shared fault did not change mtime!\n"), exit(1);
+	if (st1.st_ctime == st2.st_ctime) fprintf(stderr, "BUG: Shared fault did not change ctime!\n"), exit(1);
+	if (munmap(map, 4096)) perror("munmap"), exit(1);
+
+	if (close(h)) perror("close"), exit(1);
+	if (unlink(FILE_NAME)) perror("unlink"), exit(1);
+	return 0;
+}
Index: xfstests-dev/tests/generic/609
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ xfstests-dev/tests/generic/609	2020-09-11 18:30:30.000000000 +0200
@@ -0,0 +1,40 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Red Hat, Inc. All Rights Reserved.
+#
+# FS QA Test No. 609
+#
+# Check ctime and mtime are not updated on COW faults
+# and that they are updated on shared faults
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+    cd /
+    rm -f $testfile
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_test
+
+testfile=$TEST_DIR/testfile.$seq
+
+echo "Silence is golden"
+
+$here/src/mmap-timestamp $testfile 2>&1
+
+status=0
+exit
Index: xfstests-dev/tests/generic/609.out
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ xfstests-dev/tests/generic/609.out	2020-09-11 18:24:24.000000000 +0200
@@ -0,0 +1,2 @@
+QA output created by 609
+Silence is golden
Index: xfstests-dev/tests/generic/group
===================================================================
--- xfstests-dev.orig/tests/generic/group	2020-09-06 12:38:40.000000000 +0200
+++ xfstests-dev/tests/generic/group	2020-09-11 18:25:09.000000000 +0200
@@ -611,3 +611,4 @@
 606 auto attr quick dax
 607 auto attr quick dax
 608 auto attr quick dax
+609 auto quick

