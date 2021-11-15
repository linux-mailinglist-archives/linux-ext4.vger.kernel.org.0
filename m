Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4710E44FD46
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Nov 2021 03:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhKOC5J (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 14 Nov 2021 21:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhKOC5I (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 14 Nov 2021 21:57:08 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB424C061746
        for <linux-ext4@vger.kernel.org>; Sun, 14 Nov 2021 18:54:13 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id r11so1351569edd.9
        for <linux-ext4@vger.kernel.org>; Sun, 14 Nov 2021 18:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OoQXZWTxSb1twOt2KIBFmE1KZpkBTmpEQV5qUPdaQ+8=;
        b=jsGct6c3LlYq0dXVAoeTJ9bzmX5VupkK2mMoLque2W/E3sY/1jtxGF6w8Nfd3GGLzT
         liU4Z5uFucGzMnIi2ieD0BBa6HXH84OV4aSY+N+qZHVQn4yrHbrj378jE3gG8EMNEW0L
         d+1M/EJC2dVbBQs7maufJOO7PuEYrsgHyxhmsuOOPdKiP05heKDhF8u2NsE1RJQ6vQCo
         RDHnlxrmbsY7U2X80X8WEVSpB2VXJ9mi513F7DUkz7XakY0mTM4uIlLshXbjRJtBJ6Wq
         Ffd4zR6bpIIMrrsm5ZovPIj77CsXM20gZmLo8A8aF1VaJheBiamSH9Y03uKVjsugAEAK
         n6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OoQXZWTxSb1twOt2KIBFmE1KZpkBTmpEQV5qUPdaQ+8=;
        b=v6lS8k9VcgGvYB2nmjLSjBLgwm8e3XvbJ/KLWkAP66s5FLQX+LKWxFoc9qWajMWfaX
         K5Eqfv/hipeEU8O1neciUaLYfBrQAjwjaAxA+9RvUusKg3vzjmWbye28LbnPMoeFgnXa
         CHoaty3Mono6LDzPkM49I1EeTpq32H/lKoC6/YJzQOKOewDFkFC9RpotT/efLacIjQ0d
         Q9i+wtrmovFS2pYjcJDFP2MgKnRxJViaK9/zObzgyVEA7xL2pqRs+aITj03OAtQZG3Qa
         l25GorbA91sygrsUkdXpi5XtsoMF3W8VD/Mgl/5WL9VKLlvx4PxSxxyf8YSnIVSPxutU
         h3aA==
X-Gm-Message-State: AOAM532gDdco+waFi40qVnvxzs7w13GhgHsJUDU6XOYfH6iGDsmQGQPn
        6axQav2cXb7hS4EgNHvg7/Abmdm7Pz0BOGYZWT0mwA9iV08=
X-Google-Smtp-Source: ABdhPJx8dDvYRqpm0teN0OgDkCOJTmWSP+cFOSEWppyMuQwf6/ziG9DozSxk73c7IBNBHaVq3vngiY+JxVaru253o5Y=
X-Received: by 2002:a17:907:a426:: with SMTP id sg38mr45111606ejc.392.1636944852045;
 Sun, 14 Nov 2021 18:54:12 -0800 (PST)
MIME-Version: 1.0
References: <CAK896s5szH8qbDGBDo74hyz5iM4QrjbMJkMjh-f1sZh6K0ozTg@mail.gmail.com>
In-Reply-To: <CAK896s5szH8qbDGBDo74hyz5iM4QrjbMJkMjh-f1sZh6K0ozTg@mail.gmail.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Sun, 14 Nov 2021 18:54:00 -0800
Message-ID: <CAD+ocbyQQym54ZkY9Jdidju_bw9Pj32sGM3qigABCu-Uj3n4Hw@mail.gmail.com>
Subject: Re: [Question] ext4: different behavior of fsync when use fast commit
To:     =?UTF-8?B?5bC55qyj?= <yinxin.x@bytedance.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Xin,

Thanks for your email and steps to reproduce the issue.

> But fast commit did change the behavior of fsync in ext4,  is this as exp=
ected ?
No this is not expected. Fast commits should not change behavior of
fsync, so thanks for spotting it.

After taking a deeper look at the issue, I think the problem is that
fast commit intentionally avoids committing directory inodes and
instead just records that "file F has been added to / deleted from
directory D". The recovery code does the actual work of updating the
directory . It saves us space in the precious fast commit area.

While it is okay to skip "addition of dentry" or "deletion of dentry"
events on a directory, it is not okay to skip "creation of directory".
So, you're right, we should be passing "enqueue =3D 1" to
ext4_fc_track_template() which would tell it to also add the inode to
"the modified inodes" queue. Once the inode is in the modified inode
queue, commit routine first commits the inode and records addition of
dentry to its parent inode.

Please feel free to send a patch to fix this.

Thanks,
Harshad


On Wed, Nov 10, 2021 at 11:10 PM =E5=B0=B9=E6=AC=A3 <yinxin.x@bytedance.com=
> wrote:
>
> Hi,
>
>
> Recently, I=E2=80=98m doing some testing with fast commit feature , and f=
ound
> there is a slight difference on fsync compared with the normal
> journaling scheme.
>
> Here is the example:
>
> -mkdir test/
>
> -create&write test/a.txt
>
> -fsync test/a.txt
>
> -crash (before a full commit)
>
>
>
> If fast commit is used then =E2=80=9Ca.txt=E2=80=9D will lost. While the =
normal
> journaling can recover it.
>
> Refer to the description of fsync [1],  fsync will not guarantee the
> parent directory to be persisted. So I think it is not an issue.
>
> But fast commit did change the behavior of fsync in ext4,  is this as exp=
ected ?
>
>
>
> For the root cause of this difference, I found that fast commit will
> not add a EXT4_FC_TAG_CREAT tag for directory creation.
>
> In func ext4_fc_commit_dentry_updates(), only directories in s_fc_q
> list can be added with EXT4_FC_TAG_CREAT,but seams the newly created
> directory inode has no change to be added to s_fc_q.
>
>
>
> Shall we just change the =E2=80=9Cenqueue=E2=80=9D param of ext4_fc_track=
_template()
> to 1 , which in __ext4_fc_track_create()?  And make fast commit record
> all the inode creation, and do the same things as normal journaling.
>
>
>
> [1] https://man7.org/linux/man-pages/man2/fdatasync.2.html
>
>
>
> BR,
>
> Xin Yin
