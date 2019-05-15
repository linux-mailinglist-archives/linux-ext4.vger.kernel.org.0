Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEB81EC6E
	for <lists+linux-ext4@lfdr.de>; Wed, 15 May 2019 12:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfEOKzf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 May 2019 06:55:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:60962 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725939AbfEOKzf (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 15 May 2019 06:55:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A7042ADC7;
        Wed, 15 May 2019 10:55:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F2EDC1E3CA1; Wed, 15 May 2019 12:55:30 +0200 (CEST)
Date:   Wed, 15 May 2019 12:55:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Chengguang Xu <cgxu519@zoho.com.cn>, Jan Kara <jack@suse.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] ext2: introduce helper for xattr header validation
Message-ID: <20190515105530.GA7418@quack2.suse.cz>
References: <20190513224042.23377-1-cgxu519@zoho.com.cn>
 <3F06FAEE-E534-42A0-A927-A07259070D6A@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F06FAEE-E534-42A0-A927-A07259070D6A@dilger.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 14-05-19 09:32:10, Andreas Dilger wrote:
> On May 13, 2019, at 4:40 PM, Chengguang Xu <cgxu519@zoho.com.cn> wrote:
> > 
> > Introduce helper function ext2_xattr_header_valid()
> > for xattr header validation and clean up the header
> > check ralated code.
> > 
> > Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
> 
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Thanks. Applied.

								Honza
> 
> > ---
> > v1->v2:
> > - Pass xattr header to ext2_xattr_header_valid().
> > - Change signed-off mail address.
> > 
> > fs/ext2/xattr.c | 31 ++++++++++++++++++++-----------
> > 1 file changed, 20 insertions(+), 11 deletions(-)
> > 
> > diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
> > index 1e33e0ac8cf1..db27260d6a5b 100644
> > --- a/fs/ext2/xattr.c
> > +++ b/fs/ext2/xattr.c
> > @@ -134,6 +134,16 @@ ext2_xattr_handler(int name_index)
> > 	return handler;
> > }
> > 
> > +static bool
> > +ext2_xattr_header_valid(struct ext2_xattr_header *header)
> > +{
> > +	if (header->h_magic != cpu_to_le32(EXT2_XATTR_MAGIC) ||
> > +	    header->h_blocks != cpu_to_le32(1))
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> > /*
> >  * ext2_xattr_get()
> >  *
> > @@ -176,9 +186,9 @@ ext2_xattr_get(struct inode *inode, int name_index, const char *name,
> > 	ea_bdebug(bh, "b_count=%d, refcount=%d",
> > 		atomic_read(&(bh->b_count)), le32_to_cpu(HDR(bh)->h_refcount));
> > 	end = bh->b_data + bh->b_size;
> > -	if (HDR(bh)->h_magic != cpu_to_le32(EXT2_XATTR_MAGIC) ||
> > -	    HDR(bh)->h_blocks != cpu_to_le32(1)) {
> > -bad_block:	ext2_error(inode->i_sb, "ext2_xattr_get",
> > +	if (!ext2_xattr_header_valid(HDR(bh))) {
> > +bad_block:
> > +		ext2_error(inode->i_sb, "ext2_xattr_get",
> > 			"inode %ld: bad block %d", inode->i_ino,
> > 			EXT2_I(inode)->i_file_acl);
> > 		error = -EIO;
> > @@ -266,9 +276,9 @@ ext2_xattr_list(struct dentry *dentry, char *buffer, size_t buffer_size)
> > 	ea_bdebug(bh, "b_count=%d, refcount=%d",
> > 		atomic_read(&(bh->b_count)), le32_to_cpu(HDR(bh)->h_refcount));
> > 	end = bh->b_data + bh->b_size;
> > -	if (HDR(bh)->h_magic != cpu_to_le32(EXT2_XATTR_MAGIC) ||
> > -	    HDR(bh)->h_blocks != cpu_to_le32(1)) {
> > -bad_block:	ext2_error(inode->i_sb, "ext2_xattr_list",
> > +	if (!ext2_xattr_header_valid(HDR(bh))) {
> > +bad_block:
> > +		ext2_error(inode->i_sb, "ext2_xattr_list",
> > 			"inode %ld: bad block %d", inode->i_ino,
> > 			EXT2_I(inode)->i_file_acl);
> > 		error = -EIO;
> > @@ -406,9 +416,9 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
> > 			le32_to_cpu(HDR(bh)->h_refcount));
> > 		header = HDR(bh);
> > 		end = bh->b_data + bh->b_size;
> > -		if (header->h_magic != cpu_to_le32(EXT2_XATTR_MAGIC) ||
> > -		    header->h_blocks != cpu_to_le32(1)) {
> > -bad_block:		ext2_error(sb, "ext2_xattr_set",
> > +		if (!ext2_xattr_header_valid(header)) {
> > +bad_block:
> > +			ext2_error(sb, "ext2_xattr_set",
> > 				"inode %ld: bad block %d", inode->i_ino,
> > 				   EXT2_I(inode)->i_file_acl);
> > 			error = -EIO;
> > @@ -784,8 +794,7 @@ ext2_xattr_delete_inode(struct inode *inode)
> > 		goto cleanup;
> > 	}
> > 	ea_bdebug(bh, "b_count=%d", atomic_read(&(bh->b_count)));
> > -	if (HDR(bh)->h_magic != cpu_to_le32(EXT2_XATTR_MAGIC) ||
> > -	    HDR(bh)->h_blocks != cpu_to_le32(1)) {
> > +	if (!ext2_xattr_header_valid(HDR(bh))) {
> > 		ext2_error(inode->i_sb, "ext2_xattr_delete_inode",
> > 			"inode %ld: bad block %d", inode->i_ino,
> > 			EXT2_I(inode)->i_file_acl);
> > --
> > 2.17.2
> > 
> > 
> 
> 
> Cheers, Andreas
> 
> 
> 
> 
> 


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
