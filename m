Return-Path: <linux-ext4+bounces-6727-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA815A57A2A
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Mar 2025 13:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D76CB16C44E
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Mar 2025 12:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFDA1B4139;
	Sat,  8 Mar 2025 12:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0PoJTqO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245F01925BC;
	Sat,  8 Mar 2025 12:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741437168; cv=none; b=H34wSJ8UR1X8Y5qfKjhJS+A7znFwbMsnvS7Pgiz3gPTi5clpAr0IcZ1cNFvSJUMrL+vJCdNz/qvJAQs+BP7GEJDWEbuodFvCu6j+t71t80EK45z42iUyvOJs1iSqGrAA/V7BLL/nGGaagywo25yOjeALz4xW/f1h6VXc2hXkYvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741437168; c=relaxed/simple;
	bh=qGtrLrdVavcPEz2I7BHEGk2utg+yWPxQkYKEelx7cEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qPbPQsSNtDIygcAtxgB7dt9Ap7oBdYTs0lhlEcz2EsJmDGa4+N7YkSW6c8Qh5EvtY+C75Pgwncn/+JIJb9DMQwynKoZrYkIfvw0VmQcJwIwpCCEtzA62LdYRkfgr955rulgoCTbTWm7OLmDPeZ9EA6qrQ7rkEe5dJAn8oCDXPUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0PoJTqO; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaedd529ba1so333437266b.1;
        Sat, 08 Mar 2025 04:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741437165; x=1742041965; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHKuaXh45+tYx/7kzOu0DC+AEvxlTgN7K25asMDT5iQ=;
        b=Z0PoJTqOgYlJ2KCtGa91kE8BMRSXIz7lW1JXB0/bCyOq2iT1BBVZnok4ldlnHJBRcG
         GL+28p2QzAlb2fyrGNkwKGK1w1I0xr8TRFyqMPI/HsI3eXz07hIWfo+yftOX5HshVxP9
         JXR9HOFKWhjGw4FBv8dyrRRPN0R1c+dt+pS9BB6MedcGunWMEqqlb1534WzkRWbazR02
         eJi3Arc4k+TCNnnrkLd+4dfBCFLjRLblMCbk8KEnzniMPC/U7jSodqBE87yFgKaaIlR1
         FXjms48fscDKQ5wR/idT5wawnXozm19p+GJPKgzZzumywKNB5Bh1MJLBopSz1kaVLTuU
         r7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741437165; x=1742041965;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZHKuaXh45+tYx/7kzOu0DC+AEvxlTgN7K25asMDT5iQ=;
        b=wO4k3yqJazhtIaFJpmxh9f5lfZd1zSPINeA/+vhPqfT8JO+9oMgpEUTVREtEDkEYEg
         nnnBwrvCrU+KLTHpazyYqXU+9j3I3rH0Q83C07Bf52VTDk5xGEEDygWBk/7/gr45RTRi
         Ly5+ueCFxhKcI6Q0HE62pKWfhBDEhCPJi6f5XMFT4JXiLfvW6yrvinF6kQXSPE1WmuDW
         Rgv2C5Qlszt5nIVs3QwSkJZ6r8yc84v3IyJFKa5pyYbaeds3K3BqxSUjXj/N6TsdNazf
         +HfPMRJkqN9Hc/1KgnUOLaFhJU2n5hl0kN562gcaDl9WjFGq2sfvMxtDhlECb2FdvI5g
         J6GQ==
X-Forwarded-Encrypted: i=1; AJvYcCWycs4egfom/ubCZBImtJwWVB0BwpgNK9VLrhQMHGgnw/N5ZnSbe7vtDLY8pryS+rDK7cWwHQulg6Bx+2b6@vger.kernel.org, AJvYcCXKBR0az4h09x0IAUMNhcOrdJI7xG8w+Rtbk52+n1zM0UHsZgIEdXZhtoEuLkx7sn/pbNPyRHf4I0hE@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6V7X4EzTYZr8DF3WvLMT8DMy/vvmgZem90gxOJNtcHl/5hOnp
	hYMk5nhYCKVXethtF2SluCmtOYokoqp02T4GoOqNvxNHZAqCIcfzY/2Lwg==
