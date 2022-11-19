Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80665630BFA
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Nov 2022 06:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiKSFCj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 19 Nov 2022 00:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiKSFCh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 19 Nov 2022 00:02:37 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071A4BB9D8
        for <linux-ext4@vger.kernel.org>; Fri, 18 Nov 2022 21:02:36 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 130so6728009pfu.8
        for <linux-ext4@vger.kernel.org>; Fri, 18 Nov 2022 21:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bik3QQ6pg/YzH90Q7ZtQejzzR44Y5fFcHJ5XampnQJ4=;
        b=Gwp8vGRLKz6mSChDqX1wUyEzmRqFxavoy0lEyvuGhw7ZedxZRxpuSSJQOxfaFUAYnA
         /RAvOICJkevlmDHIe3Ia9snlgbvGkkaGrKtzmz63I4Tg91A7P6jDIkilcDFcgCl6nab/
         7v+0rvPbmFmIp+Lgq+rrFTJAogvCFzSBoyLoBFB6ayPSaQgo8Djbl+i6HLojxbCbOT/d
         Y8rBrPTu7nTgJJp5DXgr6IGo9EPD8ubVqX7CE64Z8uc9J8k6lcSUl8fIZFQdTjAclM1c
         diyFRsjZGQ0/rHdfw4FzRL8QsPTGQj/mTwrRTDmoWqzKIqi60VBxGEVxaVph9Yjua1s9
         rHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bik3QQ6pg/YzH90Q7ZtQejzzR44Y5fFcHJ5XampnQJ4=;
        b=56Ls8x322yTXzbqjN7KbneK+YyWshjOw+JbiGkS0iXCi3rEKLw+s6hJaaPAAtbAyLF
         ofbC7v7E1A2fG5zqcvnMWV9+QZEEDkFiGVorcNfkaBjB9cSQ4MIJVpKlFPOM00K146qB
         xSibduNnkxEE2wBj/G2ZXuDwKSNe0G/8ycl3B0Nfga2JhTHYnRLnOqjhFmu91MxUXxXS
         1TrJas/DMVfDvt4WKOxjc/QXZbZWlr9ZKpyjPc0nkwUYkZH/ebRxRAMKnmhoFJRf6ojX
         P3rbiCSbZXErPiidx9fPGXhIDh6kLpphdfPNoAAzQocDGakJMZhBeoaSYp1hmv9wjEid
         EqTQ==
X-Gm-Message-State: ANoB5pnoaa+zMtl0zYH6zeJ0N91xgDPtDYR85NIszxUI+oyTx27bEUC5
        O7xWhNhcz8VWnU04+sH+v28=
X-Google-Smtp-Source: AA0mqf7H6wWeO0T4rsivPFMM12fSn1nEfHXROtNVJlaSYsZgf0lbh4Njd6MQ9ccp7elAWySyaRHRow==
X-Received: by 2002:a63:6645:0:b0:476:cdb8:28fd with SMTP id a66-20020a636645000000b00476cdb828fdmr9602413pgc.358.1668834155376;
        Fri, 18 Nov 2022 21:02:35 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:f6ca:e236:f59f:8c18])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090a708300b00216df8f03fdsm6172638pjk.50.2022.11.18.21.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 21:02:34 -0800 (PST)
Date:   Sat, 19 Nov 2022 10:32:29 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Subject: Re: [RFCv1 12/72] libext2fs: dupfs: Add fs clone & merge api
Message-ID: <20221119050229.xznagyl2v6bmqgvt@riteshh-domain>
References: <e6d1ef1be6dd5a82b223e77d2d6713c1c84aa977.1667822611.git.ritesh.list@gmail.com>
 <78178FB1-8B01-4956-BDBE-751251E2D58A@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78178FB1-8B01-4956-BDBE-751251E2D58A@dilger.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/11/18 12:46PM, Andreas Dilger wrote:
