Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC5544FD4E
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Nov 2021 03:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhKODCc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 14 Nov 2021 22:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhKODC1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 14 Nov 2021 22:02:27 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6ACAC061746
        for <linux-ext4@vger.kernel.org>; Sun, 14 Nov 2021 18:59:30 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z10so38706621edc.11
        for <linux-ext4@vger.kernel.org>; Sun, 14 Nov 2021 18:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/LY4RRQUAzzup1PpuAxDoghzp/ky4NRVN/yMuuDoLFc=;
        b=NgVBoqF3wQTjCFuCUlRuCfHZFh8uQ5dV4y4h/aIelAnGJIaMOknrS0grJcooaRq0El
         n2d8Hdnh8OeKoxPOiKFXO2zqOAz9PW7cW0uJl+6FMXLpGW3JEMqbPXme6rg0LJ6vViNP
         SsL6Pe4q1gkJiwWGndzzcI1zlvRtCN4/1gZyiflnxBgLfFMtgKoxaOeBeBGZnO1VuqCR
         PoTA9Qw0v6SllUGmN+2uUjTFx8QNcrYIhI5hclQZO/wKu63WcObv1odcDch6pYhwnGYB
         FlGbvmgLVQl8/VuWXKSO3cMF7xWnEKlC5oiKUaR3HqcIdll/uaF6HymrDO2XCDvDv0CD
         VWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/LY4RRQUAzzup1PpuAxDoghzp/ky4NRVN/yMuuDoLFc=;
        b=ypqD29cbn4vu9WrO8BaRwh1Jg9ph/FdQz4y/OWQYOMhlNpCDfTHduPi4IflKIWWXOk
         hJtVxouqGyQ8lp4zebsGvgBlIW/EAC/HQhpkvBEnp9yC8CMuPnFmSK6lxaDqqXnbbYBk
         DC6z0mVhhcrJsm9v0MHeHQ2cT2XmJ8fPKis+ZOUxh8VB1JgcJ8UjI8KtML5Q/S+mEBmS
         TbljxILwHxJygT4Bl75aY9glYP6gTiSBM2DP6y8QIo2BoGv0zP8Ewz08Q9scS2Kmk7f0
         VQKI7TmkpFFQU9/eXNCNhJr8doHT0xHHLWSBcAYQe2AuMTPCqH2N82iBUZVQlmE325rI
         ogMQ==
X-Gm-Message-State: AOAM530SA0Jh2HGs7KrP9RdLMEdxU2JmFC4Sbbj/fbLV972LivKBoU7Y
        s1Q/SkZpVuB/NZOwMhjX0LWYS2/QxE5bGMN+mkE=
X-Google-Smtp-Source: ABdhPJxF3OpVGlU0Hku3vk2i1ck8r/zVRkOGsEOgCUR8djUKqSgbsM3shMU9C2JhqAVBPDMcvFjjJm9+rLr2jyb17Pw=
X-Received: by 2002:a17:906:489b:: with SMTP id v27mr43470995ejq.567.1636945169211;
 Sun, 14 Nov 2021 18:59:29 -0800 (PST)
MIME-Version: 1.0
References: <CAK896s5szH8qbDGBDo74hyz5iM4QrjbMJkMjh-f1sZh6K0ozTg@mail.gmail.com>
 <CAD+ocbyQQym54ZkY9Jdidju_bw9Pj32sGM3qigABCu-Uj3n4Hw@mail.gmail.com>
In-Reply-To: <CAD+ocbyQQym54ZkY9Jdidju_bw9Pj32sGM3qigABCu-Uj3n4Hw@mail.gmail.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Sun, 14 Nov 2021 18:59:18 -0800
Message-ID: <CAD+ocbzBg8bnBZcVcQ-kU=zMZWYzGbw=HC34Zb=f9zHXyos8XQ@mail.gmail.com>
Subject: Re: [Question] ext4: different behavior of fsync when use fast commit
To:     =?UTF-8?B?5bC55qyj?= <yinxin.x@bytedance.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Nov 14, 2021 at 6:54 PM harshad shirwadkar
<harshadshirwadkar@gmail.com> wrote:
>
> Hi Xin,
>
> Thanks for your email and steps to reproduce the issue.
>
> > But fast commit did change the behavior of fsync in ext4,  is this as e=
xpected ?
> No this is not expected. Fast commits should not change behavior of
> fsync, so thanks for spotting it.
>
> After taking a deeper look at the issue, I think the problem is that
> fast commit intentionally avoids committing directory inodes and
> instead just records that "file F has been added to / deleted from
> directory D". The recovery code does the actual work of updating the
> directory . It saves us space in the precious fast commit area.
>
> While it is okay to skip "addition of dentry" or "deletion of dentry"
> events on a directory, it is not okay to skip "creation of directory".
To clarify and rephrase this better: While it is okay to skip
recording of directory inode during addition of dentry or deletion of
dentry events on a directory (which is the reason why
ext4_fc_track_link() and ext4_fc_track_unlink() pass "enqueue =3D 0" to
ext4_fc_track_template()), it is not okay to skip recording of the
directory inode during creation of directory event - which is what
fast commit code was unintentionally doing.
> So, you're right, we should be passing "enqueue =3D 1" to
> ext4_fc_track_template() which would tell it to also add the inode to
> "the modified inodes" queue. Once the inode is in the modified inode
> queue, commit routine first commits the inode and records addition of
> dentry to its parent inode.
>
> Please feel free to send a patch to fix this.
>
> Thanks,
> Harshad
>
>
> On Wed, Nov 10, 2021 at 11:10 PM =E5=B0=B9=E6=AC=A3 <yinxin.x@bytedance.c=
om> wrote:
> >
> > Hi,
> >
> >
> > Recently, I=E2=80=98m doing some testing with fast commit feature , and=
 found
> > there is a slight difference on fsync compared with the normal
> > journaling scheme.
> >
> > Here is the example:
> >
> > -mkdir test/
> >
> > -create&write test/a.txt
> >
> > -fsync test/a.txt
> >
> > -crash (before a full commit)
> >
> >
> >
> > If fast commit is used then =E2=80=9Ca.txt=E2=80=9D will lost. While th=
e normal
> > journaling can recover it.
> >
> > Refer to the description of fsync [1],  fsync will not guarantee the
> > parent directory to be persisted. So I think it is not an issue.
> >
> > But fast commit did change the behavior of fsync in ext4,  is this as e=
xpected ?
> >
> >
> >
> > For the root cause of this difference, I found that fast commit will
> > not add a EXT4_FC_TAG_CREAT tag for directory creation.
> >
> > In func ext4_fc_commit_dentry_updates(), only directories in s_fc_q
> > list can be added with EXT4_FC_TAG_CREAT,but seams the newly created
> > directory inode has no change to be added to s_fc_q.
> >
> >
> >
> > Shall we just change the =E2=80=9Cenqueue=E2=80=9D param of ext4_fc_tra=
ck_template()
> > to 1 , which in __ext4_fc_track_create()?  And make fast commit record
> > all the inode creation, and do the same things as normal journaling.
> >
> >
> >
> > [1] https://man7.org/linux/man-pages/man2/fdatasync.2.html
> >
> >
> >
> > BR,
> >
> > Xin Yin
