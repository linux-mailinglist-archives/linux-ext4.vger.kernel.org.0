Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBEC34BE7C
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Jun 2019 18:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfFSQpD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Jun 2019 12:45:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:51984 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725843AbfFSQpD (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 19 Jun 2019 12:45:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1FFAAAD18;
        Wed, 19 Jun 2019 16:45:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9479C1E434D; Wed, 19 Jun 2019 18:45:00 +0200 (CEST)
Date:   Wed, 19 Jun 2019 18:45:00 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Chengguang Xu <cgxu519@zoho.com.cn>, jack@suse.com,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext2: add missing brelse() in ext2_iget()
Message-ID: <20190619164500.GC13630@quack2.suse.cz>
References: <20190616150801.2652-1-cgxu519@zoho.com.cn>
 <20190616164521.GB1872750@magnolia>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <20190616164521.GB1872750@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun 16-06-19 09:45:21, Darrick J. Wong wrote:
> On Sun, Jun 16, 2019 at 11:08:01PM +0800, Chengguang Xu wrote:
> > Add missing brelse() on error path of ext2_iget().
> > 
> > Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
> 
> /me wonders if the brelse ought to be moved down to bad_inode so that
> each error branch only has to set @ret and then jump (thereby
> eliminating the possibility of making this mistake again), but for a
> oneliner quick fix I guess it's fine:
> 
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

I've applied the fix and also the cleanup Darrick suggested (attached).

								Honza
> 
> --D
> 
> > ---
> >  fs/ext2/inode.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> > index e474127dd255..fb3611f02051 100644
> > --- a/fs/ext2/inode.c
> > +++ b/fs/ext2/inode.c
> > @@ -1473,6 +1473,7 @@ struct inode *ext2_iget (struct super_block *sb, unsigned long ino)
> >  	else
> >  		ei->i_dir_acl = le32_to_cpu(raw_inode->i_dir_acl);
> >  	if (i_size_read(inode) < 0) {
> > +		brelse(bh);
> >  		ret = -EFSCORRUPTED;
> >  		goto bad_inode;
> >  	}
> > -- 
> > 2.21.0
> > 
> > 
> > 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--AqsLC8rIMeq19msA
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-ext2-Always-brelse-bh-on-failure-in-ext2_iget.patch"

From 936bbf3aea84696ce1081ab9648d08bbf08ca7aa Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Wed, 19 Jun 2019 18:29:45 +0200
Subject: [PATCH] ext2: Always brelse bh on failure in ext2_iget()

All but one bail out paths in ext2_iget() is releasing bh. Move the
releasing of bh into a common error handling code.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext2/inode.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index e680478866db..7004ce581a32 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1400,7 +1400,7 @@ void ext2_set_file_ops(struct inode *inode)
 struct inode *ext2_iget (struct super_block *sb, unsigned long ino)
 {
 	struct ext2_inode_info *ei;
-	struct buffer_head * bh;
+	struct buffer_head * bh = NULL;
 	struct ext2_inode *raw_inode;
 	struct inode *inode;
 	long ret = -EIO;
@@ -1446,7 +1446,6 @@ struct inode *ext2_iget (struct super_block *sb, unsigned long ino)
 	 */
 	if (inode->i_nlink == 0 && (inode->i_mode == 0 || ei->i_dtime)) {
 		/* this inode is deleted */
-		brelse (bh);
 		ret = -ESTALE;
 		goto bad_inode;
 	}
@@ -1463,7 +1462,6 @@ struct inode *ext2_iget (struct super_block *sb, unsigned long ino)
 	    !ext2_data_block_valid(EXT2_SB(sb), ei->i_file_acl, 1)) {
 		ext2_error(sb, "ext2_iget", "bad extended attribute block %u",
 			   ei->i_file_acl);
-		brelse(bh);
 		ret = -EFSCORRUPTED;
 		goto bad_inode;
 	}
@@ -1473,7 +1471,6 @@ struct inode *ext2_iget (struct super_block *sb, unsigned long ino)
 	else
 		ei->i_dir_acl = le32_to_cpu(raw_inode->i_dir_acl);
 	if (i_size_read(inode) < 0) {
-		brelse(bh);
 		ret = -EFSCORRUPTED;
 		goto bad_inode;
 	}
@@ -1527,6 +1524,7 @@ struct inode *ext2_iget (struct super_block *sb, unsigned long ino)
 	return inode;
 	
 bad_inode:
+	brelse(bh);
 	iget_failed(inode);
 	return ERR_PTR(ret);
 }
-- 
2.16.4


--AqsLC8rIMeq19msA--
