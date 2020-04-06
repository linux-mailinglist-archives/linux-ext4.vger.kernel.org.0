Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADBE319F027
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Apr 2020 07:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgDFFgU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Apr 2020 01:36:20 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50274 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgDFFgU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Apr 2020 01:36:20 -0400
Received: by mail-pj1-f66.google.com with SMTP id v13so6029913pjb.0
        for <linux-ext4@vger.kernel.org>; Sun, 05 Apr 2020 22:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:in-reply-to:references:mime-version:content-id
         :date:message-id;
        bh=CU2Yugo0GP8rSA0D5+20VRTazpR4K/wfY10bxf3KXLw=;
        b=hRQaQFHE+WlG2EzQzvmED2YHfJET0RivmAJuzcP3p79AtKyNaw2X5fE4Gd5P0WK9hx
         xaCP8fh9TupXUJ61aOjLrjy+y2i+pjQipVZKhxRhc0Hb4jlAuCi2S0KqISu2I8WOYSO+
         icpXXqWPcdZZhNyVhADptpk80fnWsdzOfOYqv4Bt/096sG1bnQtixR8fwS1EvJEZbTYG
         0j00Sh6yX6B3hFPR425jajfho7PlPbKgQy6l1EV3amqOv2Rl1UO4yAfzhQItV36ykNR7
         4JVDYL8Ix0P5yoxNao7BjmXguJjEq9l6raHQ+mqOWQrlHVCxrrPlcTr3PWiFDZwFI7pv
         /HVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:in-reply-to:references
         :mime-version:content-id:date:message-id;
        bh=CU2Yugo0GP8rSA0D5+20VRTazpR4K/wfY10bxf3KXLw=;
        b=dkNNM7AqGnkn9Deno7SNb0uXhv58HtbIeh3bQ05hwX4sYj7OEhUAKo019Yd1PnMoCg
         l5vKnpSQS0/JHmKpbiWFNmJSfPaV9KN9pHEW6meSnJ7Vf2sECaiBu/j4KYwg+k/LJaVy
         EZb/8vWDpobxePbqO4O7QehvYxHdMq2+OSnsjKD5eu6OuAjYXQRPmHQIEeUbJoHCpLvA
         Wh3hI8IaHCR15VsS/IP6x1sYULaJ3XGfDIZd9UkJQvHCz4NDhGRwK0+oOWi9khx/Vpqc
         SVWNYb7WLbbktwlWFeH5HadGGu2wtORy9nsJNm31nt+D8vmBuBOFc/9eejKOIdek7YHf
         jytQ==
X-Gm-Message-State: AGi0PuZI6gMZdjXELxkRQPFMGM4C8HQ7dJDhlH9KbEbYL0QGaaaQ5ua0
        sD2AxzPeyTPLRkvAOaAT0L8=
X-Google-Smtp-Source: APiQypJ2h3haLQQHSgmESn0aGFULJvhzmiAYcwTleY8tQ1HEJwKNswKLp+TH/OwMIza4iS9Cm6l3rw==
X-Received: by 2002:a17:902:7896:: with SMTP id q22mr17123097pll.75.1586151378924;
        Sun, 05 Apr 2020 22:36:18 -0700 (PDT)
Received: from jromail.nowhere (h219-110-108-104.catv02.itscom.jp. [219.110.108.104])
        by smtp.gmail.com with ESMTPSA id e187sm10690233pfe.50.2020.04.05.22.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 22:36:18 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=jrobl) by jrobl id 1jLKQj-0007xb-1W ; Mon, 06 Apr 2020 14:36:17 +0900
From:   "J. R. Okajima" <hooanon05g@gmail.com>
Subject: Re: [PATCH v2] ext2: Silence lockdep warning about reclaim under xattr_sem
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
In-Reply-To: <20200225120803.7901-1-jack@suse.cz>
References: <20200225120803.7901-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30601.1586151377.1@jrobl>
Date:   Mon, 06 Apr 2020 14:36:17 +0900
Message-ID: <30602.1586151377@jrobl>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Jan Kara:
> Lockdep complains about a chain:
>   sb_internal#2 --> &ei->xattr_sem#2 --> fs_reclaim
>
> and shrink_dentry_list -> ext2_evict_inode -> ext2_xattr_delete_inode ->
> down_write(ei->xattr_sem) creating a locking cycle in the reclaim path.
> This is however a false positive because when we are in
> ext2_evict_inode() we are the only holder of the inode reference and
> nobody else should touch xattr_sem of that inode. So we cannot ever
> block on acquiring the xattr_sem in the reclaim path.
>
> Silence the lockdep warning by using down_write_trylock() in
> ext2_xattr_delete_inode() to not create false locking dependency.

v5.6 is released.
But I cannot see this patch applied.  Sad.

Anyway I am wondering whether acquiring xattr_sem in
ext2_xattr_delete_inode() is really necessary or not.
It is necessary because this function refers and clears i_file_acl,
right?

But this function handles the removed (nlink==0) and unused inodes only.
If nobody else touches xattr_sem as you wrote, then it is same to
i_file_acl, isn't it?  Can we replace xattr_sem (only here) by memory
barrier, or remove xattr_sem from ext2_xattr_delete_inode()?


J. R. Okajima
