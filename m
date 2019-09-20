Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2888EB935A
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2019 16:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393043AbfITOqd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Sep 2019 10:46:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390979AbfITOqd (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 20 Sep 2019 10:46:33 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7ABA20C01
        for <linux-ext4@vger.kernel.org>; Fri, 20 Sep 2019 14:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568990793;
        bh=9KvqGZWZHqe7utK0/zKU+G9jJ5bZWTajC16scgEKdXY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E2qvdZciJTOkuzH5AN3o+Pg2na+BJj9oIW1zUzLteDTgX4Ywc99dKURg+ppoNBvPj
         brpCQyfKQ4e+cA6QnjyK2dwt5Pq+u7ebq8iMu9wMTme5XnesNd94hPzYBMRJmeDwGT
         cvD/4GgMcM3jsgLLTWUfNnhfYrHrxIkGSQKHDMT4=
Received: by mail-wm1-f46.google.com with SMTP id y135so9748049wmc.1
        for <linux-ext4@vger.kernel.org>; Fri, 20 Sep 2019 07:46:32 -0700 (PDT)
X-Gm-Message-State: APjAAAXwTR18hDx4OuJtb20x0OBlXzfdjoyWXeQ0LdjTdXvdYyTeYjIg
        f+aCHYsH09mOfe6fBKpqrrk7LWIehsRrtC2h8ATx9w==
X-Google-Smtp-Source: APXvYqzi2F3mb9UuroEXoe+2WVfgT+1UiPiDEDpH8NFT3s3jHKNvuKWQMPj6DYUanuqSrmX13b1sbBdFlEUEKUgBuWQ=
X-Received: by 2002:a1c:3803:: with SMTP id f3mr4123444wma.161.1568990791254;
 Fri, 20 Sep 2019 07:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568990048.git.luto@kernel.org>
In-Reply-To: <cover.1568990048.git.luto@kernel.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 20 Sep 2019 07:46:19 -0700
X-Gmail-Original-Message-ID: <CALCETrWeWQeotMXbY2yKOmWbhW7HZLYdFBUVcFy3vCmSnm+9Sw@mail.gmail.com>
Message-ID: <CALCETrWeWQeotMXbY2yKOmWbhW7HZLYdFBUVcFy3vCmSnm+9Sw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Rework random blocking
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Theodore Tso <tytso@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 20, 2019 at 7:36 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> This makes two major semantic changes to Linux's random APIs:

Hmm.  I have at least two issues in here that need fixing:

 - getrandom() can warn.  Whoops.

 - Repeatedly calling getentropy in GRND_INSECURE mode will interfere
will CRNG init.

v3 will fix these issues.
