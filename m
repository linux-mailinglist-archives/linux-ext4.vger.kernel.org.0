Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C361C13C6B8
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jan 2020 15:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgAOO4u (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Jan 2020 09:56:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60024 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729015AbgAOO4t (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Jan 2020 09:56:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ueg3OFT4kDDVnrKmNSjzXklCJQ8E0kesClJTnzAK4Hw=; b=MULYh9qQhPZifhFoRWQQ4MEro
        40Hq2YrEYrRHHXRHThQgih82mfaN4X/wJ5eee8qJSBPxdNnDWmKqYKOLBPwuYQAKjidtNplUL0hWb
        G6m9o3yZSQrT/uIdSWC/nt2Dp920J4ItjGKZEa0a1rySLUNACa2JYLslwfxzIQL6SJNyP6BhpcpXb
        eZ9p6LwD8iWXOjqcKihqE5iy6m5aTaxAPydLiCylgeAE0F4QNad5HCd7/wwjxQ74dXoqJEwazhiKK
        KOnLa05rzfKIJjcRQ0SDiCewj6A5Iwqvm6jwbRUdRvbN5YooPekV+mYCgh5ZD+5NkidMwyh7uUVFt
        CI8Rkp3lw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irk6B-00049E-3F; Wed, 15 Jan 2020 14:56:47 +0000
Date:   Wed, 15 Jan 2020 06:56:47 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [RFC 1/2] iomap: direct-io: Move inode_dio_begin before
 filemap_write_and_wait_range
Message-ID: <20200115145647.GA8791@infradead.org>
References: <cover.1578907890.git.riteshh@linux.ibm.com>
 <27607a16327fe9664f32d09abe565af0d1ae56c9.1578907891.git.riteshh@linux.ibm.com>
 <20200113215159.GA8235@magnolia>
 <20200114090507.GA6466@quack2.suse.cz>
 <20200114163818.GB7127@infradead.org>
 <20200115091925.GC31450@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115091925.GC31450@quack2.suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 15, 2020 at 10:19:25AM +0100, Jan Kara wrote:
> On Tue 14-01-20 08:38:18, Christoph Hellwig wrote:
> > On Tue, Jan 14, 2020 at 10:05:07AM +0100, Jan Kara wrote:
> > > 
> > > Well, XFS always performs buffered writeback using unwritten extents so at
> > > least the immediate problem of stale data exposure ext4 has does not happen
> > > there AFAICT. 
> > 
> > Currently XFS never uses unwritten extents when converting delalloc
> > extents.
> 
> I see, it is a long time since I last looked at that part of XFS code. So
> then I think XFS might be prone to the same kind of race and data exposure
> as I outlined in [1]...

I think not using unwritten extents for filling holes inside i_size will
always lead to the potential for stale data exposure in one form or
another.  Because of that Darrick has started looking into always using
unwritten extents for buffered writes inside i_size.
