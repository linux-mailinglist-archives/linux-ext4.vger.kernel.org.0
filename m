Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3514B9C75C
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Aug 2019 04:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbfHZCrD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 25 Aug 2019 22:47:03 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39336 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729343AbfHZCrD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 25 Aug 2019 22:47:03 -0400
Received: by mail-ot1-f67.google.com with SMTP id b1so13834873otp.6
        for <linux-ext4@vger.kernel.org>; Sun, 25 Aug 2019 19:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o9vhPyEcDXAyczZart37wAoSWs4GspKpb9/ZUwTSn/o=;
        b=eC8WbQVO0rNWMrxlbMjPZ3EJi0abJ3RVN+iwr9Jv65DS7i0eIQOuTNj3k0rGnmXn7y
         hOfSVmJYtUR9GlzWa4D4Uy63avGbe29btTVGC091HNf/0JOUqMjD9QZ/7t4/+/pFh2Qp
         Spmtxcn9G91kST+YOunftUjVhA3G1NsumvfX4rrMCqu5QHt6/3wh/mHp60ucboYRfh4O
         ov83OOofEKGPmQTZh/1sXkshg0+avAmrjQSJw9VzKRXFkPFZuB46ERTPUQNq+ffQEH2r
         nOAiDloscncK9Yh831ucjsrIGzAo+8995S/qZZ3Ao+ZYpk4T1p1rAku4k6SpJVxaBfsQ
         VERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o9vhPyEcDXAyczZart37wAoSWs4GspKpb9/ZUwTSn/o=;
        b=AmJTrcKn2HX2rILszQQPtBBgPmnSipaJYk2LlXkGtRa2hgQ0G4OplOI8eVvMHSNnRq
         26F03gEmT4iNfRLemmIXQ0ifrLElT4clR1ssllggIvaXYAn6yIMaqzDeOJZwueN75QS+
         mxHpTrRifTMmtfs9V9DuOShZi6wZWXVN9ysnBob0N91/P9vuReoYIyPUwi683L30fHTX
         zhXl44fgVRlyFRrj0Us7aWYqli9CSS2/wVPlNyzUb3TmRzycY4qsiJsUyvH8p9ee4oBa
         pAT6w8C/WGhOmrJIyPlMQPcyCQbnvWkma1eaA9lDRE26Xat2RF1Xk9npMpIR9TGyk3Uz
         tjFQ==
X-Gm-Message-State: APjAAAXl2FjBWobg5eEnSDJNGfd1NSAtEaNwMd1OxLkQyshlp0JSgJgO
        cly3LD61shM1A1NZSKk6eGOSlWStzDyaTvDok6A=
X-Google-Smtp-Source: APXvYqzbeEL7TAdUVQp8HR2HuyJ3z/mTUdMmqYytj48gXLKmPfsAjlXjPkIoLpUGKyQLKoOf0ZVLEPbyT+w9yMdugEg=
X-Received: by 2002:a05:6830:2051:: with SMTP id f17mr13111743otp.141.1566787621722;
 Sun, 25 Aug 2019 19:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190821182740.97127-1-harshadshirwadkar@gmail.com> <20190824023110.GB19348@mit.edu>
In-Reply-To: <20190824023110.GB19348@mit.edu>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Sun, 25 Aug 2019 19:46:50 -0700
Message-ID: <CAD+ocbyrJDbUFtQdq087iJCc=41CNACeAA2U_KQG-B4w19Soqw@mail.gmail.com>
Subject: Re: [PATCH] ext4: attempt to shrink directory on dentry removal
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 23, 2019 at 7:31 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Wed, Aug 21, 2019 at 11:27:40AM -0700, Harshad Shirwadkar wrote:
> > As of now, we only support non-indexed directories and indexed
> > directories with no intermediate dx nodes.
>
> From my testing, it doen't work on non-indexed directories; the
> problem is in the is_empty_dirent_block() function.
>
> > This technique can also be used to remove intermediate dx nodes. But
> > it needs a little more interesting logic to make that happen since
> > we don't store directory entry name in intermediate nodes.
>
> Actually, that's not the problem.  An empty dx node is not allowed; in
> a two-level htree directory, if removing an empty leaf node becomes
> causes its parent dx node to become empty, we need to remove the
> parent dx node immediately.  Which is fine, because when we did the
> dx_probe, we know the path from the root to the leaf node.
>
> But removing the parent dx node means we need to be able to remove an
> empty block from the directory, regardless whether it is at the end of
> the directory or not.  OK, so how to do that?
>
> First of all, how to do find any directory block's parent?  If it is a
> leaf node, we can simply calculate the hash on the first directory
> entry (whether it is "dead" or not), and then do a lookup based on
> that hash.  For an intermediate dx node, we can do the same thing,
> since a dx node is simply a list of hashes and block numbers.  The
> first hash in the dx node can be used to do a htree lookup, and that
> will give us the full path from the root of the htree to the dx node.
>
> So, suppose we delete a file, and that causes a leaf node to become
> empty.  We can actually shrink the directory right then and there, and
> not wait until the last block in the directory beomes empty.  How do we do that?
>
> 1) We'll call the logical block number of that empty leaf block Empty,
>    and the block number of the parent of that empty leaf block Parent(Empty).
>    We'll also call the logical block number of the last entry in the
>    directory, Last.
>
> 2) Remove the pointer to Empty from Parent(Empty).  If that causes
>    Parent(Empty) to become empty, we also need to remove the
>    reference to Parent(Empty) in Parent(Parent(Empty)).  (And for 3
>    level htree directories, which are present in Largedir
>    directories, we might also need to do that one more level up.)
>
> 3) To free the directory block Empty, if Empty != Last, we copy the
>    contents of Last into the directory block Empty, and then determine
>    Parent(Last), and find the pointer to Last, and update it to be
>    Empty.  At this point, the last directory block is not in use, so
>    we can release the last directory block, and shrink the size of the
>    directory by one block.

