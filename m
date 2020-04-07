Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6A21A076D
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Apr 2020 08:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgDGGjf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Apr 2020 02:39:35 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42687 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgDGGje (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Apr 2020 02:39:34 -0400
Received: by mail-oi1-f195.google.com with SMTP id e4so557252oig.9
        for <linux-ext4@vger.kernel.org>; Mon, 06 Apr 2020 23:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HaVOfIyHtw1cy1xyl+orHyqrEmhmPWHQrKUL2yDi53A=;
        b=ilAod5DXoeekRa69iP7VHVQOehkPIxt0/W6BMI++qCykV2gcLRM3IPs4+JolZngVjf
         GQcNDW8jfevzQuVHqkwo8bzHijB4rIMLjjlnOv0PwMSJXJpCfmBgMeqs4VvqEZArNqGU
         YUNo+liqk2BrL08EBIbYz2hD5dVoF13/uO4DhZiK4BcojmgCBrjEdE4xBxA3uxcjYCCw
         throACpbivk9iwSDCIA8bAppZ0l95SnLcluGQLVVxxFhUds/3LEjnDbjEO2VxxLevMo2
         Xtpax/IIzwQCDINeTTZ0iC0AT0wz/clMiEc15tVN8MHLa7AlD6zGEad7W28U3upVOQBa
         6FAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HaVOfIyHtw1cy1xyl+orHyqrEmhmPWHQrKUL2yDi53A=;
        b=Eoi7ofQoX1QffPfV1hv070gA1QTFa9mMKy6/HzCkdHr94xXls+Nq7Bl/fcigzDJMjA
         04tsUBtaShEhyQ1LrIfi1EhirIRI65R0Ir4zFxC2LaUJz+G3dATgs9121XQrmxhIh4KP
         wG9U30Qxxp7J82/evuQYIbAfXBI+1P0UklwTOPuGoP15uIAbsfpbzouXXarBX/h2V9+m
         bLRF5INhGtX0FRk1xALurW2O/17Eu/xVAoysMvdHigmqy5cP5Si0zj9AzIkEiXzoV1Iu
         lsgsKqk1IVSb6+k4Z37z/9THs99kxvCCRpd0+btnTchvGgc/9RV3Ob8vMDB1CE6Z41Gz
         h9zA==
X-Gm-Message-State: AGi0PuZx+nktQUHrE1OX0bs3I5cvr8PNwLA30SgT8pU/Qy3x91NGx/gr
        2QOnVTyOQPXEKek1eHSMvVxnM0DD7ixqW0NjBjN0NymF
X-Google-Smtp-Source: APiQypK5IhKGb+AfebzTGOAIOpGzcQQ7il/3zXl9Up/rfnjC7kKiyW0DgnS58JaM6Ju8cA7EtgIzyVq82Ciccd76Lkg=
X-Received: by 2002:aca:4e47:: with SMTP id c68mr618526oib.16.1586241573572;
 Mon, 06 Apr 2020 23:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200325093728.204211-1-harshadshirwadkar@gmail.com>
 <20200325093728.204211-2-harshadshirwadkar@gmail.com> <C2D84F9E-374E-4B3C-8E2E-30A7CD5A0A0C@dilger.ca>
In-Reply-To: <C2D84F9E-374E-4B3C-8E2E-30A7CD5A0A0C@dilger.ca>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 6 Apr 2020 23:39:22 -0700
Message-ID: <CAD+ocbyWikuOLzg+fvAg2jaLfrAvmSiGz1BJXYY-KUaNn2QPPQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ext4: shrink directories on dentry delete
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for the review Andreas.

On Sat, Mar 28, 2020 at 5:01 PM Andreas Dilger <adilger@dilger.ca> wrote:
>
> On Mar 25, 2020, at 3:37 AM, Harshad Shirwadkar <harshadshirwadkar@gmail.com> wrote:
> >
> > This patch adds shrinking support for htree based directories. The
> > high level algorithm is as follows:
> >
> > * If after dentry removal the dirent block (let's call it B) becomes
> >  empty, then remove its references in its dx parent.
> > * Swap its contents with that of the last block (L) in directory.
> > * Update L's parents to point to B instead.
> > * Remove L
> > * Repeat this for all the ancestors of B.
> >
> > We add variants of dx_probe that allow us perform reverse lookups from
> > a logical block to its dx parents.
> >
> > Ran kvm-xfstests smoke and verified that no new failures are
> > introduced. Ran shrinking for directories with following number of
> > files and then deleted files one by one:
> > * 1000 (size before deletion 36K, after deletion 4K)
> > * 10000 (size before deletion 196K, after deletion 4K)
> > * 100000 (size before deletion 2.1M, after deletion 4K)
> > * 200000 (size before deletion 4.2M, after deletion 4K)
> >
> > In all cases directory shrunk significantly. We fallback to linear
> > directories if the directory becomes empty.
> >
> > But note that most of the shrinking happens during last 1-2% deletions
> > in an average case. Therefore, the next step here is to merge dx nodes
> > when possible. That can be achieved by storing the fullness index in
> > htree nodes. But that's an on-disk format change. We can instead build
> > on tooling added by this patch to perform reverse lookup on a dx
> > node and then reading adjacent nodes to check their fullness.
> >
> > This patch supersedes the other directory shrinking patch sent in Aug
> > 2019 ("ext4: attempt to shrink directory on dentry removal").
> >
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> > ---
> > fs/ext4/ext4_jbd2.h |   7 +
> > fs/ext4/namei.c     | 355 ++++++++++++++++++++++++++++++++++++++++++--
> > 2 files changed, 353 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> > index d567b9589875..b78c6f9a6eba 100644
> > --- a/fs/ext4/namei.c
> > +++ b/fs/ext4/namei.c
> >
> > +/*
> > + * dx_probe with relaxed checks. This function is used in the directory
> > + * shrinking code since we can run into intermediate states where we have
> > + * internal dx nodes with count = 0.
> > + */
> > +static inline struct dx_frame *
> > +dx_probe_relaxed(struct ext4_filename *fname, struct inode *dir,
> > +             struct dx_hash_info *hinfo, struct dx_frame *frame_in)
> > +{
> > +     return __dx_probe(fname, dir, hinfo, frame_in, 0, false);
> > +}
> > +
> > +/*
> > + * Perform only a parttial dx_probe until we find block end_lblk.
>
> (typo) "partial"
Ack
>
> > +static inline struct dx_frame *
> > +dx_probe_partial(struct ext4_filename *fname, struct inode *dir,
> > +              struct dx_hash_info *hinfo, struct dx_frame *frame_in,
> > +              ext4_lblk_t end_lblk)
> > +{
> > +     return __dx_probe(fname, dir, hinfo, frame_in, end_lblk, false);
> > +}
> > +
> [snip]
Ack
> > +/*
> > + * This function tries to remove the entry of a dirent block (which was just
> > + * emptied by the caller) from the dx frame. It does so by reducing the count by
> > + * 1 and left shifting all the entries after the deleted entry.
> > + */
> > +int
> > +ext4_remove_dx_entry(handle_t *handle, struct inode *dir,
> > +                  struct dx_frame *dx_frame)
> > +{
> > +     err = ext4_journal_get_write_access(handle, dx_frame->bh);
> > +     if (err) {
> > +             ext4_std_error(dir->i_sb, err);
> > +             return -EINVAL;
> > +     }
> > +
> > +     for (; i < count - 1; i++)
> > +             entries[i] = entries[i + 1];
>
> It would be more efficient to do this with "memmove()" rather than copying
> each entry separately.
Ack, implemented in V2.
>
> > +     /*
> > +      * If i was 0 when we began above loop, we would have overwritten count
> > +      * and limit values since those values live in dx_entry->hash of the
> > +      * first entry. We need to update count but we should set limit as well.
> > +      */
> > +     dx_set_count(entries, count - 1);
> > +     dx_set_limit(entries, limit);
>
> How hard is it to avoid clobbering these fields in the first place?
> I'm just thinking that "clobber + fixup" is subject to race conditions
> at various times in the past, and may become an issue in the future
> (e.g. with parallel directory operations).
>
Ack, I agree better to not clobber in the first place. Implemented in V2.
> > static inline bool is_empty_dirent_block(struct inode *dir,
> > +                                      struct buffer_head *bh)
> > +{
>
> This should be combined with ext4_empty_dir() to avoid code duplication.
Thanks, this also simplifies ext4_empty_dir().
>
> > +     struct ext4_dir_entry_2 *de = (struct ext4_dir_entry_2 *)bh->b_data;
> > +     int     csum_size = 0;
> > +
> > +     if (ext4_has_metadata_csum(dir->i_sb) && is_dx(dir))
> > +             csum_size = sizeof(struct ext4_dir_entry_tail);
> > +
> > +     return ext4_rec_len_from_disk(de->rec_len, dir->i_sb->s_blocksize) ==
> > +                     dir->i_sb->s_blocksize - csum_size && de->inode == 0;
> > +}
>
> This looks like a low cost way to determine the leaf block is empty,
> but checking this for every unlink likely has a non-zero cost.
Ack
>
> > @@ -2530,6 +2864,9 @@ static int ext4_delete_entry(handle_t *handle,
> >       if (unlikely(err))
> >               goto out;
> >
> > +     if (is_dx(dir))
> > +             ext4_try_dir_shrink(handle, dir, lblk, bh);
> > +
> >       return 0;
>
> It would be useful to run a comparison benchmark between the patched ext4
> and unpatched when deleting a large number of entries that checks both CPU
> usage and performance.  That will give us an idea of how much this costs
> to be checked for every entry.
CPU performance wasn't that different fo both the cases, but there are
some differences in overall unlink performance. I added a performance
evaluation section in V2.
>
> Also, rather than calling ext4_try_dir_shrink() and is_empty_dirent_block()
> for every entry, couldn't this be returned from ext4_generic_delete_entry(),
> since it has that information already.
Thanks, implemented this in V2.

Thanks,
Harshad
>
> Cheers, Andreas
>
>
>
>
>
