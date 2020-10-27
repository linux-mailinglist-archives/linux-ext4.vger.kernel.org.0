Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0789629A5E6
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Oct 2020 08:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508451AbgJ0Hzg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Oct 2020 03:55:36 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37336 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508445AbgJ0Hzf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Oct 2020 03:55:35 -0400
Received: by mail-oi1-f193.google.com with SMTP id f7so403827oib.4
        for <linux-ext4@vger.kernel.org>; Tue, 27 Oct 2020 00:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DOZ/or+uXcofLUI05AASj9pqYEI1+H4nTxttRQeOH3w=;
        b=p0ybGNuotD2awoJRp4EIUps3i33wWnSBscgfxKE+PLT03BAAfghsklin5UQ1AI5LHb
         NKoqRRtTa/rJIBjm2EWYL+fKZ+pwXGCG9lFC5kLy0Hdm9u+zLFyksmaM+WRGUtZjYNoj
         c3ikMGBTs+zDygIBiywKzSXWg5zfr96Pqw/VHcrTy79z5wSofz4rPXO8K3QreT1V7ylJ
         uM14o74YCSexauZZ3iyZwyKFTdex1g9v2Uxpx9ISawxwvePFy+zZMHYdiDvPsHcAYaUx
         0iMz9wq8LP+Qv4HgF0HBr2ybRH2ImmsnCgs1B6Prd2o6mLH7LAvmdo4V8xgU5YDNOs28
         Oz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DOZ/or+uXcofLUI05AASj9pqYEI1+H4nTxttRQeOH3w=;
        b=e/oh3udAdKKaQ2zcW04K9TuKN7tEDHTTMqhKI1pZPMF86FhlkLkvjxFFf41D1IMgch
         WggwOSZTNSFdWn+dpvkvdwOKYNPepEWNtxWR9ix96bJmZsgtnwrLqelBRbOIjzKI/ZTi
         V7eGyyAjw67iQwkbla+z+cpHMpZ6Gu4HMOimj2beEYyxW1nUXOKbfAQstQD0Kma4wnbP
         ij2vJF7hvXW3/GJTdrJjLc+sYGe9OqReSYV+Lv7rUU88//vF2cYXMBRE6lNTCe+HkCcP
         Xn9vUqtNAnazzWJeSFllCevp13F0NYNAZkV+pLpdH0BnjCkLkSCfxjVXEbIXzWvVsEIj
         3+3w==
X-Gm-Message-State: AOAM531xxVywoxCPtHQg3IVO0dlj22v5ijTR59uZFOWK2nbfH/qGpEdA
        OLf1DxGzgZi6rSIxgKITPlNxWIzDYCRBb4zsblne7g==
X-Google-Smtp-Source: ABdhPJy9DnGoYipYvpataI7s7gEKop4LEknvR99sUFOYQrgxmqfLbYJYMFlpKS8G5wR7l7le8Ljz97l7WA1fdaM5ZvA=
X-Received: by 2002:a54:4812:: with SMTP id j18mr632555oij.70.1603785333575;
 Tue, 27 Oct 2020 00:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20201026183523.82749-1-98.arpi@gmail.com>
In-Reply-To: <20201026183523.82749-1-98.arpi@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 27 Oct 2020 08:55:22 +0100
Message-ID: <CANpmjNMNd2fMmqsmBMSTwD6Cp0OBORjTgDBiDOzXD1zVyELLnw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kunit: Support for Parameterized Testing
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

On Mon, 26 Oct 2020 at 19:36, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
[...]
>          * success starts as true, and may only be set to false during a
>          * test case; thus, it is safe to update this across multiple
> @@ -1742,4 +1760,18 @@ do {                                                                            \
>                                                 fmt,                           \
>                                                 ##__VA_ARGS__)
>
> +/**
> + * KUNIT_PARAM_GENERATOR() - Helper method for test parameter generators
> + *                          required in parameterized tests.
> + * @name:  prefix of the name for the test parameter generator function.

This could mention that the generator function will be suffixed by
"_gen_params".

> + * @prev: a pointer to the previous test parameter, NULL for first parameter.
> + * @array: a user-supplied pointer to an array of test parameters.
> + */

I just noticed this: the interface of this macro does not include
"prev" (which is an argument of the generated function, but not
supplied to this macro; "prev" should hopefully be explained in the
other comment you're adding for the new struct field). So, the
kernel-doc comment here should only list the actual arguments of this
macro, which is only "name" and "array".

> +#define KUNIT_PARAM_GENERATOR(name, array)                                                     \
[...]

Thanks,
-- Marco
