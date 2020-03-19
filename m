Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 354F118AA54
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Mar 2020 02:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgCSBe1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Mar 2020 21:34:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42620 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgCSBe0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Mar 2020 21:34:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id v11so735247wrm.9
        for <linux-ext4@vger.kernel.org>; Wed, 18 Mar 2020 18:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SuERmyPuhCg3zAVzXBMx4EONeH0JdIBVUoFaYugV9mA=;
        b=kR8z+FlATtPoIj+aQ/Cy89Vwo9FBzlr32JUtR0aDIEIUOqUtzMq5fHpcd8E2rpuS6+
         dlwo5Cj0uj9EtVRtDeNGA3X6zyoExc+GqQbpATXW+qJapAgLPrCVe7M9ppl1pLOAZkGC
         KZi89teuyoASn7S3TzimXm8IBLagZ9tSPmJUnHOdtmYQfOBtUzDEVbzrATNPO23zFrEC
         iY1LOrO2dvk1gy1Pd2cBuJDgrV+RZriGEvA7bYPfkWbRQFmolMTVVGitnbu83RZjJ4qd
         9yZZcHuPrWvs2grkM/UEuKm4dK9NPvb6Tt5I4v7f+JcSeBI4ZNl7zlhDu73qeDtWXdhr
         6rOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SuERmyPuhCg3zAVzXBMx4EONeH0JdIBVUoFaYugV9mA=;
        b=iblSM90tCv/Tbwsybgk6l1NH8YonBDJi1Ca+xZxXg2CoXgFTGeJPrCW1YwgnsvrqLY
         WI8VU5Y7yvTv/Q735pSF9NvMNOpL5vVrVP/p4ifumwpPZn1NYjSSEueK0C6SSreKEgYj
         pUiPerUYbP4oNZHj1guRoCD6x24pdiCVLUAI+5qzmhOXcgjI7fgG+ViAOI24EJXasfIF
         UK3+bKWWKo3AeTpRQuXqfat5VqGlfw4XUQVdDYS9KHw/VQ/jyvyZQiDnKaazPGdZdTL6
         +a9d5rWD4htfN1v6kqwcf81Zw6WlSmHot65vN9S1RqrbcPYA2KzIn9xqEe9sy0a/5djz
         ESUQ==
X-Gm-Message-State: ANhLgQ0oSTCSIHCx5dld6zxzJip/LHHZBu6tb75B56I+6BLw73CcXzte
        LtpGD4htndlzvRKLVgRt8P6ld4TDb532qIGkaTnFSg==
X-Google-Smtp-Source: ADFU+vsNw9TvmQidiXgZRZv+iQHllz24IZJBNzZLUJS6lywIIW6gC2oGtDmI/5VXfWfhZu0LVRbJ/5Hp7NVqdt2l+B4=
X-Received: by 2002:a5d:6344:: with SMTP id b4mr830627wrw.354.1584581664997;
 Wed, 18 Mar 2020 18:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAAJeciW-r=+90gMJvEZ8xFMFwUH+rD1Qf9DRmqatD51vMgHbJg@mail.gmail.com>
 <20200318032817.GA893@sol.localdomain>
In-Reply-To: <20200318032817.GA893@sol.localdomain>
From:   xiaohui li <lixiaohui1@xiaomi.corp-partner.google.com>
Date:   Thu, 19 Mar 2020 09:34:03 +0800
Message-ID: <CAAJeciWFic9ZJ+-kmy8ENCZD_5MAZpAj6omRPZUN2FDQaxFmMg@mail.gmail.com>
Subject: Re: is there root_fs.arm32 used by xfstests?
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

oh, thank you.
I will try it as what you say.

On Wed, Mar 18, 2020 at 11:28 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, Mar 18, 2020 at 11:16:32AM +0800, xiaohui li wrote:
> > hello ted:
> >
> > many thanks for your xfstests-bld project which can be deployed on
> > android systems and make mobile phone more robust and stable.
> > but as is known, many low-end mobile phone=E2=80=99s cpu still use the =
arm32
> > architecture.
> > and if these low-end mobile phone also can make full use of xfstests
> > to do fs tests,
> > there will be more fs bug will be found and our filesystem will become
> > more robust.
> >
> > but from below link:
> > https://www.kernel.org/pub/linux/kernel/people/tytso/kvm-xfstests
> > there is not arm32 root_fs.
> >
> > so if you or anyone can offer me a link which can download arm32
> > root_fs needed by xfstests=EF=BC=8C
> > i appreciate it very much.
> >
> > best regards.
>
> Great to hear that you're interested in running xfstests on Android!  Pro=
bably
> Ted stopped providing an arm32 root_fs because arm64 is much more common =
now.
> It should be pretty straightforward to build an arm32 root_fs.tar yoursel=
f,
> though; have you checked the documentation in
> https://github.com/tytso/xfstests-bld/blob/master/Documentation/building-=
rootfs.md
> ?
>
> It should just require:
>
>         sudo ./setup-buildchroot --arch=3Darmhf
>         ./do-all --chroot=3Dbuster-armhf --out-tar
>
> I haven't done it in a while so I can't guarantee it hasn't gone stale, b=
ut it's
> supposed to work.
>
> - Eric
