Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323D72A60ED
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Nov 2020 10:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgKDJwc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Nov 2020 04:52:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:43596 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgKDJwc (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 4 Nov 2020 04:52:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 79944AFB5;
        Wed,  4 Nov 2020 09:52:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C4AD31E1305; Wed,  4 Nov 2020 10:52:29 +0100 (CET)
Date:   Wed, 4 Nov 2020 10:52:29 +0100
From:   Jan Kara <jack@suse.cz>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 02/10] ext4: mark fc ineligible if inode gets evictied
 due to mem pressure
Message-ID: <20201104095229.GA5600@quack2.suse.cz>
References: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
 <20201031200518.4178786-3-harshadshirwadkar@gmail.com>
 <20201103141331.GF3440@quack2.suse.cz>
 <CAD+ocbyXyjA9AKS-us4dFmA=ExdFQttYeXH2bJ8bQUAm0qYRDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD+ocbyXyjA9AKS-us4dFmA=ExdFQttYeXH2bJ8bQUAm0qYRDg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 03-11-20 10:33:47, harshad shirwadkar wrote:
> On Tue, Nov 3, 2020 at 6:13 AM Jan Kara <jack@suse.cz> wrote:
> > > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > > index b96a18679a27..52ff71236290 100644
> > > --- a/fs/ext4/inode.c
> > > +++ b/fs/ext4/inode.c
> > > @@ -327,6 +327,7 @@ void ext4_evict_inode(struct inode *inode)
> > >       ext4_xattr_inode_array_free(ea_inode_array);
> > >       return;
> > >  no_delete:
> > > +     ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_MEM_CRUNCH);
> > >       ext4_clear_inode(inode);        /* We must guarantee clearing of inode... */
> > >  }
> >
> > This will make fs ineligible on every inode reclaim. Even if the inode was
> > clean, not part of any FC. I guess this is too aggressive...
> Right, I missed that, so first checking if the inode is on FC list and
> then marking the FS as ineligible should suffice?

Yes, that looks good to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
