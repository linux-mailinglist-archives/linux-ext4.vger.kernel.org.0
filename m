Return-Path: <linux-ext4+bounces-3362-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CC4939B69
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 09:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7C061C21B19
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 07:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F75414A617;
	Tue, 23 Jul 2024 07:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aKsC2dVQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E69413B5A6
	for <linux-ext4@vger.kernel.org>; Tue, 23 Jul 2024 07:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721718396; cv=none; b=TaZ8/nRs4P5SXTfs7khKZcw+Y0DP2cXWeOSVynTa4Oh9Vctk7N/b3hm+s22/FOPZn9SaAtjugQldQ9xvk+4Gc0ZvD7fsPXRS1mt/oI8qcKt5kfvlu6N3S9giy8QaIMWipO2t3gcfDW92IDZF7MOPffVapPSe8ZNynwI/fdBAoW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721718396; c=relaxed/simple;
	bh=T0a5WQAwYpflbA1vg5hpjmRavw1oEVX/Ht39sOULNIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=baZkSFI0/vS22c+pq+o70wG2h+rsIn5sn9m2tBXA/iHYLPJYo0eRQMOoOTxyyugAF0069BmbYmhjgPBeemvBkj7OJ73e7nl0FbRR1iIyZD3x9IT3obBHPoiV64X4q64iPH32G7EFKMwXmslq6yknUO0EOdVzFxsGAGqUAo4lY7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aKsC2dVQ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-75a6c290528so2973166a12.1
        for <linux-ext4@vger.kernel.org>; Tue, 23 Jul 2024 00:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721718395; x=1722323195; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TVQolDblYpfBAHM0BVYvZ7L0Xvl6DY3RRTkKfePEOus=;
        b=aKsC2dVQE/IB/Iv0FYumrRLGzIUHEyEZ7IsmMVY7f63qfFgTZX6upBtEhKeGNzmFP9
         mS+UvFRbJH9AOni/pmG0mM8UjHKb2yBkUuZJ8dpqEUAlvBYm0BLl5yjcS+jSD7+yw+Zu
         F4AMS7Hm6JNTCaAX3TTqI2/7boHQsmf6E57WQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721718395; x=1722323195;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TVQolDblYpfBAHM0BVYvZ7L0Xvl6DY3RRTkKfePEOus=;
        b=ZP7M1sE4VNqCsRZlbgtiuPPz3HELEN6j7XA8v7i8R/BWuH3fuThvPgpluijFT95C0n
         6Jm3Eohm84jRGxjlPFfv0paGEEPLS4arNeJm1FLGBvYN7C5s8l49rrZ1NTKTF6xYj4qZ
         caeV2tU2LAfa8kUNYGyBaXho40mIr52/oi4A/RH7NQjJZr62Jim+O//G1IykFmWJINZt
         WyXtbDxHZYa+79cpNZYwuwF+Z980pIKkV9rQMrVEuBpezomgP0xYspw+NC51h8Aw60sH
         jZZLfImzZJeH7Zfmr6Xh9YKlmAPkpOFnqtjqY1dszdahqG1oBggPndNPZQBwawGknliC
         6vSg==
X-Forwarded-Encrypted: i=1; AJvYcCV/qmeZ+etGk6lPTY2Z8zL+rawibvmNHw9hb2rYs/8UtPcmxkZWfJldgDnpqKSfMZHWhNMOC7JWv1UItHvBsHRkoOemNfFavmU7jA==
X-Gm-Message-State: AOJu0YyHH4T3l3bPKZPqACoDXt1lB+Hr/9dpRr06TDGNNsg5n2jMSjGr
	2zpD0JXsGwDNYdAupKdnbePSHx+cdGSr2eI6AZA8q8s3xvmkfIaWWrlndqEuSA==
X-Google-Smtp-Source: AGHT+IH6yBqLPZThrJF1lWBcvb2T28e1qgZqnd8sJbhHQ+K1obWAqxroFQqZT+6CS59cjnBEKk6+6w==
X-Received: by 2002:a05:6a21:9993:b0:1c2:8dd5:71d9 with SMTP id adf61e73a8af0-1c4285b75f1mr8005527637.4.1721718394067;
        Tue, 23 Jul 2024 00:06:34 -0700 (PDT)
Received: from akaher-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f25ac64sm67166915ad.59.2024.07.23.00.06.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2024 00:06:33 -0700 (PDT)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: gregkh@linuxfoundation.org
Cc: amir73il@gmail.com,
	chuck.lever@oracle.com,
	jack@suse.cz,
	krisman@collabora.com,
	patches@lists.linux.dev,
	sashal@kernel.org,
	stable@vger.kernel.org,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	florian.fainelli@broadcom.com
Subject: [PATCH 5.10 387/770] fanotify: Allow users to request FAN_FS_ERROR events
Date: Tue, 23 Jul 2024 12:36:27 +0530
Message-Id: <1721718387-9038-1-git-send-email-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20240618123422.213844892@linuxfoundation.org>
References: <20240618123422.213844892@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

> [ Upstream commit 9709bd548f11a092d124698118013f66e1740f9b ]
> 
> Wire up the FAN_FS_ERROR event in the fanotify_mark syscall, allowing
> user space to request the monitoring of FAN_FS_ERROR events.
> 
> These events are limited to filesystem marks, so check it is the
> case in the syscall handler.

Greg,

Without 9709bd548f11 in v5.10.y skips LTP fanotify22 test case, as: 
fanotify22.c:312: TCONF: FAN_FS_ERROR not supported in kernel

With 9709bd548f11 in v5.10.220, LTP fanotify22 is failing because of
timeout as no notification. To fix need to merge following two upstream
commit to v5.10:

124e7c61deb27d758df5ec0521c36cf08d417f7a:
0001-ext4_fix_error_code_saved_on_super_block_during_file_system.patch
https://lore.kernel.org/stable/1721717240-8786-1-git-send-email-ajay.kaher@broadcom.com/T/#mf76930487697d8c1383ed5d21678fe504e8e2305

9a089b21f79b47eed240d4da7ea0d049de7c9b4d:
0001-ext4_Send_notifications_on_error.patch
Link: https://lore.kernel.org/stable/1721717240-8786-1-git-send-email-ajay.kaher@broadcom.com/T/#md1be98e0ecafe4f92d7b61c048e15bcf286cbd53 

-Ajay


