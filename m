Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAEC3252C3
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Feb 2021 16:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhBYPwE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 25 Feb 2021 10:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhBYPwD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 25 Feb 2021 10:52:03 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BC8C06174A
        for <linux-ext4@vger.kernel.org>; Thu, 25 Feb 2021 07:51:21 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a22so9650554ejv.9
        for <linux-ext4@vger.kernel.org>; Thu, 25 Feb 2021 07:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fb7gxRr2wVatpvn5aFDNDRiaxp2zR7KmrBYbUmV1cqE=;
        b=jOYCxez3lLDcIR0qFmP+dikhSvZg85a38b3WQ3oAO0A/nfRPn17Bed9jUmssxYlb9z
         l0qwsRg76ZHPoU/xeJmx8JsZa8RSfZsQo7MZN46jma0FTNUfF2y9WcVnIpHqk0JJWkhf
         2uWHLp9d57SAOGPjmc95d53UCWIxUkK3hU+R6Ab/zIrFNCLRMkbN8zxFWr85lS46Tokd
         LSR2EtbOlSVqLOHIEjIHpooq55tOfXSRgKWpC57w9RW8JFnChOIvGFNDlQhEwYfUtND4
         tBDjS6xyQT3RdBUt9R3E9dXOJZiSna9hOXcCQVbWMMWBSy1ilaVlROdxbpeBoERFWnKi
         F/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fb7gxRr2wVatpvn5aFDNDRiaxp2zR7KmrBYbUmV1cqE=;
        b=h2rDaWlOXd+GhegAEhHVFvmL30F1eNHWw+8PgxIrw3tmj3O+trUAJk+CyQ/9DOVdRh
         RsESHt7lo6hIlntiZXDDUh7Ai4OHnHTQs5Nf8dj3Lzxh95QOiQw1zo4L/AGpYFIDGjpu
         8j37elmxgy4YWtCOFH1HeLL7BTMbVJMJSFhL3A+MnYGZSgcv7c57o19Qtpg6VHsPbeNU
         1d1j0k1/LUNNr+WM/RlLG7ZXy+U9D3QaCqTVRUhyK3L+YAlwLzqYIDA1qogO5+yze/9J
         YAy2UUohQrmPLqu+YA3Y2RGAdHi2mm0kbZpE+VEBVIiHgnOtyRXAj2Q1ZZNrn3WhnzAo
         36SA==
X-Gm-Message-State: AOAM531cSNJwWWPoFSjq3CTUYPwzSEwTovTvsbQFCn56qeMfGpWsp7V9
        lGdzRRPh7ERu3zndwXB1E+cj967D8YAxpx9viYKUVR6D30g=
X-Google-Smtp-Source: ABdhPJz+x+D2EQLECeBQFevjVgMlIg33adcYTTRKZaHaUF0WVbD3vGo7TrmQH+3Q7ptfvkeW0A3G7Ys92y+UCJMcnbY=
X-Received: by 2002:a17:906:a099:: with SMTP id q25mr3177374ejy.549.1614268280408;
 Thu, 25 Feb 2021 07:51:20 -0800 (PST)
MIME-Version: 1.0
References: <c6fb0951-a472-dbb4-1970-fe9cece5d182@huawei.com>
In-Reply-To: <c6fb0951-a472-dbb4-1970-fe9cece5d182@huawei.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Thu, 25 Feb 2021 07:51:09 -0800
Message-ID: <CAD+ocbwkQ4rMYhiOm4msnBH65vh6Pm25ZkPsC2pD0sFy68bPgA@mail.gmail.com>
Subject: Re: [PATCH] debugfs: fix memory leak problem in read_list()
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        linfeilong <linfeilong@huawei.com>,
        lihaotian <lihaotian9@huawei.com>,
        "lijinlin (A)" <lijinlin3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Feb 20, 2021 at 12:41 AM Zhiqiang Liu <liuzhiqiang26@huawei.com> wrote:
>
>
> In read_list func, if strtoull() fails in while loop,
> we will return the error code directly. Then, memory of
> variable lst will be leaked without setting to *list.
>
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> Signed-off-by: linfeilong <linfeilong@huawei.com>
> ---
>  debugfs/util.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/debugfs/util.c b/debugfs/util.c
> index be6b550e..9e880548 100644
> --- a/debugfs/util.c
> +++ b/debugfs/util.c
> @@ -530,12 +530,16 @@ errcode_t read_list(char *str, blk64_t **list, size_t *len)
>
>                 errno = 0;
>                 y = x = strtoull(tok, &e, 0);
> -               if (errno)
> -                       return errno;
> +               if (errno) {
> +                       retval = errno;
> +                       break;
> +               }
Shouldn't we have `goto err;` here instead of break? strtoull failure
here indicates that no valid value was found, so instead of returning
the allocated memory, we should just free the memory and return error.

- Harshad
>                 if (*e == '-') {
>                         y = strtoull(e + 1, NULL, 0);
> -                       if (errno)
> -                               return errno;
> +                       if (errno) {
> +                               retval = errno;
> +                               break;
> +                       }
>                 } else if (*e != 0) {
>                         retval = EINVAL;
>                         break;
> --
> 2.19.1
>
>
