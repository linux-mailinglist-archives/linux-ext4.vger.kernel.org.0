Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5861A9D8A5
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Aug 2019 23:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfHZVqO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Aug 2019 17:46:14 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40115 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfHZVqN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 26 Aug 2019 17:46:13 -0400
Received: by mail-oi1-f194.google.com with SMTP id h21so13337388oie.7
        for <linux-ext4@vger.kernel.org>; Mon, 26 Aug 2019 14:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hDLxh/wDAnGYgyHQGf1g1WN+KKS1KKuJZAHSWkLXjI4=;
        b=GmYAT3SmGj+RBUcl3L5LUbKUnU/FHOuzvvyRlEOe6I2Ok4m9o71drjyzugItr1am1v
         zIoJOMI9VjsSoGu6b2sntkO4uJsTTJBU1j4dKKI/vz/5+frzAgtIdvICBPZGTDPukFL6
         ixDIzBACP3oZdUdLfxkHfixw+RMVBjN2qYqvaJ55uqD6hBRp6IEwyKqjo7vHnf4Vqnwl
         eRGkpOpoMWnq07kv16F2qoaaTXUHkYoB1ISSeJNu9is2gi7wAVr8An9lgmpRFPhFNIhx
         C5JK+JXQpy1zSXXXqKjUH0DooLByARrpnFx/Neib66nXPbxf/5+MgouztRR20PVeApfg
         uj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hDLxh/wDAnGYgyHQGf1g1WN+KKS1KKuJZAHSWkLXjI4=;
        b=tRUy+0L7f8v11jgF3inzy1G+4EQxjc+x+03XIQbFMpwEZnOKQaccEVE2U/HaIr7LV4
         jBlDqEUh//88HU1a+f4K50vG1gLhAj5bae/uGrvIpn+vMgGuXzSUtUaj6Z0b2UlaeLx4
         KA906WMGMHOgHNCeaPRYpUFpsnBn4wOvOH7/fK8vdAFL4vVNGKqm5IlLJPvH6WfbHRw+
         Ujd4NF972yeUqm7YsMgZ7q4j9iNkGtkpXzDKjLGTOfFnVnjlhblQY3C4T25WnIOiPCao
         CY+c+w36dr4w+1VMNuPzazd2D14Qda1AlWgshx27BsBUO9OY2Q9TQsRycN59B5kTfgR7
         QEYQ==
X-Gm-Message-State: APjAAAW109p9uhtn+t5gjeZsrqy//DS8xbTf/Z8MtqRcdh6t6UZhSurx
        pVT3/ujvAHsHj22ReJBaKOGvkjIf/UDr9yrmbl0=
X-Google-Smtp-Source: APXvYqzV9act9A5OHcjwNpdLOzvElfK9sdAISVJ5r5FacR7lfM02pCrUhkxBnCv0yo76kb/SkfxOnwKR/L6iDK1Aj9A=
X-Received: by 2002:a05:6808:92:: with SMTP id s18mr9525107oic.141.1566855972413;
 Mon, 26 Aug 2019 14:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190821182740.97127-1-harshadshirwadkar@gmail.com> <7303B125-6C0E-41C2-A71E-4AF8C9776468@dilger.ca>
In-Reply-To: <7303B125-6C0E-41C2-A71E-4AF8C9776468@dilger.ca>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 26 Aug 2019 14:46:01 -0700
Message-ID: <CAD+ocbzT=A4LW7CYBC_mxh2cf3ZxUhvffhtpO0LnfkXAJDy0Kw@mail.gmail.com>
Subject: Re: [PATCH] ext4: attempt to shrink directory on dentry removal
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I see, this is an interesting approach. I think we can do this without
modifying on-disk format and by bearing the cost of 2 extra reads per
merge. Whenever dentry deletion results in a dirent block that is
_sufficiently_ empty, we can look at its parent dx block and and find
its neighbors that can be merged. We can be aggressive and do this for
every dentry deletion or we could do this whenever the current dirent
block is half empty or something.

By this method we end up reading up to 2 extra blocks (one previous
and one next) that are not going to be merged. That's the trade-off we
have to make in order to avoid any changes to on-disk structure (If we
modify the on-disk structure and store the fullness in the dx block,
we would read only the blocks that need to be merged).

The same logic can also be applied to intermediate dx nodes as well.
After every merge operation, we'll have a set of blocks that need to
be freed. Once we know what blocks we can free, we can use Ted's idea
of swapping them with the last block, one by one.

Since merging approach also requires a way to free up directory
blocks, I think we could first get a patch in that can free up
directory blocks by swapping with the last block. Once we have that
then we could implement merging.

