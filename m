Return-Path: <linux-ext4+bounces-1791-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1EE8928E3
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Mar 2024 03:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF7FF1F2201B
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Mar 2024 02:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E2A46B8;
	Sat, 30 Mar 2024 02:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsygBTUA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B5A1860;
	Sat, 30 Mar 2024 02:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711765021; cv=none; b=AFQvtw7IlqCLxQELiPkeGpRIJyYuro+33jpWyLUALL4TP0pItvma//1Q7av9mFzAcMve1JQMRx9g/k1xUIPNvw7twkxySPUMIUGof+1if5UO/gu7lONd0DBH4V1Z0fqUM3Sy4Asw4Ql3VEfoXsIgM0jGdZ8URz40AwKnlJxuCNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711765021; c=relaxed/simple;
	bh=fQWCvuCOvyxi0v02XJRPfc+KD/6czuElXo5sHXKVIkk=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=IV2X1xmrMjP79++o5sZsWZ4wFkK7DPwgiWrnnHPWpbIYrDl1XR3rrcA7qSe12I66sAFUjy/RqtaOWoEfvicdgj0MZCaRMyq2/SxabYmeoiUBws8tfPcvTQpzApBEHbrH+DYFXEv50JdrSelTdGmdeXcznnSqLkE9n3uhkyrQvps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsygBTUA; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5e152c757a5so1504871a12.2;
        Fri, 29 Mar 2024 19:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711765019; x=1712369819; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nwo1ZLrAwSsaE5E6meyaZk2gLpGnAbw98pCerINhLsQ=;
        b=jsygBTUAQo7b9UH15xITe6o4aPqXMO6AMLgrLhZuvjkjnLaI1IrS7ogseQrST7aGuR
         gpQF7PCBI7P38oDkNZ1StISii661CZUojkq9lix/Aul7n945B6R+iD5k/dB19LM/ciP0
         DnFc+HvbKHF5vb0A0LF4fjE79obi+OiR5xri/TDDv/GxmwOgZU4QVkfctDy2jlF1uVdD
         87V15M7jLQjeu9gSgLXbyr4bXAULNeC11hnHD4NldMP7RdGvp6WDd2ZMT8ZytnO+mAoL
         dCmYh9mmS2kVDajnFizNvjo3lUiD7Yr3Lx3VTNS/NMIZeTmANaWxLTJLdZ6/9f6vk8xq
         iWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711765019; x=1712369819;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nwo1ZLrAwSsaE5E6meyaZk2gLpGnAbw98pCerINhLsQ=;
        b=N8KvnUNEuqUpG7cu/Qg2SCf3XLabR828V43YMGAlybeOWKeQ7XeAbFKBWO5jAaknlk
         8+MKfQBbSVqlxrHtU+ITZsV1s2G50FuqnH8N0Lnd3oOMeiTwqq4sfWZBBhqgEFZWKeTt
         9rGnQ4LkC/Y9i8ynFeXQ8CRLZcZQHZgDV+0QaIWo9VdUQoNyiLT+aCz6HB6gh6JFkDsP
         sWVgDE06Zw+RjpPpX1Tr9oN5iV58mMqKyIbZnA+Bq8jmRQFU2d8hIscUqZ7jIh2bcZAp
         gRiAcy60v6sEYOX9XCjIVd3xYiKuX5fcvzX0kK7x5B8q1T/iI+iPCQ52tDI9kiwWIlw5
         NgFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2KDRPF2kRL6RIFxP/tzXI/2hrDGUH02ej0uwtKclH0Ha0yL3Ku5ibOWPSaP1PBeCuj9lBovrIVF/wvV4wX8J2Hqu/gz/2bhSj0bqsi9mbBc28qO93HJCNOgZjI74StV4jrNcvbKUZmA==
X-Gm-Message-State: AOJu0Yy1niDRzYprsaIJ5rWcVsCLBWLemTF7LZiTl/SpsS1DDwPmNRo5
	Lk8svlrEa4gvusmPtYzcJoLsa8W/gxN+4GE8K+fm1x+SJ711Mt/9
X-Google-Smtp-Source: AGHT+IGw/ItCtbnbMUHQ3NCtwQVacxQKM82yWYLj8ecyLWf0N5RhlUtr68YgHLH3g/LvAtKTCp/fcw==
X-Received: by 2002:a05:6a20:d904:b0:1a6:fe58:ee8e with SMTP id jd4-20020a056a20d90400b001a6fe58ee8emr2841116pzb.51.1711765018795;
        Fri, 29 Mar 2024 19:16:58 -0700 (PDT)
Received: from dw-tp ([171.76.85.110])
        by smtp.gmail.com with ESMTPSA id u9-20020a170903124900b001e0f55082ebsm4141634plh.56.2024.03.29.19.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 19:16:58 -0700 (PDT)
Date: Sat, 30 Mar 2024 07:46:45 +0530
Message-Id: <87h6goqx9u.fsf@gmail.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Mikhail Ukhin <mish.uxin2012@yandex.ru>, Theodore Ts'o <tytso@mit.edu>
Cc: Mikhail Ukhin <mish.uxin2012@yandex.ru>, Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, Michail Ivanov <iwanov-23@bk.ru>, Pavel Koshutin <koshutin.pavel@yandex.ru>, Artem Sadovnikov <ancowi69@gmail.com>
Subject: Re: [PATCH] ext4: fix semaphore unlocking order
In-Reply-To: <20240328143301.6432-1-mish.uxin2012@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

Mikhail Ukhin <mish.uxin2012@yandex.ru> writes:

> Fuzzing reports a possible deadlock in jbd2_log_wait_commit.
>
> The problem occurs in ext4_ind_migrate due to an incorrect order of
> unlocking of the journal and write semaphores - the order of unlocking
> must be the reverse of the order of locking.
>

Maybe we should update the subject msg to:
      "ext4: "fix i_data_sem unlock order in ext4_ind_migrate()"

and also should add:
    CC: stable@vger.kernel.org


I think this should have been fixed in patch [1], but looks like it
forgot to fix the unlock order.

[1]: https://lore.kernel.org/all/1364801462-13120-1-git-send-email-dmonakhov@openvz.org/


> Found by Linux Verification Center (linuxtesting.org) with syzkaller.

I am not sure if there is an easy reproducer. If yes, we should consider
adding it in fstests.

>
> Signed-off-by: Artem Sadovnikov <ancowi69@gmail.com>

Thanks for fixing it. With above changes to subject and CC tag, this
looks good to me. Feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

> ---
>  fs/ext4/migrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
> index d98ac2af8199..a5e1492bbaaa 100644
> --- a/fs/ext4/migrate.c
> +++ b/fs/ext4/migrate.c
> @@ -663,8 +663,8 @@ int ext4_ind_migrate(struct inode *inode)
>  	if (unlikely(ret2 && !ret))
>  		ret = ret2;
>  errout:
> -	ext4_journal_stop(handle);
>  	up_write(&EXT4_I(inode)->i_data_sem);
> +	ext4_journal_stop(handle);
>  out_unlock:
>  	ext4_writepages_up_write(inode->i_sb, alloc_ctx);
>  	return ret;
> -- 
> 2.25.1

