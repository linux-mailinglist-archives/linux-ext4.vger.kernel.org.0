Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395D52C0980
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Nov 2020 14:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388114AbgKWNIj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Nov 2020 08:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388430AbgKWNIW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Nov 2020 08:08:22 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437FEC061A4D
        for <linux-ext4@vger.kernel.org>; Mon, 23 Nov 2020 05:08:21 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id 79so15789969otc.7
        for <linux-ext4@vger.kernel.org>; Mon, 23 Nov 2020 05:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XOXAAY/4nvkcRrNExNVW2w/236SkW1Wa7iXXWBvmVzk=;
        b=TjKKxvzDW2xRKxIFZmHVFhGbVxv0QEA4azsjh4Se746LrbtvwDBbIpopLLJPcdhJuI
         o1UN/Sgy+csMwaKTMGZjpYSYYvmIyiPIPJb0BBaL970Yx0co3l6w5RlEUi5zoeO3a41o
         ixa59nJIh/qvyqIxi1Oh0NLbZPaCS9YL7gDr3qR0euTD9h1m8ImjYcjwxjtWd+Hb9JxT
         oySzIQ0UlURtEcJqYo1XjJlylqzaWFr1Zysp2vrEeH7IiLXI1zCnOHsBDlOqNUItHNct
         4XZv1QveWS5lUpstKQIx2lAfZBxr0/GA6fXyIxSheWczhQdhMpmv184qnScvo2+vRaoE
         m1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XOXAAY/4nvkcRrNExNVW2w/236SkW1Wa7iXXWBvmVzk=;
        b=CTH179OSWo+ZFSmU3SymoJu/KFQAjyhm2cLXVaRqCuGJK1Sxd47F5FS/nzJZeA6rtq
         7VsTgZC4BnnRjAbiJSK5kFwUb3bbAgrIMw+0ITddHscUdFBSoKi5w0+Hbq1gef2kOF5o
         x7FkaZMrR533a+c34d+EDTg5PEpv1LexBtXinWgpx5NKpAGjdB1veDfzKsN4bRawMSct
         iWt/cCyEtD3q9tZsAxjMAK8ThoP2U+YGxQjPd4H1gXXG0m5P7MpksWrfzRzpFkGrlAWv
         6hwQhGMXHrezyl206G6T7eyuZnPlGIDlo2UahDbU/nr5GZK0TQqvUzPPaklRiLHs6ADU
         XmgQ==
X-Gm-Message-State: AOAM533pn617ZcVdQSGpBbnlUlnLUtlUKwP3n/TZyXCKiLqfhSvZ6KhB
        xDMF1yHWSGgY37wtEvVjtU15wwt6NrtidDZotwjonQ==
X-Google-Smtp-Source: ABdhPJzr6yHUX5v7BGEcMhUDV1cUCOAKiltj24nnnPzP6TuGA0Pq1ldfeUd2BvVxt3jSHtlqeTvapEQeBsyIkpdrGqc=
X-Received: by 2002:a05:6830:1c76:: with SMTP id s22mr12465867otg.233.1606136900157;
 Mon, 23 Nov 2020 05:08:20 -0800 (PST)
MIME-Version: 1.0
References: <20201116054035.211498-1-98.arpi@gmail.com> <CABVgOSkoQahYqMJ3dD1_X2+rF3OgwT658+8HRM2EZ5e0-94jmw@mail.gmail.com>
In-Reply-To: <CABVgOSkoQahYqMJ3dD1_X2+rF3OgwT658+8HRM2EZ5e0-94jmw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 23 Nov 2020 14:08:08 +0100
Message-ID: <CANpmjNOhb13YthVHmXxMjpD2JZUO4H2Z1KZSKqHeFUv-RbM5+Q@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] kunit: Support for Parameterized Testing
To:     David Gow <davidgow@google.com>
Cc:     Arpitha Raghunandan <98.arpi@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
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

On Tue, 17 Nov 2020 at 08:21, David Gow <davidgow@google.com> wrote:
> On Mon, Nov 16, 2020 at 1:41 PM Arpitha Raghunandan <98.arpi@gmail.com> wrote:
> >
> > Implementation of support for parameterized testing in KUnit. This
> > approach requires the creation of a test case using the
> > KUNIT_CASE_PARAM() macro that accepts a generator function as input.
> >
> > This generator function should return the next parameter given the
> > previous parameter in parameterized tests. It also provides a macro to
> > generate common-case generators based on arrays. Generators may also
> > optionally provide a human-readable description of parameters, which is
> > displayed where available.
> >
> > Note, currently the result of each parameter run is displayed in
> > diagnostic lines, and only the overall test case output summarizes
> > TAP-compliant success or failure of all parameter runs. In future, when
> > supported by kunit-tool, these can be turned into subsubtest outputs.
> >
> > Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> > Co-developed-by: Marco Elver <elver@google.com>
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> [Resending this because my email client re-defaulted to HTML! Aarrgh!]
>
> This looks good to me! I tested it in UML and x86-64 w/ KASAN, and
> both worked fine.
>
> Reviewed-by: David Gow <davidgow@google.com>
> Tested-by: David Gow <davidgow@google.com>

Thank you!

> Thanks for sticking with this!

Will these patches be landing in 5.11 or 5.12?

> -- David

Thanks,
-- Marco
