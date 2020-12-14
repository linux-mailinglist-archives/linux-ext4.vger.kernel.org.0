Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF3C2D9F77
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Dec 2020 19:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440953AbgLNSpm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Dec 2020 13:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440951AbgLNSpV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 14 Dec 2020 13:45:21 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893D8C0613D3
        for <linux-ext4@vger.kernel.org>; Mon, 14 Dec 2020 10:44:41 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id 19so16567044qkm.8
        for <linux-ext4@vger.kernel.org>; Mon, 14 Dec 2020 10:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Qk4am2aZ/3IfkXb1NDFZYDnIAY7ApZ0zdjpeThZwvkY=;
        b=feG5xeMS3Y64K+EEDNOf6ETnOIxYP3foNeERtf2IpqNK1lEqluvysPAKXGIwRugt11
         HDaOz4GHp8H0A52mwQnfk3ezM81hnfntmkcU4wBrdBJXbxyi5idw85eb/D5CaHGlgLbM
         u9jrAuFuPtI8AqX0kXushcYfjVis/EMyN0iBzePlTviRuKitXJG5l3IZM34K0tfOSrio
         QIDsT2tOR5FPYFT+Ob0SK+IfBDbm8o0Kx50otdAfashVZIi4Cu6ISOpXiSsiPr5hl3rg
         Al0btcbGf2I4fDbXOI3PUOL/lAgSjr7fRa0+5VBuLmL3tZ+muagDsExuWuCmQhbUGv61
         XNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Qk4am2aZ/3IfkXb1NDFZYDnIAY7ApZ0zdjpeThZwvkY=;
        b=imopuJrIhxVVzhrNlIahSs7ZEhCYwy2USRDLCtKx4M8rx3FAr13nHhhUUFtODltFE/
         iAlmjcrctPy+PnpMWILnKLEMcTt3Ou3XomASexwBvNKLLkOvOQwVtkkYBsOGiGckRxLh
         iFOf9z1zuWlYaG0c0ieBaS4nVtSW0muRjire8UuEBFowUMYsxHOmIjz9yxJE6uj5gpLx
         CQxTGwe8+cJfLZiafTjzvKBvBKlNyHbELdcjNDoN2GrsKl0JsTt1yU4yDO6qqMSaOorO
         PQZt5znlbN1f5SaB4KaNj84D6BIr1KD9MZMBDQKKFh4xWXKLI4MVlNG0Gb8iOJrqbTVw
         7FJQ==
X-Gm-Message-State: AOAM532ULJw9pw8PCDK7qiN23lu7ZwdhPGo+FO9knw2tBqLVIFEjTdEt
        h2UEZ3A4mBOj9H+1EhC/qeM44luAr0PhqWv0nGMKBM7MPJZHsg==
X-Google-Smtp-Source: ABdhPJxnLSk8MQHaU1hUmExFBsGlf7yZxtHuv2NY6rpXbcHOINjO+/NItmshHceKaNnPlpwLwTnfeYPShOFa+Y8sOJY=
X-Received: by 2002:a37:a0c6:: with SMTP id j189mr34642608qke.142.1607971480720;
 Mon, 14 Dec 2020 10:44:40 -0800 (PST)
MIME-Version: 1.0
References: <1bb3c556-4635-061b-c2dc-df10c15e6398@huawei.com>
 <CAD+ocbxAyyFqoD6AYQVjQyqFzZde3+QOnUhC-VikAq4A3_t8JA@mail.gmail.com> <3e3c18f6-9f45-da04-9e81-ebf1ae16747e@huawei.com>
In-Reply-To: <3e3c18f6-9f45-da04-9e81-ebf1ae16747e@huawei.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 14 Dec 2020 10:44:29 -0800
Message-ID: <CAD+ocbz=mp8k2Ruqiagq7ZDfhGui29X8Wz-_7698zaghzH4BXA@mail.gmail.com>
Subject: Re: [PATCH] e2fsck: Avoid changes on recovery flags when
 jbd2_journal_recover() failed
To:     Haotian Li <lihaotian9@huawei.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "liuzhiqiang (I)" <liuzhiqiang26@huawei.com>,
        linfeilong <linfeilong@huawei.com>, tytso@alum.mit.edu,
        liangyun2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Haotian,

