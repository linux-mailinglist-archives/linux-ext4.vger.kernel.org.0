Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCFA2A6E51
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Nov 2020 20:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgKDTwh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Nov 2020 14:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgKDTwh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Nov 2020 14:52:37 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E164CC0613D3
        for <linux-ext4@vger.kernel.org>; Wed,  4 Nov 2020 11:52:36 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id o18so23793782edq.4
        for <linux-ext4@vger.kernel.org>; Wed, 04 Nov 2020 11:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WVLH3o3WZcnqEm9D1RS3k7rXZp9vK6ZC2u5AyD0Nazs=;
        b=Cs4Tl7FW7MgrKCjrbuWbVYR2CXno05vM6ydMuNRoEt8/+siMNew5kkL8EreV/7AzkY
         3G5yHZtHQ/G9Fcu3tR2sHawQTy8TnP1P7US9w8K74OcEmjQWtQs6l0rQqnL3pGIrn4ue
         GvmazmZBrsCrFH+9uSjfAJVjIUXljSbOI/WCznzxU61JSOzsYko9Zqj80DVkKlXF/bxB
         PowLPkWc5cXL0Ax26o0IYYW0L+lPhLh5liVjcZ9nYJse+0TXmzA+Mpmeq6BUF6GYvLJy
         CAbrbbGnRDNb3AbE1QbdSzcqRjRHCjNiYXqqsCGovY0dyI57VyV9nFEbK5agaJCqhwBk
         pJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WVLH3o3WZcnqEm9D1RS3k7rXZp9vK6ZC2u5AyD0Nazs=;
        b=GNHS6X4PAUmyWit7oBjwGxD5kgPvvr9CY8+50J7AZ1yxPRa5Ptyq79eD92OkgIpIfL
         xrYaYlYHUfjfYAyIaI7jJYZ9i7YtaQgGArbxGUTfCdQH6DwD3upOvq998z4kw/YupBXF
         VxmXgB6DJMugiothKMYdXQW2wM/8JlRCPXDNsFFjIwk0XFZp319TNXM7m434uxj1xhlM
         /XOAMxfmfrpBVhJNVG6zDVGuHHq0O5AhCZqh0l7IX9tTUj+KbTAsOQ1x+jjxiy0Tk2CB
         JggdKEFIeD8iyHAMLffRNV7sSOffwCU9ECR98XxnvnF36erQaoTohRXtk36DCN93xxfP
         zC+w==
X-Gm-Message-State: AOAM531dXcrbvulf/DgbAtP1sx5SAKt0KSAMRlDydMiCIvs9MWmq2YQl
        obHeRyM5PKKjd6JnBVSeadstNvJ5E+aieAwYeVk=
X-Google-Smtp-Source: ABdhPJyVgr353xrLycFVUJKH5AmAINsv+LpReczmnCzngC2RHrouGiUcASzS+4kUU/LETwwL9WqL+XBjEtGyDCDNzXw=
X-Received: by 2002:a50:99c3:: with SMTP id n3mr28910661edb.213.1604519555470;
 Wed, 04 Nov 2020 11:52:35 -0800 (PST)
MIME-Version: 1.0
References: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
 <20201031200518.4178786-5-harshadshirwadkar@gmail.com> <20201103162943.GH3440@quack2.suse.cz>
