Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135E528C5A9
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Oct 2020 02:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgJMA2Q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Oct 2020 20:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgJMA2Q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Oct 2020 20:28:16 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2718C0613D0
        for <linux-ext4@vger.kernel.org>; Mon, 12 Oct 2020 17:28:14 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id t25so25745361ejd.13
        for <linux-ext4@vger.kernel.org>; Mon, 12 Oct 2020 17:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jq3ylEy7ho1AeHyh+2rZvlUtRHivnbrF5t78Lgl0Mvs=;
        b=ZuWTBxRq5zel6/EFFT2tJckeM+Ly02WYBVUYEwrUktjf9r39XfqGHgm4r28f8FG+lw
         444Ozp5UA0vO33g+EZrcYXOHKJoOQVlqXNYEAATSfDNk1Pu3b10qURNjluHQAukvb12G
         fJKZYqNmLfyN2UPcfKwzkVlFvATdlJzUTkHa1dQFBTDlYfgouIWnCUIWRXjSSOKyUtuE
         PmiPJradtUgWskyXdnUfsJJ8hK1eQPXDcu/KRTGebN7QfKaAT5zi1cxYc80sAx7x78A5
         YxgJDNKwFz7ZNo7p3juqyg01VMAJp6xiEolH5XtNAU2oWZkkPIILrc8VPESO3/EI++gz
         muAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jq3ylEy7ho1AeHyh+2rZvlUtRHivnbrF5t78Lgl0Mvs=;
        b=czAvkwB3b/dUu84sw+8PFYgbSzE0FeuRd2+alomcRXwdL8rchnWwfG8ZYzUW/z/BJU
         Ouy+lKEjxphRgl9yGOtasQUuHKiS87Y14U2YQ+tnkdFSDqVAEW5Bf0Ey2YJgyLV23VGS
         41nU11hQSGdZ9ePn/Zfl1aLJNa26BB5e3Abjmp9H2EFaZN+cbocJ3rhnEqPn8uWHI71W
         0/aqN+Bg9K+1JVes2S8Az6gVUGBR2T7YVCFiD6/C6twiqo6DfQ5gvrkRewgIuJ8fib94
         IqNJC8BZ7YNiKrt25fH53zVo1bsxumd+8l7KDjpgMWgR2wsQ2Eto5iedxKFb9dLmBhBO
         /i3A==
X-Gm-Message-State: AOAM533uzOLPShaxT0utqWsXQUV/21vlcqR9Oheny3g8Muy82NoNAmmF
        /Upnu57llsn/QTnda70puCgOnEsk52C1Dppom2o=
X-Google-Smtp-Source: ABdhPJwvJ78m+g9qu8itc/o5l8kB71Br3Cir445SMwGQQ7CijIrq4sM2d4HJybPzvLDUYab4bzstPfFziQgFoW5ievk=
X-Received: by 2002:a17:906:ae48:: with SMTP id lf8mr18870448ejb.345.1602548893139;
 Mon, 12 Oct 2020 17:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200919005451.3899779-1-harshadshirwadkar@gmail.com>
 <20200919005451.3899779-4-harshadshirwadkar@gmail.com> <10591a3f-6dad-4e3d-f3f1-f10981cb4fe8@linux.ibm.com>
In-Reply-To: <10591a3f-6dad-4e3d-f3f1-f10981cb4fe8@linux.ibm.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 12 Oct 2020 17:28:01 -0700
Message-ID: <CAD+ocbzsvL3yQ+0q9zOwYeZieNq3+bOda7LUHm5eutPGe-A+EA@mail.gmail.com>
Subject: Re: [PATCH v9 3/9] ext4 / jbd2: add fast commit initialization
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks Ritesh for taking a look at the patches! I know that a couple
of patches in this series are really big, I really appreciate you
taking a look at them!

