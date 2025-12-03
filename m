Return-Path: <linux-ext4+bounces-12143-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4BAC9FD28
	for <lists+linux-ext4@lfdr.de>; Wed, 03 Dec 2025 17:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C0CD30071A5
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Dec 2025 16:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A6734FF58;
	Wed,  3 Dec 2025 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFfvKWWY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A6E340D82
	for <linux-ext4@vger.kernel.org>; Wed,  3 Dec 2025 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764778094; cv=none; b=NSFZGGwhidBhFtBGZygHpeUNxUGKdUfr9IYN/1fcVHAkxGsG6f3DkKHKKVHukoELO4zeoeBYNr/H/esDsgIhcvMgzIHooMkYPAKH+gg3KzHVbERP7+WhswhfzkgnKfEWPXH/pmkqOmL9+mEaCbfTDeyEDbOuPD8T/1oD+SeHhBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764778094; c=relaxed/simple;
	bh=t8UdtXjAc59D4J6GvJTeXGoV+4cjmIdKxrqekSmeSRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e56b5JNKC72/YwpH2DZGnCH0ZHhFV8u7IOAxPePwP4u7yJeqQtAB6eul9tma2WL43FGjtL2WRDIZBlWO6Zw2V+rDQSYvpF08QUS9Ee7YDU8nWpygQgAG82MsNUqINj6WfuMNn4CF7WwwmWnxqmEtMTlHYKG5RcSWrzprgHa9gJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFfvKWWY; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b1e54aefc5so508592685a.1
        for <linux-ext4@vger.kernel.org>; Wed, 03 Dec 2025 08:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764778092; x=1765382892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vjK1XAu2xT25O+AavGRfhzxz/zLiQnbfHyTquGAL0Ms=;
        b=dFfvKWWYFDmjSYj1bgic3CbMIl+7PQ9pzh01xlPUlw1Lq/3hsAvvtVOLGuGIyEjYJO
         eASOAIdCdVFV0buL93CzmAsC9nmm2NeOGTLBe8DdF4yXPeyRvRrf+5niEpfX5CK1EpP8
         nB9MkKFvBb5aAwdckyK4EM71mm8TrQcB0VRGe98Hqp1e7+pLOWaq8DD0mZjly70bYonB
         I8eFi8pG46sWv6TxT7RJFCw7mMJj9vJ0bxEErO7A8MZ0Iya1SvDYDSDWL2tU5/JCcOvn
         UsDHyXuSqrmLzpWrnB+kiWP8ykfla7tJTt6rE9UieHVSksLzsSRKawUVDLWwcMOaWJZt
         iH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764778092; x=1765382892;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vjK1XAu2xT25O+AavGRfhzxz/zLiQnbfHyTquGAL0Ms=;
        b=LoVnTyEe0ev/ldWC/rSOGhEDGd7pSxf26xqKygt4Tw98xMgkxN0Rq6POyVo4CNo00r
         P8pHpcGvlBp5HaEVwP5O/LjVN+hmFbXKhnpohhzhW0ngYdovAyabQ3A3VF+IT31pTVlk
         XpsC2H4ikw9u7O9z51BNARZ1dnhkttDS5OF8vbX6KG6cxYMpL/Lglae9dYabcq3mIz80
         DROUqAHQhAqU2KgNvFSyM9Ht//cCypg0hF7uyTcIDc/pqZ9pRMZOhL9cF0pUhWH9hkB8
         456+evJHAUYQtGQpMbsqZ+ccHPshbBgmIiHP/VYlWLVthzcLtfGH5WoUqOVSZSzMtgS4
         ym+A==
X-Forwarded-Encrypted: i=1; AJvYcCWIAD4lqAql92zE55ly/Ki7XVVF+R95ut8peWNXJX6smxJSaDLUjTHUOMObS/vP8wNKmaG8mSwnQZ2b@vger.kernel.org
X-Gm-Message-State: AOJu0Yzog6DC0EQ1VcAVWIC6cXadwRBHP4o4mkpFncFO3dscZagMifxu
	Eo9grXNi1Fyr7rKXf4EycY8c//XfvcJaWNJSGlpiEqGYqEUGBjM1mc5w
