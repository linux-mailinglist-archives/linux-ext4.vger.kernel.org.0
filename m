Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 159311923E9
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Mar 2020 10:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgCYJU6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Mar 2020 05:20:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36396 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgCYJU6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Mar 2020 05:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ihmJv1brBj6wrslrN130WrjYRLeKs/TEzo95JedDuQE=; b=VVlJCPTl9HltfIO3OxAs3HGKKD
        He4wfn0kQ0/ruQxdwMVfjLoSAGF7abkRzLDEAJB1mHKK41KXdDr7w9ypakrVILxJ+sWAA6BGQgp1B
        tIaSkl4ws+rsTbDsYee8L8j7aKDEmsLPPvI1LHL6KbYqsDvr/hRDlV2R4mjpKG4u1OLGOXcfPIZDw
        dokRf09ZHgKcM51G5iRWjzAjQfzZTtOtNgWZLBvecwCJEHRAJicb8A5+fCHJKSLdE8A/Prekl5ST/
        kpzaVDgGq+zc7FTuc5VDR3oZQyrCmn28eJV4L+rs2N0OSzexbC7zy1S32sZBkZVVhCqRpvJc1U3z9
        NNqrU3gA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH2DZ-0002sC-3w; Wed, 25 Mar 2020 09:20:57 +0000
Date:   Wed, 25 Mar 2020 02:20:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 1/2] writeback: avoid double-writing the inode on a
 lazytime expiration
Message-ID: <20200325092057.GA25483@infradead.org>
References: <20200320024639.GH1067245@mit.edu>
 <20200320025255.1705972-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320025255.1705972-1-tytso@mit.edu>
L:      linux-mtd@lists.infradead.org
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

>  	spin_unlock(&inode->i_lock);
>  
> -	if (dirty & I_DIRTY_TIME)
> -		mark_inode_dirty_sync(inode);
> +	/* This was a lazytime expiration; we need to tell the file system */
> +	if (dirty & I_DIRTY_TIME_EXPIRED && inode->i_sb->s_op->dirty_inode)
> +		inode->i_sb->s_op->dirty_inode(inode, I_DIRTY_SYNC);

I think this needs a very clear comment explaining why we don't go
through __mark_inode_dirty.

But as said before I'd rather have a new lazytime_expired operation that
makes it very clear what is happening.  We currenly have 4 file systems
(ext4, f2fs, ubifs and xfs) that support lazytime, so this won't really
be a major churn.
