Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7F0263CFB
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Sep 2020 08:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgIJGJK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Sep 2020 02:09:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54292 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgIJGJB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Sep 2020 02:09:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08A65LZx078701;
        Thu, 10 Sep 2020 06:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=BZKbxxW9fRj1O1NrXCl2qK3IkQQc10VGvhE4jGAfas0=;
 b=SQXd37fk/BtuTbYp748oOSVO53w3aOoQNP/3F8naKXGJyn/Emxpln0uo/FP1QQV+SwMa
 RBhwXY0N1ICtDL0IyNhtKdYr/x1cuW3XL2cBm+0sWFG56khgarmwH2MCGdaN4EccRrPE
 MUQt2bNNa1U79RvqRBkOb7IBAzP/e2K57RAWoWPvO1kLLlv1H1ezz2s3vRIai/o0y3Tq
 NTjth5D+U0sr3oEGQ75nz9VilMpJtKHxtUzNuXqujU6uXz7W1agd0/zYZ8BzSWeLM9VD
 um2WB6SFr+wXVxYgW/iOatGGl2OXv3/a97+AzwUvQesXQ8j7totADeGAJNYINuUP9SpS kg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 33c23r5yje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Sep 2020 06:08:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08A66Pc7133170;
        Thu, 10 Sep 2020 06:06:36 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 33cmm0c2ea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Sep 2020 06:06:36 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08A66TSK001564;
        Thu, 10 Sep 2020 06:06:29 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Sep 2020 23:06:28 -0700
Date:   Wed, 9 Sep 2020 23:06:26 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20200910060626.GA7964@magnolia>
References: <alpine.LRH.2.02.2009031328040.6929@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009041200570.27312@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009050805250.12419@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009050812060.12419@file01.intranet.prod.int.rdu2.redhat.com>
 <20200905153652.GA7955@magnolia>
 <alpine.LRH.2.02.2009051229180.542@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2009051229180.542@file01.intranet.prod.int.rdu2.redhat.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9739 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=1
 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009100056
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9739 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=1 spamscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009100056
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Sep 05, 2020 at 01:02:33PM -0400, Mikulas Patocka wrote:
> 
> 
> On Sat, 5 Sep 2020, Darrick J. Wong wrote:
> 
> > On Sat, Sep 05, 2020 at 08:13:02AM -0400, Mikulas Patocka wrote:
> > > When running in a dax mode, if the user maps a page with MAP_PRIVATE and
> > > PROT_WRITE, the xfs filesystem would incorrectly update ctime and mtime
> > > when the user hits a COW fault.
> > > 
> > > This breaks building of the Linux kernel.
> > > How to reproduce:
> > > 1. extract the Linux kernel tree on dax-mounted xfs filesystem
> > > 2. run make clean
> > > 3. run make -j12
> > > 4. run make -j12
> > > - at step 4, make would incorrectly rebuild the whole kernel (although it
> > >   was already built in step 3).
> > > 
> > > The reason for the breakage is that almost all object files depend on
> > > objtool. When we run objtool, it takes COW page fault on its .data
> > > section, and these faults will incorrectly update the timestamp of the
> > > objtool binary. The updated timestamp causes make to rebuild the whole
> > > tree.
> > > 
> > > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > > Cc: stable@vger.kernel.org
> > > 
> > > ---
> > >  fs/xfs/xfs_file.c |   11 +++++++++--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > > 
> > > Index: linux-2.6/fs/xfs/xfs_file.c
> > > ===================================================================
> > > --- linux-2.6.orig/fs/xfs/xfs_file.c	2020-09-05 10:01:42.000000000 +0200
> > > +++ linux-2.6/fs/xfs/xfs_file.c	2020-09-05 13:59:12.000000000 +0200
> > > @@ -1223,6 +1223,13 @@ __xfs_filemap_fault(
> > >  	return ret;
> > >  }
> > >  
> > > +static bool
> > > +xfs_is_write_fault(
> > 
> > Call this xfs_is_shared_dax_write_fault, and throw in the IS_DAX() test?
> > 
> > You might as well make it a static inline.
> 
> Yes, it is possible. I'll send a second version.
> 
> > > +	struct vm_fault		*vmf)
> > > +{
> > > +	return vmf->flags & FAULT_FLAG_WRITE && vmf->vma->vm_flags & VM_SHARED;
> > 
> > Also, is "shortcutting the normal fault path" the reason for ext2 and
> > xfs both being broken?
> > 
> > /me puzzles over why write_fault is always true for page_mkwrite and
> > pfn_mkwrite, but not for fault and huge_fault...
> > 
> > Also: Can you please turn this (checking for timestamp update behavior
> > wrt shared and private mapping write faults) into an fstest so we don't
> > mess this up again?
> 
> I've written this program that tests it - you can integrate it into your 
> testsuite.

I don't get it.  You're a filesystem maintainer too, which means you're
a regular contributor.  Do you:

(a) not use fstests?  If you don't, I really hope you use something else
to QA hpfs.

(b) really think that it's my problem to integrate and submit your
regression tests for you?

> Mikulas
> 
> 
> #include <stdio.h>

and (c) what do you want me to do with a piece of code that has no
signoff tag, no copyright, and no license?  This is your patch, and
therefore your responsibility to develop enough of an appropriate
regression test in a proper form that the rest of us can easily
determine we have the rights to contribute to it.

I don't have a problem with helping to tweak a properly licensed and
tagged test program into fstests, but this is a non-starter.

--D

> #include <stdlib.h>
> #include <unistd.h>
> #include <fcntl.h>
> #include <string.h>
> #include <sys/mman.h>
> #include <sys/stat.h>
> 
> #define FILE_NAME	"test.txt"
> 
> static struct stat st1, st2;
> 
> int main(void)
> {
> 	int h, r;
> 	char *map;
> 	unlink(FILE_NAME);
> 	h = creat(FILE_NAME, 0600);
> 	if (h == -1) perror("creat"), exit(1);
> 	r = write(h, "x", 1);
> 	if (r != 1) perror("write"), exit(1);
> 	if (close(h)) perror("close"), exit(1);
> 	h = open(FILE_NAME, O_RDWR);
> 	if (h == -1) perror("open"), exit(1);
> 
> 	map = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_PRIVATE, h, 0);
> 	if (map == MAP_FAILED) perror("mmap"), exit(1);
> 	if (fstat(h, &st1)) perror("fstat"), exit(1);
> 	sleep(2);
> 	*map = 'y';
> 	if (fstat(h, &st2)) perror("fstat"), exit(1);
> 	if (memcmp(&st1, &st2, sizeof(struct stat))) fprintf(stderr, "BUG: COW fault changed time!\n"), exit(1);
> 	if (munmap(map, 4096)) perror("munmap"), exit(1);
> 
> 	map = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, h, 0);
> 	if (map == MAP_FAILED) perror("mmap"), exit(1);
> 	if (fstat(h, &st1)) perror("fstat"), exit(1);
> 	sleep(2);
> 	*map = 'z';
> 	if (fstat(h, &st2)) perror("fstat"), exit(1);
> 	if (st1.st_mtime == st2.st_mtime) fprintf(stderr, "BUG: Shared fault did not change mtime!\n"), exit(1);
> 	if (st1.st_ctime == st2.st_ctime) fprintf(stderr, "BUG: Shared fault did not change ctime!\n"), exit(1);
> 	if (munmap(map, 4096)) perror("munmap"), exit(1);
> 
> 	if (close(h)) perror("close"), exit(1);
> 	if (unlink(FILE_NAME)) perror("unlink"), exit(1);
> 	return 0;
> }
> 
