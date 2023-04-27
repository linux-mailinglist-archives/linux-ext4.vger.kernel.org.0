Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845C46F0BEC
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Apr 2023 20:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243751AbjD0SaC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Apr 2023 14:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244526AbjD0SaB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 Apr 2023 14:30:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E7F4233;
        Thu, 27 Apr 2023 11:29:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F76163EDD;
        Thu, 27 Apr 2023 18:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A881C4339B;
        Thu, 27 Apr 2023 18:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682620198;
        bh=6raNhLsn3jhA9M0ARzpuznsFRAQ+ToAZBcarkGXjIXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LY1esqfSsr+T1h4KHxV5BGlbEae9hsQjTFcKCQz7IApBWWc4dLqhwcheEynTyY6/d
         ntGuE7zatO9/hs8j1IBGxc5aw2uv0DZgpsAa69bDK7+JQBsiB4pUkNETLt6PlcCwQC
         6wo7rBBj0J1ZLfuBqUCAFxqIfiwKoWKLl+xfrLoXXAYO0WvQFmWbrdvOFLew4og1EB
         bOoCfrbEQh0BP9Gxat5DiA/LcMfGCmEd3ziSE2NO9hFfS1rA6i0tv2TVl+CiNC/gLy
         jeGEvV3nebJlu/dhLwI+tW6VS+Hh8xD9ehJJAVISYIkSAWyHXZdD19raASRI8AHeLw
         +e8ZhPxyn7Z/g==
Date:   Thu, 27 Apr 2023 11:29:56 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, yanaijie@huawei.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix unused iterator variable warnings
Message-ID: <20230427182956.GA2970@dev-arch.thelio-3990X>
References: <20230420-ext4-unused-variables-super-c-v1-1-138b6db6c21c@kernel.org>
 <CAMuHMdU0V=b1FLiT4UbNVTa42+5hFx3WJQD6gETwNYioSaSoag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdU0V=b1FLiT4UbNVTa42+5hFx3WJQD6gETwNYioSaSoag@mail.gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Geert,

On Thu, Apr 27, 2023 at 02:36:10PM +0200, Geert Uytterhoeven wrote:
> On Thu, Apr 20, 2023 at 6:56 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > When CONFIG_QUOTA is disabled, there are warnings around unused iterator
> > variables:
> >
> >   fs/ext4/super.c: In function 'ext4_put_super':
> >   fs/ext4/super.c:1262:13: error: unused variable 'i' [-Werror=unused-variable]
> >    1262 |         int i, err;
> >         |             ^
> >   fs/ext4/super.c: In function '__ext4_fill_super':
> >   fs/ext4/super.c:5200:22: error: unused variable 'i' [-Werror=unused-variable]
> >    5200 |         unsigned int i;
> >         |                      ^
> >   cc1: all warnings being treated as errors
> >
> > The kernel has updated to gnu11, allowing the variables to be declared
> > within the for loop. Do so to clear up the warnings.
> >
> > Fixes: dcbf87589d90 ("ext4: factor out ext4_flex_groups_free()")
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thank you for the review!

> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> 
> > @@ -1311,7 +1311,7 @@ static void ext4_put_super(struct super_block *sb)
> >         ext4_flex_groups_free(sbi);
> >         ext4_percpu_param_destroy(sbi);
> >  #ifdef CONFIG_QUOTA
> > -       for (i = 0; i < EXT4_MAXQUOTAS; i++)
> > +       for (int i = 0; i < EXT4_MAXQUOTAS; i++)
> 
> int
> 
> >                 kfree(get_qf_name(sb, sbi, i));
> >  #endif
> >
> 
> > @@ -5628,7 +5627,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
> >  #endif
> >
> >  #ifdef CONFIG_QUOTA
> > -       for (i = 0; i < EXT4_MAXQUOTAS; i++)
> > +       for (unsigned int i = 0; i < EXT4_MAXQUOTAS; i++)
> 
> unsigned int
> 
> >                 kfree(get_qf_name(sb, sbi, i));
> >  #endif
> >         fscrypt_free_dummy_policy(&sbi->s_dummy_enc_policy);
> 
> I do see an opportunity to make this more consistent.
> get_qf_name() takes an int for the last parameter, but that should probably
> become unsigned int?

Yes, or I could have just changed the type of this variable to 'int', as
Arnd did in his version; I just chose to keep the existing type so this
was basically a "no functional change" patch.

https://lore.kernel.org/20230421070815.2260326-1-arnd@kernel.org/

I do not think it fundamentally matters, EXT4_MAXQUOTAS is defined as 3
so I do not think unsigned versus signed semantics matter much here :) I
can make that change in a v2 or separate change or we can just take
Arnd's patch, but this is now in mainline and there is another patch
trying to fix this warning so it would be good to get this dealt with
sooner rather than later...

https://lore.kernel.org/7ca8f790-c14e-6449-f3b5-4214d3fb1e61@googlemail.com/

Cheers,
Nathan
