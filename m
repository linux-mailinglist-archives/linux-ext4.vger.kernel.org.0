Return-Path: <linux-ext4+bounces-7808-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 248D0AB367F
	for <lists+linux-ext4@lfdr.de>; Mon, 12 May 2025 14:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74C3219E083B
	for <lists+linux-ext4@lfdr.de>; Mon, 12 May 2025 12:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A6929292F;
	Mon, 12 May 2025 12:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZSiAk8P"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F4C19E97C;
	Mon, 12 May 2025 12:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747051349; cv=none; b=jW2xSrfppsUfnrQVmO0Q5/LQekWtDzowwQeZGIggmwBs0sdIuIxA1L7cU1lhLvMWYxfCbBElZh6iXssYOlfjd3q1FqSpBLDLGDxTE1RQcbif7TefwctrUgf8k5WnTyKCxujxk+st8wazvM2j7f2s21JBQKSFkslpO0aRgNLm2sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747051349; c=relaxed/simple;
	bh=43zbKpDLFw/DqCwaWDislDy+LtxUe9FRg4bNeZvDE/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HcTPY5sXCFb1UVOSvXee4dNhXcT04tURIGz862cD+x3q9r2bzAWnOLi1RRARsQhqpWSk28IKBfUpuQLszYZlpSNQ6jU5/Cr3svR6oCT1+TWvtTid8n010UJBoSy/M5uT1/l42CtUmrEHvE8g12kd8grU/Sj8kQp+LaXgZBfIIeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZSiAk8P; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-477296dce8dso49572261cf.3;
        Mon, 12 May 2025 05:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747051346; x=1747656146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lu00x3P4/7hmsriXwMYGYk47s3btJeQpSRTbeqZCmsY=;
        b=gZSiAk8PqzEHVqRZQuqGp7bmLBem09zL5x9PZPNl3yXEmh4Cx3qu6HjzIKL6GXl4hu
         YgaN1KJVORPA56f3LLWK8ujGJcj7H8a7JBEjmiXT1VNl7Nkldwu/XjNBBJ/pDp/LOD02
         gi6CjEUuMbDohuD2excHxyLVtRRzSVd9r9hd7Lw9QgvcJzcyU29D28MYHeR8hcL/ZrYb
         ZVfeVuJGgBFoCin1VKycrUC1HBM9aZCUiX/IJ0jtkdY2YtyNMsNyPpfV5fuQH5kVfARy
         WZA7HlTeE2Asve8/VT4Njbi1RtKL9HL0RAt+U6RuHsfGKVUL12uJ+sbiDOt5HWUidat6
         KB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747051346; x=1747656146;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lu00x3P4/7hmsriXwMYGYk47s3btJeQpSRTbeqZCmsY=;
        b=xTVm/2gUVbgwZ7+2TGqDX0Bwl9z7Mac9hxi5AXfaICVcVxdwLK+v/FCHgyKwl4OYkd
         r2vm2kHt1mR839/iON9LGX635GleAeZl0hhmYmxMWkRROKt7KkugxNyeDARFgrT1Y/ba
         oD4F4+LIQXMaoeoHqc32z4OHdm+movvpdoFY++3jK0WLMnNplMbuQynCW+O+hKfKTQoP
         WuGA5Xl2kAqhDq16+w9foFlkAJPdIkj0vmGr6EWlx8qAROW8amhprO4tykLtItgoPZnf
         9mgN1g1BX0Vic3qB456TM+I07ik9kNd5EuFjh6or5zEn/M9JRqOyXoLGNV2QMFyxKEN+
         Uh2w==
X-Forwarded-Encrypted: i=1; AJvYcCUtca+idz2Od8Ctwvcv2Fp/7UkATWkp2r8LCfoyo42H5cJU3DZ+xVx22BRR6vvKrKIOPhqyOYAaceWkbg==@vger.kernel.org, AJvYcCW1Y7yLdA6yU5fjflY0WVd/9QnmSBeZ4kvkVUr3WrbiW5/XbVi4mlT3fhiyDcwaX51XHYh3O5sO@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5dzyPXxaYnTi3nlmgoufveVzxH0MPRxP8iZkoAMHnH9GPeGFy
	aAfOwuC63X7otmCjaqZnycwYIvBOeubr5rAq83hc48o0PXLLnTkSbeLKAA==
X-Gm-Gg: ASbGnctIH9w4rEtv1Shb1PY61lITt0hIx+zLCZBxcIIo2EqY5/X1uSyAL3I1GE85OQh
	2dV2QzYOs1nY35ejaPedheRa3/WnpqJUyTGLOPuzjOEkh8eXHwwZxEUb1YKRRHtiPWksArvA3RC
	0671eDcdKharh1BpJIkJEKMhOTlJoPrAjNS3ZUKVwXEr9gvJxBw/YBJC7r1rY3U+mYOtuWUUJ1M
	bD4RAnK0Cd04eaAQINgie3DxatGQQ4Li/YUWGWkARiiJjeBaKfonkWQUNgJX/oO7bWKD8Y5SI9E
	tZNAI6JChCURzoKij126krarzn25r4rfN+jiwKkjTzT9+xZiq8FYAmTOPb/XcA==
