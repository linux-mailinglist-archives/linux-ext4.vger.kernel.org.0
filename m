Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9EF92DA021
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Dec 2020 20:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408937AbgLNTJI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Dec 2020 14:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408917AbgLNTIv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 14 Dec 2020 14:08:51 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C85C0613D3
        for <linux-ext4@vger.kernel.org>; Mon, 14 Dec 2020 11:08:06 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id n26so24052738eju.6
        for <linux-ext4@vger.kernel.org>; Mon, 14 Dec 2020 11:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xuR72zkNhchqQVbvXo1Nmv8jsLcpHYpwxJu9BP6CJOs=;
        b=XjNZnCoVXZnnlgKpBGOi0WS3uKEqlPClQ7qEtmkb8olrpnuP4nSN9HgL11QG+EklX6
         +TcC0x4667374m1UFDeY8sGrF5XxfnW+jiFRtztpfNna1R06NSCCO5jFQJXoSve+wnRI
         k56l5PXqeipZWUglJT6UQXXAJKYeL1zVFHS7//z+hF5YS6euYIiaCpEALEsk4sQfv+Rl
         SXURvTF5Ov7uhq/Ib09wKtWaJhdfNYeaXpiQAxfdx2nDp6yQhmNTa6bdd/d/2/EtstgX
         R6XBfvBiLg/nfhVCAR5FeG8Z6jlf9isS8nQRKq26twVZrPKGKt++riaqFUfi6xGrwjHW
         Vq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xuR72zkNhchqQVbvXo1Nmv8jsLcpHYpwxJu9BP6CJOs=;
        b=maHzghcr++0/rYMXiWybVx73TsRv18mn+tBT4DQA53QZLFe6qKU+Nqi/2FxMnK6zpd
         om1Lf2vTlee+Jxv1LQQ7HgnpyS0H24uh8xdRmcI5l4VNMsgT9I+3QxrZGa+2yb8PQwiX
         zmILurFfp175KQjzjM3W0SW5fh8I6UP3jAg/jz1Ex5DcDTuiVI2yyuHs1ZvpvES2ILlZ
         jXjPjHuACydK+lUFRgRPHUXSvIovOk6EX/5Xq+Bbx/3or/cswPgjuqBreEhYsHP8RiJ0
         sZV7wQv/IuCv6xiIAx7E2Aknbi6uRvoGlsbpsj4zLY6xfVmmp12lhNMCF4Pocfv5Q9/9
         0iCw==
X-Gm-Message-State: AOAM531rr9Y7amkzC8hZjAkx39lMjhID7CtVfMOIc7QzcrnKO2s6riBN
        Tt9xlD9q/K5R3mPm8UVFg/4fSpWt+vddHHgvNU4=
X-Google-Smtp-Source: ABdhPJzNa5xgAeJDT5xC+osNmM19MHDr8W/sGZ8FjQUIFDOICpBWDi1cfuC0y4Kwe16n3uAe0xWYMG1nkn1KSGUKyQA=
X-Received: by 2002:a17:906:4a47:: with SMTP id a7mr12968059ejv.345.1607972885062;
 Mon, 14 Dec 2020 11:08:05 -0800 (PST)
MIME-Version: 1.0
References: <20201127113405.26867-1-jack@suse.cz>
In-Reply-To: <20201127113405.26867-1-jack@suse.cz>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 14 Dec 2020 11:07:53 -0800
Message-ID: <CAD+ocbwspkmmX=G_DCETqCcKdmC-Z7HG6G6nUycW6gUB+5msLw@mail.gmail.com>
Subject: Re: [PATCH 00/12] ext4: Various fixes of ext4 handling of fs errors
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks! I ran smoke tests (-c 4k -g quick) on this series and there were no
regressions for me as well.


- Harshad

On Fri, Nov 27, 2020 at 3:37 AM Jan Kara <jack@suse.cz> wrote:
>
> Hello,
>
> this patches addresses problems in handling of filesystem errors in ext4.
> When we hit metadata error, we want to store information about the error
> in the superblock. Currently we do it through direct superblock modification
> which can lead to lost information, checksum failures, or DIF/DIX failures.
> Fix various races in the error handling so that the superblock update is
> reliable.
>
> The patches have passed xfstests for me in various configurations and some
> targetted manual testing of the error handling.
>
>                                                                 Honza
