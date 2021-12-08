Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A965B46D5D9
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Dec 2021 15:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhLHOj5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Dec 2021 09:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhLHOj5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Dec 2021 09:39:57 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B888C061746;
        Wed,  8 Dec 2021 06:36:25 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id y12so8870673eda.12;
        Wed, 08 Dec 2021 06:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4oCIz8X6Xpr951fQV2/0BZURheht/YvLFt2PkopgfJE=;
        b=Cyhf//uI31/yt0r1WBKeFQqjck9z6NMKw8tn5j6nXohEAMsyLup6KRjtmrEOwKUVvL
         8XyGc45YrlPm1DfLNkJPldbmxKoFIxdKlYLoxoqTDClxwAxcDq8HFdHTP0rqfY1EON1A
         0zeZEqTH5rBLHhxafh9DJP4ljLqegOtluB/vLcL9mRRgHCHP8HHH7VAjWlWNNx3fxGQ0
         4mexkwuHcPBdlVMxDOfA9f977qq3+G1iUxk7IIDkYwYdeiCVOsiJPYGSI+SL453uZrk6
         AzVTh6aH3cjCYL7atemJO4Q7COuOQZhpO8Z+VHv7INAsp4suRHSPnR858V2KA6cwhCun
         9HiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4oCIz8X6Xpr951fQV2/0BZURheht/YvLFt2PkopgfJE=;
        b=ACvo/K5Gz+eU3H8ODqzPc4NCqBliHSDL1U3pFb80cAyG5qlBqg0y35yyRKvFZrX5dR
         l1YqWaR+TxbEL30dx3+Dgtb4y2j7EzYq646Q/mEXPSIKzWesI3fajbIjh45+rZ8P8A/s
         wNAKVyzpvfGZd4zTBvzj/sZOj/8DgU+lBlsB6NK0rRwTMnnraHgtv9NLq1u9BuehHU/D
         3Bhh9nhxeH3Zz/sBmmVC7Ng0Pq1zbMkR8HUqLdiUT6QY0C06C0QZLKD984vWky9P058Y
         Lv4HqK4B06FO+RUCk2EutNgwG9aB1ZU+RJzgxYwZPf87uUeNiopsWEzPhstqpge7z9AQ
         aJwA==
X-Gm-Message-State: AOAM531m63Z7b/48lpdF7pjx13Z0Vzy2ZDeOgOndnRyJywZ/6OJ8gCQW
        1+CEnTHxvBxh6ARZcArGOmed2HeuT4sNObBlxPTGbQ4WCKROmhoU
X-Google-Smtp-Source: ABdhPJwllokWo7JWP9j5GegebcD7IQmd9EWI6+Wk0gSVMJHyThfOLWZmpMPCOa7IbJPy8Q3dpgveat73HZ8lAT4sMAU=
X-Received: by 2002:a17:907:868e:: with SMTP id qa14mr8228487ejc.564.1638974181817;
 Wed, 08 Dec 2021 06:36:21 -0800 (PST)
MIME-Version: 1.0
References: <20211124110308.2053-1-urezki@gmail.com> <20211124110308.2053-2-urezki@gmail.com>
In-Reply-To: <20211124110308.2053-2-urezki@gmail.com>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Wed, 8 Dec 2021 15:36:09 +0100
Message-ID: <CA+KHdyUvoB9bbm34=fJ8oi21=r0JEYfRw9R6HQRZ1obpBnaOHg@mail.gmail.com>
Subject: Re: [PATCH 1/9] ext4: Switch to kvfree_rcu() API
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

+ linux-ext4@vger.kernel.org

On Wed, Nov 24, 2021 at 12:03 PM Uladzislau Rezki (Sony)
<urezki@gmail.com> wrote:
>
> From: Uladzislau Rezki <uladzislau.rezki@sony.com>
>
> Instead of invoking a synchronize_rcu() to free a pointer
> after a grace period we can directly make use of new API
> that does the same but in more efficient way.
>
> CC: "Theodore Ts'o" <tytso@mit.edu>
> Signed-off-by: Uladzislau Rezki <uladzislau.rezki@sony.com>
> ---
>  fs/ext4/super.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 4e33b5eca694..111b0498a232 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1886,8 +1886,7 @@ static int clear_qf_name(struct super_block *sb, int qtype)
>                 return -1;
>         }
>         rcu_assign_pointer(sbi->s_qf_names[qtype], NULL);
> -       synchronize_rcu();
> -       kfree(old_qname);
> +       kvfree_rcu(old_qname);
>         return 1;
>  }
>  #endif
> --
> 2.30.2
>


-- 
Uladzislau Rezki
