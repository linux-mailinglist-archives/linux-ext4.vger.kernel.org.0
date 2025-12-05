Return-Path: <linux-ext4+bounces-12207-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CF4CA7E7E
	for <lists+linux-ext4@lfdr.de>; Fri, 05 Dec 2025 15:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99465315EB25
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Dec 2025 10:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF513064A3;
	Fri,  5 Dec 2025 10:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="k9v3N7F3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D432FFDEB
	for <linux-ext4@vger.kernel.org>; Fri,  5 Dec 2025 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764929871; cv=none; b=nZ84mojqbwgugCjotfSOWcQQtvVRIy4iEV057cMrOXw1+1eULYSmiECh29K2jxA/9K/WHFn4Z3+wGy3KnnQHvcV0SKDA+H/yRxw/loCo8G/TssuT2RgbcdCxt4fWUEiOJR7ijmxLL2V3JTE33+1V/UBiaFBEdObYpl7UxGao/B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764929871; c=relaxed/simple;
	bh=RhBRJFyOAdwsl0zH3ZBkLnkGnhMSLZjWUL7rNE+cRf4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Kb7rHHQwpKUbY4jp+0zP/2erJrlkeDedBuPGOP3t2IJxC6YSYcLlDQjcq4ZDtqDcs58wGSmQcfjmOGsA5k6GHxtLfWQNkoLa8BoiWBncAMb7TCIxzIzdRFdMS0RxvCCQnW8+bopZyNZLo+ryztftDBlPGSF3cascK4xEzHaTP6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=k9v3N7F3; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-298287a26c3so23617925ad.0
        for <linux-ext4@vger.kernel.org>; Fri, 05 Dec 2025 02:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1764929860; x=1765534660; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejAA+82WXMRpxMzI7K+RY1NfuttWEInlfhpwdDmj4lM=;
        b=k9v3N7F3Sp4oMOjTRmpoP/0fQewAHghNKroQ1k0P05YQVB0kSItMrdi4YoBK/HzDPB
         AguSOo+LbzfD/GtJshSmLWmqvfTTuQ5QSMZ9AkxbEj00joqxuQWz3yqdJUmp5jV9tG9g
         5uzqvR2GRMRsi/cGiLIiFhu2kO3mBwKiEpdcK4PZ4zVz1xs1rJ4v1o6wbFSeSI6aYNgT
         LDcJGK02qrxUvO9lhs4tH9V6oFg77fi19/v655pA/qOxA01gW3SeEsJeMjDG737ZCZ6h
         qLqwLtx6l38KFxG3pouJjARtL1o/1qd6LDpw2ErqgXFY/HhJbS2hSFLOENux07/+pmny
         IvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764929860; x=1765534660;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ejAA+82WXMRpxMzI7K+RY1NfuttWEInlfhpwdDmj4lM=;
        b=gzO8tB1xYQeesLW7g4T7p8WN5la8BhFZ13X2tXYoyV3schApeHmMHDKGmHAhBfdAFs
         Mm6fPA3bhD+7bNI0c+yR1jC5cHKE56S4ga0TSm6mRFhTxXBGLQUKaou1Pr6j4GRgqA4v
         bNmPK1+uWKRmHh3YDKVLSgsOeChxfP1snQSLxOYh5msY3T+NsjnQLsLIGK3aZMlS/PiI
         h70akHf9SXzAfcEBRtma36bd6cgIH9+QKdsAPjR/d/3CmkqsKr8xFBHm4tZroiZod4eD
         q7ScTgLggWXztFFY6jOtcfMzy4rg7ORT0V40FQY4G4oJ8M8YBHXCmXYhtHGvsd7BiWrj
         5RAw==
X-Forwarded-Encrypted: i=1; AJvYcCUd9kPix5lr2UAtJGHgZwHHPRadbDGG2Fon1FsxVY7igtDp+eEGR9mbX809NkNm1lWjjv2z1V2brmYN@vger.kernel.org
X-Gm-Message-State: AOJu0YzivQicbAqNUaE7oixtFmBmPYh8kjFV8kpY63dKg3EczB5/sMmx
	RLw/8bzUFacCFVus8Rluwc+G0vIP4ajN04vUte//Te8Qox6Xd7icC8mDFSwJy7l7MGw=
X-Gm-Gg: ASbGncv5Wfdg7QcZMrLmWfugEpXDqWX+DouklpKWzeHmDNRIO3SBLQRIrHe9uainND/
	T7Am6htrud/vv0fEu9Ad8880TN4ch0HykCJZgizHfJMszTAtEg4zVLZwDgSTKQhQ6GoiqHC+WO/
	ZdFeSHUHFTRRkTnp3Qg1DvECdYV2kbmIi16m2fDSWDBE2LC2SKHaG9La81d+rMZY+tgUFltIkwp
	8eBGmRy743617vZ0PwkCj85BBLoWaTF9o8Vgd3T9NEVGu3eWMOx025AnJc5gj2rM+tSys2iD02c
	2RjiZuLp3qoJXnhP9qZmO8gS9ks3pmVpMf3wx0Wwck4B+QRqZfTA1g6iqWCdzYIv4sB37vspPNA
	UlNRrEPYpU4N2hEejXqo7wN6wNQKE0JdhbmgCdXx7mGhIhdxdKF6HE3aHR6S601iMuPKWFCC3Sr
	BKBoD2PvGEyKbs3Aj5HhZOBvdyroIn+xAWKqSKXL1Cb6sGTsAA75jPOHEVoB6dHjSHZA==
