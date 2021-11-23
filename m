Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE65545AEB3
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Nov 2021 22:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237892AbhKWVxM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 Nov 2021 16:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbhKWVxL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 23 Nov 2021 16:53:11 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AD3C061746
        for <linux-ext4@vger.kernel.org>; Tue, 23 Nov 2021 13:50:03 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id s137so283323pgs.5
        for <linux-ext4@vger.kernel.org>; Tue, 23 Nov 2021 13:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TYkPf9vJ648gXjsCEnGEexU4+Ifkiqg1wwbcGn6CCJ4=;
        b=Zg2lBRkAMXF8A+wvUtTCMUUrMwJSgDxXgPFdIJ6mN7vtPUcxzmlaWcpTf9u8Q3z98h
         X/Q6JeK0cyueZaLleVAsw/AXaT4zKEIJmobxui02H2iRJwR6JQ6k+7ohKUH/xkhZtcrk
         AUpJh1ywhRU6oaywvvX2nXCy9HlVnkwENOYB/cohnRCUpdHTb0Po2TpaAZ5v/3eSZpRI
         8V3uh9/QGNOkIwreJn4bL+pCGYZydEDpnqKywmkmy4aH4tbxUO5DJdIr7F4HLJ2A0sqA
         ygzmFWm5Okq9v0BfBD825f1vPnJFQ6RvtJm08BV2t1iAQ4uh6Zl3udb+YoU4MJmQj7Nw
         WjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TYkPf9vJ648gXjsCEnGEexU4+Ifkiqg1wwbcGn6CCJ4=;
        b=z1jSGzxGWd3ygpx3fM8CobUF3nz9MvdOkyh985jVuN1cw5xdQ5Jwh4q0RGKfZvZYzF
         vXiztt/Y6MB4WH4SQcX8CoEZXJWDoVoXtIsQpFu3C1gas0D6XcmHMjC3ScoLbTBIQ8B+
         KiQwsJm2yGlRQNvh2dIJQEoriwYYT9r7YHAlu7sfg09v4MmZU3NG7aW9BHKFrZjUC9w2
         Y3/iaOhCYYu0z87vQlPpeCA+V1134EjlsBY3am/snWeBgu4UuxoUcZPyJHEO3T8MhAmT
         HZ7rKDUOJZqhoLzeu6H/M5+4phE7jO43SNbWeL3t2NWV6JCqNBx0hyqVyoNvCS3UlXnx
         mo/w==
X-Gm-Message-State: AOAM533TYAyqXtkhflXdrspTfX1sLGnCf0ak37OfQEKrrk0bSekk6kne
        V5jswUhKnzBuMe5jisMp3h6qqHPJMb1cq//wug+91A==
X-Google-Smtp-Source: ABdhPJyGFtcTnW/NcVjiSH5pncdxregmswvMZp0GGEC99SZ7f8Vh58bATLOZJ9aYCBUx/N4xWCbII0nzMB7q2Ks2bo4=
X-Received: by 2002:a63:5401:: with SMTP id i1mr6259530pgb.356.1637704203058;
 Tue, 23 Nov 2021 13:50:03 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-21-hch@lst.de>
In-Reply-To: <20211109083309.584081-21-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Nov 2021 13:49:52 -0800
Message-ID: <CAPcyv4htTDV10OkdXfWJzES2dUdm+7PDsX6LPYSxEYFnNVeMwA@mail.gmail.com>
Subject: Re: [PATCH 20/29] ext4: cleanup the dax handling in ext4_fill_super
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
> Only call fs_dax_get_by_bdev once the sbi has been allocated and remove
> the need for the dax_dev local variable.

Looks good.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
