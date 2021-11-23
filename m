Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB252459B05
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Nov 2021 05:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbhKWEUd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Nov 2021 23:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhKWEUd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 22 Nov 2021 23:20:33 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C94C061574
        for <linux-ext4@vger.kernel.org>; Mon, 22 Nov 2021 20:17:26 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id u80so6493619pfc.9
        for <linux-ext4@vger.kernel.org>; Mon, 22 Nov 2021 20:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZQsMyZujMjnowhAwZ2baLD9uO7OCrRs7T2rtVARAjVk=;
        b=r5BttbD0H9Ys+86N0W8OZt6YhGoGDH1OlqQzbeJL1DHVrD2yQYBFcAQpDJZdPp96ld
         u7ZRxawo8C15Rm8P9h/VH5gu3oohxCYJiT1x83EZ7S5DS8ZwExgaHogTmXUfy49vrooy
         uY9QBu9K0yN5b+5oZTDqMIVuo71/tE10X4peb5+q5eiDHecfanupjPCqOSworjGI5IQ5
         Aj7bWFf9mIURtRUlNDfH2tKdJ15j6ud19enU8mc5XfzSZ1qi5lkH5u7vzXmkUNvPZ8ua
         waA1d5UF/uDBNAN49ee3fRWBvihtr0fagsdWiD2SnKCZhsMGyCRgbV3y2BeBkd6hwREP
         GcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZQsMyZujMjnowhAwZ2baLD9uO7OCrRs7T2rtVARAjVk=;
        b=YVbM0QLiU7x808pD+DzdKz6Nm0pklJI1TyBZ7QqY5O8Aa1CyQ4pzoXKlSDoGihP7QG
         EkxpbJo4rs70moVb2hzqKCtB30k8TRa5/gAaTdwNPNagFQmg2FLf0hskXmVxkippLEe3
         ViiNhhV1g8mN5b0CIBXdjziVxJj6B/QhImiX+aSDz7YXibdZDuge0dbU8sjo0a/dx36m
         DhsQp1Wk6c1EUDlTp1ysvfcqr+pr7KgDBkRybG0Cy+LvfAirAQbPJYrv8W6LhznNlYjC
         suhiKh6+qbnnlhz5bM2M1tIr2xLVGl6B4GC7nNx/H7b37FRHVDKdlB/yblKTxuGzStH6
         b7pg==
X-Gm-Message-State: AOAM532Ve40atX7XsccHxayvoqxu05wJR+ocKKvzCAZElifHGO5yQF4l
        4QIU3VPA+A2Ml6XvECIBO6kOPkrCY93ruIYQKi5LiLh/AuU=
X-Google-Smtp-Source: ABdhPJyduKiEJGam42hMgnTTV6OAgsDuX6QGWziIbZi1yEyOpgOf+OAOhzM4qFm0U34fEtUNE/R0JNCPUbjj9GmSWQ0=
X-Received: by 2002:a63:85c6:: with SMTP id u189mr1612542pgd.377.1637641045591;
 Mon, 22 Nov 2021 20:17:25 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-13-hch@lst.de>
In-Reply-To: <20211109083309.584081-13-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 22 Nov 2021 20:17:14 -0800
Message-ID: <CAPcyv4g_ZeZCZwfSvoAXL_xnnM2dTSCgN8atodfr8vfJTbYOXA@mail.gmail.com>
Subject: Re: [PATCH 12/29] fsdax: remove a pointless __force cast in copy_cow_page_dax
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 9, 2021 at 12:34 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Despite its name copy_user_page expected kernel addresses, which is what
> we already have.

Yup,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
