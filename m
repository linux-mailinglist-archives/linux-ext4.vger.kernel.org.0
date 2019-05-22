Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9557C26000
	for <lists+linux-ext4@lfdr.de>; Wed, 22 May 2019 11:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfEVJAx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 May 2019 05:00:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:41906 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727946AbfEVJAx (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 22 May 2019 05:00:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 35FBAB03E;
        Wed, 22 May 2019 09:00:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8F1931E3C69; Wed, 22 May 2019 11:00:52 +0200 (CEST)
Date:   Wed, 22 May 2019 11:00:52 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/3] ext4: Do not delete unlinked inode from orphan list
 on failed truncate
Message-ID: <20190522090052.GD17019@quack2.suse.cz>
References: <20190521074358.17186-1-jack@suse.cz>
 <20190521074358.17186-3-jack@suse.cz>
 <20190521181348.GB31888@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521181348.GB31888@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 21-05-19 11:13:49, Ira Weiny wrote:
> On Tue, May 21, 2019 at 09:43:57AM +0200, Jan Kara wrote:
> > It is possible that unlinked inode enters ext4_setattr() (e.g. if
> > somebody calls ftruncate(2) on unlinked but still open file). In such
> > case we should not delete the inode from the orphan list if truncate
> > fails. Note that this is mostly a theoretical concern as filesystem is
> > corrupted if we reach this path anyway but let's be consistent in our
> > orphan handling.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/ext4/inode.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 9bcb7f2b86dd..c7f77c643008 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -5625,7 +5625,7 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
> >  			up_write(&EXT4_I(inode)->i_data_sem);
> >  			ext4_journal_stop(handle);
> >  			if (error) {
> > -				if (orphan)
> > +				if (orphan && inode->i_nlink)
> >  					ext4_orphan_del(NULL, inode);
> 
> 
> NIT: While ext4_orphan_del() can be called even if the inode was not on the
> orphan list it kind of tripped me up to see this called even if
> ext4_orphan_add() fails...
> 
> But considering how ext4_orphan_del() works:
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Yes, calling ext4_orphan_del() twice is harmless. You're right we just
shouldn't set 'orphan = 1' if ext4_orphan_add() fails but that's
independent cleanup we could do. Thanks for your review!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
