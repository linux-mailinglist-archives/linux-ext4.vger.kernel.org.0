Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B22BEC1A8
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Nov 2019 12:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfKALXm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 1 Nov 2019 07:23:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55970 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfKALXl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 1 Nov 2019 07:23:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id g24so8999811wmh.5
        for <linux-ext4@vger.kernel.org>; Fri, 01 Nov 2019 04:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Qozr4RraxVw3AIoqkq5NOqyj+4JsfE1BKmXlzQuthM=;
        b=pBw3YArVQtzOCQVraUck7DoJgF6t3tP7Em+WuMRz3DEmVOG2lrLtTX38kRJYbFVdzE
         ugSCtpb7fVP7fYCWRR8dK/XqdeagKiJmQrOpJEFTpw8aF371JXlFV2WSqfSbodwteguU
         D/jFffnbovCSlxupueCW8yWtgLzrfVyw+9OxJEzr0dlLdTRzFPp+FfkbjkImHODWQDxq
         /VxElS8fXcJTDm/yUN6jEvNIJxTkoN71kS5HfX8x+QL8TlM8b9gHZxbnWK/kXySnpd7A
         5G19BdYlcFDWVbUVAL+swF9w4zl2AAit8NW67M+ZkcSrYCt+9u/1/+28s3DnO2vhpYPi
         1knA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Qozr4RraxVw3AIoqkq5NOqyj+4JsfE1BKmXlzQuthM=;
        b=PczJ8bsr2BDI1ovdEXQKnWEkOwx3VgbiyK/KxqZvxSC5Qd6t0bncRtD/iIe2/uHxp6
         ih2v5ZADWiMfTx8CsY7ih7SwPDapyP1+Lor/t6+ytspIsm+4N16jm8sIWRWAF1vgY5WI
         +4+eRE7h2mTVeUExPdDumzhAp5DhcwJRMyNIeQWQmSdl13qCqhvYyc9TIyQuZMTeFJ9m
         Ug8Rzb0/2rUeIrcMhEd0H1y8O8l42X9HkAPwKi9CE2FC2A4KfDzpviTJ7SxQI0MRR2oj
         u50wipf5Hm96IP8XbwLxNlc8QwIrbRUr8UlOozJ5W2N0q4V/VGbbkHMByF7+lFn+9fIQ
         m6Ew==
X-Gm-Message-State: APjAAAVf5ZchzxFd/ArXEBdKijaV7f7S3XGSlWTl+oQBYD5KeeL5scwu
        00hVJR9eJBmj5ahG9lIXP13DRWfavd8wI6vHf729gljF
X-Google-Smtp-Source: APXvYqx2RoEcRZI8RHafIROgsMfz9hkvCLE43LbKGHMWw0bgQAmcc7ZgyRtOouL7k9SAPUZ5LoYhbZUKnUdQ11R3Evg=
X-Received: by 2002:a05:600c:2295:: with SMTP id 21mr9201805wmf.85.1572607418592;
 Fri, 01 Nov 2019 04:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
 <20190809034552.148629-4-harshadshirwadkar@gmail.com> <D1E772AE-A30B-434B-916E-E3B5FADE6517@dilger.ca>
 <CAD+ocbybr=5L+jYRz9=NXWAU-DfPJjzy4oyi+z9Ezb-CndCgbg@mail.gmail.com>
In-Reply-To: <CAD+ocbybr=5L+jYRz9=NXWAU-DfPJjzy4oyi+z9Ezb-CndCgbg@mail.gmail.com>
From:   xiaohui li <lixiaohui1@xiaomi.corp-partner.google.com>
Date:   Fri, 1 Nov 2019 19:22:35 +0800
Message-ID: <CAAJeciVpv-Ctvx31yPGLMS1DKiLOX7AWDZ1V_=xqLpKXMn8cng@mail.gmail.com>
Subject: Re: [PATCH v2 03/12] jbd2: fast commit setup and enable
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

greate.

