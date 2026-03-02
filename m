Return-Path: <linux-ext4+bounces-14334-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MRGBfLnpWlLHwAAu9opvQ
	(envelope-from <linux-ext4+bounces-14334-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 20:41:38 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FBC1DEE74
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 20:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21E2D302E7D1
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Mar 2026 19:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9319847DD4B;
	Mon,  2 Mar 2026 19:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="cqOb0Coi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852A247DD42
	for <linux-ext4@vger.kernel.org>; Mon,  2 Mar 2026 19:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772480492; cv=none; b=aZpjXt1jhcBjp86WBS+7lqSCYKfv/GKdNSL0OyUePGfHsi/h9Hjc+aEPohr7iiJkNzKJFEu1YnLjfd+8hNGXF69wZ9KWvTetXfZAn13fh0wsM5BXyfEDaJPxJOHvFLiuT6hp+Hs28q19ggxPnVW/zN414kOyO/JGrfW3PkFMvDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772480492; c=relaxed/simple;
	bh=NqSXEN1SaHPthBzjtNpNQ3VrNlhW/QUVBKKvpSF/g0o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gpIPJQeT8Q1dBdcZ1dkAcOytKfqOSMsxVBK3hL/bDUB2vtZIR0Bq7icPhF2sKvsaQqNflxKEmHggoOwQxoUK+scUCEddjNqUoBNqCzOZd7Hio4+2rXUlwz4Cf+hp7XYm90KMnTggdLkAwaeuZBAsVzrx97RCwj7uoW5K5a+zJwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=cqOb0Coi; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-826c49b7628so3118667b3a.0
        for <linux-ext4@vger.kernel.org>; Mon, 02 Mar 2026 11:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1772480489; x=1773085289; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uc0uyGCA4f24QmRWDH0aGYcMOP0JiqsOmpw+Umalrkc=;
        b=cqOb0Coiui8gWrJSzX4IFHnLQ7+nyi5uAlGCKQlgQyZciPQN/zI2lnBVTpi3Tv9R3i
         CxIZwAs741jQmdeU+BH6+BtaG6fikkYt+7DPDR0ChZvxfST4+5XC1Z/z+bTJRdDRckVl
         ZxaPy/+r8o7EXk/RZI9kw4VDG7oOFjCWvbmzJMnNYFYRQJ/Zyk3ihEoVay72AB/HpXUF
         QdZKMgvqWRa3fr7h5WO/sVKTJxOqBWuhEiK4GlYZOE3uYornoVQPX0lKnebNTpp7zOGg
         pR2S3RWRrw30t7P64yskKgGCVREBtsKDlP5o1QmEWuMKQH7fvn9Jnan4piFhdhKGvWDP
         T13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772480489; x=1773085289;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uc0uyGCA4f24QmRWDH0aGYcMOP0JiqsOmpw+Umalrkc=;
        b=a44/WM1xGBGY2eM1BTxMaFRFTAxCbpAK8slYfYdSV9uu3tQhODNvFXWhqxIXEISwIS
         PA5lQTuaWBhwikZeadE6YovQ9nphvEpoOWtwsN+oEaN5Q4jhCvwkD9X1+KD3R0zvEF6c
         qgyjBnYWMs6MU8lyKcNwyjcVkH0EA+dWiOzqUm/SLUoKEDcIxJ9wcn5YFqHVU5VlVs25
         XrmEr4K9qvubEU02NlzWf2HLmNgZr762AlTxuI2PmG9fqijKGzsLidSQyi6QMzT2jsb1
         JdM+o4qBr8liW8iti+FV2a5zjzd0t/2eGTyzeWh3EIGPKyJCCTrytcq4+8dtQhjTIF8W
         MiJg==
X-Forwarded-Encrypted: i=1; AJvYcCXdI2Shk2q7NAZqqbKWzG36phb0scIr/nxQ4C5svS7lqS9mG/j3snxXbN9XwMdlAWCOy0pcu5urbo80@vger.kernel.org
X-Gm-Message-State: AOJu0YzMHkt0EQHSdgyJMsQ65PiBvXY8kCEHxPwLTdKJiY7aIfFLmn1G
	pU9qw1j+2n7dKgExhlmsHBydfaoZ2F7OQFf/fitf39L56mATfQeiVeAhnLlfrhfzJHyi9EBd2vB
	4mQFdfEM=
X-Gm-Gg: ATEYQzwzuQzihGkw08cKMreX2m6Yh7StF+Yfh4MPzbr9VLYvCDYjrMz+fG1wjcir156
	O/sDX0Ty4gRE+1KVGsddy7Y0WpUp26G2tvmCmDrMN3kKvV8Zs+ew5HwPO9OGXf/wp83901qpHuq
	hMRJRQERzmJMg84iQ7MAmKBpsFr4+cBXQfFYp82V0N7+penJQy+EI52Q0c3gzNAgUDJqwGJPSsZ
	wsgsKQjt39JXkLDoppcDrCrBo0B6WhbDQ1kKnzpPPrm02c87aBPEpICNTbUfapynVSW7/V5L5K9
	/1qCxG+R+QfGNIgAp8smEgw1RLMk4z0hnGDi6vf0/9lybwyhKHAYm6WSEoSlreBEpXBs3C2RRNO
	XRsAN6Cj1EfPYh743Av8n73JKs0jqJW8H/3qC3KTjWcPu2E1joswCoWrRGSc8vHHgYr5W1fjFj3
	60eJBLZ7YrDYCXeMnXr08EWF3iqxnCei89txadrT0Hq0b7rRoFe1hsww3qFRnRn8ctb4B6MxqHC
	BdVOw==
X-Received: by 2002:a05:6a21:44c8:b0:38b:d9f5:3c4e with SMTP id adf61e73a8af0-395c3b30e8cmr11570600637.55.1772480488664;
        Mon, 02 Mar 2026 11:41:28 -0800 (PST)
Received: from smtpclient.apple (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa5eab4esm11985402a12.6.2026.03.02.11.41.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2026 11:41:28 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH] ext4: avoid allocate block from corrupted group in
 ext4_mb_find_by_goal()
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <20260302134619.3145520-1-yebin@huaweicloud.com>
Date: Mon, 2 Mar 2026 12:41:16 -0700
Cc: tytso@mit.edu,
 linux-ext4@vger.kernel.org,
 jack@suse.cz
Content-Transfer-Encoding: quoted-printable
Message-Id: <578ABB60-B0E6-4BB2-B247-15C9875AC6A5@dilger.ca>
References: <20260302134619.3145520-1-yebin@huaweicloud.com>
To: Ye Bin <yebin@huaweicloud.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-Rspamd-Queue-Id: 34FBC1DEE74
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[dilger-ca.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14334-lists,linux-ext4=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dilger.ca];
	DKIM_TRACE(0.00)[dilger-ca.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adilger@dilger.ca,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,dilger.ca:mid,dilger.ca:email,dilger-ca.20230601.gappssmtp.com:dkim]
X-Rspamd-Action: no action

On Mar 2, 2026, at 06:46, Ye Bin <yebin@huaweicloud.com> wrote:
>=20
> From: Ye Bin <yebin10@huawei.com>
>=20
> There's issue as follows:
> ...
> EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 206 at =
logical offset 0 with max blocks 1 with error 117
> EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost
>=20
> EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 206 at =
logical offset 0 with max blocks 1 with error 117
> EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost
>=20
> EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 206 at =
logical offset 0 with max blocks 1 with error 117
> EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost
>=20
> EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 206 at =
logical offset 0 with max blocks 1 with error 117
> EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost
>=20
> EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 2243 at =
logical offset 0 with max blocks 1 with error 117
> EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost
>=20
> EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 2239 at =
logical offset 0 with max blocks 1 with error 117
> EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost
>=20
> EXT4-fs (mmcblk0p1): error count since last fsck: 1
> EXT4-fs (mmcblk0p1): initial error at time 1765597433: =
ext4_mb_generate_buddy:760
> EXT4-fs (mmcblk0p1): last error at time 1765597433: =
ext4_mb_generate_buddy:760
> ...
>=20
> According to the log analysis, blocks are always requested from the
> corrupted block group. This may happen as follows:
> ext4_mb_find_by_goal
>  ext4_mb_load_buddy
>   ext4_mb_load_buddy_gfp
>     ext4_mb_init_cache
>      ext4_read_block_bitmap_nowait
>      ext4_wait_block_bitmap
>       ext4_validate_block_bitmap
>        if (!grp || EXT4_MB_GRP_BBITMAP_CORRUPT(grp))
>         return -EFSCORRUPTED; // There's no logs.
> if (err)
>  return err;  // Will return error
> ext4_lock_group(ac->ac_sb, group);
>  if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info))) // =
Unreachable
>   goto out;
>=20
> After commit 9008a58e5dce ("ext4: make the bitmap read routines return
> real error codes") merged, Commit 163a203ddb36 ("ext4: mark block =
group
> as corrupt on block bitmap error") is no real solution for allocating
> blocks from corrupted block groups. This is because if
> 'EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)' is true, then
> 'ext4_mb_load_buddy()' may return an error. This means that the block
> allocation will fail.
> Therefore, check block group if corrupted when ext4_mb_load_buddy()
> returns error.
>=20
> Fixes: 163a203ddb36 ("ext4: mark block group as corrupt on block =
bitmap error")
> Fixes: 9008a58e5dce ("ext4: make the bitmap read routines return real =
error codes")
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca =
<mailto:adilger@dilger.ca>>

> ---
> fs/ext4/mballoc.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index e2341489f4d0..ffa6886de8a3 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2443,8 +2443,12 @@ int ext4_mb_find_by_goal(struct =
ext4_allocation_context *ac,
> return 0;
>=20
> err =3D ext4_mb_load_buddy(ac->ac_sb, group, e4b);
> - if (err)
> + if (err) {
> + if (EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info) &&
> +    !(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY))
> + return 0;
> return err;
> + }
>=20
> ext4_lock_group(ac->ac_sb, group);
> if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)))
> --=20
> 2.34.1
>=20


