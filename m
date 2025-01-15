Return-Path: <linux-ext4+bounces-6104-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85645A118A9
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jan 2025 06:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A263C188A383
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jan 2025 05:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D4D22F3A3;
	Wed, 15 Jan 2025 05:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dCFsWF+C"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A861876
	for <linux-ext4@vger.kernel.org>; Wed, 15 Jan 2025 05:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736917233; cv=none; b=o/GaQLJjXnDPtohM1Pl7XaXzA3+GcM+67vCjGL01wDe/GWbhOY+eilg4GblKgoeUAm4klqgQMPfEh6mh94wF6BwarAeaK53nPm0WG3krgv+M0RB9SeWobcwUgYF7aPrX2fa1VanokJlk+kUhMcnPX2suxCFutedxtgp+JkxrMnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736917233; c=relaxed/simple;
	bh=cIJFpZ2hrk7DGupK9ItVZj3+AgxWS9w13/A0QFIO8OE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7wsPrZKn3UCPe/fDtgcJfLnwtZ3Us4/SFFS7W8D90b6a+pc/Gr0tI7rgwafy8X99ZUZHq0vD07VttTyIMcFt/izQhfOAXLKpMuESRIU3Mko72sUElO/U661FL9K4SMu2jtHD95Ut1L/1doEN2+7Y2hB1GjujD5XDcZZo3Yq9II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dCFsWF+C; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3ce64e7e5so924068a12.0
        for <linux-ext4@vger.kernel.org>; Tue, 14 Jan 2025 21:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736917229; x=1737522029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XJMW9rnub/plt9wklWDGLR+ue2+UySWkbfATgGqVPsw=;
        b=dCFsWF+Cuh+E0CjbGmCCc4ikY3WgOkG0e1u5zNguZJwcFDKugcSInI3y0W4M8rjkDO
         G9qElOdEusJXN3goIJSbN9hGWK/g2aISs4WoLMosxjNkR/nXIZwAUFI+f1jrucTelOdy
         yx4m5VZvfMCo8bVy0GL0pkqdMF8j6WS9BRYbwyUL4UfWlimy3P4nVIBvzTX1Tvx9IL61
         DBcLnApW13YD7Pzh0gVJjuTeyXEf3WDdC0xnWIaqMAZD20ZnUhKs2MIdZnAq6wgdCC6r
         X8CJNORr1uPAAkHhLSVqyw1CbZitIrkMZFrGQjKpjNSz6DvkKjqy2ZSErHA8QaiA9Rrk
         2d7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736917229; x=1737522029;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJMW9rnub/plt9wklWDGLR+ue2+UySWkbfATgGqVPsw=;
        b=Hbxy8k8Xi2gaN5vHJJ76TD2EaIwl3969Zrd7tp13u579Rohb0IcwtPcxjnF/V7iJn0
         /bEUf0csytncSDajr9gkfmSgGHhPs29Nv5WnfxrKwX+Zdawzaa4aMqXgSA0fINtRtfbU
         Muk8xQGCoKslE9ZVSqxwuljXoLT004g2URvau9uxw8KcqrsoE2vxe2aN3x2IRVHmxW+5
         amJLBgkr0P2SZ17HGkPBsNQdStU9gvecyKlFaFIw7BetqgX5FXJKlMViuzZavRxr0Lk/
         /LYwkJeKzTk3+ifguOELAhedj0kfDHkxCRCkwFCJBv7f4fklPNMUtvI/Fd6YDqfNmHh6
         KGDg==
X-Forwarded-Encrypted: i=1; AJvYcCXlH5BcHBXjcljF0KKqV1/PejbYwW3MfngFmwa/c58xuQsNRJBYZJhy1gyXbzzAqiwQfeEvS5SbmU0o@vger.kernel.org
X-Gm-Message-State: AOJu0YzaQr8kx0cWSZzgVukAX71ZeepFM9b2JfyLhj8GxU9oCjzVFZkX
	Tbk+LQ823kafgo+QzO0UzH+oUKRWKKWdujqG0RgRKa6zQvQK3GrjwVgPodKPIZGdYoww1gi6rde
	ASKw=
X-Gm-Gg: ASbGncs/L2WwgcZXJVTiK5GJDAxzAOBkDvPze3kH2sGkmSEIEx8vdwsQAQOeqyucXsC
	bE4UdA+Luo0p30lcUXucaj+AUX4TTOJXjgkqfpxn/1auyEdFMBnLlR4ctIfm1siSfL6kT4qUfD3
	+GWScVNFnvpCrlebrohPUKqaiLhz/WDMibHG/mnZv/rtrsr9y6M0Zuqip/g48wSckDIg8tXCkpS
	u5IoyPfDcDkJSTbyMy69JmtLqX7B4jdDy+IFk9dFl0W7Rn+Z/OB0aNxhe1d
X-Google-Smtp-Source: AGHT+IGNe+b4wa4MisZ5kr1URc23Ns5uB8BbpHRkS9J8ACHpwmz0gD/aOPF9gHMOwDMMIS/6+ztEGA==
X-Received: by 2002:a05:6402:2743:b0:5d2:d72a:7803 with SMTP id 4fb4d7f45d1cf-5d972e06b12mr8320833a12.4.1736917229376;
        Tue, 14 Jan 2025 21:00:29 -0800 (PST)
