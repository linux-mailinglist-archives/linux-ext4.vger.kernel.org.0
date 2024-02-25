Return-Path: <linux-ext4+bounces-1384-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB26862B68
	for <lists+linux-ext4@lfdr.de>; Sun, 25 Feb 2024 17:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF24F1F219AD
	for <lists+linux-ext4@lfdr.de>; Sun, 25 Feb 2024 16:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5043D175A7;
	Sun, 25 Feb 2024 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0fzgpB0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4017F10979;
	Sun, 25 Feb 2024 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708877242; cv=none; b=ALrcdIrQcuHNS4iRYAf6ClV+7qV8feTA8qTt3SOoX63O2detpGCLy9/CRqLICLR8Fd+4AhsR8bhUhe3EjBbWBtXsXwRFlC7QVOwhFZrmzLhebUBET4+Fq6QP20gJNSvW4H9CpOkCFoOChKf6OlUEvBbxj3kNBE2WoumpyFsdf3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708877242; c=relaxed/simple;
	bh=ojvq2a2lJ8LluXCTGBiPZiYk+1YnG7ZSb6t6D/YYrEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7SK54+gltpXN3C5K7rIuSg7DPv7XlQZov5bRQ9eCL8QlaEHkcfR38rzhPv9y2xVomJs41nj19I5Y1CoWhU84P5kfMi9Igmbfz491F2qPOKS4lYO+KruAyknTVVUwHTBq0B/7aim20qauJhL1LD/5Enoz0/pEyVk3scF+/GKSzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0fzgpB0; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so1728310a12.1;
        Sun, 25 Feb 2024 08:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708877240; x=1709482040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gRB5mRoUZdjLcMpcOzyXA/yV9oCYtE3HK3r97520qXw=;
        b=Z0fzgpB0ilqmQnLxQA3Sr8OdNiV/TKkjxCVfjudwePXhn3Z/QqSoWVvjhp9PGX3fyc
         VmRnWCA86LeDsRW5Yr0M6g1T7yzvVoxk5wUuaPf5J/UHgrDouGL0DojxM86sGRawJi5J
         f7HxXKUrHRC4Cjp+2jppve5kGgm+DaaN5Srl78DbSTN7vaDmXk7h4srJXT8nWPAO+BKM
         CQ8eBmGCZGoS7mnV7onttq2uIKXvj2/OvyZWubSar1boPZultHY1DvTxzb/fvMdZuhMY
         KOnNV7ZwEHJRjOPpITQs2TErNSlUPtZQceRCMXJVI1i8miSjbLU+C5iTKanzSut4ECkc
         t+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708877240; x=1709482040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRB5mRoUZdjLcMpcOzyXA/yV9oCYtE3HK3r97520qXw=;
        b=Xx1eu+FBaU6bDbvGXJJYsZ3ctzpRtoCmj7sTRXIxflvScwlb7uOvx80XMEMSMAb1wN
         Ww36jHUpZwZQvronvF02XKwAlz/cLbHrL6znCRL6cFQSKt73ALMnBHfRwQBkCNM6pavf
         54UzG9ezYIOMg/++s15/rTkIeENwxHEDoSuNtIx98C2tZNqldy/O8mqJkXiq0KSZkmlE
         af1u4FkYdHcSPrw3mhWVehITKkR5JL8dYmM+k73TDwbeol6ifeagZlQPDZHDs7oFq+1M
         JXZxunKvAtRYt+NohiTk4dlhij6guxyo+hMEiIwotCfEGpQadjt4aUlRMSx8//3e6d81
         J9pg==
X-Forwarded-Encrypted: i=1; AJvYcCUugYzXCBc+/fujMZBlWDY9LsxtvMyL6ahVpc+cr/lVqCoeLwFBAHx91gEFyiM4oxBo9rBel9/QknJ3+vqCo9zhkPR30NLauT/PmYCguRLoOkevH41NPwkGb76eDOlq1PeBVk+F+V54nQ==
X-Gm-Message-State: AOJu0YzT0hkg7rAtTqiAJrQe1Kal9LsxhrUPXUeDamWmgm3VI716YPMY
	Tsb64dBkX9YlXafzmuFzTtTpT3VbcnLxz1m10tsEEg6wmXf0C+ML6dMz17ng
X-Google-Smtp-Source: AGHT+IFySaw8RVbLMVPmMTHCP6+zcKpDhaLX1sNJZSMoh3WH2MZUrDZ40yNwEiDyvTgH3yq7AIZwxg==
X-Received: by 2002:a05:6a21:3987:b0:1a0:ebbd:9aeb with SMTP id ad7-20020a056a21398700b001a0ebbd9aebmr6781904pzc.5.1708877240600;
        Sun, 25 Feb 2024 08:07:20 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a21-20020a63e415000000b005bd980cca56sm2430625pgi.29.2024.02.25.08.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 08:07:20 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 25 Feb 2024 08:07:19 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] More unit test for mballoc
Message-ID: <2e7f5498-1a75-49c7-9217-74eac8895a0c@roeck-us.net>
References: <20240103104900.464789-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103104900.464789-1-shikemeng@huaweicloud.com>

On Wed, Jan 03, 2024 at 06:48:55PM +0800, Kemeng Shi wrote:
> This series covers more function to mark on-disk bitmap. Besides, some
> code which is relevant to buddy cache is also tested.
> Before more work is done, I want to be sure I'm not on a wrong
> direction!
> 
> v1->v2:
> -Fix unused variable warning which is reported at
> https://lore.kernel.org/lkml/202311260042.kMxL6DnL-lkp@intel.com/T/
> 

With this patch series in linux-text, and with various debug options
enabled, unit tests for ext4 fail widely and result in crashes.

[    4.798582]         # Subtest: test_new_blocks_simple
[    4.803166] BUG: key 00000000000000a8 has not been registered!
[    4.803443] ------------[ cut here ]------------
ILLOPC: ffffffff9050cbf4: 0f 0b
[    4.803521] DEBUG_LOCKS_WARN_ON(1)
[    4.803720] WARNING: CPU: 0 PID: 154 at kernel/locking/lockdep.c:4895 lockdep_init_map_type+0x224/0x250
...
[    4.833277]         # Subtest: test_mb_mark_used
[    4.835875] ------------[ cut here ]------------
[    4.836055] kernel BUG at fs/ext4/mballoc.c:2053!

Guenter

