Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEBE921EF1
	for <lists+linux-ext4@lfdr.de>; Fri, 17 May 2019 22:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfEQURC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 May 2019 16:17:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:39872 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfEQURC (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 17 May 2019 16:17:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 May 2019 13:17:01 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga004.fm.intel.com with ESMTP; 17 May 2019 13:17:01 -0700
Date:   Fri, 17 May 2019 13:17:47 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: Can ext4_break_layouts() ever fail?
Message-ID: <20190517201746.GA14175@iweiny-DESK2.sc.intel.com>
References: <20190516205615.GA2926@iweiny-DESK2.sc.intel.com>
 <20190517090252.GC20550@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517090252.GC20550@quack2.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, May 17, 2019 at 11:02:52AM +0200, Jan Kara wrote:
> On Thu 16-05-19 13:56:15, Ira Weiny wrote:
> 
> > It looks to me like it is possible for ext4_break_layouts() to fail if
> > prepare_to_wait_event() sees a pending signal.  Therefore I think this is a bug
> > in ext4 regardless of how I may implement a truncate failure.
> 
> Yes, it's a bug in ext4.
> 
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -5648,6 +5648,8 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
> >                 if (rc) {  
> >                         up_write(&EXT4_I(inode)->i_mmap_sem);
> >                         error = rc;
> > +                       if (orphan)
> > +                               ext4_orphan_del(NULL, inode);
> 
> This isn't quite correct. This would silence the warning but leave the
> inode in on-disk orphan list. That is OK in case of fs-meltdown types of
> failures like IO errors for metadata, aborted journal, or stuff like that.
> But failing ext4_break_layouts() needs to be handled gracefully maintaining
> fs consistency. So you rather need something like:
> 
> 			if (orphan && inode->i_nlink > 0) {
> 				handle_t *handle;
> 
> 				handle = ext4_journal_start(inode,
> 						EXT4_HT_INODE, 3);
> 				if (IS_ERR(handle)) {
> 					ext4_orphan_del(NULL, inode);
> 					goto err_out;
> 				}
> 				ext4_orphan_del(handle, inode);
> 				ext4_journal_stop(handle);
> 			}
>

Thanks!  Unfortunately, even with your suggestion something is still wrong with
my code.

For some reason this does not seem to be "canceling" the truncate completely.
With my test code for FS DAX which fails ext4_break_layout() the file is being
truncated and an application which is writing past that truncation is getting a
SIGBUS.

I don't understand why this is happening because failing here should be
skipping the call to truncate_pagecache() which AFAICT does user unmappings...
So...  I'm still investigating this.

But thanks for confirming this is a bug.  I will get a generic patch out soon.

Thanks,
Ira

