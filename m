Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D778A16BECF
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Feb 2020 11:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbgBYKcs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Feb 2020 05:32:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:42102 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729698AbgBYKcr (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 25 Feb 2020 05:32:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A2372AF10;
        Tue, 25 Feb 2020 10:32:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5D47F1E0EA2; Tue, 25 Feb 2020 11:32:44 +0100 (CET)
Date:   Tue, 25 Feb 2020 11:32:44 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        "J. R. Okajima" <hooanon05g@gmail.com>
Subject: Re: [PATCH] ext2: Silence lockdep warning about reclaim under
 xattr_sem
Message-ID: <20200225103244.GB29340@quack2.suse.cz>
References: <20200224125916.17321-1-jack@suse.cz>
 <20200224194655.GA24741@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224194655.GA24741@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 24-02-20 11:46:55, Christoph Hellwig wrote:
> On Mon, Feb 24, 2020 at 01:59:16PM +0100, Jan Kara wrote:
> > +	/*
> > +	 * We are the only ones holding inode reference. The xattr_sem should
> > + 	 * better be unlocked! We could as well just not acquire xattr_sem at
> > +	 * all but this makes the code more futureproof. OTOH we need trylock
> > +	 * here to avoid false-positive warning from lockdep about reclaim
> > +	 * circular dependency.
> > +	 */
> > +	if (WARN_ON(!down_write_trylock(&EXT2_I(inode)->xattr_sem)))
> > +		return;
> 
> Shouldn't this be a WARN_ON_ONCE?  Just in case the impossible happens
> that avoids spamming dmesg over and over.

Fair enough, I'll switch to WARN_ON_ONCE here. Thanks for the review.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
