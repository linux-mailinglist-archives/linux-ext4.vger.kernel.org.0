Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860313F52CD
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Aug 2021 23:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbhHWVXs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Aug 2021 17:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbhHWVXs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Aug 2021 17:23:48 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9ED1C061575
        for <linux-ext4@vger.kernel.org>; Mon, 23 Aug 2021 14:23:04 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id j10-20020a17090a94ca00b00181f17b7ef7so374793pjw.2
        for <linux-ext4@vger.kernel.org>; Mon, 23 Aug 2021 14:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ShErwyspG88Bo4yVlFpB0fmc1BjfRh8zuGfu0CGRDeA=;
        b=rHIKZbBUCGl81JJDCGO2jSGr728UIVVQ13KxyIxc5kP6Wg5oWA9rRVWif9iIao5pL4
         L8JX62XyKt1eePLQ2AwBJuJrwPwVawP5zim6ZdRWmHiKv2kKR3fko7lTmbKjyT/aQtzo
         MEdxWwqwa1yVZo9MHkLO9AqBKKOAaM2gOsmwCUlHxgSNIJ8uSbFInX867fUxouhXCXBK
         gKKCWO53t3zw6Z8NYQly+wmZgIqWldfA/074D115o3Qsil+IMBtncqlvsQq8DAEwET7c
         V12Srx4AvkF0ONhtcsEFOppkKM7yNRBoaPdKFKb4agsQdX7D6hUMAsWrwA5FtIt/Kyou
         eNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ShErwyspG88Bo4yVlFpB0fmc1BjfRh8zuGfu0CGRDeA=;
        b=D6pSKbmVuDXyvJpw9TXDVsf2UYX9g/5aiFOvjPw5F2Z0JIhx4ABW0Vk6TLli22OtCv
         QbWO8JLKXHlnMyImHH8nElD120uckeM/HiDY3cc7u4yirJMxuzDgKUD7AhVQjthCNH90
         ty+tlbSfF1WWD3MKGCVEiBGcLjiK3c5I3WtY3Z8NKFYMadzviDoh63xIxYxMVpWLi6S6
         oPthJYMxndxozCVNb3bWW2Z/ZLVb7Kczr5WIN2XhGQXwNFxFCNv+6q516VuoiecLV1HJ
         h4ZYRKSvVVqtTlSwAR60Od+iWwRAFLygLbR94OSAdbrKCEujjh+CiaOw9o5+xznXvqUY
         USZg==
X-Gm-Message-State: AOAM532sxC8KQN9Q/0lL4NZ9ImMu+QT1J+1JWxBjy7hPJq0DkVSHcYx0
        YWUj2kEVzLpqNHPPz0jDYnU5aLQMlr9PAl8joVlDJg==
X-Google-Smtp-Source: ABdhPJx42nu034KgnU+n5z3pwJcpAAmVm/tyH+LAY8tSKD1qwe5mGvbj3AXhqEGCH92DHgFtK8TvIT3ZBlghdPmQxgY=
X-Received: by 2002:a17:902:edd0:b0:135:b351:bd5a with SMTP id
 q16-20020a170902edd000b00135b351bd5amr2141894plk.52.1629753782818; Mon, 23
 Aug 2021 14:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210823123516.969486-1-hch@lst.de> <20210823123516.969486-10-hch@lst.de>
In-Reply-To: <20210823123516.969486-10-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 23 Aug 2021 14:22:52 -0700
Message-ID: <CAPcyv4hNL+ohvTP7VK9zrPDhyVTbUZSD74=z2H2uveudaqi+=w@mail.gmail.com>
Subject: Re: [PATCH 9/9] dax: remove bdev_dax_supported
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 23, 2021 at 5:45 AM Christoph Hellwig <hch@lst.de> wrote:
>
> All callers already have a dax_device obtained from fs_dax_get_by_bdev
> at hand, so just pass that to dax_supported() insted of doing another
> lookup.

Looks good, series passes regression tests:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

I can take this with an XFS ack, or if Darrick wants to carry it to
make Ruan's life easier that's ok with me.
