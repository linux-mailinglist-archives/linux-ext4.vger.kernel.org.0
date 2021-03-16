Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B93033DA72
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Mar 2021 18:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238717AbhCPRPA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 16 Mar 2021 13:15:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:42968 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239090AbhCPROa (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 16 Mar 2021 13:14:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4F0E1AC24;
        Tue, 16 Mar 2021 17:14:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1945B1F2C4C; Tue, 16 Mar 2021 18:14:29 +0100 (CET)
Date:   Tue, 16 Mar 2021 18:14:29 +0100
From:   Jan Kara <jack@suse.cz>
To:     Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] inode.i_opflags - Usage of two different locking schemes
Message-ID: <20210316171429.GA22701@quack2.suse.cz>
References: <f63dd495-defb-adc4-aa91-6aacd7f441c7@tu-dortmund.de>
 <a4709bc4-ee62-2cdc-0628-32e8fa73e8f9@tu-dortmund.de>
 <YEJLuP6+Zy8/dq+D@mit.edu>
 <667b3ec3-a522-05a9-31e8-87d8bfaa7adb@tu-dortmund.de>
 <YEJWiXaZ+9H+2nBx@mit.edu>
 <0f387f5b-a516-af45-856d-f38d1adfadf5@tu-dortmund.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f387f5b-a516-af45-856d-f38d1adfadf5@tu-dortmund.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 08-03-21 15:05:33, Alexander Lochmann wrote:
> On 05.03.21 17:04, Theodore Ts'o wrote:
> > On Fri, Mar 05, 2021 at 04:35:47PM +0100, Alexander Lochmann wrote:
> > > 
> > > 
> > > On 05.03.21 16:18, Theodore Ts'o wrote:
> > > > 1)  I don't see where i_opflags is being read in ipc/mqueue.c at all,
> > > > either with or without i_rwsem.
> > > > 
> > > It is read in fs/dcache.c
> > 
> > So why is this unique to the mqueue inode then?  It might be helpful
> > to have explicit call stacks in the e-mail, in text form, when you
> > resend to LKML.
> It is unique to mqeue inode, because the control flow goes through
> ipc/mqueue.c where almost always the i_rwsem is taken.
> Hence, we see more memory accesses to an mqueue inode with the i_rwsem.
> The i_lock is less often hold compared to the i_rwsem.
> We conclude the i_rwsem is needed. So it might not be a contradiction at
> all. It rather could be a flaw in our approach. :-/
> 
> Besides from our current discussion:
> Does the i_lock protect i_opflags for both reading and writing?

So i_lock is supposed to protect i_opflags for writing AFAICT. For reading
we don't seem to bother in some cases and I agree that is potentially
problematic. It is *mostly* OK because we initialize i_opflags when loading
inode into memory / adding it to dcache. But sometimes we also update them
while the inode is alive. Now this is fine for the particular flag we
update but in theory, if the compiler wants to screw us and stores
temporarily some nonsensical value in i_opflags we'd have a problem. This
is mostly a theoretical issue but eventually we probably want to fix this.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
