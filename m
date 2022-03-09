Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297E84D2C8F
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Mar 2022 10:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiCIJxu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Mar 2022 04:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiCIJxu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Mar 2022 04:53:50 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1FBCDF
        for <linux-ext4@vger.kernel.org>; Wed,  9 Mar 2022 01:52:49 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8AD9E210F4;
        Wed,  9 Mar 2022 09:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646819568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U5IcDzlNsbdkZ+2DQb9QEkG5NusgUMbdqFqIDV1gKwg=;
        b=wLhn0w4GgFdVf55DeXi50StjRoFAcxtcS/rcG5G5QvHlDcToTExwUY9QrHSPcwzxcs3cGm
        +h/qZLfWv+HbzjwuHzexIGGkzVR4NslTYIdatPx5lv4XxR1ghg74jVx+WR1gpMownhwZP6
        zqlut0hUyjAlfygrmKM+OBCT7mRCrOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646819568;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U5IcDzlNsbdkZ+2DQb9QEkG5NusgUMbdqFqIDV1gKwg=;
        b=U7flW5pfiM18dfaGaYVmWdqhSlaVuDkodBw3DHxWhx5eTCYsTax3MnjGJosz/ksBcDy9pX
        UVKa7IrXEL4mtSAw==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 76D3BA3B85;
        Wed,  9 Mar 2022 09:52:48 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 25E6DA060B; Wed,  9 Mar 2022 10:52:48 +0100 (CET)
Date:   Wed, 9 Mar 2022 10:52:48 +0100
From:   Jan Kara <jack@suse.cz>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 3/5] ext4: for committing inode, make ext4_fc_track_inode
 wait
Message-ID: <20220309095248.v7kj3ss2kn6kva54@quack3.lan>
References: <20220308105112.404498-1-harshads@google.com>
 <20220308105112.404498-4-harshads@google.com>
 <20220308123020.u4357jwbtoqhy5xd@quack3.lan>
 <CAD+ocbzwGW91MdnwBS2hZ_W+kum-cSpUfAWYJ0jU0xjnt3Y_SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD+ocbzwGW91MdnwBS2hZ_W+kum-cSpUfAWYJ0jU0xjnt3Y_SQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 08-03-22 05:06:51, harshad shirwadkar wrote:
> On Tue, 8 Mar 2022 at 04:30, Jan Kara <jack@suse.cz> wrote:
> > > diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
> > > index 3477a16d08ae..7fa301b0a35a 100644
> > > --- a/fs/ext4/ext4_jbd2.c
> > > +++ b/fs/ext4/ext4_jbd2.c
> > > @@ -106,6 +106,18 @@ handle_t *__ext4_journal_start_sb(struct super_block *sb, unsigned int line,
> > >                                  GFP_NOFS, type, line);
> > >  }
> > >
> > > +handle_t *__ext4_journal_start(struct inode *inode, unsigned int line,
> > > +                               int type, int blocks, int rsv_blocks,
> > > +                               int revoke_creds)
> > > +{
> > > +     handle_t *handle = __ext4_journal_start_sb(inode->i_sb, line,
> > > +                                                type, blocks, rsv_blocks,
> > > +                                                revoke_creds);
> > > +     if (ext4_handle_valid(handle) && !IS_ERR(handle))
> > > +             ext4_fc_track_inode(handle, inode);
> >
> > Why do you need to call ext4_fc_track_inode() here? Calls in
> > ext4_map_blocks() and ext4_mark_iloc_dirty() should be enough, shouldn't
> > they?
> This is just a precautionary call. ext4_fc_track_inode is an
> idempotent function, so it doesn't matter if it gets called multiple
> times. This check just covers cases (such as the ones in inline.c)
> where ext4_reserve_inode_write() doesn't get called. I saw a few
> failures in the log group when I remove this call. The right way to
> fix this though is to ensure that ext4_reserve_inode_write() gets
> called before every inode update.

Oh, you mean like when updating inline data? I'm not sure
ext4_reserve_inode_write() is usable for all the places in inline.c but
yes, you probably need some sprinkling of ext4_fc_track_inode() there. That
would be definitely better than hacking it around in
__ext4_journal_start().

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
