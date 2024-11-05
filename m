Return-Path: <linux-ext4+bounces-4968-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5B79BD02A
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2024 16:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0631C21AC1
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2024 15:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C824238DD6;
	Tue,  5 Nov 2024 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wZMzeTBp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF78C1D90B4
	for <linux-ext4@vger.kernel.org>; Tue,  5 Nov 2024 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730819518; cv=none; b=q8l2sFMf8o0TTikY0dNI3ibOPfQ2fdIDaPdzgEJe36Dqlw4g/KLt/z2gExhOhSLmXTA+3TQidSSSBLtVWrSPDVDIcL5PFTHModivvZq8vbI/5wJQuywjKYFq66/4B45LQv5wKby4rpc7yGMaNpeWd0A6hMyg3rr+rfe42XbwUkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730819518; c=relaxed/simple;
	bh=eoJshfMY3GJ5a+HHGfGtlgMreRED5NlAGt3XNM1/SBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Th1xMg23iBxLSWXKidQzdyRMByWYYqG2L0xcYuw6g3vgnwXYxfguOWjLK0ycy30S4Gt6y2DawkJ8PVA+tJZoLfEfWCHjsgKryKwPr178eXBl9C1uLCEw6c46m6X9YvvQP7QDGpjbn4YBSkogoOZ2Z8Kpgb0XQliIm508TKe8Bis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wZMzeTBp; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a6adaee7acso18281665ab.0
        for <linux-ext4@vger.kernel.org>; Tue, 05 Nov 2024 07:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730819515; x=1731424315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SWwAKBYPKBxi+Egnr6GkcZQMq1o5kRfwuupexQV/vk0=;
        b=wZMzeTBpaFN8AN4gACNFFscUj+hnV3rmk0h/ZOxBJSXkxH39wmNXFq6f4Z4ynE45xI
         wXsEkTh7+AHFIn1Hqe5MY5Za428sZqSQymx2ow4mcbRlkikQvNhwfvOxm5nS75LbMH9c
         MKnGyYzR3bjkWGinlqYvq2aMYVSFRyGhkz4negaqkgRP+vc3FWH2N+vESIMswOas4xf0
         xP8Nfb6wQCldcdc4/v2SvJ+FxgOtfQ5mA+g0t34IT3NXdF4MxJjn3epUlu7ei6DXuBXm
         JiV6xOdImX72QxVsA2YMO7wAtxKME/N2pQkrauBtFHr+LtPeirDEMPbR3VLUeYuxV5fd
         n1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730819515; x=1731424315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SWwAKBYPKBxi+Egnr6GkcZQMq1o5kRfwuupexQV/vk0=;
        b=m4TRvKhBgs8vJh0IW+pi+q0vmCzvOyKv+xXh/6kVExzHo7OIWrp4/gi881yTAxz2Ck
         EJQ0MKFSR1SGY7TA+d7ioE9Na8qi2sMadr5oW7GUkgPMcK33jD3Px4WY3zpFfP0oUCqi
         Gci5t8OgmzvIOGwnq6tR1bwl5p573H6ky5Iha9AmDeRjUFHB7D013C5fK+mfwFsTYdOf
         ZbO9FO14Tuey7qSCz3bAePM4iuMxmwKNR5AI3juXQLXDOT84tw7OOM30wjA32l3NUrGr
         PvN0Gxx3tf4pjKwWAZ/BgYE3cTJr6MCrtREYrILAn5mitIAXJpI1rpBLX1GtqJkSWVN7
         spmg==
X-Forwarded-Encrypted: i=1; AJvYcCXdV73SmyeLHItJ1/OMTzWEULQf03pLGRY2s1vcyqEdOFT8mKH5en6QhePyugyXudYL3YY2xMU1rEdT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4zZbJE7lNx/xLkN6iM4VOhMrxCqJ2QWoUObcBZpsWH6dOsT2x
	ioxyHeV2cynz/MGGHBDfLzN13lDPIhw0XVdygnAmLnqd1wR01W2oOopF/8X/ils=
X-Google-Smtp-Source: AGHT+IGDX75ZExNONHJoHGRJ/IqT5vn5gVmGAZ8JGgbv4qy8khE6jtcPyWRkSO7ad0xRLtuL8OZmSQ==
X-Received: by 2002:a05:6e02:16cb:b0:3a6:b0d0:ee2d with SMTP id e9e14a558f8ab-3a6b0d0f518mr139871665ab.9.1730819514844;
        Tue, 05 Nov 2024 07:11:54 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6a97cf520sm29049985ab.25.2024.11.05.07.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 07:11:54 -0800 (PST)
Message-ID: <5557bb8e-0ab8-4346-907e-a6cfea1dabf8@kernel.dk>
Date: Tue, 5 Nov 2024 08:11:52 -0700
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] work tree for untorn filesystem writes
To: Theodore Ts'o <tytso@mit.edu>
Cc: Carlos Maiolino <cem@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
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
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241105150812.GA227621@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/24 8:08 AM, Theodore Ts'o wrote:
> On Tue, Nov 05, 2024 at 05:52:05AM -0700, Jens Axboe wrote:
>>
>> Why is this so difficult to grasp? It's a pretty common method for
>> cross subsystem work - it avoids introducing conflicts when later
>> work goes into each subsystem, and freedom of either side to send a
>> PR before the other.
>>
>> So please don't start committing the patches again, it'll just cause
>> duplicate (and empty) commits in Linus's tree.
> 
> Jens, what's going on is that in order to test untorn (aka "atomic"
> although that's a bit of a misnomer) writes, changes are needed in the
> block, vfs, and ext4 or xfs git trees.  So we are aware that you had
> taken the block-related patches into the block tree.  What Darrick has
> done is to apply the the vfs patches on top of the block commits, and
> then applied the ext4 and xfs patches on top of that.

And what I'm saying is that is _wrong_. Darrick should be pulling the
branch that you cut from my email:

for-6.13/block-atomic

rather than re-applying patches. At least if the intent is to send that
branch to Linus. But even if it's just for testing, pretty silly to have
branches with duplicate commits out there when the originally applied
patches can just be pulled in.

> I'm willing to allow the ext4 patches to flow to Linus's tree without
> it personally going through the ext4 tree.  If all Maintainers
> required that patches which touched their trees had to go through
> their respective trees, it would require multiple (strictly ordered)
> pull requests during the merge window, or multiple merge windows, to

That is simply not true. There's ZERO ordering required here. Like I
also mentioned in my reply, and that you also snipped out, is that no
ordering is implied here - either tree can send their PR at any time.

> land these series.  Since you insisted on the block changes had to go
> through the block tree, we're trying to accomodate you; and also (a)
> we don't want to have duplicate commits in Linus's tree; and at the
> same time, (b) but these patches have been waiting to land for almost
> two years, and we're also trying to make things land a bit more
> expeditiously.

Just pull the branch that was created for it... There's zero other
things in there outside of the 3 commits.

-- 
Jens Axboe

