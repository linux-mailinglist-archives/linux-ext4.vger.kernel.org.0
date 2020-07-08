Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A642185F2
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jul 2020 13:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgGHLUw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Jul 2020 07:20:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:42982 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728385AbgGHLUw (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 8 Jul 2020 07:20:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D3B00AD4B;
        Wed,  8 Jul 2020 11:20:51 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0E8781E12BF; Wed,  8 Jul 2020 13:20:51 +0200 (CEST)
Date:   Wed, 8 Jul 2020 13:20:51 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Chengguang Xu <cgxu519@mykernel.net>, jack@suse.com,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext2: initialize quota info in ext2_xattr_set()
Message-ID: <20200708112051.GE25069@quack2.suse.cz>
References: <20200626054959.114177-1-cgxu519@mykernel.net>
 <20200708105202.7AE73A405F@b06wcsmtp001.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708105202.7AE73A405F@b06wcsmtp001.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 08-07-20 16:22:01, Ritesh Harjani wrote:
> 
> 
> On 6/26/20 11:19 AM, Chengguang Xu wrote:
> > In order to correctly account/limit space usage, should initialize
> > quota info before calling quota related functions.
> 
> How did you encounter the problem?
> Any test case got hit?
> 
> > 
> > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> 
> LGTM, feel free to add
> Reviewed-by: Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

Thanks. I've added the patch to my tree.

								Honza

> 
> 
> > ---
> >   fs/ext2/xattr.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
> > index 943cc469f42f..913e5c4921ec 100644
> > --- a/fs/ext2/xattr.c
> > +++ b/fs/ext2/xattr.c
> > @@ -437,6 +437,9 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
> >   	name_len = strlen(name);
> >   	if (name_len > 255 || value_len > sb->s_blocksize)
> >   		return -ERANGE;
> > +	error = dquot_initialize(inode);
> > +	if (error)
> > +		return error;
> >   	down_write(&EXT2_I(inode)->xattr_sem);
> >   	if (EXT2_I(inode)->i_file_acl) {
> >   		/* The inode already has an extended attribute block. */
> > 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
