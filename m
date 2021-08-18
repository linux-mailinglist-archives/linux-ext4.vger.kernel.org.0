Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C030D3F09DC
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Aug 2021 19:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbhHRRE4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Aug 2021 13:04:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60425 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231898AbhHRREr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 18 Aug 2021 13:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629306252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HEJP7HIWBn8mMt7k4XmJIok4RhmUZ7RY4/8EvTqTX6U=;
        b=BwR9kPemq4yWNXmzRQCXKscW45dKRglyzAF4gWmRSn4vTjdwEFdP1+gBP47ccGr20r1+zk
        SkF0Fn2ETeTC7Pk7E8awXpsHuTcJfmUWMh8XK7gzWbz2Y/uA5x5guCDbi+Llw2KdFaixoW
        O+hr/pkxUViEaXaj2QF56mdNKgVmaHk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-Hn7ikQYkOz-yXkesegdlMA-1; Wed, 18 Aug 2021 13:04:10 -0400
X-MC-Unique: Hn7ikQYkOz-yXkesegdlMA-1
Received: by mail-pj1-f72.google.com with SMTP id r13-20020a17090a4dcdb0290176dc35536aso1499414pjl.8
        for <linux-ext4@vger.kernel.org>; Wed, 18 Aug 2021 10:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=HEJP7HIWBn8mMt7k4XmJIok4RhmUZ7RY4/8EvTqTX6U=;
        b=lQ0a7JkXBh5NXb2lIvBkjaxayXJUBSR4BXlMGktn0rNed0I/bONXgk8rJ12OsHpBwE
         5M7C9o4zvAEc8+D4ZLYyhTBUaH0svOn687jNBefuqHO5+Gz1n2mc1wgsP9sLHMv0Di83
         pjoCusZAcW9zJr9Ci1LtUczp5GPeZkCvY2crqZmL03Td69T0EUuzhhE2M19jYDDMKiW7
         wB0RZZF859TRb6HOdsHslB8lbaRHAiBFYIYV3THT60Nr/YR8QpAab/DMr0ehISw7PQT1
         pTcA4u6DDRK0SfCzieqTDbcITqAGyd1rTEZ7HNV90kcpBUoCt3QlVSZoyAU7yoUaEdlC
         vsgg==
X-Gm-Message-State: AOAM532rAbM54CYmsWi0jo3ouCQpY2hEj7cYvm63GD6Aclr11U/28121
        2E5uSRxQd8k9rdJAis+UFd7vQn71bhaQ14CCPyoIj7LYkfhGI10WtMRGbB8CS1yVey0DnkPRHA5
        FNDpehfkv6jIR3luKoPLYFg==
X-Received: by 2002:a63:f154:: with SMTP id o20mr9767021pgk.172.1629306249640;
        Wed, 18 Aug 2021 10:04:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiV0B+pxkwgeEv7B1cWz1zMVlwV1ICw0gS5kmdxk3Ssr7n8n+fPJcpBbOHmbzPD5tf1R4m2Q==
X-Received: by 2002:a63:f154:: with SMTP id o20mr9767001pgk.172.1629306249410;
        Wed, 18 Aug 2021 10:04:09 -0700 (PDT)
Received: from fedora ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j35sm323274pgm.55.2021.08.18.10.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 10:04:09 -0700 (PDT)
Date:   Thu, 19 Aug 2021 01:16:47 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Boyang Xue <bxue@redhat.com>, fstests@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: regression test for "tune2fs -l" after ext4
 shutdown
Message-ID: <20210818171647.pllyrawwdl7cppsl@fedora>
Mail-Followup-To: Jan Kara <jack@suse.cz>, Boyang Xue <bxue@redhat.com>,
        fstests@vger.kernel.org, linux-ext4@vger.kernel.org
References: <20210818084126.4167799-1-bxue@redhat.com>
 <20210818114517.kqvfzu2vd45vuhze@fedora>
 <CAHLe9YZcuo2K6ELT0p1c6sfzwkSgikeiyNect4phEoCt8vTPXw@mail.gmail.com>
 <20210818142601.GF28119@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818142601.GF28119@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 18, 2021 at 04:26:01PM +0200, Jan Kara wrote:
> On Wed 18-08-21 21:20:44, Boyang Xue wrote:
> > > > +
> > > > +# real QA test starts here
> > > > +_supported_fs ext4
> > >
> > > I'm wondering if this case can be a generic case, there's nothing
> > > ext4 specified operations, except this line:
> > >
> > > "$TUNE2FS_PROG -l $SCRATCH_DEV"
> > >
> > > Hmm... if we can change this line to something likes _get_fs_super(),
> > > it might help to make this test to be a generic test.
> > 
> > I think this bug is heavily related to "tune2fs", ext4 only. So I
> > guess an ext4 only test is enough?
> 
> FWIW I agree with Boyang here. For this test to make sense for any other
> filesystem other the filesystem would need to read fs metadata through
> buffer cache in _get_fs_super(). Furthermore it is somewhat ext2/3/4
> specific (due to historical reasons) that reading superblock from the
> buffer cache of a mounted filesystem is expected to result in something
> sensible. Usually this is plain unsupported use...

Thanks for this explanation:) I didn't ask for extending this test to be
a generic test, just checking others ideas:) Due to although tune2fs is
special, but the test steps are common:
1) mkfs
2) mount
3) write io
4) shutdown fs
5) umount && mount
6) read sb from a mounted fs (make sure using tune2fs for ext4)

Anyway, keep this test as ext4 only is fine for me :)

Thanks,
Zorro

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

