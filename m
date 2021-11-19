Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A404569C5
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Nov 2021 06:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbhKSFlz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Nov 2021 00:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhKSFly (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 19 Nov 2021 00:41:54 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1750C061574
        for <linux-ext4@vger.kernel.org>; Thu, 18 Nov 2021 21:38:53 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id e8so9142432ilu.9
        for <linux-ext4@vger.kernel.org>; Thu, 18 Nov 2021 21:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f2aHJUlff+sHT0KB89Ar0wCxeN5RNH8wkzpd87A4xsk=;
        b=oAlT9paDS24Qy4Yiyrpr8LzhBDDyY6nuFPfoE5WZFi0CNco6Z0RyOAi/YjJZH6eLIv
         3Ztra06Kmrw2Sxn0fXMfJ7gJIFeTN3Ftacz2Uk0/yiQayzlqpvalFSQwDcIgLP5t1kay
         3syKNEWkQ+dkRBSPNJqHKYProaLHYWN0YbCNld2+Oc3QLDPL9IiB+vZHVt/71sz1Zaup
         nhJZxWzbLqliECWS8PLsBTIL2hf63nt21oS6vN74Cm2DV8DV6B2jbo1SRgOj5mCwmKl4
         aQa96+CMiBrp9ev6tWAoxD2XT6oKoegT14sB5S4GQKI9QamhdCPmu9GmeJw7u9pqJofQ
         6WzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f2aHJUlff+sHT0KB89Ar0wCxeN5RNH8wkzpd87A4xsk=;
        b=32tZOIU3lYsuny7ULjFKPDwccMqoBy/hF6RYHFRn8IuNigvxebgBHHoZ6KriypdcJg
         ElxNnEoEe1wpn/TxKPSkEs5vTkSNTpWVWkKwaZf3eZrXVgHz8FRdqS27G0j1QvgGfiPX
         uPHruFLO20iQuwbWO/d3a6L/vzLjcIaBu6itv7gIwwa1w8UsKCXvuOLfE27QQrYDPeOn
         1ljfeFl2vO76zPVOsurP1BxRYCJsHgfvADjc7X0a9r4xjQc/Ogc1HrMj4VTHiuj4IN0m
         BETQn6oydvmJ+1l7+UotF01PgF1iF4CiRF2TYg4B32DKp2M3XPcPBHqcS5+7G6uhXMsE
         9KJQ==
X-Gm-Message-State: AOAM5333TR8ltQRDBmrxYjsLTPN0AGVu65f9HJuDd7gNQWRGMI2EvrDC
        41weT4o3hoR+hg8SrC6loEcwUtpef0G1nQENgvU=
X-Google-Smtp-Source: ABdhPJyge6d8ROjZzxsBZyUPkRoblSllQwMAlbWsZDPUJx4cTNGX4/IFYezj1zcs6kCpZ2H+j9hO+ryU6FblamVSbKo=
X-Received: by 2002:a05:6e02:c87:: with SMTP id b7mr3301518ile.198.1637300333243;
 Thu, 18 Nov 2021 21:38:53 -0800 (PST)
MIME-Version: 1.0
References: <20211118235744.802584-1-krisman@collabora.com> <20211118235744.802584-5-krisman@collabora.com>
In-Reply-To: <20211118235744.802584-5-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 19 Nov 2021 07:38:42 +0200
Message-ID: <CAOQ4uxjk8J48ASw2yJhd-OR2LVN6kirg7p6xQbX=xEofGYUghw@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] syscalls/fanotify22: Validate the generic error info
To:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Petr Vorel <pvorel@suse.cz>,
        Matthew Bobrowski <repnop@google.com>
Cc:     Jan Kara <jack@suse.com>, Ext4 <linux-ext4@vger.kernel.org>,
        kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
        LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Nov 19, 2021 at 1:58 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Implement some validation for the generic error info record emitted by
> the kernel.  The error number is fs-specific but, well, we only support
> ext4 for now anyway.
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> ---
> Changes since v2:
>   - check for error record type in autotools (Amir)
> Changes since v1:
>   - Move defines to header file.
> ---
>  configure.ac                                  |  3 +-
>  testcases/kernel/syscalls/fanotify/fanotify.h | 32 ++++++++++++++++
>  .../kernel/syscalls/fanotify/fanotify22.c     | 37 ++++++++++++++++++-
>  3 files changed, 70 insertions(+), 2 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index 859aa9857021..a9dc2524966d 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -160,7 +160,8 @@ AC_CHECK_MEMBERS([struct utsname.domainname],,,[
>  AC_CHECK_TYPES([enum kcmp_type],,,[#include <linux/kcmp.h>])
>  AC_CHECK_TYPES([struct acct_v3],,,[#include <sys/acct.h>])
>  AC_CHECK_TYPES([struct af_alg_iv, struct sockaddr_alg],,,[# include <linux/if_alg.h>])
> -AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_header],,,[#include <sys/fanotify.h>])
> +AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_header,
> +               struct fanotify_event_info_error],[],[],[#include <sys/fanotify.h>])

Doh! it seems like fanotify_event_info_pidfd was dropped between v2 ->
v3 in Matthew's patches.

Petr,

Can you please fix this.

Thanks,
Amir.
