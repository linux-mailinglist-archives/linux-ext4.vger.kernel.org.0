Return-Path: <linux-ext4+bounces-9691-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E03B381C0
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Aug 2025 13:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73ED89814F6
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Aug 2025 11:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1AA2F3611;
	Wed, 27 Aug 2025 11:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QGwHXKNW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418661EDA09
	for <linux-ext4@vger.kernel.org>; Wed, 27 Aug 2025 11:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756295641; cv=none; b=ClVWspT5Xy/1zlkuMOsEcnuaTiafUow9xHTzchUft+pYt9W23CurPGXB5y13Ox+lO0ftV0nLv9GsPn+1v0+3RGZFN7/Q292qnkk1ldZqd+jwWpNKNFEk4RCuH7gx71Z3yh5cMPjrAmI1ayIMZd2E7ByVujzffdVL7FSPsSzumUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756295641; c=relaxed/simple;
	bh=FdSJI+1r1IkYikdA6gHoDLOHiR2shcVeIdhv+YJnghA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G9DFg3SgTU91gQrWFrlr/lQloY59u4tjsplFaG8p2iGY7mr+X8if4R8Dd4H74sE0ct9KO0/KkXlU7EBG2bIV0SAGUCqp7n5IE8VfD9DIVNgF4TCM5SOBeJmP/c2mKxiYaaxOfKs2P3WOIJ2Jhy3MfXqs4iYENRa4AyUXn8uRIc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QGwHXKNW; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-770593ba164so3073838b3a.3
        for <linux-ext4@vger.kernel.org>; Wed, 27 Aug 2025 04:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756295638; x=1756900438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7eumiJJ/tmspXooWFZi0Ctwyz0M2e1H9u7mUSej35Us=;
        b=QGwHXKNWX/md9F9AwujHpUd6coVAXVOORJVH6iTaeADGI22jdzdUVQQyme8xCK3jmV
         9UoSZcg6mss6o6VYbXWBDqw8SMaAI5lC8luPZbd0oEsiqJi6bXKZV6K5PO1w8ERcziY4
         EwU8rIiRByw0akyl/X63evBnK1ryoJAvDPfIN7lspSUtXAKduKYIxBPrCY0RTuH6k9XM
         sxfhFa6VYzzakd3YDKhPSEBQ+9Z+FzHvy2BSsTZ16f9DHkWdJzauWB0sWM43CIniYnr9
         670VzmuPyL3/UT1ig64GHmfH8Qvkl2ItgaR0UjpxDbKyvkAHbT9n2pOmq+iJ784GrR/c
         FU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756295638; x=1756900438;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7eumiJJ/tmspXooWFZi0Ctwyz0M2e1H9u7mUSej35Us=;
        b=PlEz/el0qD0d4OoaGCJbjFbBP+MycjOfqQivaObkgm8S1Poad0v5ZWrbEByy5GnGNO
         jmQ48gkXT3uiNSJCffDkj5L8v6YzUvELXcjDcCiFiR1jRfcyb07Iyindpp5mxpkpIVfF
         eXGrVLXgOwE1Oe3Sxuzq8uPVjmueqvrKpm2kwxsi7C2joehMqleT2g9zVWeqQgjHfuuc
         PQqW8wGesfr73ApZg8WvR+0KVuDslEasM38xwLp4HJR++9RcrZkSVoyCTtukjZl2dRLz
         X+nMbU32K2w+DrgbTgBDkY3VUVuCR+BDHY47GmB3NF21vQCBRvqewjDMztWVN1ZSE8qD
         hgZw==
X-Forwarded-Encrypted: i=1; AJvYcCV/FeaEHVvYd7cYWL9wx9q1Qu4/fuv3TzTut6vrI12j8Lf093LSNftOg6bH+QUJBuHVQHnWW0QuirQX@vger.kernel.org
X-Gm-Message-State: AOJu0YykGFsRp0C6iuWBLSng1iHgr3JYsKV93bmFoTcpEOol2sIUtwTs
	5bXBNkyXcMLpNfVdIr23bUIyLSoGJEPP9Wo8JkXVTqPWJed1/ZeQZX0vOyQagwa4HyA=