X-Google-Smtp-Source: AGHT+IEEvRA1xCBXvqSjZTNo64T8mXDVrJh2N0X8WBDVQeSOMRiomZY0g9UlEQO6XyHVNe6LSX9phA==
X-Received: by 2002:a05:6a20:6f07:b0:203:addb:5a29 with SMTP id adf61e73a8af0-215abc78929mr21413566637.40.1747051335751;
        Mon, 12 May 2025 05:02:15 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b236de8839asm5328176a12.40.2025.05.12.05.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 05:02:15 -0700 (PDT)
Message-ID: <06e740ad-8990-45ca-bdd8-fa5d446e4bd4@gmail.com>
Date: Mon, 12 May 2025 17:32:10 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] xfs: Fail remount with noattr2 on a v5 with v4
 enabled
Content-Language: en-US
To: Carlos Maiolino <cem@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 fstests@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
 djwong@kernel.org, zlang@kernel.org, david@fromorbit.com, hch@infradead.org
References: <cover.1747043272.git.nirjhar.roy.lists@gmail.com>
 <uvQIPMIpyNU1GgrBWDuyTQvD6gJNGgIBfFc0qRZt-ehl_bRnVMTBNcfYRxRqjgkUSJVXaltU7eN1HGLqi4Vp1w==@protonmail.internalid>
 <e03b24e6194c96deb6f74cd8b5e5d61490d539f6.1747043272.git.nirjhar.roy.lists@gmail.com>
 <xwx4pyblttfkrxfq3wlorwz743oathzvjdigehgke4gsu6vona@xfftyhxmzr22>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <xwx4pyblttfkrxfq3wlorwz743oathzvjdigehgke4gsu6vona@xfftyhxmzr22>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/12/25 16:40, Carlos Maiolino wrote:
> On Mon, May 12, 2025 at 03:27:14PM +0530, Nirjhar Roy (IBM) wrote:
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
>> and hence, the following if condition in
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
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   fs/xfs/xfs_super.c | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
>> index b2dd0c0bf509..606a95ac816f 100644
>> --- a/fs/xfs/xfs_super.c
>> +++ b/fs/xfs/xfs_super.c
>> @@ -2114,6 +2114,21 @@ xfs_fs_reconfigure(
>>   	if (error)
>>   		return error;
>>
>> +	/* attr2 -> noattr2 */
>> +	if (xfs_has_noattr2(new_mp)) {
>> +		if (xfs_has_crc(mp)) {
>> +			xfs_warn(mp,
>> +			"attr2 is always enabled for a V5 filesystem - can't be changed.");
>> +			return -EINVAL;
> This looks good to me now:
>
> Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
>
> I still wish hch's opinion here though before merging it. Giving his was the
> first RwB, I want to make sure he still keeps his RwB with the above change.
Sure.
>
>
> FWIW, for a next patch, there is no need to copy ext4 list for a code change
> that is totally unrelated to ext4. This just generates unnecessary extra
> traffic.

Okay. I will keep this in mind.

--NR

>
>
>> +		}
>> +		mp->m_features &= ~XFS_FEAT_ATTR2;
>> +		mp->m_features |= XFS_FEAT_NOATTR2;
>> +	} else if (xfs_has_attr2(new_mp)) {
>> +		/* noattr2 -> attr2 */
>> +		mp->m_features &= ~XFS_FEAT_NOATTR2;
>> +		mp->m_features |= XFS_FEAT_ATTR2;
>> +	}
>> +
>>   	/* inode32 -> inode64 */
>>   	if (xfs_has_small_inums(mp) && !xfs_has_small_inums(new_mp)) {
>>   		mp->m_features &= ~XFS_FEAT_SMALL_INUMS;
>> @@ -2126,6 +2141,17 @@ xfs_fs_reconfigure(
>>   		mp->m_maxagi = xfs_set_inode_alloc(mp, mp->m_sb.sb_agcount);
>>   	}
>>
>> +	/*
>> +	 * Now that mp has been modified according to the remount options,
>> +	 * we do a final option validation with xfs_finish_flags()
>> +	 * just like it is done during mount. We cannot use
>> +	 * xfs_finish_flags()on new_mp as it contains only the user
>> +	 * given options.
>> +	 */
>> +	error = xfs_finish_flags(mp);
>> +	if (error)
>> +		return error;
>> +
>>   	/* ro -> rw */
>>   	if (xfs_is_readonly(mp) && !(flags & SB_RDONLY)) {
>>   		error = xfs_remount_rw(mp);
>> --
>> 2.43.5
>>
>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


