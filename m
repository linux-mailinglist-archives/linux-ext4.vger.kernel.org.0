Return-Path: <linux-ext4+bounces-3536-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 862539421C9
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 22:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2C261F255C6
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 20:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A86518E02C;
	Tue, 30 Jul 2024 20:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Gjp+hkHn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252A818E02F
	for <linux-ext4@vger.kernel.org>; Tue, 30 Jul 2024 20:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722372130; cv=none; b=nKsh3k4UN7KBscYG3plQ2U7Y0/Og92xSuKuOICosgyja0e2GOFCsa43YajIGkjO3UXorkJ2GBo6rNpxYNOu38sjkokgMSmFA1JO2yufyn7FT9dApK53AKvPHFwKylb0tyR6/a6QXveX4u5u0wbY2x1R+wYHyCTr1345J0wz7MMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722372130; c=relaxed/simple;
	bh=SeJUJSRj1A5h20HzHOqQaZ16XgUf+3Alvj7rMvDzVG4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KukwUcQhyZWPsbFkMyOlFypYzyOZ0Z0fJVK9PC/O4D9pdZJLYJqOH0bHdK7dUhftt/jv4Dd/7kWT1XB2Wzi7AOwIcNehXktmtwr9IhCUxbcEthymWwEpBJPrtTDb/wLzBMKMT5cnggAPby5GZSmQvfRaXKEnN90KvddSTrlvfyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Gjp+hkHn; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-595856e2336so456155a12.1
        for <linux-ext4@vger.kernel.org>; Tue, 30 Jul 2024 13:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1722372127; x=1722976927; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQDSUf9qVf6rrSdyp/WjPyLLR10PpkvNhtYgC4dx4JI=;
        b=Gjp+hkHnRI0ZfePG7c7NYbnoOTyhDB7W8q7SSOSMV+K4tVlyZCpm/ef2wXrWMR5wQf
         pr+LvjJivRzWV6EYVcb1WK95SNemLpQif+wzfxmjvnUg3PQuvO4JCL5lUt2hY9KZw6Iq
         k8z80qF0LHk7dhHjZYFHNqLUgHsorolZfnN0Ym40ufl9Dc//Epvewj0f4CtWfSgw8PJl
         i+73SB9WeIwrbLF0kvunnu1R5LULt4e847BtZEgLiIZ32njvvV3NeQT4V2I5ENV/mEAN
         MMD+6HJhdOxQ7MqoK2imekmcqEvWvviZ6h9XCHepjy+BpU3KfL8UMq3tfl/hf9aIlyVB
         npyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722372127; x=1722976927;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQDSUf9qVf6rrSdyp/WjPyLLR10PpkvNhtYgC4dx4JI=;
        b=SEfS+QVDCJUXBKRve4QgY3SnNph3x9t1wmcvuq9egLAZ0Owqdeg0TAkxNsrtk55cuy
         xf3TOS6n0SpEFtQ4SVsle7wOAGcLHv/LNxjf4s2x1351mKTtBF8A9eIL/4n5di8MCbkj
         Rz2ekBOsqQeJD/+AzgNMJr4SM+wY2SHDsA5qKsUQILc5PNvOEE2wXYc4az5n50d3s2bd
         U3xsCv+Hw9NN6YltUMqo1DB0M16XX8kz4W3haHhX7HZttJmMfJaig6qLqsf3WumXrcc2
         Ymff6U8m21TDS24Go3LHBhfrmB2YBehRVJ+AdCsE3t2zGVIitkvBZS4g2hBzHzaxR+qk
         RxBA==
X-Forwarded-Encrypted: i=1; AJvYcCWYYL1VcTA1lhjAFXjNBUIxI9BwxbA5LzDx6eVULjLWl0XAukR3xrIDLmZi/fgn9VYJUzbYaF+/TGpfWmIIq4Y4NdIKTJcGMVvXFw==
X-Gm-Message-State: AOJu0YweX5OU14ss37jsBZoYthmwOYTP+aUiq0f6hQ01UVlrJ8dX8gc6
	bCXcwO5i8tiPpg0DBrBfLoyM0rOFiT8RzCo2egiSFOU2JoS6J4paa8AM8CONQj0=
X-Google-Smtp-Source: AGHT+IEk3gBXb0BChOHPjZjDPNI7/jDNPJae5VrxXQC2xMV26ISbNd7bgMEaF0jYXSvxGPO0N6weKg==
X-Received: by 2002:a50:8d5c:0:b0:5b4:ec9d:d66a with SMTP id 4fb4d7f45d1cf-5b4ec9ddc0bmr2108402a12.15.1722372127127;
        Tue, 30 Jul 2024 13:42:07 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:10b5:fc01:4198:a192:529f:265d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63d4724csm7594657a12.48.2024.07.30.13.42.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2024 13:42:06 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v2] ext4: Annotate struct ext4_xattr_inode_array with
 __counted_by()
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <d4362976-ac3d-4236-a213-666a42560dfe@embeddedor.com>
Date: Tue, 30 Jul 2024 22:41:55 +0200
Cc: tytso@mit.edu,
 adilger.kernel@dilger.ca,
 kees@kernel.org,
 gustavoars@kernel.org,
 linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4C3E47BC-37AA-49BF-BEDB-C2A45F2D564E@toblux.com>
