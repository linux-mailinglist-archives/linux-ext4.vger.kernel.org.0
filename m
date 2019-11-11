Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16A1DF7AC1
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2019 19:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfKKS1N (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Nov 2019 13:27:13 -0500
Received: from mail-lj1-f177.google.com ([209.85.208.177]:35452 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfKKS1N (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 11 Nov 2019 13:27:13 -0500
Received: by mail-lj1-f177.google.com with SMTP id r7so14895406ljg.2
        for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2019 10:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MThzuPE5GHK9HkxVsoX5XDICTVaynruuXSaosaKjcs8=;
        b=Fw0twQqHYcZerf7R7Z3mbmARQOIFlH3pXVj4Yjat2DM7woJjV+SUtLUFxaEmeBl+U5
         szMKEvHO9eLWrC8gGlF9I60PdiM4n2eVfToqoV5409n1CtsBTL3vU6t0ClyXdYIp4Xvt
         nWXLT0OSdbsl0Wx6bZ6d8xeGYVa8JX7gNAf+7micSQJLTdtOlEcyFzX48Yb1d5PPyBxL
         DefhaGvaBR5etVxoKduL7AjUCl4udWuhNJWtuhe24rPNevBh9yKJxiS6oY/UpubbNHmA
         SamzTvPY1gSEo+YFXpeKBxJxPZAYb3un85/OrkIjyB8A71lPT+Iigg7yWZpwMiCJ6xq1
         VNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MThzuPE5GHK9HkxVsoX5XDICTVaynruuXSaosaKjcs8=;
        b=MjgiCmOasBl1/Ljy+DiWXog4WJCnJDZOZ+qMbHVXe3xv8r7x7YDMgjCSajTn/F0md5
         QwP5xHacELPqkfz+gwtT2hswHeXcaatC+T+DnnhNF/XE+8fVgqftteFldjFyOkl80rB6
         EOPEm7y0LalGQhzpNg5yc83K840U06Ie1gt/cDgvnQIXyCumVUkTRmBZHn4RuS4f2X37
         zFx9peQ3H4sjHrAcspVErjfmXJZB41W7mteL+5RwnZKsWG74Sw+Jy1Gyy0Paw093VtGN
         ejvINCtgXueqqTN+/no1r6Vp8Ga5KEWx5u2tcQCjmp+7IK+di/EcOVoukQMJpm/+hTeK
         EQFg==
X-Gm-Message-State: APjAAAUxa5heWev2Dyp3xivRsnUPxw6BgW8f7+IMScCH+qjs46mJu4jr
        cGr6QJUB/+HWpD1PgaDNcuBCrrvy5Y00MXusd6SB0Q==
X-Google-Smtp-Source: APXvYqyWMSR5OPToEop6rDei4ILQee/UuxXH+ZjV7ZXKAeitGVZS2Lw9zm51FtgZf6Xt1NfAsveDiRmS7Mfl3wUydIw=
X-Received: by 2002:a2e:a410:: with SMTP id p16mr17228931ljn.46.1573496829912;
 Mon, 11 Nov 2019 10:27:09 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYtmA5F174nTAtyshr03wkSqMS7+7NTDuJMd_DhJF6a4pw@mail.gmail.com>
 <852514139.11036267.1573172443439.JavaMail.zimbra@redhat.com>
 <20191111012614.GC6235@magnolia> <1751469294.11431533.1573460380206.JavaMail.zimbra@redhat.com>
 <20191111083815.GA29540@infradead.org> <1757087132.11450258.1573468734360.JavaMail.zimbra@redhat.com>
In-Reply-To: <1757087132.11450258.1573468734360.JavaMail.zimbra@redhat.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 11 Nov 2019 23:56:58 +0530
Message-ID: <CA+G9fYtuwT_vkQL-RfAMcmH_HBHUWQ5ZPHdwsGoNTALhwyiZgg@mail.gmail.com>
Subject: Re: LTP: diotest4.c:476: read to read-only space. returns 0: Success
To:     Jan Stancek <jstancek@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        LTP List <ltp@lists.linux.it>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, chrubis <chrubis@suse.cz>,
        open list <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        lkft-triage@lists.linaro.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 11 Nov 2019 at 16:09, Jan Stancek <jstancek@redhat.com> wrote:
>
>
> ----- Original Message -----
> > Is this a new test?
>
> No, it's not new.
>
> > If not why was this never reported?  Sounds like
> > we should add this test case to xfstests.
>
> I'm guessing not that many users still run 32bit kernels.
> Naresh' setup is using ext4, so I assume he noticed only
> after recent changes in linux-next wrt. directio and ext4.

That's true.
Started noticing recently from Linux next-20191107 kernel on i386 and arm32.

Steps to reproduce:
./runltp -f dio -d /mounted-ext4-drive

- Naresh
