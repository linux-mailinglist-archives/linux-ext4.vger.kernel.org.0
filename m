Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA3C505F1F
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Apr 2022 23:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343592AbiDRVFk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Apr 2022 17:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242971AbiDRVFk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Apr 2022 17:05:40 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DE62A274
        for <linux-ext4@vger.kernel.org>; Mon, 18 Apr 2022 14:02:59 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id r13so29054767ejd.5
        for <linux-ext4@vger.kernel.org>; Mon, 18 Apr 2022 14:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p2GdD4HMoXKh89Kz3xaXx6zDuKIbesoEnFLqYzbAHww=;
        b=Z45O12J3KhSy4H0LXlTNTw2dG1xKsNjcZ9MR5YrLRLia4uAfza0p7zZBglDUSgRXmK
         RWhkhQLTzcRguFEJzIw0GygALkT+QEzElXbHBUA6ewiaZqzRLBewhg19ULkIOoEY4pgA
         mQz1XC20ZN9ZM8/7KzsetakZeztighvcy1M+7mBf/RpeJ1SdacKs25p4u57I4pwhPNEt
         +WlbQQ2hYmDYrcOjs617tqlsa85YF6hd8erI88vokJ9MhAUEXXs4Mf/kwo5Zihm8b+EW
         qioeC2ihuLBYtClX9lorV0ohf5LsuphWPOAkWwfnfIvAMvJVQivn5C3rlScAsMaTTfjp
         piuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p2GdD4HMoXKh89Kz3xaXx6zDuKIbesoEnFLqYzbAHww=;
        b=nuxEcgQ+9OOw2SlNxy262SxyxGrksdTKDl7JVv8nIAE2pwECz2iDj3JLxf55vY0H6q
         gf0ad5Gbjp9Xz9vdYp/yx4H7mncTNjVl7MV2ZflJrp7zESGcOjMDKuPauN0FE+7d89CD
         65ya8eN+u4414wW2l6eRImHYKDvv+fP/aMrsS/2TNZvhNKlV1JkkHmWoHuHgrWgqSGUz
         p7hm2ymNvCKHRsx7DyDQMdsC7btKMEh0+XA33F2yYWANjADd92ud+SYgdZBlWzwFrnXa
         Z7yKig4Ls85ZVNP3V/UwTw8u8x3UT73CgC7iziKoC4GweoYDYaagvbTPeCuqBKwEGyR1
         DAcg==
X-Gm-Message-State: AOAM532tbl8r1KCE86nsiPGP1D/Gzphjx6xbNzWGD5FA/RbwTLu1UJvt
        47bPlAFrOY4Axurbps27Xs/FtllLgtOooBDf9/4=
X-Google-Smtp-Source: ABdhPJxjFdMkISAtJQPCGbc/wLYWz3hhVMnRSKbp2yBwOd2jqq8B/3fhrB83AZnyWafYd2J+ASuITNy6ny5xqv9+JBg=
X-Received: by 2002:a17:907:9484:b0:6e8:9c3e:291c with SMTP id
 dm4-20020a170907948400b006e89c3e291cmr10556956ejc.768.1650315777516; Mon, 18
 Apr 2022 14:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220308163319.1183625-1-harshads@google.com> <20220308163319.1183625-3-harshads@google.com>
 <20220309101426.qumxztpd4weqzrcs@quack3.lan> <CAD+ocbyM9HdZwpB_NzKAiJTsZ78gZ_4Hsk3c21tL4ZetapqcFg@mail.gmail.com>
 <CAD+ocbzGsf3=2OK5MD_MyF=SyV63q1Z7Vg5VtkaE5FzmZ7_qqw@mail.gmail.com> <20220321140617.wc2ohrorqny4leyc@quack3.lan>
In-Reply-To: <20220321140617.wc2ohrorqny4leyc@quack3.lan>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 18 Apr 2022 14:02:46 -0700
Message-ID: <CAD+ocbyBXKa=LvhAwNyxY5b-E1-G01FUhtO+uSwrUn7Z8m+38Q@mail.gmail.com>
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

Sorry for the late reply, I was on vacation and getting to this just now.

