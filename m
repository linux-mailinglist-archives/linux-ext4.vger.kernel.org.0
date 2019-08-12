Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7A98A4D3
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Aug 2019 19:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfHLRrs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Aug 2019 13:47:48 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40259 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfHLRrr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Aug 2019 13:47:47 -0400
Received: by mail-ot1-f65.google.com with SMTP id c34so22029355otb.7
        for <linux-ext4@vger.kernel.org>; Mon, 12 Aug 2019 10:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4wawRQCHdcZTmgKJKwizn/urFtMXISL9AbW1MmNDWCU=;
        b=cIjyFyyr6W37R7+RdqmorpEIyAtM8bygqGrIGJN3aZwWU3aahXDDqCv6RR/kjP3ylv
         msYPk8eSO4XbSGy/F7nUcO6MdeYSRbppR04ezU+6AqYDxrL2NGyBQmvy/DRcZDSPhKgn
         xdFAWJJcoj58PurHCdLSjQymeq5aYh2MYXR8GAsPEK9O7e6yItXOtBlnY8GQMvGoDbaU
         eyHo8zUmI/N6cQf+duAKSfdM4StHPpLP32zHKV8etFxmmYEOPqMNy87vwar47rmct4qZ
         Hvp1nUzcq41CSuXN86uqHT9Kqwglc5gdfHecSGWYRO00UNkI3V7oZsamUjBTcAKIZ/vc
         nK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4wawRQCHdcZTmgKJKwizn/urFtMXISL9AbW1MmNDWCU=;
        b=aOlg4i3PqIwDyTQr5CCOUVsvJb4ARsxxHhjvmmDaWNsb6x4VLY1/HPyur3/RlR3MLI
         fHw/KhfE2UoERHtrdCQB46glnmJBityYLLBl1Gio1XSB/tUCnOl5VoLiPzpboyFywIHJ
         DeK1JN4/9TpzjDoxySqFAbuH8MhtQpbY+pbB6LgZWaLfj6CbYdoOVaAWu3BHlSU6lxPq
         dkPOO4Znm+LjjBAspozmEAsy4hr34Cn/31vXwzO6N9FawuUnFhJA9WnM6c+czju5JVg0
         qgrcDTjU6IRClRAtbdlgLA3gX9xyauVu2jYMLzy96JGb6TarY4a4wkry+ls3ZMvToDBw
         RaTg==
X-Gm-Message-State: APjAAAV7LL+UcSG85cgVZFfP5qY8Lrv2YF8YrCj6xCcONa2wBVsRGnA/
        J94FFtckaloGQRp6QIQvyg7mhgt6GYoHuSDdRpc=
X-Google-Smtp-Source: APXvYqwSpqEINq96z/OzluWUcuOiGEhOm9RQAG7PIVZtBSfxJ6jO+fAZ33I4kfaov+VaDP1z+8nX7zok+280HEL7MX4=
X-Received: by 2002:a9d:922:: with SMTP id 31mr2599417otp.227.1565631747668;
 Mon, 12 Aug 2019 10:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
 <20190809034552.148629-6-harshadshirwadkar@gmail.com> <20190812160445.GA28705@mit.edu>
In-Reply-To: <20190812160445.GA28705@mit.edu>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 12 Aug 2019 10:41:48 -0700
Message-ID: <CAD+ocbxwraTHT0wPCZgtjC8mJ7OU6wpkd7PgC7_YW=G9W-arDQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] jbd2: fast-commit commit path new APIs
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks Andreas and Ted for the review.

Yeah, this makes sense.

On Mon, Aug 12, 2019 at 9:04 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Thu, Aug 08, 2019 at 08:45:45PM -0700, Harshad Shirwadkar wrote:
> > This patch adds new helper APIs that ext4 needs for fast
> > commits. These new fast commit APIs are used by subsequent fast commit
> > patches to implement fast commits. Following new APIs are added:
> >
> > /*
> >  * Returns when either a full commit or a fast commit
> >  * completes
> >  */
> > int jbd2_fc_complete_commit(journal_tc *journal, tid_t tid,
> >                           tid_t tid, tid_t subtid)
>
> I think there is an opportunity to do something more efficient.
>
> Right now, the ext4_fsync() calls this function, and the file system
> can only do a "fast commit" if all of the modifications made to the
> file system to date are "fast commit eligible".  Otherwise, we have to
> fall back to a normal, slow commit.
>
> We can make this decision on a much more granular level.  Suppose that
> so far during the life of the current transaction, inodes A, B, and C
> have been modified.  The modification to inode A is not fast commit
> eligible (maybe the inode is deleted, or it is involved in a directory
> rename, etc.).  The modification to inode B is fast commit eligible,
> but an fsync was not requested for it.  And the modification to inode
> C *is* fast commit eligble, *and* fsync() has been requested for it.
>
> We only need to write the information for inode C to the fast commit
> area.  The fact that inode A is not fast commit eligible isn't a
> problem.  It will get committed when the normal transaction closes,
> perhaps when the 5 second commit transaction timer expires.  And inode
> B, even though its changes might be fast commit eligible, might
> require writing a large number of data blocks if it were included in
> the fast commit.  So excluding inodes A and B from the fast commit,
> and only writing the logical changes corresponding to the those made
> to inode C, will allow a fast commit to take place.
>
> In order to do that, though, the ext4's fast commit machinery needs to
> know which inode we actually need to do the fast commit for.  And so
> for that reason, it's actually probably better not to run the changes
> through the commit thread.  That makes it harder to plumb the file
> system specific information through, and it also requires waking up
> the commit thread and waiting for it to get scheduled.
I see, so you mean each fsync() call will result in exactly one inode
to be committed (the inode on which fsync was called), right? I agree
this doesn't need to go through JBD2 but we need a mechanism to inform
JBD2 about this fast commit since JBD2 maintains sub-transaction ID.
JBD2 will in turn need to make sure that a subtid was allocated for
such a fast commit and it was incremented once the fast commit was
successful as well.
>
> Instead, ext4_fsync() could just call the fast commit machinery, and
> the only thing we need to expose is a way for the fast commit
> machinery to attempt to grab a mutex preventing the normal commit
> thread from starting a normal commit.  If it loses the race, and the
> normal commit takes place before we manage to do the fast commit; then
> we don't need to do any thing more.  Otherwise the fast commit
> machinery can do its thing, writing inode changes to the journal, and
> once it is done, it can release the mutex and ext4 fsync can return.
>
> Does that make sense?
Thanks for the suggestion, I will implement this in V3.
>
>                                         - Ted