On Fri, Oct 9, 2020 at 9:10 AM Ritesh Harjani <riteshh@linux.ibm.com> wrote:
>
>
> Sorry about the delay. Few comments below.
>
> On 9/19/20 6:24 AM, Harshad Shirwadkar wrote:
> > This patch adds fast commit area trackers in the journal_t
> > structure. These are initialized via the jbd2_fc_init() routine that
> > this patch adds. This patch also adds ext4/fast_commit.c and
> > ext4/fast_commit.h files for fast commit code that will be added in
> > subsequent patches in this series.
> >
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> > ---
> >   fs/ext4/Makefile      |  2 +-
> >   fs/ext4/ext4.h        |  4 ++++
> >   fs/ext4/fast_commit.c | 20 +++++++++++++++++
> >   fs/ext4/fast_commit.h |  9 ++++++++
> >   fs/ext4/super.c       |  1 +
> >   fs/jbd2/journal.c     | 52 ++++++++++++++++++++++++++++++++++++++-----
> >   include/linux/jbd2.h  | 39 ++++++++++++++++++++++++++++++++
> >   7 files changed, 121 insertions(+), 6 deletions(-)
> >   create mode 100644 fs/ext4/fast_commit.c
> >   create mode 100644 fs/ext4/fast_commit.h
> >
> > diff --git a/fs/ext4/Makefile b/fs/ext4/Makefile
> > index 2e42f47a7f98..49e7af6cc93f 100644
> > --- a/fs/ext4/Makefile
> > +++ b/fs/ext4/Makefile
> > @@ -10,7 +10,7 @@ ext4-y      := balloc.o bitmap.o block_validity.o dir.o ext4_jbd2.o extents.o \
> >               indirect.o inline.o inode.o ioctl.o mballoc.o migrate.o \
> >               mmp.o move_extent.o namei.o page-io.o readpage.o resize.o \
> >               super.o symlink.o sysfs.o xattr.o xattr_hurd.o xattr_trusted.o \
> > -             xattr_user.o
> > +             xattr_user.o fast_commit.o
> >
> >   ext4-$(CONFIG_EXT4_FS_POSIX_ACL)    += acl.o
> >   ext4-$(CONFIG_EXT4_FS_SECURITY)             += xattr_security.o
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index 82e889d5c2ed..9af3971dd12e 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -964,6 +964,7 @@ do {                                                                             \
> >   #endif /* defined(__KERNEL__) || defined(__linux__) */
> >
> >   #include "extents_status.h"
> > +#include "fast_commit.h"
> >
> >   /*
> >    * Lock subclasses for i_data_sem in the ext4_inode_info structure.
> > @@ -2679,6 +2680,9 @@ extern int ext4_init_inode_table(struct super_block *sb,
> >                                ext4_group_t group, int barrier);
> >   extern void ext4_end_bitmap_read(struct buffer_head *bh, int uptodate);
> >
> > +/* fast_commit.c */
> > +
> > +void ext4_fc_init(struct super_block *sb, journal_t *journal);
> >   /* mballoc.c */
> >   extern const struct seq_operations ext4_mb_seq_groups_ops;
> >   extern long ext4_mb_stats;
> > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> > new file mode 100644
> > index 000000000000..0dad8bdb1253
> > --- /dev/null
> > +++ b/fs/ext4/fast_commit.c
> > @@ -0,0 +1,20 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * fs/ext4/fast_commit.c
> > + *
> > + * Written by Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> > + *
> > + * Ext4 fast commits routines.
> > + */
> > +#include "ext4_jbd2.h"
> > +
> > +void ext4_fc_init(struct super_block *sb, journal_t *journal)
> > +{
> > +     if (!test_opt2(sb, JOURNAL_FAST_COMMIT))
> > +             return;
> > +     if (jbd2_fc_init(journal, EXT4_NUM_FC_BLKS)) {
> > +             pr_warn("Error while enabling fast commits, turning off.");
> > +             ext4_clear_feature_fast_commit(sb);
> > +     }
> > +}
> > diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
> > new file mode 100644
> > index 000000000000..8362bf5e6e00
> > --- /dev/null
> > +++ b/fs/ext4/fast_commit.h
> > @@ -0,0 +1,9 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef __FAST_COMMIT_H__
> > +#define __FAST_COMMIT_H__
> > +
> > +/* Number of blocks in journal area to allocate for fast commits */
> > +#define EXT4_NUM_FC_BLKS             256
>
> Just wanted to understand how is this value determined?
> Do you think this needs to be configurable?
> Just thinking since, on some platforms blksz could be of 64K.
I see, I chose this value experimentally. In my experiments with very
aggressive journal commits, (such as fs_mark and NFS), I found that
256 blocks was enough to guarantee that this space doesn't get filled
up before the mandatory periodic full commit (happening at default of
5 seconds). But I realize that it's probably better to make this
configurable. Another option is to have this value be statically
defined as a percentage of the total number of blocks available for
JBD2. The latter has the advantage that we don't need on-disk format
doesn't need to be updated. Performance gains with fast commits are
achieved by delaying full commits as much as possible.
>
> > +
> > +#endif /* __FAST_COMMIT_H__ */
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index b62858ee420b..94aaaf940449 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -4962,6 +4962,7 @@ static void ext4_init_journal_params(struct super_block *sb, journal_t *journal)
> >       journal->j_commit_interval = sbi->s_commit_interval;
> >       journal->j_min_batch_time = sbi->s_min_batch_time;
> >       journal->j_max_batch_time = sbi->s_max_batch_time;
> > +     ext4_fc_init(sb, journal);
> >
> >       write_lock(&journal->j_state_lock);
> >       if (test_opt(sb, BARRIER))
> > diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> > index 17fdc482f554..736a1736619f 100644
> > --- a/fs/jbd2/journal.c
> > +++ b/fs/jbd2/journal.c
> > @@ -1179,6 +1179,14 @@ static journal_t *journal_init_common(struct block_device *bdev,
> >       if (!journal->j_wbuf)
> >               goto err_cleanup;
> >
> > +     if (journal->j_fc_wbufsize > 0) {
> > +             journal->j_fc_wbuf = kmalloc_array(journal->j_fc_wbufsize,
> > +                                     sizeof(struct buffer_head *),
> > +                                     GFP_KERNEL);
> > +             if (!journal->j_fc_wbuf)
> > +                     goto err_cleanup;
> > +     }
> > +
> >       bh = getblk_unmovable(journal->j_dev, start, journal->j_blocksize);
> >       if (!bh) {
> >               pr_err("%s: Cannot get buffer for journal superblock\n",
> > @@ -1192,11 +1200,22 @@ static journal_t *journal_init_common(struct block_device *bdev,
> >
> >   err_cleanup:
> >       kfree(journal->j_wbuf);
> > +     kfree(journal->j_fc_wbuf);
> >       jbd2_journal_destroy_revoke(journal);
> >       kfree(journal);
> >       return NULL;
> >   }
> >
> > +int jbd2_fc_init(journal_t *journal, int num_fc_blks)
> > +{
> > +     journal->j_fc_wbufsize = num_fc_blks;
> > +     journal->j_fc_wbuf = kmalloc_array(journal->j_fc_wbufsize,
> > +                             sizeof(struct buffer_head *), GFP_KERNEL);
> > +     if (!journal->j_fc_wbuf)
> > +             return -ENOMEM;
> > +     return 0;
> > +}
> > +
> >   /* jbd2_journal_init_dev and jbd2_journal_init_inode:
> >    *
> >    * Create a journal structure assigned some fixed set of disk blocks to
> > @@ -1314,11 +1333,20 @@ static int journal_reset(journal_t *journal)
> >       }
> >
> >       journal->j_first = first;
> > -     journal->j_last = last;
> >
> > -     journal->j_head = first;
> > -     journal->j_tail = first;
> > -     journal->j_free = last - first;
> > +     if (jbd2_has_feature_fast_commit(journal) &&
> > +         journal->j_fc_wbufsize > 0) {
> > +             journal->j_last_fc = last;
> > +             journal->j_last = last - journal->j_fc_wbufsize;
> > +             journal->j_first_fc = journal->j_last + 1;
> > +             journal->j_fc_off = 0;
> > +     } else {
> > +             journal->j_last = last;
> > +     }
> > +
> > +     journal->j_head = journal->j_first;
> > +     journal->j_tail = journal->j_first;
> > +     journal->j_free = journal->j_last - journal->j_first;
> >
> >       journal->j_tail_sequence = journal->j_transaction_sequence;
> >       journal->j_commit_sequence = journal->j_transaction_sequence - 1;
> > @@ -1663,9 +1691,18 @@ static int load_superblock(journal_t *journal)
> >       journal->j_tail_sequence = be32_to_cpu(sb->s_sequence);
> >       journal->j_tail = be32_to_cpu(sb->s_start);
> >       journal->j_first = be32_to_cpu(sb->s_first);
> > -     journal->j_last = be32_to_cpu(sb->s_maxlen);
> >       journal->j_errno = be32_to_cpu(sb->s_errno);
> >
> > +     if (jbd2_has_feature_fast_commit(journal) &&
> > +         journal->j_fc_wbufsize > 0) {
> > +             journal->j_last_fc = be32_to_cpu(sb->s_maxlen);
> > +             journal->j_last = journal->j_last_fc - journal->j_fc_wbufsize;
> > +             journal->j_first_fc = journal->j_last + 1;
> > +             journal->j_fc_off = 0;
> > +     } else {
> > +             journal->j_last = be32_to_cpu(sb->s_maxlen);
> > +     }
> > +
> >       return 0;
> >   }
> >
> > @@ -1726,6 +1763,9 @@ int jbd2_journal_load(journal_t *journal)
> >        */
> >       journal->j_flags &= ~JBD2_ABORT;
> >
> > +     if (journal->j_fc_wbufsize > 0)
> > +             jbd2_journal_set_features(journal, 0, 0,
> > +                                       JBD2_FEATURE_INCOMPAT_FAST_COMMIT);
> >       /* OK, we've finished with the dynamic journal bits:
> >        * reinitialise the dynamic contents of the superblock in memory
> >        * and reset them on disk. */
> > @@ -1809,6 +1849,8 @@ int jbd2_journal_destroy(journal_t *journal)
> >               jbd2_journal_destroy_revoke(journal);
> >       if (journal->j_chksum_driver)
> >               crypto_free_shash(journal->j_chksum_driver);
> > +     if (journal->j_fc_wbufsize > 0)
> > +             kfree(journal->j_fc_wbuf);
> >       kfree(journal->j_wbuf);
> >       kfree(journal);
> >
> > diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> > index f438257d7f31..36f65a818366 100644
> > --- a/include/linux/jbd2.h
> > +++ b/include/linux/jbd2.h
> > @@ -915,6 +915,30 @@ struct journal_s
> >        */
> >       unsigned long           j_last;
> >
> > +     /**
> > +      * @j_first_fc:
> > +      *
> > +      * The block number of the first fast commit block in the journal
> > +      * [j_state_lock].
> > +      */
> > +     unsigned long           j_first_fc;
> > +
> > +     /**
> > +      * @j_fc_off:
> > +      *
> > +      * Number of fast commit blocks currently allocated.
> > +      * [j_state_lock].
> > +      */
> > +     unsigned long           j_fc_off;
>
> I guess choosing a single naming convention for fast commit would be
> very helpful for grepping/searching.
> So for e.g. we could have everything using j_fc_**
> If you agree, then we may have to change other members of this structure
> accordingly.
That makes sense, I'll rename the variables / functions where this
convention is not followed.

Thanks,
Harshad

>
> -ritesh
>
> > +
> > +     /**
> > +      * @j_last_fc:
> > +      *
> > +      * The block number one beyond the last fast commit block in the journal
> > +      * [j_state_lock].
> > +      */
> > +     unsigned long           j_last_fc;
> > +
> >       /**
> >        * @j_dev: Device where we store the journal.
> >        */
> > @@ -1065,6 +1089,12 @@ struct journal_s
> >        */
> >       struct buffer_head      **j_wbuf;
> >
> > +     /**
> > +      * @j_fc_wbuf: Array of fast commit bhs for
> > +      * jbd2_journal_commit_transaction.
> > +      */
> > +     struct buffer_head      **j_fc_wbuf;
> > +
> >       /**
> >        * @j_wbufsize:
> >        *
> > @@ -1072,6 +1102,13 @@ struct journal_s
> >        */
> >       int                     j_wbufsize;
> >
> > +     /**
> > +      * @j_fc_wbufsize:
> > +      *
> > +      * Size of @j_fc_wbuf array.
> > +      */
> > +     int                     j_fc_wbufsize;
> > +
> >       /**
> >        * @j_last_sync_writer:
> >        *
> > @@ -1507,6 +1544,8 @@ void __jbd2_log_wait_for_space(journal_t *journal);
> >   extern void __jbd2_journal_drop_transaction(journal_t *, transaction_t *);
> >   extern int jbd2_cleanup_journal_tail(journal_t *);
> >
> > +/* Fast commit related APIs */
> > +int jbd2_fc_init(journal_t *journal, int num_fc_blks);
> >   /*
> >    * is_journal_abort
> >    *
> >
