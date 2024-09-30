Return-Path: <linux-ext4+bounces-4387-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFC4989F37
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 12:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C6431F22E77
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 10:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0356E18990E;
	Mon, 30 Sep 2024 10:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L1CIMS5M"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D47F185B48
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727691321; cv=none; b=C0xS6BaUcncr9rwUlqMlR5ISJCE2u2AKIbrKwdOBVkr9tXRwZx7bk4W5K81jB/F4nzQkrmaMUrrKhN2CwomPHfQi8g7BNK6vAo26yOv1pT6hhe76Jd/+iP3yg6B6co8HfnT6RRxont8HHRpeNxmb+NOe86o15hvOf+hY2Mn9ed0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727691321; c=relaxed/simple;
	bh=OEc8dFLInS0OAS2YX51LHZxpz80U77z8iK4+AQjCYII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+gDvOvDv7VESz7eUQEVvv0Boshtdy5PJOYRTKK5JtmJvBQVKG0i0CwNJXA6Q7vEV/UOwdgRt1uITrJpc1m9yBdASceCQBlFspnYm3E/V1mFtRlU7bZIf3N713QB97GY4ryq4JmCOt1PmiPt2axl/l7dmI888Akc1MPb3b2Wddk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L1CIMS5M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727691317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wCUdNikGJCngAq5rrc4vcaoiBZukIDMXIdCY4aEjVyM=;
	b=L1CIMS5MU7fRVqElXJEZ7CYwsiPOzKaMHxjKJv/m3S9op1MNCgnz9ljZXXr5lzdwuzlKoA
	leVNmKbEHdj1dLwfBgV/aI/R3/yRMh84l26w4BeT7/Z+O8G0U+cVxnByrIk5svWbslaasq
	M3ZIB6pQpJJPygokJdFYUEyd0m5lN5I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-9O_e90PJNWqSiz0XLRiacw-1; Mon, 30 Sep 2024 06:15:15 -0400
X-MC-Unique: 9O_e90PJNWqSiz0XLRiacw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb830ea86so27822385e9.3
        for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 03:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727691314; x=1728296114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCUdNikGJCngAq5rrc4vcaoiBZukIDMXIdCY4aEjVyM=;
        b=seFD8f0v86MdNEfSYaWUFR1BZG65lXu1Yl5wR/yrfh2iIk0YvdX0MxiHaowhTzYvoP
         my9+lN94OTyyPbkMEQu0vQfycCbPUV5MNdwjVLyZmhyHSaITqC1Ks5Hts6OYgqGaP1U1
         2IPKwlCeOm6bJzWM2tzXEmtcJUW7V/BX+9zxs3E8t3XPEdfhIqonHIaCanW7UD7yqKw1
         w/yq+eoE68mQdq0lvdvFs6FC9HoiMtym69WBznvUi4DAbhTc4uzllFL0pBK/OEkP9fSd
         QmcMIAFBkzQ4oviVPVrWmuoNH9I5MwNCiIbzGxhEKnmG0zg6qtstI0NlV5LmWjb/JbOU
         AE+A==
X-Forwarded-Encrypted: i=1; AJvYcCWxUp8UtYn1d2TZWxRYHoiI0OrsIWuRlGGDdJbz0rcuxuml8xK5FxipiAGvSPPbK/1E1qSGy4cvJFvX@vger.kernel.org
X-Gm-Message-State: AOJu0YziB6rkbLKsOUm9xzpxl4sniuGsDGOBMPkTutY6efVvBTHHUPwc
	emShLX0uV6iXGR+uzbibw//4U28o9FhRBa9hVbjXlppj3CKw/jcsnS58fN0VM7fKkKdGbnexYWW
	+YIJt2zb3A+Uo7gV61o4jld5KIuDK04YAf11LOnGUEDV4tY6FemGPI7gXaus=