X-Gm-Gg: ASbGncsVkRaCSpet8Ey2ZcGtdCVK2iYnBf1NRP0iiIFj4e+x6nFWgJhKCOSwMVFKIUD
	YoK9oWqc9RO8OQ2AHyB1+aHVvVNCc+DeltSVpLrD9DgRTjVW4078VRtidq4Rgk9PE3/u4jzgFCY
	1c1IVDfRM+aP5XocDi0VhefFeDVbhSlaLtukvJDEG3fhuGYytf3m3rF5G2hyH6i6DW/GhjLdiLx
	coe4pvqo4snDK3rcj9qlFGvHAE5xDw1mkwlpcfUvi4F1Fh1fk6cMoz4fUI54y4XlGk4bUT/pNeb
	FsUweS5xpu5pE6tN6bpC5uJCKhusICMG+XXOEXOx8iILzPOx
X-Google-Smtp-Source: AGHT+IE4Pj2XFWGcf4xYLSf28qlK45DbvkRoH6gzYHmFKEomjC0Asx6OW0DonbipoAxUh0WRhFrIBw==
X-Received: by 2002:a05:6402:1ed2:b0:5dc:74fd:abf1 with SMTP id 4fb4d7f45d1cf-5e5e22d523amr19300217a12.15.1741437165079;
        Sat, 08 Mar 2025 04:32:45 -0800 (PST)
Received: from qasdev.system ([2a02:c7c:6696:8300:f465:a080:411e:5b2d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23988b0b0sm431625566b.130.2025.03.08.04.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 04:32:44 -0800 (PST)
Date: Sat, 8 Mar 2025 12:32:42 +0000
From: Qasim Ijaz <qasdev00@gmail.com>
To: Charles Han <hanchunchao@inspur.com>
Cc: adilger.kernel@dilger.ca, tytso@mit.edu, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix potential null dereference in ext4 test
Message-ID: <Z8w43zQ2KVUPbxFi@qasdev.system>
Reply-To: 20250307115432.2112-1-hanchunchao@inspur.com
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 07, 2025 at 07:54:31PM +0800, Charles Han wrote:
> kunit_kzalloc() may return a NULL pointer, dereferencing it without
> NULL check may lead to NULL dereference.
> Add a NULL check for test_state
> 
> Fixes: b7098e1fa7bc ("ext4: Add unit test for mb_free_blocks")
> Fixes: ac96b56a2fbd ("ext4: Add unit test for mb_mark_used")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>  fs/ext4/mballoc-test.c | 2 ++
>  1 file changed, 2 insertions(+)

Hi Charles,

I already submitted a patch for this on 5th March, link below:

Link: <https://lore.kernel.org/linux-ext4/20250305124012.28500-1-qasdev00@gmail.com/T/#u>

Thanks,
Qasim
> 
> diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
> index bb2a223b207c..d634c12f1984 100644
> --- a/fs/ext4/mballoc-test.c
> +++ b/fs/ext4/mballoc-test.c
> @@ -796,6 +796,7 @@ static void test_mb_mark_used(struct kunit *test)
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buddy);
>  	grp = kunit_kzalloc(test, offsetof(struct ext4_group_info,
>  				bb_counters[MB_NUM_ORDERS(sb)]), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, grp);
>  
>  	ret = ext4_mb_load_buddy(sb, TEST_GOAL_GROUP, &e4b);
>  	KUNIT_ASSERT_EQ(test, ret, 0);
> @@ -860,6 +861,7 @@ static void test_mb_free_blocks(struct kunit *test)
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buddy);
>  	grp = kunit_kzalloc(test, offsetof(struct ext4_group_info,
>  				bb_counters[MB_NUM_ORDERS(sb)]), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, grp);
>  
>  	ret = ext4_mb_load_buddy(sb, TEST_GOAL_GROUP, &e4b);
>  	KUNIT_ASSERT_EQ(test, ret, 0);
> -- 
> 2.43.0
> 