On Tue, Oct 1, 2019 at 3:53 PM harshad shirwadkar
<harshadshirwadkar@gmail.com> wrote:
>
> Oops, I missed this, I'll handle this in V4. Thanks!
>
> On Fri, Aug 9, 2019 at 1:02 PM Andreas Dilger <adilger@dilger.ca> wrote:
> >
> > On Aug 8, 2019, at 9:45 PM, Harshad Shirwadkar <harshadshirwadkar@gmail.com> wrote:
> > >
> > > This patch allows file systems to turn fast commits on and thereby
> > > restrict the normal journalling space to total journal blocks minus
> > > JBD2_FAST_COMMIT_BLOCKS. Fast commits are not actually performed, just
> > > the interface to turn fast commits on is opened.
> > >
> > > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> > >
> > > ---
> > >
> > > Changelog:
> > >
> > > V2: No changes since V1
> > > ---
> > > fs/ext4/super.c      |  3 ++-
> > > fs/jbd2/journal.c    | 39 ++++++++++++++++++++++++++++++++-------
> > > fs/ocfs2/journal.c   |  4 ++--
> > > include/linux/jbd2.h |  2 +-
> > > 4 files changed, 37 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > > index e376ac040cce..81c3ec165822 100644
> > > --- a/fs/ext4/super.c
> > > +++ b/fs/ext4/super.c
> > > @@ -4933,7 +4933,8 @@ static int ext4_load_journal(struct super_block *sb,
> > >               if (save)
> > >                       memcpy(save, ((char *) es) +
> > >                              EXT4_S_ERR_START, EXT4_S_ERR_LEN);
> > > -             err = jbd2_journal_load(journal);
> > > +             err = jbd2_journal_load(journal,
> > > +                                     test_opt2(sb, JOURNAL_FAST_COMMIT));
> > >               if (save)
> > >                       memcpy(((char *) es) + EXT4_S_ERR_START,
> > >                              save, EXT4_S_ERR_LEN);
> > > diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> > > index 953990eb70a9..59ad709154a3 100644
> > > --- a/fs/jbd2/journal.c
> > > +++ b/fs/jbd2/journal.c
> > > @@ -1159,12 +1159,15 @@ static journal_t *journal_init_common(struct block_device *bdev,
> > >       journal->j_blk_offset = start;
> > >       journal->j_maxlen = len;
> > >       n = journal->j_blocksize / sizeof(journal_block_tag_t);
> > > -     journal->j_wbufsize = n;
> > > +     journal->j_wbufsize = n - JBD2_FAST_COMMIT_BLOCKS;
> >
> > The reservation of the JBD2_FAST_COMMIT_BLOCKS should only be done in
> > the case of the FAST_COMMIT feature being enabled.  Otherwise it can
> > hurt performance for filesystems where this feature is not enabled.
> >
> > Cheers, Andreas
> >
> > >       journal->j_wbuf = kmalloc_array(n, sizeof(struct buffer_head *),
> > >                                       GFP_KERNEL);
> > >       if (!journal->j_wbuf)
> > >               goto err_cleanup;
> > >
> > > +     journal->j_fc_wbuf = &journal->j_wbuf[journal->j_wbufsize];
> > > +     journal->j_fc_wbufsize = JBD2_FAST_COMMIT_BLOCKS;
> > > +
> > >       bh = getblk_unmovable(journal->j_dev, start, journal->j_blocksize);
> > >       if (!bh) {
> > >               pr_err("%s: Cannot get buffer for journal superblock\n",
> > > @@ -1297,11 +1300,19 @@ static int journal_reset(journal_t *journal)
> > >       }
> > >
> > >       journal->j_first = first;
> > > -     journal->j_last = last;
> > >
> > > -     journal->j_head = first;
> > > -     journal->j_tail = first;
> > > -     journal->j_free = last - first;
> > > +     if (jbd2_has_feature_fast_commit(journal)) {
> > > +             journal->j_last_fc = last;
> > > +             journal->j_last = last - JBD2_FAST_COMMIT_BLOCKS;
> > > +             journal->j_first_fc = journal->j_last + 1;
> > > +             journal->j_fc_off = 0;
> > > +     } else {
> > > +             journal->j_last = last;
> > > +     }
> > > +
> > > +     journal->j_head = journal->j_first;
> > > +     journal->j_tail = journal->j_first;
> > > +     journal->j_free = journal->j_last - journal->j_first;
> > >
> > >       journal->j_tail_sequence = journal->j_transaction_sequence;
> > >       journal->j_commit_sequence = journal->j_transaction_sequence - 1;
> > > @@ -1626,9 +1637,17 @@ static int load_superblock(journal_t *journal)
> > >       journal->j_tail_sequence = be32_to_cpu(sb->s_sequence);
> > >       journal->j_tail = be32_to_cpu(sb->s_start);
> > >       journal->j_first = be32_to_cpu(sb->s_first);
> > > -     journal->j_last = be32_to_cpu(sb->s_maxlen);
> > >       journal->j_errno = be32_to_cpu(sb->s_errno);
> > >
> > > +     if (jbd2_has_feature_fast_commit(journal)) {
> > > +             journal->j_last_fc = be32_to_cpu(sb->s_maxlen);
> > > +             journal->j_last = journal->j_last_fc - JBD2_FAST_COMMIT_BLOCKS;
> > > +             journal->j_first_fc = journal->j_last + 1;
> > > +             journal->j_fc_off = 0;
> > > +     } else {
> > > +             journal->j_last = be32_to_cpu(sb->s_maxlen);
> > > +     }
> > > +
> > >       return 0;
> > > }
> > >
> > > @@ -1641,7 +1660,7 @@ static int load_superblock(journal_t *journal)
> > >  * a journal, read the journal from disk to initialise the in-memory
> > >  * structures.
> > >  */
> > > -int jbd2_journal_load(journal_t *journal)
> > > +int jbd2_journal_load(journal_t *journal, bool enable_fc)
> > > {
> > >       int err;
> > >       journal_superblock_t *sb;
> > > @@ -1684,6 +1703,12 @@ int jbd2_journal_load(journal_t *journal)
> > >               return -EFSCORRUPTED;
> > >       }
> > >
> > > +     if (enable_fc)
> > > +             jbd2_journal_set_features(journal, 0, 0,
> > > +                                       JBD2_FEATURE_INCOMPAT_FAST_COMMIT);
> > > +     else
> > > +             jbd2_journal_clear_features(journal, 0, 0,
> > > +                                         JBD2_FEATURE_INCOMPAT_FAST_COMMIT);
> > >       /* OK, we've finished with the dynamic journal bits:
> > >        * reinitialise the dynamic contents of the superblock in memory
> > >        * and reset them on disk. */
> > > diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
> > > index 930e3d388579..3b4d91b16e8e 100644
> > > --- a/fs/ocfs2/journal.c
> > > +++ b/fs/ocfs2/journal.c
> > > @@ -1057,7 +1057,7 @@ int ocfs2_journal_load(struct ocfs2_journal *journal, int local, int replayed)
> > >
> > >       osb = journal->j_osb;
> > >
> > > -     status = jbd2_journal_load(journal->j_journal);
> > > +     status = jbd2_journal_load(journal->j_journal, false);
> > >       if (status < 0) {
> > >               mlog(ML_ERROR, "Failed to load journal!\n");
> > >               goto done;
> > > @@ -1642,7 +1642,7 @@ static int ocfs2_replay_journal(struct ocfs2_super *osb,
> > >               goto done;
> > >       }
> > >
> > > -     status = jbd2_journal_load(journal);
> > > +     status = jbd2_journal_load(journal, false);
> > >       if (status < 0) {
> > >               mlog_errno(status);
> > >               if (!igrab(inode))
> > > diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> > > index 9a750b732241..153840b422cc 100644
> > > --- a/include/linux/jbd2.h
> > > +++ b/include/linux/jbd2.h
> > > @@ -1476,7 +1476,7 @@ extern int         jbd2_journal_set_features
> > >                  (journal_t *, unsigned long, unsigned long, unsigned long);
> > > extern void      jbd2_journal_clear_features
> > >                  (journal_t *, unsigned long, unsigned long, unsigned long);
> > > -extern int      jbd2_journal_load       (journal_t *journal);
> > > +extern int      jbd2_journal_load(journal_t *journal, bool enable_fc);
> > > extern int       jbd2_journal_destroy    (journal_t *);
> > > extern int       jbd2_journal_recover    (journal_t *journal);
> > > extern int       jbd2_journal_wipe       (journal_t *, int);
> > > --
> > > 2.23.0.rc1.153.gdeed80330f-goog
> > >
> >
> >
> > Cheers, Andreas
> >
> >
> >
> >
> >
