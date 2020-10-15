Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3E028F5F4
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Oct 2020 17:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389734AbgJOPiC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Oct 2020 11:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389730AbgJOPiC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Oct 2020 11:38:02 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B321C061755
        for <linux-ext4@vger.kernel.org>; Thu, 15 Oct 2020 08:38:02 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id k9so2676989qki.6
        for <linux-ext4@vger.kernel.org>; Thu, 15 Oct 2020 08:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=V0VfdeUfw6NsdlOpDZXNb0VUIwgIXGaIRWlsm2FmJAA=;
        b=pHXOtsMC2r1VWMVaHi0ghO96UrdnT9mkap3hDYNE+o8taONbZCZv5w2gKyYtSg0KaB
         dqvHAHv1ER42TBaI8vyPiiP/fSacXCz8eNq3qGlcfoEdjT+jR375AAPHh8TvJubn3409
         uZgL49Ic+m+nWdIBMAdq2Bvs2lb9CoPx6QzAdcoZCKmAxyxV8HS+G+mMYlWulXLDf2UU
         vJPEc3wzXyawBa4zJW5JVgyvhAeyFgl0l2UWiBKPI+vqfMAmgqeo4C5kAtc2cTKkyuX2
         XN0sCKKbiNfUPy2aOvsdNJwoop6lkUJDIfF/2ySeKVbNuvov8p84H+ImPCP/9h8JT3VO
         G1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=V0VfdeUfw6NsdlOpDZXNb0VUIwgIXGaIRWlsm2FmJAA=;
        b=KC2nJqWt01/4PygvyofkYCLUn3oB15vU5qdwwc8DyYhPy6AbUidYgg4a/oqnwyu1gC
         Vt0T0sI8Pze9x50bTyU5zckajy9zyndfXZS4MedVaQp+bX63XVVPCktgy2C03fQWqT6Z
         Uq95Ju54YAFeOywhEpjNAy5rw/Zja8NBrHVvIo9HuvM/CJCVJbc9+GVbMWwkXdhP1kO4
         pmh7ufZONOYGKe1AF3Sefpb9z0cT025KX+ZhkmkN4z+EgYCgVatrlcJ4Dzcou4BXX9Jf
         eSY3hVb4hqM+lDjQS8fu0w4u3mYQVFfOZPIP/zZpXF+tJwj8OA7AV41DaBvFyLlY84PF
         9BdA==
X-Gm-Message-State: AOAM531+wbit7NsG7gMAaxQqXDwbpLbX+LPvcRRy9l4smoxmRBnDzb1O
        LFTsNcZtcGoe5VKW+ZqCrKzqO+h7V7DH2xqz/paFAbkXB1k=
X-Google-Smtp-Source: ABdhPJz0OQJcVa/OOjWpraTYFSgc2Lkrl+W+gfGucYb9Ps1T7gZD8aq9oF8fE+zA7iWTCfXDoH9oxRP5PcY8jJELurs=
X-Received: by 2002:a37:9cd3:: with SMTP id f202mr4407564qke.479.1602776281697;
 Thu, 15 Oct 2020 08:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAL3q7H4boq-Rsm+OSK5bSBJhu-ywugOdwWfHRQkyuyDC_RoRZA@mail.gmail.com>
 <20200708141706.GB5288@quack2.suse.cz>
In-Reply-To: <20200708141706.GB5288@quack2.suse.cz>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 15 Oct 2020 16:37:49 +0100
Message-ID: <CAL3q7H6zoYUZsQrTmgNm-wyFJgzjRcbY-TtjU=tg394iMxno9w@mail.gmail.com>
Subject: Re: RWF_NOWAIT writes not failing when writing to a range with holes
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 8, 2020 at 3:17 PM Jan Kara <jack@suse.cz> wrote:
>
> Hi!
>
> On Mon 15-06-20 18:53:11, Filipe Manana wrote:
> > I found out a bug in btrfs where a RWF_NOWRITE does not fail if we
> > write to a range that starts with an extent followed by holes (since
> > it requires allocating extent(s)).
> >
> > When writing a test case for fstests I noticed xfs fails with -EAGAIN
> > as expected, but ext4 succeeds just like btrfs currently does:
> >
> > mkfs.ext4 -F /dev/sdb
> > mount /dev/sdb /mnt
> >
> > xfs_io -f -d -c "pwrite -S 0xab -b 256K 0 256K" /mnt/bar
> > xfs_io -c "fpunch 64K 64K" /mnt/bar
> > sync
> > xfs_io -d -c "pwrite -N -V 1 -b 128K -S 0xfe 0 128K" /mnt/bar
> >
> > Is this a known bug? Or is there a technical reason that makes it too
> > expensive to check no extents will need to be allocated?
>
> Thanks for report! This is actually a fallout of the conversion of ext4
> direct IO code to iomap (commit 378f32bab37 "ext4: introduce direct I/O
> write using iomap infrastructure"). I'll send a fix.

Thanks for looking into it Jan.

I just wrote a test case for fstests that exercises that case and
others where btrfs used to fail.
And I think I found some regression happened in ext4 in the meanwhile.
Basically a write into a fallocated extent that starts at eof now
fails with -EAGAIN in ext4 on a 5.9-rc6 kernel at least, but it used
to work when I found the bug in btrfs [1] (with a 5.7 kernel iirc).

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D4b1946284dd6641afdb9457101056d9e6ee6204c

That new test case:
https://patchwork.kernel.org/project/fstests/patch/aa8318c5beb380a9e99142d1=
b5e776b739d04bdb.1602774113.git.fdmanana@suse.com/

Thanks.

>
>                                                                 Honza
>
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
