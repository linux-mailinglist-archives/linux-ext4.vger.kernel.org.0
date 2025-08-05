Return-Path: <linux-ext4+bounces-9264-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754FEB1AD6A
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Aug 2025 07:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B826176903
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Aug 2025 05:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8941F0E32;
	Tue,  5 Aug 2025 05:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HL+/R4Lh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBFE1E47CA;
	Tue,  5 Aug 2025 05:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754370084; cv=none; b=mS+VJ0J58TivoK+texpVpSY4jvf2vNzHMwgjyweTYSaYJtN2uPbNpc37AxeEGttnA6wCGwv9uaIOf0VkXD7WoXwRJh8Vvep2mF7XjKcL+HpFWdS2nTFXiEceGJgcl5gTFmaaZDBttnj1fvqPrLJc9m5TyZNMHPFrVv5C7yOsEA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754370084; c=relaxed/simple;
	bh=UvU99nEZePGyVcWOc3JbH1BeYWMApkt1hfytTnmOT6M=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=b84uPK+b3SnNb8jpqDiXkzp6hgNNLBAW4w3LiZyyNCmS96qpTX3ehjCOSI4XWk5kxt+h38op4vpb47cE/cZdIrX7Dmx5QYoMBvyQjj1S3KS1F7P6/TN+ilGBZm5ozwkt8Y5e1L0P63rA5HwdzOt9hnXyaK8Y+m2Mztl0oytUWGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HL+/R4Lh; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso3889017a12.3;
        Mon, 04 Aug 2025 22:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754370079; x=1754974879; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B0TmagIM6Mc/JObSwVkC/rWfmooLv6wfWY26OeBBeN0=;
        b=HL+/R4LhS5gw6Rp2J/2a3TQTw21VgC8ErQtXw7LuWtGskclT2WTwCBH/npaOgjjgmQ
         nUtpMbyJZvCBz9EE9Wng8oh96FcuPKIjKJeaISo2Tkk5xjWxuxuKSuk9bFHh1QigfDyn
         xGoJHjJ4iBYCvZyMIkBZpB1pPS0sHiwZMTftWvv482dXPzXcUWn6GY+M2hjQcUN2vYKV
         oFYd2+oJOri65Zpd1BCGgenKdmsc2M59zNXmpD7v4rCle+KsQvBWkIYS53alJUhsUnxp
         jH7fY7Jc2Yo/x4m2+mJiSB6kZl/1K7NadsmBBtqisgAXE6bav44l+6paQfRjVlT+3Phl
         qZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754370079; x=1754974879;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B0TmagIM6Mc/JObSwVkC/rWfmooLv6wfWY26OeBBeN0=;
        b=f5RYqYizApMer3EigeWpEd5rHMnfX1WoTvQkskBLx9/kRvKIw2rl4CqERKWFnwdxJN
         lI7frt2JNrmaZHxWoutb/IjD8R7zfNxWZ+vzePImfWaYrs8dzmBg1HZmwkki42u+3QsD
         HtC0TxKmkxLNoHZCPZWatJ+ipA07wH5SKYmvnU3UsTpt6MmmST31u9i8gYoGewlYuuxc
         Qv2gEV1Ng2fe2l5LXG9WszpO2RioqvCgBFV40MKqhNwmOalYjDP+tbZGsmKuJiNQicy+
         ttpUW6We54o29+971pOXTS9MfNMF9T198Sf0rEH0myfkpgzcU1aKdwNu6VZzaZrvWSt6
         Be3g==
X-Forwarded-Encrypted: i=1; AJvYcCUQ7elmEWdC4uVhsjLa8LG6dn6OjoLGJJoAiGPublek83jfJQATH4SdfEnaPLEKw7RimQ2BtGrSPAxb@vger.kernel.org, AJvYcCW2TaUeLHE+88XKIdKP+b/n1lNR9jjgE18QZTZoruqQOIAz8O2NmnPmP89oBCwP3FaPabSrqvrCaRua@vger.kernel.org
X-Gm-Message-State: AOJu0YxVtDWIzhC6uCrwUpGYdflEYiahvP33JK8zeJya20Me0OEZTdwP
	YI+BJEhycLBXsjI8RAGMQcgI74DTxN9wnzVeblmM4ZfexyIU1zF3/QcBZ0pJ3A==
