Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC0C1E4068
	for <lists+linux-ext4@lfdr.de>; Wed, 27 May 2020 13:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgE0Ltd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 May 2020 07:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgE0Lt3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 May 2020 07:49:29 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0599CC061A0F
        for <linux-ext4@vger.kernel.org>; Wed, 27 May 2020 04:49:29 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id e125so14286854lfd.1
        for <linux-ext4@vger.kernel.org>; Wed, 27 May 2020 04:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1eb8hhRgWhldc6gNCY/BHu4k6Mc3ON849X4b3k08UMU=;
        b=dZ2EO3LdRXmW0rb/PbGBy5/ATbLPpBSpne2iHWL8g4cHa5pFCH5GCbOAD7jC3Kzi3S
         MISYPGpgS2exm9jQV0gLr3s2v7seE3tyMVMGbhwvcq5KWBC2lbp4WRogLsHJmD56dSoF
         SaGqBkdQFcT/Q8+h09FriRhyy32nZ8Qbam2ia6qehADmirwsw9FzofuUIssUXiEf/O1M
         PNKyMGSEEuXIahADQmZbrbIFZkk9iuRkEcQbQIaG2M4cssRD0uw+ZxOkNkqohemuxYe7
         g5KMFqDZR/29AuHUIPPzijSDWnAEbdNVWRVRrdnecAjUZPqBYLoGLUucygRKxHZITQJs
         lRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1eb8hhRgWhldc6gNCY/BHu4k6Mc3ON849X4b3k08UMU=;
        b=IJnn2DCtUTzFRjqikUga9WjpMB0lqnd/7qNIt9bYT5Qf8mC5cEDPM3IfSz2i7186cu
         4/KgknrDty0GU7DXWTyW1q00aDd6wUIet75NZ9onAR3xXz1Y0EoNOoCYM93N0JZ1roY/
         Co0AXdnGKyrpl1Yq3+LhXuOHEjVCI9tdY68QH2iqcnIpEqNWHsOeEDHktHZow3WEoNCS
         z6hyXIyzFIFB24t7PWJZJKuwgQf11XC33q2BcbtPEvkRkIJcLnxdFzPnllm/OX5xKYIq
         AroLu2r/Z1DcxPmfd7R4hzLoZyUzkmKmm8XK5z7fXrC7vd2JBFW5yBpuSnmvCcfpVOjG
         f0YA==
X-Gm-Message-State: AOAM533JCqnGQUUEqgS0gDYZFms2Ahd3rmnwDgbBK1g0do334RVRzchP
        P0N5SPNbBU9TyyBPaXhdobT9cHtwpEwCFHtMKDXlTA==
X-Google-Smtp-Source: ABdhPJxtfHGgD1x+0sGWQDtxJJeB9uCl6Feg/5utDqmnhP3TYYxI7kATndRbmt63ldid6mOZbKhfx/ZSXQlPvqovUXQ=
X-Received: by 2002:a05:6512:1051:: with SMTP id c17mr2908078lfb.206.1590580167403;
 Wed, 27 May 2020 04:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200511131350.29638-1-anders.roxell@linaro.org>
In-Reply-To: <20200511131350.29638-1-anders.roxell@linaro.org>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Wed, 27 May 2020 13:49:16 +0200
Message-ID: <CADYN=9LkA2h6dANREfPQq4iDvVEJX1wAdxjv31mpVBkaM_g0ZQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Enable as many KUnit tests as possible
To:     Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Marco Elver <elver@google.com>, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi all,

Friendly ping: who can take this?

Cheers,
Anders

On Mon, 11 May 2020 at 15:14, Anders Roxell <anders.roxell@linaro.org> wrote:
>
> Hi,
>
> This patchset will try to enable as many KUnit test fragments as
> possible for the current .config file.
> This will make it easier for both developers that tests their specific
> feature and also for test-systems that would like to get as much as
> possible for their current .config file.
>
> I will send a separate KCSAN KUnit patch after this patchset since that
> isn't in mainline yet.
>
> Since v2:
> Fixed David's comments. KUNIT_RUN_ALL -> KUNIT_ALL_TESTS, and he
> suggested a great help text.
>
> Since v1:
> Marco commented to split up the patches, and change a "." to a ",".
>
>
> Cheers,
> Anders
>
> Anders Roxell (6):
>   kunit: Kconfig: enable a KUNIT_ALL_TESTS fragment
>   kunit: default KUNIT_* fragments to KUNIT_ALL_TESTS
>   lib: Kconfig.debug: default KUNIT_* fragments to KUNIT_ALL_TESTS
>   drivers: base: default KUNIT_* fragments to KUNIT_ALL_TESTS
>   fs: ext4: default KUNIT_* fragments to KUNIT_ALL_TESTS
>   security: apparmor: default KUNIT_* fragments to KUNIT_ALL_TESTS
>
>  drivers/base/Kconfig      |  3 ++-
>  drivers/base/test/Kconfig |  3 ++-
>  fs/ext4/Kconfig           |  3 ++-
>  lib/Kconfig.debug         |  6 ++++--
>  lib/kunit/Kconfig         | 23 ++++++++++++++++++++---
>  security/apparmor/Kconfig |  3 ++-
>  6 files changed, 32 insertions(+), 9 deletions(-)
>
> --
> 2.20.1
>