X-Received: by 2002:a5d:5258:0:b0:37c:cc54:ea72 with SMTP id ffacd0b85a97d-37cd5a687c8mr6230529f8f.4.1727691314538;
        Mon, 30 Sep 2024 03:15:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAmQ9keNL/1ukB9mMF7yp8J5+HTw3AMKd/GNMHUzlXqNxxyeInkNU+WTVYZxy9eRgobMCc5w==
X-Received: by 2002:a5d:5258:0:b0:37c:cc54:ea72 with SMTP id ffacd0b85a97d-37cd5a687c8mr6230519f8f.4.1727691314158;
        Mon, 30 Sep 2024 03:15:14 -0700 (PDT)
Received: from t14s (109-81-84-73.rct.o2.cz. [109.81.84.73])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd564d0a3sm8797984f8f.15.2024.09.30.03.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 03:15:13 -0700 (PDT)
Date: Mon, 30 Sep 2024 12:15:11 +0200
From: Jan Stancek <jstancek@redhat.com>
To: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Cc: Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ext4: don't set SB_RDONLY after filesystem errors
Message-ID: <Zvp6L+oFnfASaoHl@t14s>
References: <20240805201241.27286-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240805201241.27286-1-jack@suse.cz>

On Mon, Aug 05, 2024 at 10:12:41PM +0200, Jan Kara wrote:
>When the filesystem is mounted with errors=remount-ro, we were setting
>SB_RDONLY flag to stop all filesystem modifications. We knew this misses
>proper locking (sb->s_umount) and does not go through proper filesystem
>remount procedure but it has been the way this worked since early ext2
>days and it was good enough for catastrophic situation damage
>mitigation. Recently, syzbot has found a way (see link) to trigger
>warnings in filesystem freezing because the code got confused by
>SB_RDONLY changing under its hands. Since these days we set
>EXT4_FLAGS_SHUTDOWN on the superblock which is enough to stop all
>filesystem modifications, modifying SB_RDONLY shouldn't be needed. So
>stop doing that.
>
>Link: https://lore.kernel.org/all/000000000000b90a8e061e21d12f@google.com
>Reported-by: Christian Brauner <brauner@kernel.org>
>Signed-off-by: Jan Kara <jack@suse.cz>
>---
> fs/ext4/super.c | 9 +++++----
> 1 file changed, 5 insertions(+), 4 deletions(-)
>
>Note that this patch introduces fstests failure with generic/459 test because
>it assumes that either freezing succeeds or 'ro' is among mount options. But
>we fail the freeze with EFSCORRUPTED. This needs fixing in the test but at this
>point I'm not sure how exactly.
>
>diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>index e72145c4ae5a..93c016b186c0 100644
>--- a/fs/ext4/super.c
>+++ b/fs/ext4/super.c
>@@ -735,11 +735,12 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
>
> 	ext4_msg(sb, KERN_CRIT, "Remounting filesystem read-only");
> 	/*
>-	 * Make sure updated value of ->s_mount_flags will be visible before
>-	 * ->s_flags update
>+	 * EXT4_FLAGS_SHUTDOWN was set which stops all filesystem
>+	 * modifications. We don't set SB_RDONLY because that requires
>+	 * sb->s_umount semaphore and setting it without proper remount
>+	 * procedure is confusing code such as freeze_super() leading to
>+	 * deadlocks and other problems.
> 	 */
>-	smp_wmb();
>-	sb->s_flags |= SB_RDONLY;

Hi,

shouldn't the SB_RDONLY still be set (in __ext4_remount()) for the case
when user triggers the abort with mount(.., "abort")? Because now we seem
to always hit the condition that returns EROFS to user-space.

I'm seeing LTP's fanotify22 failing for a about week (roughly since
commit de5cb0dcb74c) on:

   fanotify22.c:59: TINFO: Mounting /dev/loop0 to /tmp/LTP_fanqgL299/test_mnt fstyp=ext4 flags=21
   fanotify22.c:59: TBROK: mount(/dev/loop0, test_mnt, ext4, 33, 0x4211ed) failed: EROFS (30)

	static void trigger_fs_abort(void)
	{
		SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type,
			   MS_REMOUNT|MS_RDONLY, "abort");
	}

Thanks,
Jan