Yeah perhaps these are the only recoverable errors. I also think that
we can't surely say that these errors are recoverable always. That's
because in some setups, these errors may still be unrecoverable (for
example, if the machine is running under low memory). I still feel
that we should ask the user about whether they want to continue or
not. The reason is that firstly if we don't allow running e2fsck in
these cases, I wonder what would the user do with their file system -
they can't mount / can't run fsck, right? Secondly, not doing that
would be a regression. I wonder if some setups would have chosen to
ignore journal recovery if there are errors during journal recovery
and with this fix they may start seeing that their file systems aren't
getting repaired.

I'm wondering if you saw any a situation in your setup where exiting
e2fsck helped? If possible, could you share what kind of errors were
seen in journal recovery and what was the expected behavior? Maybe
that would help us decide on the right behavior.

Thanks,
Harshad

On Sun, Dec 13, 2020 at 5:27 PM Haotian Li <lihaotian9@huawei.com> wrote:
>
> Hi Harshad,
>
> Thanks for your review. I think you are right, so I try to find
> all the recoverable err_codes in journal recovery. But I have no
> idea to distinguish all the err_codes. Only the following three
> err_codes I think may be recoverable. -ENOMEM,EXT2_ET_NO_MEMORY
> ,-EIO. In these cases, I think we probably don't need ask user if
> they want to continue or not, only tell them why journal recover
> failed and exit instead. Because, the reason cause these cases
> may not disk errors, we need try to avoid the changes on the disk.
> What do you think?
>
> Thanks,
> Haotian
>
> =E5=9C=A8 2020/12/12 6:07, harshad shirwadkar =E5=86=99=E9=81=93:
> > Hi Haotian,
> >
> > Thanks for your patch. I noticed that the following test fails:
> >
> > $ make -j 64
> > ...
> > 365 tests succeeded     1 tests failed
> > Tests failed: j_corrupt_revoke_rcount
> > make: *** [Makefile:397: test_post] Error 1
> >
> > This test fails because the test expects e2fsck to continue even if
> > the journal superblock is corrupt and with your patch e2fsck exits
> > immediately. This brings up a higher level question - if we abort on
> > errors when recovery fails during fsck, how would that problem get
> > fixed if we don't run fsck? In this particular example, the journal
> > superblock is corrupt and that is an unrecoverable error. I wonder if
> > instead we should check for certain specific transient errors such as
> > -ENOMEM and only then exit? I suspect even in those cases we probably
> > should ask the user if they would like to continue or not. What do you
> > think?
> >
> > Thanks,
> > Harshad
> >
> >
> > On Fri, Dec 11, 2020 at 4:19 AM Haotian Li <lihaotian9@huawei.com> wrot=
e:
> >>
> >> jbd2_journal_revocer() may fail when some error occers
> >> such as ENOMEM. However, jsb->s_start is still cleared
> >> by func e2fsck_journal_release(). This may break
> >> consistency between metadata and data in disk. Sometimes,
> >> failure in jbd2_journal_revocer() is temporary but retry
> >> e2fsck will skip the journal recovery when the temporary
> >> problem is fixed.
> >>
> >> To fix this case, we use "fatal_error" instead "goto errout"
> >> when recover journal failed. We think if journal recovery
> >> fails, we need send error message to user and reserve the
> >> recovery flags to recover the journal when try e2fsck again.
> >>
> >> Reported-by: Liangyun <liangyun2@huawei.com>
> >> Signed-off-by: Haotian Li <lihaotian9@huawei.com>
> >> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> >> ---
> >>  e2fsck/journal.c | 9 +++++++--
> >>  1 file changed, 7 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/e2fsck/journal.c b/e2fsck/journal.c
> >> index 7d9f1b40..546beafd 100644
> >> --- a/e2fsck/journal.c
> >> +++ b/e2fsck/journal.c
> >> @@ -952,8 +952,13 @@ static errcode_t recover_ext3_journal(e2fsck_t ct=
x)
> >>                 goto errout;
> >>
> >>         retval =3D -jbd2_journal_recover(journal);
> >> -       if (retval)
> >> -               goto errout;
> >> +       if (retval && retval !=3D EFSBADCRC && retval !=3D EFSCORRUPTE=
D) {
> >> +               ctx->fs->flags &=3D ~EXT2_FLAG_VALID;
> >> +               com_err(ctx->program_name, 0,
> >> +                                       _("Journal recovery failed "
> >> +                                         "on %s\n"), ctx->device_name=
);
> >> +               fatal_error(ctx, 0);
> >> +       }
> >>
> >>         if (journal->j_failed_commit) {
> >>                 pctx.ino =3D journal->j_failed_commit;
> >> --
> >> 2.19.1
> >>
> > .
> >
