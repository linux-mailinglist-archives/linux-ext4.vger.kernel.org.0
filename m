Return-Path: <linux-ext4+bounces-7540-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70781AA0E70
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Apr 2025 16:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A9E284543B
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Apr 2025 14:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EB82D8DA5;
	Tue, 29 Apr 2025 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vd7RnTHW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357832D8699;
	Tue, 29 Apr 2025 14:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745935897; cv=none; b=YJeDqK4Ftxcsl4PD/I94cWyhe1YZyYuPRXWEMDaTN0RKgMSv2ZfV7szuYh95I6eC3ULi3gBI8J8bwa0fNeylTz9qWVvZQKEtTejqbNeufBovteuwSSD3gm5PfttdUE+kTKhoZYvWNw2ZBJQPVmNm+UvOS15pvbuuUCG4ZWPi6Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745935897; c=relaxed/simple;
	bh=9kD6OTSweYA7XlA7mugMcF+Qvv4vk6XLfcm6Nry/sNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CktJ3ByNDhxMSq01jVvCZHraG1vz3uM7YvIRR87kp9gjV6ExOnBUUG0gj7ja6E5fEgs+Ajns4ZH1awGSVrtQr6i7o0qoFZsKy3lwOLkm6dyppW/zGCdzHYWgtakPkuTFkq7PFOCIo8NRW0Ld1x6MBpZQvXQ4aRRNB7v/uEljipE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vd7RnTHW; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2240b4de12bso88939805ad.2;
        Tue, 29 Apr 2025 07:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745935895; x=1746540695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=txPRzhp6owC64zhJPSR3NsfLXXGLxGN3jwUZX74lVQI=;
        b=Vd7RnTHWS8+kv0TJCLaarPE+20T7h6l5GJEi4hMKxRcFDI+XiXtQUUDLFM0AyL4q2L
         YouZjj76/9z54Z0r5xuZYoENQEXhvkYuBJ6zIz11eU4ANBemczEaEIFbaBIuafSRNdOC
         V8oA5M98Z/qhLoiGsG3HYypojjnNyqZIUikjB86tSHIvQe3w/+HoRtUAsFOfj01ZAZth
         jBISdgBI/KEzur/DD4gXPO5SAJt6CSWgPDakgKI5AQR2Vn9ZzFB9/iWIpefRzTVTQQHD
         vxa/xo6xFZuS0BkAEQCgBXqjvzj0oI7CJWQTIfbYzrX+wDFLLxlJmNyI6evW8t7pFI+K
         Ot9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745935895; x=1746540695;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=txPRzhp6owC64zhJPSR3NsfLXXGLxGN3jwUZX74lVQI=;
        b=FB2DH/1c2waa/zTawDlxnBSjFL5acHixN5NmymouwTCiaIg6dQ+fTaSclUXWC9XInV
         sz7Hp8K3mLSWJuWYcZORLOYqZ8SyRBJCkYFObMhWEngCyTJCk8ckcCBt3Pa8IoTyK/pl
         HY2Ldm7aNwBNlvctKR4PO6OxmuCNte6QVRJDcnO+iBOZfdH72pX1a2kv3afDBy2wj0DT
         +U6fdTzOnLGjYdFohzXhN3Unr4Cm+0VTEMUewhenPyq38xNpfkebqOHXGmoQ65Fux6iH
         fAyMKKlgva+rtnVwFsR+IaHmDBANphlO6QyT/Zx7peoqoOtdOFcmTQzSw2iA1SobqdIk
         BURA==
X-Forwarded-Encrypted: i=1; AJvYcCV+rSJH9CJIsW3VLu0F/Zh5TbzREENTX6CfkaHE9Xsz7srE/oHrCKeaA64IifbVC/sxZ2tRuUi0@vger.kernel.org, AJvYcCVuPP4xQQApmljUEFEwYegrONzHny13AlJl/QbwGMAaxlBHL0Um3w+9abPHTRUlCW2oNo3g9/TAZd6MYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFxhJAiYaLXTunWnj1wZWwykk050CZe24N/0Jw94coc8QVWf5Z
	MjyXbs8eQtOdyyEbawzDFiff/3/n9xkqGWzRZ95dF0hRHIyKX5Yu
X-Gm-Gg: ASbGncsK3+Iy/5FJcZFbMj5switEDWp4dXqLV3FsHW4IZCCCCc8SVDGTy2uzcpGfJYa
	TDp7gzFfa256ZlUBO3PSR/DxiVtdlvd+yATgpfzksQPq9mKCYj+Bk0ex8hgYGhrAyvntx2HZ/FO
	YLSupR7nzp3Ce/BQvoHA8BPg6/LPhya91kld4Y19Cfy6X0u4tPSBjCJ/yIkqAobjX2EUs0vICsD
	a8R/yNk9S+ZdmgyCKNH2h0xPv/h6jds5tm/TDCrX2d1hGDJBwqwmQ2UbPZ/rYWc/HkKNixE4PXO
	UZ11E2QjigYXyHUOGmuGs2WkaXOueIivXg1I6GCDQxeHX+ZBB/Q=
