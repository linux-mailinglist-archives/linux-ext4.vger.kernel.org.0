Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6D625F362
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Sep 2020 08:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgIGGsC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Sep 2020 02:48:02 -0400
Received: from verein.lst.de ([213.95.11.211]:47846 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgIGGsC (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 7 Sep 2020 02:48:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5A1BB6736F; Mon,  7 Sep 2020 08:47:58 +0200 (CEST)
Date:   Mon, 7 Sep 2020 08:47:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Theodore Ts'o <tytso@mit.edu>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/2] xfs: don't update mtime on COW faults
Message-ID: <20200907064758.GA19384@lst.de>
References: <alpine.LRH.2.02.2009031328040.6929@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2009041200570.27312@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2009050805250.12419@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2009050812060.12419@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2009050812060.12419@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> +static bool
> +xfs_is_write_fault(
> +	struct vm_fault		*vmf)
> +{
> +	return vmf->flags & FAULT_FLAG_WRITE && vmf->vma->vm_flags & VM_SHARED;
> +}

This function does not look xfs specific at all.  Why isn't it it in
fs.h?  While we're at it the name sounds rather generic, and there are
no good comments.

Maybe we just need to split FAULT_FLAG_WRITE into two and check those
instead of such crazy workarounds?
