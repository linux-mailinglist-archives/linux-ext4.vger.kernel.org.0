Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF9C459AD7
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Nov 2021 04:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhKWECq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Nov 2021 23:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhKWECo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 22 Nov 2021 23:02:44 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7EFC061746
        for <linux-ext4@vger.kernel.org>; Mon, 22 Nov 2021 19:59:36 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 200so17098943pga.1
        for <linux-ext4@vger.kernel.org>; Mon, 22 Nov 2021 19:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g/ky7DkMfynxz93Jg1Thyokk1eZpzUf1Xl2rDhRoyWA=;
        b=gwTsNrCEoSododJW02pXoG5va8bW6OECitQWc09+sfRQX7sjnk65lMa71jflZhqZ1Z
         86aeuya1xffrx25hqOEdYvOiHJs5SgCPT9ynh1h37Y6R+YK22M+VCRKtE4fEa7B4vmJj
         FgIl1EAn3HVhHAskqaElmROImyfgrhseCNECcArK+N8mGcWyaNrHQ2uUa5SryedQ51xK
         EFHOUqysfj0ZP5ewN50SJI8X536nWAnVKZXIvFxFdkrKxXPVOOjm85CFAu2VFaD2Y1/c
         IkmhJjqPuO4/my+NrNDZVrBhbYZL7tBr4KB5P4Dw+Kdi1tW3eMcLXRLw1g/M1n7CsTvT
         3cxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/ky7DkMfynxz93Jg1Thyokk1eZpzUf1Xl2rDhRoyWA=;
        b=li1AsVdsxoXMwziR1cGI7G7rlGQ1byubMReyTXP8w4bIAeogArl09QaQ9qpKPwYu+G
         0koNWG3lXgqQa2SxsVHP7OysnpdUgGRt2q9Zh3mZlRmic9qNqBekD6khryBVzp3MxHf1
         dVUMK3SVOoPbg23VnArcc9bOtUXtl4/1eBxdz0fEBMs1RPeOBEg7uI9qSByJ8C1eRroS
         yScnkclZ1yLHLO6y+Bw2uxkSBFlfck+QfrQgB10PSyKHCC3bYtYynVJXf6Ca5COO3C8J
         URp9lAYd9DtTtv8vjwsXTb3tPB3FhCXehtER7MjHA29xhuig52YAqgTROk6Tk2dcThJ+
         x5zg==
X-Gm-Message-State: AOAM530Hk3nCdkAwqW+i2Hc0zoR5H0+XnpGf5rF9S/Sbw70uVlJ6pxxn
        zkgQYqsxejodpFSVI8vLBDnxUMSuqYTgaMnz75bwKA==
X-Google-Smtp-Source: ABdhPJwGHnABHnUK3lJPgD02NSEK0H2EfeyLizUEIRr93I6wp+H8p3N47d3IhUfBHGyYAjrqraEpCA3HamH0r9lHbyI=
X-Received: by 2002:a63:85c6:: with SMTP id u189mr1546658pgd.377.1637639976375;
 Mon, 22 Nov 2021 19:59:36 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-10-hch@lst.de>
In-Reply-To: <20211109083309.584081-10-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 22 Nov 2021 19:59:25 -0800
Message-ID: <CAPcyv4igxMdMA0XpjZt0aXahef5Worvz663ynd5i4=HeKJAqKw@mail.gmail.com>
Subject: Re: [PATCH 09/29] dm-linear: add a linear_dax_pgoff helper
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

On Tue, Nov 9, 2021 at 12:33 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Add a helper to perform the entire remapping for DAX accesses.  This
> helper open codes bdev_dax_pgoff given that the alignment checks have
> already been done by the submitting file system and don't need to be
> repeated.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Mike Snitzer <snitzer@redhat.com>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
