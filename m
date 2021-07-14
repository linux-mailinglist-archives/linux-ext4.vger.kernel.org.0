Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0315B3C80E4
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jul 2021 11:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238720AbhGNJDG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Jul 2021 05:03:06 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:32790 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238496AbhGNJDF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Jul 2021 05:03:05 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 68B5B229A9;
        Wed, 14 Jul 2021 09:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626253213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n7nexEeSK5d1RlNWBq51iG5GZh9OfW5rJvNt842iUuU=;
        b=EUrCRKCV2F60DcDdTlWu0lFMKHMndJKH+nsSKpRlaenZUrpNUJfmzH5MwlOqTrp3azUzkg
        HFKF4Im+EwwgYg4pI/JegSL/+qTiPjk7p3WdpsGRhpszpVkmmCstlytz8SdKFpq7bv0Gy4
        7bJ5ZxEyTCFBCt2twNwb5QKTYzuLdzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626253213;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n7nexEeSK5d1RlNWBq51iG5GZh9OfW5rJvNt842iUuU=;
        b=USMaLID+E9CO/qjDh+aHtbhP6hXDUg6Tw0N9o8LVQWkNbw4JgScG+7a6E5Ay91JIWfWyHj
        IEE1T+sgZr+jsRAw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 584B2A3BA4;
        Wed, 14 Jul 2021 09:00:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2F1051E0BD1; Wed, 14 Jul 2021 11:00:13 +0200 (CEST)
Date:   Wed, 14 Jul 2021 11:00:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     Javier Pello <javier.pello@urjc.es>
Cc:     Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 1/1] fs/ext2: Avoid page_address on pages returned by
 ext2_get_page
Message-ID: <20210714090013.GA9457@quack2.suse.cz>
References: <20210713165821.8a268e2c1db4fd5cf452acd2@urjc.es>
 <20210713165918.10da0318af5b9b73e599a517@urjc.es>
 <20210713163018.GF24271@quack2.suse.cz>
 <20210713193319.a223cd12e3fb8687f0cae0e8@urjc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713193319.a223cd12e3fb8687f0cae0e8@urjc.es>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 13-07-21 19:33:19, Javier Pello wrote:
> On Tue, 13 Jul 2021 18:30:18, Jan Kara wrote:
> > > @@ -584,16 +584,16 @@ int ext2_add_link (struct dentry *dentry, struct inode *inode)
> > >   * ext2_delete_entry deletes a directory entry by merging it with the
> > >   * previous entry. Page is up-to-date.
> > >   */
> > > -int ext2_delete_entry (struct ext2_dir_entry_2 * dir, struct page * page )
> > > +int ext2_delete_entry (struct ext2_dir_entry_2 *dir, struct page *page,
> > > +                     void *kaddr)
> > 
> > Why not have 'kaddr' as char *. We type it to char * basically everywhere
> > anyway.
> 
> I thought about that, as well, but in the end I leaned towards void *
> because it is a generic pointer, conceptually. Would you rather have it
> be char *?

Well, it depends on how you look at it. We can also think of kaddr as a
start of buffer 'dir' is pointing to. Anyway given this is not some generic
function but a very targetted one with only a few call sites I'd just lean
towards making our life easy and making kaddr char *.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
