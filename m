Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1EF5B3700
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2019 11:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfIPJUe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Sep 2019 05:20:34 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34908 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfIPJUe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Sep 2019 05:20:34 -0400
Received: by mail-ed1-f66.google.com with SMTP id v8so1061859eds.2
        for <linux-ext4@vger.kernel.org>; Mon, 16 Sep 2019 02:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zomg-hu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TGaRemEmFeSSlnNdj7nX2rcO4xNpEWP90cFSs0qWvPI=;
        b=Xk08xXi8ootHZXDv6Tb6QFAxZt2l2MDryctGAoTV3k68DT63La3oUBU+BKPjG2d91D
         PQyfq1RKqt8R4paAifgqODfNOJs4d6P69O+o+rnC8bdngstnQpJ3eOjG0qfEnUFQiWwI
         K3XoIyl6WtOziPcewSc6ilHhLs2brzMG/b/LXiwV3wCD7N5mRlelZyv9WxrI+OaOZLLD
         D7kzDlFYfsOVIw6q+zP5CXUMc5+AdoEG+GVU9ISwRwzSTSTGDtt+Y7aMeWpcXlyDjy1H
         CImQIqziJDV03gg6d0Wa8aQ/lwpTjPl2A3LU3ktXeCVxANOZzgRn/rUQRZdASnEn48Bc
         LftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TGaRemEmFeSSlnNdj7nX2rcO4xNpEWP90cFSs0qWvPI=;
        b=eOB44Iw+6QZ4q2Ts4uU1vCNDfn6aSBGHZdkjsFynGwJ518goQ4Y4HecmGiY1SPpOnw
         3Ln9lgA7A222TTlswqADEA0RrEMsS80qvHsLrB9g+SPgXJUAsyuKOostf90wdV/jy/96
         39aaUjGm5lyuanfiZqWU7pAKWOFEyCdRcFwY6I7jLUsev6XB7cy0wMXPZE442E8vbzOf
         F77nf2Hj6GXZiDY8lu7l2rme6c0XCwbn7MWQP6uNVdzDbzvzQXUikX13+QE0nNCvvNmu
         91YvMZgZ5UwEl7RNZvJ25vzjq31gCVkpPuNAHROkI00P+AQStFy/7lEOB52A4eBKXhA2
         N1Kg==
X-Gm-Message-State: APjAAAUPX2Re9+IuLThidrgqMKWeT7SOKwWokUoc8xfWenP9Vhr3CIsq
        MicbRz8DIJTrUJKhoRA2UV8lpc0iHYA8L+K9jJWFZCpF8BA=
X-Google-Smtp-Source: APXvYqzVNB/dzYe8aKTndeMZTkiuc8xVdTY90rFwfegQPdO20b8BH4IDGyv66P64YF8qETFV2i8iUYD4vEktC+JIyDY=
X-Received: by 2002:a50:f00c:: with SMTP id r12mr61078890edl.274.1568625632239;
 Mon, 16 Sep 2019 02:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAF1H-TADHtpDtdL++Vk1FLAL7jJbOOifnN+7taDXpVkjYrbsgA@mail.gmail.com>
 <20190914232801.GD19710@mit.edu>
In-Reply-To: <20190914232801.GD19710@mit.edu>
From:   Pas <pas@zomg.hu>
Date:   Mon, 16 Sep 2019 11:20:20 +0200
Message-ID: <CAF1H-TAUkTqX+nWjpp0bxLrmOShr4eSTDPL=yqrnoLaph950tg@mail.gmail.com>
Subject: Re: inline_data status (e2fsprogs)
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for the blazing fast and detailed reply!

Am I correct assuming that the jbd2 problem is only (mostly?) relevant
in case of data=journal mode?

> It also generally doesn't buy you much for most file system
workloads, so it hasn't been high on my priority list to fix.

Completely understandable. I wasn't really hunting for those juice
performance bits, however it seemed like a nice optimization that's in
the kernel for quite long, plus enabling it is just a bit flip, then
why not? But then I haven't found anything conclusive on it.

Thanks again for clearing things up!

Pas

On Sun, 15 Sep 2019 at 01:28, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Sat, Sep 14, 2019 at 08:06:04PM +0200, Pas wrote:
> >
> > I hope this is the correct forum to ask these questions. (If not, then
> > sorry for the noise! Though then could you recommend where to ask
> > them?)
>
> There are some known issues with with the inline_data feature; in
> particular, it violates some of the jbd2 rules about how to jorunal
> data blocks.  As such, bad things(tm) can happen on crash recovery.
> For the most part it works OK for the original intended use case, was
> for bigalloc file systems where there was a desire to handle small
> directories more efficiently, which was how the developer who created
> the feature used said feature.  I didn't realize this particular
> rather serious bug until after the feature went into the kernel, and
> it's been on my todo list to fix; I just haven't had the time.
>
> It doesn't happen all that often; you need to start files that are
> small enough such that they can fit in an inline_data file, and then
> grow them via an appending write so that they need to be shifted to an
> block allocated file, and then force an unclean shutdown at an
> inopportune time.
>
> But yeah, there is a good reason why it's not a default-enabled
> feature.  It also generally doesn't buy you much for most file system
> workloads, so it hasn't been high on my priority list to fix.
>
> Regards,
>
>                                         - Ted
