Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949D323CFEF
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Aug 2020 21:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgHET0r (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Aug 2020 15:26:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:46820 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728663AbgHERNr (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 5 Aug 2020 13:13:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D96E1B5E0;
        Wed,  5 Aug 2020 14:12:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DFA0C1E12CB; Wed,  5 Aug 2020 16:11:51 +0200 (CEST)
Date:   Wed, 5 Aug 2020 16:11:51 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] ext4: Do not block RWF_NOWAIT dio write on unallocated
 space
Message-ID: <20200805141151.GA16475@quack2.suse.cz>
References: <20200708153516.9507-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708153516.9507-1-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 08-07-20 17:35:16, Jan Kara wrote:
> Since commit 378f32bab371 ("ext4: introduce direct I/O write using iomap
> infrastructure") we don't properly bail out of RWF_NOWAIT direct IO
> write if underlying blocks are not allocated. Also
> ext4_dio_write_checks() does not honor RWF_NOWAIT when re-acquiring
> i_rwsem. Fix both issues.
> 
> Fixes: 378f32bab371 ("ext4: introduce direct I/O write using iomap infrastructure")
> Reported-by: Filipe Manana <fdmanana@gmail.com>
> Signed-off-by: Jan Kara <jack@suse.cz>

Ted, can you please merge this patch? Thanks!

								Honza

> ---
>  fs/ext4/file.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 2a01e31a032c..8f742b53f1d4 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -428,6 +428,10 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
>  	 */
>  	if (*ilock_shared && (!IS_NOSEC(inode) || *extend ||
>  	     !ext4_overwrite_io(inode, offset, count))) {
> +		if (iocb->ki_flags & IOCB_NOWAIT) {
> +			ret = -EAGAIN;
> +			goto out;
> +		}
>  		inode_unlock_shared(inode);
>  		*ilock_shared = false;
>  		inode_lock(inode);
> -- 
> 2.16.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
