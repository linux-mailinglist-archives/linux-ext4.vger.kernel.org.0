Return-Path: <linux-ext4+bounces-9684-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7ABB3795D
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Aug 2025 06:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 771007AF904
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Aug 2025 04:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3BE30ACE5;
	Wed, 27 Aug 2025 04:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="aGI3o5b6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A632308F3A
	for <linux-ext4@vger.kernel.org>; Wed, 27 Aug 2025 04:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756270658; cv=none; b=EETOY/AHNL30cdupti7nwXkV83PKnMwCQU3q/Q/k8oKW6+7+XGIYasd2HU2rXvCM5JGNc5mb+e2TBaD2h7K/QFLsLkmQqKPcBWb4lLJpA5d/elqbBwPN9cjP+s0Al1g8tZ94ITucwHBOPYF6xOaoQ4aZKKiiWIqlbmEC3hSboIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756270658; c=relaxed/simple;
	bh=YFgitVI1mod+1pOrQ//keAVey0bcVb6xMPZF+h8Nox8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ktuB67yK3JwF9sgV/gKuAU7eJ7aWjNHgC7Gu5I+3dKs191TKOtKXBs8ToT4mhNaRoSKKRspzQRPla002FAUCfPwKwoEpXpPkMb6nAl5dsto2/iBUbE/fLdHZ8jO8ZCMwSKWKNCHH4WMiR2HDkD6cN17Ifd7uHmrot98lRw3xaMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=aGI3o5b6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-246aef91e57so43723555ad.1
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 21:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756270656; x=1756875456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWrnD7vTgXVERhTWDmZq09cBexK09wZndsoZC040TbQ=;
        b=aGI3o5b6qDzw2/HMnhsnG8be0IU/v9LCb7Fwz/o7MIHAYmODmnm/9iUcnOXL5ez7sX
         NhgnFqgniM/0wFjePCANHQhRrM85DfanHEY5telr56iZe3zfZqdNfUpk/KH4Q+mxBQGu
         OXaHqKMwnL/Fik5/eEL5qBZtYa4JFDdN8l5dgxUBZvEamYxDmgf2/k5hModvlZo3pJcT
         zO2VtG9ZDGfy74yGZN8+NVWabzUYBh6VFHdfwiwTdEPO1SPnCrt2kN2uzISgvtVsJJ/M
         eDdldRPd+2t3Dod1htAROtDzJQ/6rqAJXrz5FOsNRd7BKF9LyHFdYPz3J2jyFmd3yH6p
         3NsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756270656; x=1756875456;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JWrnD7vTgXVERhTWDmZq09cBexK09wZndsoZC040TbQ=;
        b=ZHVXIJpTrlI+b70XOc7SR0+LvYIa0Fu4SwRuOyeIoMm/s4Z4rUwSEJB0AZIkZr54tx
         N6OkqRx5XevTbIfNoVGmloTHt+jhIbb8VGrgz7mWzAL7DVJCL+uGCr4NWkXb3AMb5ooi
         o+1dvm6Xb6iAhGyhZOUr9Fz6P9nFzeDA+U308jiOhbExd7bPGs05wBtRtsvk/dldRlYb
         47M1rVSJ6KjAHnXdy93DU9a4QHewO7fr73buTnGy5N/wzUcHejY899IVTvOK4LMloLTS
         LKq3WqkPQRfmY2GiMabOdhzllLzveDUXf8UjUTSPVbfVg936fbkn94O292qzkd5CkGMl
         FRzA==
X-Forwarded-Encrypted: i=1; AJvYcCUo7i4n1mBvtZKIg8mbFxBiOJ9yULYOaVu6ZG3LNf0v8A2B40xbBEFQag+3VtYOnzC0XVJnNGvij4J4@vger.kernel.org
X-Gm-Message-State: AOJu0YwWMDnLFtUStftuE9gF/YKT6fjEz5+inSuAq2H0UfKSfH6G9gVy
	ErrCYmXYIg7hTy9uwBYlTPxbe8cJBnI371Ke6cFJj2jJ75kJjdFkbgvwnhIv+MMOkEc=
X-Gm-Gg: ASbGncvrgWdc7n+XhutC9ulME7EqTc5RCwvsAbjnMaw0/Gy6pmlbQfNIzeKHPrbaoQ8
	wkAW4hsp+OCipRECKUPfuJnul0Vzho3FzBr9tY8ZtARkR9sSQmXgiOS8HHfoplPTZtRq52G288o
	zBMepT8dWRZ6cPOznA+3tS5GRzE7KMU5QLLgPTAXEbKH3pwpnx80rC0uHkd782S6amvrbLiPrNJ
	iB+UvlvxdnAo6J7+Jfrge69By1wV/QBzn1MRqlQT5FoFS/jYdWDm87XvArdHJ1ZzekH7VIpPy5O
	kn9R2nymd/BxsF1uAAlZXw0D7pyEMoYzP/WiHalvUPKqYcKaApAlg8/S+NBvFnFRWW33YDpthbC
	MOKXbpPU7Q3h255FgZ8gMIbJP9Kpx50T+HADoTYTNcsVeZP6+IeQ53cmIefX4dwYrUKHIa+RKoA
	==
X-Google-Smtp-Source: AGHT+IF8ROGdUstf31am1OXKjbsYoMv+Pj7FwI/9jlUsNDntB/cRoPq0V9ol+wWVGRHICgEOH9SOpg==
X-Received: by 2002:a17:903:1a08:b0:246:cfc5:1b61 with SMTP id d9443c01a7336-246cfc51d45mr113972685ad.55.1756270656264;
        Tue, 26 Aug 2025 21:57:36 -0700 (PDT)
Received: from [10.88.210.107] ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-248787e1bb2sm27644465ad.96.2025.08.26.21.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 21:57:35 -0700 (PDT)
Message-ID: <418cbbab-4046-494d-bfdf-899c3b66f5fc@bytedance.com>
Date: Wed, 27 Aug 2025 12:57:32 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jbd2: Increase IO priority of checkpoint.
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