X-Gm-Gg: ASbGncs7krIljpMBFfiREmZ9RtRqB96EOKR7hxGwervMdA4aypuy7WDz5fmWe4yDu5v
	7VGJq97jSyfJDaA/0TfxsAcgynIZ8d+EmAIJhnLce3T4Q/Hw+4sEXIJWjDNPhNAyxcQEfkNwJPf
	zBltAZ4SsgE4DJWHnrzXDdr+KDK5kkCEKrg96IxnIq4COMUs8BqqXcF3fjubB5m+2Y7xF+4EG9o
	tGw0ZWN6HGLCUFDiAvolnGAf8vOEDBsM4gfjJ7FhAjYH4PJxQg8wyZjPlQ2+j9mWVOzgCfzeLGq
	aKCSFiCKvht9AHLQoo/GDhwQTKH7APgE9AEVepL6+z7yZ8hAWeBGypDgWUfvmMxBhUf5h7svZqW
	OJVfWstpNnVul79iZdbMrvu1W6A==
X-Google-Smtp-Source: AGHT+IHpSJcES+hh8acfeo9cx5Ee5zHW3zV73S05GZ7M3Sk+hbHMo03tD0NDolX6c1s90E/Yn1fBBA==
X-Received: by 2002:a05:6300:210c:b0:21a:e751:e048 with SMTP id adf61e73a8af0-23df90f64f5mr18130097637.35.1754370078754;
        Mon, 04 Aug 2025 22:01:18 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422be2b3a5sm10182728a12.46.2025.08.04.22.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 22:01:18 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>, John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, cem@kernel.org, linux-xfs@vger.kernel.org, linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2] xfs: disallow atomic writes on DAX
In-Reply-To: <20250722175820.GV2672070@frogsfrogsfrogs>
Date: Tue, 05 Aug 2025 10:02:20 +0530
Message-ID: <87a54e4cdn.fsf@gmail.com>
References: <20250722150016.3282435-1-john.g.garry@oracle.com> <20250722175820.GV2672070@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

"Darrick J. Wong" <djwong@kernel.org> writes:

> [cc linux-ext4 because ext4_file_write_iter has the same problem]
>

Thanks Darrick for the cc.

So ext4 currently will not issue atomic writes requests on DAX device,
unless the DAX device advertizes atomic write support (which IMO, it
doesn't). That is because, sbi->s_awu_min should be 0. I guess the
problem in case of XFS was the software fallback, where we only check if
the xfs_mount has reflink enabled, if yes, then we set
FMODE_CAN_ATOMIC_WRITE on file open. Since ext4 does not have such a
fallback, then the atomic write requests on EXT4 DAX should fail with
-EOPNOTSUPP.

static inline bool ext4_inode_can_atomic_write(struct inode *inode)
{

	return S_ISREG(inode->i_mode) &&
		ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS) &&
		EXT4_SB(inode->i_sb)->s_awu_min > 0;
}

But having said that - I guess we could still add an explicit check in
above to disable atomic write if inode is IS_DAX(inode) and make the
same changes in ext4_file_write_iter() as XFS. Logically it make sense to
disable atomic writes explicitly if inode is of type DAX and also to do
any generic checks on the iocb before calling their respective file I/O
operations in ext4_file_write_iter().

-ritesh



