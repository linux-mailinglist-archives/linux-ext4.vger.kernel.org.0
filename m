Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F06A31FDCD
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Feb 2021 18:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhBSRXh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Feb 2021 12:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhBSRXe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 19 Feb 2021 12:23:34 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4913C061786;
        Fri, 19 Feb 2021 09:22:53 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id s11so11194709edd.5;
        Fri, 19 Feb 2021 09:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sgU+CZrZZFSzovqSyineFZB7+11lz5F3oYA1vP9Voos=;
        b=DgFFBkrTUxhDKqBc6NMwr3FK5oMKtJ15gVXVqduWj0Y1A8uS1hSqupLxAYb3aQpyVL
         GS+swZY/to4LUQTCf2Nl9IQ0pBwW3zLwhc7zbTZPmA+l1MStI13B9aqtH1ncNIvX14JR
         dllviE88TtijXXYJl+zCQauMtvOod9ZvKhYxODIyMyyG4+HjIJOSI4VPAI7vTnC+8DT7
         7Fs6xl27RpiJCsgoR3Vdw1EMKz0/o80HQAF+I1CXWb9qNrlb0MfsdcnkRoi6y7qberff
         w22WN5uhD5Fa/1x1n2GeGEYp+b7KIPaRy1Zzl14us+XVti1Gnhj0p7yDc2SfUJJIDyQs
         2Spw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sgU+CZrZZFSzovqSyineFZB7+11lz5F3oYA1vP9Voos=;
        b=kjq8A0ctmPrdF5yYeqpdMW1s0z0xoy71kaNcTFDsgKqMPV24PuLlZHlSZ1zDTT3NKY
         wNpjiCeHH+maNugg2fMFowPjpc7qhD6yqPV4OQ8q20lmoGBYhROJfNzJgUbggmrHfoqi
         yo5yxwQCmOc/L0q0mydF/Yn1r311fio4TZTZ+NPdsik0cGEC+B4cdvRk7XzWDwbl8hn9
         lgODqyZn1o+7RZkJmKbFxCaWeUedPFywbfWBWq89AEnQMV5uYD3IBku3GiDopOsHfIS0
         PXpQuMCl9qElMAVm9R2w+KofF/3wmE4eco9CuKeUf5G+IS5szIN48gbnq92zkHO1roTc
         l7bw==
X-Gm-Message-State: AOAM530AtGIYx2jLcaSZmuRJ3ctdy5Av2it46/HDKuVhhlj1mTINqyt/
        bumyCu0NOQ7Gt9o1NaAWBaMusZn76QO2Zm58FeQ=
X-Google-Smtp-Source: ABdhPJy67UmNC7MuGtqmBdm241YUWMlRoCz49DCXlPS6TV1pzEQVBYCbomneUctTxYFwYBmvcPF3PGxNy18J/Wj9ui4=
X-Received: by 2002:aa7:da0c:: with SMTP id r12mr2088959eds.362.1613755372428;
 Fri, 19 Feb 2021 09:22:52 -0800 (PST)
MIME-Version: 1.0
References: <000000000000563a0205bafb7970@google.com> <20210211104947.GL19070@quack2.suse.cz>
 <bf1088e3-b051-6361-57dd-6b836b1c3b46@i-love.sakura.ne.jp>
 <20210215124519.GA22417@quack2.suse.cz> <aaee5d61-f988-84c3-4d16-f8b7987f3a83@i-love.sakura.ne.jp>
 <20210215142935.GB22417@quack2.suse.cz> <34341830-f74f-57fa-2d21-c141f239b017@i-love.sakura.ne.jp>
In-Reply-To: <34341830-f74f-57fa-2d21-c141f239b017@i-love.sakura.ne.jp>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Fri, 19 Feb 2021 09:22:40 -0800
Message-ID: <CAD+ocbynNULCAPuYyVaBThdvQxUy_Zg8phDNn_wnD4bqPBW1uw@mail.gmail.com>
Subject: Re: possible deadlock in start_this_handle (2)
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jan Kara <jack@suse.cz>, jack@suse.com,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        "Theodore Y. Ts'o" <tytso@mit.edu>, mhocko@suse.cz,
        linux-mm@kvack.org,
        syzbot <syzbot+bfdded10ab7dcd7507ae@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 19, 2021 at 2:20 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2021/02/15 23:29, Jan Kara wrote:
