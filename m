Return-Path: <linux-ext4+bounces-4970-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C389BD121
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2024 16:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990CF1F23CC2
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2024 15:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324151531F8;
	Tue,  5 Nov 2024 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0izHAbJR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179F513E04B
	for <linux-ext4@vger.kernel.org>; Tue,  5 Nov 2024 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822084; cv=none; b=p/+Fc3JXYHAGKJ1FZUTVsR86IIiiq2fvmE+i0qVupdAumS6fHNQEoTGvL4xJPpdFDuXBR4pGsZR5idvNQbwiyIOfVkQSoeNGZGRblihsqIp+JdSvHin52C8Zojouspb44CU9BH9USdH3uBvR3bwVUBLRRg9ANvnB2+UU81Kl/Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822084; c=relaxed/simple;
	bh=GmDcH9fH5CQZbjDIsLa9zbmwEVBfpSGCcfdtLHzHg2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=THDD5GV6TIksXEPenOk1QGZNvAnoi3JgiFm3kc38qsW8XZfOi1oQHovrbspCApxXq9l9i4f/I8WS9uQxnu5EGE3L62ERuK2ElI6mbFNsCTzdrO3vU9xzaUKr/5qdr61K9lJP5RrSWsOW5BNgAKYBq/c+ra9q7KiwPuctrnxGxCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0izHAbJR; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-83ac817aac3so210434239f.0
        for <linux-ext4@vger.kernel.org>; Tue, 05 Nov 2024 07:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730822082; x=1731426882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UMblOGMbazjLmtJYQwpwJ6Rzx7y2x3BU21hGqMAlPmE=;
        b=0izHAbJRVwll4z5mbE1BJzWzmBuFDr0o06EdNjUl2w1IfJVIfdpoMcLOaKuyvGyAFb
         RqaY3jIURqOVA8rBSG+Ib+GFBtydW7P0JKTt9Xyl3EVPByCKgwdypKq+uD2BQzsKx7Kj
         SHLO/zgtcNpdtlleYHDv3SwRybnon2a1Wb2l5F040/G3oKxXRX8A1SJV9kUGiRLpjS8/
         QfCls6vEa3aF3YctnQjHS3Xsw5nx4ukOKcoCESWaijGy4Zc2jg7DqpPd86i/Edbkd2Rs
         vyGSwzaYG25kzp9EyVWpqSoyHUQOv1cXHosWs772iAnCtq/10hgnBDspGPx7XiqvaUYn
         rO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730822082; x=1731426882;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UMblOGMbazjLmtJYQwpwJ6Rzx7y2x3BU21hGqMAlPmE=;
        b=fm9VwVjrE0TyMHyKqmqZBtztiLDk6cDpdq2i9qgAdtW28+Op0T29y87Y6MbT8g6pWK
         5wOxA9bwnFmjSURe8UzvIjKbTMTjGX86JEugQfFsW3NbWANWYlZ9BYNXSKKf4dEz1R75
         dU9ajFLc1shZiERa+A3BC4iHahIpZTUJzYa02rCNYfEUlJq1Wwo1TQS4z3sXFqcjuidZ
         GlEZEzKB62NGQLDxHds9RFwlmgN+iUc3cvEnBiZ58SiVM3RKFFwqFU0VC5Na/1xPTfE3
         VDPGnNBzsLnFspbP6PMq3E76P6AElVCTVf5Vw6dmD13Mt7v/JmYmM8LveMK5Sty0rZa7
         RoHg==
X-Forwarded-Encrypted: i=1; AJvYcCUmGcxBYVg9ldySbxLBr8hsB+8I0ybVaVgsR04l9RxY5WgvC7F0d9VAcRN4Hk9PtbHzSB/36pd9Az0g@vger.kernel.org
X-Gm-Message-State: AOJu0YxLvyzZrhmrgzXQx9WKULcCEMRA7UecyZrFriTvFlbRZ44dxsS7
	iv28dGmsQKNMEWInaH7xeyiwNrzEgeieV2nslIGqzujLw8YV+4MiQ6QjcpJwOec=
