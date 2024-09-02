Return-Path: <linux-ext4+bounces-4004-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8D0968648
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Sep 2024 13:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D212815F2
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Sep 2024 11:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593A51D4603;
	Mon,  2 Sep 2024 11:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="IZnPKT4K"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955501D3188
	for <linux-ext4@vger.kernel.org>; Mon,  2 Sep 2024 11:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725276768; cv=none; b=PQGTrc7jFjJjOHJmRWLpvCScoU37WOjRGI06hgiRNVZUwES0TAl4lql7t79XoHsYU4INMmCGqyrbEQc+U3X3enpGGBQsCex2OJiV2z2AvIPRhYQInzHAzju+aE6jkKO+gRDyOp8aF629cmlo/y/nfJ1NsgfFhMLVwM+2SzBxUJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725276768; c=relaxed/simple;
	bh=EaCx9uD7lLBoyO3gvZoujmruCtOjW8d0mUOQCiUGTNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TP+/QW+czwi+T3iy5YV7Wvq6sF+yyTSgpC8QWN+4vJc5OO9RaQJnlXnbNUaQ8aVN9ePPAbHNvgiNSoW4R7ipCVK1TkgIHLDOHeC8obSuiDpLobkwd8qv8Rq9v1f/H8mO+VFKB7BjoT7vlphqX4QVeY1Shj0rEJSGhL/Yn0lLKwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=IZnPKT4K; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-715cdc7a153so2863378b3a.0
        for <linux-ext4@vger.kernel.org>; Mon, 02 Sep 2024 04:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1725276766; x=1725881566; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3T+qEmHOcCq1xQ+zRsNTSDREegBrH4STnJvq2MDDf0=;
        b=IZnPKT4KGFUJRhas1kioF8R1UhsnVhFkksoN/SiqjhTVKS6sxMbhAFi8tRf2DYKJDT
         eV8FzVOAQidrlI5gaSB0HTtJgnFO25Z49w4Lmk3riPdALM5wpGQMiIpRx+O+iXkhqcrj
         RR9ywqACGa+/8ZexKXUtyv7pXPLXdJLOns/f5snvYZOQSHOOdo2HJjvsr3mApz7jKzFZ
         CLMjk8sw0/Y07MbLL45EAiS649J3TbmmMphXOP+cnmf6Mw4FsrXV6DXhQcJ047aJGpsV
         0KFXEN57l5jFKSoGtW48dy4dQ+H2aIqUVjfllol9d5WmnUs7ydxuQZ1WdGz3Xz23LjK5
         Y5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725276766; x=1725881566;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k3T+qEmHOcCq1xQ+zRsNTSDREegBrH4STnJvq2MDDf0=;
        b=IVIpxjvskT2+XZeE5oIYAZI1g7uE60UtOzA9m/luLGd3VKgJ2LVYmS78LC5FaAFKOV
         fyxEP/io/NNn7LlN/YOY6cYct43WEiR1jEEj1dGNlUkcAUalAwGzlB+ZqVX2EENcx6cR
         SX1M2zcfTkl6Ogfc34+rucIX+CXTy7TssQui8ugpPGk46ZxpVNFy7TCWWDl2v4cgo7Mz
         CPJhE24ZWBfPVKOhKPIs3rh/65BtVWOrh4+LjooYJHyvdc/4H+N/xCr0x4wW2O1pQtko
         sUemZqMzXsHbrVll13B/rArZvT1zQTibJvOwO95p8durZdGs3OmQd5WtgAK728F2nqSg
         +RkA==
X-Forwarded-Encrypted: i=1; AJvYcCVmjekBY1D9aWieChR2NUoxCLNxka8R390i7JPAWiZ1a4XwXAIu/fSxn88s3mno0lwgSRu4fHuwMYyD@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4aUh7KOf14CWXHFmQgdQckG96Dya17mjueeA9/TIUdUov/B8z
	ezZIivEPA8oJkBAT1CBfzVp0HbQWa0lToI88AX5z731tK18TqgrEugyZZRProbk=
X-Google-Smtp-Source: AGHT+IEKBR7dteQbq1hh6J1kq7GDsyXK0XN7F9BJXJnN31Mk4hReTi+nlhaf0SDOblRrJ5aRyaTS8w==
X-Received: by 2002:a05:6a21:1690:b0:1ca:ccfc:edc8 with SMTP id adf61e73a8af0-1ccee8874a3mr14856504637.22.1725276765428;
        Mon, 02 Sep 2024 04:32:45 -0700 (PDT)
