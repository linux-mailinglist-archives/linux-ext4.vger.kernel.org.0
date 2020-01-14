Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5628013AF90
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Jan 2020 17:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgANQiU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Jan 2020 11:38:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56560 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgANQiU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Jan 2020 11:38:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=br2+5wy1XUss0Zzq9qG1eoVYrKzP4x6pwtXzFGEktTM=; b=a/6SXdFWdAipwwnZQ6ZDKaGKd
        rw8lWIke6achN490NOT1uH3jK+NMI3TzX3+oY8f0r2H4xWnCXICFfpXL7PtvUVD4a2o2Kb4UNriPd
        9VpcELnVBuZC6PHw4vc9hsL64bmtfvm5Xbuw3mLHdJk+uvc2jBfM+UMCO6lskVhZHHdD5kz7dwE9p
        5LszGnrwhAScOVtjXOS3DpTnNh6RGm1wNKIUssDKvtWGOOPPZJTP2yrfUQXiPGYv48EfGU+xe5c7E
        cZKAA9BOTlLGsBf//CzwSeBKOHcGl9Rdfr8m495TK3NO24A0IyAZ/4h61A/Ah9gbLD+senCpoUQs5
        JF/CJuxyg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irPCs-0003CR-3x; Tue, 14 Jan 2020 16:38:18 +0000
Date:   Tue, 14 Jan 2020 08:38:18 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [RFC 1/2] iomap: direct-io: Move inode_dio_begin before
 filemap_write_and_wait_range
Message-ID: <20200114163818.GB7127@infradead.org>
References: <cover.1578907890.git.riteshh@linux.ibm.com>
 <27607a16327fe9664f32d09abe565af0d1ae56c9.1578907891.git.riteshh@linux.ibm.com>
 <20200113215159.GA8235@magnolia>
 <20200114090507.GA6466@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114090507.GA6466@quack2.suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jan 14, 2020 at 10:05:07AM +0100, Jan Kara wrote:
> 
> Well, XFS always performs buffered writeback using unwritten extents so at
> least the immediate problem of stale data exposure ext4 has does not happen
> there AFAICT. 

Currently XFS never uses unwritten extents when converting delalloc
extents.
