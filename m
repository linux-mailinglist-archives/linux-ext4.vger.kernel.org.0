Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7C358B250
	for <lists+linux-ext4@lfdr.de>; Sat,  6 Aug 2022 00:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241667AbiHEWGo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Aug 2022 18:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241626AbiHEWGn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Aug 2022 18:06:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D121211C32
        for <linux-ext4@vger.kernel.org>; Fri,  5 Aug 2022 15:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659737199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zlDrYXgDCUthUhiy73M1xjmezLFpu3vi4ADVmnqoFtM=;
        b=IZZ179FP/9ItWRAObFFeQllCWkBijN1zarTlzOSekT8m1c3A8iTVUmVaq6T5F7iDd3PmTb
        avuzWnfr3EWEru75w6hpPOONLYmtIZMJBYkkUKxndsoiko79gOZyrc2zPbaS+/0Crwpt9o
        StmUl+KbQGTVG1O0yGhpdxAnAfcClWo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-KpOga47ZNQSju1wEwxPoig-1; Fri, 05 Aug 2022 18:06:38 -0400
X-MC-Unique: KpOga47ZNQSju1wEwxPoig-1
Received: by mail-qv1-f71.google.com with SMTP id op9-20020a056214458900b00475a72eeb4dso2111789qvb.11
        for <linux-ext4@vger.kernel.org>; Fri, 05 Aug 2022 15:06:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=zlDrYXgDCUthUhiy73M1xjmezLFpu3vi4ADVmnqoFtM=;
        b=VflJZp8jm4UyR7+hHHvzzNV8Oa28onhnM8fPJiRwhbPfnvOS9J1Lekdi9+4ZCnnrbi
         oGMB4K0FQ4Jjk45i57upwzIrZN3dlHgFCfN7mUt7wnahwipYN9hD2iyj7qE1LrlJrQ03
         hOQKU+putv5u+sezxMZC6zPG187pIbzvRxEZJ16v5aLLOg+ZrXT4ikgYOj00DKXB0KEQ
         3u9cxM+4bndeStvEnCYhyQeLBpmwTd99C3UoQGFFHQHqJ24Xy2P6+rGP77erioRthqN7
         3ZnV+JX1xPuswt+g3UVGCAKEEJhfYmWHTnIoHjf/kAdlI6X54oh3bUo3lNb19u/7fJfn
         zrrQ==
X-Gm-Message-State: ACgBeo0UcqTUOGum00wrcQBk5qqNJKWTBE+UC9znA3Q0Oy3AasXtzVYV
        v8L76qhPKG5k0P5lo92kGnV3ltreGtFv0eYBl/0WblRPdq7efA1Oj4slFQK8Yjk76mSe1xE4ppd
        wOiVbHBflOAWuk3WxgVnm5Q==
X-Received: by 2002:a05:620a:170e:b0:6b8:fa02:6110 with SMTP id az14-20020a05620a170e00b006b8fa026110mr6704342qkb.184.1659737198077;
        Fri, 05 Aug 2022 15:06:38 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7xEDaXjDnYGgwNPYVw0vUMBp/ecTy5raNl40Xwriy8H7D/VAv8N6Y/Htlz8LTyvWjvxbIRbw==
X-Received: by 2002:a05:620a:170e:b0:6b8:fa02:6110 with SMTP id az14-20020a05620a170e00b006b8fa026110mr6704322qkb.184.1659737197860;
        Fri, 05 Aug 2022 15:06:37 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id g18-20020a05620a40d200b006b5f9b7ac87sm4514981qko.26.2022.08.05.15.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 15:06:37 -0700 (PDT)
Message-ID: <c10e4aa381aea86bb51b005887533e28f9c7302b.camel@redhat.com>
Subject: Re: [RFC PATCH 1/4] vfs: report change attribute in statx for
 IS_I_VERSION inodes
From:   Jeff Layton <jlayton@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        lczerner@redhat.com, bxue@redhat.com, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Date:   Fri, 05 Aug 2022 18:06:36 -0400
In-Reply-To: <20220805220136.GG3600936@dread.disaster.area>
References: <20220805183543.274352-1-jlayton@kernel.org>
         <20220805183543.274352-2-jlayton@kernel.org>
         <20220805220136.GG3600936@dread.disaster.area>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, 2022-08-06 at 08:01 +1000, Dave Chinner wrote:
> On Fri, Aug 05, 2022 at 02:35:40PM -0400, Jeff Layton wrote:
> > From: Jeff Layton <jlayton@redhat.com>
> >=20
> > Claim one of the spare fields in struct statx to hold a 64-bit change
> > attribute. When statx requests this attribute, do an
> > inode_query_iversion and fill the result in the field.
> >=20
> > Also update the test-statx.c program to fetch the change attribute as
> > well.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/stat.c                 | 7 +++++++
> >  include/linux/stat.h      | 1 +
> >  include/uapi/linux/stat.h | 3 ++-
> >  samples/vfs/test-statx.c  | 4 +++-
> >  4 files changed, 13 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/stat.c b/fs/stat.c
> > index 9ced8860e0f3..976e0a59ab23 100644
> > --- a/fs/stat.c
> > +++ b/fs/stat.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/syscalls.h>
> >  #include <linux/pagemap.h>
> >  #include <linux/compat.h>
> > +#include <linux/iversion.h>
> > =20
> >  #include <linux/uaccess.h>
> >  #include <asm/unistd.h>
> > @@ -118,6 +119,11 @@ int vfs_getattr_nosec(const struct path *path, str=
uct kstat *stat,
> >  	stat->attributes_mask |=3D (STATX_ATTR_AUTOMOUNT |
> >  				  STATX_ATTR_DAX);
> > =20
> > +	if ((request_mask & STATX_CHGATTR) && IS_I_VERSION(inode)) {
> > +		stat->result_mask |=3D STATX_CHGATTR;
> > +		stat->chgattr =3D inode_query_iversion(inode);
> > +	}
>=20
> If you're going to add generic support for it, shouldn't there be a
> generic test in fstests that ensures that filesystems that advertise
> STATX_CHGATTR support actually behave correctly? Including across
> mounts, and most importantly, that it is made properly stable by
> fsync?
>=20
> i.e. what good is this if different filesystems have random quirks
> that mean it can't be relied on by userspace to tell it changes have
> occurred?

Absolutely. Being able to better test the i_version field for consistent
behavior is a primary goal. I haven't yet written any yet, but we'd
definitely want something in xfstests if we decide this is worthwhile.
--=20
Jeff Layton <jlayton@redhat.com>

