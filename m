Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DA152D606
	for <lists+linux-ext4@lfdr.de>; Thu, 19 May 2022 16:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239722AbiESO23 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 May 2022 10:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239715AbiESO20 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 May 2022 10:28:26 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4A2CC17C
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 07:28:24 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id j4so2790608edq.6
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 07:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uEIL6AsSreMI83+kfkA58gTnFlshlzAaH7JxJ4A0+ys=;
        b=c+fo2wRq0n4LcBXDcISuARTorDzzn6illDjsRXqjcBvvOIUByP8TQzL5MaHyrEjpAO
         oGJI9xctLJIqDc3NRFncPAMmwo2ID4Cnex1HOCOXnJ0P+Y3RmAA23yRz7KnnMhPXKUX0
         +5UvNP76VzFvCo87biYoEnla2VoJhXhcn7ySfodwoWoS07zinL+WVsYOqEmQctCIBDc1
         3MjlWvqkN980LM/I5HYOWxP0zi9BMSUsuTp+lZeVKxszkccNM3MDKEv82lXzERG4ZGL2
         MaHitl1QaHAWS4AvHJ6tn6kfNqxRJFX/8RHcOl4hAYIOa3EoX2rsdrUUKHiBMaF1FbXX
         HsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uEIL6AsSreMI83+kfkA58gTnFlshlzAaH7JxJ4A0+ys=;
        b=UzkBqqrAgI1bNXC70eR6nx23QHljaIXKzpWnw2PB5Ty4BQ9CwHk0kNh4cd7n1gepzK
         jZ5TmtftmdLae0Pyl5o8wqpldGtiFcjHhV48SuTaopmKchf9XUc/+WQSAIb5ov38hn2D
         yYTQrx+wgd466b4eG8569xzcn6yza4P6UzYkI+JMHe0KFllSkMVNpD6bc0g3zTVH2zbO
         HDGgFa1Q6lbkZ+x0+6XKTFKHTQwMtfMf8gQU8uyDbj6MuDEBevkWXQW30AqiUDDYkAPb
         ZjelflodgJevwzzd1SHsBAHoKSQ8wjKXPvxjYueK5sRBmVgH2vKSKNf96uGVd3fBYj7G
         pRyw==
X-Gm-Message-State: AOAM533BcFZx9sIXV7gPJX2y45+HOt32iHWHyY3h/h9FNTwS5bw3Ng86
        uqfN1vsSgzHBCF2nw1uW7dG+Hc4OLC+YHit7wez09I0UbzM=
X-Google-Smtp-Source: ABdhPJxTogRQL40RMOFkBRXeInVMFG2g3aH0dXMfDnZh1VSr8bXfgjc90VxK+RzxNX4Yy8CbrrKJktUeLrBOUh6dpno=
X-Received: by 2002:a05:6402:1542:b0:42a:ccc0:b1dd with SMTP id
 p2-20020a056402154200b0042accc0b1ddmr5607372edx.341.1652970502831; Thu, 19
 May 2022 07:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220419173143.3564144-1-harshads@google.com> <20220419173143.3564144-3-harshads@google.com>
 <20220427155032.pikb3jdb62732xvi@quack3.lan>
In-Reply-To: <20220427155032.pikb3jdb62732xvi@quack3.lan>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Thu, 19 May 2022 07:28:11 -0700
Message-ID: <CAD+ocbzyHdb+Du+7dDePazue649nr6H=A-pCPo5S1+PSEQMhyQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] ext4: for committing inode, make
 ext4_fc_track_inode wait
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

Thanks for the review. Some questions / comments below:

On Wed, 27 Apr 2022 at 08:50, Jan Kara <jack@suse.cz> wrote:
>
> On Tue 19-04-22 10:31:39, Harshad Shirwadkar wrote:
> > From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> >
> > If the inode that's being requested to track using ext4_fc_track_inode
> > is being committed, then wait until the inode finishes the
> > commit. Also, add calls to ext4_fc_track_inode at the right places.
> >
> > With this patch, now calling ext4_reserve_inode_write() results in
> > inode being tracked for next fast commit. A subtle lock ordering
> > requirement with i_data_sem (which is documented in the code) requires
> > that ext4_fc_track_inode() be called before grabbing i_data_sem. So,
> > this patch also adds explicit ext4_fc_track_inode() calls in places
> > where i_data_sem grabbed.
> >
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> > ---
> >  fs/ext4/fast_commit.c | 38 ++++++++++++++++++++++++++++++++++++++
> >  fs/ext4/inline.c      |  3 +++
> >  fs/ext4/inode.c       |  5 ++++-
> >  3 files changed, 45 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> > index c278060a15bc..55f4c5ddd8e5 100644
> > --- a/fs/ext4/fast_commit.c
> > +++ b/fs/ext4/fast_commit.c
> > +     /*
> > +      * If we come here, we may sleep while waiting for the inode to
> > +      * commit. We shouldn't be holding i_data_sem in write mode when we go
> > +      * to sleep since the commit path needs to grab the lock while
> > +      * committing the inode.
> > +      */
> > +     WARN_ON(lockdep_is_held_type(&ei->i_data_sem, 1));
>
> Note that we can deadlock even if we had i_data_sem for reading because
> another reader is not allowed to get the rwsem if there is writer waiting
> for it. So we need to check even that case here.
I turned the above WARN_ON to check if data_sem is held in either read
or write mode and now I am seeing many other places where data_sem
gets grabbed in read mode before calling ext4_fc_track_inode(). We
either need to call ext4_fc_track_inode() before all
ext4_reserve_inode_write() in all those cases, or ensure that places
that acquire in data_sem in write mode, wait if there's an ongoing
commit and only then lock data_sem.
>
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
> > +             prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
> > +             if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING))
> > +                     schedule();
> > +             finish_wait(wq, &wait.wq_entry);
> > +     }
> > +
> >       ret = ext4_fc_track_template(handle, inode, __track_inode, NULL, 1);
> >       trace_ext4_fc_track_inode(handle, inode, ret);
>
> As we discussed in the call we should tell lockdep that this is equivalent
> to lock+unlock of let's say fc_committing_lock and the fastcommit code
> setting / clearing EXT4_STATE_FC_COMMITTING is equivalent to lock / unlock
> of fc_committing_lock. That way we get proper lockdep tracking of this
> waiting primitive.
Sure, so you mean just adding __acquires() / __releases() annotations
in these places right?

- Harshad
>
>                                                                 Honza
>
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