If last is an intermediate dx node, is there a way to find out if it
actually is an intermediate dx node? Because an empty dirent block and
an intermediate dx block look the same. Unless we do dx_probe() there
is no way to know if a block is an intermediate dx block. Is that
right or am I missing something?

Looking at your following comment, if metadata_csum feature is
enabled, then we can distinguish if a block is an empty dirent block
or an index block based on dentry->rec_len. If metadata csum is
enabled, then for index blocks, fake_dentry->rec_len is set to
blocksize while for a dirent not dentry->rec_len is set to blocksize -
sizeof(ext4_dir_entry_tail). Is my understanding correct?

>
> 4) If we need to free Parent(Empty) because it was emptied by step 2,
>    follow the procedure in step 3.
>
> This has a couple of benefits.  The first is that it will work for
> large dx directories, where directory shrinking is most needed.
> Secondly, also allows the directory shrinking to take gradually place
> as the directory is emptied, instead waiting until last directory
> block is empty.  (And for multi-level dx directories that have been
> optimized via e2fsck -fD, the above is needed to allow shrinking from
> the end won't work at all.  Why that is the case is left as an
> exercise to the reader.  Hint: try creating a very large directory and
> optimize it using e2fsck -fD, and see where the index nodes end up.)
>
> BTW, for non-indexed directories, we must always shrink from the end.
> We can't play games with swapping with the last directory block,
> unless we can guarantee that (a) there are no open fd's on the
> directories (since there might be telldir/seekdir cookies that have to
> stay valid), and (b) the directory isn't exported via NFS.  Given that
> establishes these guarantees is tricky, and most of the file systems
> we care about will have indexing enabled, I'm not *that* concerned
> about making directory shrinking working well for non-indexed
> directories.  (Which will tend to only exist from ext2 file systems.)
>
>
> +static inline bool is_empty_dirent_block(struct inode *dir,
> +                                        struct buffer_head *bh)
> +{
> +       struct ext4_dir_entry_2 *de = (struct ext4_dir_entry_2 *)bh->b_data;
> +       int     csum_size = 0;
> +
> +       if (ext4_has_metadata_csum(dir->i_sb))
> +               csum_size = sizeof(struct ext4_dir_entry_tail);
>
> The dx_tail only exists for indexed directories.  So the if statement
> should read:
>
>         if (ext4_has_metadata_csum(dir->i_sb) && is_dx(dir))
>
Ah I see, thanks. I didn't have metadata csum enabled so it worked for
me. Will fix it.

Thanks,
Harshad

>
> > +     /*
> > +      * If i was 0 when we began above loop, we would have overwritten count
> > +      * and limit values sin ce those values live in dx_entry->hash of the
>
> s/sin ce/since/
>
>
> > +     /*
> > +      * Read blocks from directory in reverse orders and clean them up one by
> > +      * one!
> > +      */
>
> s/reverse orders/reverse order/
>
>
> > +             info = &((struct dx_root *)frames[0].bh->b_data)->info;
> > +             if (info->indirect_levels > 0) {
> > +                     /*
> > +                      * We don't shrink in this case. That's because the
> > +                      * block that we just read could very well be an index
> > +                      * block. If it's an index block, we need to do special
> > +                      * handling to delete the block.
>
> Please delete this comment, and replace it with "we don't support dx
> directories with a depth > 2 for now".  See the above discussion...
>
> Cheers,
>
>                                         - Ted
