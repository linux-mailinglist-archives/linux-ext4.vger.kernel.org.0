Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF012B5A37
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Nov 2020 08:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgKQHVI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Nov 2020 02:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgKQHVH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Nov 2020 02:21:07 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE61C0617A7
        for <linux-ext4@vger.kernel.org>; Mon, 16 Nov 2020 23:21:07 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id b17so23081933ljf.12
        for <linux-ext4@vger.kernel.org>; Mon, 16 Nov 2020 23:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=80Js5MzpHp2BBoeVGpXRsYdQ6UcFRe8F27UXWyhna1Y=;
        b=AZI9q7Hh5V0M3ulX5rXXq94IdrHcPbKhKzMBw8pHrITVB6DhBINSuSLKZM56RV08Ut
         zePZpSkaopondOCx+ODPU34lvDF/Qa8tF2O3CDRuL36QlTT7cpy+xdRayULsVWPpwV/q
         VTu0648DGbdPC+1Gycuz14zyTF0aFXT3C7KHogy6bm8ZP8QBV+Sk9XWrSyCHB3afX+4f
         O417S8E0LRdNxUzquMgDuoWrcOsuEHEB64DYSWU3mHUQdS25kVEezV8KUCjIUbCPX6kr
         WuY9jLzfi42uTOpIJ0kXXEkSnf3Dt4Upw/vhj9JcSBNkt1TbhtlO4QK5HMZ4Y0HZYoLi
         Uzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=80Js5MzpHp2BBoeVGpXRsYdQ6UcFRe8F27UXWyhna1Y=;
        b=mLsXNtVEhaLzq2u7+qI9qYBaWUkMZdvt127KfaDdUUgLH0nionYO4vcHvyqg8cohrP
         u+cfM71G07ns7Bq+8HSE7/KmDqo6ttZ0EkbKiRN0u1dlIev7uMk+dE6WR81y0TpGWghd
         A9XduSA+2QKNTonYfVzEWg+6rz+2sIKJmMkkheP0zRxliz1vHy9UsLKcFpNEdN/+8q2O
         As7/UiIRj7KRfL/1+Frn4/uedFsIFehXy3jd4mWr5PtvPGhNzA2L7meDFFtnNzJBS9m0
         75nCLeDcVE1G3yXWswBF52B+cGClYFJuwDvc3iLxhw/2RnMoTSYA29FFXXCdHUW7UtQL
         LJLw==
X-Gm-Message-State: AOAM531je5RVVqT+CTH+MM5d6aGcVPrReN2sSSryxrFqm1+kA/6PVvNG
        J2HA29jvHqHCWeKcFzO9afbae/J65lZA7GwxfbDnOQ==
X-Google-Smtp-Source: ABdhPJywGgbQ9i2Pw0CnqEmzP1/KTa/qYi1ggHVULwNavreJq3J/8m6hrHchGZDgMVWmiB61tHAZNSCM4ssJCrw8kg8=
X-Received: by 2002:a2e:8504:: with SMTP id j4mr1204429lji.169.1605597665336;
 Mon, 16 Nov 2020 23:21:05 -0800 (PST)
MIME-Version: 1.0
References: <20201116054035.211498-1-98.arpi@gmail.com>
In-Reply-To: <20201116054035.211498-1-98.arpi@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 17 Nov 2020 15:20:53 +0800
Message-ID: <CABVgOSkoQahYqMJ3dD1_X2+rF3OgwT658+8HRM2EZ5e0-94jmw@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] kunit: Support for Parameterized Testing
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Marco Elver <elver@google.com>,
        Iurii Zaikin <yzaikin@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 16, 2020 at 1:41 PM Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>
> Implementation of support for parameterized testing in KUnit. This
> approach requires the creation of a test case using the
> KUNIT_CASE_PARAM() macro that accepts a generator function as input.
>
> This generator function should return the next parameter given the
> previous parameter in parameterized tests. It also provides a macro to
> generate common-case generators based on arrays. Generators may also
> optionally provide a human-readable description of parameters, which is
> displayed where available.
>
> Note, currently the result of each parameter run is displayed in
> diagnostic lines, and only the overall test case output summarizes
> TAP-compliant success or failure of all parameter runs. In future, when
> supported by kunit-tool, these can be turned into subsubtest outputs.
>
> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> Co-developed-by: Marco Elver <elver@google.com>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
[Resending this because my email client re-defaulted to HTML! Aarrgh!]

This looks good to me! I tested it in UML and x86-64 w/ KASAN, and
both worked fine.

Reviewed-by: David Gow <davidgow@google.com>
Tested-by: David Gow <davidgow@google.com>

Thanks for sticking with this!

-- David
