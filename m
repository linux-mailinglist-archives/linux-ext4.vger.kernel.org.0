Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608AD5B142C
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 07:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiIHFqU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 01:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIHFqT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 01:46:19 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232C37EFED
        for <linux-ext4@vger.kernel.org>; Wed,  7 Sep 2022 22:46:18 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so1292117pjl.0
        for <linux-ext4@vger.kernel.org>; Wed, 07 Sep 2022 22:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=gjP1/8HgkUfbFK7lgBLP283fbeCevjBt7Aw2eNcV3Bk=;
        b=H9oRarxKB93f3Uqsfs1Yju6E9s/kNDIKYJd5GcXM9Dsc7KTfpGzaSKYZl2CzzvOvDB
         XQnL9r48LhuQoQZuPdHF5M3DJs3HHWDUPg3fS/HHP7qyoLERLhyOYj6YxZVvniKo2Eqk
         uNNpbSRddBOEYNXwm6m2cu1vgWxlnl5txBwtltaMvep7NODS7dVTgf3G+UbGKmKpYGEQ
         YCrRzDp2DKafKCGW3D/+Y4E6wHF1h+fjSxV5uwUfs2Gk1ZRmdV0bLYaaTv0ygwuOAL23
         Wxs5RJQFe9GMvV7QGDYz8nrhQ2SQM2lgBW1aZxtZ8GsP9H4uhgoweBihL6CplAKh0wU+
         XZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=gjP1/8HgkUfbFK7lgBLP283fbeCevjBt7Aw2eNcV3Bk=;
        b=Q9kbnmGNBxjaCVWyUfK8xU6noNfQeltjG4ypiPR56J+ydqXgyfemVmM03w/BBeh3ch
         RdDXg5LtQ6FAgnZBxSyyZ4iUBBJ6GCUPwqeNWVMmCipRP9V871e23YhL3SIraPThyXPt
         fhfzF6R43BkbMzV3fYbMvctMPoz8h9KzJ+rpKwPXbTkG/4M8aKXHmvydZe0Fq4cLeEU4
         bDjWHR6WErgxJBxtupUWs9f7vTiXC0Sq+EjIFj2fjbn+cy5oNUzpRTdWGF1P7F1z5cnP
         Hl4FalqOQyeyY4BDpVc/dc5wlA/BSvRx0a9PEYp5FpvguzoJ5jbJGWZ3zaziuo9o2Shi
         ng9A==
X-Gm-Message-State: ACgBeo0WhP28AGfEZs90rpLxxnCL3jTMxBBQmvrpO/EM1Iw5woMKP/mb
        CmmXQlYlHGSiHglnjQDFYbr35CcMSmw=
X-Google-Smtp-Source: AA6agR7DEBjyKMw8l7sE288NGieTiFn5ML84Yvvcw0tCyh94gyakez5PNE+CStvPx96LHLAzHPEUQA==
X-Received: by 2002:a17:902:7d86:b0:176:a6eb:1758 with SMTP id a6-20020a1709027d8600b00176a6eb1758mr7720974plm.90.1662615977489;
        Wed, 07 Sep 2022 22:46:17 -0700 (PDT)
Received: from localhost ([2406:7400:63:83c4:f166:555c:90a1:a48d])
        by smtp.gmail.com with ESMTPSA id q2-20020a17090a2e0200b001fbb6d73da5sm780627pjd.21.2022.09.07.22.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 22:46:17 -0700 (PDT)
Date:   Thu, 8 Sep 2022 11:16:11 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Alexey Lyashkov <alexey.lyashkov@gmail.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>,
        Andrew Perepechko <anserper@ya.ru>
Subject: Re: [PATCH] jbd2: wake up journal waiters in FIFO order, not  LIFO
Message-ID: <20220908054611.vjcb27wmq4dggqmv@riteshh-domain>
References: <20220907165959.1137482-1-alexey.lyashkov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907165959.1137482-1-alexey.lyashkov@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/09/07 07:59PM, Alexey Lyashkov wrote:
> From: Andrew Perepechko <anserper@ya.ru>
> 
> LIFO wakeup order is unfair and sometimes leads to a journal
> user not being able to get a journal handle for hundreds of
> transactions in a row.
> 
> FIFO wakeup can make things more fair.

prepare_to_wait() will always add the task to the head of the list.
While prepare_to_wait_exclusive() will add the task to the tail since all of the
exclusive tasks are added to the tail.
wake_up() function will wake up all non-exclusive and single exclusive task 
v/s
wake_up_all() function will wake up all tasks irrespective.

So your change does makes the ordering to FIFO, in which the task which came in 
first will be woken up first. 

Although I was wondering about 2 things - 
1. In what scenario this was observed to become a problem/bottleneck for you?
Could you kindly give more details of your problem?

2. What about start_this_handle() function where we call wait_event() 
for j_barrier_count to be 0? I guess that doesn't happen often.

-ritesh


> 
> Signed-off-by: Alexey Lyashkov <alexey.lyashkov@gmail.com>
> ---
>  fs/jbd2/commit.c      | 2 +-
>  fs/jbd2/transaction.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index b2b2bc9b88d9..ec2b55879e3a 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -570,7 +570,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>  	journal->j_running_transaction = NULL;
>  	start_time = ktime_get();
>  	commit_transaction->t_log_start = journal->j_head;
> -	wake_up(&journal->j_wait_transaction_locked);
> +	wake_up_all(&journal->j_wait_transaction_locked);
>  	write_unlock(&journal->j_state_lock);
>  
>  	jbd2_debug(3, "JBD2: commit phase 2a\n");
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index e1be93ccd81c..6a404ac1c178 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -168,7 +168,7 @@ static void wait_transaction_locked(journal_t *journal)
>  	int need_to_start;
>  	tid_t tid = journal->j_running_transaction->t_tid;
>  
> -	prepare_to_wait(&journal->j_wait_transaction_locked, &wait,
> +	prepare_to_wait_exclusive(&journal->j_wait_transaction_locked, &wait,
>  			TASK_UNINTERRUPTIBLE);
>  	need_to_start = !tid_geq(journal->j_commit_request, tid);
>  	read_unlock(&journal->j_state_lock);
> @@ -194,7 +194,7 @@ static void wait_transaction_switching(journal_t *journal)
>  		read_unlock(&journal->j_state_lock);
>  		return;
>  	}
> -	prepare_to_wait(&journal->j_wait_transaction_locked, &wait,
> +	prepare_to_wait_exclusive(&journal->j_wait_transaction_locked, &wait,
>  			TASK_UNINTERRUPTIBLE);
>  	read_unlock(&journal->j_state_lock);
>  	/*
> @@ -920,7 +920,7 @@ void jbd2_journal_unlock_updates (journal_t *journal)
>  	write_lock(&journal->j_state_lock);
>  	--journal->j_barrier_count;
>  	write_unlock(&journal->j_state_lock);
> -	wake_up(&journal->j_wait_transaction_locked);
> +	wake_up_all(&journal->j_wait_transaction_locked);
>  }
>  
>  static void warn_dirty_buffer(struct buffer_head *bh)
> -- 
> 2.31.1
> 
