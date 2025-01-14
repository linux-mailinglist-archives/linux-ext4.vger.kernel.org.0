Return-Path: <linux-ext4+bounces-6090-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C17A109E8
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Jan 2025 15:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B3233A8B6A
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Jan 2025 14:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7528156257;
	Tue, 14 Jan 2025 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SPqUfLLb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A0215532A
	for <linux-ext4@vger.kernel.org>; Tue, 14 Jan 2025 14:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736866279; cv=none; b=SETTG2FkeTbBnRao300Hw4/F0GoFXaogRPWuBp+OiWhDcn/MYuSmUrGZFNT/eQhXpywIJBlLrg6P/rSHGDLYxhg3xpoT0R0lWngfdbdoEpY6H5+8Rktrbs8ZaNpk+M38/2NGFW6t4Uiai84fly/xEaRmhoLnfNaA6gatxzBIh/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736866279; c=relaxed/simple;
	bh=OnivAETXnsBl7mXrjeIuhqyy2UMVgs8PMFytRZ0/6SI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pJwARyUtWBelLqdsY8YqMgaFVlb+cSUwo2/pZwvpUIctDuBieMWbr+sLlysHLD0xtIi8JvMCHiC7fv0CIYUHfFs7Sfm8MLy5vP7jp7AUa1sjophdta89SpSm2X8Qs1qp4V5vGmiubNmsTxgTiDS6iOoos6oWKyJ5xDIa6YwFMbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SPqUfLLb; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab30614c1d6so58008866b.1
        for <linux-ext4@vger.kernel.org>; Tue, 14 Jan 2025 06:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736866276; x=1737471076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pGaLjip8ws2aBkJc+HkZKzrNkaPfpsakY2s6/rWCOro=;
        b=SPqUfLLbtWwrVB4RhYKh9aeX9GlxvkdK+OwG8Py3l7JqXiCusJScv4GzdghTQmg2Aj
         eexdqyaLTSlju51DU0obUjfhjUtF1kaHGQrCcEk+rGJyOJt1CcnSr8StIXQbJQ/gwHcQ
         rwb+bp7bo4VY3NqhLzmU7+fQYMw3c4xUDc2P2w7D5Gp+4PwoeC17I+MTnDtXWDBKbjjb
         7C3ijSur3NvYWwi9gZrEXtSKQGKyyp8t0AANkhHhxyxexW9HT//KruIH2sMz2Vu+Hkjq
         nyYL4fkUoPFEvwruPB+1CRLDY4LP6pelPUsBWzMk4kzYZrdRG3l2PfKEaOD0a2n2XgfQ
         yS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736866276; x=1737471076;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pGaLjip8ws2aBkJc+HkZKzrNkaPfpsakY2s6/rWCOro=;
        b=eUdloBZmj0Mw+4v/XRxPTi3r0ipc7j/tp74BngUX7Yp1a1ypqm3gMKdHcINK4yj+cT
         tmRY5YXJhSVQt0CV5KGclK8a7mWpBT+cRJTAN3jQaH1PACEYJP1j41xq4e+vN+DxChN/
         CmkJvXG6rBIgs1OfkVOwVym6PTUMEj4n8hPmLDp5YjOZfVEA8UCbjhOcWrP0fK2N/ips
         otu0tGEn8ZWKq0+5QzlqvJ613pUp3Gx0Mxoj8VKCAowVhgWgy9aS/xsvFfF3YVtxi0KS
         ReDhrn/Ghn+ZlIAWMyGAWORSLT8Ju6RZVwpfScHscBUfJ/nFQYBgfnqsNZkVlQGKskgU
         8MWA==
X-Forwarded-Encrypted: i=1; AJvYcCWb/9D5QZQcwiZdvOWsPfSNAH2QmoGdRZE4ybkcQzn09r+e4dptMYoGl1hMBDOZUbyIa4IrXKyZFGBD@vger.kernel.org
X-Gm-Message-State: AOJu0YxyM/enGX2z74MNhHVpBoNzdtFUqzd90kbIc1vK/T01Uc9wpsv0
	zLm+rcvKUw/RgwfmcejSW55EyRIYWwGTaI1tv7TUSlH9+LVIwzGjkKk/GssBUyA=
