Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 350FBDF9F0
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Oct 2019 02:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbfJVAvc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Oct 2019 20:51:32 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44835 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbfJVAvb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Oct 2019 20:51:31 -0400
Received: by mail-oi1-f193.google.com with SMTP id w6so12700455oie.11
        for <linux-ext4@vger.kernel.org>; Mon, 21 Oct 2019 17:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wKeXQ6WSWVCuZeO3MaMM0GeqhfTH6DUUj/94XvXxApg=;
        b=snFZE5ED1snZX9RerA7ijkHwzVNharm7oaKz8HB1Cxcn4xWlGP2Wp94qR6yue+XmhZ
         hGk8Amuxt5GVw/oDuY0xxaKyOLqYWn4VTOZLe/qN8uj87JEkwS5Lr9ieA+bFbuw7Qia0
         8FHndO7dGXeNqi6KkHN4q9f5Kb4+f3Stv7WNsKk3ERMW9C594ytApehZXS+k6gN82izA
         DCoDj6P8FZU4siT2XXK69FeWazAXdomTdVQm94lyCBn+sMKteltSL35t9YDa3+MMRD6c
         IiCfCP0t8857csEfqHv3J3IUT7Wa6BhIK4WdR3RX2Jd7u23iGzkgDu8jmbKwb290AbN0
         k1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wKeXQ6WSWVCuZeO3MaMM0GeqhfTH6DUUj/94XvXxApg=;
        b=uTOqezGmHGmnIe6dURhf609n0qU5VXImWW21BgC9R2QNw5ODzYutN/6CbUEFAqZUrV
         bV2KjDzIMtuGdP1oahHDookj6LPnMKVpqO73CrEuLglvqHo37r//jNhvd7n8DaJY17bD
         tVsATSfWW4Cuvklr2uccO2fbQ6VybjG+xjMlbbHEuVQBoe3NaMbwcFYa92dzp8etTncE
         Ah56KKSL+PUCFUNK8vLIyWnnwdu6z9wwmdNWHrIICzjl4dOObuHTbyconz9M3iZoVJDU
         ZYYzGcqxji6hxdMMwHN6KOyKIVmajwD2KDYuR0+/66m4JZ2dxrLGhj/RwAoizMvMYJre
         jEiA==
X-Gm-Message-State: APjAAAVH6HXSmgOQkig0HUzHNLydANtm32Lxf/6WvlY0sMcM+2zzysOJ
        lhct9yTCaF2jtzDe9JhYuif3i5ygOmqgOdo4XFw=
X-Google-Smtp-Source: APXvYqyTEy5qukk4jSXEpUcdZw3dMufp4MMbc1yfWY7M/sKl2bHUEflQ9PvmFAVmHYCWrT1vziX+w+LRIDj6NY9QXCI=
X-Received: by 2002:a05:6808:10:: with SMTP id u16mr749374oic.16.1571705490575;
 Mon, 21 Oct 2019 17:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
 <20191001074101.256523-6-harshadshirwadkar@gmail.com> <20191016173039.GE11103@mit.edu>
In-Reply-To: <20191016173039.GE11103@mit.edu>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 21 Oct 2019 17:51:19 -0700
Message-ID: <CAD+ocbywMJg3UG523sSLpoNmni7e8Gv1dDYGtF=2zsXDNoMUtQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/13] jbd2: fast-commit recovery path changes
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 16, 2019 at 10:30 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Tue, Oct 01, 2019 at 12:40:54AM -0700, Harshad Shirwadkar wrote:
> > diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> > index 14d549445418..e0684212384d 100644
> > --- a/fs/jbd2/journal.c
> > +++ b/fs/jbd2/journal.c
> >
> >       jbd2_write_superblock(journal, write_op);
> >
> > +     if (had_fast_commit)
> > +             jbd2_set_feature_fast_commit(journal);
> > +
>
> Why the logic with had_fast_commit and (re-)setting the fast commit
> feature flag?
>
> This ties back to how we handle the logic around setting the fast
> commit flag if requested by the file system....

Fast commit feature flag serves 2 purposes: 1) If the flag is turned
on in on-disk superblock, it means that the superblock contains fast
commit blocks that should be replayed. 2) If the flag is turned on in
the in-memory representation of the superblock, it serves as an
indicator for the rest of the JBD2 code that fast commit feature is
enabled. Based on that flag, for example, the journal thread decides
to try fast commits. In this particular case, since the journal is
empty we don't want to commit fast commit feature flag on-disk but we
want to retain that flag in in-memory structure.

>
> > @@ -768,6 +816,8 @@ static int do_one_pass(journal_t *journal,
> >                       if (err)
> >                               goto failed;
> >                       continue;
> > +             case JBD2_FC_BLOCK:
> > +                     continue;
>
> Why should a Fast Commit block ever show up in the primary part of the
> journal?   It should never happen, right?
That's right, I'll fix this in next version.
>
> In which case, we should probably at least issue a warning, and not
> just skip the block.
>
>                                         - Ted
