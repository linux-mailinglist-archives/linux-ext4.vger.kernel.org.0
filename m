Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8CDAFFBDF
	for <lists+linux-ext4@lfdr.de>; Sun, 17 Nov 2019 23:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfKQWOV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 17 Nov 2019 17:14:21 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44327 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfKQWOV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 17 Nov 2019 17:14:21 -0500
Received: by mail-io1-f65.google.com with SMTP id j20so5493923ioo.11
        for <linux-ext4@vger.kernel.org>; Sun, 17 Nov 2019 14:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dxu8o2qHWR0EXSrarvDxqJb9MJ6dYNmxMSt9Vv3SMos=;
        b=ddexHeWk+w9w0ex/32bSyDk2HiFIfOtFFtaXcTIbP6hdH8NTO4u7i0ljXS3pJAoi7w
         rPjk6JXkc0yIlpi1f0+QQiyfYoxXqe7ZYxptuySj5uhkkkTFKYX5RGjUWKFZafF3X984
         EpQuZjjc4j07oMHL1Vh2NdVqUqtHVjJxqAYnBW0g+JZN90t/AuMkLF1+g9hXrWgXEw4k
         sbUzhdQaCYldBBuRKHYLUCO/jmoq8O6ryDK/b0hwGdpX7L8ipdK7UF6dzVXUHQCyJSuW
         gDG4nAqW3+Y99a6h2pXa5NWg96l4sOtPadEsaikIs9W14nMh1W4yDdrq+8Z38e6TiLjJ
         TUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dxu8o2qHWR0EXSrarvDxqJb9MJ6dYNmxMSt9Vv3SMos=;
        b=pUeJ5qkYPuZ1fKxubY9B5vxshfB1FAwuj5uSTP9KqcB7kKUcilXdCeeOTn93EauT4S
         vENej/fMwRxaEvEzIM2YDHUhNia0LuJfeQW4g8Vkb6GrlMMAcNfGhIOLhUfCttSjFoat
         lNp4fas/sYVb9cm01QYNUT8TvymjLmUVVaQAoafRfJcqDjZcY0ykyFiAlqQKItc271gO
         6vLyfaIZcPMCa1kSB/GplvY8fSeSvymvsMt/crfkb3RfwMieFMBuy/eIYgKFsvnsp14K
         E9TE6M08ZY4RerF/1CY5E6eSM6FcvSZ4XBbytEZXJhBbVFKfWivALOcBh3xc9YhmOQmp
         kIjg==
X-Gm-Message-State: APjAAAWHyNQBss0/ndD0sx/UFpCyPONYVOvya1JwKh6oZJzfqLSnjPN8
        CDND5dS8VzJVM1bGe5pzJw0YPaJSrUJ/4PgOkle5hAKXXZ0=
X-Google-Smtp-Source: APXvYqyMpdzeQG1AaO3XFl/wzJylUYii+YevmgR4IY3IPUw/S6mLOgklIn994hAb1j5oUFdM5igx+xnwBjLEnQBsQeA=
X-Received: by 2002:a02:c989:: with SMTP id b9mr10674428jap.59.1574028859135;
 Sun, 17 Nov 2019 14:14:19 -0800 (PST)
MIME-Version: 1.0
References: <CACtp79ADncLAs560QNKCZtX937XaB6-37Xz2SYP7PyonJjRtwg@mail.gmail.com>
 <20191114172754.GB4579@mit.edu>
In-Reply-To: <20191114172754.GB4579@mit.edu>
From:   Jesse Grodman <jgrodman@gmail.com>
Date:   Mon, 18 Nov 2019 00:14:07 +0200
Message-ID: <CACtp79BMK8yEVFar4Sc3iABbatJVDppqMR4w=bRgY50dVmtppA@mail.gmail.com>
Subject: Re: Suggested change for superblock journal hint
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Sorry, and got it. I asked my employer but it can take a while to get
a response, so feel free to make the change yourself if you'd like.
I'd be curious if you think it is a good change.

Best,
Jesse


On Thu, Nov 14, 2019 at 7:27 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Thu, Nov 14, 2019 at 05:05:06PM +0200, Jesse Grodman wrote:
> > Hi,
> >
> > I encountered the scenario that a full fsck check was being run
> > unnecessarily when the major / minor number of my external journal was
> > being fixed by fsck. This PR changes that so that this change does
> > trigger the full fsck run: github.com/tytso/e2fsprogs/pull/26
>
> Hi Jessie,
>
> It's preferable that patches e2fsprogs be sent to the linux-ext4 list,
> so they can get reviewed by the full ext4 community.  That being said,
> I will accept minor patches sent via a pull request if they full meet
> the requirements for kernel patches:
>
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
>
> Note in particular the requirements for the Developer's Certification
> of Origin (aka the Signed-off-by tag).  That has specific legal
> meanings (for example, you are certifying that your employer allows
> you to contribute to open source projects, or at least, *this* open
> source project), so please take a close look at that.
>
> Cheers,
>
>                                         - Ted
