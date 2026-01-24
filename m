Return-Path: <linux-ext4+bounces-13287-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id C0+2HnOAdGlW6QAAu9opvQ
	(envelope-from <linux-ext4+bounces-13287-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Jan 2026 09:18:59 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BB07CF69
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Jan 2026 09:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 005F63012CCE
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Jan 2026 08:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A092773EE;
	Sat, 24 Jan 2026 08:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJCNC3wM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38281F875A
	for <linux-ext4@vger.kernel.org>; Sat, 24 Jan 2026 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769242733; cv=none; b=loEoZp+6aamF3OxMmlpMVAkRvHAMhqlXDlwzo4c4v2rrG4GQiGdYEfb0E3ou011UB5FACQo7NQevtaZLQACP5iejkK0EKlSsMCyjmKwI+HQUSdMJeR3uARe4YewAB7USe4Apn+o8DJ/NGXEs4uRHkbxYga4V6LtcfPH/QzfwhaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769242733; c=relaxed/simple;
	bh=OVAeomsh6Mj11icHu9KqyNRZ2jyJuFcGOWKABatdc74=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rq6GkiS4apYzNPYcBcEBKfets8KjLWJBxDIr7N/Wuz8rmpBwy7ZhK8hL7+YIVpzbIt8Ztz9SQhis4fc/bXssW8D/S86UF079xfRvjiX9gYCocxCyEoTOrMGoplYXnQb3wtftiXHgWs0s0CRgvk9esI2On2zeWkcOhaldt5qqjrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJCNC3wM; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a0834769f0so19744665ad.2
        for <linux-ext4@vger.kernel.org>; Sat, 24 Jan 2026 00:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769242731; x=1769847531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rMKou0lTGiCd2raLCB3aWAc1kprvOo5pfAG7zCR/gfQ=;
        b=cJCNC3wMIdSCUP3A+WXQel43PbHp4gdbtNfDzydUmwOTnxSSvBbbrh3DHalVMio/qe
         4xQbrep03hIWESh8L4DkhJRDOET+aAjL5YNBDHPdEBqbqkEs61ZDIG8GSuGAi3Lq6roH
         5jeJSKg5AnZql8mp5vgTS97V8Q2fHUvLMxZgSIEwbuj9awcwoyzbCK2c6Ul7uJ5ZU7jM
         bhAG1XhoPhICRqEc9XBMfPkwImlNdqvDzX51y6jKYCLkScLdbz9ciRBI+GAXuz3twbWh
         1VkobbCVkfsTqdTSZl/2rV8rfrvyr+CLliVzWAPpb4kUXx98sXUdXReMm8m6fevTwn9P
         U9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769242731; x=1769847531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rMKou0lTGiCd2raLCB3aWAc1kprvOo5pfAG7zCR/gfQ=;
        b=H2bMyvg+zgIKO99Fg2qodvDpM+QZn8Ur6Omjv6WrYGV+Pp1TBNhLgZM384gqFN9jUT
         m1LtG46q4p5KA+v5RFkt+xqoVa60ID2gA8FdXKEUrD17UEg2y4UGEsxQQruizLFb83Ml
         qZSaIlOOnUsbVcDXkGA2kyXwhnROFgCUTxp00rEqloYp0vI52watJ7GFSpu7rWuJin7q
         RVKapEoWI+wqP6xrsx1kDFUk5JqBeu5z73frPW9YZ3q6JKK/e5inc6QGO6031FlBVR62
         2LiEgi+nIc3/sZ+IiAF13CT9EN2u12Nvx4G4c12uwULSyPLnfJfPG2lv2yunfNd62z/j
         YsEA==
X-Forwarded-Encrypted: i=1; AJvYcCUk5xBR02orS9qdHFtjf87bCcv/6FnDsukwYxNW1lbIDZxxANpmThUTQAyrehCEi0HmiiplNpASXAWT@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8vknAGbN42eTQUygJl5RddEn5wAw8XgHllYqxQiq7F2mkHKoN
	IkBqZtlQhjcVqsTYFVt7QWYHnvKpSdFEVTqC5iWOHJLhViwifKPDpz8T
X-Gm-Gg: AZuq6aKTUUY+i8Yh7NEPIGG4D7OrHu3JC4seYtmk7qia4Od14s3+iXcOi1z00Yh20NJ
	LVgx4tUpOlbAguMIc0rM9A1lp9qsb4449rQegIuP3KGTZJlbVECo4U0K5RCw7GFS0dkvoD6juWD
	rKU3hiZoQxoUpa1ZVduxcrUQ7D/qqNPYp0eH0sRl11122ZV8ywSRzK4LZikafY1XxjyDtOTlxid
	EFmvq+gfNmzJ7LXiuSr53AWOIKDeCxb+tFA+SAPD7czSkvpqtn9qYWLtcTwDDnGCYEON1uHZA1+
	gVV1RBS4PYeYbOE8cuilvX6BaFWsFSbhTi+gGcXdnWhWOvo4XOkcaM0SYCCM5u8Mgj6V9Mhmhmm
	Ks8/EMJNRuqEZxMNAvooyW/JlZhZy42cbUaQHvcBj2slsCMt+PXs3kO49IfPc4IVxyDdfEQzT+J
	c+1VlyJqVR6pmT8d++z2RJzKfjpVUyWYcO5nfnCTLVO3FljRFhAC3UsznoozTemg==
X-Received: by 2002:a17:902:f652:b0:2a7:a22c:90f7 with SMTP id d9443c01a7336-2a7fe756185mr49731635ad.51.1769242731079;
        Sat, 24 Jan 2026 00:18:51 -0800 (PST)
Received: from ?IPV6:240e:390:a84:ae11:f96c:3476:2936:720f? ([240e:390:a84:ae11:f96c:3476:2936:720f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802fdd715sm38380625ad.102.2026.01.24.00.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jan 2026 00:18:50 -0800 (PST)
Message-ID: <f20b78a1-82c2-4864-a996-585c703573e7@gmail.com>
Date: Sat, 24 Jan 2026 16:18:47 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: remove unused i_fc_wait
To: Li Chen <me@linux.beauty>, Theodore Ts'o <tytso@mit.edu>,
 Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260120121941.144192-1-me@linux.beauty>
Content-Language: en-US
From: Zhang Yi <yizhang089@gmail.com>
In-Reply-To: <20260120121941.144192-1-me@linux.beauty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13287-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yizhang089@gmail.com,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,linux.beauty:email]
X-Rspamd-Queue-Id: F2BB07CF69
X-Rspamd-Action: no action

On 1/20/2026 8:19 PM, Li Chen wrote:
> i_fc_wait is only initialized in ext4_fc_init_inode() and never used for
> waiting or wakeups. Drop it.
> 
> Signed-off-by: Li Chen <me@linux.beauty>

Thank you for the cleanup, it looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>   fs/ext4/ext4.h        | 4 ----
>   fs/ext4/fast_commit.c | 2 +-
>   2 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 56112f201cac..dc3a5a926eff 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -28,7 +28,6 @@
>   #include <linux/seqlock.h>
>   #include <linux/mutex.h>
>   #include <linux/timer.h>
> -#include <linux/wait.h>
>   #include <linux/sched/signal.h>
>   #include <linux/blockgroup_lock.h>
>   #include <linux/percpu_counter.h>
> @@ -1091,9 +1090,6 @@ struct ext4_inode_info {
>   
>   	spinlock_t i_raw_lock;	/* protects updates to the raw inode */
>   
> -	/* Fast commit wait queue for this inode */
> -	wait_queue_head_t i_fc_wait;
> -
>   	/*
>   	 * Protect concurrent accesses on i_fc_lblk_start, i_fc_lblk_len
>   	 * and inode's EXT4_FC_STATE_COMMITTING state bit.
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index fa66b08de999..86789989b3f4 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -13,6 +13,7 @@
>   #include "mballoc.h"
>   
>   #include <linux/lockdep.h>
> +#include <linux/wait_bit.h>
>   /*
>    * Ext4 Fast Commits
>    * -----------------
> @@ -215,7 +216,6 @@ void ext4_fc_init_inode(struct inode *inode)
>   	ext4_clear_inode_state(inode, EXT4_STATE_FC_COMMITTING);
>   	INIT_LIST_HEAD(&ei->i_fc_list);
>   	INIT_LIST_HEAD(&ei->i_fc_dilist);
> -	init_waitqueue_head(&ei->i_fc_wait);
>   }
>   
>   static bool ext4_fc_disabled(struct super_block *sb)