References: <20240730172301.231867-4-thorsten.blum@toblux.com>
 <d4362976-ac3d-4236-a213-666a42560dfe@embeddedor.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
X-Mailer: Apple Mail (2.3774.600.62)

On 30. Jul 2024, at 20:12, Gustavo A. R. Silva <gustavo@embeddedor.com> =
wrote:
> On 30/07/24 11:23, Thorsten Blum wrote:
>> Add the __counted_by compiler attribute to the flexible array member
>> inodes to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
>> CONFIG_FORTIFY_SOURCE.
>> Remove the now obsolete comment on the count field.
>> Refactor ext4_expand_inode_array() by assigning count before copying =
any
>> data using memcpy(). Copy only the inodes array instead of the whole
>> struct because count has been set explicitly.
>> Use struct_size() and struct_size_t() instead of offsetof().
>> Change the data type of the local variable count to unsigned int to
>> match the struct's count data type.
>> Compile-tested only.
>> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
>> ---
>> Changes in v2:
>> - Adjust ext4_expand_inode_array() as suggested by Gustavo A. R. =
Silva
>> - Use struct_size() and struct_size_t() instead of offsetof()
>> - Link to v1: =
https://lore.kernel.org/linux-kernel/20240729110454.346918-3-thorsten.blum=
@toblux.com/
>> ---
>>  fs/ext4/xattr.c | 20 +++++++++-----------
>>  fs/ext4/xattr.h |  4 ++--
>>  2 files changed, 11 insertions(+), 13 deletions(-)
>> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
>> index 46ce2f21fef9..b27543587103 100644
>> --- a/fs/ext4/xattr.c
>> +++ b/fs/ext4/xattr.c
>> @@ -2879,11 +2879,10 @@ ext4_expand_inode_array(struct =
ext4_xattr_inode_array **ea_inode_array,
>>   if (*ea_inode_array =3D=3D NULL) {
>>   /*
>>   * Start with 15 inodes, so it fits into a power-of-two size.
>> - * If *ea_inode_array is NULL, this is essentially offsetof()
>>   */
>>   (*ea_inode_array) =3D
>> - kmalloc(offsetof(struct ext4_xattr_inode_array,
>> - inodes[EIA_MASK]),
>> + kmalloc(struct_size_t(struct ext4_xattr_inode_array,
>> +      inodes, EIA_MASK),
>=20
> As Kees previously commented, you can use struct_size() here.
>=20
>>   GFP_NOFS);
>>   if (*ea_inode_array =3D=3D NULL)
>>   return -ENOMEM;
>> @@ -2891,17 +2890,16 @@ ext4_expand_inode_array(struct =
ext4_xattr_inode_array **ea_inode_array,
>>   } else if (((*ea_inode_array)->count & EIA_MASK) =3D=3D EIA_MASK) {
>>   /* expand the array once all 15 + n * 16 slots are full */
>>   struct ext4_xattr_inode_array *new_array =3D NULL;
>> - int count =3D (*ea_inode_array)->count;
>> + unsigned int count =3D (*ea_inode_array)->count;
>=20
> It seems `count` is not actually needed anymore.
>=20
> If you remove it and directly use `(*ea_inode_array)->count` in the =
following
> call to `kmalloc()`, you could use `struct_size()` in the call to =
`memcpy()`
> below, and copy the whole thing in one line. See below.
>=20
>>  - /* if new_array is NULL, this is essentially offsetof() */
>> - new_array =3D kmalloc(
>> - offsetof(struct ext4_xattr_inode_array,
>> - inodes[count + EIA_INCR]),
>> - GFP_NOFS);
>> + new_array =3D kmalloc(struct_size(*ea_inode_array, inodes,
>> + count + EIA_INCR),
>> +    GFP_NOFS);
>>   if (new_array =3D=3D NULL)
>>   return -ENOMEM;
>> - memcpy(new_array, *ea_inode_array,
>> -       offsetof(struct ext4_xattr_inode_array, inodes[count]));
>> + new_array->count =3D count;
>> + memcpy(new_array->inodes, (*ea_inode_array)->inodes,
>> +       count * sizeof(struct inode *));
>=20
> memcpy(new_array, *ea_inode_array, struct_size(new_array, inodes, =
(*ea_inode_array)->count));
>=20
>>   kfree(*ea_inode_array);
>>   *ea_inode_array =3D new_array;
>>   }
>=20
> Also, you are missing one more like just below this one, where =
`(*ea_inode_array)->count`
> is currently being used to directly index `inodes`:
>=20
> (*ea_inode_array)->inodes[(*ea_inode_array)->count++] =3D inode;

Thanks, I missed this one.

Thorsten=

