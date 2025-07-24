Return-Path: <linux-ext4+bounces-9178-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A343B10D9C
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Jul 2025 16:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D93C1C232B3
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Jul 2025 14:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5833B2E6107;
	Thu, 24 Jul 2025 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOmjRNZa"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6793A2957C2;
	Thu, 24 Jul 2025 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367418; cv=none; b=doE3WyZ1aFtrkBe08GE4FzaUNQwvfzbk4A0CYtcD50Zck6ewnYqQSQIdOYnqXdL9NDxSFC7xo/T2fHOs95EY5BZMA6LllN1Oe8i8kcaPFj9YmNkl/o9VoINJOQp2kLgfQwt6yHPidrKAliN7vuC1y9hdCflhTcrv9u3fho2rHVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367418; c=relaxed/simple;
	bh=U6vS/rkhunq9/uDsYb96AdTjl24qQuRknjxvA2eCvHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILghg8YBkYoMpEr5aoKSs6bgLV4JOTEPNoAtDqdTBeQa5+OEniJqwC3uAN8m6TcS8VTM5bA/PpA4AuaBjnRG5GM+GcPmH2UDDlbI24RKxQlbxUMYG/DWxV5g05E4NszMJYw/E2TAwgoJvQJxhmpWCHTlMpZ/+45xIuisryxfnNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOmjRNZa; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-234d3261631so9550695ad.1;
        Thu, 24 Jul 2025 07:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753367415; x=1753972215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0KpcZO3ax4ADqwCkWeWobRMdcAxiAjewjQZcz/x2QVA=;
        b=XOmjRNZaEP6r42yrBwMasCa5skOHoEGP+xvqctsbL0pNDIKmgr3upVuKcsXwfZaKCq
         EsiVfcsnd0ZzDybSxEOweH3Nly3xUqkCLA8w+ylVXpB9ELL3FKFaiCCvJtC5YTAmpsBz
         CrM7fOkwLVOsVzjO5klaHSfPA1fjUL5T8FCNgzS0dd3eOzZvGgwHQZGaH2yKmSIhoHjr
         zoi47gghbw7buaAQD/abWvYpE85EV4u1scpr9H2h4HOgclLU4E7Qf0538aWUzXApzdvW
         MROqq88F2BqhEuf/QVm8p79C7x9VrsgS1S1soCsavWufluJLmRKt2XvCpi0wy5hxZXuq
         yUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753367416; x=1753972216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KpcZO3ax4ADqwCkWeWobRMdcAxiAjewjQZcz/x2QVA=;
        b=L/uYTOTjn84V5dcnwv11sJJSZipNd506xlpVOvCA/JEyg0AOKyCs+WpVRcrsb/zG4p
         aNv1vv/O3vhz4aFQ089CLJPmHdNarMJ6ttQHvwoc8qjKEb+qdnjxpUHPpvXuzwB7ZTBV
         O/b5nDmSpzoAeKgz8lhgDLxV6iekKsj8WdJp5S1kZhYoWiQrCv/RxPshkWRMAGq3H5ba
         c/8tyz/Li8znByaLuieIssFhLLZ8GOCkL6HPdfHMc/+cYx9AK9ss+YkTBZHV2gjtu1+9
         I19uWWgCIFV0vlP/Gs+vdCiIQy9ujr6afcmQHFaOeuzQVFMgtGNI2IoswsglB8/y4/NI
         QOng==
X-Forwarded-Encrypted: i=1; AJvYcCWhC39oHjWeXFx3Nzs1SPE1yFmLcxXOQcOJZ0OBTxARb9NVrQj8D0+xWaXxRPfbeJe/V3revyqNA9CZ@vger.kernel.org, AJvYcCXfo7QyBwR/koCm3XXSolAZelKg72JWVo/e/lrDNXRIlRykZUvteA3pjz38FulMsd5vZvAvFWtCf9beGiJn@vger.kernel.org
X-Gm-Message-State: AOJu0YzZuRhneF/I93nQ6SlAVDap2t5AHH5n0Ftgi/sI9j/eeeMxNz6R
	2ws6/StVr/eMwVpaYYVnC1s2RJOSGaVHQzJuLVKSHNp+EEMb8apiKaEw
X-Gm-Gg: ASbGncsHxmv46u5e9YBH7RWklRQag1lB2yyWidEy0hTihOVoj61vxZvXRKhmTVMwRGi
	m7Z/M6w+Zfmbo3Jt6c2qOniqcGEDqJbqfWVcyw4/5HxY1rOHvrpd82V2F642Ufc3845ORlWGkMi
	CI4PH1wIEeYqn2iXIQ1s3Igvz4DtuPU4El0Eac4NcVbDHH1tyL0KVTqPiXDjTK3QPln29MOOxMI
	qSSapjxfuEjvI5eUWAxH6wyEDaWCN8M2kOs0T2C4QNTmE0sugUjRUfIJwDt0B2ksqQT2G74z+R3
	mrkzaMtW2iXU7MSmkJSK9OXYQzve+ZFXCC422bVGt4iCRSRaxAQhvyI5w6A6NHauz4VuFge73+S
	mRDEr0hygCvmezJIKZXoy7pOkElD+VRM2pwA=