X-Gm-Gg: ASbGncs98/sFSiWYdCLwn+jlkXylBKnYNQ2YT8czqKDxWiJ5mz0KUbLqUNRQ0eQojhx
	K1d+KUDIkbYpYNRj0pLBrDcZltBbk1mXksc+s5PJz56fKIHxjbyuzCdvXLeZE6YrG0o48IvIXJd
	jsBHdDHpvXIWRaiJgZtu48Js0LZkJ70cs2pT09Yqhawk+C0inLMJGIdPcuyODYcODw8RT0slOHl
	M2Q9QjxP6UxNNE1V9IOMzZDBdznVLyncpx5lGwTgXclEc6ijcddei3SZ2lJ1LWC9I3kII96mFUO
	JipM25ti9sGvilq7w86pdu95I8of+8eJaG7sv98tt23HWGUBSmr9A/j2iHy34RttzfF5OeOuStm
	nzJbOvmDvGysAjPogPiWfIZtd7KbUmxMeZA9jZie7rc4EENDnnWrKiJy5N3FCjhZFQI8iEk7iKe
	v35n3232zHn3/V8feUiWqidMJW1wFUfOQo5YAPBQ==
X-Google-Smtp-Source: AGHT+IG8XNHFYN5A+3Cg7wEkan0iO0paJZc5a0d8DfhoogQB7q95o21uPOmzpwu8og6VMUZxzU+/rA==
X-Received: by 2002:a05:620a:c55:b0:8b2:e38d:2f03 with SMTP id af79cd13be357-8b5e47d0321mr308095785a.9.1764778091859;
        Wed, 03 Dec 2025 08:08:11 -0800 (PST)
Received: from [192.168.0.155] ([170.10.253.128])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b5299a6fdcsm1324637585a.20.2025.12.03.08.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 08:08:11 -0800 (PST)
Message-ID: <cc17bad2-ef56-40bc-9fae-073c1065a57b@gmail.com>
Date: Wed, 3 Dec 2025 11:08:10 -0500
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext2: factor out ext2_fill_super() teardown path
To: Jan Kara <jack@suse.cz>
Cc: jack@suse.com, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251203045048.2463502-1-vivek.balachandhar@gmail.com>
 <herlaqmrxfzbh2yqumcquf4ex7qxz5sk47uswmwucdg3pmryez@bvyyavacx5rq>
Content-Language: en-CA
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
In-Reply-To: <herlaqmrxfzbh2yqumcquf4ex7qxz5sk47uswmwucdg3pmryez@bvyyavacx5rq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

thanks for the review. You are right — the helper has only one call site 
and bh is uninitialized on some failed_sbi paths. I will drop this patch 
and look for a more meaningful cleanup in ext2.

Vivek

On 2025-12-03 5:40 a.m., Jan Kara wrote:
> On Wed 03-12-25 04:50:48, Vivek BalachandharTN wrote:
>> The error path at the end of ext2_fill_super() open-codes the final
>> teardown of the ext2_sb_info structure and associated resources.
>> Centralize this into a small helper to make the control flow a bit
>> clearer and avoid repeating the same cleanup sequence in multiple
>> labels.
>>
>> Behavior is unchanged.
>>
>> Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
> This is pointless - no point in factoring out helper when it has a single
> call site. Also your patch is broken in several ways (both in correctness
> and style). Please be more thoughtful when submitting patches.
>
> 								Honza
>
>> +static void ext2_free_sbi(struct super_block *sb,
>> +			  struct ext2_sb_info *sbi,
>> +			  struct buffer_head *bh)
>> +{
>> +	if (bh)
>> +		brelse(bh);
>> +
>> +	fs_put_dax(sbi->s_daxdev, NULL);
>> +	sb->s_fs_info = NULL;
>> +	kfree(sbi->s_blockgroup_lock);
>> +	kfree(sbi);
>> +}
>> +
>>   static int ext2_fill_super(struct super_block *sb, struct fs_context *fc)
>>   {
>>   	struct ext2_fs_context *ctx = fc->fs_private;
>> @@ -1251,12 +1264,8 @@ static int ext2_fill_super(struct super_block *sb, struct fs_context *fc)
>>   	kvfree(sbi->s_group_desc);
>>   	kfree(sbi->s_debts);
>>   failed_mount:
>> -	brelse(bh);
>>   failed_sbi:
>> -	fs_put_dax(sbi->s_daxdev, NULL);
>> -	sb->s_fs_info = NULL;
>> -	kfree(sbi->s_blockgroup_lock);
>> -	kfree(sbi);
>> +	ext2_free_sbi(sb, sbi, bh);
>>   	return ret;
>>   }
>>   
>> -- 
>> 2.34.1
>>

