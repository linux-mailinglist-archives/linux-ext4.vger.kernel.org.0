Return-Path: <linux-ext4+bounces-9683-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1705CB37959
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Aug 2025 06:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBE8936638F
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Aug 2025 04:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188B22C0F9C;
	Wed, 27 Aug 2025 04:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="W1G8j+C2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9F626E706
	for <linux-ext4@vger.kernel.org>; Wed, 27 Aug 2025 04:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756270631; cv=none; b=cI9QRU0fWEOc5wMVGFUqA6LHayYcjBSH4Y5usq74/HuvKm5SgZxTgTmVEt6KiP/PxvZZp1xpSedMNryxcQWPnh2zRf76ne3uFSTxdPZMttklHVYIwjmvFF7A5Vk3CHavr2jaUg6r1l4ucPa/lOTo7Vvj71oSs0lhhHUBWsjd2Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756270631; c=relaxed/simple;
	bh=YFgitVI1mod+1pOrQ//keAVey0bcVb6xMPZF+h8Nox8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JCkZc3dvG64Lxb+c8HlUpt3bcnli3QI4/sqc/sfe0JlQh0kHD5nQBOQIbd/juDw2gyD577X/Or5P7wAamTWjJ+Kni4iK+fUe177ciYDPnnHm+ntdNXtzt0Zy4VjGanpj04ApB1HDzuNf5OWeJsFJUgIFlHuS5doAUavkxmqhaM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=W1G8j+C2; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b49dcdf018bso2236079a12.0
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 21:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756270629; x=1756875429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWrnD7vTgXVERhTWDmZq09cBexK09wZndsoZC040TbQ=;
        b=W1G8j+C2hzluIy0/vuPKEFWzkTXLQ8HyL1Vej8lsQY6XA3wIWBNMCFdagYofhyxyxR
         +roctGqKnieinS2bvAt/LJSLumPlOJ8eL7kSW7TnO4LKvqhJmktGVkFYaPIl9wyeFHRe
         Vao0+fSx9SgGriCrDn3W+jNZC9jb64xA1LyrVt4y9D/xnzaQv0gMdvt4byeoPgo0ujOm
         Vh2PFL3EcKgn4IxHX6Usj/3dUzOyyQ5MuEXNFnUgnrmtyTYBFiss8bK0Vq/O3Wfeh1nE
         XNnJ3/23sC8KFNdTR2w08PgEenqQJ7/j9Hlu/9yzs6TWCBWykleU4etblY2hSuxjTsD+
         0sKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756270629; x=1756875429;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JWrnD7vTgXVERhTWDmZq09cBexK09wZndsoZC040TbQ=;
        b=sdIlwEWdx8VCq+4prODS2DUFijVqQU7nbTHm080GwvnNxq/zcwgUrla45KMwvj2T8d
         GTz8C84OjyliJNoHN2IyMYckZgYKZUfhrkdsxP7Q7tZOOtw1MRJPRpijvC4XkdGh9AM1
         5KoZJLkAe4Bi80x8Tp0gTxEE562tA7qvR3b2R+3Tx2ttbjN3fLWd7VhpLynm+QuB+I76
         gLYKvqj46AwOz4GLjcYT+KI2cl/dQrk3mtebRyrl2dGfXwpPwWqYUFX9t3V8iMYTaj1T
         AsmIIgtD9zPZg9SuCupVx4MA1s8mvjRZG8xLJPDCig7Ijc0og0zj5urja6BNIzrO3YL4
         mXIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUVfuD6Otq0KxmtRhPirPyGg8RuZ1Cdoou2R2kwPPczz9rOxndEviSESUNULQPReh5IUEwuWi2p/Tg@vger.kernel.org
X-Gm-Message-State: AOJu0YzYcEeGxTcYs7BRwqcRlAlXXNA4XyFZkzoBm5m5AfOIgicx90QQ
	6NuzlOlysC6d25c1bB4l/9tb4xgMeALZYi/bkXpaVzU1IPuMgLBGvMYEfyCvuPkH7wU=