> > On Mon 15-02-21 23:06:15, Tetsuo Handa wrote:
> >> On 2021/02/15 21:45, Jan Kara wrote:
> >>> On Sat 13-02-21 23:26:37, Tetsuo Handa wrote:
> >>>> Excuse me, but it seems to me that nothing prevents
> >>>> ext4_xattr_set_handle() from reaching ext4_xattr_inode_lookup_create()
> >>>> without memalloc_nofs_save() when hitting ext4_get_nojournal() path.
> >>>> Will you explain when ext4_get_nojournal() path is executed?
> >>>
> >>> That's a good question but sadly I don't think that's it.
> >>> ext4_get_nojournal() is called when the filesystem is created without a
> >>> journal. In that case we also don't acquire jbd2_handle lockdep map. In the
> >>> syzbot report we can see:
> >>
> >> Since syzbot can test filesystem images, syzbot might have tested a filesystem
> >> image created both with and without journal within this boot.
> >
> > a) I think that syzbot reboots the VM between executing different tests to
> > get reproducible conditions. But in theory I agree the test may have
> > contained one image with and one image without a journal.
>
> syzkaller reboots the VM upon a crash.
> syzkaller can test multiple filesystem images within one boot.
>
> https://storage.googleapis.com/syzkaller/cover/ci-qemu-upstream-386.html (this
> statistic snapshot is volatile) reports that ext4_get_nojournal() is partially covered
> ( https://github.com/google/syzkaller/blob/master/docs/coverage.md ) by syzkaller.
>
>       /* Just increment the non-pointer handle value */
>       static handle_t *ext4_get_nojournal(void)
>       {
>    86         handle_t *handle = current->journal_info;
>               unsigned long ref_cnt = (unsigned long)handle;
>
>               BUG_ON(ref_cnt >= EXT4_NOJOURNAL_MAX_REF_COUNT);
>
>    86         ref_cnt++;
>               handle = (handle_t *)ref_cnt;
>
>               current->journal_info = handle;
>  2006         return handle;
>       }
>
>
>       /* Decrement the non-pointer handle value */
>       static void ext4_put_nojournal(handle_t *handle)
>       {
>               unsigned long ref_cnt = (unsigned long)handle;
>
>    85         BUG_ON(ref_cnt == 0);
>
>    85         ref_cnt--;
>               handle = (handle_t *)ref_cnt;
>
>               current->journal_info = handle;
>       }
>
>
>       handle_t *__ext4_journal_start_sb(struct super_block *sb, unsigned int line,
>                                         int type, int blocks, int rsv_blocks,
>                                         int revoke_creds)
>       {
>               journal_t *journal;
>               int err;
>
>  2006         trace_ext4_journal_start(sb, blocks, rsv_blocks, revoke_creds,
>  2006                                  _RET_IP_);
>  2006         err = ext4_journal_check_start(sb);
>               if (err < 0)
>                       return ERR_PTR(err);
>
>  2005         journal = EXT4_SB(sb)->s_journal;
>  1969         if (!journal || (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY))
>  2006                 return ext4_get_nojournal();
>  1969         return jbd2__journal_start(journal, blocks, rsv_blocks, revoke_creds,
>                                          GFP_NOFS, type, line);
>       }
>
> >
> > *but*
> >
> > b) as I wrote in the email you are replying to, the jbd2_handle key is
> > private per filesystem. Thus for lockdep to complain about
> > jbd2_handle->fs_reclaim->jbd2_handle deadlock, those jbd2_handle lockdep
> > maps must come from the same filesystem.
> >
> > *and*
> >
> > c) filesystem without journal doesn't use jbd2_handle lockdep map at all so
> > for such filesystems lockdep creates no dependency for jbd2_handle map.
> >
>
> What about "EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY)" case?
> Does this case happen on filesystem with journal, and can this case be executed
> by fuzzing a crafted (a sort of erroneous) filesystem with journal, and are
> the jbd2_handle for calling ext4_get_nojournal() case and the jbd2_handle for
> calling jbd2__journal_start() case the same?
EXT4_FC_REPLAY is a mount state that is only set during jbd2 journal
recovery. The only way for jbd2 journal recovery to set EXT4_FC_REPLAY
option is if after a journal crash there are special fast_commit
blocks present in the journal. For these fast_commit blocks to be
present in the journal, the Ext4 file system prior to crash should
have had "fast_commit" feature enabled.

If we have a way to look at the Ext4 partition that syzbot used for
reporting this bug, it is very easy to see if this FC_REPLAY will ever
be set or not. Just running "debugfs <image>" and inside debugfs,
running logdump will show us if there are any fast commit blocks
present in the journal.

Having said that, I have following reason to believe that this option
wasn't set during the syzbot failure:

EXT4_FC_REPLAY will only be set during journal recovery and is cleared
immediately after. Which means EXT4_FC_REPLAY will only be set during
mount and as soon as mount returns the option will be cleared. Looking
at the stack trace, it shows no evidence that we are in the journal
recovery phase. It seems like most of the traces are resulting from
system calls made by the user. I checked if we are accidentally
setting this flag even after journal recovery, but that doesn't seem
to be the case. On a successfully mounted file system, we
unconditionally clear this flag.

- Harshad

>
> Also, I worry that jbd2__journal_restart() is problematic, for it calls
> stop_this_handle() (which calls memalloc_nofs_restore()) and then calls
> start_this_handle() (which fails to call memalloc_nofs_save() if an error
> occurs). An error from start_this_handle() from journal restart operation
> might need special handling (i.e. either remount-ro or panic) ?
>
