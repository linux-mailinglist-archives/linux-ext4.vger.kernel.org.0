Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BB44761FC
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Dec 2021 20:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhLOTlZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Dec 2021 14:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhLOTlZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Dec 2021 14:41:25 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F24CC061574;
        Wed, 15 Dec 2021 11:41:24 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b40so45141359lfv.10;
        Wed, 15 Dec 2021 11:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kC5hssZfuoqKQFOl0IRNjLPgt4ZvJbJLqKLSmIpMcYw=;
        b=J1dW9Nitupl96gsJeQ1DDiPCWRUqZgUXxF0+A+FUZzfBUcTSEMQjKGSQj5tKAjYUTO
         N6NjY53M2T2I7vFKpnmoSut7L9mLo0shhC4XzWuhnhu0JaEoSA9EK+r6AZY6pldAeKs0
         mHEYeNuEmzZu0OZY47x90bL0uRnS8rK2m9sc2FYU+bN47JGvYYNe1LxYiGMW/9gddHc5
         CjU0XDV13W+jXkHiCKQo0RCAhP0Stw7hLAZT9O9nT0dI5OT5sVQQZ/AQbFuCr0nBb/7K
         Z2hrv0ViovkYbveWa8VPY+wdk0VCgbqnXOsAg9v18t/Xqe/8FyIkLkYY14bagkuzfxz5
         PB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kC5hssZfuoqKQFOl0IRNjLPgt4ZvJbJLqKLSmIpMcYw=;
        b=lgZl8VtQj+1XRYpCh6DeS1L7frLIRMMr8xxhRw6bb2xy0c7j6l3OK+KMbqKrq0l9vO
         Te2P/0r18BYF3GtFONh9aK2rJ6vJvsjjlxXYLUP41GzlPbqeOSPwP2EtQ/tIlghgC85R
         D7UKX/ktCPXlH6mmMtIw4Nd4T2W0FfXfrpIfSD7GNsDkEJZ8aWxmD3tz3iP87iMMYcBs
         2GBibFMHH0MjS1tY6XQKgdp/0ffI2M6lbyy+qJwTJMIerDYMAXmFQDdwjUlHnC1EO1yH
         iUN4zrwenx9/lcBnV1Ar/qwveHmaDbIvutMabJh5tlUGxuNri4kbzM5xJ40cuK79MEUb
         x9ZQ==
X-Gm-Message-State: AOAM530x7sAuAdDcKIXaTqoeN9kBggUxYTckzciu/CAUihySX2UzQX1M
        HcAVtiHm2SiWzhnQfvLDIsI=
X-Google-Smtp-Source: ABdhPJz4XmxZm2vwudyDVD7pkEndYczLrZjTupCg8nmjNpQObzp+Ft4IXjgLZ9BlbnY9fTk8yHwVGw==
X-Received: by 2002:a19:6557:: with SMTP id c23mr11065671lfj.617.1639597282903;
        Wed, 15 Dec 2021 11:41:22 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id a1sm464681lfc.92.2021.12.15.11.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 11:41:21 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 15 Dec 2021 20:41:18 +0100
To:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>
Subject: Re: [PATCH RESEND] ext4: Switch to kvfree_rcu() API
Message-ID: <YbpE3uOu3ur/X5L4@pc638.lan>
References: <20211215111845.2514-1-urezki@gmail.com>
 <20211215111845.2514-3-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215111845.2514-3-urezki@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Dec 15, 2021 at 12:18:39PM +0100, Uladzislau Rezki (Sony) wrote:
> From: Uladzislau Rezki <uladzislau.rezki@sony.com>
> 
> Instead of invoking a synchronize_rcu() to free a pointer
> after a grace period we can directly make use of new API
> that does the same but in more efficient way.
> 
> TO: "Theodore Ts'o" <tytso@mit.edu>
> TO: linux-ext4@vger.kernel.org
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
>  		return -1;
>  	}
>  	rcu_assign_pointer(sbi->s_qf_names[qtype], NULL);
> -	synchronize_rcu();
> -	kfree(old_qname);
> +	kvfree_rcu(old_qname);
>  	return 1;
>  }
>  #endif
> -- 
> 2.30.2
> 
+ "Theodore Ts'o" <tytso@mit.edu>
+ linux-ext4@vger.kernel.org

--
Vlad Rezki
