Return-Path: <linux-ext4+bounces-9915-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B05B5285B
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Sep 2025 07:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B62B1B21CC5
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Sep 2025 05:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC81A255240;
	Thu, 11 Sep 2025 05:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="U7lkqRrV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84E324E4A1
	for <linux-ext4@vger.kernel.org>; Thu, 11 Sep 2025 05:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757570087; cv=none; b=Oq9Fdn9neAAWD5oZij7wsvbAZCHHBlrTLwsIImoKD2DmPyV2IfEZmz1oIPjxVxjgKFRLmqtvT6Hej9GNLOSJQZAUgbPMMgxwsAIVUx29pAjEhiTU9IFPRxGgGyxVxwy23guovEOIFKMSWyUxrGe+dGGqV4Oi7Qx8+/tM6EmMC/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757570087; c=relaxed/simple;
	bh=JLVGfMwisW3Y4JGot2IV80m6V+FOPM2PsbTbCgXGcNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJZzSwURgiD6Dqol1uUC61WtJv4bzr03vN4S3hT5aDzhBzT7B1+IEu1dTqqr1S46VAsBe+ALzJdVYfKpklEKBBjcxOgdWM0hRUncju0aZ+/kLy6bXQKxysQM4Yvb2X6uZPmnaCiqwQcMizMMD+I2PfNEaXL+4cMpzQ3GmbXBz8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=U7lkqRrV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24b21006804so3212375ad.3
        for <linux-ext4@vger.kernel.org>; Wed, 10 Sep 2025 22:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1757570085; x=1758174885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7U/qSpu3brb3YBeOIJTTylaUCIcvX4SeZCWNyYbixqI=;
        b=U7lkqRrVbCuJAFHEae+IPf77lWdCcl9IPLjkxHPq1hDp6w/xxREPaRlIYLQqdQqPjf
         eqmGbQRw/LOz+9HugJNnu9uwdm0d9qdNlAoB/mONG6pFTLG4T6iV+t8YM07yPAKcvDjy
         kJlLiEAVfTIYJE7Unm+MX8kaEz8b9CHfJwPQsVymf94xxwz/ftSwODDzotlgD7nN+lk5
         TvRaCZ/7RKt7JLWuQsi9OC+RMhL6mAG0CfbhYlXWTwnOeVJERmAeGLHu8HO10Tv/DTAU
         ZUrvqrWCDllvAoQY8ZI3TuI7XbsHmZKPTpDuA7OrZqIsGHI6itChFo5s8yeJHYrWqfYt
         wYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757570085; x=1758174885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7U/qSpu3brb3YBeOIJTTylaUCIcvX4SeZCWNyYbixqI=;
        b=qUNJDXFcygiBMTizeG+CF6YKJGouZbrQ7BVdW51GgQQTNgsls6MZnGid12jLpInT/J
         YyJhVQSq8uUPaLOVNo2v8DLeSzjtwXfuZgYgSvfwLzXaHpVFC2ZbWip+qmBcNDoJrc+v
         Iv3soIV7z9dgCjah0eHQDV7Aoa6YtwRwHG1Au66URlxHXuKNCOMcr8hBcqAIO1fBnxkW
         zfWh4AVIs+zJJIgF15o34agILIdlaDosi3gQRUQK4NSm05WQy7Z+WLU5U2ggKdzc4ZbE
         mxrCmCr/SUCyyoaz9PmHhMGlIr2T8xVpwUdBbqqc9lVhkc/XksxirtGkLkvuPWfm5TUS
         jy7g==
X-Forwarded-Encrypted: i=1; AJvYcCVWl9Yx1d5JJ4f2sDGJK9W05Hj7Ai2/FwRElywqgkJzceio/Q0ZclSyxEbZPm/XQNZLo/8nAeQbQt2v@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7AooWRH4ZAzlieSzxH57Gp55KFe6utzEkTD3O/o2B+B5nX8/C
	TBEARA6g+RcKPHyBSu7h6xJuNnO5NM6oxKzsNb5Qch5xpqvzXNuqGfjoeOjKFXL7Ers=
X-Gm-Gg: ASbGncvGd6YAgGvdgfSE5Nk3PlMBojpuNznQrqtn4GOb0na9K+OTnaBfU2xXdl12GR+
	pCIDPUjAkZty8gCQ0+WeC7JT5+r6Hst7ATQcQf6lwhK4dQCw3xO7bNB2Sdlmlck9qajyDGPJsiV
	SqOf1d1i/Qf+i4vHKaBvmE1vJOKnFe4Hoee4/OTgJXudA38c8T5mMLlYXZz6OMqMMdeyQvRLvVZ
	O9RymXmJoYF9H9AIRTUAjSGPfIUBQs5P+QxFhQOnKcC3iULEqnHuxXQc8KjtQaT4uZIfVIBqhR8
	h/Daot6DNaiPO7fE/jbuVi5lj0UK/4bmGbB1noEz77sLbSrMF5O1IAJh8MKlR4dYWUOJ/5/2yx9
	aHKEjsO11N/2RX7Q4HlQK8v80zHvI7+/izngmPMVXc1xaSnoXR+eiPJk23TT9RhG1Vgc3DleqF5
	tvH3VqAPgL
X-Google-Smtp-Source: AGHT+IEJ8EWH4EX2E0dT8s/g+9UDN2nb1wl7crNvle8QYhSW73RtvbWKXJWPfnOBHU1es1wXSTrLow==
X-Received: by 2002:a17:902:c946:b0:25c:5a14:5012 with SMTP id d9443c01a7336-25c5a1457bemr5452105ad.1.1757570084813;
        Wed, 10 Sep 2025 22:54:44 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c36cc6c59sm6905715ad.12.2025.09.10.22.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 22:54:44 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uwaGX-00000000QEt-1mcY;
	Thu, 11 Sep 2025 15:54:41 +1000
Date: Thu, 11 Sep 2025 15:54:41 +1000
From: Dave Chinner <david@fromorbit.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com, kernel-team@fb.com, amir73il@gmail.com,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ocfs2-devel@lists.linux.dev
Subject: Re: [PATCH v3 1/4] fs: expand dump_inode()
Message-ID: <aMJkIbDwuzJkH53b@dread.disaster.area>
References: <20250911045557.1552002-1-mjguzik@gmail.com>
 <20250911045557.1552002-2-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911045557.1552002-2-mjguzik@gmail.com>

On Thu, Sep 11, 2025 at 06:55:54AM +0200, Mateusz Guzik wrote:
> This adds fs name and few fields from struct inode: i_mode, i_opflags,
> i_flags and i_state.
> 
> All values printed raw, no attempt to pretty-print anything.

Please use '0x' prefixes for hexadecimal output.....

> 
> Compile tested on for i386 and runtime tested on amd64.
> 
> Sample output:
> [   31.450263] VFS_WARN_ON_INODE("crap") encountered for inode ffff9b10837a3240
>                fs sockfs mode 140777 opflags c flags 0 state 100

.... because reading this I have no idea if "state 100" means a
value of one hundred, 0x100 (i.e. 256 decimal), or something else
entirely. I have to go look at the code to work it out, then I have
to remember that every time I look at one of these lines of output.

When I'm looking through gigabytes of debug output, it's little
things like this make a big difference to how quickly I can read the
important information in the output...

Otherwise it's ok, though I would have added the reference count
for the inode as well...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

