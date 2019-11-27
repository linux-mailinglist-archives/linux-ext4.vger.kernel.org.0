Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB9D10A75B
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Nov 2019 01:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfK0ALL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Nov 2019 19:11:11 -0500
Received: from mail-qv1-f47.google.com ([209.85.219.47]:40358 "EHLO
        mail-qv1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfK0ALL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 26 Nov 2019 19:11:11 -0500
Received: by mail-qv1-f47.google.com with SMTP id i3so8143357qvv.7
        for <linux-ext4@vger.kernel.org>; Tue, 26 Nov 2019 16:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tPAa6K1hEpZAWlJEeILCEz+OHSX3u+lqqPmekXqKtCk=;
        b=P4pdcjgVPTXnEoTGZtK93BlobdSiRutjA1iG1KGbsFAphbNpjl0YpBK/OAFFZ+FgY+
         cW32B5l/fi6UxEewJjB5C1jgPc7Lj/akQm1IVAGHifTos7ftU4fB8jFL/Kg+cLybKZaR
         r9lc4Y6N7IxhGE4aXpQCDsuV38VeS1nCvNbK/OISm9foy1xIXVZHK3GGR0GeqRx34rDx
         4XEkr7/4jbqxukXdEqz7GfyxxV9SByuMgK3leALFXZUf65kjpbw4AibKgDz+U+cabe5Y
         AP5gCpzH1op9RSFH7NMexffasj/+agaGi1oUuhV2iGaalsRT/J8ouuLTz3+u5WHz339m
         Mo4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tPAa6K1hEpZAWlJEeILCEz+OHSX3u+lqqPmekXqKtCk=;
        b=PsPJYVttNZr7V75bnlEtyDZTkGjjxYJRPRsi+HKYP4rUJ+2bF5Bg9GnUQhIu6t2gDy
         mGCsX3KEIXUSG4l7n3pj0qLSKqW6W9Chluq98DEESoNzYmft4osHVoG+M5tglNoKlqDb
         Kp07mFcgvZ5HYuInDWIvZSuOIXYkirYR06V54nGUDe2BlQUWii690FRYyFr2A18sair1
         ybNnNTSy33HFJiZLka0sgzev/bomB1hYbcprGgLBy3ewXEruHIZHv/LytJFdZ6zm85tW
         OHVdfBkGzjGUi9/Cv/JQha1K5jbHqVUvzOUanqd2R4KC7XWYHtDs1DPMNfRdLg/Fz/TA
         ieGg==
X-Gm-Message-State: APjAAAWSE0f8GX7qoK/RqTAZ1LbV1BOZq8pEZJG0gUCTUB+o7O1Wv2/Z
        LW0w+UaYz+DpE5l3upRYX8pDJffwL1mz/f/ynEKW
X-Google-Smtp-Source: APXvYqwKKr/ioXbZ1t9yhMEosZ189qCnWVfygTh3UApLzh5y7ENZUzRkU5DTLmB53kSzAluiFSyKOOvLoj4uJt0tv6U=
X-Received: by 2002:a05:6214:14b2:: with SMTP id bo18mr1812012qvb.72.1574813469883;
 Tue, 26 Nov 2019 16:11:09 -0800 (PST)
MIME-Version: 1.0
References: <git-mailbomb-linux-master-1cbeab1b242d16fdb22dc3dab6a7d6afe746ae6d@kernel.org>
 <CAMuHMdUoOWugmyAA3-dP=AAMYwLy7KPKpGzXwxRn_yTJugM+Ww@mail.gmail.com>
In-Reply-To: <CAMuHMdUoOWugmyAA3-dP=AAMYwLy7KPKpGzXwxRn_yTJugM+Ww@mail.gmail.com>
From:   Iurii Zaikin <yzaikin@google.com>
Date:   Tue, 26 Nov 2019 16:10:33 -0800
Message-ID: <CAAXuY3pXS9-msjLTREcm2pPtR4b47MiD1JaqXg0T9D-dPyMpGg@mail.gmail.com>
Subject: Re: ext4: add kunit test for decoding extended timestamps
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Theodore Tso <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 26, 2019 at 5:15 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> While this test succeeds on arm64, it fails on m68k and arm32 (presumably
> all 32-bit platforms?):
:(
Reproducible on i386 too.
Sending the patch to fix it.