> On Tue, Jul 22, 2025 at 03:00:16PM +0000, John Garry wrote:
>> Atomic writes are not currently supported for DAX, but two problems exist:
>> - we may go down DAX write path for IOCB_ATOMIC, which does not handle
>>   IOCB_ATOMIC properly
>> - we report non-zero atomic write limits in statx (for DAX inodes)
>> 
>> We may want atomic writes support on DAX in future, but just disallow for
>> now.
>> 
>> For this, ensure when IOCB_ATOMIC is set that we check the write size
>> versus the atomic write min and max before branching off to the DAX write
>> path. This is not strictly required for DAX, as we should not get this far
>> in the write path as FMODE_CAN_ATOMIC_WRITE should not be set.
>> 
>> In addition, due to reflink being supported for DAX, we automatically get
>> CoW-based atomic writes support being advertised. Remedy this by
>> disallowing atomic writes for a DAX inode for both sw and hw modes.
>
> You might want to add a separate patch to insert:
>
> 	if (WARN_ON_ONCE(iocb->ki_flags & IOCB_ATOMIC))
> 		return -EIO;
>
> into dax_iomap_rw to make it clear that DAX doesn't support ATOMIC
> writes.
>
>> Reported-by: Darrick J. Wong <djwong@kernel.org>
>> Fixes: 9dffc58f2384 ("xfs: update atomic write limits")
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>
> Otherwise seems reasonable to me...
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
>
> --D
>
>> ---
>> Difference to v1:
>> - allow use max atomic mount option and always dax together (Darrick)
>> 
>> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
>> index ed69a65f56d7..979abcb25bc7 100644
>> --- a/fs/xfs/xfs_file.c
>> +++ b/fs/xfs/xfs_file.c
>> @@ -1099,9 +1099,6 @@ xfs_file_write_iter(
>>  	if (xfs_is_shutdown(ip->i_mount))
>>  		return -EIO;
>>  
>> -	if (IS_DAX(inode))
>> -		return xfs_file_dax_write(iocb, from);
>> -
>>  	if (iocb->ki_flags & IOCB_ATOMIC) {
>>  		if (ocount < xfs_get_atomic_write_min(ip))
>>  			return -EINVAL;
>> @@ -1114,6 +1111,9 @@ xfs_file_write_iter(
>>  			return ret;
>>  	}
>>  
>> +	if (IS_DAX(inode))
>> +		return xfs_file_dax_write(iocb, from);
>> +
>>  	if (iocb->ki_flags & IOCB_DIRECT) {
>>  		/*
>>  		 * Allow a directio write to fall back to a buffered
>> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
>> index 07fbdcc4cbf5..bd6d33557194 100644
>> --- a/fs/xfs/xfs_inode.h
>> +++ b/fs/xfs/xfs_inode.h
>> @@ -358,9 +358,20 @@ static inline bool xfs_inode_has_bigrtalloc(const struct xfs_inode *ip)
>>  
>>  static inline bool xfs_inode_can_hw_atomic_write(const struct xfs_inode *ip)
>>  {
>> +	if (IS_DAX(VFS_IC(ip)))
>> +		return false;
>> +
>>  	return xfs_inode_buftarg(ip)->bt_awu_max > 0;
>>  }
>>  
>> +static inline bool xfs_inode_can_sw_atomic_write(const struct xfs_inode *ip)
>> +{
>> +	if (IS_DAX(VFS_IC(ip)))
>> +		return false;
>> +
>> +	return xfs_can_sw_atomic_write(ip->i_mount);
>> +}
>> +
>>  /*
>>   * In-core inode flags.
>>   */
>> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
>> index 149b5460fbfd..603effabe1ee 100644
>> --- a/fs/xfs/xfs_iops.c
>> +++ b/fs/xfs/xfs_iops.c
>> @@ -616,7 +616,8 @@ xfs_get_atomic_write_min(
>>  	 * write of exactly one single fsblock if the bdev will make that
>>  	 * guarantee for us.
>>  	 */
>> -	if (xfs_inode_can_hw_atomic_write(ip) || xfs_can_sw_atomic_write(mp))
>> +	if (xfs_inode_can_hw_atomic_write(ip) ||
>> +	    xfs_inode_can_sw_atomic_write(ip))
>>  		return mp->m_sb.sb_blocksize;
>>  
>>  	return 0;
>> @@ -633,7 +634,7 @@ xfs_get_atomic_write_max(
>>  	 * write of exactly one single fsblock if the bdev will make that
>>  	 * guarantee for us.
>>  	 */
>> -	if (!xfs_can_sw_atomic_write(mp)) {
>> +	if (!xfs_inode_can_sw_atomic_write(ip)) {
>>  		if (xfs_inode_can_hw_atomic_write(ip))
>>  			return mp->m_sb.sb_blocksize;
>>  		return 0;
>> -- 
>> 2.43.5
>> 

