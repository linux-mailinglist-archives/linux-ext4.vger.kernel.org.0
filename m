Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB1BF18877
	for <lists+linux-ext4@lfdr.de>; Thu,  9 May 2019 12:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfEIKmb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 May 2019 06:42:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:54898 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725869AbfEIKmb (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 9 May 2019 06:42:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 66003AC11;
        Thu,  9 May 2019 10:42:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 223751E3C7F; Thu,  9 May 2019 12:42:28 +0200 (CEST)
Date:   Thu, 9 May 2019 12:42:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     "sunny.s.zhang" <sunny.s.zhang@oracle.com>
Cc:     Chengguang Xu <cgxu519@gmail.com>, jack@suse.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] jbd2: fix potential double free
Message-ID: <20190509104228.GD23589@quack2.suse.cz>
References: <1557054064-3504-1-git-send-email-cgxu519@gmail.com>
 <a931ed92-763c-0a18-ed3d-4ac1c4fbcb8d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a931ed92-763c-0a18-ed3d-4ac1c4fbcb8d@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 08-05-19 14:38:22, sunny.s.zhang wrote:
> Hi Chengguang,
> 
> 在 2019年05月05日 19:01, Chengguang Xu 写道:
> > When fail from creating cache jbd2_inode_cache, we will
> > destroy previously created cache jbd2_handle_cache twice.
> > This patch fixes it by removing first destroy in error path.
> > 
> > Signed-off-by: Chengguang Xu <cgxu519@gmail.com>
> > ---
> >   fs/jbd2/journal.c | 1 -
> >   1 file changed, 1 deletion(-)
> > 
> > diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> > index 382c030cc78b..49797854ccb8 100644
> > --- a/fs/jbd2/journal.c
> > +++ b/fs/jbd2/journal.c
> > @@ -2642,7 +2642,6 @@ static int __init jbd2_journal_init_handle_cache(void)
> >   	jbd2_inode_cache = KMEM_CACHE(jbd2_inode, 0);
> >   	if (jbd2_inode_cache == NULL) {
> >   		printk(KERN_EMERG "JBD2: failed to create inode cache\n");
> > -		kmem_cache_destroy(jbd2_handle_cache);
> Maybe we should keep it, and set the jbd2_handle_cache to NULL.
> If there are some changes in the future,  we may forget to change the
> function
> of jbd2_journal_destroy_handle_cache.

So what I'd do is that I'd split initialization of jbd2_inode_cache into a
separate function (and the same for destruction). That more aligns with how
things are currently done in jbd2 and also fixes the problem with double
destruction.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
