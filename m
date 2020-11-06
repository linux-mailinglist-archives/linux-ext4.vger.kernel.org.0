Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5F62A9E25
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Nov 2020 20:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgKFThj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Nov 2020 14:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgKFThj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Nov 2020 14:37:39 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7FEC0613D2
        for <linux-ext4@vger.kernel.org>; Fri,  6 Nov 2020 11:37:38 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id o25so1652452oie.5
        for <linux-ext4@vger.kernel.org>; Fri, 06 Nov 2020 11:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mP1FNfhSXY5n5cuTFQ/M/4yPG4XlmpEFYtLq6GDkKUE=;
        b=gNu7ut0U3clqE69rnhvzIiZ3OwEi3TwtXhAk+ORMHzmp+mUaN//pGv8x5n81jS/WTF
         X1xpRtZ3V4YUrpu+d9nEjd7tGDf2u+THCYyaAScnvt8xQv5fEqMTZpp6Reg1IaPKU55Q
         DEYqXfOdwV6Om8D0YqSAPniZro7lAkm3CZHvTBOxaI/r07dGtacIrkrEgo6HCC2suUys
         lKGsbKn9AZS9oKXN3my1JG+d4UBUwtR6AKHGfw2zsLhIvATpl261KCKxXeuGxoplafZe
         X/JeWyHmYkeDTbWba2gWJdGDABaBSI+pw6MHNDshMDjf2Mj5ez6674PBCXhdwjOtnBeZ
         DL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mP1FNfhSXY5n5cuTFQ/M/4yPG4XlmpEFYtLq6GDkKUE=;
        b=nUodOVFnerNYbn0cfZqnSXQB0Ct/Qb+WpQEDtGKmX6XbFzdDPpkCuDMA5Rs1WdG1Bm
         bIcCuJuG9FLezk81mr18JO9aHmOkLIME3J5WiBn7iiBk5bAsEsFZ+18obW+ZAxt8NUyi
         yEIQnMJK613sj0wXSN8f15NavKILtAC9pVlF7NdgtLVHsApiMKp9A2+k79HZVR09LQsj
         t1iOIJF7ZHG2DPKcLjAprehmj86r6fK5xua/5s/Pt0C1KEWh1RmZtOLWkoestQCQDYLm
         ypGXXF8oj74ppPM49LgRGGdYVDYXkaTP/95TiXKc9OiB0+nGxkItPep9dDs2EiYKTTMi
         askw==
X-Gm-Message-State: AOAM530E0NjYlg39V5d/DStV5xbjrrr2tICoLWuxtGpZEqDlIBl5ZHh5
        qIme40tqdetk+wCzKxiCZg5tXQ9A1NaST3GbptG8Dw==
X-Google-Smtp-Source: ABdhPJydJRE9oDMRNEsREh7ZPKeGFWX+yL0ZSvAAmgnD57EBdmSwWm2xusshWTHj2B1LZFSsf7tK4a9GHtNmM+nIYUQ=
X-Received: by 2002:a54:4812:: with SMTP id j18mr2150352oij.70.1604691458091;
 Fri, 06 Nov 2020 11:37:38 -0800 (PST)
MIME-Version: 1.0
References: <20201106192154.51514-1-98.arpi@gmail.com>
In-Reply-To: <20201106192154.51514-1-98.arpi@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 6 Nov 2020 20:37:26 +0100
Message-ID: <CANpmjNNj=ub1TLEOxtjajVsm0Fw9fJnFAZOhiYewiBzVFgFVew@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] kunit: Support for Parameterized Testing
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        skhan@linuxfoundation.org, Iurii Zaikin <yzaikin@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, 6 Nov 2020 at 20:22, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
> Implementation of support for parameterized testing in KUnit.
> This approach requires the creation of a test case using the
> KUNIT_CASE_PARAM macro that accepts a generator function as input.
> This generator function should return the next parameter given the
> previous parameter in parameterized tests. It also provides
> a macro to generate common-case generators.
>
> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> Co-developed-by: Marco Elver <elver@google.com>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
[...]
>
>  include/kunit/test.h | 36 ++++++++++++++++++++++++++++++++++
>  lib/kunit/test.c     | 46 +++++++++++++++++++++++++++++++-------------
>  2 files changed, 69 insertions(+), 13 deletions(-)

Looks good, thank you!

Others: Please take another look.

Thanks,
-- Marco
