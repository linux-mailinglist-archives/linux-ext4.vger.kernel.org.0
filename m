Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 099CA13A386
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Jan 2020 10:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgANJML (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Jan 2020 04:12:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:49034 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgANJML (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 14 Jan 2020 04:12:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 937A0ACD9;
        Tue, 14 Jan 2020 09:12:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 26FA71E0D0E; Tue, 14 Jan 2020 10:12:08 +0100 (CET)
Date:   Tue, 14 Jan 2020 10:12:08 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz
Subject: Re: [RFC 1/2] iomap: direct-io: Move inode_dio_begin before
 filemap_write_and_wait_range
Message-ID: <20200114091208.GB6466@quack2.suse.cz>
References: <cover.1578907890.git.riteshh@linux.ibm.com>
 <27607a16327fe9664f32d09abe565af0d1ae56c9.1578907891.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27607a16327fe9664f32d09abe565af0d1ae56c9.1578907891.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 13-01-20 16:34:21, Ritesh Harjani wrote:
> Some filesystems (e.g. ext4) need to know in it's writeback path, that
> whether DIO is in progress or not. This info may be needed to avoid the
> stale data exposure race with DIO reads.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  fs/iomap/direct-io.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 23837926c0c5..d1c159bd3854 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -468,9 +468,18 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		flags |= IOMAP_NOWAIT;
>  	}
>  
> +	/*
> +	 * Call inode_dio_begin() before we write out and wait for writeback to
> +	 * complete. This may be needed by some filesystems to prevent race
> +	 * like stale data exposure by DIO reads.
> +	 */
> +	inode_dio_begin(inode);
> +	/* So that i_dio_count is incremented before below operation */
> +	smp_mb__after_atomic();

I wonder if the barrier shouldn't go into inode_dio_begin() - as a sepatare
patch. Because people just treat this as a lock-kind-of-thingy. E.g. btrfs
or ceph use inode_dio_begin() in places which I'd consider prone to CPU
reordering issues without this barrier...

Otherwise the patch looks good to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
