Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F375B1431
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 07:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiIHFvt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 01:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIHFvs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 01:51:48 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9409D8FB
        for <linux-ext4@vger.kernel.org>; Wed,  7 Sep 2022 22:51:46 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id z23so18643141ljk.1
        for <linux-ext4@vger.kernel.org>; Wed, 07 Sep 2022 22:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=AT57uI6JE0+Wid00QMjw2CuLH9jS89ISmZCucf7qQKI=;
        b=GTzSJd3DTH2lTYbS6qMIIUMBiAMJia0rEOxQDUqrWPEPhoJ/trayHkvmq9LN7M4o/L
         I0vZYSQ/W3vmS3Cgkr9RyjSI5Y6hckCNVZOlSE9xKOG9V+f/63T4+rM/TS4Y3PgZtUL+
         cE1zp6LphsYzxZXfV1GFhAITcAj63HSN6tT4SPu8MLjhh4qTlrgjARmkkvnRhFXbEoQX
         TCqwA1JmThCHK9t1H8J+J+tVALWckp7NVqEut5HtuCHOp8R4K6WtbJg++miEiC8ouBqQ
         aFbfXQBXis/cG16EpIRLEmz9wlKtMaXbPMYOtQVaz+16ePnCHep0YNWMPA+eE5BvkrJD
         DYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=AT57uI6JE0+Wid00QMjw2CuLH9jS89ISmZCucf7qQKI=;
        b=IkHMg1vbUwmOPGyk2FdxStioBJ+2IiZkEy6YCD0/RH+eR7SRchGt817X2BLj7wE0ta
         LUs9wozLy3Skc6yjtWF5VXqECzER5WpKpoHywx6Pw5/NlwlgIsylZ/TjW1+yVNM70ViU
         Sz362u0pYvFnKGQUyVDl3PYtOWhOnQJtjESabHra46sPGE/l/nuoCmJORDb0b+xnGHbw
         Fe8xqyzTzeQ1h/5Sx0niJN/rtjjm8J7s5OP1b/g0k6lsjH35Cx+gnt1xPa7JnCtvkf6w
         PFr0nXs88+cHexCxR70i9dJPkn5QwvoleCD0AFKE6NifYUjgFHcjippTiJvtYjZ4ff2L
         wSwQ==
X-Gm-Message-State: ACgBeo3NFMLjNBcraww2IQ7jLkv7cCMGQFkdvrilBQd5/xgL9LA5Dt2j
        VceaHsdLOEqLB0EZcLfX6QY=
X-Google-Smtp-Source: AA6agR7o3knF3UIxQwo/dhvArp4XC2KsWVRDDpl0qcjDTdE5GQnmAs+WYfP2GHFzcdYWc7axMPZ1QQ==
X-Received: by 2002:a2e:994f:0:b0:26a:ce85:ad98 with SMTP id r15-20020a2e994f000000b0026ace85ad98mr1737873ljj.481.1662616304698;
        Wed, 07 Sep 2022 22:51:44 -0700 (PDT)
Received: from smtpclient.apple ([46.246.26.67])
        by smtp.gmail.com with ESMTPSA id m11-20020a05651202eb00b0049313f77755sm2863697lfq.213.2022.09.07.22.51.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Sep 2022 22:51:43 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] jbd2: wake up journal waiters in FIFO order, not  LIFO
From:   Alexey Lyahkov <alexey.lyashkov@gmail.com>
In-Reply-To: <20220908054611.vjcb27wmq4dggqmv@riteshh-domain>
Date:   Thu, 8 Sep 2022 08:51:40 +0300
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>,
        Andrew Perepechko <anserper@ya.ru>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B32B956C-E851-42A2-9419-2947C442E2AA@gmail.com>
References: <20220907165959.1137482-1-alexey.lyashkov@gmail.com>
 <20220908054611.vjcb27wmq4dggqmv@riteshh-domain>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ritesh,

This was hit on the Lustre OSS node when we have ton=E2=80=99s of short =
write with sync/(journal commit) in parallel.
Each write was done from own thread (like 1k-2k threads in parallel).
It caused a situation when only few/some threads make a wakeup and enter =
to the transaction until it will be T_LOCKED.
In our=E2=80=99s observation all handles from head was waked and it=E2=80=99=
s handles added recently, while old handles still in list and
It caused a soft lockup messages on console.

