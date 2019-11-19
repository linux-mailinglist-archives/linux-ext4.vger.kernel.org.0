Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C765F102BD1
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Nov 2019 19:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfKSSkG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Nov 2019 13:40:06 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35055 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfKSSkG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Nov 2019 13:40:06 -0500
Received: by mail-pf1-f196.google.com with SMTP id q13so12621287pff.2
        for <linux-ext4@vger.kernel.org>; Tue, 19 Nov 2019 10:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jYjHSJvr+i9FC2v2zgsP96Au9uEuo58MANuvF+6NBVc=;
        b=NUGJDsr28kvTJwQuryficrX4gXw/AobGQnRXWancIWkQP7PcSBto66I8D5b42NRltE
         27La5zT90RZnbEQ1OBhGD2mDBi75K2lvQmz7TupyV1w/HSKYypXFadmxMcx8iG6/mItU
         eIjyY4kdNTdpg8AoS8qrlGisrWhZycLVtH+lXlcBVO98y//SiozIEiHLej5AJf4BIrxE
         fIrYsWP9bjs+cHHL8dNOpCiXZUeU1IKeWHqTeuLn494HYaxyDxwvmeUNNFmIP38AH4wa
         T/W3uTL1hJ10BV115Nic1e2HxRoU+nF+47C4MHytRVz4Pe21r+0CFbQU5p4vmmxfljqt
         zh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jYjHSJvr+i9FC2v2zgsP96Au9uEuo58MANuvF+6NBVc=;
        b=V/XdUjL2HMyLWydwpnb1oifcTIRvqhQTRh4dpf/j4fGtw34ZD5k2H1SXvNJEOQQ1uZ
         DjRiSPZwrfPrl2IfRSjK6XR0RdrNKZV2z9VUvPIDph8pquG+tiqvsW+njWQ7erSDu1rT
         5hzT7A897pWQJ3Hm9O2r8j9tFzXK5EebIN9YbotIdl29RIZvscp1faHVZuL+Jes1FaNc
         MaYP/m5Pj+wWfNI2kOfDNci6dmirJ+J2kmlL3GLicjvYVOoldUPi/eblrin1qmc13IAr
         ndXBNP/xesdDpNN8NqBvNE6Pef/O68oeknuAzURAZ0KtpOEUMMbgfCyqITu9pPL+hLMg
         GQig==
X-Gm-Message-State: APjAAAUIsfxd215j51qF5uLumc1MGRBR973Qqcxj4Xb/NRE5pAyKdOeu
        LGBB1tqb1XEnspEswmHY0a7GpUVAByxg+t9NPp9CMA==
X-Google-Smtp-Source: APXvYqyYCaJxCJoYIws4UTVjprf7I2OP+MEoJ45u03fPl7RX8dgda4nxwXp+wwGez7023IC2zXDCdaX8JfxDrzbjMrY=
X-Received: by 2002:a63:712:: with SMTP id 18mr1253250pgh.384.1574188805300;
 Tue, 19 Nov 2019 10:40:05 -0800 (PST)
MIME-Version: 1.0
References: <1573812972-10529-1-git-send-email-alan.maguire@oracle.com> <1573812972-10529-2-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1573812972-10529-2-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 19 Nov 2019 10:39:53 -0800
Message-ID: <CAFd5g455qerOtZ0nQNGiCKJ9Uqu1=y7y2OfrCKU0HUjY3LDJcg@mail.gmail.com>
Subject: Re: [PATCH v4 linux-kselftest-test 1/6] kunit: move string-stream.h
 to lib/kunit
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        Jonathan Corbet <corbet@lwn.net>,
        "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        Luis Chamberlain <mcgrof@kernel.org>, changbin.du@intel.com,
        linux-ext4@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Nov 15, 2019 at 2:17 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> string-stream interfaces are not intended for external use;
> move them from include/kunit to lib/kunit accordingly.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Knut Omang <knut.omang@oracle.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>

Stephen pointed out a couple of nits, but beyond that this looks good to me.

Thanks for all your hard work!
