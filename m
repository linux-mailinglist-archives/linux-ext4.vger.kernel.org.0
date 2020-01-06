Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81E40130F7D
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jan 2020 10:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgAFJdD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Jan 2020 04:33:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:60660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgAFJdD (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 6 Jan 2020 04:33:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D6F79AE19;
        Mon,  6 Jan 2020 09:33:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EFCFE1E0B47; Mon,  6 Jan 2020 10:33:00 +0100 (CET)
Date:   Mon, 6 Jan 2020 10:33:00 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-ext4@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        "Berrocal, Eduardo" <eduardo.berrocal@intel.com>
Subject: Re: [PATCH] ext4: Optimize ext4 DIO overwrites
Message-ID: <20200106093300.GB9176@quack2.suse.cz>
References: <20191218174433.19380-1-jack@suse.cz>
 <20191219135329.529E3A404D@d06av23.portsmouth.uk.ibm.com>
 <20191219192823.GA5389@quack2.suse.cz>
 <20191226171731.GE3158@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191226171731.GE3158@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 26-12-19 12:17:31, Theodore Y. Ts'o wrote:
> On Thu, Dec 19, 2019 at 08:28:23PM +0100, Jan Kara wrote:
> > > However depending on which patch lands first one may need a
> > > re-basing. Will conflict with this-
> > > https://marc.info/?l=linux-ext4&m=157613016931238&w=2
> > 
> > Yes, but the conflict is minor and trivial to resolve.
> > 
> 
> Is this the correct resolution?

Looks good to me as well.

								Honza

> 
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -447,6 +447,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	struct inode *inode = file_inode(iocb->ki_filp);
>  	loff_t offset = iocb->ki_pos;
>  	size_t count = iov_iter_count(from);
> +	const struct iomap_ops *iomap_ops = &ext4_iomap_ops;
>  	bool extend = false, unaligned_io = false;
>  	bool ilock_shared = true;
>  
> @@ -526,7 +527,9 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		ext4_journal_stop(handle);
>  	}
>  
> -	ret = iomap_dio_rw(iocb, from, &ext4_iomap_ops, &ext4_dio_write_ops,
> +	if (ilock_shared)
> +		iomap_ops = &ext4_iomap_overwrite_ops;
> +	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
>  			   is_sync_kiocb(iocb) || unaligned_io || extend);
>  
>  	if (extend)
> 
>      	   	    	      	  - Ted
> 				  
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