X-Google-Smtp-Source: AGHT+IHx4XYVdOEQB1fuv7KmfyxWz/fsEeyxbyhyP0PnEBcHFIT24et7k1hv3V2APh3M3l0s92OUBw==
X-Received: by 2002:a05:6602:2cc8:b0:83a:f447:f0b9 with SMTP id ca18e2360f4ac-83b56712446mr2807793039f.9.1730822082167;
        Tue, 05 Nov 2024 07:54:42 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83b67aeacfdsm271817939f.9.2024.11.05.07.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 07:54:41 -0800 (PST)
Message-ID: <00618fda-985d-4d6b-ada1-2d93a5380492@kernel.dk>
Date: Tue, 5 Nov 2024 08:54:40 -0700
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] work tree for untorn filesystem writes
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Carlos Maiolino <cem@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 John Garry <john.g.garry@oracle.com>, brauner@kernel.org,
 Catherine Hoang <catherine.hoang@oracle.com>, linux-ext4@vger.kernel.org,
 Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
 Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-block@vger.kernel.org,
 Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20241105004341.GO21836@frogsfrogsfrogs>
 <fegazz7mxxhrpn456xek54vtpc7p4eec3pv37f2qznpeexyrvn@iubpqvjzl36k>
 <72515c41-4313-4287-97cc-040ec143b3c5@kernel.dk>
 <20241105150812.GA227621@mit.edu>
 <5557bb8e-0ab8-4346-907e-a6cfea1dabf8@kernel.dk>
 <20241105154044.GD2578692@frogsfrogsfrogs>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241105154044.GD2578692@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/24 8:40 AM, Darrick J. Wong wrote:
> On Tue, Nov 05, 2024 at 08:11:52AM -0700, Jens Axboe wrote:
>> On 11/5/24 8:08 AM, Theodore Ts'o wrote:
>>> On Tue, Nov 05, 2024 at 05:52:05AM -0700, Jens Axboe wrote:
>>>>
>>>> Why is this so difficult to grasp? It's a pretty common method for
>>>> cross subsystem work - it avoids introducing conflicts when later
>>>> work goes into each subsystem, and freedom of either side to send a
>>>> PR before the other.
>>>>
>>>> So please don't start committing the patches again, it'll just cause
>>>> duplicate (and empty) commits in Linus's tree.
>>>
>>> Jens, what's going on is that in order to test untorn (aka "atomic"
>>> although that's a bit of a misnomer) writes, changes are needed in the
>>> block, vfs, and ext4 or xfs git trees.  So we are aware that you had
>>> taken the block-related patches into the block tree.  What Darrick has
>>> done is to apply the the vfs patches on top of the block commits, and
>>> then applied the ext4 and xfs patches on top of that.
>>
>> And what I'm saying is that is _wrong_. Darrick should be pulling the
>> branch that you cut from my email:
>>
>> for-6.13/block-atomic
>>
>> rather than re-applying patches. At least if the intent is to send that
>> branch to Linus. But even if it's just for testing, pretty silly to have
>> branches with duplicate commits out there when the originally applied
>> patches can just be pulled in.
> 
> I *did* start my branch at the end of your block-atomic branch.
> 
> Notice how the commits I added yesterday have a parent commitid of
> 1eadb157947163ca72ba8963b915fdc099ce6cca, which is the head of your
> for-6.13/block-atomic branch?

Ah that's my bad, I didn't see a merge commit, so assumed it was just
applied on top. Checking now, yeah it does look like it's done right!
Would've been nicer on top of current -rc and with a proper merge
commit, but that's really more of a style preference. Though -rc1 is
pretty early...

> But, it's my fault for not explicitly stating that I did that.  One of
> the lessons I apparently keep needing to learn is that senior developers
> here don't actually pull and examine the branches I link to in my emails
> before hitting Reply All to scold.  You obviously didn't.

I did click the link, in my defense it was on the phone this morning.
And this wasn't meant as a scolding, nor do I think my wording really
implies any scolding. My frustration was that I had explained this
previously, and this seemed like another time to do the exact same. So
my apologies if it came off like that, was not the intent.

-- 
Jens Axboe

