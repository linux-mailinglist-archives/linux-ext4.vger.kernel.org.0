Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B24FE8ABF0
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Aug 2019 02:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfHMAYv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Aug 2019 20:24:51 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45671 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfHMAYv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Aug 2019 20:24:51 -0400
Received: by mail-ot1-f67.google.com with SMTP id m24so13006722otp.12
        for <linux-ext4@vger.kernel.org>; Mon, 12 Aug 2019 17:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sijVWHRV9TEx6Y1Myka1VvCzpLNS0T0c4Yhatkot2nw=;
        b=PYM56I79iL4ebbdM2pzc4Bg3V7V4A+CqcqqIRcGrDBfFVUgc/P/hQFIsCts5ga6rjs
         yE15usCUpyxRKYAhYmafmd7+42NHt1mcwMk+OLkIwQUvumM8vuF5XLYOPJuW2kJACnv4
         WmxOWtw64fcl5p3UArqcq9aY6e946SrBhHe8feICZqnwmV3BmIxaSJ/3UNrrbu+Cs2GC
         +8Z0DvwU2JWiAb8BSXO7elflO7mpiuR9MQwSTdQeaYv8Lt01qf8CD/mdaaaDvZDPGXTm
         SYdAtoL3FP7O95+dhjXgvnX7PCpgWdaJ43GfGT51fCIXqpG9r4+ydK6RzKdqsOjn98RM
         KVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sijVWHRV9TEx6Y1Myka1VvCzpLNS0T0c4Yhatkot2nw=;
        b=eT6VnLeHpNMVXUDyj+cv29gdVRnzsqB2c5DQ+R2TKt4hclTub5JtChEONCAjcFgSok
         9RiGdWXFqF2geWi++xEsSdNIzQxRnP79dG1rwNYl+Z/txv+uygMnp2XGJs/0NcfeWuxh
         InJ1w+hNrNGJ+8rpW9QHt9rbxvHHnQiRCl+0wg3vjZQt4qhF82UMHFXge+McV/PJFFdP
         Lad3ZJfNDYEOoz47+t58yln3wbvT5Hjzj3VhufXyE+URExhsZORf/Twe62IknEsehR/o
         wqviafXFKvn3vD3f5iHBIpe+JJsUtnpWPA12qMU6xpVRM4MgWHKmyifinvbb7Ub03eTQ
         uiiw==
X-Gm-Message-State: APjAAAW70cNrnEBOa8KRpjE3/TLZHPaayB3ejDzeUdKBXbJ0aCidL8cb
        iwBW9ORwALnYNBaD6q7v1/KHwAGAbsdksIKn+fI=
X-Google-Smtp-Source: APXvYqzt1wb/z2bBKFwlTGxPObEuONe4UWI2BUGZP9hEpBs3w7ZZfTpzYd6E9/BWINroCZN6ZFrOLOau7A5K5+PLz/Q=
X-Received: by 2002:aca:3509:: with SMTP id c9mr1267909oia.179.1565655890777;
 Mon, 12 Aug 2019 17:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190227040118.246464-1-harshadshirwadkar@gmail.com> <20190407235836.GA29128@mit.edu>
In-Reply-To: <20190407235836.GA29128@mit.edu>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 12 Aug 2019 17:24:39 -0700
Message-ID: <CAD+ocbyYj77BF-Dhfts4Uf08oAtoKExg=2MWGYP23v7_LqFXTw@mail.gmail.com>
Subject: Re: [PATCH v3] ext4: shrink directory when last block is empty
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger@dilger.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for the review Ted and I'm sorry for the delay in handling
these comments. I have sent out a V4 of this patch where these
comments are handled.


- Harshad


On Sun, Apr 7, 2019 at 4:58 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Tue, Feb 26, 2019 at 08:01:18PM -0800, harshadshirwadkar@gmail.com wrote:
> >
> +static bool
> +ext4_dx_delete_entry(handle_t *handle, struct inode *dir,
> +                    struct dx_frame *dx_frame, __le64 block)
> +{
> >
>
> The function name is a bit problematic.  The ext4_find_entry,
> ext4_dx_find_entry, ext4_delete_entry() all operate on the directory
> entry.  This is doing something different --- it's operating to remove
> the hash tree dx entry.  So something maybe like
> ext4_remove_dx_entry()?  And we definitely need some documentation for
> this function.
>
> Also, I think we can drop last argument, since you can get it from
>  cpu_to_le64(dx_get_block(dx_frame->at)).
>
> > +
> > +static inline bool should_try_dx_delete(struct dx_frame *dx_frame,
> > +                                     struct buffer_head *bh,
> > +                                     struct inode *dir)
> > +{
> > +     return dx_frame && dx_frame->bh && is_empty_dirent_block(dir, bh) &&
> > +                     dx_get_block(dx_frame->at) ==
> > +                     (dir->i_size - 1) >> dir->i_sb->s_blocksize_bits;
> > +}
>
> As above, I'm not sure this is a great name for the function --- and
> for that matter, I'm not sure it's worth it to separate this out.
> First of all, we want to be able to truncate non-indexed directory,
> not just indexed directories.  So moving this logic into
> ext4_delete_entry() probably makes sense.
>
> If the directory is not indexed, it's really trivial to truncate it
> --- and the xfstests change you submitted would fail on file system
> configurations if the dir_index feature is not set, so we should
> really do that simple case while we're at it.
>
>
> > -static struct buffer_head * ext4_find_entry (struct inode *dir,
> > -                                     const struct qstr *d_name,
> > -                                     struct ext4_dir_entry_2 **res_dir,
> > -                                     int *inlined)
> > +static struct buffer_head *ext4_find_entry(struct inode *dir,
> > +                                        const struct qstr *d_name,
> > +                                        struct ext4_dir_entry_2 **res_dir,
> > +                                        int *inlined,
> > +                                        struct dx_frame *dx_frame)
>
> Could you add some documentation for this function --- specifically,
> why a caller might want to pass in dx_frame, and what it's used for?
>
> BTW, ext4_rmdir() should have also been modified to pass in dx_frame
> when calling ext4_find_entry().  Right now with this patch, if the
> last entry is a directory, when it's rmdir'ed, since ext4_rmdir()
> doesn't have the plumbing to pass dx_frame to ext4_delete_entry(),
> we'll end up leaving an empty directory entry on the directory entry.
>
> Thanks,
>
>                                         - Ted