X-Gm-Gg: ASbGncsjZZNT63RNWDMvDnMLvEUrUn/ia1gA6I4KUomOT+nnYUiYuy7vg/aFBNX9Xfo
	FFGlCg5qLCHcAGITh31J2lqkT46Fa83FIJDhRLKJ8RhFZ4pjDvCAUOvW55wynaeQcOODpZQM62D
	LeUQroC1oxhJMXCmWaaDKr78mBEb1uc0jYpYaReG2m2BIHGpGr4025sixNIGk8QGV0L6dIyqMh9
	jedqdgEFbn5Pwqyf2HpqgnC0OGt3q/N0dXSIAmGcdAXjOZAsQIAbfKgXl9iOh/YWPg7wr1M0whP
	qGmjXnocsPxGx8yBdEA2RsdqhUVoa3yFuYHwioPHVhLh7eMin3Tcjgp4nIlsjAQRXlxIxfr/kB0
	+3NK/+FiyUMoO6Q3P5zNPkjyMtojxA6PVlkuh1VKkhQZnd2R+XXyYJ4bXf4k2NuEnHtE4jLgCLg
	==
X-Google-Smtp-Source: AGHT+IHSe1Wv6Qz1TSENPdlqYPQSplPk0LI9/BKyVhDPbtz6nTy4gnj0To/q8iyRtd7nnX8d+6wXdA==
X-Received: by 2002:a17:903:11c9:b0:235:f143:9b16 with SMTP id d9443c01a7336-2462ef73b86mr242112075ad.41.1756270628533;
        Tue, 26 Aug 2025 21:57:08 -0700 (PDT)
Received: from [10.88.210.107] ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2487beb7ed2sm23360825ad.55.2025.08.26.21.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 21:57:08 -0700 (PDT)
Message-ID: <234ea0c7-601c-4262-9381-a26129d6b457@bytedance.com>
Date: Wed, 27 Aug 2025 12:57:04 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH] jbd2: Increase IO priority of checkpoint.
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linux-ext4@vger.kernel.org
Cc: tytso@mit.edu, jack@suse.com, yi.zhang@huawei.com
References: <20250825125339.1368799-1-sunjunchao@bytedance.com>
 <877byprefg.fsf@gmail.com>
From: Julian Sun <sunjunchao@bytedance.com>
In-Reply-To: <877byprefg.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/8/27 04:55, Ritesh Harjani (IBM) 写道:
> Julian Sun <sunjunchao@bytedance.com> writes:
> 
>> In commit 6a3afb6ac6df ("jbd2: increase the journal IO's priority"),
>> the priority of IOs initiated by jbd2 has been raised, exempting them
>> from WBT throttling.
>> Checkpoint is also a crucial operation of jbd2. While no serious issues
>> have been observed so far, it should still be reasonable to exempt
>> checkpoint from WBT throttling.
>>
> 
> Interesting.. I was wondering whether we were able to observe any
> throttling for jbd2 log writes or for jbd2 checkpoint?
> Maybe It would have been nice, if we had some kind of data for this.

Good idea. But AFAICS wbt lacks of such a obversation mechanism now..>
> BTW - does it make sense for fastcommit path too maybe for non-tail
> fc write requests? I think it uses ext4_fc_submit_bh().

Yeah, I think so.
After a rough check of the code, the following code paths may result in 
high latency or even task hangs:
   1. fastcommit io is throttled by wbt or other block layer qos policies.
   2. jbd2_fc_wait_bufs() might wait for a long time while 
JBD2_FAST_COMMIT_ONGOING is set in journal->flags, and then 
jbd2_journal_commit_transaction() waits for the 
JBD2_FAST_COMMIT_ONGOING bit for a long time while holding the write 
lock of j_state_lock.
   3. start_this_handle() waits for read lock of j_state_lock which 
results in high latency or task hang.

Hi, Jan, please correct me if I'm missing anything.
> 
> -ritesh
> 
> 
>> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
>> ---
>>   fs/jbd2/checkpoint.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
>> index 38861ca04899..2d0719bf6d87 100644
>> --- a/fs/jbd2/checkpoint.c
>> +++ b/fs/jbd2/checkpoint.c
>> @@ -131,7 +131,7 @@ __flush_batch(journal_t *journal, int *batch_count)
>>   
>>   	blk_start_plug(&plug);
>>   	for (i = 0; i < *batch_count; i++)
>> -		write_dirty_buffer(journal->j_chkpt_bhs[i], REQ_SYNC);
>> +		write_dirty_buffer(journal->j_chkpt_bhs[i], JBD2_JOURNAL_REQ_FLAGS);
>>   	blk_finish_plug(&plug);
>>   
>>   	for (i = 0; i < *batch_count; i++) {
>> -- 
>> 2.20.1

Thanks,
-- 
Julian Sun <sunjunchao@bytedance.com>

