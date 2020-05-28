Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793FF1E6A00
	for <lists+linux-ext4@lfdr.de>; Thu, 28 May 2020 21:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406049AbgE1TFO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 May 2020 15:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406045AbgE1TFI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 May 2020 15:05:08 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78298C08C5C8
        for <linux-ext4@vger.kernel.org>; Thu, 28 May 2020 12:05:08 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id s69so755pjb.4
        for <linux-ext4@vger.kernel.org>; Thu, 28 May 2020 12:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0J8Ym+kzod0znonchBb67O6GEq+arSkfzWAx+2kx7IA=;
        b=a8nA3Uvc1XNWqllXPWq50YCm6GC9JIOys9XsXoIOt75s4dnRClATn64VHORczX9nz6
         36TiE/XIWNy4AlmxWJnXDOjgvsdfvmvpVnaO2spx11lRLFhR2wUwUrM6twTgijFZSMqE
         wlhBeYKIjt+aSvFkHgat+EnhmlS08Lj8cQdcmDa8DdOVCnGQfzYhxtphaTNntW39TuoY
         NXWldrR4iHGI2FL0D3sITI0vFDewIHKpEGHL2qvhCcHfj0ZL8ZpDSHixbKyv8jWakGKz
         hMtXp+VhiNXwFMwKe+la2CyE3Cj0X/v83o5EewZSH0f1rn80z/ge1nhoKL5BqoZMw6XH
         lzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0J8Ym+kzod0znonchBb67O6GEq+arSkfzWAx+2kx7IA=;
        b=hBuL2dqKJmqN+sne9bi+86FIhteqzXjap8eoVZRaOjUGDHr3YzgOdP+/h5Z+u4S67b
         MqyoypjdCWHPYlYKv6VL2yusFW5cPMJtvCToytumaiPmkQfkiO23HufY+++tbONsUCw+
         2SyLc4br9zOci4XVSlkO8ZsuG/xO6QVo+oiZFNo5JSRjyQr8XXXNHhCwNxZLjkbPxDCc
         xnbuwYs//9LR8czfNhVyvcJ5uN4mFLT7yGSfcyMsIYSBOZIBwt8T/TJL8hpe/zsXNgr9
         UEtM+2yOG0j+dHEpEhaNayhMb88Eby+v5kuJEN4trKBT3mH3U9anpveoa8waRS9IQKhp
         Ik/Q==
X-Gm-Message-State: AOAM533KUWnCtqJxmTAoK/EsI/vx2mRxoucLbpwfmfI9CvvaKpddal2h
        BiAqxhSYnx0UgBe4FHgmshu2L2d5IRYmWoaSpTBZtA==
X-Google-Smtp-Source: ABdhPJyGks+NLInlB7CGn8AvdNxpH+2UCTLT9jhDTHdhJNdwc1bWKpa0P/I3v5HG+9H3eFYcbh9Z67/5AufG661dnwA=
X-Received: by 2002:a17:90a:17ed:: with SMTP id q100mr4941782pja.80.1590692707555;
 Thu, 28 May 2020 12:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200511131420.29758-1-anders.roxell@linaro.org>
In-Reply-To: <20200511131420.29758-1-anders.roxell@linaro.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 28 May 2020 12:04:57 -0700
Message-ID: <CAFd5g458j=VXttzbJUtD-HQR4k5T7us44oQOB6EPL09rgVr4LA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] kunit: Kconfig: enable a KUNIT_ALL_TESTS fragment
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com, "Theodore Ts'o" <tytso@mit.edu>,
        adilger.kernel@dilger.ca, Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, linux-security-module@vger.kernel.org,
        Marco Elver <elver@google.com>, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, May 11, 2020 at 6:14 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> Make it easier to enable all KUnit fragments.  This is useful for kernel
> devs or testers, so its easy to get all KUnit tests enabled and if new
> gets added they will be enabled as well.  Fragments that has to be
> builtin will be missed if CONFIG_KUNIT_ALL_TESTS is set as a module.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
