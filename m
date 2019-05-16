Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 996FA200AE
	for <lists+linux-ext4@lfdr.de>; Thu, 16 May 2019 09:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfEPHwo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 May 2019 03:52:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:51344 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726363AbfEPHwo (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 16 May 2019 03:52:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0A698ADF7;
        Thu, 16 May 2019 07:52:43 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C732D1E3ED6; Thu, 16 May 2019 09:52:42 +0200 (CEST)
Date:   Thu, 16 May 2019 09:52:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     "cgxu519@zoho.com.cn" <cgxu519@zoho.com.cn>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/3] ext2: Merge loops in ext2_xattr_set()
Message-ID: <20190516075242.GA13274@quack2.suse.cz>
References: <20190515140144.1183-1-jack@suse.cz>
 <20190515140144.1183-3-jack@suse.cz>
 <6340e88cfb57aadef737ba882d342cd922555a95.camel@zoho.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6340e88cfb57aadef737ba882d342cd922555a95.camel@zoho.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 16-05-19 09:13:34, cgxu519@zoho.com.cn wrote:
> On Wed, 2019-05-15 at 16:01 +0200, Jan Kara wrote:
> > There are two very similar loops when searching xattr to set. Just merge
> > them.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/ext2/xattr.c | 32 +++++++++++---------------------
> >  1 file changed, 11 insertions(+), 21 deletions(-)
> > 
> > diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
> > index fb2e008d4406..26a049ca89fb 100644
> > --- a/fs/ext2/xattr.c
> > +++ b/fs/ext2/xattr.c
> > @@ -437,27 +437,7 @@ ext2_xattr_set(struct inode *inode, int name_index, const
> > char *name,
> >  			goto cleanup;
> >  		}
> >  		/* Find the named attribute. */
> > -		here = FIRST_ENTRY(bh);
> > -		while (!IS_LAST_ENTRY(here)) {
> > -			struct ext2_xattr_entry *next = EXT2_XATTR_NEXT(here);
> > -			if ((char *)next >= end)
> > -				goto bad_block;
> > -			if (!here->e_value_block && here->e_value_size) {
> > -				size_t offs = le16_to_cpu(here->e_value_offs);
> > -				if (offs < min_offs)
> > -					min_offs = offs;
> > -			}
> > -			not_found = name_index - here->e_name_index;
> > -			if (!not_found)
> > -				not_found = name_len - here->e_name_len;
> > -			if (!not_found)
> > -				not_found = memcmp(name, here->e_name,name_len);
> > -			if (not_found <= 0)
> > -				break;
> > -			here = next;
> > -		}
> > -		last = here;
> > -		/* We still need to compute min_offs and last. */
> > +		last = FIRST_ENTRY(bh);
> >  		while (!IS_LAST_ENTRY(last)) {
> >  			struct ext2_xattr_entry *next = EXT2_XATTR_NEXT(last);
> >  			if ((char *)next >= end)
> > @@ -467,8 +447,18 @@ ext2_xattr_set(struct inode *inode, int name_index, const
> > char *name,
> >  				if (offs < min_offs)
> >  					min_offs = offs;
> >  			}
> > +			if (not_found) {
> > +				if (name_index == last->e_name_index &&
> > +				    name_len == last->e_name_len &&
> > +				    !memcmp(name, last->e_name,name_len)) {
> > +					not_found = 0;
> > +					here = last;
> > +				}
> > +			}
> >  			last = next;
> >  		}
> > +		if (not_found)
> > +			here = last;
> 
> Entry name is sorted so I think for new entry we should find right place for it
> not just appending to last.

Ah, good catch! I actually didn't find a place which would use the fact
that names are sorted (and that's why xfstests passed fine as well) but
you're right that the old code worked that way and we should keep that.
Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