X-Google-Smtp-Source: AGHT+IE8Wpfxjjlh35P0E2ph1hvwZSlHV94Aw4orZ58yOLdr7iKQyeRgBa19laUwwEli2Ideo2TTIA==
X-Received: by 2002:a17:903:2352:b0:234:8a4a:adb4 with SMTP id d9443c01a7336-23f9817696bmr120501805ad.21.1753367415303;
        Thu, 24 Jul 2025 07:30:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa47601f6sm17346765ad.42.2025.07.24.07.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 07:30:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 24 Jul 2025 07:30:13 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Zhang Yi <yi.zhang@huawei.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Baokun Li <libaokun1@huawei.com>,
	linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	julia.lawall@inria.fr, yangerkun@huawei.com,
	libaokun@huaweicloud.com
Subject: Re: [PATCH v3 15/17] ext4: convert free groups order lists to xarrays
Message-ID: <914ea234-cfd3-4790-b1c5-1f2cb3814a79@roeck-us.net>
References: <20250714130327.1830534-1-libaokun1@huawei.com>
 <20250714130327.1830534-16-libaokun1@huawei.com>
 <b0635ad0-7ebf-4152-a69b-58e7e87d5085@roeck-us.net>
 <20250724045456.GA80823@mit.edu>
 <ef789a81-f326-4af6-8e9b-a13b5b20412b@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef789a81-f326-4af6-8e9b-a13b5b20412b@huawei.com>

On Thu, Jul 24, 2025 at 07:14:58PM +0800, Zhang Yi wrote:
> On 2025/7/24 12:54, Theodore Ts'o wrote:
> > On Wed, Jul 23, 2025 at 08:55:14PM -0700, Guenter Roeck wrote:
> >> Hi,
> >>
> >> On Mon, Jul 14, 2025 at 09:03:25PM +0800, Baokun Li wrote:
> >>> While traversing the list, holding a spin_lock prevents load_buddy, making
> >>> direct use of ext4_try_lock_group impossible. This can lead to a bouncing
> >>> scenario where spin_is_locked(grp_A) succeeds, but ext4_try_lock_group()
> >>> fails, forcing the list traversal to repeatedly restart from grp_A.
> >>>
> >>
> >> This patch causes crashes for pretty much every architecture when
> >> running unit tests as part of booting.
> > 
> > I'm assuming that you're using a randconfig that happened to enable
> > CONFIG_EXT4_KUNIT_TESTS=y.
> > 
> > A simpler reprducer is to have a .kunitconfig containing:
> > 
> > CONFIG_KUNIT=y
> > CONFIG_KUNIT_TEST=y
> > CONFIG_KUNIT_EXAMPLE_TEST=y
> > CONFIG_EXT4_KUNIT_TESTS=y
> > 
> > ... and then run :./tools/testing/kunit/kunit.py run".
> > 
> > The first failure is actually with [11/17] ext4: fix largest free
> > orders lists corruption on mb_optimize_scan switch, which triggers a
> > failure of test_mb_mark_used.
> > 
> > Baokun, can you take a look please?   Many thanks!
> > 
> 
> Hi Ted and Guenter,
> 
> I'm sorry for this regression, we didn't run these tests. Baokun is
> currently on a business trip, so I help to look into this issue. The
> reason for the failure is that the variable initialization in the
> mb unit tests are insufficient, but this series relies on them.
> 
> Could you please try the following diff? I have tested it on my
> machine, and the issue does not recur. If every thing looks fine, I
> will send out the official patch.
> 

Confirmed to fix the problem. Please feel free to add

Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

> Thanks,
> Yi.
> 
> 
> diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
> index d634c12f1984..a9416b20ff64 100644
> --- a/fs/ext4/mballoc-test.c
> +++ b/fs/ext4/mballoc-test.c
> @@ -155,6 +155,7 @@ static struct super_block *mbt_ext4_alloc_super_block(void)
>  	bgl_lock_init(sbi->s_blockgroup_lock);
> 
>  	sbi->s_es = &fsb->es;
> +	sbi->s_sb = sb;
>  	sb->s_fs_info = sbi;
> 
>  	up_write(&sb->s_umount);
> @@ -802,6 +803,8 @@ static void test_mb_mark_used(struct kunit *test)
>  	KUNIT_ASSERT_EQ(test, ret, 0);
> 
>  	grp->bb_free = EXT4_CLUSTERS_PER_GROUP(sb);
> +	grp->bb_largest_free_order = -1;
> +	grp->bb_avg_fragment_size_order = -1;
>  	mbt_generate_test_ranges(sb, ranges, TEST_RANGE_COUNT);
>  	for (i = 0; i < TEST_RANGE_COUNT; i++)
>  		test_mb_mark_used_range(test, &e4b, ranges[i].start,
> @@ -875,6 +878,8 @@ static void test_mb_free_blocks(struct kunit *test)
>  	ext4_unlock_group(sb, TEST_GOAL_GROUP);
> 
>  	grp->bb_free = 0;
> +	grp->bb_largest_free_order = -1;
> +	grp->bb_avg_fragment_size_order = -1;
>  	memset(bitmap, 0xff, sb->s_blocksize);
> 
>  	mbt_generate_test_ranges(sb, ranges, TEST_RANGE_COUNT);
> 
> 
> 