X-Gm-Gg: ASbGncttSQkdFBElC4G03EUCoolMYJV5UitSioQL5Is5e0fa6pv7dq6vwd2xh9E6KRm
	MZseoF8Twgk2ECqoZhp1z2OaZ4/L8xcWvzxOa2peq8rjtr35DkLo+tBGJLM8ZqL+4F7piabfG6u
	IPfdGsZ8PZ1YrjMsfLCILjiAhmzOTyKzPiS1rLruH5u+QPTKgKo1jkG8DckII10HomkUQqVb8uX
	6OUxHMeXf+Vg9+TKlN4ayD/ofpb6x0TFuiWCobu/pYTzfov0T/oa4N35SfAT1E=
X-Google-Smtp-Source: AGHT+IEekbyRZetOC3fp4MjYg219+9eB5QuJKqBG/xAtl77M4ni+Kg/FKCcbgOEGbgD4MYoZu3NqAQ==
X-Received: by 2002:a17:907:d0f:b0:aae:83c7:fd4e with SMTP id a640c23a62f3a-ab2abc95fcbmr744650666b.13.1736866275808;
        Tue, 14 Jan 2025 06:51:15 -0800 (PST)
Received: from [10.202.112.30] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40692172sm7496304b3a.154.2025.01.14.06.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 06:51:15 -0800 (PST)
Message-ID: <3655551d-b881-4f2b-8419-03efe4d3aca7@suse.com>
Date: Tue, 14 Jan 2025 22:51:10 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WARNING in jbd2_journal_update_sb_log_tail
To: Theodore Ts'o <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, Liebes Wang <wanghaichi0403@gmail.com>,
 jack@suse.com, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller@googlegroups.com, Joseph Qi <joseph.qi@linux.alibaba.com>,
 ocfs2-devel@lists.linux.dev
References: <CADCV8sq0E9_tmBbedYdUJyD4=yyjSngp2ZGVR2VfZfD0Q1nUFQ@mail.gmail.com>
 <mzypseklhk6colsb5fh42ya74x43z5mmkzdjdyluesx6hb744a@hycbebanf7mv>
 <24f378c8-7a27-47b8-bd79-dba4a2e92f6d@suse.com>
 <20250114133815.GA1997324@mit.edu>
Content-Language: en-US
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <20250114133815.GA1997324@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ted,

On 1/14/25 21:38, Theodore Ts'o wrote:
> On Tue, Jan 14, 2025 at 02:25:21PM +0800, Heming Zhao wrote:
>>
>> The root cause appears to be that the jbd2 bypass recovery logic
>> is incorrect.
> 
> Heming, thanks for taking a look.
> 
> I'm not convinced the root cause is what you've stated.  When
> jbd2_journal_wipe() calls jbd2_mark_journal_empty(), s_start gets set
> to zero:

Actually, ocfs2 calls jbd2_journal_wipe() with 'write=0' (hard coded),
so jbd2_mark_journal_empty() isn't called during the ocfs2 mount
phase. This means the following deduction won't apply in this case.

-- Heming

> 
> 	sb->s_start    = cpu_to_be32(0);
> 
> This then gets checked in jbd2_journal_recovery:
> 
> 	if (!sb->s_start) {
> 		jbd2_debug(1, "No recovery required, last transaction %d, head block %u\n",
> 			  be32_to_cpu(sb->s_sequence), be32_to_cpu(sb->s_head));
> 		journal->j_transaction_sequence = be32_to_cpu(sb->s_sequence) + 1;
> 		journal->j_head = be32_to_cpu(sb->s_head);
> 		return 0;
> 	}
> 
> I suspect that there is something else wrong with jbd2's superblock,
> since this normally works in the absence of malicious fs image
> fuzzing, such that when jbd2_journal_load() calls reset_journal()
> after jbd2_journal_recover() correctly bypasses recovery, the WARN_ON
> gets triggered.
> 
> I'd suggest that you enable jbd2 debugging so we can see all of the
> jbd2_debug() message to understand what might be going on.
> 
> By the way, given that this is only a WARN_ON, and it involves
> malicious image fuzzing, this is probably a valid jbd2 bug, but it's
> not actually a security bug.  Sure, someone silly enough to pick up a
> maliciously corrupted USB thumb drive dropped in a parking lot and
> insert it into their desktop, and the distribution is silly enoough to
> allow automount, the worse that can happen is that the system to
> reboot if the system is configured to panic on a WARNING.  So feel
> free to prioritize your investigation appropriately.  :-)
> 
> Cheers,
> 
> 						- Ted


