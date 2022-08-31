Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2632C5A7B6A
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Aug 2022 12:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiHaKhd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 Aug 2022 06:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiHaKhc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 31 Aug 2022 06:37:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28ECBFC77;
        Wed, 31 Aug 2022 03:37:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5CBCE1F950;
        Wed, 31 Aug 2022 10:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661942246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oAVbXh8Sv4Kg7ajdiS+SYvzgFKQFZzIUQa2MG93qgpo=;
        b=umyq3H6nRIV03g50IC2i4MwmzWhTX1ghqj5L+iJOX33dKCUD4ASbsYwtx4DBm3CNoCMvkW
        /13xidmFGiSczFx7mi00CgOmj0duFNykK0wA4liwa5uFJLccutK203KfJXCO6HDV630lZZ
        ompXQ3SI2D9q5SFllAyx+iruF44srmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661942246;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oAVbXh8Sv4Kg7ajdiS+SYvzgFKQFZzIUQa2MG93qgpo=;
        b=qIrrCmxOq6U1Kslfi91K8+95+8zh9JJlffaohDkTuLa121tAIAze/Xch1l9Gf7icgrNqF0
        HnRuhit5ITd3ecAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 46FEC13A7C;
        Wed, 31 Aug 2022 10:37:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XFREEeY5D2OCZwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 31 Aug 2022 10:37:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CE2A0A067B; Wed, 31 Aug 2022 12:37:25 +0200 (CEST)
Date:   Wed, 31 Aug 2022 12:37:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Yang Xu <xuyang2018.jy@fujitsu.com>,
        fstests@vger.kernel.org, oliver.sang@intel.com, lkp@intel.com,
        linux-ext4@vger.kernel.org, tytso@mit.edu, lczerner@redhat.com
Subject: Re: [PATCH] ext4/053: Remove nouser_xattr test
Message-ID: <20220831103725.j4fpbi75oxzqhyi6@quack3>
References: <1660705823-2172-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220828024858.cf5awn2uksbpchb3@zlang-mailbox>
 <20220829100657.wunvx2twhjzuqckk@quack3>
 <20220831093148.twysch2nhpajrxpq@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831093148.twysch2nhpajrxpq@zlang-mailbox>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 31-08-22 17:31:48, Zorro Lang wrote:
> On Mon, Aug 29, 2022 at 12:06:57PM +0200, Jan Kara wrote:
> > On Sun 28-08-22 10:48:58, Zorro Lang wrote:
> > > On Wed, Aug 17, 2022 at 11:10:23AM +0800, Yang Xu wrote:
> > > > Plan to remove noacl and nouser_xattr mount option in kernel because they
> > > > are deprecated[1]. So remove nouser_xattr test in here.
> > > 
> > > What's the [1]?
> > > 
> > > We'd better to be careful when we want to remove a testing coverage. I'm not
> > > sure if they've decided to removed this mount option, the ext4/053 is an
> > > important test case for ext4, so I'd like to hear their opinion.
> > 
> > Yes, the option is long deprecated and we want to remove it from ext4. But
> > I think you might want to see official ack from Ted as a maintainer on this
> > :). Ted?
> 
> It's fine for me, if anyone stand for ext4 list to give this patch a RVB, due
> to it's not a bug fix or new testing, it's a testing deduction, and only affect
> ext4 testing.

Sure, feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> > > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> > > > ---
> > > >  tests/ext4/053 | 1 -
> > > >  1 file changed, 1 deletion(-)
> > > > 
> > > > diff --git a/tests/ext4/053 b/tests/ext4/053
> > > > index 555e474e..5d2c478a 100755
> > > > --- a/tests/ext4/053
> > > > +++ b/tests/ext4/053
> > > > @@ -439,7 +439,6 @@ for fstype in ext2 ext3 ext4; do
> > > >  	mnt oldalloc removed
> > > >  	mnt orlov removed
> > > >  	mnt -t user_xattr
> > > > -	mnt nouser_xattr
> > > >  
> > > >  	if _has_kernel_config CONFIG_EXT4_FS_POSIX_ACL; then
> > > >  		mnt -t acl
> > > > -- 
> > > > 2.27.0
> > > > 
> > > 
> > -- 
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
> > 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
