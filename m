Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F831C805D
	for <lists+linux-ext4@lfdr.de>; Thu,  7 May 2020 05:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgEGDL0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 May 2020 23:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728666AbgEGDLY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 May 2020 23:11:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B45C0610D5
        for <linux-ext4@vger.kernel.org>; Wed,  6 May 2020 20:11:23 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e16so4509285wra.7
        for <linux-ext4@vger.kernel.org>; Wed, 06 May 2020 20:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/M4/DuBTGflvVuChw5Y25GaHL26QwHucGpDopq+uKKM=;
        b=EDZcbDkryNHUq+1LtvqavsxqGBJ2zTgq94L3okmprwpunnwTqR843h/HBRE9aU+gHJ
         V4HcsR9N0EJlXs7fC0Wt4d5cyP4EvYKBZDbJQ7xDwC74mBhV6Om8NAOKru6gJ1ylLOzI
         wE2MB+h/1AOPbbHBAdNE+XMuiBgywyQ60Mia14JbAEGLC+u7ZOLY/dhydgzotaUpF8uY
         QwnYAynKqDtPfZzajgUJo2uvhonRZF3QPRJ1e+E9RdcEmRGMFnbFw6dAtUCuCksgLmmn
         6JieoL6lt15z7QZ0COWZ8gB9QYLbTQg/F+92uVog9oKiv4936wfJgOmksAKdpwWjacWY
         YYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/M4/DuBTGflvVuChw5Y25GaHL26QwHucGpDopq+uKKM=;
        b=eKqm/tVaDkXgdBabP8RPwJtrvGIB4x1LY+6dJnGhbLYCl1mjZ3wcEc9Z1JrkLbvst9
         vs/hynArKiwO2u19fEbu+JjZsuhssVsS60WWoMzveqaCYRE9GBvqo7USpBgT9itRXnGI
         HdZNZzo5gsqyXqWr++eTiregoYtcRCvVYjgC7GXSSSrjcOHCmqXo7kxLYEmxu+nca+i2
         lDHpuBRNEBOZ/LCJNbLOoxNDqQtAmsNSUXoRfbMpCX5t9QulmsLt/k8FbeFADgI+1uWe
         V+sVvyogd1jn2v2JSVRvhIzw4PGqCvWuyx/4DHujDgz3qVP/fvmvMyTrMmu/WSh+CeVl
         tBZQ==
X-Gm-Message-State: AGi0PuaUbuA8DlkEo2oGa4W7JYHleeSKUZW0eA3FbsvkIpU7cI/ZK3fO
        ZJ9hmOdVqddaix9RAitr8pY6JY+Ec4yFPO+eJGVBCg==
X-Google-Smtp-Source: APiQypLBDSZbDJjvDYDKUk2tG5mW4OE2larhjMHIL+GzojR08YDhbTwnOD8/jg18+7ituZ8OLmGHSBh19zzrRajSfq8=
X-Received: by 2002:adf:e34d:: with SMTP id n13mr1519574wrj.249.1588821081532;
 Wed, 06 May 2020 20:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200505102714.8023-1-anders.roxell@linaro.org>
In-Reply-To: <20200505102714.8023-1-anders.roxell@linaro.org>
From:   David Gow <davidgow@google.com>
Date:   Thu, 7 May 2020 11:11:10 +0800
Message-ID: <CABVgOSnxMd1ZdEQ3jHxtok1oQcMKh=UMtxZufeS9fv-q9C3-AQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] lib: Kconfig.debug: default KUNIT_* fragments to KUNIT_RUN_ALL
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com, "Theodore Ts'o" <tytso@mit.edu>,
        adilger.kernel@dilger.ca,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Reviewed-by: David Gow <davidgow@google.com>

Thanks!
-- David


> ---
>  lib/Kconfig.debug | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 21d9c5f6e7ec..d1a94ff56a87 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2064,8 +2064,9 @@ config TEST_SYSCTL
>           If unsure, say N.
>
>  config SYSCTL_KUNIT_TEST
> -       tristate "KUnit test for sysctl"
> +       tristate "KUnit test for sysctl" if !KUNIT_RUN_ALL
>         depends on KUNIT
> +       default KUNIT_RUN_ALL
>         help
>           This builds the proc sysctl unit test, which runs on boot.
>           Tests the API contract and implementation correctness of sysctl.
> @@ -2075,8 +2076,9 @@ config SYSCTL_KUNIT_TEST
>           If unsure, say N.
>
>  config LIST_KUNIT_TEST
> -       tristate "KUnit Test for Kernel Linked-list structures"
> +       tristate "KUnit Test for Kernel Linked-list structures" if !KUNIT_RUN_ALL
>         depends on KUNIT
> +       default KUNIT_RUN_ALL
>         help
>           This builds the linked list KUnit test suite.
>           It tests that the API and basic functionality of the list_head type
> --
> 2.20.1
>
