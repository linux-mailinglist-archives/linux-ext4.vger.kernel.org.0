Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C951B2709
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Apr 2020 15:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgDUNCz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Apr 2020 09:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728866AbgDUNCy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 21 Apr 2020 09:02:54 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4182C061A10
        for <linux-ext4@vger.kernel.org>; Tue, 21 Apr 2020 06:02:52 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id k133so11896407oih.12
        for <linux-ext4@vger.kernel.org>; Tue, 21 Apr 2020 06:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KeatBysOs4g1w9ucJik06kMFsqtbBYNKB2LJi34r5/g=;
        b=ZEHK3zuTVFYNcFuYOAgxTYB5atjiPGX1lleSsfDtvhignUa7fXzs6WpktzR/OAVEGc
         8E1uyGgs3LDOOXc9qAnO0YfOfqcefQ0zM0EsxYkHnrO9Vimg1IYDc6wS9LWjTHf5ERWR
         nL+zBcQ57ReI1KIsOr4yD8DEpcD17YWO2UH3Zuy2GfokaHahgq5LDJ0qoaSrz408loCy
         o34nyylhNIzvvTfjUW1vstzHutbCavTyktxKpSkL1KZuaVaEUwLhEezSih6ycNwuMmie
         RP4kvXAfsYlrZ5pxQahkOhx5t+2D+DWKRNGNiEhW7iAV9LcHogVirvt6RpdWnfvwwrq3
         iJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KeatBysOs4g1w9ucJik06kMFsqtbBYNKB2LJi34r5/g=;
        b=gCQZyspAIBqOzBa4BEpAq5xghEYE3AnP38H6uor7EsTzSvOeKokn5kFjMYlINA8HbU
         eRbjB9R/DS8z6F2plorO++btjZ6RV8fxOKZwAltXZ2npDjwQFykzja56QlE4oAE0Kw0Y
         Fig1Mk7mBS0LZ2muq2XxFJznzcSW6422pF4XsQsXex5hcoMAEQwdD8+HzsL0AACCCXj+
         C7ZZMkmZx6v72rsGcGrtjLlS+FyTxxJcNqqT73UngAZk7NETQtiD4CLixjPVmo+AjLko
         8tKTbFCIV3EBCCtkkv97B770IQeWfk6fPshbEyXTF0kbuSnkTcgrbhQqePQmB8TvDe1x
         wO0g==
X-Gm-Message-State: AGi0PuYLVpYXALmOrf5zQbcaxpVoraRcLFQe7Oigp7ZBNOm5SPPuuHRb
        ZTZ4t0YjFPB6iRyMoDGOThTZQqa+aRyuVnPfTceoTw==
X-Google-Smtp-Source: APiQypLEdn8xTZKTZv9gRqG5Fj19mVLGqJN/fnq7VfXeiz5gV6tiXoLVzH0IzsAvypZbVip6HiFZw00aj2c/+0a/9rE=
X-Received: by 2002:aca:c751:: with SMTP id x78mr3059673oif.163.1587474172245;
 Tue, 21 Apr 2020 06:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200331133536.3328-1-linus.walleij@linaro.org>
 <CAFEAcA9Gep1HN+7WJHencp9g2uUBLhagxdgjHf-16AOdP5oOjg@mail.gmail.com>
 <87v9luwgc6.fsf@mid.deneb.enyo.de> <CAFEAcA-No3Z95+UQJZWTxDesd-z_Y5XnyHs6NMpzDo3RVOHQ4w@mail.gmail.com>
 <FA73C1DA-B07F-43D5-A9A8-FBC0BAE400CA@dilger.ca>
In-Reply-To: <FA73C1DA-B07F-43D5-A9A8-FBC0BAE400CA@dilger.ca>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Tue, 21 Apr 2020 14:02:39 +0100
Message-ID: <CAFEAcA9kktJd8EJ1VCp4a0XikPS9mxmag2GFv0NvwobubQLABw@mail.gmail.com>
Subject: Re: [PATCH] fcntl: Add 32bit filesystem mode
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Florian Weimer <fw@deneb.enyo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 21 Apr 2020 at 00:51, Andreas Dilger <adilger@dilger.ca> wrote:
> Another question I had here is whether the filesystem needs to provide
> 32-bit values for other syscalls, such as stat() and statfs()?  For
> ext4, stat() is not going to return a 64-bit inode number, but other
> filesystems might (e.g. Lustre has a mode to do this).  Similarly,
> should statfs() scale up f_bsize until it can return a 32-bit f_blocks
> value?  We also had to do this ages ago for Lustre when 32-bit clients
> couldn't handle > 16TB filesystems, but that is a single disk today.
>
> Should that be added into F_SET_FILE_32BIT_FS also?

Interesting question. The directory-offset is the thing that's
got peoples' attention because it's what has actually been hit
in real-world situations, but other syscalls have the same
potential problem too. The closest I can think of to a 'general
rule' (in terms of what QEMU would like) would be "behave the
same way you would for a compat32 syscall if you had one, or
how you would behave on an actual 32-bit host".

thanks
-- PMM
