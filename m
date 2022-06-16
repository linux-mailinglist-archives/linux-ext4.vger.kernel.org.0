Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377C954DF8E
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Jun 2022 12:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359357AbiFPKyr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Jun 2022 06:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiFPKyq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Jun 2022 06:54:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208905DE56;
        Thu, 16 Jun 2022 03:54:45 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C3B1B21DA2;
        Thu, 16 Jun 2022 10:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655376883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bUUIZPIJgqXxIabRsFLC/hMdM3P1EPHF6IMeeNQPJ3k=;
        b=oYMOSU/tHdBy+oZDN2Iq4v7D5Z4kSLCJDihrAK7vNLdY/lA0qXDSnivpwLt5scVQ9MQJoH
        aOYj3Uyss26kiP75Llxq934OHm50ytCLnc34defPJ0jpK850LJVlY4PLcCioZbgPsZ0Kb/
        1S0mEEZ32Rr5xuVEd2uG/oDx0KIs3RQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655376883;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bUUIZPIJgqXxIabRsFLC/hMdM3P1EPHF6IMeeNQPJ3k=;
        b=E5uc+W6+fJwJ5d/lHgcS/lfAqmkxxjfYyXaxLUQF5fs1EyV4lxUuoS0Kpo7bFWgWmUuDPC
        Q/Y7jK95MI/eywCA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 82FA22C141;
        Thu, 16 Jun 2022 10:54:43 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 360CFA062E; Thu, 16 Jun 2022 12:54:42 +0200 (CEST)
Date:   Thu, 16 Jun 2022 12:54:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Ye Bin <yebin10@huawei.com>,
        tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ext4: fix bug_on in ext4_iomap_begin as race
 between bmap and write
Message-ID: <20220616105442.cki523p7rdft7svg@quack3.lan>
References: <20220615135850.1961759-1-yebin10@huawei.com>
 <20220615152139.vp64tnv46enwnfcs@riteshh-domain>
 <20220615153123.ab32zt75q7yn7jc5@riteshh-domain>
 <20220615172609.oydxhjw7exas23hd@quack3.lan>
 <20220616063100.mkuqs6cxcqf6u234@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616063100.mkuqs6cxcqf6u234@riteshh-domain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 16-06-22 12:01:00, Ritesh Harjani wrote:
> On 22/06/15 07:26PM, Jan Kara wrote:
> > On Wed 15-06-22 21:01:23, Ritesh Harjani wrote:
> > > > >
> > > > > To solved above issue hold inode lock in ext4_bamp.
> > > > 											^^^ ext4_bmap()
> > > >
> > > > I checked the paths where bmap() kernel api can be called i.e. from jbd2/fc and
> > > > generic_swapfile_activate() (apart from ioctl())
> > > > For jbd2, it will be called with j_inode within bmap(), hence taking a inode lock
> > > > of the inode passed within ext4_bmap() (j_inode in this case) should be safe here.
> > > > Same goes with swapfile path as well.
> > > >
> > > > However I feel maybe we should hold inode_lock_shared() since there is no
> > > > block/extent map layout changes that can happen via ext4_bmap().
> > > > Hence read lock is what IMO should be used here.
> > >
> > > On second thoughts, shoudn't we use ext4_iomap_report_ops here?  Can't
> > > recollect why we didn't use ext4_iomap_report_ops for iomap_bmap() in the
> > > first place. Should be good to verify it once.
> >
> > Hum, but I guess there's a deeper problem than ext4_bmap(). Generally we
> > have places doing block mapping (such as ext4_writepages(), readahead, or
> > page fault) where we don't hold i_rwsem and racing
> > ext4_create_inline_data() could confuse them? I guess we need to come up
> 
> You are right, i_rwsem won't be able to protect against such races which you
> described. So, we actually use EXT4_I(inode)->xattr_sem for inline data
> serialization.

Yes, and that is a problem. Because all the places checking for
ext4_has_inline_data() would have to be protected by xattr_sem (unless they
are already protected by i_rwsem) to make sure we cannot race with inline
data creation which is just unworkable both for performance and I suspect
also lock ordering reasons.

> So for this issue, I think if we should move from ext4_iomap_ops to
> ext4_iomap_report_ops. ext4_iomap_begin_report does takes care of read locking
> xattr_sem to properly report if it's a inline_data and similarly iomap_bmap
> reports 0 (which it should) in case of iomap->type != IOMAP_MAPPED
> (since in this case ext4_iomap_begin_report() will give IOMAP_INLINE)

I don't think the switch to ext4_iomap_report_ops is really correct. We
use ext4_iomap_ops mostly for direct IO and if inline data gets there,
there's indeed a deeper problem. Specifically for ext4_bmap() using i_rwsem
may be acceptable solution but I'm generally against sprinkling locks here
and there without good general locking design how exactly are inline data
operations intended to be synchronized with stuff as writeback, readahead
etc. Because as I wrote above xattr_sem is not really a working answer...

								Honza
