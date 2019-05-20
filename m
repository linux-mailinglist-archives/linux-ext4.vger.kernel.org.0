Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84FCB22EC3
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2019 10:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbfETIXm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 May 2019 04:23:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:53786 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731411AbfETIXm (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 20 May 2019 04:23:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 191AEAF8D;
        Mon, 20 May 2019 08:23:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 184381E3ED6; Mon, 20 May 2019 10:23:40 +0200 (CEST)
Date:   Mon, 20 May 2019 10:23:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Subject: Re: Can ext4_break_layouts() ever fail?
Message-ID: <20190520082340.GB30972@quack2.suse.cz>
References: <20190516205615.GA2926@iweiny-DESK2.sc.intel.com>
 <20190517090252.GC20550@quack2.suse.cz>
 <20190517201746.GA14175@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517201746.GA14175@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 17-05-19 13:17:47, Ira Weiny wrote:
> On Fri, May 17, 2019 at 11:02:52AM +0200, Jan Kara wrote:
> > On Thu 16-05-19 13:56:15, Ira Weiny wrote:
> > 
> > > It looks to me like it is possible for ext4_break_layouts() to fail if
> > > prepare_to_wait_event() sees a pending signal.  Therefore I think this is a bug
> > > in ext4 regardless of how I may implement a truncate failure.
> > 
> > Yes, it's a bug in ext4.
> > 
> > > --- a/fs/ext4/inode.c
> > > +++ b/fs/ext4/inode.c
> > > @@ -5648,6 +5648,8 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
> > >                 if (rc) {  
> > >                         up_write(&EXT4_I(inode)->i_mmap_sem);
> > >                         error = rc;
> > > +                       if (orphan)
> > > +                               ext4_orphan_del(NULL, inode);
> > 
> > This isn't quite correct. This would silence the warning but leave the
> > inode in on-disk orphan list. That is OK in case of fs-meltdown types of
> > failures like IO errors for metadata, aborted journal, or stuff like that.
> > But failing ext4_break_layouts() needs to be handled gracefully maintaining
> > fs consistency. So you rather need something like:
> > 
> > 			if (orphan && inode->i_nlink > 0) {
> > 				handle_t *handle;
> > 
> > 				handle = ext4_journal_start(inode,
> > 						EXT4_HT_INODE, 3);
> > 				if (IS_ERR(handle)) {
> > 					ext4_orphan_del(NULL, inode);
> > 					goto err_out;
> > 				}
> > 				ext4_orphan_del(handle, inode);
> > 				ext4_journal_stop(handle);
> > 			}
> >
> 
> Thanks!  Unfortunately, even with your suggestion something is still
> wrong with my code.
> 
> For some reason this does not seem to be "canceling" the truncate
> completely.  With my test code for FS DAX which fails ext4_break_layout()
> the file is being truncated and an application which is writing past that
> truncation is getting a SIGBUS.

Looking at the code again, I'm not really surprised. The path bailing out
of truncate in case ext4_break_layouts() fails is really hosed. The problem
is that when we get to ext4_break_layouts(), we have already updated i_size
and i_disksize and we happily leave them at their new values when bailing
out. So we need to somewhat reorder the stuff we do in ext4_setattr(). I'll
send a patch for that since it needs some considerations for proper lock
ordering etc... Thanks for experimenting with this :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
