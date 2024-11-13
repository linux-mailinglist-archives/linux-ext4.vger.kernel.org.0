Return-Path: <linux-ext4+bounces-5128-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1B59C67F4
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Nov 2024 05:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02251F23EB0
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Nov 2024 04:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9564F1632CA;
	Wed, 13 Nov 2024 04:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aH8CGpx1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC762566
	for <linux-ext4@vger.kernel.org>; Wed, 13 Nov 2024 04:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731470662; cv=none; b=PIdg3BvdOYRVv4nqB0MYAOi6UyoEpguSCyNg6W93TBPhWa7zjIc9Tk8g7wFlLQIZ9kdShGnSawzGDqcRSVkVoEWKjg7L0wbOdFSkvWXICTw4Q77GZlw4olC9nS/ltPjTqu8HfqQ2FfU7EqyQht2lOU3dc6NCgFDDNCJq9EDDuow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731470662; c=relaxed/simple;
	bh=vPFOHp2CC6TEPHTGA6cKL8S6kkkxXN/ztLmi6PWlB+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBcPdYz0bAbm7mqKRmgIt/o+QPqJ5s25hzVqjYtJd2eUxVZwz/RsJAOZoSHyJ7xQMK9GH5A43gM35go1l1ZpLGx+bmWjnEjMZU8/UU6XafPKjlJBSzmqX4FcMtw5jY7cBDDUfKN/DrXYOrl85ZLBVk0mva6GZODfch7/cvx6kHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aH8CGpx1; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-723f37dd76cso6679985b3a.0
        for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 20:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731470660; x=1732075460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mw8a3ViX6RzOGhfbloDj6IPahlwyKfVtIHPZfv2Tt0E=;
        b=aH8CGpx1r86nbSjQO2QS3j8B/5C0/qDd9Nku4C0fDailDZvulDc2oJyz9qF0bONEIJ
         UM+mk4Z9+m2nqj8GIVBWY07gvg3PKoFX0jldCHXfiuyp1w1N5Uz6/XbN0BKQkRx7mR6g
         lEA5GLbSHTebjbSe464r1iJ6Nxs1e99nl1Auw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731470660; x=1732075460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mw8a3ViX6RzOGhfbloDj6IPahlwyKfVtIHPZfv2Tt0E=;
        b=ubg6fd5e9Ocbo3davkR0P3iGtACragYRPLuoM2KUBdeysq1c3DH6vCFbLa+tLcXqNS
         y01jtU/moiKND6W7Y+6uwwoOK77bZSdlyQjlRSFeviPMQVS4d3fn3qyrG1syEObPMiNE
         WibfhskF/dgDvgzFskpVcz4DCTxhILPKmHpn6V508mnF0YVTsnizMaqGEvBhwbv6h9F/
         C9rtv7FIQf+25UmoR/pkVXW4f7nyBroW1X3RDQcSSoEJ72bICYbMBC1lCJHKobNp7GE+
         uQzU+jnged6bQwDFbAUtPelOPMAB/9i51Ooqu+ZJzvQXZGftXoYdbW7k60LT68+L6pTD
         /L1g==
X-Forwarded-Encrypted: i=1; AJvYcCXsXMiX8JqL1DI81jEYgp/RCHaotfAEEMVvpRdyQeYxhmDn7djzPMlGJpGQSl1tgxecpAji1E0gXIL0@vger.kernel.org
X-Gm-Message-State: AOJu0YxhJ1hK3R7njY9oX+fVt52P/qno1nWlA11spmgDgKaEf1AzLeXS
	chMRo0tOB6Ype3mDDCox3IRd0/yDQqI6nyKhpDstzEMQ84uAKI/Miat5dd+H/w==
X-Google-Smtp-Source: AGHT+IG8CWAumD+73fyZuH+m6h5Xv3epqXIbma2P3c0T8RCJudcTZUOyJksgkbPEM64Ab+qVl165uQ==
X-Received: by 2002:a05:6a00:b85:b0:71e:db72:3c87 with SMTP id d2e1a72fcca58-72457a2a4e6mr2353946b3a.20.1731470660039;
        Tue, 12 Nov 2024 20:04:20 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:9e09:d4e8:509d:405b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079aa994sm12541029b3a.129.2024.11.12.20.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 20:04:19 -0800 (PST)
Date: Wed, 13 Nov 2024 13:04:15 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ext4: possible circular locking dependency at
 ext4_xattr_inode_create
Message-ID: <20241113040415.GF1458936@google.com>
References: <20241112073421.GD1458936@google.com>
 <20241112152957.GA317364@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112152957.GA317364@mit.edu>

Hi Ted,

On (24/11/12 10:29), Theodore Ts'o wrote:
> > I've a following syzkaller report (no reproducer); the report is
> > against 5.15, but the same call-chain seems possible in current
> > upstream as well.  So I suspect that maybe ext4_xattr_inode_create()
> > should take nested inode_lock (I_MUTEX_XATTR) instead.  Does the
> > patch below make any sense?
> 
> These syzkaller reports result from mounting a corrupted (fuzzed) file
> system typically when an inode is used in multiple contexts (e.g., as
> a directory and an EA inode, etc.) at the same time.

I certainly see your point, and I don't argue.

> I'd have to take a closer look to see if it makes sense, but in
> general, very often whenever we try to fix one of these it ends up
> triggering some other syzkaller failure.

I see, the one-liner that I posted sort of looks like an addition to
d1bc560e9a9c7 which landed in ext4 recently.

> And, these sorts of things don't actually result in actual security
> problems (at worst, a hang / denial of service attack), and the right
> thing to do is to just run fsck on the !@#?!? file system before
> mounting the thing.

So in our particular case reboot is a bad scenario.  Looking at reports
from the fleet I see a bunch of hung-task reboots with ext4 frames,
e.g. ext4_update_i_disksize()->down_write()->schedule() /* forever */,
but I can't claim that this is the deadlock that syzkaller has reported,
it very well might not be.

