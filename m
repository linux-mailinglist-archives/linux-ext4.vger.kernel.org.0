Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1DA07FDAE
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2019 17:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfHBPiN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Aug 2019 11:38:13 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42635 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfHBPiN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Aug 2019 11:38:13 -0400
Received: by mail-oi1-f194.google.com with SMTP id s184so57131461oie.9
        for <linux-ext4@vger.kernel.org>; Fri, 02 Aug 2019 08:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EVf4d+zjieuEltRbSnaKGzVcm/kyMm9OnjJml/2IymM=;
        b=eLYs/QcuZEU+UI0xWeXaY5a2bihXM3uFbRofCSd+gD9uyD6EaBIQDP2oWoWx30C8Ib
         6/gkI94/qLU+1IPkrXr+VrbF8GmoJEEuNGbzqq2ooIhlElebEJ3TnrCttFMF3Bos1oQt
         ScFZFVgZ8YredTCMJHFrianDVDLQmdcsMCm+gXTY2XnixQaoLuMu4HDuI7vrNkfNGPSk
         IBaB3/4R2Lxo3qV3rObgZleljpnKVFH6TTMFo4iEyNuU0e9jJyIAdl+0EuGvdwJXFj2S
         gQfS7F5pyS/sSn8glaSW2ztoae7D+rkVTNkFsr6eYSJ3ddrpaaJKdlDUXVcA6eghNpam
         GdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EVf4d+zjieuEltRbSnaKGzVcm/kyMm9OnjJml/2IymM=;
        b=hacAy4KjzMw6xliZCTOO/S9EWD/ghAEQm82XCaKWDYER8OVw0orUF3KxCTIedAcbTx
         0LovJFT8c3kE/qMtgBUbZ7V9fwqa0V/okWMuvZ0+myK2tXZGvit0buDJrvnEQiF0hKKH
         NBv+BaHnX0KstY3ya0BPyFlda38Ra5eT6j7zGPN1gqbekO53JTlIC2dlHgxSC11AtW7j
         EPm0TZHePatF3PdW54aFOzevf8M20HXp5WsLYk8vkIovGdnyAk7TJGiIm+zzI2Nb7f3e
         htjFlCqzO0WRer//hFqpGb/2eoM9/HbWSOEzqrlR92pWoI829HplIrsR4OoVzBWMkfTX
         3lMA==
X-Gm-Message-State: APjAAAWk/qfMYXxzptHJmq2LZ5KlKDcEqWN6lQjUoED8A0yE57ATVc9E
        sK7BELy63YGGCW1oaoEdr114R7DhJppIn73w33bzDA==
X-Google-Smtp-Source: APXvYqz+BIMVb8BzpIqFh01shlXaD8Knvf68YtJYTvRm4VvO+44ji4Fbgw804uDOmxU0s/wsqxd0LaqSjoOPEVHRobE=
X-Received: by 2002:aca:1304:: with SMTP id e4mr3105027oii.149.1564760292506;
 Fri, 02 Aug 2019 08:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4g1g2i-9p1ZDqy596O-cbw3Gas2wdiv49EvM+b0i-1uLg@mail.gmail.com>
 <20190802144304.GP25064@quack2.suse.cz>
In-Reply-To: <20190802144304.GP25064@quack2.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 2 Aug 2019 08:38:01 -0700
Message-ID: <CAPcyv4g_q_mzesgXexsSxhE_Shwf-v-uvQOwnCLxw9oBrsdzwA@mail.gmail.com>
Subject: Re: dax writes on ext4 slower than direct-i/o?
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>,
        "Berrocal, Eduardo" <eduardo.berrocal@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 2, 2019 at 7:43 AM Jan Kara <jack@suse.cz> wrote:
>
> Hi Dan!
>
> On Tue 30-07-19 16:49:41, Dan Williams wrote:
> > Eduardo raised a puzzling question about why dax yields lower iops
> > than direct-i/o. The expectation is the reverse, i.e. that direct-i/o
> > should be slightly slower than dax due to block layer overhead. This
> > holds true for xfs, but on ext4 dax yields half the iops of direct-i/o
> > for an fio 4K random write workload.
> >
> > Here is a relative graph of ext4: dax + direct-i/o vs xfs: dax + direct-i/o
> >
> > https://user-images.githubusercontent.com/56363/62172754-40c01e00-b2e8-11e9-8e4e-29e09940a171.jpg
> >
> > A relative perf profile seems to show more time in
> > ext4_journal_start() which I thought may be due to atime or mtime
> > updates, but those do not seem to be the source of the extra journal
> > I/O.
> >
> > The urgency is a curiosity at this point, but I expect an end user
> > might soon ask whether this is an expected implementation side-effect
> > of dax.
> >
> > Thanks in advance for any insight, and/or experiment ideas for us to go try.
>
> Yeah, I think the reason is that ext4_iomap_begin() currently starts a
> transaction unconditionally for each write whereas ext4_direct_IO_write()
> is more clever and starts a transaction only when needing to allocate any
> blocks. We could put similar smarts into ext4_iomap_begin() and it's
> probably a good idea, just at this moment I'm working with one guy on
> moving ext4 direct IO code to iomap infrastructure which overhauls
> ext4_iomap_begin() anyway, so let's do this after that work.

Sounds good, thanks for the insight!
