Return-Path: <linux-ext4+bounces-14649-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cK0PI1ZPqWk14AAAu9opvQ
	(envelope-from <linux-ext4+bounces-14649-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 05 Mar 2026 10:39:34 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDA020EAE7
	for <lists+linux-ext4@lfdr.de>; Thu, 05 Mar 2026 10:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9835E306C87C
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Mar 2026 09:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036B237B021;
	Thu,  5 Mar 2026 09:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jG2lEdIy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9614437B014
	for <linux-ext4@vger.kernel.org>; Thu,  5 Mar 2026 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772703160; cv=none; b=HcvsjCCd1QBsOSk2vsGS5NSMn8SpCmOsuakKRANZpZo6Hxl4Dbyl9/vYOmJYfEM3qaQBm7rKt5hPvMgjTr30uszrbd4dGZhRfJKhtCGicHdDWH6YK7SW7aUiyupL2TIyWOFXkTQhLWfVzZu33A/BYEmHtP9DeYAm518I0lJ7NPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772703160; c=relaxed/simple;
	bh=NTI2sbNqmXefHVl9iq5aGjDsfbtqWEWb9pGbTAhKmbA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QzCnDXp5mE/pwoglyyYhibSocMmIuY73fomL9ij2Oo85IMdUonSKgPHObuD3ZGTylX5YzCZfYDBCgEkqmr1RNDNCHfQKKqzpdNoKYByPYhDkG6Ov+iwF0Ba+sMMATDQTQIdB31pwMIfSq3HOCAJcKZJQLhTwjE77PtwtlIoTIg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jG2lEdIy; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35995cb33a8so2172776a91.0
        for <linux-ext4@vger.kernel.org>; Thu, 05 Mar 2026 01:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772703159; x=1773307959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6YxMc0zSq1+O+4DI+93m766Ua5MlZWmUYfipBYyLeUE=;
        b=jG2lEdIy5LvJPs9ufYconitWsAzUepVcBeFffZROeOIiGrQMWX+lg1xNcV0ysHOeOd
         UNE/WsDJg6zmXXuuTVEuKbGjEV/8jkjrA/QJdTgqK0ecEaS8Vl+KK3r9gUzIhRSkqWOP
         sn9mljtddmD57o8sxB9KZHD0bz9P17aMkHZRZnp4T7iUa34JwE2yfWQHAhYVZip998M0
         Ogf6dT+VdBW7oLqCwJuuTeTnAW+XCNIzloKLmthAgYnnTR9EZe73MkdozmwGHS+OPn+N
         BrINXtX4gGKpwyg2B4XzgNQs9ySmN4paKYyNOo426Kn4NiajOQh+hUrK3piCVaAur9Ta
         o1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772703159; x=1773307959;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6YxMc0zSq1+O+4DI+93m766Ua5MlZWmUYfipBYyLeUE=;
        b=mzzW+mPTWlMowkMoWFDxGAZwt4+rRmBsxtnUJygt9Q7N0ODg0B10vNx7v43MZTRFCS
         hk3kqO3AaGqbNez4diiOJ71cwSGC5ooOSQp/aniID1Ecc/PDjbOPKyTP/Ltrj28/rFBf
         Mm+PLunCRmUjPfpWeQTnd5uD7amxrWhMaxEhw1rryYqkLGIXpcfZHC0u60ZrzNfFRKqg
         Yj0JXTl+gsZnnqWj8xVueJM2fIwkEwXJqV8yciRSvW8RDGsu7fM2SRaPJOGBoAvodyb9
         ULMzAoHDPa6Fz35VnBeAO2HEsnN2VPNMuIgOM1Y4uwQAk00FWC1qhslAaRbj5eW/dM32
         6WAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+uWxtIAtOfWm2eI2wBYhD/kGImLFENKZ+hBdXkl7RHe3bFurZPWyvBwPPIssRekfb8nCXZHbZgogb@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjj90jrnlcNgtU5s1LeZDIJbju5WPigzk/kx/WLpIFllaGusa+
	tKqXznBUg1I0Oq2RgEXASE4aAQTEIMHma73p3M0e2SbNR5iC9rGcL+w/
X-Gm-Gg: ATEYQzxHc13Gq/4PSwKDaec/i2tNQ+0MnzuNapjKR3zrMymC2vQe9hkBXA095YqaEBE
	sUaaChXjtYDlmVe1oYlmB2a+IQX8jWloHUJUat3XMd0HAZvYj4OIJxYpm9LyrY4BrHZDtKqSNhk
	A3gmwu6FsLX0BSxvlBLIiyV3qOcxSXWgIRH04D3rgvDY1fFqkKsdSC1tLhgh+IBogoqf/dRszrq
	BDboeskNilQfRtxUqWKQR6I9KbPV+WBruZ/8eYdfNWSAhX2pdp/JG0Eo3wt5LeWgkbMxmpBcNGr
	lqxKEXSmiJwGrkUaTmzlQftsWKtSi4+ka3l1nPqvL7a47Fk4OBGbjP8TchRMmzbMOT4T1mviLL3
	L2GYcQl3YvwzZ0BeA+Z6lJsbxBFUzfRE5b9D0LfJkkQws7zmV+N9UNZtT3datGAVOa6KiYdy8Hh
	OJtq0wg54n112PP1x8kTI6XeDFPhg=
X-Received: by 2002:a17:90b:5102:b0:359:8a78:5696 with SMTP id 98e67ed59e1d1-359b1ba0e7bmr1521475a91.1.1772703158842;
        Thu, 05 Mar 2026 01:32:38 -0800 (PST)
Received: from [192.168.50.90] ([116.87.14.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2d2b1c7sm1899251a91.4.2026.03.05.01.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 01:32:38 -0800 (PST)
Message-ID: <9078e07d-5997-41f3-9991-c1f6975c768b@gmail.com>
Date: Thu, 5 Mar 2026 17:32:36 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Anand Jain <anajain.sg@gmail.com>
Subject: Re: [PATCH 0/3] fix s_uuid and f_fsid consistency for cloned
 filesystems
To: Christoph Hellwig <hch@infradead.org>, Anand Jain <asj@kernel.org>
Cc: linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org
References: <cover.1772095546.git.asj@kernel.org>
 <aagzcbj_CohXgIXe@infradead.org>
Content-Language: en-US
In-Reply-To: <aagzcbj_CohXgIXe@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8FDA020EAE7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14649-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anajainsg@gmail.com,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 4/3/26 21:28, Christoph Hellwig wrote:
> On Thu, Feb 26, 2026 at 10:23:32PM +0800, Anand Jain wrote:
>> This series resolves the tradeoff by aligning btrfs and ext4 behaviour
>> with XFS: f_fsid incorporates device identity (devt) to remain unique
>> across clones, while s_uuid is preserved consistently matching the on-disk
>> uuid.
> 
> While I like fixing this up, switching the f_fsid construction to a
> different method might break things.  Is there a way to only change
> it for cloned file systems to reduce the surface of this change?

The problem is that we won't know which filesystem is the original
and which is the clone. Generally, the first one mounted is treated
as the original and the following one as the clone. However, f_fsid
should remain consistent regardless of mount order, at least for
the duration that the block device is connected (or until a
system reboot).

>> Patches
>> -------
>> Patch 1/3: btrfs: fix f_fsid to include rootid and devt
>> Patch 2/3: btrfs: fix s_uuid to be stable across mounts for cloned filesystems  
>> Patch 3/3: ext4: fix f_fsid to use devt instead of s_uuid
> 
> I don't really see that patch 3 in my inbox on linux-btrfs.


My bad, I sent the btrfs/ext4 patches only to their respective
mailing lists. I'll copy both in v2.

Here it is:

 https://lore.kernel.org/linux-ext4/e269a49eed2de23eb9f9bd7f506f0fe47696a023.1772095546.git.asj@kernel.org/


Thanks, Anand