Received: from [10.54.24.59] (static-ip-148-99-134-202.rev.dyxnet.com. [202.134.99.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e5576a37sm6688723b3a.29.2024.09.02.04.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 04:32:44 -0700 (PDT)
Message-ID: <dcf1c5c7-d5b0-41f4-9191-2876b80165ae@shopee.com>
Date: Mon, 2 Sep 2024 19:32:38 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ovl: don't set the superblock's errseq_t manually
To: "Darrick J. Wong" <djwong@kernel.org>, Amir Goldstein <amir73il@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Theodore Tso <tytso@mit.edu>,
 miklos@szeredi.hu, linux-unionfs@vger.kernel.org,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Ext4 <linux-ext4@vger.kernel.org>, fstests <fstests@vger.kernel.org>
References: <CAOQ4uxi4B8JHYHF=yn6OrRZCdkoPUj3-+PuZTZy6iJR7RNWcbA@mail.gmail.com>
 <20240730042008.395716-1-haifeng.xu@shopee.com>
 <CAOQ4uxhs==_-EM+VyJRRCX_NPmYybPDBW2v7cXz33Qt2RMaPnQ@mail.gmail.com>
 <20240830152648.GE6216@frogsfrogsfrogs>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <20240830152648.GE6216@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/8/30 23:26, Darrick J. Wong wrote:
> On Fri, Aug 30, 2024 at 03:27:35PM +0200, Amir Goldstein wrote:
>> On Tue, Jul 30, 2024 at 6:20 AM Haifeng Xu <haifeng.xu@shopee.com> wrote:
>>>
>>> Since commit 5679897eb104 ("vfs: make sync_filesystem return errors from
>>> ->sync_fs"), the return value from sync_fs callback can be seen in
>>> sync_filesystem(). Thus the errseq_set opreation can be removed here.
>>>
>>> Depends-on: commit 5679897eb104 ("vfs: make sync_filesystem return errors from ->sync_fs")
>>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
>>> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>>> ---
>>> Changes since v1:
>>> - Add Depends-on and Reviewed-by tags.
>>> ---
>>>  fs/overlayfs/super.c | 10 ++--------
>>>  1 file changed, 2 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
>>> index 06a231970cb5..fe511192f83c 100644
>>> --- a/fs/overlayfs/super.c
>>> +++ b/fs/overlayfs/super.c
>>> @@ -202,15 +202,9 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
>>>         int ret;
>>>
>>>         ret = ovl_sync_status(ofs);
>>> -       /*
>>> -        * We have to always set the err, because the return value isn't
>>> -        * checked in syncfs, and instead indirectly return an error via
>>> -        * the sb's writeback errseq, which VFS inspects after this call.
>>> -        */
>>> -       if (ret < 0) {
>>> -               errseq_set(&sb->s_wb_err, -EIO);
>>> +
>>> +       if (ret < 0)
>>>                 return -EIO;
>>> -       }
>>>
>>>         if (!ret)
>>>                 return ret;
>>> --
>>> 2.25.1
>>>
>>
>> FYI, this change is queued in overlayfs-next.
>>
>> However, I went to see if overlayfs has test coverage for this and it does not.
>>
>> The test coverage added by Darrick to the mentioned vfs commit is test xfs/546,
>> so it does not run on other fs, although it is quite generic.
>>
>> I fixed this test so it could run on overlayfs (like this):
>> # This command is complicated a bit because in the case of overlayfs the
>> # syncfs fd needs to be opened before shutdown and it is different from the
>> # shutdown fd, so we cannot use the _scratch_shutdown() helper.
>> # Filter out xfs_io output of active fds.
>> $XFS_IO_PROG -x -c "open $(_scratch_shutdown_handle)" -c 'shutdown -f
>> ' -c close -c syncfs $SCRATCH_MNT | \
>>         grep -vF '[00'
>>
>> and it passes on both xfs and overlayfs (over xfs), but if I try to
>> make it "generic"
>> it fails on ext4, which explicitly allows syncfs after shutdown:
>>
>>         if (unlikely(ext4_forced_shutdown(sb)))
>>                 return 0;
>>
>> Ted, Darrick,
>>
>> Do you have any insight as to why this ext4 behavior differs from xfs
>> or another idea how to exercise the syncfs error in a generic test?
>>
>> I could fork an overlay/* test from the xfs/* test and require that
>> underlying fs is xfs, but that would be ugly.
>>
>> Any ideas?
> 
> That should be:
> 
> 	if (unlikely(ext4_forced_shutdown(sb)))
> 		return -EIO;
> 
> no?  The fs is dead and cannot persist anything, so we should fling that
> back to the calling program.

yes. sync_filesystem() write outs and wait upon all dirty data. If the superblock is shutdown,
writeback can't make any progress and there is no guarantees are made on how many dirty data
have been written out. So I think it's reasonable to tell users about this error.

> 
> --D
> 
>> Thanks,
>> Amir.
>>

