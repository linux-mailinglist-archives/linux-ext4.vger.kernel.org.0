Return-Path: <linux-ext4+bounces-4965-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EAE9BCD16
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2024 13:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E9728275D
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2024 12:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A686C1D63D4;
	Tue,  5 Nov 2024 12:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="i/3V9+s3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAFD1D61BC
	for <linux-ext4@vger.kernel.org>; Tue,  5 Nov 2024 12:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730811132; cv=none; b=gQ3cpetTYMXS44N4RxPEYAuVTlqsTmBe7KiywHVn4ccMVd5OxkkJ7TTlPK//YnjJ0zz9iupZbsgz2iNseTVKeLYubrI4JeHyxVXTeCcAc0o1OZoU+oSImkPP/LD+KDI/UFgOw1onb6HbY0J/X8V8nwq2jGm+0oH0UHm1PrAcEgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730811132; c=relaxed/simple;
	bh=5AavB2k8eTzT+b9vnQylCFfBcymntVGRSHXHCEWFvuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mtxU2agrZ/DijUKERNYdcZG09zI6XHvg2kI8NT4bwgjKqNNaNEia+/wWr4uklx5oZlYytF10SpNwh/CWfg7C6OK/rWgUXT1ctajpiDbxEmrYHo8QmI87Z3nD52PYV/uDBOvWZ1g7tBxX/6qmgDuG2j6lHPTTEKQe28ZLGn8uiiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=i/3V9+s3; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e2cc47f1d7so3853565a91.0
        for <linux-ext4@vger.kernel.org>; Tue, 05 Nov 2024 04:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730811128; x=1731415928; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=At2805czTihicDRdY+YJdDpwWq0X5S/HDbS43yOjnkM=;
        b=i/3V9+s3/JNEFfHOcuRpBzd5G7491DomHO3MF90MHZr8nK8fiYJ+KudnQUZquDj8b6
         q45RrF536g5AH9//3l+BOQjbAHt58ppvReuxu5e3yaqb7r9oEZMX3lmp+3tcyFHTSHzy
         8GCycCWQlYOpKejYxa4qUFhVBlgQaIKYyPHncdAnpi31kmHc72bcE3+saecPfyG7O4A5
         7auenblDUBKF4Yjpe5RZ3yGBgcHjIq/ZD79uzbAtuiUNbCQC9JvGE57DFYLpep7tdnmi
         r1ogtFk78mBsXAhjUM1xCDvzqm80jvNF1b3OFJ/g2YRpTzrwawYA4S2HFhXrIIrJrK6s
         kh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730811128; x=1731415928;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=At2805czTihicDRdY+YJdDpwWq0X5S/HDbS43yOjnkM=;
        b=V4P/W7kVQAp985RzcURB1U/XiEUDgpc9sdLFVSgoMKiPlrfq7fjdEwk3ia3e6hPXBT
         DAA3An6fJNZmdSjROU1L2B12nFdPUZgn0AeSUXfIG21/d9Zeh7bxqiiXlGEwulWvh6s2
         Tj5tLtwl3ToqrXfMK9uo01FdFOd+gORCNum4L1cA5dpvil94gP1W4L0he4aVfsL4lv/D
         td/iygmn8fsT+10G6/A96aYKAfRMPmhF7ernATuNoGv2nSi+MFIBdoFer7UDJJQnU1xw
         Ys20ZAFfwipA5dhQhTo1xjKzGrWGNo1wcNMYNRVEIl2nczVcUJnHk8XEsRA85PCiWL83
         T1Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVMyoXme7rVRI2Kt778cwetf0cZCNWBkSwdc2net2FRm3EJB3AqHFoEO3cNGE3atrgFnDNss3ZqiENg@vger.kernel.org
X-Gm-Message-State: AOJu0YwW8HyotK4rZLrn8yhHkbV1DDbS74syH3PBUCoxH0zuH4v3PR1+
	EQ8ttTGK0LvjeQ+L5Ixi6M1xn3qAd+fOSqQd2hS+C3KnmWGDfSyCEd/C0zqXxCM=
X-Google-Smtp-Source: AGHT+IFZ2rqlU9xmlbidWBPBOCsO4c5ZoLFE3W7KH4q7MLqnYLyStlgN4LLR9uK8B2J9oi1JSXBZXQ==
X-Received: by 2002:a17:90b:540c:b0:2e2:b94c:d6a2 with SMTP id 98e67ed59e1d1-2e93ddf4d4fmr29684686a91.0.1730811128404;
        Tue, 05 Nov 2024 04:52:08 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fbe0252sm11939317a91.45.2024.11.05.04.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 04:52:07 -0800 (PST)
Message-ID: <72515c41-4313-4287-97cc-040ec143b3c5@kernel.dk>
Date: Tue, 5 Nov 2024 05:52:05 -0700
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] work tree for untorn filesystem writes
To: Carlos Maiolino <cem@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 John Garry <john.g.garry@oracle.com>, brauner@kernel.org,
 Catherine Hoang <catherine.hoang@oracle.com>, linux-ext4@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
 Christoph Hellwig <hch@infradead.org>, Ojaswin Mujoo
 <ojaswin@linux.ibm.com>, linux-block@vger.kernel.org,
 Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20241105004341.GO21836@frogsfrogsfrogs>
 <fegazz7mxxhrpn456xek54vtpc7p4eec3pv37f2qznpeexyrvn@iubpqvjzl36k>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <fegazz7mxxhrpn456xek54vtpc7p4eec3pv37f2qznpeexyrvn@iubpqvjzl36k>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/24 4:19 AM, Carlos Maiolino wrote:
> On Mon, Nov 04, 2024 at 04:43:41PM -0800, Darrick J. Wong wrote:
>> Hi everyone,
>>
>> Nobody else has stepped up to do this, so I've created a work branch for
>> the fs side of untorn writes:
>> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fs-atomic_2024-11-04
>>
>> Can you all check this to make sure that I merged it correctly?  And
>> maybe go test this on your storage hardware? :)
>>
>> If all goes well then I think the next step is to ask brauner very
>> nicely if he'd consider adding this to the vfs trees for 6.13.  If not
>> then I guess we can submit it ourselves, though we probably ought to ask
>> rothwell to add the branch to for-next asap.
>>
>> PS: We're now past -rc6 so please reply quickly so that this doesn't
>> slip yet another cycle.
>>
>> Catherine: John's on vacation all week, could you please send me the
>> latest versions of the xfs_io pwrite-atomic patch and the fstest for it?
> 
> I am kind confused here now. IIRC Jens pulled the first three patches
> from John's series into his tree, and John asked me to pull the other
> ones. I'm much happier to see a single person pulling the whole series
> instead of splitting it into different maintainers though.
> 
> Giving how spread the series is, I'd say going through vfs tree would
> be the best place, but I'm not opposed to pull them myself.

Guys, not sure why this is so difficult to grasp. I already pulled the
initial bits weeks ago, into an immutable branch:

https://git.kernel.dk/cgit/linux/log/?h=for-6.13/block-atomic

which was subsequently also pulled into for-6.13/block. Whoever wants
to stage the xfs bits must simply:

1) Pull the above for-6.13/block-atomic branch
2) Apply XFS bits on top

Why is this so difficult to grasp? It's a pretty common method for cross
subsystem work - it avoids introducing conflicts when later work goes
into each subsystem, and freedom of either side to send a PR before the
other.

So please don't start committing the patches again, it'll just cause
duplicate (and empty) commits in Linus's tree.

-- 
Jens Axboe