> On Nov 7, 2022, at 05:23, Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:
> > 
> > ﻿From: Saranya Muruganandam <saranyamohan@google.com>
> > 
> > This patch mainly adds "parent" & "clone_flags" member in ext2_filsys struct
> > for enabling multi-threading. Based on what CLONE flags will be passed from
> > the client of libext2fs down to ext2fs_clone_fs(), those structures/bitmaps will
> > be cloned (thread-aware child copy) and rest will be shared with the parent fs.
> > 
> > The same flags will also help to merge those cloned bitmap structures back into
> > the parent bitmaps when ext2fs_merge_fs() will be called with childfs struct.
> > 
> > Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > ---
> > lib/ext2fs/dupfs.c  | 183 ++++++++++++++++++++++++++++++++++++++++++++
> > lib/ext2fs/ext2fs.h |  23 ++++++
> > 2 files changed, 206 insertions(+)
> > 
> > diff --git a/lib/ext2fs/dupfs.c b/lib/ext2fs/dupfs.c
> > index 02721e1a..ecc57cf7 100644
> > --- a/lib/ext2fs/dupfs.c
> > +++ b/lib/ext2fs/dupfs.c
> > @@ -14,8 +14,12 @@
> > #if HAVE_UNISTD_H
> > #include <unistd.h>
> > #endif
> > +#if HAVE_PTHREAD_H
> > +#include <pthread.h>
> > +#endif
> > #include <time.h>
> > #include <string.h>
> > +#include <assert.h>
> > 
> > #include "ext2_fs.h"
> > #include "ext2fsP.h"
> > @@ -120,3 +124,182 @@ errout:
> > 
> > }
> > 
> > +#ifdef HAVE_PTHREAD
> > +errcode_t ext2fs_clone_fs(ext2_filsys fs, ext2_filsys *dest, unsigned int flags)
> > +{
> > +    errcode_t retval;
> > +    ext2_filsys childfs;
> > +
> > +    EXT2_CHECK_MAGIC(fs, EXT2_ET_MAGIC_EXT2FS_FILSYS);
> > +
> > +    retval = ext2fs_get_mem(sizeof(struct struct_ext2_filsys), &childfs);
> > +    if (retval)
> > +        return retval;
> > +
> > +    /* make an exact copy implying lists and memory structures are shared */
> > +    memcpy(childfs, fs, sizeof(struct struct_ext2_filsys));
> > +    childfs->inode_map = NULL;
> > +    childfs->block_map = NULL;
> > +    childfs->badblocks = NULL;
> > +    childfs->dblist = NULL;
> > +
> > +    pthread_mutex_lock(&fs->refcount_mutex);
> > +    fs->refcount++;
> > +    pthread_mutex_unlock(&fs->refcount_mutex);
> 
> The locking her doesn't make sense. Why is the mutex only protecting the "refcount",
> and not the rest of the fields in fs?
> 
> It would make more sense to hold the mutex over the whole copy process, from up before
> the memcpy(), until down after the last structure is cloned. Otherwise, once fs has
> been cloned once and given to another thread it would be possible for them to
> change these structures. 

Ok, so there are two things here. Let's first discuss it from the e2fsck perspective. 
ext2fs_clone_fs() is called in the thread prepare for each thread
sequentially. Also what we are really trying to do here is copy the ext2_filsys
source fs and then all threads will work on their cloned "childfs".

So we don't require any locking, because even when threads will start running,
they will only modify their childfs.

Now.. let's see it from the libext2fs API perspective. So will there be any need
for locking for any other client which might use ext2fs_clone_fs()?
Because the general pthread programming would be like :

start():
	for (t = 0; t < num_threads; t++) {
		clone_contexts() -> ext2fs_clone_fs()
		pthread_run()
		<..>
	}

finish():
	for (t = 0; t < num_threads; t++) {
		pthread_join()
		merge_contexts() -> ext2fs_merge_fs()
	}

So why we don't require any locking here, right? 
Unless ofcourse start() phase can also be called in parallel. 
But that won't be true no.

> 
> > +    if ((flags & EXT2FS_CLONE_INODE) && fs->inode_map) {
> > +        retval = ext2fs_copy_bitmap(fs->inode_map, &childfs->inode_map);
> > +        if (retval)
> > +            return retval;
> > +        childfs->inode_map->fs = childfs;
> > +    }
> > +
> > +    if ((flags & EXT2FS_CLONE_BLOCK) && fs->block_map) {
> > +        retval = ext2fs_copy_bitmap(fs->block_map, &childfs->block_map);
> > +        if (retval)
> > +            return retval;
> > +        childfs->block_map->fs = childfs;
> > +    }
> > +
> > +    if ((flags & EXT2FS_CLONE_BADBLOCKS) && fs->badblocks) {
> > +        retval = ext2fs_badblocks_copy(fs->badblocks, &childfs->badblocks);
> > +        if (retval)
> > +            return retval;
> > +    }
> > +
> > +    if ((flags & EXT2FS_CLONE_DBLIST) && fs->dblist) {
> > +        retval = ext2fs_copy_dblist(fs->dblist, &childfs->dblist);
> > +        if (retval)
> > +            return retval;
> > +        childfs->dblist->fs = childfs;
> > +    }
> > +
> > +    /* icache when NULL will be rebuilt if needed */
> > +    childfs->icache = NULL;
> 
> This should be up where the other NULL values are set. 

ok.

> 
> > +
> > +    childfs->clone_flags = flags;
> > +    childfs->parent = fs;
> > +    *dest = childfs;
> > +
> > +    return 0;
> > +}
> > +
> > +errcode_t ext2fs_merge_fs(ext2_filsys *thread_fs)
> > +{
> > +    ext2_filsys fs = *thread_fs;
> > +    errcode_t retval = 0;
> > +    ext2_filsys dest = fs->parent;
> > +    ext2_filsys src = fs;
> > +    unsigned int flags = fs->clone_flags;
> > +    struct ext2_inode_cache *icache;
> > +    io_channel dest_io;
> > +    io_channel dest_image_io;
> > +    ext2fs_inode_bitmap inode_map;
> > +    ext2fs_block_bitmap block_map;
> > +    ext2_badblocks_list badblocks;
> > +    ext2_dblist dblist;
> > +    void *priv_data;
> > +    int fsflags;
> > +
> > +    pthread_mutex_lock(&fs->refcount_mutex);
> > +    fs->refcount--;
> > +    assert(fs->refcount >= 0);
> > +    pthread_mutex_unlock(&fs->refcount_mutex);
> 
> Same here. The mutex should be held over the whole copy process. 

Again same discussion as above. We don't need to have a lock here, because the
ext2fs_merge_fs() will happen post pthread_join() for each thread.

-ritesh

> 
> Cheers, Andreas
> 
> 
> > +    icache = dest->icache;
> > +    dest_io = dest->io;
> > +    dest_image_io = dest->image_io;
> > +    inode_map = dest->inode_map;
> > +    block_map = dest->block_map;
> > +    badblocks = dest->badblocks;
> > +    dblist = dest->dblist;
> > +    priv_data = dest->priv_data;
> > +    fsflags = dest->flags;
> > +
> > +    memcpy(dest, src, sizeof(struct struct_ext2_filsys));
> > +
> > +    dest->io = dest_io;
> > +    dest->image_io = dest_image_io;
> > +    dest->icache = icache;
> > +    dest->inode_map = inode_map;
> > +    dest->block_map = block_map;
> > +    dest->badblocks = badblocks;
> > +    dest->dblist = dblist;
> > +    dest->priv_data = priv_data;
> > +    if (dest->dblist)
> > +        dest->dblist->fs = dest;
> > +    dest->flags = src->flags | fsflags;
> > +    if (!(src->flags & EXT2_FLAG_VALID) || !(dest->flags & EXT2_FLAG_VALID))
> > +        ext2fs_unmark_valid(dest);
> > +
> > +    if ((flags & EXT2FS_CLONE_INODE) && src->inode_map) {
> > +        if (dest->inode_map == NULL) {
> > +            dest->inode_map = src->inode_map;
> > +            src->inode_map = NULL;
> > +        } else {
> > +            retval = ext2fs_merge_bitmap(src->inode_map, dest->inode_map, NULL, NULL);
> > +            if (retval)
> > +                goto out;
> > +        }
> > +        dest->inode_map->fs = dest;
> > +    }
> > +
> > +    if ((flags & EXT2FS_CLONE_BLOCK) && src->block_map) {
> > +        if (dest->block_map == NULL) {
> > +            dest->block_map = src->block_map;
> > +            src->block_map = NULL;
> > +        } else {
> > +            retval = ext2fs_merge_bitmap(src->block_map, dest->block_map, NULL, NULL);
> > +            if (retval)
> > +                goto out;
> > +        }
> > +        dest->block_map->fs = dest;
> > +    }
> > +
> > +    if ((flags & EXT2FS_CLONE_BADBLOCKS) && src->badblocks) {
> > +        if (dest->badblocks == NULL)
> > +            retval = ext2fs_badblocks_copy(src->badblocks, &dest->badblocks);
> > +        else
> > +            retval = ext2fs_badblocks_merge(src->badblocks, dest->badblocks);
> > +        if (retval)
> > +            goto out;
> > +    }
> > +
> > +    if ((flags & EXT2FS_CLONE_DBLIST) && src->dblist) {
> > +        if (dest->dblist == NULL) {
> > +            dest->dblist = src->dblist;
> > +            src->dblist = NULL;
> > +        } else {
> > +            retval = ext2fs_merge_dblist(src->dblist, dest->dblist);
> > +            if (retval)
> > +                goto out;
> > +        }
> > +        dest->dblist->fs = dest;
> > +    }
> > +
> > +    if (src->icache) {
> > +        ext2fs_free_inode_cache(src->icache);
> > +        src->icache = NULL;
> > +    }
> > +
> > +out:
> > +    if (src->io)
> > +        io_channel_close(src->io);
> > +
> > +    if ((flags & EXT2FS_CLONE_INODE) && src->inode_map)
> > +        ext2fs_free_generic_bmap(src->inode_map);
> > +    if ((flags & EXT2FS_CLONE_BLOCK) && src->block_map)
> > +        ext2fs_free_generic_bmap(src->block_map);
> > +    if ((flags & EXT2FS_CLONE_BADBLOCKS) && src->badblocks)
> > +        ext2fs_badblocks_list_free(src->badblocks);
> > +    if ((flags & EXT2FS_CLONE_DBLIST) && src->dblist) {
> > +        ext2fs_free_dblist(src->dblist);
> > +        src->dblist = NULL;
> > +    }
> > +
> > +    ext2fs_free_mem(&src);
> > +    *thread_fs = NULL;
> > +
> > +    return retval;
> > +}
> > +#endif
> > diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
> > index 139a25fc..b1505f95 100644
> > --- a/lib/ext2fs/ext2fs.h
> > +++ b/lib/ext2fs/ext2fs.h
> > @@ -12,6 +12,10 @@
> > #ifndef _EXT2FS_EXT2FS_H
> > #define _EXT2FS_EXT2FS_H
> > 
> > +#ifdef HAVE_PTHREAD_H
> > +#include <pthread.h>
> > +#endif
> > +
> > #ifdef __GNUC__
> > #define EXT2FS_ATTR(x) __attribute__(x)
> > #else
> > @@ -331,6 +335,13 @@ struct struct_ext2_filsys {
> >    struct ext2fs_hashmap* block_sha_map;
> > 
> >    const struct ext2fs_nls_table *encoding;
> > +
> > +#ifdef HAVE_PTHREAD
> > +    struct struct_ext2_filsys *parent;
> > +    size_t refcount;
> > +    pthread_mutex_t refcount_mutex;
> > +    unsigned int clone_flags;
> > +#endif
> > };
> > 
> > #if EXT2_FLAT_INCLUDES
> > @@ -1057,6 +1068,18 @@ extern errcode_t ext2fs_move_blocks(ext2_filsys fs,
> > /* check_desc.c */
> > extern errcode_t ext2fs_check_desc(ext2_filsys fs);
> > 
> > +#ifdef HAVE_PTHREAD
> > +/* flags for ext2fs_clone_fs */
> > +#define EXT2FS_CLONE_BLOCK            0x0001
> > +#define EXT2FS_CLONE_INODE            0x0002
> > +#define EXT2FS_CLONE_BADBLOCKS        0x0004
> > +#define EXT2FS_CLONE_DBLIST            0x0008
> > +
> > +extern errcode_t ext2fs_clone_fs(ext2_filsys fs, ext2_filsys *dest,
> > +                                 unsigned int flags);
> > +extern errcode_t ext2fs_merge_fs(ext2_filsys *fs);
> > +#endif
> > +
> > /* closefs.c */
> > extern errcode_t ext2fs_close(ext2_filsys fs);
> > extern errcode_t ext2fs_close2(ext2_filsys fs, int flags);
> > -- 
> > 2.37.3
> > 
