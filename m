Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8806520152
	for <lists+linux-ext4@lfdr.de>; Thu, 16 May 2019 10:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfEPI3p (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 May 2019 04:29:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:57938 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbfEPI3p (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 16 May 2019 04:29:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7D57DAE84;
        Thu, 16 May 2019 08:29:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 361F61E3ED6; Thu, 16 May 2019 10:29:44 +0200 (CEST)
Date:   Thu, 16 May 2019 10:29:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     "cgxu519@zoho.com.cn" <cgxu519@zoho.com.cn>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/3] ext2: Strengthen xattr block checks
Message-ID: <20190516082944.GB13274@quack2.suse.cz>
References: <20190515140144.1183-1-jack@suse.cz>
 <20190515140144.1183-4-jack@suse.cz>
 <e0252f7d378e8de5cadea28ad3c4765a541c2c69.camel@zoho.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0252f7d378e8de5cadea28ad3c4765a541c2c69.camel@zoho.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 16-05-19 09:16:06, cgxu519@zoho.com.cn wrote:
> On Wed, 2019-05-15 at 16:01 +0200, Jan Kara wrote:
> > Check every entry in xattr block for validity in ext2_xattr_set() to
> > detect on disk corruption early. Also since e_value_block field in xattr
> > entry is never != 0 in a valid filesystem, just remove checks for it
> > once we have established entries are valid.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Could we do the entry check in the loop of get/list operation too?

Yes, makes sense. Will add for v2. Thanks for review.

								Honza

> 
> Thanks,
> Chengguang
> 
> > ---
> >  fs/ext2/xattr.c | 15 ++++++---------
> >  1 file changed, 6 insertions(+), 9 deletions(-)
> > 
> > diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
> > index 26a049ca89fb..04a4148d04b3 100644
> > --- a/fs/ext2/xattr.c
> > +++ b/fs/ext2/xattr.c
> > @@ -442,7 +442,9 @@ ext2_xattr_set(struct inode *inode, int name_index, const
> > char *name,
> >  			struct ext2_xattr_entry *next = EXT2_XATTR_NEXT(last);
> >  			if ((char *)next >= end)
> >  				goto bad_block;
> > -			if (!last->e_value_block && last->e_value_size) {
> > +			if (!ext2_xattr_entry_valid(last, sb->s_blocksize))
> > +				goto bad_block;
> > +			if (last->e_value_size) {
> >  				size_t offs = le16_to_cpu(last->e_value_offs);
> >  				if (offs < min_offs)
> >  					min_offs = offs;
> > @@ -482,12 +484,7 @@ ext2_xattr_set(struct inode *inode, int name_index, const
> > char *name,
> >  		error = -EEXIST;
> >  		if (flags & XATTR_CREATE)
> >  			goto cleanup;
> > -		if (!here->e_value_block && here->e_value_size) {
> > -			if (!ext2_xattr_entry_valid(here, sb->s_blocksize))
> > -				goto bad_block;
> > -			free += EXT2_XATTR_SIZE(
> > -					le32_to_cpu(here->e_value_size));
> > -		}
> > +		free += EXT2_XATTR_SIZE(le32_to_cpu(here->e_value_size));
> >  		free += EXT2_XATTR_LEN(name_len);
> >  	}
> >  	error = -ENOSPC;
> > @@ -552,7 +549,7 @@ ext2_xattr_set(struct inode *inode, int name_index, const
> > char *name,
> >  		here->e_name_len = name_len;
> >  		memcpy(here->e_name, name, name_len);
> >  	} else {
> > -		if (!here->e_value_block && here->e_value_size) {
> > +		if (here->e_value_size) {
> >  			char *first_val = (char *)header + min_offs;
> >  			size_t offs = le16_to_cpu(here->e_value_offs);
> >  			char *val = (char *)header + offs;
> > @@ -579,7 +576,7 @@ ext2_xattr_set(struct inode *inode, int name_index, const
> > char *name,
> >  			last = ENTRY(header+1);
> >  			while (!IS_LAST_ENTRY(last)) {
> >  				size_t o = le16_to_cpu(last->e_value_offs);
> > -				if (!last->e_value_block && o < offs)
> > +				if (o < offs)
> >  					last->e_value_offs =
> >  						cpu_to_le16(o + size);
> >  				last = EXT2_XATTR_NEXT(last);
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
