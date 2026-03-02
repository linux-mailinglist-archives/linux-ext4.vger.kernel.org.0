Return-Path: <linux-ext4+bounces-14304-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCdFBPORpWmREAYAu9opvQ
	(envelope-from <linux-ext4+bounces-14304-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 14:34:43 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D821D9DC2
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 14:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B7AEE3038EF0
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Mar 2026 13:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC2F3CC9F4;
	Mon,  2 Mar 2026 13:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QliuqGlh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B2D377021
	for <linux-ext4@vger.kernel.org>; Mon,  2 Mar 2026 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458224; cv=none; b=FxjLsEQEzruCHodbMxiOfrqC16FT3R5bOuu+gXEq5TFWTnMzSPuwwwHYlYIKJBVkO50k/tvVHQ/OFXn9REMcQLJK3TBY3CrQL4lP2a44Ltqy03tL61Hv+XQe208A69cOXZWRBm/V+T8ypYkfCH4BxkMGtbz080VWlOAlH6aRYVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458224; c=relaxed/simple;
	bh=Rq7RfAq1tZwnyavsjnkK9wmAf48OHY+TrmeBnY75gVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VyfKrLeVmpo/JUacEdTMD5tDH47iJ7cc9gcHAr6axJXPyfNeMNZxR8mTCVI0whi123lKghhZAbHUZ4SjYx0K6GV5lwCtLiYBtjsHEFqEztGMk4y57TuFqXbh/UxGq4iDkMVlqmb0LjL+oMzzUeHC2Psd1V2+9WGkDcXiRb183m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QliuqGlh; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ae46b9c70dso5551635ad.1
        for <linux-ext4@vger.kernel.org>; Mon, 02 Mar 2026 05:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772458220; x=1773063020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s24i19n8lKIqVIDIL0pIocUyXuHdTYTMYpJQeikEDx4=;
        b=QliuqGlhM72zAOFK2QwkQ1LbtSPrJdHcPPOCXJYqpUcpGXOCZJcRCbvBWdT8BUuq3v
         bUQx6IaUTLOfZeUkEgGSzREw56LuGVkdDUwOhkjPuEjO87GZNWEXTGzcm3FqJzUTSiEB
         hSUzGmc+N18g9cpKr86DaCf6/gLVfR1syAwTeH7odxYnUIQD0w6zQk9zKAyqNX7VGnS1
         6j+jhjCCLv7Z351U9BAWsWqYhNZoigqcOVIp0LO6probde+f95GaH8BF+NiVK06ulphS
         C2A+A6+ix2/DRDb63ftTR1A7znyW5Dej6xPIVEmaTGIivy8k+zZOTtowp3XM6wYdW+4Q
         kGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772458220; x=1773063020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s24i19n8lKIqVIDIL0pIocUyXuHdTYTMYpJQeikEDx4=;
        b=qftHPDUDyvfXsVu1QjfJtK8xiMdbOlrF76vpMMtc+NBrMQABOz3rl5DnOuA+5mN8AW
         H44kJDynyho3Fdh6O1ID4/6IEr+aFZ1W5hA6s1kh6qcVEVnf6MseFxDt6j0fQD2F35hX
         u3kZFmRSwSkdUZAiqTAM/4Rgz/Ffq0H5vVRKAzu6eDcSUaguWci08xkaNGt7RPg6y0CZ
         vWYrlY/L+lod7WgfxiaqU05DpFAvnuRet5+ywIckQHM8MeY5uBQkWtlB0pBpBSrdoZC8
         y3kvapttZzkqZAZzOOG1b6uzogs8m6gsWzB/Zw0Mr1+P6kr/Q7NkoxmSdWS2j5ykQSBG
         ToPA==
X-Forwarded-Encrypted: i=1; AJvYcCUMGjB3BIIC9I2w1C+n17C/Sd15lEsfTqkkdLCTCzRhy3xO1r8LdCMaYypknWYDFZ57v2p0hddciJ5F@vger.kernel.org
X-Gm-Message-State: AOJu0YyVhsI/XH6PEtds4ybbMg3HUd+Zgxt+dTnUh7BIr6F6WTVlSc5P
	rrqvgV27vQ/Vz1ED356Au7N/kOw25oqjmr3ziD5vU231ySvKbZsO7705
X-Gm-Gg: ATEYQzz7POLgvmtHMduB8WwfJcJUEURlyvfm6g2pWYKdEacC+/UlKsoUN0Ojgx1BkHY
	OGd/GfH4C2XWj2IR+zBMZA6eb6SLWHI1YJfoGgRUWJKAaVj3CBoZHR/j+Koe/EhCF3xZgZ69AWk
	ZLYybleiD94b+BAZG+1yG+JjuTM+1MOdkbQd0GhdY3LN7yWsjL6wzbafcGjE7Bh8KmjxZDSMHi8
	eRCi9PSKQ1GPf1ctAn5UjshUpZveY+DzRBGk9/VmqsUrxFeWfWyloaOO27RiiCY3oqyviJiIEHO
	/zIZoF75u1o46ZDYvELtELCWs+Skw5qcQV/u+5LFx3nXATETsF83Mp7U1YrhpjyRHlxFT6c4bG5
	4DcftEnFezU+BRtCvGVHBFw5kLQ+S5WrU9MmO55+KVA6rt/nCfv2bj98aszpGenblRZmK7mMicT
	XsNqZDULxBvIP8fo/qeI4aoMpADPbXA2K1JHPMug==
X-Received: by 2002:a17:903:19cf:b0:2ae:4ad5:b76c with SMTP id d9443c01a7336-2ae4ad5ba05mr48823935ad.10.1772458220205;
        Mon, 02 Mar 2026 05:30:20 -0800 (PST)
Received: from [192.168.50.90] ([116.87.14.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae45b5201fsm55018345ad.87.2026.03.02.05.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 05:30:19 -0800 (PST)
Message-ID: <cb136241-ca7f-4c64-a6b3-3f86688240f3@gmail.com>
Date: Mon, 2 Mar 2026 21:30:17 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] fstests: verify fanotify isolation on cloned
 filesystems
To: Amir Goldstein <amir73il@gmail.com>, Anand Jain <asj@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 Jan Kara <jack@suse.cz>
References: <cover.1772095513.git.asj@kernel.org>
 <b54dea5e72585db5f5c3d74ce399f9d839965821.1772095513.git.asj@kernel.org>
 <aaQ8CB7C4FjDuedR@amir-ThinkPad-T480>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <aaQ8CB7C4FjDuedR@amir-ThinkPad-T480>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14304-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anajainsg@gmail.com,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 49D821D9DC2
X-Rspamd-Action: no action


>> diff --git a/src/Makefile b/src/Makefile
>> index d0a4106e6be8..ff71cde936a7 100644
>> --- a/src/Makefile
>> +++ b/src/Makefile
>> @@ -36,7 +36,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>>  	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
>>  	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
>>  	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault min_dio_alignment \
>> -	rw_hint
>> +	rw_hint fanotify
> 
> Check if you already have fsnotifywait installed on your system
> most likely you do. It was added to inotify-tools quite some time ago.
> Could save you from adding a custom prog.
> Not 100% sure about fsnotifywait, but quite sure that
> fsnotifywatch --verbose prints the FSID of events.
> 

I missed that command. V2 switched to using fsnotifywait.
V2 is not sent yet, I'll wait for any further comments.

Thanks for the review.

Anand

> Thanks,
> Amir.

