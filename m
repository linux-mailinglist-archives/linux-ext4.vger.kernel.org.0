Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2F31C8071
	for <lists+linux-ext4@lfdr.de>; Thu,  7 May 2020 05:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgEGDUu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 May 2020 23:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726470AbgEGDUu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 May 2020 23:20:50 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3B5C0610D5
        for <linux-ext4@vger.kernel.org>; Wed,  6 May 2020 20:20:49 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id h4so4701600wmb.4
        for <linux-ext4@vger.kernel.org>; Wed, 06 May 2020 20:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pDjmi4nDijjLhAo3pAeGchPyMMB2jhrTWFoR5lY155Q=;
        b=BmuVDhBX37IfMkagW6Mr7BRshXN5szVExBMJvr0sd6SgAWNlVN8ep350rhWuVUdqxF
         6KMuA33HRh+Xv5D3eo3eNBbCuZidgijDiZI1MiVJ/kFftxDyoBh0+ocmtWldFNY5a7br
         ltmhc1SNqt1egXBTFhenT4oQZCj0HtacdC9FqFfJPU5EdYGt4gMe1ttM/p25/ml5XuU2
         FeJq4ijnny9A9G3mnuO9XHZfxNoaSAKFySBPG+W+8LO/C28S+BvQIfDUW/1FRsCyxTXE
         iDT18wSeR0daXs/5ow9Zmai7If4Z05ohaJhuobVMhj95CHthc5Ily9sP1akGH9tlEbXx
         pJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pDjmi4nDijjLhAo3pAeGchPyMMB2jhrTWFoR5lY155Q=;
        b=aBL1XdIXuLlg1XAEbH3ReD6qU5E9xsmviDtvVMiU28ty0/wZjgDp29JdysqUxASTUN
         75NMQFXJCOEcYw8tmbXFUWV0S+z/qLp3gYohh2PTAuNuJkx/fPFw1l1I+omtSVhB3/wr
         FcWrKeDaYeQQNjWRiAkX7n6gdMcpYVTaY6fpTRhlLTlXyh+849jpqnu1xB97Iq/EOcA1
         Lsz0P3fdZYcVmFp8Y7O/YHMYPoOuERFUdFnnsoMr2Znj9IB4SUOEJPhQQSqKN89rDZhu
         efcvoZO1VpvyuUti9Qe/lAMSUGt8cqioP4T9WPln56w7DHZZSXs6A/WYV7jhi5J4x2p1
         X9nw==
X-Gm-Message-State: AGi0PuYKPdNdv/9jt9wDK9/vqQjS8Ogx38/Vhun9+pm+iWn/TXw99qQm
        FUK6aAHcJQ5VCLj8aC8cuX1gLWyPsuBb21tN76cXEA==
X-Google-Smtp-Source: APiQypIM1h5NUYYyuda9BBAdMggq86SAn/7iO72jWVoi8e4r6SmTF8rKOn9WxDNPoCQ7ZgoRCjgyytyOXdpxI5CAESw=
X-Received: by 2002:a1c:1fcf:: with SMTP id f198mr7844299wmf.16.1588821648002;
 Wed, 06 May 2020 20:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200505102719.8071-1-anders.roxell@linaro.org>
In-Reply-To: <20200505102719.8071-1-anders.roxell@linaro.org>
From:   David Gow <davidgow@google.com>
Date:   Thu, 7 May 2020 11:20:36 +0800
Message-ID: <CABVgOS=dPEM4HavGy6s=Y0AhVw0qekfmTR8V549zRR+cB9rA0A@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] drivers: base: default KUNIT_* fragments to KUNIT_RUN_ALL
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com, "Theodore Ts'o" <tytso@mit.edu>,
        adilger.kernel@dilger.ca,
        Andrew Morton <akpm@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        =linux-kselftest@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, linux-security-module@vger.kernel.org,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 5, 2020 at 6:27 PM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> This makes it easier to enable all KUnit fragments.
>
> Adding 'if !KUNIT_RUN_ALL' so individual test can be turned of if
> someone wants that even though KUNIT_RUN_ALL is enabled.

As with patch 2, minor typos here.

> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Reviewed-by: David Gow <davidgow@google.com>

> ---
>  drivers/base/Kconfig      | 3 ++-
>  drivers/base/test/Kconfig | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 5f0bc74d2409..c48e6e4ef367 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -149,8 +149,9 @@ config DEBUG_TEST_DRIVER_REMOVE
>           test this functionality.
>
>  config PM_QOS_KUNIT_TEST
> -       bool "KUnit Test for PM QoS features"
> +       bool "KUnit Test for PM QoS features" if !KUNIT_RUN_ALL
>         depends on KUNIT=y
> +       default KUNIT_RUN_ALL
>
>  config HMEM_REPORTING
>         bool
> diff --git a/drivers/base/test/Kconfig b/drivers/base/test/Kconfig
> index 305c7751184a..0d662d689f6b 100644
> --- a/drivers/base/test/Kconfig
> +++ b/drivers/base/test/Kconfig
> @@ -9,5 +9,6 @@ config TEST_ASYNC_DRIVER_PROBE
>
>           If unsure say N.
>  config KUNIT_DRIVER_PE_TEST
> -       bool "KUnit Tests for property entry API"
> +       bool "KUnit Tests for property entry API" if !KUNIT_RUN_ALL
>         depends on KUNIT=y
> +       default KUNIT_RUN_ALL
> --
> 2.20.1
>