On Mon, 21 Mar 2022 at 07:06, Jan Kara <jack@suse.cz> wrote:
>
> Sorry for delayed reply, I've got dragged into other things and somewhat
> forgot about this...
>
> On Fri 11-03-22 00:25:48, harshad shirwadkar wrote:
> > Hmm, after removing ext4_fc_track_inode() from ext4_journal_start(), I
> > see one deadlock - there are some places in code where
> > ext4_mark_inode_dirty gets called while holding i_data_sem. Commit
> > path requires i_data_sem to commit inode data (via ext4_map_blocks).
> > So, if an inode is being committed, ext4_mark_inode_dirty may start
> > waiting for the inode to commit while holding i_data_sem and the
> > commit path may wait on i_data_sem.
>
> Indeed, that is a problem.
>
> > The right way to fix this is to
> > call ext4_fc_track_inode in such places before acquiring i_data_sem in
> > write mode. But that would mean we sprinkle code with more
> > ext4_fc_track_inode() calls which is something that I preferably
> > wanted to avoid.
>
> So I agree calling ext4_fc_track_inode() from ext4_reserve_inode_write()
> isn't going to fly as is. We need to find a better way of doing things.
>
> > This makes me wonder though, for fast commits, is it a terrible idea
> > to extend the meaning of ext4_journal_start() from "start a new
> > handle" to "start a new handle with an intention to modify the passed
> > inode"? Most of the handles modify only one inode, and for other
> > places where we do modify multiple inodes, ext4_reserve_inode_write()
> > would ensure that those inodes are tracked as well.
>
> Well but to avoid deadlocks like you've described above you would have to
> start tracking inode with explicit ext4_fc_track_inode() calls before
> grabbing i_data_sem. ext4_reserve_inode_write() would be only useful for an
> assertion check that indeed the inode is already tracked.
>
> > All of the
> > existing places where inode gets modified after grabbing i_data_sem,
> > i_data_sem is grabbed only after starting the handle. This would take
> > care of the deadlock mentioned above and similar deadlocks. Another
> > advantage with doing this is that developers wouldn't need to worry
> > about adding explicit ext4_fc_track_inode() calls for future changes.
>
> Well, at least for the simple case where only one inode is modified. But I
> agree that's a majority.
>
> > If we decide to do this, we would need to do a thorough code review to
> > ensure that the above rule is followed everywhere. But note that
> > ext4_fc_track_inode() is idempotent, so it doesn't matter if this
> > function gets called multiple times in the same handle. So to avoid
> > breaking fast commits, we can be super careful and in the first
> > version, we can have ext4_fc_track_range() calls in
> > ext4_reserve_inode_dirty(), ext4_journal_start(), inline.c and in
> > handles where i_data_sem gets acquired in write mode. We can then
> > carefully evaluate each code path and remove redundant
> > ext4_fc_track_range() calls.
>
> As I wrote above, if we go this path, I'd be for ext4_fc_track_inode()
> calls in ext4_journal_start() and then adding explicit calls to
> ext4_fc_track_inode() where additionally needed and have only assertion
> checks in ext4_reserve_inode_dirty() and other places which modify inode
> metadata, to catch places which need explicit calls to
> ext4_fc_track_inode(). That way we won't have any hidden deadlocks in the
> code waiting to happen.
Okay sounds good, so based on your response, I'll rework the patch
series to make following changes:
1) Add ext4_fc_track_inode() calls in ext4_journal_start()
2) Add ext4_fc_track_inode calls in places where more than one inode
are changed in a handle and / or i_data_sem is being acquired.
3) Add an assertion in ext4_reserve_inode_dirty() to check if the
inode on which write is being reserved is already being tracked.

Does that sound good?
>
> I have also another proposal for consideration how we could handle this.
> Mostly branstorming now: We could also drop the need for fastcommit code to
> acquire i_data_sem during commit. We could use just information in extent
> status tree to provide block mapping for the fastcommit code (that does not
> need i_data_sem). The only thing is we'd need to make sure modified extents
> from the status tree are not evicted from memory before the appropriate
> transaction commits so that they are available for appropriate fastcommit -
> for that we'd probably need to add TID of the transaction that last
> modified an extent and add check into the shrinker to avoid shrinking
> uncommitted extents. As a bonus, we could now add to fastcommit only
> extents with appropriate TID and thus save on extent logging for sparsely
> modified inode.
Yeah, I like this idea. I'll add that as a TODO in the code just so
that we don't lose it.

Thanks,
Harshad
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
