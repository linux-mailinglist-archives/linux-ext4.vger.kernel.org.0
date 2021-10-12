Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE494429BAD
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Oct 2021 04:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhJLDAP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Oct 2021 23:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhJLDAO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 11 Oct 2021 23:00:14 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F43C061570
        for <linux-ext4@vger.kernel.org>; Mon, 11 Oct 2021 19:58:13 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id i20so58699422edj.10
        for <linux-ext4@vger.kernel.org>; Mon, 11 Oct 2021 19:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deitcher-net.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6T6KYczfNTjmbcvmUpgVA8bO93YXtTlfRBkczo21+Ls=;
        b=12Wo0VIRo5OPSdJHADChq9o98V1LHTKZLvYi6yvETsT4rA/Q+3kU1EDFY2F6Yc8K4M
         GqK+XxguZ48pQ+zHm3KpXYJbZOSHK0aATYfdej1qgzrDFI3ICz//c/ijUEAQyC4PndQO
         njdxLflt1zq2ntnlUV7ZPhE28QEbSr5G9LdCrSAJxw6t4lyJ2SP1GQyP1kvW3Gz/70ut
         Wx2rJzMaeqT4irlrCXPpvxsih4gd/jVhFt3R8RaENzmk5pcEjcavGhMwpv38jWGwcXqv
         +RmUrEu6gFryPlfZnYLDPcF9v3/RHIsb97TrDvHOcu2XoJE2gjrRw3s2xWYT+3hTy7AL
         ZV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6T6KYczfNTjmbcvmUpgVA8bO93YXtTlfRBkczo21+Ls=;
        b=uC7u0z8KkG1W1JgoWhtXUyvDXksHPz09hJr32+s743ztyLV+ZJvhJ7BVw7xAf6JgjU
         zxvFE9GpRVlPGjvmL3aYQCrSMHK8hc/C/G5py0o0jU4c29wFI0tJ2RflMU2zh7O7YxCX
         U6X4arbIOfkmqwiveND4hCrNYzXwVZIkdKC6EQ2jv5rOMIIc8S2AyAlp5BvbZXDl/UzE
         bjSdM8lDfiU8xaHORVjPNeMed6Lni9poSKeMk5FcWQCPAqmvgfG6+T7gj+Wd9gbqmgiA
         pqr/7NNh+TeDF8tCQOpLjtxBmVvCq9IY8cvEmATxY1cjLxfXNonEyvPsksqCAA3g3nX4
         kDlw==
X-Gm-Message-State: AOAM531l0VBLFx9dUq9q9b5LkvoLya2SH5jc9vjPXFqH7VaiS+UjTKCr
        KlgB3JEHQ7tnY8KovVfMAhZ3ZKX8KHlVtjkMaatoyMHh5wc=
X-Google-Smtp-Source: ABdhPJy/XsV0Q4Bgi++7vk96sWaehsDlxrrvtvw5rmL4A2TvxVtAU/+qadDiFBTnDwmDzH3fE9k4sUpN7KG5FOpMPB8=
X-Received: by 2002:a50:e108:: with SMTP id h8mr47488905edl.42.1634007491817;
 Mon, 11 Oct 2021 19:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAF1vpkgPAy3FJ9mN22OVQ41jQAYoRdoCdqzYwRYYPXD4uucdpg@mail.gmail.com>
 <3A493D20-568A-4D63-A575-5DEEBFAAF41A@dilger.ca> <CAF1vpkigHMdKphnNjDm7=rR6TTxViHGGHi3bb64rsHG7KbqYzQ@mail.gmail.com>
 <CAF1vpkhwSOfGfErUUrp0YU5hSt58TtykTECiJXTcgqDtG0WVVg@mail.gmail.com> <YWSck57bsX/LqAKr@mit.edu>
In-Reply-To: <YWSck57bsX/LqAKr@mit.edu>
From:   Avi Deitcher <avi@deitcher.net>
Date:   Mon, 11 Oct 2021 19:58:00 -0700
Message-ID: <CAF1vpkiKx3jArgjNBrid9-MSHBweGsFL0zu0UgDX_dq_hrkUgw@mail.gmail.com>
Subject: Re: algorithm for half-md4 used in htree directories
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Aha. I missed that the seed is injected into buf before passing it
into half_md4_transform. I was looking at it as just the empty buffer
before the first iteration of the loop (or, in my case, since I was
testing with a 6 char filename, the only iteration).

I will repeat my experiment with that and see if I can tease it out.

Thanks, Ted!

On Mon, Oct 11, 2021 at 1:20 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Oct 11, 2021 at 08:30:36AM -0700, Avi Deitcher wrote:
> > Does someone know how this is constructed and used?
> >
> > On Mon, Oct 4, 2021 at 12:57 AM Avi Deitcher <avi@deitcher.net> wrote:
> > >
> > > Hi Andreas,
> > >
> > > I had looked in __ext4fs_dirhash(). Yes, it does reference the seed -
> > > and create a default if none is there at the filesystem level - but it
> > > doesn't appear to use it, in that function. hinfo is populated in the
> > > function - hash, minor-hash, seed - but it never uses the seed to
> > > manipulate the hash.
>
> The seed is used to initialize the buf array, so long as the seed is
> not all zero's.  If it is all zeros, then the default seed is used
> instead (right above this bit of code:
>
>         if (hinfo->seed) {
>                 for (i = 0; i < 4; i++) {
>                         if (hinfo->seed[i]) {
>                                 memcpy(buf, hinfo->seed, sizeof(buf));
>                                 break;
>                         }
>                 }
>         }
>
> The legacy hash doesn't use the seed, yes.  But for the other hash
> types (hash_version), they mix the filename (in different ways
> depending on the hash type.  For example, for half md4:
>
>         case DX_HASH_HALF_MD4:
>                 p = name;
>                 while (len > 0) {
>                         (*str2hashbuf)(p, len, in, 8);
>                         half_md4_transform(buf, in);
>                                            ^^^
>                         len -= 32;
>                         p += 32;
>                 }
>                 minor_hash = buf[2];
>                 hash = buf[1];
>                 break;
>
> When the hash seed is different, that means the initial state of the
> buf array will different, and this influences the resulting hash.
>
> Cheers,
>
>                                         - Ted



-- 
Avi Deitcher
avi@deitcher.net
Follow me http://twitter.com/avideitcher
Read me http://blog.atomicinc.com