X-Google-Smtp-Source: AGHT+IFnHfsMKYXe2P3mVmNDPpMoGnC069tFh2MBSac6+s0ZQZJ1arinWSiMTr8CCkw0Oc1r21x8Gw==
X-Received: by 2002:a17:903:fa5:b0:298:2e7a:3c47 with SMTP id d9443c01a7336-29d68451d74mr110045265ad.42.1764929860395;
        Fri, 05 Dec 2025 02:17:40 -0800 (PST)
Received: from smtpclient.apple (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae49b196sm45651555ad.17.2025.12.05.02.17.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Dec 2025 02:17:39 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH] ext4: fix ext4_tune_sb_params padding
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <3ueamfhbmtwmclmtm77msvsuylgxabt3zqkrtvxqtajqhupfdd@vy7bw3e3wiwn>
Date: Fri, 5 Dec 2025 03:17:28 -0700
Cc: Theodore Ts'o <tytso@mit.edu>,
 "Darrick J. Wong" <djwong@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B2AC14DC-0B9D-433A-A1B0-78D0778D0A39@dilger.ca>
References: <20251204101914.1037148-1-arnd@kernel.org>
 <3ueamfhbmtwmclmtm77msvsuylgxabt3zqkrtvxqtajqhupfdd@vy7bw3e3wiwn>
To: Jan Kara <jack@suse.cz>,
 Arnd Bergmann <arnd@kernel.org>
X-Mailer: Apple Mail (2.3864.100.1.1.5)



> On Dec 4, 2025, at 3:31=E2=80=AFAM, Jan Kara <jack@suse.cz> wrote:
>=20
> On Thu 04-12-25 11:19:10, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>=20
>> The padding at the end of struct ext4_tune_sb_params is architecture
>> specific and in particular is different between x86-32 and x86-64,
>> since the __u64 member only enforces struct alignment on the latter.
>>=20
>> This shows up as a new warning when test-building the headers with
>> -Wpadded:
>>=20
>> include/linux/ext4.h:144:1: error: padding struct size to alignment =
boundary with 4 bytes [-Werror=3Dpadded]
>>=20
>> All members inside the structure are naturally aligned, so the only
>> difference here is the amount of padding at the end. Make the padding
>> explicit, to have a consistent sizeof(struct ext4_tune_sb_params) of
>> 232 on all architectures and avoid adding compat ioctl handling for
>> EXT4_IOC_GET_TUNE_SB_PARAM/EXT4_IOC_SET_TUNE_SB_PARAM.
>>=20
>> This is an ABI break on x86-32 but hopefully this can go into 6.18.y =
early
>> enough as a fixup so no actual users will be affected.  =
Alternatively, the
>> kernel could handle the ioctl commands for both sizes (232 and 228 =
bytes)
>> on all architectures.
>>=20
>> Fixes: 04a91570ac67 ("ext4: implemet new ioctls to set and get =
superblock parameters")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>=20
> Indeed. I agree this is fairly new so we can just fix the structure. =
Feel
> free to add:
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>

While this change isn't _wrong_ per-se, it does seem very strange to =
have
a 68-byte padding at the end of the struct.  You have to check the =
number
of __u32 fields closely to see this, and I wonder if this will =
perpetuate
errors in the future (e.g. adding a __u64 field after mount_opts[64]).

IMHO, it would be more clear to either add an explicit "__u32 pad_3;"
field after mount_opts[64], or alternately declare mount_opts[68] so it
will consume those bytes and leave the remaining fields properly =
aligned.
It isn't critical if the user tools use the last 4 bytes of mount_opts[]
or not, so they could be changed independently at some later time.

Either will ensure that new fields added in place of pad[64] will be
properly aligned in the future.

Cheers, Andreas


>=20
> Honza
>=20
>> ---
>> include/uapi/linux/ext4.h | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/include/uapi/linux/ext4.h b/include/uapi/linux/ext4.h
>> index 411dcc1e4a35..9c683991c32f 100644
>> --- a/include/uapi/linux/ext4.h
>> +++ b/include/uapi/linux/ext4.h
>> @@ -139,7 +139,7 @@ struct ext4_tune_sb_params {
>> __u32 clear_feature_incompat_mask;
>> __u32 clear_feature_ro_compat_mask;
>> __u8  mount_opts[64];
>> - __u8  pad[64];
>> + __u8  pad[68];
>> };
>>=20
>> #define EXT4_TUNE_FL_ERRORS_BEHAVIOR 0x00000001
>> --=20
>> 2.39.5
>>=20
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR



Cheers, Andreas






