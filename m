Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371044D18B8
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Mar 2022 14:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbiCHNIS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Mar 2022 08:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244058AbiCHNH7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Mar 2022 08:07:59 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FDE48316
        for <linux-ext4@vger.kernel.org>; Tue,  8 Mar 2022 05:07:03 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id t28so16002521qtc.7
        for <linux-ext4@vger.kernel.org>; Tue, 08 Mar 2022 05:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sa+Tre1JUm35J/+yjjl5UgGs9+Ghlc1MWYjugeEOHFQ=;
        b=b9Tdo+5Nei6nAP0Y5wxtIWP4o8W2BuvsTeQiWr9z9Noe4HycsNLfHgC+alPALB6vec
         wbPxLSjGoMEl4nCGx0RsNhl8MCo5aGRyGnfE2li+jtej03cLiVybCt7cZvZpQ+qGni4U
         3TaXwIzYy5OAYNZ0u//XAfi0UNICR1QtAc2d4Sa1PomRO9/DdmwM0jOmMQEV99G4/ZhC
         qUdjRSY6uF9Q+pUZYshvD8SwaXp2CLmqrggoeKKgsB1pO5aDqojCnB7qqDlrEYgPUdsi
         PmoyYlHnaxehpKiaPiDCkIkDe/kSJ1mSHQ5saPoCUSTltdKEIQYUGGYK5YXvGvFC/bGE
         7SSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sa+Tre1JUm35J/+yjjl5UgGs9+Ghlc1MWYjugeEOHFQ=;
        b=EQKBDmQIcyjd73WQl+lkebJHCw7J/ZjFZQHJ91YBFTkc1h32JjtZ0F0VjLZHVV7yJ8
         Vs/gYd7F7h6X5AWltm3G+Fu1jqA+IaGrkefOy6MNt3AQQ/ShdTHBbQhpzw0LShov6i+N
         0/xCH+m7Go7JDDcMDX/Xhc6U2gI4AEqN54pIaGLzfaCfjLN74Ae4csLGwGBCkIU9rZTC
         ChNwPg3uTFEEyEHKIm5cUN86J31EuELRPuJRwiJirGHWX8jyLRFhlU418kPzGmH2ICEb
         RC9Qo1t8nwaO0SAgRd1xWzEsXojXDkcJvQ+1HoU05Qh71nFXb4SXopO35RuWUTmz2Hrq
         V7Gg==
X-Gm-Message-State: AOAM531Wvi5nnSIPF2M0KxTheCzTZ9Dupc9YuvtjZs5QKqtKb03aJoED
        OdbX+RM4FV0de6mTjHB7eeajPqae16ebejQjFpiP3ntfs8TsIw==
X-Google-Smtp-Source: ABdhPJz4n8Uwy1QLeaBn3cRHs8YVuqzkMlWxH9EvKcA/jmRSPtmBZv30oaiumc/1FWKN5kAVa5UjU1Mwm7RRkSCQpwE=
X-Received: by 2002:ac8:7d0b:0:b0:2e0:6891:832c with SMTP id
 g11-20020ac87d0b000000b002e06891832cmr6697530qtb.297.1646744822105; Tue, 08
 Mar 2022 05:07:02 -0800 (PST)
MIME-Version: 1.0
References: <20220308105112.404498-1-harshads@google.com> <20220308105112.404498-4-harshads@google.com>
 <20220308123020.u4357jwbtoqhy5xd@quack3.lan>
In-Reply-To: <20220308123020.u4357jwbtoqhy5xd@quack3.lan>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Tue, 8 Mar 2022 05:06:51 -0800
Message-ID: <CAD+ocbzwGW91MdnwBS2hZ_W+kum-cSpUfAWYJ0jU0xjnt3Y_SQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] ext4: for committing inode, make ext4_fc_track_inode wait
To:     Jan Kara <jack@suse.cz>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 8 Mar 2022 at 04:30, Jan Kara <jack@suse.cz> wrote:
>
> On Tue 08-03-22 02:51:10, Harshad Shirwadkar wrote:
> > From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> >
> > If the inode that's being requested to track using ext4_fc_track_inode
> > is being committed, then wait until the inode finishes the commit.
> >
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>
> Looks mostly good. Just some notes below.
>
> > diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
> > index 3477a16d08ae..7fa301b0a35a 100644
> > --- a/fs/ext4/ext4_jbd2.c
> > +++ b/fs/ext4/ext4_jbd2.c
> > @@ -106,6 +106,18 @@ handle_t *__ext4_journal_start_sb(struct super_block *sb, unsigned int line,
> >                                  GFP_NOFS, type, line);
> >  }
> >
> > +handle_t *__ext4_journal_start(struct inode *inode, unsigned int line,
> > +                               int type, int blocks, int rsv_blocks,
> > +                               int revoke_creds)
> > +{
> > +     handle_t *handle = __ext4_journal_start_sb(inode->i_sb, line,
> > +                                                type, blocks, rsv_blocks,
> > +                                                revoke_creds);
> > +     if (ext4_handle_valid(handle) && !IS_ERR(handle))
> > +             ext4_fc_track_inode(handle, inode);
>
> Why do you need to call ext4_fc_track_inode() here? Calls in
> ext4_map_blocks() and ext4_mark_iloc_dirty() should be enough, shouldn't
> they?
This is just a precautionary call. ext4_fc_track_inode is an
idempotent function, so it doesn't matter if it gets called multiple
times. This check just covers cases (such as the ones in inline.c)
where ext4_reserve_inode_write() doesn't get called. I saw a few
failures in the log group when I remove this call. The right way to
fix this though is to ensure that ext4_reserve_inode_write() gets
called before every inode update.

>
> > +     return handle;
> > +}
> > +
> >  int __ext4_journal_stop(const char *where, unsigned int line, handle_t *handle)
> >  {
> >       struct super_block *sb;
>
> ...
>
> > @@ -519,6 +525,33 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
> >               return;
> >       }
> >
> > +     if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
> > +         (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
> > +             return;
> > +
> > +     spin_lock(&ei->i_fc_lock);
> > +     while (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
> > +#if (BITS_PER_LONG < 64)
> > +             DEFINE_WAIT_BIT(wait, &ei->i_state_flags,
> > +                             EXT4_STATE_FC_COMMITTING);
> > +             wq = bit_waitqueue(&ei->i_state_flags,
> > +                                EXT4_STATE_FC_COMMITTING);
> > +#else
> > +             DEFINE_WAIT_BIT(wait, &ei->i_flags,
> > +                             EXT4_STATE_FC_COMMITTING);
> > +             wq = bit_waitqueue(&ei->i_flags,
> > +                                EXT4_STATE_FC_COMMITTING);
> > +#endif
> > +
> > +             prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
> > +             spin_unlock(&ei->i_fc_lock);
> > +
> > +             schedule();
> > +             finish_wait(wq, &wait.wq_entry);
> > +             spin_lock(&ei->i_fc_lock);
> > +     }
> > +     spin_unlock(&ei->i_fc_lock);
>
> Hum, we operate inode state with atomic bitops. So I think there's no real
> need for ei->i_fc_lock here. You just need to be careful and check inode
> state again after prepare_to_wait() call.
Okay that makes sense, I'll do this in V2.

- Harshad
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
