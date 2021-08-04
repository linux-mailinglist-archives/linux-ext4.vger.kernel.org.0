Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA8B3DFF39
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Aug 2021 12:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237041AbhHDKNq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Aug 2021 06:13:46 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41604 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236732AbhHDKNp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Aug 2021 06:13:45 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4592C1FDBF;
        Wed,  4 Aug 2021 10:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628072012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FaXqzcjJMAeZs3vHNiqSK3m80IufvTb/rXxebHEfq68=;
        b=VamAHRptipuz6UV5hNLaQXbDKfMDaRvHj7XNwOpHLNT3Gs2B8+4FsbqyEu1e1vNaID7aPq
        3vppzaZDqVbt2Av/AedNzf6rhhHS7Ml6vX9g+6O2BR7khiXFYEqNpHkJ7+9UJki8AeYW9T
        ol8PrTqx7xQEzUvMH66tHHDHfvUx5Q0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628072012;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FaXqzcjJMAeZs3vHNiqSK3m80IufvTb/rXxebHEfq68=;
        b=kMnwNxEnrH+a/HFLoCdqqmV2FONr5JrMwbTW2NINbq9gozj2xWRkF2xN0CsicPuX9sq5DH
        yDd6XZ5Jh2msKkDg==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 37530A3B8D;
        Wed,  4 Aug 2021 10:13:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0C47B1E62D6; Wed,  4 Aug 2021 12:13:32 +0200 (CEST)
Date:   Wed, 4 Aug 2021 12:13:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 4/9] libext2fs: Support for orphan file feature
Message-ID: <20210804101332.GB4578@quack2.suse.cz>
References: <20210712154315.9606-1-jack@suse.cz>
 <20210712154315.9606-5-jack@suse.cz>
 <YQl1gGwVSB5+IMCW@mit.edu>
 <20210804092537.GA4578@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804092537.GA4578@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 04-08-21 11:25:37, Jan Kara wrote:
> On Tue 03-08-21 12:57:36, Theodore Ts'o wrote:
> > On Mon, Jul 12, 2021 at 05:43:10PM +0200, Jan Kara wrote:
> > > @@ -825,6 +826,7 @@ struct ext2_super_block {
> > >  #define EXT4_FEATURE_RO_COMPAT_GDT_CSUM		0x0010
> > >  #define EXT4_FEATURE_RO_COMPAT_DIR_NLINK	0x0020
> > >  #define EXT4_FEATURE_RO_COMPAT_EXTRA_ISIZE	0x0040
> > > +#define EXT4_FEATURE_RO_COMPAT_ORPHAN_PRESENT	0x0080
> > >  #define EXT4_FEATURE_RO_COMPAT_QUOTA		0x0100
> > >  #define EXT4_FEATURE_RO_COMPAT_BIGALLOC		0x0200
> > 
> > (This isn't a full review of the patch, but just a quick feedback of
> > what I've noticed so far.)
> > 
> > Since Andreas has requested that we not get rid of the
> > RO_COMPAT_SNAPSHOT, I'm using 0x0400 for
> > EXT4_FEATURE_RO_COMPAT_ORPHAN_PRESENT in my testing.
> 
> Yeah, I'm sorry. Somehow older version of the patch escaped to this posting
> (I've checked and this was the only difference between what I have in git
> and what I have posted).
> 
> > I also noted a number of new GCC warnings when running "make gcc-wall"
> > on lib/ext2fs after applying this commit.
> 
> I'll check these fix them up and repost. Thanks for noticing.

OK, I have all the problems fixed up in my local branch. Since they were
all rather local issues and you have something working in your tree I guess
I'll wait with reposting the series if you have some other review comments.
But feel free to speak up if you want the current state of the series
posted.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
