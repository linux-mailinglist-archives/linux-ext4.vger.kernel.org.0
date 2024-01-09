Return-Path: <linux-ext4+bounces-757-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BE982897D
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 16:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B24B1C2453F
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 15:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4102D39FEB;
	Tue,  9 Jan 2024 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfN1a3v9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D35B3987C
	for <linux-ext4@vger.kernel.org>; Tue,  9 Jan 2024 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d6b4e2945so37321565e9.0
        for <linux-ext4@vger.kernel.org>; Tue, 09 Jan 2024 07:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704815709; x=1705420509; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qBvYOhDE9HUrUc9mYwWMMBbTnM22iB1JVQDEJBHJ+AE=;
        b=QfN1a3v9TizzCYERhqEdZwr8GVH0ki981jl/5xCzQokijFcf5HbR4I1YWotwu68mEA
         9PuYJjDHPA7m4c56HOphHtUxe5dIMR7y1xYvlZPUbJtCRawd+QYMamjGvLyRzg4WKvEW
         IspcmbWIewNcEEca6UQR4iioihnumkQEHkB1Ew1zBNwT6l3hBfRY14X48wE2Mi6Y/j8/
         GLKIxAeeZXZTlN5ve7FJvcld/h0sCdAHLOkas+YCndNHSbCRGGbz8qPeNXmsGncwleF8
         C9e2AH2/8bp0p25eKxkI2U7b+HTn+fmi8i/iw+bG0WxeWG11GRL5YOUl06tgmZkS7Y6i
         ejyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704815709; x=1705420509;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBvYOhDE9HUrUc9mYwWMMBbTnM22iB1JVQDEJBHJ+AE=;
        b=fvtlXPNup9D2KJ5EXEHERRAxJValTMuu8gkGiRYmAJZF9qiQ2ycuNMiwlD074puowm
         HlRFbDTzEbzZpfpoW5aQh248u4Di0DsHhXMTIOjPlgIpK5mjvuC4sWhk0epipRQBmghP
         9JoEEUnM0EajtHU/XE6AhBuDDp44YtqBbuxH4+yDUF53wBbl+D2y9ttY0q8+AObrJCfb
         WCnyNhG++gEadqQW36XGU/pLXuMzsY1VmoQoxZ74V0ffYht8GNB0Hcz8GgN3rnfieRR3
         R8rrV2Pkc5e1E+MkJ6rxkLYy+kSDH2r3X9RyI8ru8UlCjdk1CZtYOtcyxsig+oeNebAw
         mfmw==
X-Gm-Message-State: AOJu0YwmedPw34UBVhKkcBdzhSZrbyryn3unO0kaNY80ZBXKitHikxAJ
	mvx9eRpMbWqd2+r5BishqIl+BtlMS64=
X-Google-Smtp-Source: AGHT+IF7fupE6C7zHAneqfLt1rer485kVuOBybNRefiGhokQ9e5Q4yAFfsWri+BH6P8K3AS4yx/sTQ==
X-Received: by 2002:a1c:7508:0:b0:40e:3c23:77f5 with SMTP id o8-20020a1c7508000000b0040e3c2377f5mr2068699wmc.72.1704815708980;
        Tue, 09 Jan 2024 07:55:08 -0800 (PST)
Received: from x1 ([2a02:2e02:45a:4d00:96e7:bff:fe65:b0ad])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b0040d5b849f38sm15483472wmq.0.2024.01.09.07.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 07:55:08 -0800 (PST)
From: Free Ekanayaka <free.ekanayaka@gmail.com>
To: Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>
Cc: linux-ext4@vger.kernel.org
Subject: Re: direct I/O: ext4 seems to not honor RWF_DSYNC when journal is
 disabled
In-Reply-To: <20240109135950.wb2lyclqxvnfzwbk@quack3>
References: <87ttscddv4.fsf@x1.mail-host-address-is-not-set>
 <87il8nhxdm.fsf@x1.mail-host-address-is-not-set>
 <20240108213112.m3f5djzesbvrc3rd@quack3>
 <ZZziDCELOmXK/zDP@dread.disaster.area>
 <20240109135950.wb2lyclqxvnfzwbk@quack3>
Date: Tue, 09 Jan 2024 15:57:19 +0000
Message-ID: <877ckio5y8.fsf@x1.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jan Kara <jack@suse.cz> writes:

[...]
>> I suspect correct crash recovery behaviour here requires
>> multiple cache flushes to ensure the correct ordering or data vs
>> metadata updates. i.e:
>> 
>> 	....
>> 	data write completes
>> 	fdatasync()
>> 	  cache flush to ensure data is on disk
>> 	  if (dirty metadata) {
>> 		issue metadata write(s) for extent records and inode
>> 		....
>> 		metadata write(s) complete
>> 		cache flush to ensure metadata is on disk
>> 	  }
>> 
>> If we don't flush the cache between the data write and the metadata
>> write(s) that marks the extent as written, we could have a state
>> after a power fail where the metadata writes hit the disk
>> before the data write and after the system comes back up that file
>> now it exposes stale data to the user.
>
> So when we are journalling, we end up doing this (we flush data disk before
> writing and flushing the transaction commit block in jbd2). When we are not
> doing journalling (which is the case here), our crash consistency
> guarantees are pretty weak. We want to guarantee that if fsync(2)
> successfully completed on the file before the crash, user should see the
> data there. But not much more - i.e., stale data exposure in case of crash
> is fully within what sysadmin should expect from a filesystem without a
> journal.

Right, which is exectly the tradeoff I need. Weaker guarantees for lower
latency.

All I need is that RWF_DSYNC holds up the promise that once I see a
successful io_uring completion entry, than I'm sure that the data has
made it to disk and it would survive a power loss.

> After all even if we improved fsync(2) as you suggest, we'd still
> have normal page writeback where we'd have to separate data & metadata
> writes with cache flushes and I don't think the performace overhead is
> something people would be willing to pay.
>
> So yes, nojournal mode is unsafe in case of crash. It is there for people
> not caring about the filesystem after the crash, single user filesystems
> doing data verification in userspace and similar special usecases. Still, I
> think we want at least minimum fsync(2) guarantees if nothing else for
> backwards compatibility with ext2.

I'm doing data verification in user space indeed. As sad, the file has
been pre-allocated posix_fallocate() and fsync'ed (along with its
dir), so no metadata changes will occur, just the bare write.

FWIW the use case is writing the log for an implementation of the Raft
consensus algorithm. So basically a series of sequential writes.

