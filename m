Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0C418FC30
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Mar 2020 18:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbgCWR7F (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Mar 2020 13:59:05 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41286 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727011AbgCWR7F (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Mar 2020 13:59:05 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02NHwcMK029627
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Mar 2020 13:58:39 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id BDFC6420EBA; Mon, 23 Mar 2020 13:58:38 -0400 (EDT)
Date:   Mon, 23 Mar 2020 13:58:38 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/2] writeback, xfs: call dirty_inode() with
 I_DIRTY_TIME_EXPIRED when appropriate
Message-ID: <20200323175838.GA7133@mit.edu>
References: <20200320024639.GH1067245@mit.edu>
 <20200320025255.1705972-1-tytso@mit.edu>
 <20200320025255.1705972-2-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320025255.1705972-2-tytso@mit.edu>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Christoph, Dave --- does this give you the notification that you were
looking such that XFS could get the notification desired that it was
the timestamps need to be written back?

    	       	       	  	  - Ted

On Thu, Mar 19, 2020 at 10:52:55PM -0400, Theodore Ts'o wrote:
> Use the flag I_DIRTY_TIME_EXPIRED passed to dirty_inode() to signal to
> the file system that it is time to flush the inode's timestamps to
> stable storage.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  fs/fs-writeback.c  | 2 +-
>  fs/xfs/xfs_super.c | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 867454997c9d..32101349ba97 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1506,7 +1506,7 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
>  
>  	/* This was a lazytime expiration; we need to tell the file system */
>  	if (dirty & I_DIRTY_TIME_EXPIRED && inode->i_sb->s_op->dirty_inode)
> -		inode->i_sb->s_op->dirty_inode(inode, I_DIRTY_SYNC);
> +		inode->i_sb->s_op->dirty_inode(inode, I_DIRTY_TIME_EXPIRED);
>  	/* Don't write the inode if only I_DIRTY_PAGES was set */
>  	if (dirty & ~I_DIRTY_PAGES) {
>  		int err = write_inode(inode, wbc);
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 2094386af8ac..f27b9b205f81 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -622,7 +622,8 @@ xfs_fs_dirty_inode(
>  
>  	if (!(inode->i_sb->s_flags & SB_LAZYTIME))
>  		return;
> -	if (flag != I_DIRTY_SYNC || !(inode->i_state & I_DIRTY_TIME))
> +	if ((flag != I_DIRTY_SYNC && flag != I_DIRTY_TIME_EXPIRED) ||
> +	    !(inode->i_state & I_DIRTY_TIME))
>  		return;
>  
>  	if (xfs_trans_alloc(mp, &M_RES(mp)->tr_fsyncts, 0, 0, 0, &tp))
> -- 
> 2.24.1
> 