Alex


> On 8 Sep 2022, at 08:46, Ritesh Harjani (IBM) <ritesh.list@gmail.com> =
wrote:
>=20
> On 22/09/07 07:59PM, Alexey Lyashkov wrote:
>> From: Andrew Perepechko <anserper@ya.ru>
>>=20
>> LIFO wakeup order is unfair and sometimes leads to a journal
>> user not being able to get a journal handle for hundreds of
>> transactions in a row.
>>=20
>> FIFO wakeup can make things more fair.
>=20
> prepare_to_wait() will always add the task to the head of the list.
> While prepare_to_wait_exclusive() will add the task to the tail since =
all of the
> exclusive tasks are added to the tail.
> wake_up() function will wake up all non-exclusive and single exclusive =
task=20
> v/s
> wake_up_all() function will wake up all tasks irrespective.
>=20
> So your change does makes the ordering to FIFO, in which the task =
which came in=20
> first will be woken up first.=20
>=20
> Although I was wondering about 2 things -=20
> 1. In what scenario this was observed to become a problem/bottleneck =
for you?
> Could you kindly give more details of your problem?
>=20
> 2. What about start_this_handle() function where we call wait_event()=20=

> for j_barrier_count to be 0? I guess that doesn't happen often.
>=20
> -ritesh
>=20
>=20
>>=20
>> Signed-off-by: Alexey Lyashkov <alexey.lyashkov@gmail.com>
>> ---
>> fs/jbd2/commit.c      | 2 +-
>> fs/jbd2/transaction.c | 6 +++---
>> 2 files changed, 4 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
>> index b2b2bc9b88d9..ec2b55879e3a 100644
>> --- a/fs/jbd2/commit.c
>> +++ b/fs/jbd2/commit.c
>> @@ -570,7 +570,7 @@ void jbd2_journal_commit_transaction(journal_t =
*journal)
>> 	journal->j_running_transaction =3D NULL;
>> 	start_time =3D ktime_get();
>> 	commit_transaction->t_log_start =3D journal->j_head;
>> -	wake_up(&journal->j_wait_transaction_locked);
>> +	wake_up_all(&journal->j_wait_transaction_locked);
>> 	write_unlock(&journal->j_state_lock);
>>=20
>> 	jbd2_debug(3, "JBD2: commit phase 2a\n");
>> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
>> index e1be93ccd81c..6a404ac1c178 100644
>> --- a/fs/jbd2/transaction.c
>> +++ b/fs/jbd2/transaction.c
>> @@ -168,7 +168,7 @@ static void wait_transaction_locked(journal_t =
*journal)
>> 	int need_to_start;
>> 	tid_t tid =3D journal->j_running_transaction->t_tid;
>>=20
>> -	prepare_to_wait(&journal->j_wait_transaction_locked, &wait,
>> +	prepare_to_wait_exclusive(&journal->j_wait_transaction_locked, =
&wait,
>> 			TASK_UNINTERRUPTIBLE);
>> 	need_to_start =3D !tid_geq(journal->j_commit_request, tid);
>> 	read_unlock(&journal->j_state_lock);
>> @@ -194,7 +194,7 @@ static void wait_transaction_switching(journal_t =
*journal)
>> 		read_unlock(&journal->j_state_lock);
>> 		return;
>> 	}
>> -	prepare_to_wait(&journal->j_wait_transaction_locked, &wait,
>> +	prepare_to_wait_exclusive(&journal->j_wait_transaction_locked, =
&wait,
>> 			TASK_UNINTERRUPTIBLE);
>> 	read_unlock(&journal->j_state_lock);
>> 	/*
>> @@ -920,7 +920,7 @@ void jbd2_journal_unlock_updates (journal_t =
*journal)
>> 	write_lock(&journal->j_state_lock);
>> 	--journal->j_barrier_count;
>> 	write_unlock(&journal->j_state_lock);
>> -	wake_up(&journal->j_wait_transaction_locked);
>> +	wake_up_all(&journal->j_wait_transaction_locked);
>> }
>>=20
>> static void warn_dirty_buffer(struct buffer_head *bh)
>> --=20
>> 2.31.1
>>=20