In-Reply-To: <20201103162943.GH3440@quack2.suse.cz>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Wed, 4 Nov 2020 11:52:24 -0800
Message-ID: <CAD+ocbykJ61MmkLqq78p=AOT0f_6j066J3ivNHjXJVbtLEvNag@mail.gmail.com>
Subject: Re: [PATCH 04/10] ext4: clean up the JBD2 API that initializes fast commits
To:     Jan Kara <jack@suse.cz>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 3, 2020 at 8:29 AM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 31-10-20 13:05:12, Harshad Shirwadkar wrote:
> > This patch cleans up the jbd2_fc_init() API and its related functions
> > to simplify enabling fast commits and configuring the number of blocks
> > that fast commits will use. With this change, the number of fast
> > commit blocks to use is solely determined by the JBD2 layer. However,
> > whether or not to use fast commits is determined by the file
> > system. The file system just calls jbd2_fc_init() to tell the JBD2
> > layer that it is interested in enabling fast commits. JBD2 layer
> > determines how many blocks to use for fast commits (based on the value
> > found in the JBD2 superblock).
> >
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>
> Thanks for the cleanup. Some comments below...
>
> > diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> > index fa688e163a80..353534403769 100644
> > --- a/fs/jbd2/commit.c
> > +++ b/fs/jbd2/commit.c
> > @@ -801,7 +801,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
> >               if (first_block < journal->j_tail)
> >                       freed += journal->j_last - journal->j_first;
> >               /* Update tail only if we free significant amount of space */
> > -             if (freed < journal->j_maxlen / 4)
> > +             if (freed < (journal->j_maxlen - journal->j_fc_wbufsize) / 4)
> >                       update_tail = 0;
>
> This change seems unrelated to the API change in jbd2_fc_init(). Can you
> please separate fix for journal length handling into a separate patch with
> a proper changelog etc.?
Sounds good, will do that.
>
> Also can you perhaps rename j_maxlen to j_total_len to give better hint
> that there may be multiple parts of the journal and provide wrapper
> jbd2_transaction_space(journal) for the
> (journal->j_maxlen - journal->j_fc_wbufsize) expression because that's kind
> of implementation detail of the current fastcommit code.
Ack
>
> > diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> > index 0c7c42bd530f..ea15f55aff5c 100644
> > --- a/fs/jbd2/journal.c
> > +++ b/fs/jbd2/journal.c
> > @@ -1357,14 +1357,6 @@ static journal_t *journal_init_common(struct block_device *bdev,
> >       if (!journal->j_wbuf)
> >               goto err_cleanup;
> >
> > -     if (journal->j_fc_wbufsize > 0) {
> > -             journal->j_fc_wbuf = kmalloc_array(journal->j_fc_wbufsize,
> > -                                     sizeof(struct buffer_head *),
> > -                                     GFP_KERNEL);
> > -             if (!journal->j_fc_wbuf)
> > -                     goto err_cleanup;
> > -     }
> > -
> >       bh = getblk_unmovable(journal->j_dev, start, journal->j_blocksize);
> >       if (!bh) {
> >               pr_err("%s: Cannot get buffer for journal superblock\n",
> > @@ -1378,19 +1370,21 @@ static journal_t *journal_init_common(struct block_device *bdev,
> >
> >  err_cleanup:
> >       kfree(journal->j_wbuf);
> > -     kfree(journal->j_fc_wbuf);
> >       jbd2_journal_destroy_revoke(journal);
> >       kfree(journal);
> >       return NULL;
> >  }
> >
> > -int jbd2_fc_init(journal_t *journal, int num_fc_blks)
> > +int jbd2_fc_init(journal_t *journal)
> >  {
> > -     journal->j_fc_wbufsize = num_fc_blks;
> > -     journal->j_fc_wbuf = kmalloc_array(journal->j_fc_wbufsize,
> > -                             sizeof(struct buffer_head *), GFP_KERNEL);
> > -     if (!journal->j_fc_wbuf)
> > -             return -ENOMEM;
> > +     /*
> > +      * Only set j_fc_wbufsize here to indicate that the client file
> > +      * system is interested in using fast commits. The actual number of
> > +      * fast commit blocks is found inside jbd2_superblock and is only
> > +      * valid if j_fc_wbufsize is non-zero. The real value of j_fc_wbufsize
> > +      * gets set in journal_reset().
> > +      */
> > +     journal->j_fc_wbufsize = JBD2_MIN_FC_BLOCKS;
> >       return 0;
> >  }
>
> When looking at this, is there a reason why jbd2_fc_init() still exists?  I
> mean why not just make the rule that the journal has FC block number set
> iff FC gets enabled? Anything else seems a bit confusing to me and also
> dangerous - imagine we have fs with FC running, we write some FCs and then
> crash. Then on system recovery we mount with no_fc mount option. We have
> just lost data on the filesystem AFAIU... So I'd just remove all the mount
> options related to fastcommits and leave everything to the journal setup
> (which can be modified with e2fsprogs if needed) to keep things simple.
The problem is whether or not to use fast commits is the file system's
call. The JBD2 feature flag will be cleared on a clean unmount and if
we rely solely on the JBD2 feature flag, fast commit will be turned
off after a clean unmount. Whereas the FS compat flag is the source of
truth about whether fast commit needs to be used or not. That's why we
need an API for the file system to tell JBD2 to still do fast commits.
Mount options that override the feature flag in Ext4 were mainly meant
for debugging purposes. So, perhaps there should be a clear warning
message in the kernel if any of these options are used? Even if we get
rid of the mount options, we still need the jbd2_fc_init() API for the
FS to tell JBD2 that it wants to use fast commit. Note that even if
jbd2_fc_init() is not called, JBD2 will still try to replay fast
commit blocks.
>
> >  EXPORT_SYMBOL(jbd2_fc_init);
> > @@ -1500,7 +1494,7 @@ static void journal_fail_superblock(journal_t *journal)
> >  static int journal_reset(journal_t *journal)
> >  {
> >       journal_superblock_t *sb = journal->j_superblock;
> > -     unsigned long long first, last;
> > +     unsigned long long first, last, num_fc_blocks;
> >
> >       first = be32_to_cpu(sb->s_first);
> >       last = be32_to_cpu(sb->s_maxlen);
> > @@ -1513,6 +1507,28 @@ static int journal_reset(journal_t *journal)
> >
> >       journal->j_first = first;
> >
> > +     /*
> > +      * At this point, fast commit recovery has finished. Now, we solely
> > +      * rely on the file system to decide whether it wants fast commits
> > +      * or not. File system that wishes to use fast commits must have
> > +      * already called jbd2_fc_init() before we get here.
> > +      */
> > +     if (journal->j_fc_wbufsize > 0)
> > +             jbd2_journal_set_features(journal, 0, 0,
> > +                                       JBD2_FEATURE_INCOMPAT_FAST_COMMIT);
> > +     else
> > +             jbd2_journal_clear_features(journal, 0, 0,
> > +                                       JBD2_FEATURE_INCOMPAT_FAST_COMMIT);
> > +
> > +     /* If valid, prefer the value found in superblock over the default */
> > +     num_fc_blocks = be32_to_cpu(sb->s_num_fc_blks);
> > +     if (num_fc_blocks > 0 && num_fc_blocks < last)
> > +             journal->j_fc_wbufsize = num_fc_blocks;
> > +
> > +     if (jbd2_has_feature_fast_commit(journal))
> > +             journal->j_fc_wbuf = kmalloc_array(journal->j_fc_wbufsize,
> > +                                     sizeof(struct buffer_head *), GFP_KERNEL);
> > +
> >       if (jbd2_has_feature_fast_commit(journal) &&
> >           journal->j_fc_wbufsize > 0) {
> >               journal->j_fc_last = last;
> > @@ -1531,7 +1547,8 @@ static int journal_reset(journal_t *journal)
> >       journal->j_commit_sequence = journal->j_transaction_sequence - 1;
> >       journal->j_commit_request = journal->j_commit_sequence;
> >
> > -     journal->j_max_transaction_buffers = journal->j_maxlen / 4;
> > +     journal->j_max_transaction_buffers =
> > +             (journal->j_maxlen - journal->j_fc_wbufsize) / 4;
> >
> >       /*
> >        * As a special case, if the on-disk copy is already marked as needing
> > @@ -1872,6 +1889,7 @@ static int load_superblock(journal_t *journal)
> >  {
> >       int err;
> >       journal_superblock_t *sb;
> > +     int num_fc_blocks;
> >
> >       err = journal_get_superblock(journal);
> >       if (err)
> > @@ -1884,10 +1902,12 @@ static int load_superblock(journal_t *journal)
> >       journal->j_first = be32_to_cpu(sb->s_first);
> >       journal->j_errno = be32_to_cpu(sb->s_errno);
> >
> > -     if (jbd2_has_feature_fast_commit(journal) &&
> > -         journal->j_fc_wbufsize > 0) {
> > +     if (jbd2_has_feature_fast_commit(journal)) {
> >               journal->j_fc_last = be32_to_cpu(sb->s_maxlen);
> > -             journal->j_last = journal->j_fc_last - journal->j_fc_wbufsize;
> > +             num_fc_blocks = be32_to_cpu(sb->s_num_fc_blks);
> > +             if (!num_fc_blocks || num_fc_blocks >= journal->j_fc_last)
>
> I think this needs to be stricter - we need the check that the journal is
> at least JBD2_MIN_JOURNAL_BLOCKS long (which happens at the beginning of
> journal_reset()) to happen after we've subtracted fastcommit blocks...
So are you saying that with FC, the minimum journal size is
JBD2_MIN_JOURNAL_BLOCKS + JBD2_MIN_FC_BLOCKS? I was assuming that we
will reserve JBD2_MIN_FC_BLOCKS (256) blocks out of the total journal
size. That way the users who rely on the journal size to be 1024
blocks, won't see a difference in journal size even after turning FC
on. But I'm not sure if that's something we should care about.
>
> > +                     num_fc_blocks = JBD2_MIN_FC_BLOCKS;
> > +             journal->j_last = journal->j_fc_last - num_fc_blocks;
> >               journal->j_fc_first = journal->j_last + 1;
> >               journal->j_fc_off = 0;
> >       } else {
> ...
> > diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> > index eb2606133cd8..822f16cbf9b3 100644
> > --- a/fs/jbd2/recovery.c
> > +++ b/fs/jbd2/recovery.c
> > @@ -134,7 +134,7 @@ static int jread(struct buffer_head **bhp, journal_t *journal,
> >
> >       *bhp = NULL;
> >
> > -     if (offset >= journal->j_maxlen) {
> > +     if (offset >= journal->j_maxlen + journal->j_fc_wbufsize) {
>
> This looks wrong since j_maxlen is currently including fastcommit blocks...
Ack,

Thanks,
Harshad
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
