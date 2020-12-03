Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838B82CDD24
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Dec 2020 19:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgLCSLA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Dec 2020 13:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgLCSK7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Dec 2020 13:10:59 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20751C061A4E
        for <linux-ext4@vger.kernel.org>; Thu,  3 Dec 2020 10:10:19 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id l5so3063005edq.11
        for <linux-ext4@vger.kernel.org>; Thu, 03 Dec 2020 10:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CkkIzTHcNkoQ0dByZVg35GBzpnUDxBa+Oe58f61lcQY=;
        b=ovinEIiByd53I02/DilvRE4MPAqKiraY/B7cDD5H7czYugRjW2m5Y3ke/Zc2fSD22I
         ftZg0ME86sqctdkUCDrfJsq2j5VBOOjIylwFQOK93xAYnCJD2XbXcWSBrL15w/YMa1mf
         WoI5SE7JbixMYjkAMBygXBI+vR2tajBRcyAqg/4LQOEsC1LSUMAGQt13FgXHltma3TrT
         Q1yBPk9ENMwkzRg18XkEyrq8oeUsuijoO3P6wfv25YcKp0Z64gENUjECLfjPD5fI5Jse
         7icBwKgjkrcrgV4hV8LDR/mS09OGv5zj1q6OJOJjpXWVLXv/8wtppMU8whPl8zb/nOqS
         ti9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CkkIzTHcNkoQ0dByZVg35GBzpnUDxBa+Oe58f61lcQY=;
        b=j9NDmG5KDFEsprSnQfamSI3k+vZU0s5UcCLO6TMpKnGGrpOJD97QKLg6DnfaPrWEF5
         5YjpDMRKfDBW5xcta++RUfH/JtfDEGQoVLomFheFjhr47AvUCQB/cW7zkSmKqwqt48z8
         AH+BGwEUbwpgmIeEi9jsll8itGC7IjD6Y27mKWhjcOvjprTicj8vqYBmoG+WbGUqd8cw
         NRnNhtzNK9VlB3TgMCXWKuVNVqB99HIfXzBH0rJGZeIqG2GrRXoT3l94d4V8yYcbbBeq
         rlwdsq9+EKAwbXNZDoqFc9up0WDD75AoOmVTRaLExIqBOPN2abwCJ9+2d7n+lSATD3Yv
         9N5Q==
X-Gm-Message-State: AOAM533kMNGGXSx8qFWZx0mNGvTURcxqJb47mU79o9sHGT82omMZ7Tdw
        uy4na0Z2bTJ5XWq0dnuW9vPGlXUayDFV7ULAaXMbWqpSat8=
X-Google-Smtp-Source: ABdhPJyvHcg2b5eNXjIcP+fyDwqqKQo/+M4K2k3uPpcRA4IXLIRY6kDo/gwtH/KTYxehJhEfksodT3ghVSc0+qM8nEo=
X-Received: by 2002:a50:99cb:: with SMTP id n11mr3946251edb.362.1607019017819;
 Thu, 03 Dec 2020 10:10:17 -0800 (PST)
MIME-Version: 1.0
References: <20201120191606.2224881-1-harshadshirwadkar@gmail.com>
 <20201120191606.2224881-3-harshadshirwadkar@gmail.com> <20201202165006.GF390058@mit.edu>
In-Reply-To: <20201202165006.GF390058@mit.edu>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Thu, 3 Dec 2020 10:10:06 -0800
Message-ID: <CAD+ocbwBJ6bREy8h+4kMPAEJMbjbEjpXq6LSPxF=RFBnxiS_ng@mail.gmail.com>
Subject: Re: [PATCH 02/15] ext2fs, e2fsck: add kernel endian-ness conversion macros
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Ah makes sense, sorry I missed that entirely in the patch series, I'll
revisit and will be more careful about what goes in libext2fs.

Thanks,
Harshad


On Wed, Dec 2, 2020 at 8:50 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Fri, Nov 20, 2020 at 11:15:53AM -0800, Harshad Shirwadkar wrote:
> > diff --git a/lib/ext2fs/bitops.h b/lib/ext2fs/bitops.h
> > index 505b3c9c..3c7b2496 100644
> > --- a/lib/ext2fs/bitops.h
> > +++ b/lib/ext2fs/bitops.h
> > @@ -247,6 +247,14 @@ extern errcode_t ext2fs_find_first_set_generic_bmap(ext2fs_generic_bitmap bitmap
> >  #endif /* __STDC_VERSION__ >= 199901L */
> >  #endif /* INCLUDE_INLINE_FUNCS */
> >
> > +/* Macros for kernel compatibility */
> > +#define be32_to_cpu(x)               ext2fs_be32_to_cpu(x)
> > +#define le32_to_cpu(x)               ext2fs_le32_to_cpu(x)
> > +#define le16_to_cpu(x)               ext2fs_le16_to_cpu(x)
> > +
> > +#define cpu_to_be32(x)               ext2fs_cpu_to_be32(x)
> > +#define cpu_to_be16(x)               ext2fs_cpu_to_be16(x)
> > +#define cpu_to_le16(x)               ext2fs_cpu_to_le16(x)
> >  /*
> >   * Fast bit set/clear functions that doesn't need to return the
> >   * previous bit value.
>
> Kernel compatibility #define's should be in e2fsck/jfs_user.h.
>
> The problem with putting them in lib/ext2fs/bitops.h is that this a
> published header file which will be pulled in by external userspace
> applications which #include <ext2fs/ext2fs.h>.  And we don't want to
> have namespace leakage which might interfere with other header files
> or the application's definition of these cpp macros.
>
>                                                 - Ted
