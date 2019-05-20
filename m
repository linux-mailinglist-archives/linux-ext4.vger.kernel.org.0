Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B46823D2D
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2019 18:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391241AbfETQYc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 20 May 2019 12:24:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:46179 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389259AbfETQYc (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 20 May 2019 12:24:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 09:24:31 -0700
X-ExtLoop1: 1
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga003.jf.intel.com with ESMTP; 20 May 2019 09:24:31 -0700
Received: from fmsmsx122.amr.corp.intel.com (10.18.125.37) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 20 May 2019 09:24:31 -0700
Received: from crsmsx104.amr.corp.intel.com (172.18.63.32) by
 fmsmsx122.amr.corp.intel.com (10.18.125.37) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 20 May 2019 09:24:30 -0700
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.116]) by
 CRSMSX104.amr.corp.intel.com ([169.254.6.192]) with mapi id 14.03.0415.000;
 Mon, 20 May 2019 10:24:28 -0600
From:   "Weiny, Ira" <ira.weiny@intel.com>
To:     Jan Kara <jack@suse.cz>
CC:     Theodore Ts'o <tytso@mit.edu>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: Can ext4_break_layouts() ever fail?
Thread-Topic: Can ext4_break_layouts() ever fail?
Thread-Index: AdUMKbLCbEtFBcIaSfOpe+6ZL3lGpQAl+awAAAjm/AAAjJpZAAAEIN1g
Date:   Mon, 20 May 2019 16:24:27 +0000
Message-ID: <2807E5FD2F6FDA4886F6618EAC48510E79D2A98C@CRSMSX101.amr.corp.intel.com>
References: <20190516205615.GA2926@iweiny-DESK2.sc.intel.com>
 <20190517090252.GC20550@quack2.suse.cz>
 <20190517201746.GA14175@iweiny-DESK2.sc.intel.com>
 <20190520082340.GB30972@quack2.suse.cz>
In-Reply-To: <20190520082340.GB30972@quack2.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTRjMWQwYjktYjQzOC00NjIwLWE2ZTUtODczZGY3MDljZGI3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVDgzbG9kYXdoeEhGQlNWOGdMR3BPbGtSekViMk9nTnJaY1g3cHRXTUw3NVVuQ0lldVNNejBYSXhmN0x5NnlERCJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> On Fri 17-05-19 13:17:47, Ira Weiny wrote:
> > On Fri, May 17, 2019 at 11:02:52AM +0200, Jan Kara wrote:
> > > On Thu 16-05-19 13:56:15, Ira Weiny wrote:
> > >
> > > > It looks to me like it is possible for ext4_break_layouts() to
> > > > fail if
> > > > prepare_to_wait_event() sees a pending signal.  Therefore I think
> > > > this is a bug in ext4 regardless of how I may implement a truncate
> failure.
> > >
> > > Yes, it's a bug in ext4.
> > >
> > > > --- a/fs/ext4/inode.c
> > > > +++ b/fs/ext4/inode.c
> > > > @@ -5648,6 +5648,8 @@ int ext4_setattr(struct dentry *dentry,
> struct iattr *attr)
> > > >                 if (rc) {
> > > >                         up_write(&EXT4_I(inode)->i_mmap_sem);
> > > >                         error = rc;
> > > > +                       if (orphan)
> > > > +                               ext4_orphan_del(NULL, inode);
> > >
> > > This isn't quite correct. This would silence the warning but leave
> > > the inode in on-disk orphan list. That is OK in case of fs-meltdown
> > > types of failures like IO errors for metadata, aborted journal, or stuff like
> that.
> > > But failing ext4_break_layouts() needs to be handled gracefully
> > > maintaining fs consistency. So you rather need something like:
> > >
> > > 			if (orphan && inode->i_nlink > 0) {
> > > 				handle_t *handle;
> > >
> > > 				handle = ext4_journal_start(inode,
> > > 						EXT4_HT_INODE, 3);
> > > 				if (IS_ERR(handle)) {
> > > 					ext4_orphan_del(NULL, inode);
> > > 					goto err_out;
> > > 				}
> > > 				ext4_orphan_del(handle, inode);
> > > 				ext4_journal_stop(handle);
> > > 			}
> > >
> >
> > Thanks!  Unfortunately, even with your suggestion something is still
> > wrong with my code.
> >
> > For some reason this does not seem to be "canceling" the truncate
> > completely.  With my test code for FS DAX which fails
> > ext4_break_layout() the file is being truncated and an application
> > which is writing past that truncation is getting a SIGBUS.
> 
> Looking at the code again, I'm not really surprised. The path bailing out of
> truncate in case ext4_break_layouts() fails is really hosed. The problem is
> that when we get to ext4_break_layouts(), we have already updated i_size
> and i_disksize and we happily leave them at their new values when bailing
> out. So we need to somewhat reorder the stuff we do in ext4_setattr(). I'll
> send a patch for that since it needs some considerations for proper lock
> ordering etc... Thanks for experimenting with this :)
> 

I should have sent something last night but yes I came to the same conclusion through some simple experiments.

I agree that the locking and other considerations would trip me up.  So I'm not opposed to you helping here.  I had more than 1 problem with either crashes or hangs while playing with the code.  :-/

Thanks,
Ira

> 								Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
