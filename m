Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A112D24481D
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Aug 2020 12:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgHNKd1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 14 Aug 2020 06:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgHNKd1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 14 Aug 2020 06:33:27 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9E6C061383
        for <linux-ext4@vger.kernel.org>; Fri, 14 Aug 2020 03:33:26 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id o23so9424820ejr.1
        for <linux-ext4@vger.kernel.org>; Fri, 14 Aug 2020 03:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LguOciC7MHJQ/KQGeN86n97H2dZJAt+GWDFZdYMkN5A=;
        b=CFmYwkEpPZy6LClBP117PJ6ks+u3S0R03p8ng7HRcrx4t1z7XCla/JA33yA9999T+i
         aIQqcl8cM93+NgApeQx/euBe+d1ifTO+foq2cnpFWeAXX9w1/yH3HfrSk+OQK1Xo6grI
         7u0f8JfY8b49gdAi7dLAwFlAagESvpZCBUEIzbK6V4puHj7K0E9mg1nFjrsdhWJWOayV
         QA0Eg4BETnxaCt8M2jA4Ke655N5Pjilhv3L2w+e+df6Ie3q0kORZNHPHuLD4t/jypzMW
         4RxklHWX7knuh8AVFdsVGjt1DAfDfXVjxahH6244G3YSDg3pUlZTpVLf+1wNAr9VPT8x
         Srwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LguOciC7MHJQ/KQGeN86n97H2dZJAt+GWDFZdYMkN5A=;
        b=hQmZsu9FbXHfhJkBlRC2je7JrMYSBsu4V0lWA1x6/qAgmxY9LR9/g1w35GhGoEumwX
         /7NldeihXPPk2C+STTtVM5y3AhWkVsNmbFPKvot/qra5pKTRnnwJANUM7yLTp9S4Qo0H
         lwhVUXejsixsM2x43X+HN11yVlgjG2AyZ9gjzZblm88F+iTJzBah/2X0ElNDF6jxFmc6
         TIapZwon/pfQxbSn1T2pAuHdgzLEOqWZYmo/6rn1EtQpEsBXKMgTeSnlX+D3Jnqu+1Cj
         ihWxFdXhyimPYa1IphREMOI3m6mH2BcCxl0lqfG/vuB04o3rXsRKMVApNI/V1ED17UMR
         iQ1g==
X-Gm-Message-State: AOAM532pjyFSCKsewnZtOttpCmWeFzm1tk1WUcWPOHWNLLNl5C5CMflx
        BttgapcHc4q63WoZ6vat+LD006FaM2DTsxBetPIALbHxp+AF+Q==
X-Google-Smtp-Source: ABdhPJyFs5IHrJPYWKvjzZQo7789FbMAHZfbpFg/rR8AhHsb9AyhBJ+i2AisxVyn50yv2QnCgMM0xFLhuKU1XyJX7nE=
X-Received: by 2002:a17:906:4a07:: with SMTP id w7mr1647004eju.269.1597401204684;
 Fri, 14 Aug 2020 03:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAPQccj4_Tz-11AfXaSiPj4aRWYU2mX9eJuJyGNR68Mini0PZjw@mail.gmail.com>
 <CAPQccj7XwunXerNYxPBTpBa0JVX7vzC=7aBoE8m35ttFHYNOPg@mail.gmail.com>
 <4D72360F-7836-4C4F-920D-4D1BC1DE704E@dilger.ca> <3cc33ea5-ab63-344e-7251-daa808b855bb@thelounge.net>
In-Reply-To: <3cc33ea5-ab63-344e-7251-daa808b855bb@thelounge.net>
From:   Maciej Jablonski <mafjmafj@gmail.com>
Date:   Fri, 14 Aug 2020 11:33:12 +0100
Message-ID: <CAPQccj4SGG4JMcDMdJff3w-BVpv5vfQm2H4DuSk2X8Wu4o5j0Q@mail.gmail.com>
Subject: Re: libext2fs: mkfs.ext3 really slow on centos 8.2
To:     Reindl Harald <h.reindl@thelounge.net>
Cc:     Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 13 Aug 2020 at 00:14, Reindl Harald <h.reindl@thelounge.net> wrote:
>
>
>
> Am 13.08.20 um 00:45 schrieb Andreas Dilger:
> > On Aug 10, 2020, at 6:37 AM, Maciej Jablonski <mafjmafj@gmail.com> wrote:
> >> On upgrading from centos 7.6 to centos 8.2 mkfs slowed down by orders
> >> of magnitude.
> >>
> >> e.g. 35GB partition from under 8s to 4m+ on the same host.
> >>
> >> Most time is spent on writing the journal to the disk.
> >>
> >> strace shows the following:
> >>
> >> We have got strace which shows that each each block is zeroed with
> >> fallocate and each
> >> invocation of fallocate takes 10ms, this accumulates of course.
> >
> > Do you really need to use mkfs.ext3, or can you use mkfs.ext4 and
> > mount the filesystem as type ext4?  Then you can use the "flexbg"
> > feature and it will not only speed up mkfs but also many other
> > normal operations (e.g. mount, e2fsck, allocation, etc)
>
> typo: it's "flex_bg" and enabled by default (Filesystem created: Sun Aug
>  9 13:24:15 2020)
>
> Filesystem features: has_journal ext_attr resize_inode dir_index
> filetype needs_recovery extent 64bit flex_bg sparse_super large_file
> huge_file dir_nlink extra_isize metadata_csum
>
> ext3 is something of the past for a full decade now

Hi Andreas,

Thanks for the insights,

A bit of background in what circumstances and how widely we see the problem

We run stock OS installers of wide range of linux distros - all
supported versions of RHEL, Ubuntu, Debian, SLES on bare metal
machines  probably 60 different models in total of major brands from
some 5 past generations to current.

And we have noticed that installs of recent distro releases on recent
hardware are just significantly slower,
e.g. RHEL8.0 vs RHEL8.2 went up from 40 minutes to 90 (300GB partition
with default ext3 journal entries) on dell r640 and dell r630
machines. We confirmed at least some of the problems with distros to
be down to mkfs as I mentioned. Note on other machines (older ones)
there is seemingly no difference, we only suspect this might be down
to a disk controller.

We have been historically pegged to ext3, however, it now looks worth
to reconsider ext4.

Thanks,
Maciej
