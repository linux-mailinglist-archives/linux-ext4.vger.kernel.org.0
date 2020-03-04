Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E466C178F77
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Mar 2020 12:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387774AbgCDLTg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Mar 2020 06:19:36 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:49729 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387398AbgCDLTg (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 4 Mar 2020 06:19:36 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 1e6388fa
        for <linux-ext4@vger.kernel.org>;
        Wed, 4 Mar 2020 11:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=543ZUe3zNqoDf0fPqwGkRrAU66k=; b=WXd4PK
        oA7nYlSqRdOT59VAzxKhL091jDCzLlyk/7vs8Jh+FHDjR8J/4aBB43i+QMaBANpC
        g4th2ZA2FeYdAHEaq8+jyrhtia2NGQsAynOG5I/6gGZB9VjvhLK+KOtJOcleMeoY
        hFCqh51Kmc13j8d62fG5yOxW1jjjH6AVhD9uLNOU1tM5Vd92Q+HEF4G6FD97M/g2
        eIoWGYzZhNioguHur+H/HtopA/UyUGn9/wLgA9ZfKCt4HQuu/unjsrSosJOZO6nY
        Z2+Fl3ht5pos3eJ5cvjenB6n+5NDg5wHiCvB8vK38lJxpiULUo+0hQQoUHegSoA0
        8vHM5Ms3gvvK0trQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c94b14ec (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-ext4@vger.kernel.org>;
        Wed, 4 Mar 2020 11:15:01 +0000 (UTC)
Received: by mail-il1-f180.google.com with SMTP id o18so1460667ilg.10
        for <linux-ext4@vger.kernel.org>; Wed, 04 Mar 2020 03:19:34 -0800 (PST)
X-Gm-Message-State: ANhLgQ2PGp4dNYPAcyqHOG3GzqlZZt1TY6TSmz++ezOcOGENbzAGHVca
        eTuHBf8oHtgLP7yVAEcuPwiqBqwIW0U8H1+i08M=
X-Google-Smtp-Source: ADFU+vsro5efBHb+brZoqyBYVH5tBP/vkJGryDQMGq+W1HS9ChXW3WfQZLwt9LDI13wRUFEy/IgGiG1kp1x9BCjLkxQ=
X-Received: by 2002:a92:9913:: with SMTP id p19mr2338603ili.38.1583320773458;
 Wed, 04 Mar 2020 03:19:33 -0800 (PST)
MIME-Version: 1.0
References: <20200302020339.GA5532@zx2c4.com> <20200303220246.GA20545@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20200303220246.GA20545@redsun51.ssa.fujisawa.hgst.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 4 Mar 2020 19:19:22 +0800
X-Gmail-Original-Message-ID: <CAHmME9pfUFSRVX7Tamg0E5pTxk4Xx322nMoG6j1tTkoxtgaY+A@mail.gmail.com>
Message-ID: <CAHmME9pfUFSRVX7Tamg0E5pTxk4Xx322nMoG6j1tTkoxtgaY+A@mail.gmail.com>
Subject: Re: "I/O 8 QID 0 timeout, reset controller" on 5.6-rc2
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 4, 2020 at 6:02 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Mon, Mar 02, 2020 at 10:03:39AM +0800, Jason A. Donenfeld wrote:
> > Hi,
> >
> > My torrent client was doing some I/O when the below happened. I'm
> > wondering if this is a known thing that's been fixed during the rc
> > cycle, a regression, or if my (pretty new) NVMe drive is failing.
> >
> > Thanks,
> > Jason
> >
> > Feb 24 20:36:58 thinkpad kernel: nvme nvme1: I/O 852 QID 15 timeout, aborting
> > Feb 24 20:37:29 thinkpad kernel: nvme nvme1: I/O 852 QID 15 timeout, reset controller
> > Feb 24 20:37:59 thinkpad kernel: nvme nvme1: I/O 8 QID 0 timeout, reset controller
> > Feb 24 20:39:00 thinkpad kernel: nvme nvme1: Device not ready; aborting reset
> > Feb 24 20:39:00 thinkpad kernel: nvme nvme1: Abort status: 0x371
>
> Sorry to say, this indicates the controller has become unresponsive.
> You usually see "timeout" messages in batches, though, so I wonder if
> only the one IO command timed out or if the controller just doesn't
> support an abort command limit.
>
> You can try throttling the queue depth and see if the problem goes away.
> The lowest possible depth can be set with kernel param
> "nvme.io_queue_depth=2".

I was unfortunately never able to reproduce. This happened while
downloading a torrent, and torrent clients have a history of creating
"interesting" I/O patterns. Hardware is "Samsung SSD 970 EVO Plus
2TB".
