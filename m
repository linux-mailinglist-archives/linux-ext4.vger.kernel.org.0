Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE8D2953F4
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Oct 2020 23:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505938AbgJUVPo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Oct 2020 17:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505933AbgJUVPo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Oct 2020 17:15:44 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63098C0613CE
        for <linux-ext4@vger.kernel.org>; Wed, 21 Oct 2020 14:15:44 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kk5so1806453pjb.1
        for <linux-ext4@vger.kernel.org>; Wed, 21 Oct 2020 14:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZW4H+HkSax4dfTCQ1O9mSWMOeNGYTGZ0c8Mu7npYyhs=;
        b=HUZ6cRVo9d0RsVGYnGFg89JSJPcVvYT3PMRLwXbw5iWTQay9ot8awNMm7nKLu1LuTV
         c+cx9K/OprNoV0GA2CqSUfa/AspC8VBIFx+SldLz9nnTBBpnc537eaE4v3hwe42wuXRc
         FRWK0AF25WqxLdVeDBzlNXk5N6frWsw1iHdiYUcyldo511mwQVnf2g+uu+hywyFyC/66
         LD0xml/QOgc5TTG+cnprqdLUa1BXO+u20TQQy3jbTmbwQc7hsPurQyad60Yqj/TPgymE
         DxVxKTdhxm+qI72kjl+2YXoRjVoiqxHtqyb+c6cBQNR2yL8O1Aoo/bIfzjKF0vyrHo6r
         DTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZW4H+HkSax4dfTCQ1O9mSWMOeNGYTGZ0c8Mu7npYyhs=;
        b=pIS1+diNmXXzO5a9xUWrvGL11z1rc+RSxke8f444eVBqkGwKhgFaIDWok5z01+6PXs
         yrKydqLJcRVmteA8aFImK6MLZKYmLIQ2B0iqCaPzHTrbJfOz7Hj6ZA89C8rmwoo09PHw
         oiR+ZF2+3DWwNBYyfHVnfRCQ0hN3E3YmCg0wZSaNV8QQfqfUNog0OmpjWuYKQvEIEYTr
         JBhSrpa/eocZQPsI03yBnI9Bh3u2MjF4yj68oR4ooNZeWQldH6AOmuryPdayMx7Wf5q7
         Jy7EYPA8LoSl4q3JK8vn2+sKCrtWTlBsLVUYYbnlXBzCDIFw8xBLoGFalav5jzj0kYlS
         VIHA==
X-Gm-Message-State: AOAM531Sez9iTsMXeud61lM807u3YwqTpu7EsJzwfysMnv4b8dGm9J48
        6hP4UWFAfuICq8jTxHWzh2yKO56FFBj1a91XbSoXWw==
X-Google-Smtp-Source: ABdhPJyHzdUuY/qEGoP+823gx7/+DiP+C7sHXVbsIemUhDFho7iS0vIenEO5E+i/+epQw1ICFAS4493V4uNXaAJUgig=
X-Received: by 2002:a17:902:7003:b029:d4:e2c6:948f with SMTP id
 y3-20020a1709027003b02900d4e2c6948fmr141621plk.65.1603314943760; Wed, 21 Oct
 2020 14:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <20201020073740.29081-1-geert@linux-m68k.org>
In-Reply-To: <20201020073740.29081-1-geert@linux-m68k.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 21 Oct 2020 14:15:32 -0700
Message-ID: <CAFd5g44dGaKyDQGPeanE1G8MPzVdVkqbWjJhj+nQJGUgkezz9g@mail.gmail.com>
Subject: Re: [PATCH] ext: EXT4_KUNIT_TESTS should depend on EXT4_FS instead of
 selecting it
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        linux-ext4@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 20, 2020 at 12:37 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> EXT4_KUNIT_TESTS selects EXT4_FS, thus enabling an optional feature the
> user may not want to enable.  Fix this by making the test depend on
> EXT4_FS instead.
>
> Fixes: 1cbeab1b242d16fd ("ext4: add kunit test for decoding extended timestamps")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

If I remember correctly, having EXT4_KUNIT_TESTS select EXT4_FS was
something that Ted specifically requested, but I don't have any strong
feelings on it either way.
