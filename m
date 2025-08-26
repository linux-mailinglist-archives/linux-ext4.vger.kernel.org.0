Return-Path: <linux-ext4+bounces-9680-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C01B3742B
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 23:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D04BB7B6798
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 20:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CCE1DA21;
	Tue, 26 Aug 2025 21:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3tzFwcY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223D31EB36
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 21:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756242081; cv=none; b=oX82627+1n1AK7B1o992jADnolvfgDdJwgbpsfwM5JRUgFBJXhsV+mRLuSbUBnqXXGJJY7r/e+uBsYjI+Bhvfq7+YzU0CeQUXgN+EGVn0qChxy1fN8dNx0MmDLsO2F6OdcE3+a6BLe/x1+W/vonMQPggSiRZGiaoz59FQQZ6PFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756242081; c=relaxed/simple;
	bh=dhiR3F0uVrGWHP1Fwn1w/DheX4EPkQPVad8O7D7YYWM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=fCwq3gsQvejgObHSX6jeAKYqtBJXprhKDsI4KyKVADmeMf/wkfs12swWv1+HpSU0/mO+x6+diYvhN5Qjdksh6RdPzzItu68aNJ7zZGYty4K7ZYWqA4eX1ASu8z9D+pmdddjFtEduVNiUPVshnS9Mqapnf+iwDuayvvtATAPfBLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3tzFwcY; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso2723484b3a.2
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 14:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756242077; x=1756846877; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nPGNWM9HJUFsW5VzLZNJ1ojndCf3jyx5scZwtHG2tY0=;
        b=P3tzFwcYXHaqeOxztxFIrX1xKFEbTiTvCekFz3LQmU7e7ktMdev6TCmAxXxFQvL1jk
         VR/ycZ7Tc+64RlP8GsAzOYHQC9M7adib06gCNkubWMfmW63sn3QN6z0AGMaD9p0btLqf
         /3BjXPxIK6ngfOg4RkO0zdOEyZkqQ6rojkpODVIpiKyNWi7wNXKc+EeYV5Mz3FSb6AcA
         nvpD5SRCyMREP0kBNgm6TmAEH1RCLbeZjUqlYqQUIVk6k1IWYetFXNHFRVFiTrCD7N/a
         PJC51BBanhS5QNGdD55VQrvaW6JlaqJpCz6W5csY8xE1nCY6a24/3SpiFfDbLoX1zKz4
         yH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756242077; x=1756846877;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nPGNWM9HJUFsW5VzLZNJ1ojndCf3jyx5scZwtHG2tY0=;
        b=Sba2UATyxkAQvuDRzC6kH7Qk51mo2VMbNOPht8ToVcxIlrySzkSKgmI1TXqOBQRRv9
         ItkkVvaStaLlHAc1YhHSDDFD6WgUmbCoPJ66PpMf8cyKUU3R1q7S8YX6NB93cwb1RXpt
         uAHb1jMfxq/1hgDGdI8U0WJlQmen/bUgG9emc/AuBlsBapEOahZMYB9/dJxrcsbU/2vt
         7A/5p4yOy42QI2EK8GH+LNw6Xl4Fs5oHREh4eRVEYNQITXwbWXwm+IzJ/W81SBV3FrXz
         7HxLaEyl2RT91rT1UKrk8rhOHKBQqdLA9IOBAYh7wRRCcJbQSxf2+MHjuE1MC24nZ7bM
         ce2w==
X-Forwarded-Encrypted: i=1; AJvYcCXeclxEdgYAGRSwjz2g5bnupDXyzlFUPv0O8I1WTcGJn5l/hODYYIpIjSBAXNbQfCdNEJloqQS/kABx@vger.kernel.org
X-Gm-Message-State: AOJu0YzWfm2FP8I0Sn0fBzlAdJ6tSUwVWPmtJ7x+SNHmrksdMn3TY46j
	17erONpbtu35EercIrktp6c575gVWrzHsGJj4J1puQ81tcWwB5A6IF9WZKhzeA==
X-Gm-Gg: ASbGncuW6aqxza8HtcPWdi3ADFguKE+MYzA8AbcPJMdms0E6mai3LnO81xpYgNkl+Q6
	FMtrA0JRUaoIhqQoPUdQru87TmrY/Yd7YQvKJGHkt/C7zUDJd4y3h1NR1bjuQj/SxCWsHtrgfin
	5cB+iOI+r2N58RB2ng7bMJjjKmafC8Fro3upjVFWvgg/caOvz6oJs2hPXzjzgYnUGRQIjTX5BVD
	0xEl/cKzABG0pJQ/tJAUpHtnxUIoBZnlxlQFAOp2XzsB/vcYyhOsArITae3aP5xrfdU25tpJjPN
	QhZW9sMsnc65Sj7IIRcEjJq8PhQgknJ0qP9pJgqQockzoS99OOvvqE0JFqTxbsoCG7oSybW+pEb
	0LMRlY2MOG6pZqQdyPfe7Viy7
X-Google-Smtp-Source: AGHT+IEpgh+wF2Tb03+QBt0YYSf9MEkZJQjl4CmOVvc8fVZlnk+MpGxRQ724/3TeY866cu93WqBeLw==
X-Received: by 2002:a05:6a20:2446:b0:240:66:bfbf with SMTP id adf61e73a8af0-24340d2c0aemr23122143637.32.1756242077104;
        Tue, 26 Aug 2025 14:01:17 -0700 (PDT)
Received: from dw-tp ([171.76.82.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771fa791e6bsm2626462b3a.60.2025.08.26.14.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 14:01:16 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Julian Sun <sunjunchao@bytedance.com>, linux-ext4@vger.kernel.org
Cc: tytso@mit.edu, jack@suse.com, yi.zhang@huawei.com
Subject: Re: [PATCH] jbd2: Increase IO priority of checkpoint.
In-Reply-To: <20250825125339.1368799-1-sunjunchao@bytedance.com>
Date: Wed, 27 Aug 2025 02:25:15 +0530
Message-ID: <877byprefg.fsf@gmail.com>
References: <20250825125339.1368799-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

Julian Sun <sunjunchao@bytedance.com> writes:

> In commit 6a3afb6ac6df ("jbd2: increase the journal IO's priority"),
> the priority of IOs initiated by jbd2 has been raised, exempting them
> from WBT throttling.
> Checkpoint is also a crucial operation of jbd2. While no serious issues
> have been observed so far, it should still be reasonable to exempt
> checkpoint from WBT throttling.
>

Interesting.. I was wondering whether we were able to observe any
throttling for jbd2 log writes or for jbd2 checkpoint?
Maybe It would have been nice, if we had some kind of data for this. 

BTW - does it make sense for fastcommit path too maybe for non-tail
fc write requests? I think it uses ext4_fc_submit_bh(). 

-ritesh


> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
> ---
>  fs/jbd2/checkpoint.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index 38861ca04899..2d0719bf6d87 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -131,7 +131,7 @@ __flush_batch(journal_t *journal, int *batch_count)
>  
>  	blk_start_plug(&plug);
>  	for (i = 0; i < *batch_count; i++)
> -		write_dirty_buffer(journal->j_chkpt_bhs[i], REQ_SYNC);
> +		write_dirty_buffer(journal->j_chkpt_bhs[i], JBD2_JOURNAL_REQ_FLAGS);
>  	blk_finish_plug(&plug);
>  
>  	for (i = 0; i < *batch_count; i++) {
> -- 
> 2.20.1

