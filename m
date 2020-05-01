Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B4A1C1E7D
	for <lists+linux-ext4@lfdr.de>; Fri,  1 May 2020 22:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgEAUb1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 1 May 2020 16:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbgEAUbX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 1 May 2020 16:31:23 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7C7C061A0E
        for <linux-ext4@vger.kernel.org>; Fri,  1 May 2020 13:31:23 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t16so4011695plo.7
        for <linux-ext4@vger.kernel.org>; Fri, 01 May 2020 13:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DVZsHO3B+82ZVvSvwD+6L84uL6YCwy6wqP9DD2caeKY=;
        b=Zc3KuQRuQy2OoPJPM+d+PnQiWTvDwpVtt8Zs/O3P2xKcWz2OpXBRQHO7c7IRb3Svou
         7tdEiY8sRnRcjQKcq5Zj+0PlJ3VLXU+3aiTRKJ5MlWhFdkPfkoa8RKmQKcnL+YtrFDPP
         AoyAhLCPYp/Bscc03FLzyMRL/p9YsUHnOlTHVDrPdG/xFXwkBqT1eusZGZHPZcMORFnJ
         XUnONPMgBLe3uBUsDaF4ihYyjghwSsIq+4toZYrsvYog8R/WKxPl/CIP6xrmB3iChGu+
         IP/ZvPS61IFkPnLMCnS1V56OJBpUCNYtLWaCzdi/NkjLIM7PXCLaVmPYfH/gNTtPYD9V
         IZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DVZsHO3B+82ZVvSvwD+6L84uL6YCwy6wqP9DD2caeKY=;
        b=e2ClS7ufJcmGAHwhna6nPJIWvlDe9s7inwKAhCes2f+qs5aKvbd/DOQjiQfKs2RpGV
         JEZnRbtgQmS9/bOIaGFa0RpP7+Xi4R4hKhbenQz4em97F4EWvZJr9jw4MDt15avek/df
         gJnosTWWuipGjhChu3ZDulCpx9hNlNMZozUgqZ4bzqDi0sUtrOYHjjh+XbKWsCYKaVQS
         q/pJgRUmemCjf3QKVfLSEJr4htAVAUR+wLa7ezV3l5OjYt4HDvFTTfDRCUVHlo0rhOJV
         Tz17pnQKf9K3uSgIFuqDMTwe00WX2xc85VZHhrb6aLAiOCl7gJA5qTT9vd8VAKKRf7k1
         yCug==
X-Gm-Message-State: AGi0PuZp5oIH/PoQWyy4QCSRB82qq22MKvtc/f5SJ6bADSW893cQ/F8B
        BlYVIFE8WhySH+/k3YP8RiS21DI3zZ47erWnyxdTFQ==
X-Google-Smtp-Source: APiQypJ9b4QRn/GrVn+RH4LsZdGv7V2jtr2OO/8zkSxd5QcIuJPpD3L0aOdJL8jy19OYg1HSleGSA99rMnX4I9DcZ7s=
X-Received: by 2002:a17:902:a40e:: with SMTP id p14mr5817749plq.297.1588365082975;
 Fri, 01 May 2020 13:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200501083510.1413-1-anders.roxell@linaro.org>
In-Reply-To: <20200501083510.1413-1-anders.roxell@linaro.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 1 May 2020 13:31:11 -0700
Message-ID: <CAFd5g45C98_70Utp=QBWg_tKxaUMJ-ArQvjWbG9q6=dixfHBxw@mail.gmail.com>
Subject: Re: [PATCH] kunit: Kconfig: enable a KUNIT_RUN_ALL fragment
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        Marco Elver <elver@google.com>,
        John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, kasan-dev <kasan-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-security-module@vger.kernel.org,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, May 1, 2020 at 1:35 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> Make it easier to enable all KUnit fragments.  This is needed for kernel
> test-systems, so its easy to get all KUnit tests enabled and if new gets
> added they will be enabled as well.  Fragments that has to be builtin
> will be missed if CONFIG_KUNIT_RUN_ALL is set as a module.
>
> Adding 'if !KUNIT_RUN_ALL' so individual test can be turned of if
> someone wants that even though KUNIT_RUN_ALL is enabled.

I would LOVE IT, if you could make this work! I have been trying to
figure out the best way to run all KUnit tests for a long time now.

That being said, I am a bit skeptical that this approach will be much
more successful than just using allyesconfig. Either way, there are
tests coming down the pipeline that are incompatible with each other
(the KASAN test and the KCSAN test will be incompatible). Even so,
tests like the apparmor test require a lot of non-default
configuration to compile. In the end, I am not sure how many tests we
will really be able to turn on this way.

Thoughts?
