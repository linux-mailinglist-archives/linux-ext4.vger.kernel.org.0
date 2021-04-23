Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850B13696D9
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Apr 2021 18:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhDWQZ5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Apr 2021 12:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWQZ5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Apr 2021 12:25:57 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACE4C061574
        for <linux-ext4@vger.kernel.org>; Fri, 23 Apr 2021 09:25:20 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id c17so34414829pfn.6
        for <linux-ext4@vger.kernel.org>; Fri, 23 Apr 2021 09:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=l5shYdOOg+HaRXRxiJmJ8WpE/eLFvCF+x7VDepDHWoU=;
        b=1HHSFuHB8bbZiR7vyn9Yu/do2J+dKcymuAO7HG9adSnkwZCjnXLmDq0w4dTt0NVlMp
         Z4qG3INNBzWQqFtqwJmw0OHcMejJADYZ8rov7pFiz3rjaYIhJX/V2bINPm2t3axkiBju
         IgldRK3T/PScdkGCeTjNn1TFs56qWfKD63grRB/DVFMMl5pDPymS3Dg6wMzcxFEqt/7s
         5A7Wq88dkZ6T1L0CyXTHaWtDIs1sncGqt9oYUD6BX0fK+M+IwwnJNhEOWfJ75BhhqGiZ
         xTHulZAmaDbc8KHLfmRXc8eChTAb964wrqzsBW98Xd4HahFrY4qw/MBxIOq+I/+XPB8e
         gW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=l5shYdOOg+HaRXRxiJmJ8WpE/eLFvCF+x7VDepDHWoU=;
        b=MjJbsMbOHB1uDDudcVwDNAh6BdD9bATsh7wUKxUQLW2fFC95sE3pwmbCWaYVpfwjVE
         cHBPsVDXNK4GCPwOZTaMRi8gMpdard4S/BZq+qIs0lMQ5bKver04xzALGaLvRoBt05P/
         H/0jFhLzoKf32/iKZDon8A5E9F86sjnwYETFpsIQlA+vzE8u6E/nqyxbbIyWjrjuAnKc
         BSrrgJlBku9kGJ8yuGMTPn3SDdSI142v0gHRc9pHm9ATLHiZEaOP7gJJBbr/fpMVgj6A
         IEgGuLcvsAyQNHPjAApAq2lW0AGLwBvneL8Yzlt5BUyHZdPmY8GxOAVDzWlXKqS1l+6Q
         VE3A==
X-Gm-Message-State: AOAM532sBUzIM5f7HiPO0PyhH7VgkPLgZeQMu3XW+SILRGvfmc3LcTtA
        Vtgf0UwGTtQqloPOnhe2dPgqIg==
X-Google-Smtp-Source: ABdhPJyGJN5Kx7yMdcbZzqN+kPk0VwqEm6BS4CiPDWBbKjBi3XaNSteK4YY1gyd2AhavvK89HuMUDA==
X-Received: by 2002:aa7:9497:0:b029:262:abda:5a9b with SMTP id z23-20020aa794970000b0290262abda5a9bmr4628026pfk.46.1619195119839;
        Fri, 23 Apr 2021 09:25:19 -0700 (PDT)
Received: from [192.168.10.175] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id a65sm5156815pfb.116.2021.04.23.09.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 09:25:19 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v5] e2image: add option to ignore fs errors
Date:   Fri, 23 Apr 2021 10:25:18 -0600
Message-Id: <4972D70F-1765-413B-971B-CE4147993B29@dilger.ca>
References: <20210422041347.29039-1-artem.blagodarenko@gmail.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        Alexey Lyashkov <alexey.lyashkov@hpe.com>,
        Artem Blagodarenko <artem.blagodarenko@hpe.com>
In-Reply-To: <20210422041347.29039-1-artem.blagodarenko@gmail.com>
To:     Artem Blagodarenko <artem.blagodarenko@gmail.com>
X-Mailer: iPhone Mail (18D70)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Apr 23, 2021, at 07:30, Artem Blagodarenko <artem.blagodarenko@gmail.com>=
 wrote:
>=20
> =EF=BB=BFAdd extended "-E ignore_error" option to be more tolerant
> to fs errors while scanning inode extents.

Not to be pedantic, but should this allow "ignore_errors", since it will
presumably ignore more than one error.  If already using "ignore_error"
in the field you could accept both for some time until able to change over,
as we've done with "ea_inode" vs. "large_xattr" in the Lustre e2fsprogs
for years.=20

> Changes since preveious version:
> - rebased on top of the master

This should go after the "---" so that it isn't in the final commit message.=
=20

> Signed-off-by: Alexey Lyashkov <alexey.lyashkov@hpe.com>
> Signed-off-by: Artem Blagodarenko <artem.blagodarenko@hpe.com>
> Cray-bug-id: LUS-1922
> Change-Id: Ib79300656726839b1d3b7ee1dd0793c60679d296
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> ---

One typo in the man page below:

> diff --git a/misc/e2image.8.in b/misc/e2image.8.in
> index cb176f5d..45a06d3b 100644
> --- a/misc/e2image.8.in
> +++ b/misc/e2image.8.in
> @@ -137,6 +144,16 @@ useful if the file system is being cloned to a flash-=
based storage device
> (where reads are very fast and where it is desirable to avoid unnecessary
> writes to reduce write wear on the device).
> .TP
> +.BI \-E " extended_options"
> +Set e2iamge extended options.

"e2image"

Ted could fix this in the final commit
Cheers, Andreas

>  Extended options are comma separated, and
> +may take an argument using the equals ('=3D') sign.  The following option=
s
> +are supported:
> +.RS 1.2i
> +.TP
> +.BI ignore_error
> +Grab an image from a corrupted FS and ignore fs errors.
> +.RE
> +.TP
> .B \-f
> Override the read-only requirement for the source filesystem when saving
> the image file using the
