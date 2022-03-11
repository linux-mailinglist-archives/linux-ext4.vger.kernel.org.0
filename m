Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542864D5D40
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Mar 2022 09:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiCKI1F (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Mar 2022 03:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbiCKI1E (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Mar 2022 03:27:04 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0271E1B8FE4
        for <linux-ext4@vger.kernel.org>; Fri, 11 Mar 2022 00:26:02 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id g20so9988228edw.6
        for <linux-ext4@vger.kernel.org>; Fri, 11 Mar 2022 00:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KChDkEJtGWat+fesexxonqPFpsGTqVja3z4bjqLtBBQ=;
        b=UR62llwd+kEXJjX+oaMx0iRdQprNdH0uhERsfXIRBxjjluhuTWpaZdGTzsLcpO4ATC
         9VRnAQUkkdpIY8Wu0Mf05DMcUGJxbVHmVAdNVTVl4hHnJBNkP1wd9Ja/QfNrZPlRu1tp
         m+xD3UIvVELgIetpUb3fdJVzbb91FC35DmV0YxkmeaFfxuuE34pJjhkfJ1QO+MAEVuhp
         1oUppMIwXh8VTVzKEtPuxmd9v4JAqV3cGUPqg/RT5/iKwylLi9JNl0hnb5q3a1gZ8t7j
         W8C/zCI1tISGUlHzAuFbdoKIsmwEpVl+3SlbLmFB+k1MYS9DAp5nryfYcILq4HRIKLOJ
         8KQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KChDkEJtGWat+fesexxonqPFpsGTqVja3z4bjqLtBBQ=;
        b=V4ANTolaZp0M7QNwwRB1UB9R+htgwyB3lmZrx6pnYyoUsqNAR3N11y9wbZAhl2zRr8
         +qUJq8tITn5cFnyWharMMBc+Ur/qZ4Pp3dpNFeZwV+TpvdrDq6JQfkgVD6q9qOMN1eEE
         /6B2MgvQ9YKxYY3pa7kRwlvYI/LR5hdH2S6BpOrA0TKQWn728gjTsT87kF2q2VhysDY0
         3HSj4e9OevW3w5jMrdYd7q5I4CSSPM8NSOYkq3hs9YM/cePR/yCcZPdG45YwIl28PyNn
         TFU1fBGZFcr0Ch4Va3+eQM6G57VtuyydiP3ErPM6LBwXe6R93hNjPWm/iGdXLEKSqERw
         gFHg==
X-Gm-Message-State: AOAM532giFwoZ2HkAsQXdiV+ILMjHU2NOXD/2JWU4+hWR/jGRcbaDIDk
        peWNCUfpd22swWKrNS5A48ophqiQ/a4gr2+sVdXXdQLC71WixA==
X-Google-Smtp-Source: ABdhPJxjvrHrQOqII1ShBqH/oQ/1WSbTvhmf2w37Uts94LBYvepph+L+EvIatx1Zyl7Buzo/BGXKLJR/bBmaItMBupc=
X-Received: by 2002:a05:6402:3490:b0:416:8b97:b1f7 with SMTP id
 v16-20020a056402349000b004168b97b1f7mr7665554edc.36.1646987160172; Fri, 11
 Mar 2022 00:26:00 -0800 (PST)
MIME-Version: 1.0
References: <20220308163319.1183625-1-harshads@google.com> <20220308163319.1183625-3-harshads@google.com>
 <20220309101426.qumxztpd4weqzrcs@quack3.lan> <CAD+ocbyM9HdZwpB_NzKAiJTsZ78gZ_4Hsk3c21tL4ZetapqcFg@mail.gmail.com>
In-Reply-To: <CAD+ocbyM9HdZwpB_NzKAiJTsZ78gZ_4Hsk3c21tL4ZetapqcFg@mail.gmail.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Fri, 11 Mar 2022 00:25:48 -0800
Message-ID: <CAD+ocbzGsf3=2OK5MD_MyF=SyV63q1Z7Vg5VtkaE5FzmZ7_qqw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] ext4: for committing inode, make
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

Hmm, after removing ext4_fc_track_inode() from ext4_journal_start(), I
see one deadlock - there are some places in code where
ext4_mark_inode_dirty gets called while holding i_data_sem. Commit
path requires i_data_sem to commit inode data (via ext4_map_blocks).
So, if an inode is being committed, ext4_mark_inode_dirty may start
waiting for the inode to commit while holding i_data_sem and the
commit path may wait on i_data_sem. The right way to fix this is to
call ext4_fc_track_inode in such places before acquiring i_data_sem in
write mode. But that would mean we sprinkle code with more
ext4_fc_track_inode() calls which is something that I preferably
wanted to avoid.

This makes me wonder though, for fast commits, is it a terrible idea
to extend the meaning of ext4_journal_start() from "start a new
handle" to "start a new handle with an intention to modify the passed
inode"? Most of the handles modify only one inode, and for other
places where we do modify multiple inodes, ext4_reserve_inode_write()
would ensure that those inodes are tracked as well. All of the
existing places where inode gets modified after grabbing i_data_sem,
i_data_sem is grabbed only after starting the handle. This would take
care of the deadlock mentioned above and similar deadlocks. Another
advantage with doing this is that developers wouldn't need to worry
about adding explicit ext4_fc_track_inode() calls for future changes.

If we decide to do this, we would need to do a thorough code review to
ensure that the above rule is followed everywhere. But note that
ext4_fc_track_inode() is idempotent, so it doesn't matter if this
function gets called multiple times in the same handle. So to avoid
breaking fast commits, we can be super careful and in the first
version, we can have ext4_fc_track_range() calls in
ext4_reserve_inode_dirty(), ext4_journal_start(), inline.c and in
handles where i_data_sem gets acquired in write mode. We can then
carefully evaluate each code path and remove redundant
ext4_fc_track_range() calls.

What do you think?

- Harshad

On Thu, 10 Mar 2022 at 20:17, harshad shirwadkar
<harshadshirwadkar@gmail.com> wrote:
>
> Thanks for the reviews Jan! I'll update inline.c as you mentioned in
> the next version.
>
> - Harshad
>
> On Wed, 9 Mar 2022 at 02:14, Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 08-03-22 08:33:16, Harshad Shirwadkar wrote:
> > > From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> > >
> > > If the inode that's being requested to track using ext4_fc_track_inode
> > > is being committed, then wait until the inode finishes the commit.
> > >
> > > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> >
> > One comment below...
> >
> > > --- a/fs/ext4/ext4_jbd2.c
> > > +++ b/fs/ext4/ext4_jbd2.c
> > > @@ -106,6 +106,18 @@ handle_t *__ext4_journal_start_sb(struct super_block *sb, unsigned int line,
> > >                                  GFP_NOFS, type, line);
> > >  }
> > >
> > > +handle_t *__ext4_journal_start(struct inode *inode, unsigned int line,
> > > +                               int type, int blocks, int rsv_blocks,
> > > +                               int revoke_creds)
> > > +{
> > > +     handle_t *handle = __ext4_journal_start_sb(inode->i_sb, line,
> > > +                                                type, blocks, rsv_blocks,
> > > +                                                revoke_creds);
> > > +     if (ext4_handle_valid(handle) && !IS_ERR(handle))
> > > +             ext4_fc_track_inode(handle, inode);
> > > +     return handle;
> > > +}
> > > +
> >
> > Please fix fs/ext4/inline.c rather than papering over the problem like
> > this. Because it is just a landmine waiting to explode in some strange
> > cornercase when someone does not call ext4_journal_start() but other handle
> > starting function.
> >
> >                                                                 Honza
> > --
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
