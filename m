Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5D95A7A3E
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Aug 2022 11:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiHaJcB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 Aug 2022 05:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiHaJcA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 31 Aug 2022 05:32:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D84C9E84
        for <linux-ext4@vger.kernel.org>; Wed, 31 Aug 2022 02:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661938319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n9sDWo5d7StxOpV9Tn2iRUhL7upGYy5DsD1f6h8ZxAE=;
        b=cIPrhFJs/DKwAU4e4npBa1YJ0ZlykKM/vdRcZexGTX8OpgqE0+aUSkKqXhrnq5OOL67aqJ
        cw0Z5MgJxxhARQlqrfJt/V4joVL3gCrOqtFRvueIJs4FwwZHOsz6cPAcZAZQ/W7J097hOB
        zDc2EaJHEkAiSbbCGNTpDaJ1CXJUX2o=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-645-7kAswe6sNHSk3-Q5UCiJoA-1; Wed, 31 Aug 2022 05:31:57 -0400
X-MC-Unique: 7kAswe6sNHSk3-Q5UCiJoA-1
Received: by mail-qt1-f199.google.com with SMTP id fv24-20020a05622a4a1800b003445e593889so10730850qtb.2
        for <linux-ext4@vger.kernel.org>; Wed, 31 Aug 2022 02:31:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=n9sDWo5d7StxOpV9Tn2iRUhL7upGYy5DsD1f6h8ZxAE=;
        b=j9wH3TwhAm9RLPZ867bhsM5nK8wLgpsMBoyaIwapvdWy9t5c2OFC/vbSlkt1rnBBEV
         fCt4oir5ng1yKvATSs4QpYIxeRdIzi3CRv9sxDf6kp28MVHfdc42ReL8VmLsxzZoJUp4
         VpBcr4/WrfiwPMTv/0hWZv4rz7TjTdKbj7RESYk7tdwAyJ7riTnNz63GPiLoc1aA8vYf
         rl194WleGRUfiTfy6aExjCrxR370NkwpdnWGCT8eKsTqI6OQk418CcMW4ofmnn3Ir/y0
         sx1WHzeh3D7ggraYd2SOJbXmOMz66/4oEflVFR0BsWYXp36wdftJdWEA5iN0dx3bR8vl
         PpCw==
X-Gm-Message-State: ACgBeo2xVj/TxqkO4FB/aGXVYjVA1eBJt5RJcZMzEiDOSbTP9wzdc4X1
        rVTLa6YuC9N4rXKm4RVqrDOAn4ON0mrNTqT+sfFZTuwGPFrwGxFuPnxNev7Sl9zi8Gd1HrI2fww
        aEeNUp0hq/2BOAO+/BeMfQA==
X-Received: by 2002:a05:6214:27c3:b0:498:f448:f7fa with SMTP id ge3-20020a05621427c300b00498f448f7famr17269492qvb.18.1661938317302;
        Wed, 31 Aug 2022 02:31:57 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7TUOpPt16yLfxBTLpHNf6hB8oXsjEuVGBi0TQVXrcV36hhqOh/wOWOo/hUGfvtIYT4tFnCAQ==
X-Received: by 2002:a05:6214:27c3:b0:498:f448:f7fa with SMTP id ge3-20020a05621427c300b00498f448f7famr17269481qvb.18.1661938317091;
        Wed, 31 Aug 2022 02:31:57 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d19-20020ac81193000000b0031f0b43629dsm8272326qtj.23.2022.08.31.02.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 02:31:56 -0700 (PDT)
Date:   Wed, 31 Aug 2022 17:31:48 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Yang Xu <xuyang2018.jy@fujitsu.com>, fstests@vger.kernel.org,
        oliver.sang@intel.com, lkp@intel.com, linux-ext4@vger.kernel.org,
        tytso@mit.edu, lczerner@redhat.com
Subject: Re: [PATCH] ext4/053: Remove nouser_xattr test
Message-ID: <20220831093148.twysch2nhpajrxpq@zlang-mailbox>
References: <1660705823-2172-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220828024858.cf5awn2uksbpchb3@zlang-mailbox>
 <20220829100657.wunvx2twhjzuqckk@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829100657.wunvx2twhjzuqckk@quack3>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 29, 2022 at 12:06:57PM +0200, Jan Kara wrote:
> On Sun 28-08-22 10:48:58, Zorro Lang wrote:
> > On Wed, Aug 17, 2022 at 11:10:23AM +0800, Yang Xu wrote:
> > > Plan to remove noacl and nouser_xattr mount option in kernel because they
> > > are deprecated[1]. So remove nouser_xattr test in here.
> > 
> > What's the [1]?
> > 
> > We'd better to be careful when we want to remove a testing coverage. I'm not
> > sure if they've decided to removed this mount option, the ext4/053 is an
> > important test case for ext4, so I'd like to hear their opinion.
> 
> Yes, the option is long deprecated and we want to remove it from ext4. But
> I think you might want to see official ack from Ted as a maintainer on this
> :). Ted?

It's fine for me, if anyone stand for ext4 list to give this patch a RVB, due
to it's not a bug fix or new testing, it's a testing deduction, and only affect
ext4 testing.

Thanks,
Zorro

> 
> 								Honza
> 
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> > > ---
> > >  tests/ext4/053 | 1 -
> > >  1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/tests/ext4/053 b/tests/ext4/053
> > > index 555e474e..5d2c478a 100755
> > > --- a/tests/ext4/053
> > > +++ b/tests/ext4/053
> > > @@ -439,7 +439,6 @@ for fstype in ext2 ext3 ext4; do
> > >  	mnt oldalloc removed
> > >  	mnt orlov removed
> > >  	mnt -t user_xattr
> > > -	mnt nouser_xattr
> > >  
> > >  	if _has_kernel_config CONFIG_EXT4_FS_POSIX_ACL; then
> > >  		mnt -t acl
> > > -- 
> > > 2.27.0
> > > 
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