X-Google-Smtp-Source: AGHT+IFv4KIsYUSPZZOOZVF88qVqaN0hNIRkI1c8bjq/7DjATV6y7VJJBTEDB5dSQZlS8cOm15wjvg==
X-Received: by 2002:a17:902:da91:b0:22c:33b2:e420 with SMTP id d9443c01a7336-22dc69f82bbmr170471705ad.7.1745935895223;
        Tue, 29 Apr 2025 07:11:35 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dbe328sm102822365ad.88.2025.04.29.07.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 07:11:34 -0700 (PDT)
Message-ID: <f1fda2ca-5531-4bba-aaea-8edc15430244@gmail.com>
Date: Tue, 29 Apr 2025 19:41:30 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] xfs: Fail remount with noattr2 on a v5 with v4
 enabled
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 fstests@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
 djwong@kernel.org, zlang@kernel.org, david@fromorbit.com
References: <cover.1745916682.git.nirjhar.roy.lists@gmail.com>
 <94a5d92139aef3a42929325bc61584437957190e.1745916682.git.nirjhar.roy.lists@gmail.com>
 <aBDDmDymL8yMxloN@infradead.org>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <aBDDmDymL8yMxloN@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/29/25 17:48, Christoph Hellwig wrote:
> On Tue, Apr 29, 2025 at 02:32:08PM +0530, Nirjhar Roy (IBM) wrote:
>> Bug: When we compile the kernel with CONFIG_XFS_SUPPORT_V4=y,
>> remount with "-o remount,noattr2" on a v5 XFS does not
>> fail explicitly.
>>
>> Reproduction:
>> mkfs.xfs -f /dev/loop0
>> mount /dev/loop0 /mnt/scratch
>> mount -o remount,noattr2 /dev/loop0 /mnt/scratch
>>
>> However, with CONFIG_XFS_SUPPORT_V4=n, the remount
>> correctly fails explicitly. This is because the way the
>> following 2 functions are defined:
>>
>> static inline bool xfs_has_attr2 (struct xfs_mount *mp)
>> {
>> 	return !IS_ENABLED(CONFIG_XFS_SUPPORT_V4) ||
>> 		(mp->m_features & XFS_FEAT_ATTR2);
>> }
>> static inline bool xfs_has_noattr2 (const struct xfs_mount *mp)
>> {
>> 	return mp->m_features & XFS_FEAT_NOATTR2;
>> }
>>
>> xfs_has_attr2() returns true when CONFIG_XFS_SUPPORT_V4=n
>> and hence, the the following if condition in
>> xfs_fs_validate_params() succeeds and returns -EINVAL:
>>
>> /*
>>   * We have not read the superblock at this point, so only the attr2
>>   * mount option can set the attr2 feature by this stage.
>>   */
>>
>> if (xfs_has_attr2(mp) && xfs_has_noattr2(mp)) {
>> 	xfs_warn(mp, "attr2 and noattr2 cannot both be specified.");
>> 	return -EINVAL;
>> }
>>
>> With CONFIG_XFS_SUPPORT_V4=y, xfs_has_attr2() always return
>> false and hence no error is returned.
>>
>> Fix: Check if the existing mount has crc enabled(i.e, of
>> type v5 and has attr2 enabled) and the
>> remount has noattr2, if yes, return -EINVAL.
>>
>> I have tested xfs/{189,539} in fstests with v4
>> and v5 XFS with both CONFIG_XFS_SUPPORT_V4=y/n and
>> they both behave as expected.
>>
>> This patch also fixes remount from noattr2 -> attr2 (on a v4 xfs).
>>
>> Related discussion in [1]
>>
>> [1] https://lore.kernel.org/all/Z65o6nWxT00MaUrW@dread.disaster.area/
>>
>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>> ---
>>   fs/xfs/xfs_super.c | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
>> index b2dd0c0bf509..1fd45567ae00 100644
>> --- a/fs/xfs/xfs_super.c
>> +++ b/fs/xfs/xfs_super.c
>> @@ -2114,6 +2114,22 @@ xfs_fs_reconfigure(
>>   	if (error)
>>   		return error;
>>   
>> +	/* attr2 -> noattr2 */
>> +	if (xfs_has_noattr2(new_mp)) {
>> +		if (xfs_has_crc(mp)) {
>> +			xfs_warn(mp, "attr2 and noattr2 cannot both be specified.");
> Nit: normal xfs style is to move the message to a new line when іt
> overflows 80 characters:
>
> 		if (xfs_has_crc(mp)) {
> 			xfs_warn(mp,
> 	"attr2 and noattr2 cannot both be specified.");
>
>> +			return -EINVAL;
>> +		}
>> +		else {
> No need for an else after a return.  And for cases where there is an
> else the kernel coding style keeps it on the same line as the closing
> brace.
>
>> +	/* Now that mp has been modified according to the remount options, we do a
>> +	 * final option validation with xfs_finish_flags() just like it is done
>> +	 * during mount. We cannot use xfs_finish_flags() on new_mp as it contains
>> +	 * only the user given options.
>> +	 */
> Please keep comments to 80 characters.  Also the kernel coding style
> keeps the
>
> 	/*
>
> at the beginning of a comment on a separate line.

Sure, I will address the above coding style related issues. Thank you.

--NR

>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