X-Gm-Gg: ASbGncsdvp4zyPXKZc185Pma/NvM8nBzFOatvGjStZ9UetrN30iT+OQph1DbJMj0RNK
	JALDgVssVp9RSQd7Y5HXyaUNvw02DuIc0eVvOgPz+KXZtxfvaiiF3ZpD974EkGDcS6+KZaDnBu4
	AOxmcKZziPiHWcRWkzxLmIuU7xCGLKKIDxP7gLFtDIORoP0qQ3bvhW+H6M7S77nZ+NYYu99P9K8
	yfggx3S/yIBwrd21BXTW3ZCVYaId4qAP6hwIHAkp+OgFrQn4esM9PEhRl+XCMITVofOGDZbeuaG
	+5AcD7DVu+pnpDvXy9eazrc4KKfaOLhS/nkiPh1cOUex8EjhHkCWLivhGHlhyKmcRPHrsrUKJKv
	XM2gMmqRhDiBvQBhTSYuQWXkeqS+IyGTnKJ9X+98hLJhj3v44L/HCgubaev4u3Iw3akxNscDUgA
	==
X-Google-Smtp-Source: AGHT+IFndg9ORd7DdV17/AY12fGMvCqbay2qmGLnfC3MlfdGWk8UTfseAJoRNWSUPwdt97Gzn0J7PQ==
X-Received: by 2002:a05:6a21:4a8c:b0:234:80f6:2b3a with SMTP id adf61e73a8af0-24340af1148mr27777548637.4.1756295638357;
        Wed, 27 Aug 2025 04:53:58 -0700 (PDT)
Received: from [10.88.210.107] ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4c54eafaf4sm585068a12.30.2025.08.27.04.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 04:53:57 -0700 (PDT)
Message-ID: <f6d49614-bb35-450b-a683-d514b2b52f31@bytedance.com>
Date: Wed, 27 Aug 2025 19:53:52 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jbd2: Increase IO priority of checkpoint.
To: Jan Kara <jack@suse.cz>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.com, yi.zhang@huawei.com
References: <20250825125339.1368799-1-sunjunchao@bytedance.com>
 <877byprefg.fsf@gmail.com>
 <418cbbab-4046-494d-bfdf-899c3b66f5fc@bytedance.com>
 <pnskj4s6nxyyootkrxcz7nl5exqzs7sdw2jfehq2z4xc6yvs67@mx7dymx7vsjk>
From: Julian Sun <sunjunchao@bytedance.com>
In-Reply-To: <pnskj4s6nxyyootkrxcz7nl5exqzs7sdw2jfehq2z4xc6yvs67@mx7dymx7vsjk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/8/27 19:15, Jan Kara 写道:
> On Wed 27-08-25 12:57:32, Julian Sun wrote:
>> 在 2025/8/27 04:55, Ritesh Harjani (IBM) 写道:
>>> Julian Sun <sunjunchao@bytedance.com> writes:
>>>
>>>> In commit 6a3afb6ac6df ("jbd2: increase the journal IO's priority"),
>>>> the priority of IOs initiated by jbd2 has been raised, exempting them
>>>> from WBT throttling.
>>>> Checkpoint is also a crucial operation of jbd2. While no serious issues
>>>> have been observed so far, it should still be reasonable to exempt
>>>> checkpoint from WBT throttling.
>>>>
>>>
>>> Interesting.. I was wondering whether we were able to observe any
>>> throttling for jbd2 log writes or for jbd2 checkpoint?
>>> Maybe It would have been nice, if we had some kind of data for this.
>>
>> Good idea. But AFAICS wbt lacks of such a obversation mechanism now..>
> 
> Well, I guess Ritesh meant some test case which is reproducing the
> situation where jbd2 log writes get stalled.

Ah, thanks for the clarification. It may be a little bit difficult to 
reproduce it manually, I’ll give it a shot but I’m not sure if I can do 
it..>
>>> BTW - does it make sense for fastcommit path too maybe for non-tail
>>> fc write requests? I think it uses ext4_fc_submit_bh().
>>
>> Yeah, I think so.
>> After a rough check of the code, the following code paths may result in high
>> latency or even task hangs:
>>    1. fastcommit io is throttled by wbt or other block layer qos policies.
>>    2. jbd2_fc_wait_bufs() might wait for a long time while
>> JBD2_FAST_COMMIT_ONGOING is set in journal->flags, and then
>> jbd2_journal_commit_transaction() waits for the JBD2_FAST_COMMIT_ONGOING bit
>> for a long time while holding the write lock of j_state_lock.
>>    3. start_this_handle() waits for read lock of j_state_lock which results
>> in high latency or task hang.
>>
>> Hi, Jan, please correct me if I'm missing anything.
> 
> I think you're correct. In fact ext4_fc_commit() does modify current
> process' io priority to match that of jbd2 thread so it would be logical
> to match IO submission flags as well.

Thanks, I will send a patch to improve here.>
> 								Honza


-- 
Julian Sun <sunjunchao@bytedance.com>

