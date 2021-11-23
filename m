Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13208459A38
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Nov 2021 03:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbhKWC52 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Nov 2021 21:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbhKWC52 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 22 Nov 2021 21:57:28 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8232C061746
        for <linux-ext4@vger.kernel.org>; Mon, 22 Nov 2021 18:54:20 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id o14so15789345plg.5
        for <linux-ext4@vger.kernel.org>; Mon, 22 Nov 2021 18:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Al5JsM62A3tHtpfVSPPyo8ez+nZ96myx/BqVadpnmZE=;
        b=xC+R2Ze1hcDaIg+74cuixxadPvoKZHVUfRh3cG7NL6liGTAKRC1u/dtLV2Upl+DjCb
         lz8tF4p8hd5xqtUPL0FFIN4COIFn8gNO0kZEDg0AZkuF8D8jKwc0aEvQ7rx69yXQ0Onu
         ygsv6Lso/1XQ2tNifMHR6wKXy6FdeML5mJLZDRvnaAHvQPYqIVreOhkxmGyxQPa6SI/i
         eitCea7WNPUHw+NWqm+DDMhFpduBZks6zZt+EcfeE8ME4X0s0nFvXWdxr1dRMwydHs/r
         NeInAl4EFa9zlunOlALEVrXarilVx4ntLaJRr9tg/Qn0MoP7TxRpqBu+w38vRZVF2hEy
         GCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Al5JsM62A3tHtpfVSPPyo8ez+nZ96myx/BqVadpnmZE=;
        b=DsdnvAocPpUQCq9FBj19CKxsNxuiALOkr9aWdPKFz9nPN/9bk28AoK+xH10L5GvMpY
         etBspKxwn2M2SMR3l3KigP4s83MoBvfBMj3pdHxK0H1+vlk0Q5ozveQ+NTJ+lQti03yi
         876cYrbaIIW+3p/wiGERC9O76qfpm0LcMy2dnTxcI7WxguTswzuvC7Rat3hCI18eD22O
         RHazCwaeKrJJpzYMWH9qSL2hp2b79hCUCETQuoHSDLx+4mlr5DfJgyK6FlQJ++4zw4VH
         Vuwq9m2dqK7gDcHbvJLun5dO1U0K9fAdHUrufZd5nV0uOr8oSRPHW8P9Z1UYdLENhdzn
         MWkg==
X-Gm-Message-State: AOAM531dKj8m5lnE8jksgtHxO9SaSswlbU/CBtkzKeANS/A69T+8nvut
        u//aDvwQpxItB1cVF4kUCQLUbijg1oFUrGu6G2CINQ==
X-Google-Smtp-Source: ABdhPJzVmbqwkteuXJ4hKBjAQTD1mqO5WV/z0skpRbQzjFZ3o+tEVCfuAJYtWwfPr8oZjtyH1KqF3yLKCjaZBtlyJ4k=
X-Received: by 2002:a17:90b:1e07:: with SMTP id pg7mr2220703pjb.93.1637636060294;
 Mon, 22 Nov 2021 18:54:20 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-3-hch@lst.de>
 <CAPcyv4iPOcD8OsimpSZMnbTEsGZKj-GqSY=cWC0tPvoVs6DE1Q@mail.gmail.com> <20211119065457.GA15524@lst.de>
In-Reply-To: <20211119065457.GA15524@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 22 Nov 2021 18:54:09 -0800
Message-ID: <CAPcyv4iDujo8ZZp=8xNEhB3u6Vyc6nzq_THGiGRON7x3oi9enw@mail.gmail.com>
Subject: Re: [PATCH 02/29] dm: make the DAX support dependend on CONFIG_FS_DAX
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

On Thu, Nov 18, 2021 at 10:55 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Nov 17, 2021 at 09:23:44AM -0800, Dan Williams wrote:
> > Applied, fixed the spelling of 'dependent' in the subject and picked
> > up Mike's Ack from the previous send:
> >
> > https://lore.kernel.org/r/YYASBVuorCedsnRL@redhat.com
> >
> > Christoph, any particular reason you did not pick up the tags from the
> > last posting?
>
> I thought I did, but apparently I've missed some.

I'll reply with the ones I see missing that need carrying over and add
my own reviewed-by then you can send me a pull request when ready,
deal?
