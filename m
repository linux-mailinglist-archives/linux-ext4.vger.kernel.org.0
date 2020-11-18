Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8585A2B763D
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 07:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgKRGWk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 01:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgKRGWk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 01:22:40 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D51C0613D4
        for <linux-ext4@vger.kernel.org>; Tue, 17 Nov 2020 22:22:40 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id f16so699120otl.11
        for <linux-ext4@vger.kernel.org>; Tue, 17 Nov 2020 22:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YtbFnHLC0F4iSC34KfXMYG3W+T/7MuJJbJ93crg4rYY=;
        b=s/0gcm/nu0ykiimxR8WdTqn9/oRW/XbyL4w3MNEAnCfzuYkMI3OFhwyBJe63/t0URk
         MF/eQSENFOP4uuanpMx/bVQmSBCMt9205j/XRDkg2inxeNJhKoi7iACS4a6LKhzYyyPq
         qa4dNN1q0jLGZrs5Lrn7jSqxzCJiOKKH3hQaT5DpJF7rkZje9PEQmxHX/SUM+QIQdrko
         eTsEfmyf6ZOcB2cirE8P2cFHN4xZybxLcNtsGeHE28KzS3mQ7JEffWMaUWI2FOczvsSz
         zEPr9p1knwW2aa2cMoNyVRYTr6BAKJgMrSjOb12HfcwQQj2g7+qML5P4PBXcJLFoIouH
         gSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YtbFnHLC0F4iSC34KfXMYG3W+T/7MuJJbJ93crg4rYY=;
        b=IEamkx+265bBUQt8j8Eej3/dG1awGne0oMW8SQmnjwn8ZmrXumjISGa6fpPsKecnTY
         XQOFA1ZczS1bMgda31WJAGEHwfUIjcAOjeqGJ43oz7U1IdpogBoO6pMgR4txAFMikolC
         CvPrZztmVb1WySws65bRXbXINo8+ctUwAPLm+5uHomzDR9olKdvjLtqdynNO9BRXEMlt
         ryAcueYScX0yE2wvmtSC3IQRNaZZiBTDXZiKZvXfytTMjyqeyI9hx2r8LKK2Hn5DuRPc
         hXF2l9R4/2AMwKgI17UPQORkjZvRV0e3NXy9tKIJUOerBBVihUdlV8O2vMiAB9J/g+pm
         SMFA==
X-Gm-Message-State: AOAM530EhuW3ACPVOBv5O3asSCAjKr02uUu6X9hdSP+xdLV/rTT3C/V2
        LJxZfaqDucoK4nOZhPka687qdpK5AdRYxFyMdEuh1g==
X-Google-Smtp-Source: ABdhPJwWgllZCVW/lRnluvAChVjMF1TDf/msIQVY0NfyaYFdNqL1Ed/ZnJAgja+VBlqEUAJ7Jx61VEi4QbR1tg0v1Z0=
X-Received: by 2002:a9d:8ee:: with SMTP id 101mr5606894otf.93.1605680559385;
 Tue, 17 Nov 2020 22:22:39 -0800 (PST)
MIME-Version: 1.0
References: <20201117040315.28548-1-drosen@google.com> <20201117040315.28548-4-drosen@google.com>
 <X7QbX9Q4xzhg+5UU@sol.localdomain>
In-Reply-To: <X7QbX9Q4xzhg+5UU@sol.localdomain>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Tue, 17 Nov 2020 22:22:28 -0800
Message-ID: <CA+PiJmRQGJP5uHf-yXs=efo++JE+SUmjRizwzH-RGG92RdAxyw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] f2fs: Handle casefolding with Encryption
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chao Yu <chao@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 17, 2020 at 10:50 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
>
> What is the assignment to dentry_page supposed to be accomplishing?  It looks
> like it's meant to pass up errors from f2fs_find_target_dentry(), but it doesn't
> do that.

Woops. Fixed that for the next version.

>
> > @@ -222,14 +250,20 @@ static bool f2fs_match_ci_name(const struct inode *dir, const struct qstr *name,
> >                * fall back to treating them as opaque byte sequences.
> >                */
> >               if (sb_has_strict_encoding(sb) || name->len != entry.len)
> > -                     return false;
> > -             return !memcmp(name->name, entry.name, name->len);
> > +                     res = 0;
> > +             else
> > +                     res = memcmp(name->name, entry.name, name->len) == 0;
> > +     } else {
> > +             /* utf8_strncasecmp_folded returns 0 on match */
> > +             res = (res == 0);
> >       }
>
> The following might be easier to understand:
>
>         /*
>          * In strict mode, ignore invalid names.  In non-strict mode, fall back
>          * to treating them as opaque byte sequences.
>          */
>         if (res < 0 && !sb_has_strict_encoding(sb)) {
>                 res = name->len == entry.len &&
>                       memcmp(name->name, entry.name, name->len) == 0;
>         } else {
>                 /* utf8_strncasecmp_folded returns 0 on match */
>                 res = (res == 0);
>         }
>
Thanks, that is a fair bit nicer.

> > @@ -273,10 +308,14 @@ struct f2fs_dir_entry *f2fs_find_target_dentry(const struct f2fs_dentry_ptr *d,
> >                       continue;
> >               }
> >
> > -             if (de->hash_code == fname->hash &&
> > -                 f2fs_match_name(d->inode, fname, d->filename[bit_pos],
> > -                                 le16_to_cpu(de->name_len)))
> > -                     goto found;
> > +             if (de->hash_code == fname->hash) {
> > +                     res = f2fs_match_name(d->inode, fname, d->filename[bit_pos],
> > +                                 le16_to_cpu(de->name_len));
> > +                     if (res < 0)
> > +                             return ERR_PTR(res);
> > +                     else if (res)
> > +                             goto found;
> > +             }
>
> Overly long line here.  Also 'else if' is unnecessary, just use 'if'.
>
> - Eric
The 0 case is important, since that reflects that the name was not found.
-Daniel
