Return-Path: <linux-ext4+bounces-13693-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCkeBhr8jmljGwEAu9opvQ
	(envelope-from <linux-ext4+bounces-13693-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Feb 2026 11:25:30 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72549135097
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Feb 2026 11:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65017304A16C
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Feb 2026 10:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96923350A27;
	Fri, 13 Feb 2026 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mB9EV/QN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37694212554
	for <linux-ext4@vger.kernel.org>; Fri, 13 Feb 2026 10:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770978324; cv=none; b=mG9XKVVIkEyiwTczCNMvxFyPWj5HxWt9YHdsur47o/CC/FGraIzog8dzYSQERwquI8vjHYhbGYG8p+QArorGUrdusWi1hbVWd7AhYa4rk5M5jXJFjcZDttqvpoXpzBNxIwjnKOMAdN80KP709ZW46+J77a7z+A0Hzjhx6Q25KyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770978324; c=relaxed/simple;
	bh=aOSOkJx+F5n0agQz+RdKAqL6Ll+cCCa/aJaGebEFJJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dz4ARZwvDG7eob2oQWyL3idSNkjZtHwnOgOTDuS+fNERPx8ycsxu2Jl6EiKErYBfXF3nl9Ak3qlZ82NYVIxaq3pJokXOljY0gp+50tceLHgORWYxWgASV/PxumCchwQGl1o94aFLxoD5clysW58+j+YXV+QFBwKmnADlrtEBHs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mB9EV/QN; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48372efa020so3413445e9.2
        for <linux-ext4@vger.kernel.org>; Fri, 13 Feb 2026 02:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770978322; x=1771583122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NYROThY/7ZHEET/uel6hPwtunmdQZfk/w+xpuNRVP/g=;
        b=mB9EV/QNGisvTKyRjOF2XJviXpqv8wYhlu0uRvNZBA+Q1FQ1AVhVnCzFEQae77afTx
         i+DYh+NmxvhbtC/iFwxvXM+zGMiTGOdMf/kjD79TT/O9vA8EP9ZDigJ2gUHdVrxsVImF
         zZYwGpGigS8OKziQ2VGEomtv26Ip+yI5O+iOxZ9pt5ezj5yYu7MgG9+soOOKAVCJGCCk
         Rpk6F/4zO9JigHgbTx6WD21KwrdLO9nOn/gqVZaAaqSLtapAkAmclPNy0NhHfCP4hSPW
         bxybbTuNoFixLZOB9pvdGxoAmPZU8Srvcev4XeJNl48RKKUzv4N0xkkgYySXNd34kX+y
         WEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770978322; x=1771583122;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYROThY/7ZHEET/uel6hPwtunmdQZfk/w+xpuNRVP/g=;
        b=kzf9nPjMHOG0+k1M49Ok1l5bjdBjXkmEHKGiqiNYUYnj3Ffd2po3G3XUrk9vjEbrI/
         nMtBk8ds/tF8h/XzrTVY4PB6NGLyXy4fE3PKtYdbkBgM+ZmXlnXzicD0hM65P6Jk1QSm
         BIVZmglttOjddfHVxaX72z06CzP1apPzPW7/kFljs38/gQ4NNYPdOkN/zOuD0CXhShU0
         94+O7Jbvg++kLgxbTHZfjZKNee+xHK7xDbVbK816r2AHvaN/Zzzf8uCvoYAf0spKDndv
         BEsOzMHbl0iCMFTTOiJdArqeIizQdc7yzSlrvrjyPYUHjQ60DRsskx+WGyMmLcukCrBd
         rj7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSDDlImHR+Xn8QI5+rFb89nmXpGnuwXu7zCuqUYfnzRXAbDsgKeSLN3ItW5r5RcTKdY4TovKi711ag@vger.kernel.org
X-Gm-Message-State: AOJu0YxdKSyETL8v3Irc7RSGsFWjzhPznO/q/I9Fhh1gK+nacxquEpPP
	AFTbcP3jwFUFY52mN0FwKDuZFimPhX00IgSA0IhfcuDtC65lyRMq2u4K
X-Gm-Gg: AZuq6aJ7/7xoq9KxMiYWl29j9L2aKlwqZFspIGvvUgDtNkVejzYU9D0JpNJF8BysDJD
	uAQUyltUcJLFv+oKU1sYwSqZ+pVja/o38znQdxpqaJ1t8MNF95A/CfRyvKaZiyIXd6RwH6Td/p+
	eEDF96O5TM7s1IlI7hE2H+9vYB9KQep2Wv0l+cl3NMshfl2tT/lLxZQULBinrLnheCJHrd/uCG8
	u7sE1B00gOEQUTmGTiijtPpz7zDaMg7ThGg5Zp0WhzUxLKbUwAg+jDz5Dtz8/dDkHISSf3cRrPj
	zypbZd6BmsQlQcmcuK32eickDN8L0jOveiHPjCZJL7rybsj0zN1q0tbV5FSwAxNubgMRUPHp+Ui
	gZWug9ubc3gCQJXfl0TQqrH3O/siX5kis0RV9UT1WIOeKU7yGQ9LBRBXc5G9FSQ5X65bKrnwcS+
	mjsRjxyhV3WtXQvhUQ52bXvmYiPMyAPO68XGVLfgVUgCfPOA/q3hgRzHQ=
X-Received: by 2002:a05:600c:4fc9:b0:477:2f7c:314f with SMTP id 5b1f17b1804b1-48373a1ba16mr20756045e9.10.1770978321454;
        Fri, 13 Feb 2026 02:25:21 -0800 (PST)
Received: from [10.128.170.182] ([77.234.210.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835dfb4bd4sm188893315e9.7.2026.02.13.02.25.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 02:25:21 -0800 (PST)
Message-ID: <4870d506-e29f-4c68-8d93-03aa3a931fa1@gmail.com>
Date: Fri, 13 Feb 2026 13:25:20 +0300
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: File name is not persisted if opened with O_SYNC and O_TRUNC
 flags
To: Christoph Hellwig <hch@infradead.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org
References: <4b207a36-5789-41d2-ac17-df86d4cde6da@gmail.com>
 <aY7T1LS5vnZI-ZxE@infradead.org>
Content-Language: en-US
From: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
In-Reply-To: <aY7T1LS5vnZI-ZxE@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-13693-lists,linux-ext4=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slavakovalevskiy2014@gmail.com,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 72549135097
X-Rspamd-Action: no action

On 13/02/2026 10:33, Christoph Hellwig wrote:
> On Thu, Feb 12, 2026 at 02:51:47PM +0300, Vyacheslav Kovalevsky wrote:
>> Detailed description ==================== Hello, there seems to be an 
>> issue with O_SYNC flag when used together with O_TRUNC on various 
>> file systems. Opening a file with O_SYNC (or using fsync(fd)) should 
>> persist directory entry. 
> No, it should not. I'm not sure who hallucinated, but O_SYNC has 
> always always applied to persistency semantics after writes and 
> nothing else.
You are right, opening file with O_SYNC does not persist anything and 
ftruncate or O_TRUNC do not count as write I/O it seems. Also found an 
error related to these assumptions in our testing tool. Thanks.

