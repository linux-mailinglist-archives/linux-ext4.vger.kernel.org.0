Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E86B925FE0
	for <lists+linux-ext4@lfdr.de>; Wed, 22 May 2019 10:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbfEVI5a (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 May 2019 04:57:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:40462 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727796AbfEVI5a (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 22 May 2019 04:57:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E0AFDB016;
        Wed, 22 May 2019 08:57:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3DD561E3C69; Wed, 22 May 2019 10:57:29 +0200 (CEST)
Date:   Wed, 22 May 2019 10:57:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/3] ext4: Gracefully handle ext4_break_layouts() failure
 during truncate
Message-ID: <20190522085729.GC17019@quack2.suse.cz>
References: <20190521074358.17186-1-jack@suse.cz>
 <20190521074358.17186-4-jack@suse.cz>
 <20190521182731.GC31888@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521182731.GC31888@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 21-05-19 11:27:32, Ira Weiny wrote:
> On Tue, May 21, 2019 at 09:43:58AM +0200, Jan Kara wrote:
> > ext4_break_layouts() may fail e.g. due to a signal being delivered.
> > Thus we need to handle its failure gracefully and not by taking the
> > filesystem down. Currently ext4_break_layouts() failure is rare but it
> > may become more common once RDMA uses layout leases for handling
> > long-term page pins for DAX mappings.
> > 
> > To handle the failure we need to move ext4_break_layouts() earlier
> > during setattr handling before we do hard to undo changes such as
> > modifying inode size. To be able to do that we also have to move some
> > other checks which are better done without holding i_mmap_sem earlier.
> > 
> > Reported-by: "Weiny, Ira" <ira.weiny@intel.com>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> 
> This fixes the bug I was seeing WRT ext4_break_layouts().  Thanks for the help!
> One more NIT comment below.
> 
> > @@ -5627,29 +5644,12 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
> >  			if (error) {
> >  				if (orphan && inode->i_nlink)
> >  					ext4_orphan_del(NULL, inode);
> > -				goto err_out;
> > +				goto out_mmap_sem;
> 
> This goto flows through a second ext4_orphan_del() call which threw me at
> first.  But I think this is ok.

It is OK but unnecessary. I've deleted this ext4_orphan_del() call. Thanks
for testing and review!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
