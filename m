Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42E82A9C6D
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Nov 2020 19:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgKFShs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Nov 2020 13:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgKFShs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Nov 2020 13:37:48 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786F1C0613D2
        for <linux-ext4@vger.kernel.org>; Fri,  6 Nov 2020 10:37:46 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id g19so2100817otp.13
        for <linux-ext4@vger.kernel.org>; Fri, 06 Nov 2020 10:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3x8lkL/vF3DeMoPUyqu8hGji+Bqntj3O00ZDR1pSoh8=;
        b=VuCd+77RNfI0hWDR2kG9l/qjtgPXcb8KpunD74WGmWoVW0/r65kNFz4QDHzaXhI3yb
         LGhkeJAgJT8WUx4Vg532YPdWRe7+5IpVXBlvYohFn+XwHZEsT0lLml+fdr6hVXJLXTRU
         b2/ioDdlSvibYc2ggcjP5NIY1lQwVs4ZTpx9YAw0UAArapXqkRBSt7Tdq8OzaNlo0uCy
         ZPqbf8Iz3bOdU7Q3NfXphQIBsZJ97JkdelZs9GZ0JrbQmExwK8sRhghJnsXNvX8nzFdt
         SBb4LYPYB6SYjwQ2kg542mO/1x7fsDWm8bd6/MYtQGSSk5lMy960clq5z2VnR5HCt1EJ
         MTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3x8lkL/vF3DeMoPUyqu8hGji+Bqntj3O00ZDR1pSoh8=;
        b=tbCGGl8//sSnMZo/IrLGb2CDT85Qm5X93R9++bfD1x9uJ6/q5OAVMP+ay/57cQSZoE
         t5H7PIsn5wion7lQrVgXdHuXYA4BkA3CuMWqscymCp/sLsXN7dIRXOzMqyWRNY3bI86c
         6BM9ACWw0Z0ARlpRBIwc40y7DrVijZ+jueYdGLefvuCHtFIrzyOt0h/W+6u8Hr5QiMnc
         iNPvuyKNXe7P+ELkfTF6Ryodl/qyeiGaZyT0pIfQym3fg/E5dooi7YeaFzl2CogEuKQq
         R/0puwdulQrB+Wyb2CXu5ZASMSDggOmU36rbhDUGMszqfDtFBzwiT+wXPxxUw55AFDhG
         K89w==
X-Gm-Message-State: AOAM530rGgSvf/UWzc03XfFnjwpUGxPsyTJzBLyddFbkkH/RnEhetPmp
        LgK+nIBzY4rqaRs1y4ioN2LmTXvNHyaZ5mWZMesfYg==
X-Google-Smtp-Source: ABdhPJxkC9aWUWZPl7ZvvP579HKk4Zam6Q8tQyPSRMBu3yFJ0dlRugCsCtjDptsvn5pFUSicllmPJ91315N/2DnrAcU=
X-Received: by 2002:a9d:649:: with SMTP id 67mr2055700otn.233.1604687865602;
 Fri, 06 Nov 2020 10:37:45 -0800 (PST)
MIME-Version: 1.0
References: <20201106182657.30492-1-98.arpi@gmail.com>
In-Reply-To: <20201106182657.30492-1-98.arpi@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 6 Nov 2020 19:37:34 +0100
Message-ID: <CANpmjNNNpuxtMnfsFz4i+699XdyzKZc=dS_G_UavLvZSZgJsnw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] kunit: Support for Parameterized Testing
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

On Fri, 6 Nov 2020 at 19:28, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
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
>  include/kunit/test.h | 36 ++++++++++++++++++++++++++++++++++
>  lib/kunit/test.c     | 46 +++++++++++++++++++++++++++++++-------------
>  2 files changed, 69 insertions(+), 13 deletions(-)

I think this is ready. Thank you for your patience, and addressing my
comments! I'm obviously fine with v5, but I think my Ack or Review
won't count much because of Co-developed. :-)

Others: Please take another look.

Thanks,
-- Marco
