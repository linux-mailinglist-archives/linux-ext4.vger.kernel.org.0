Return-Path: <linux-ext4+bounces-14192-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ETVGIEmoWlmqgQAu9opvQ
	(envelope-from <linux-ext4+bounces-14192-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 06:07:13 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA291B2CE3
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 06:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2D3D30E7846
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 05:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FB1362125;
	Fri, 27 Feb 2026 05:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+Ziqtbn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC412D8DC2
	for <linux-ext4@vger.kernel.org>; Fri, 27 Feb 2026 05:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772168821; cv=none; b=ZrDlsMfPRt1BGQnMGUpPvJu+kiXa34EXc1jHjbQwlzApcq1EqiK3SQ2mFbZshiSLxFpPF6Nl8YAofnAs5Yu5zDWeyr5rt3GI0kldvW0ajj2BidSPNAtmeJhTpeYHErtbHRzRel93iWUteScOTTTkMKdwitHASaJ3ncZonrg40RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772168821; c=relaxed/simple;
	bh=zSGHnBJ5pNX5vyeUAoVCHxB6L3jgL0JJmCniFSp8230=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpLitUp+gi1YZaCs3fiRRcX8K6dP6Dq8/U493a5poCAj3IyBgcqYcjRqAFe2O11yG8Vp9rU0DyFQHrJXskH/1Kkbsd2Q2re0pjLIa9YO6bVbopPkYM6hp8HIFLtHd2/gw3ffnxDOm8z0CykAJhf9H35YPnufh0OtXfdKlHgYH7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+Ziqtbn; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1270adc5121so2081567c88.0
        for <linux-ext4@vger.kernel.org>; Thu, 26 Feb 2026 21:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772168819; x=1772773619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSGHnBJ5pNX5vyeUAoVCHxB6L3jgL0JJmCniFSp8230=;
        b=X+ZiqtbnvagQBY3CNdb3cU/6eydN/IApzxHls27yLuJiw1IeXFluttmFmlO99WSkah
         T7riDOFSfhJe4+/FCDJF+tIwU5Ta95DlA4xbB5AnmFHcui2OEa3ssmkUAZ0UAIIU6GGC
         CL2p4l2REHtfwITrUoVYYjYb/FqqY6ibJ/ZBP/P69bcnI8zboazAoglo+m+8aObJjUcH
         XgGYkQaWDHodLIOIXgYFj0gL3xCY0J2Uan12lU27zdhV+SYrSJ3RJaRL+oZc/fQyV4Z4
         UBwJPar7IprE8tw67w/Q9S7Bfqavtvr1npyppPvvF3SkHQuNRUvzR+W2Mj3wFIZzAJ5t
         nWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772168819; x=1772773619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zSGHnBJ5pNX5vyeUAoVCHxB6L3jgL0JJmCniFSp8230=;
        b=QKIifhk9l2htPMCvc8NYHG1PAwsGCA4VVtihke8qswCqxORA25U+dM2k/MWAVcvGRS
         36HshNbxFn1jE67L8t65inErLLd8RUcwrWNMEQz+83gynKKESakSZtJgmHYy7ue21Egp
         op408xLuJcsrhXwOdtMK104/uF/5SrEYUuQW718W9KIvF6nJ4gs0FovNknTZeIJpqKEq
         7Swh775sVz/O+0Y1FzEJDEWxZoWwBeXLYmzSFfpz1Xvr36iM2iZZq0ZbyfjQI3mzgV76
         oC4KvUiUkyiwAfzsaQfcaM+w31qB6P8e1xqXu6S6AN5DDNyAr5nEZ5BvmZ6bqd/wOhXY
         xNSg==
X-Forwarded-Encrypted: i=1; AJvYcCUQg6T9XoH4WnWWeRgK1/LRQE9b0ngj5JMa9/eKIjUShAiyycDUVG54hR3pb/ftpTqx9XgrYMdU4j1r@vger.kernel.org
X-Gm-Message-State: AOJu0YyEmcKnJ5r2nlotwW9YBSnLY6quUilI5pJSTBMdIngnNKR+75z7
	b48/6ZBd4vY3RQm6X/h0A3Y1r/HZP476hiWqabydgcMmaCNi6UU5bBvGBu/rvqhB
X-Gm-Gg: ATEYQzzokfebU15jmRuyKS+tkJlOhCbmM5/oYGcAxlLAPDxVjh0Se3SXzT/58eSzpTI
	rJTMM2AHSUzDvALA7CsV/B0O1a4UbOYc6JYX74y80IhBWX5bRt3ttalbq66flEofAz8CmwswsGS
	obphGX3OWQWOfxqYFJz6IHnnotKatO3M3bG3wkpjIjWeSw7LVXvgBD7tejz8nnKKwlyobd/araz
	a2zQ0iMJ6lzTMOYrCasL2k8jQonzcvL+ads/RYnyk0+pst2aQIzp4ikuH0C8nGsNvdZ2Gw0QIHR
	YSQPj3vMYcYyf9u5Xu4THEYsc77EYzbkpk9n4G1ztvRZHK3TqMrM8UicnOn1zfa4r9qHYxSPN6g
	Ia5iRLgNry5zEaqFC9pp7P0kv6IUeBtRLqvdnA99PsF39lco1LJUuuKU5GCqtE/Rrf3Toi/oB9b
	LiHdolhooongdul5T46UcOmHXSSAPDcPGOJZU8+Lggo6O0RHjPemvOk1d+s1oTO0iVFAtRLsgTr
	2Lr/nshX3QclhTN4Ovl2bd1DS/L1lV0oCIv69kQiUxcWqE031AhNf3bpugYWwJfbA5dvdsrdID3
	trX+yY7DFr2GWvJQe48I/yMKL1nl
X-Received: by 2002:a05:7022:239c:b0:11d:f440:b695 with SMTP id a92af1059eb24-1278fc20cd7mr641627c88.16.1772168819223;
        Thu, 26 Feb 2026 21:06:59 -0800 (PST)
Received: from arch.lan (c-98-51-119-100.hsd1.ca.comcast.net. [98.51.119.100])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12789a32dabsm4273872c88.11.2026.02.26.21.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 21:06:58 -0800 (PST)
From: Milos Nikic <nikic.milos@gmail.com>
To: nikic.milos@gmail.com
Cc: jack@suse.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext2: guard reservation window dump with EXT2FS_DEBUG
Date: Thu, 26 Feb 2026 21:06:57 -0800
Message-ID: <20260227050657.13451-1-nikic.milos@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260207022920.258247-1-nikic.milos@gmail.com>
References: <20260207022920.258247-1-nikic.milos@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14192-lists,linux-ext4=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikicmilos@gmail.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BCA291B2CE3
X-Rspamd-Action: no action

Hi Jan,

Just a friendly ping on this patch now that a few weeks have passed.
Let me know if you need any changes!

Thanks,
Milos

