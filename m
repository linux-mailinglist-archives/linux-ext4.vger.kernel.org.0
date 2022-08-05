Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5360B58A5A8
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Aug 2022 07:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbiHEFcz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Aug 2022 01:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbiHEFcx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Aug 2022 01:32:53 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E876E2EF
        for <linux-ext4@vger.kernel.org>; Thu,  4 Aug 2022 22:32:52 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id q190so1512450vsb.7
        for <linux-ext4@vger.kernel.org>; Thu, 04 Aug 2022 22:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=VqYlgAGXiAoAa/2/g8o2yT9r4hnB5QzRJFtJBNinUGI=;
        b=IdFX24PT+M1zvuUajHC7NljKoiDE5FR6IB4ulyslPufjMHogsQ5YcFH1mjYEVSBXsf
         EhSa1MoWq9ybuNYUJeXtQC6lydJKiXHlOVhaZblZN245pMt8gHt0yEFYIOeS/uxWRK6O
         82VlWEOS1xIUeO/s0AYtB/JTM2bwcJLXrp8y0KBLwYzs5F+8fZiv2HxJaNJDCNLC5ets
         sGUk8ofvnKajuyZb05+rHUpucqutk6DifRjfNMSdeA4dj5niwOscwlLNO0TNuchWqH/S
         NIHepNTej/PYzN5bE6PnK2OZ2sGKXAkHDH8x6ef8fbEb52dMaKcXwjU5N3/FQ60AZmwi
         59Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=VqYlgAGXiAoAa/2/g8o2yT9r4hnB5QzRJFtJBNinUGI=;
        b=P0vLHucVNZqnIGpW1VGIogCFh2Wl84yw+NL1+Qd0ULxCZCoq7rxun6Ce8zcXN31Akw
         j8epMpFlSUTNmFU/l3gwi1nIDiHPRZDCt96QBCiIKzCMTdX/ZxrOW11LGOU+uqu5fVAr
         Ysvd2Q6h8RjwkX1XY/ZsDRCd/WnYelnCPHKnaHSylMDnNU87Y3hII+w8zIxSCH2NKP4c
         MFIVEb5++3TrerEf0CIbn0TuQUi86d4Hb65woyG93GWPdHpZz6SkUIm8y/wLEZ2vmN9/
         YVzPsjOFRSKp6/+u40JnJGv+K6R8Vu0YCiXjk9ddKRvYa1M0I3bCat5xhu3j/9em31ac
         O8+w==
X-Gm-Message-State: ACgBeo2sC/RuLyIfwHplPwDTReLYDYpJ31UKDgGGsf4zbPURNaAqXCvz
        oZ8qoxpNhT1JagXdEAa+tcCq6jqQA5YVpoSbPu08Lw==
X-Google-Smtp-Source: AA6agR4tf1x3QqDtZy08f+bprGNL/b/q42LNAakh9z7arUKviqceSRkJXa6zALBVaG3YdqpG83OQRRAHJe9HlW40+hc=
X-Received: by 2002:a05:6102:822:b0:385:48e2:a16f with SMTP id
 k2-20020a056102082200b0038548e2a16fmr2151360vsb.45.1659677571271; Thu, 04 Aug
 2022 22:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <CANFuW3eGgyeWba-2GjDtdhYvX2fV7-dcrHn-4O8QAeHDERAbqw@mail.gmail.com>
 <20220803143113.frmayykhlhvcqkxg@fedora>
In-Reply-To: <20220803143113.frmayykhlhvcqkxg@fedora>
From:   Daniel Ng <danielng@google.com>
Date:   Fri, 5 Aug 2022 15:32:14 +1000
Message-ID: <CANFuW3d5e=0qs+8mQmy+Gd5zJK9NcnJETZ1PAgTgS8E33qG5ng@mail.gmail.com>
Subject: Re: [BUG] fsck unable to resolve filenames that include '='
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org,
        Sarthak Kukreti <sarthakkukreti@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hey Lukas,

that aligns with our observations; I also ran into this when running
tune2fs on the file too.

I'm not very familiar with blkid_get_devname(), but that sounds sensible to me.

Alternatively, my colleague (sarthak@) was suggesting that we could
add a stat() check for the file in the conditional that checks if
there is a '=' character in the
token - which would work for us at least. I suppose it just depends on
what we should prioritize finding. It might make more sense to
prioritize finding
a regular file, before trying to parse the expression. In your
example, the 'LABEL=volume-label' file couldn't ever be selected if
there is also a
device with 'volume-label' (it also seems more likely that in that
situation, the file should be interacted with, over interpreting the
token as an expression).

What are your thoughts behind the ordering (and alluded exploits)?

Kind regards,
Daniel

On Thu, Aug 4, 2022 at 12:31 AM Lukas Czerner <lczerner@redhat.com> wrote:
>
> On Tue, Aug 02, 2022 at 06:21:56PM +1000, Daniel Ng wrote:
> > Hi,
> >
> > I've run into an issue when trying to use fsck with an ext4 image when
> > it has '=' in its name.
> >
> > Repro steps:
> > 1. fallocate -l 1G test=.img
> > 2. mkfs.ext4 test=.img
> > 3. fsck test=.img
> >
> > Response:
> > 'fsck.ext4: Unable to resolve '<path>/test=.img'
> >
> > Expected:
> > fsck to do it's thing.
> >
> > Observations:
> > Originally I wasn't sure what the source was, I thought that maybe
> > mkfs wasn't creating the image appropriately.
> > However, I've tried:
> > - renaming the image
> > - creating a hard-link to the image
> >
> > Running fsck on either the renamed image, or the hard-link, works as expected.
> >
> > Kernel version: Linux version 4.19.251-13516-ga0bcf8d80077
> > Environment: Running on a Chromebook
> >
> > Kind regards,
> > Daniel
>
> Hi Daniel,
>
> yeah, that's a good catch. The problem is that various e2fsprogs tools
> (at least tune2fs and e2fsck) are using blkid_get_devname() to get the
> device name without ever checking if we already got the actual existing
> device name.
>
> The reason to call blkid_get_devname() at all is to get device in the
> form of NAME=value (like for example UUID=uuid, or LABEL=volume-label).
> However if we blindly pass in the device (or in this case regular file)
> name with an equal sign in it, the blkid_get_devname just returns whatever
> it can find by that tag. Which is likely nothing.
>
> Unless of course, you're trying to use e2fsck, or tune2fs on a file with
> an actual filename LABEL=volume-label and you have actual file system
> with 'volume-label' LABEL ;) That's a problematic behavior and depending
> on how we go about fixing it it could be potentialy exploitable...
>
> Maybe something like this:
>
>         1. look for the actual block device first
>         2. if none is found call blkid_get_devname()
>         3. if that didn't return anything maybe see if have a regular
>            file and work with that
>         4. if we still get nothing, then we're "Unable to resolve..."
>
> Thoughts?
>
> -Lukas
>