Received: from [10.202.32.28] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a31ddb9e4b4sm8964243a12.70.2025.01.14.21.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 21:00:28 -0800 (PST)
Message-ID: <db4da8db-d501-4181-994b-c25845908161@suse.com>
Date: Wed, 15 Jan 2025 13:00:23 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WARNING in jbd2_journal_update_sb_log_tail
To: Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, li.kai4@h3c.com
Cc: jack@suse.com, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller@googlegroups.com, Joseph Qi <joseph.qi@linux.alibaba.com>,
 ocfs2-devel@lists.linux.dev, Liebes Wang <wanghaichi0403@gmail.com>,
 syzbot <syzbot+96ee12698391289383dd@syzkaller.appspotmail.com>
References: <CADCV8sq0E9_tmBbedYdUJyD4=yyjSngp2ZGVR2VfZfD0Q1nUFQ@mail.gmail.com>
 <mzypseklhk6colsb5fh42ya74x43z5mmkzdjdyluesx6hb744a@hycbebanf7mv>
 <24f378c8-7a27-47b8-bd79-dba4a2e92f6d@suse.com>
 <20250114133815.GA1997324@mit.edu>
 <3655551d-b881-4f2b-8419-03efe4d3aca7@suse.com>
 <CADCV8srwww_--oOvi1sdS4JfUafidPOPr0srG1bWO66py2WTtQ@mail.gmail.com>
Content-Language: en-US
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <CADCV8srwww_--oOvi1sdS4JfUafidPOPr0srG1bWO66py2WTtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Jan,

On 1/15/25 09:32, Liebes Wang wrote:
> The bisection log shows the first cause commit is a09decff5c32060639a685581c380f51b14e1fc2:
> a09decff5c32 jbd2: clear JBD2_ABORT flag before journal_reset to update log tail info when load journal
> 
> The full bisection log is attached. Hope this helps.

This bisearch commit a09decff5c32 appears to be the root cause
of this issue. It fixed one issue but introduced another.

Syzbot tested the patch with calling jbd2_journal_wipe() with 'write=1'.
The Syzbot test result [1] shows that the same WARN_ON() is triggered
in a subsequent routine – the classic whack-a-mole!

Back to commit a09decff5c32, it opened a door to allow jbd2 to update
sb regardless of whether the value of sb items are correct.

To fix a09decff5c32, it seems that jbd2 needs to add more sanity check
codes in a sub-routine of jbd2_journal_load().

btw, in my view, this is a jbd2 issue not ocfs2/ext4 issue.

[1]: https://lore.kernel.org/ocfs2-devel/04a9ad29-51de-4b50-a5bb-56f91817639d@suse.com/T/#m86d01f83d808868bb5e6548d30f79b4f9f889b13

-- Heming

> 
> Heming Zhao <heming.zhao@suse.com <mailto:heming.zhao@suse.com>> 于2025年1月14日周二 22:51写道：
> 
>     Hi Ted,
> 
>     On 1/14/25 21:38, Theodore Ts'o wrote:
>      > On Tue, Jan 14, 2025 at 02:25:21PM +0800, Heming Zhao wrote:
>      >>
>      >> The root cause appears to be that the jbd2 bypass recovery logic
>      >> is incorrect.
>      >
>      > Heming, thanks for taking a look.
>      >
>      > I'm not convinced the root cause is what you've stated.  When
>      > jbd2_journal_wipe() calls jbd2_mark_journal_empty(), s_start gets set
>      > to zero:
> 
>     Actually, ocfs2 calls jbd2_journal_wipe() with 'write=0' (hard coded),
>     so jbd2_mark_journal_empty() isn't called during the ocfs2 mount
>     phase. This means the following deduction won't apply in this case.
> 
>     -- Heming
> 
>      >
>      >       sb->s_start    = cpu_to_be32(0);
>      >
>      > This then gets checked in jbd2_journal_recovery:
>      >
>      >       if (!sb->s_start) {
>      >               jbd2_debug(1, "No recovery required, last transaction %d, head block %u\n",
>      >                         be32_to_cpu(sb->s_sequence), be32_to_cpu(sb->s_head));
>      >               journal->j_transaction_sequence = be32_to_cpu(sb->s_sequence) + 1;
>      >               journal->j_head = be32_to_cpu(sb->s_head);
>      >               return 0;
>      >       }
>      >
>      > I suspect that there is something else wrong with jbd2's superblock,
>      > since this normally works in the absence of malicious fs image
>      > fuzzing, such that when jbd2_journal_load() calls reset_journal()
>      > after jbd2_journal_recover() correctly bypasses recovery, the WARN_ON
>      > gets triggered.
>      >
>      > I'd suggest that you enable jbd2 debugging so we can see all of the
>      > jbd2_debug() message to understand what might be going on.
>      >
>      > By the way, given that this is only a WARN_ON, and it involves
>      > malicious image fuzzing, this is probably a valid jbd2 bug, but it's
>      > not actually a security bug.  Sure, someone silly enough to pick up a
>      > maliciously corrupted USB thumb drive dropped in a parking lot and
>      > insert it into their desktop, and the distribution is silly enoough to
>      > allow automount, the worse that can happen is that the system to
>      > reboot if the system is configured to panic on a WARNING.  So feel
>      > free to prioritize your investigation appropriately.  :-)
>      >
>      > Cheers,
>      >
>      >                                               - Ted
> 