On Sun, Aug 25, 2019 at 10:07 PM Andreas Dilger <adilger@dilger.ca> wrote:
>
> On Aug 21, 2019, at 12:27 PM, Harshad Shirwadkar <harshadshirwadkar@gmail.com> wrote:
> >
> > On every dentry deletion, this patch traverses directory inode in
> > reverse direction and frees up empty dirent blocks until it finds a
> > non-empty dirent block. We leverage the fact that we never clear
> > dentry name when we delete dentrys by merging them with the previous
> > one. So, even though the dirent block has only fake dentry which spans
> > across the entire block, we can use the name in this dead entry to
> > perform dx lookup and find intermediate dx node blocks as well as
> > offset inside these blocks.
>
>
> One high-level limitation with this implementation is that it is unlikely
> to remove any directory blocks until the directory is almost entirely
> empty since "rm -r" will return entries in hash order, which does not
> match the order that the leaf blocks are allocated in the file.  Even
> worse, if files in the directory are not deleted in hash order, no leaf
> block will be completely empty until about 99% of the files have been
> deleted - assume 24-byte filenames in 4096-byte blocks means up to 128
> entries per block, typically 3/4 full, or 1/96 entries will be left in
> each block before it becomes empty.
>
> One option that was discussed in the past is to use the high 4 bits
> of dx_entry->block (i.e. the opposite of dx_get_block()) to store the
> "fullness" of each block (in 1/16th of a block, or 256-byte increments
> for 4096-byte blocks) and try to merge entries into an adjacent block
> if it becomes mostly empty (e.g. if the current block plus the neighbour
> are below 50% full).  That allows removing blocks much earlier as the
> directory shrinks, rather than waiting until each block is completely
> empty.  A fullness of "0" would mean "unset", since we don't set it
> yet, and once this feature is available there would never be a block
> that is entirely empty.
>
> > As of now, we only support non-indexed directories and indexed
> > directories with no intermediate dx nodes. This technique can also be
> > used to remove intermediate dx nodes. But it needs a little more
> > interesting logic to make that happen since we don't store directory
> > entry name in intermediate nodes.
> >
> > Ran kvm-xfstests smoke test-suite and verified that there are no
> > failures. Also, verified that when all the files are deleted in a
> > directory, directory shrinks to either 4k for non-indexed directories
> > or 8k for indexed directories with 1 level.
> >
> > This patch is an improvement over previous patch that I sent out
> > earlier this month. So, if this patch looks alright, then we can drop
> > the other shrinking patch.
> >
>
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> >
> > ---
> > This patch supersedes the other directory shrinking patch sent in Aug
> > 2019 ("ext4: shrink directory when last block is empty").
> >
> > fs/ext4/namei.c | 176 ++++++++++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 176 insertions(+)
> >
> >
> >
> > +static inline bool is_empty_dirent_block(struct inode *dir,
> > +                                      struct buffer_head *bh)
> > +{
> > +     struct ext4_dir_entry_2 *de = (struct ext4_dir_entry_2 *)bh->b_data;
> > +     int     csum_size = 0;
> > +
> > +     if (ext4_has_metadata_csum(dir->i_sb))
> > +             csum_size = sizeof(struct ext4_dir_entry_tail);
> > +
> > +     return ext4_rec_len_from_disk(de->rec_len, dir->i_sb->s_blocksize) ==
> > +                     dir->i_sb->s_blocksize - csum_size && de->inode == 0;
> > +}
>
> This may not always detect empty directory blocks properly, because
> ext4_generic_delete_entry() will only merge deleted entries with the
> previous entry.  It at least appears possible that if entries are not
> deleted in the proper order (e.g. in reverse of the order they are
> listed in the directory) there may be multiple empty entries in a block,
> and the above check will fail.
>
> Instead, this checks should walk all entries in a block and return false
> if any one of them has a non-zero de->inode.  In the common case there
> may be only a single entry, or the first entry will be used, so it
> should be fairly quick to decide that the block cannot be removed.
>
> Another option is to change ext4_generic_delete_entry() to also try
> to merge with the immediately following entry to ensure that an empty
> block always has rec_len of the full blocksize.  However, I think this
> is probably not a worthwhile effort since it would be better to support
> removing blocks that are partly empty rather than entirely empty.
>
> > @@ -2510,6 +2684,8 @@ static int ext4_delete_entry(handle_t *handle,
> >       if (unlikely(err))
> >               goto out;
> >
> > +     ext4_try_dir_shrink(handle, dir);
> > +
> >       return 0;
>
> I think it would be inefficient to try shrinking the directory after
> _every_ directory entry is removed.  Instead, there should be some
> way to determine here if ext4_generic_delete_entry() removed the last
> entry from the directory block, and only shrink in that case.
>
> Cheers, Andreas
>
>
>
>
>
