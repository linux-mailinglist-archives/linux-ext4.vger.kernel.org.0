Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279B75B9DB9
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Sep 2022 16:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiIOOvX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Sep 2022 10:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiIOOvV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Sep 2022 10:51:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACEA6BD64;
        Thu, 15 Sep 2022 07:51:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0B726336BC;
        Thu, 15 Sep 2022 14:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663253479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=32FnE/jPBxSheAV2o1jOqSIv4eKfN7cEfyroXJ6700U=;
        b=1ltI2O8di+dMce5cZ+ybV+YPrcfDK4eYZHGLLr1DNBdBwc3pBx9U1wrrAnQrvEjuVoYPqa
        TeUMuSxSEiYUR8tLNnkv89NYgiwbmBl4nfRtrYNtxn4pyXBRa8DEPNMQfORp78RdZ46TYk
        d4Hx9JZN5BeXD0Z3zKjlXadKIaG64NI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663253479;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=32FnE/jPBxSheAV2o1jOqSIv4eKfN7cEfyroXJ6700U=;
        b=uPrV3f45UBozqpw9Bt/nb07RFtUVIP1YDnUb7Sjjai2qEFmqbcn8PPGRpxiT7IvkGNW8cV
        nx9IPYy3U3EaUmBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F1CE3133B6;
        Thu, 15 Sep 2022 14:51:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iMABO+Y7I2MqBAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 15 Sep 2022 14:51:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 854B6A0682; Thu, 15 Sep 2022 16:51:18 +0200 (CEST)
Date:   Thu, 15 Sep 2022 16:51:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     yebin <yebin10@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 2/2] ext4: adjust fast commit disable judgement
 order in ext4_fc_track_inode
Message-ID: <20220915145118.po7abyz4tnmigpyk@quack3>
References: <20220915135611.3040776-1-yebin10@huawei.com>
 <20220915135611.3040776-3-yebin10@huawei.com>
 <20220915143008.27woacjur6sg32t2@quack3>
 <632339F2.1000802@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <632339F2.1000802@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 15-09-22 22:42:58, yebin wrote:
> 
> 
> On 2022/9/15 22:30, Jan Kara wrote:
> > On Thu 15-09-22 21:56:11, Ye Bin wrote:
> > > Judge filesystem if fast commit disabled before test inode's journal mode.
> > > 
> > > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > Probably makes sense but is there any particular reason why you do this?
> > 
> > 								Honza
> 
> I think the impact of fast commit on normal processes should be minimized.

Yeah, I guess you mean when fastcommit is actually disabled. Makes sense
but please add it to the changelog. With that feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> 
> > 
> > > ---
> > >   fs/ext4/fast_commit.c | 6 +++---
> > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> > > index eadab945b856..9217a588afd1 100644
> > > --- a/fs/ext4/fast_commit.c
> > > +++ b/fs/ext4/fast_commit.c
> > > @@ -577,15 +577,15 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
> > >   	if (S_ISDIR(inode->i_mode))
> > >   		return;
> > > +	if (ext4_fc_disabled(inode->i_sb))
> > > +		return;
> > > +
> > >   	if (ext4_should_journal_data(inode)) {
> > >   		ext4_fc_mark_ineligible(inode->i_sb,
> > >   					EXT4_FC_REASON_INODE_JOURNAL_DATA, handle);
> > >   		return;
> > >   	}
> > > -	if (ext4_fc_disabled(inode->i_sb))
> > > -		return;
> > > -
> > >   	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
> > >   		return;
> > > -- 
> > > 2.31.1
> > > 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
