Return-Path: <linux-ext4+bounces-3009-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C9291B358
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Jun 2024 02:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF0501F22503
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Jun 2024 00:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13594C98;
	Fri, 28 Jun 2024 00:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ANkSa4zo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27404428
	for <linux-ext4@vger.kernel.org>; Fri, 28 Jun 2024 00:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719534306; cv=none; b=Jdcu0XiWv6Fq8GWWd//aR+gVHbaJUphQCrFT2geuNULFPMKIIuWMU7KlkQWu4hDNNA/7kKpDRvhUJ4c/okDDvtobMCXbEjEIFrYqpeZbYn2AOi0wlzq3DK4t6umZkg8SNQmqQMwbufjqZQ3sG8iuWqlG2cYDot6qc9IjqTK82wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719534306; c=relaxed/simple;
	bh=B7ai0eVoKTNczcFTdEd5cVJdPhoqYSzvFR4/p1O1rYo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=GZ/xsJHAxHYSmIeku2DPEQlTW0Lf0rllfldKBFOlofLpuJ5Ku/PkJjQV7kdFiw6PMlRVkE9iB8MXM56PGvGS9Y+wsN/mFKYiZPoa+KTWdEO/GDFnHD1tSH2akArneMNqcVRkAQAcHHitif5tWrxcKMDZtFi4adS/rMh4oDiHirQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ANkSa4zo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719534303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Pht9Lfpad0vyg1Yyut9IEpvrjSRLNRr1y5QQbadsiGU=;
	b=ANkSa4zoOzL3+PvGs74y5JvQkv60ko+P7S0Oc/fZOFfMtzTrdbjYmBEnIbJ+p4/CPYshKJ
	dhmtLJt7sJYDlU/W8g/50HfgVp4F0mFVKbZddKuYgY/Mxq6HUzIM8TiFj1jZuQCKx2TlsU
	PG3iJYQbgWAnpbD4x/798ZwUSHxO4Qc=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-1NyLuRH7MIuOa4OUlfyftg-1; Thu, 27 Jun 2024 20:25:01 -0400
X-MC-Unique: 1NyLuRH7MIuOa4OUlfyftg-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-376210a881dso1074585ab.1
        for <linux-ext4@vger.kernel.org>; Thu, 27 Jun 2024 17:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719534301; x=1720139101;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pht9Lfpad0vyg1Yyut9IEpvrjSRLNRr1y5QQbadsiGU=;
        b=qbnzhU8M04tD7sclKaBgcSH/u6IXpIKC4czr5KjaoAB2FPc0kwRDToOAIcp8KyOfN4
         KpM56XV940KBP1+ShwcmWbTQdU/hraKTvbQIHMTwFWMWi5ag/jxMuY1vHRjaZPxPdSpy
         ThNpWnfWpeYziDaptYnIWgy9/kU+OGAt1eLMINo5X2vyJb7kEvYyYOX1nI0ldxu+zdUh
         hM6Zv3bDznu8RY0bPHgO3zmrQjdDt4Q/QqxvigRkrCsCxpVEZ12BDpoQtiGdkV/4Q58K
         SVgX4innyljB0+ENA+KMZ9Xa8Fxj+kzNnjr7WzA7yinHhNKTWQjanNgE4PEZ6H++6MIM
         xYrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS0Q12GULRfn1khP8AYsFuZzVO3pawfnrtFANOEX13AYG6nSzVah/JfnqZaE/S5plVpoTFlRW6nE++d2jk8QVOvZ/MAjQyq7l7Fg==
X-Gm-Message-State: AOJu0YwCCLwExSXmwiDXsbEld8o9yn4x2nEfA2J+WXPcOS3HZAyJY+ow
	OsKub4uvXSz4uWG3t+xYQfyCiqQm5f/BV69LHrKF5tnEzdgejvN5SJHtJkUGwqSUkovSmiqYPnE
	wgi2qIpYIYeVOY7LaYzPBnfLGZK9tutDfM+zYW7j6bZ3pzE/mqcjlGqkgj7I=
X-Received: by 2002:a05:6e02:b4b:b0:375:86bb:2142 with SMTP id e9e14a558f8ab-3763e0607bfmr185522605ab.24.1719534301025;
        Thu, 27 Jun 2024 17:25:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH481kZ0wneyCG62Atf5OEAOI8SNnvN2mW4RtYhpSMGDQsWqiRmeiQ26Brky+7JgOdDtIxULw==
X-Received: by 2002:a05:6e02:b4b:b0:375:86bb:2142 with SMTP id e9e14a558f8ab-3763e0607bfmr185522465ab.24.1719534300668;
        Thu, 27 Jun 2024 17:25:00 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37ad4370c90sm1696895ab.69.2024.06.27.17.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 17:25:00 -0700 (PDT)
Message-ID: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
Date: Thu, 27 Jun 2024 19:24:59 -0500
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: autofs@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-efi@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>,
 linux-ext4@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 linux-mm@kvack.org, Jan Kara <jack@suse.cz>, ntfs3@lists.linux.dev,
 linux-mm@kvack.org, linux-cifs@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Hans Caniullan <hcaniull@redhat.com>
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 0/14] New uid & gid mount option parsing helpers
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Multiple filesystems take uid and gid as options, and the code to
create the ID from an integer and validate it is standard boilerplate
that can be moved into common helper functions, so do that for
consistency and less cut&paste.

This also helps avoid the buggy pattern noted by Seth Jenkins at
https://lore.kernel.org/lkml/CALxfFW4BXhEwxR0Q5LSkg-8Vb4r2MONKCcUCVioehXQKr35eHg@mail.gmail.com/
because uid/gid parsing will fail before any assignment in most
filesystems.

Net effect is a bit of code removal, as well.

Patch 1 is the infrastructure change, then per-fs conversions follow,
cc'd as appropriate.

This series is also at
https://git.kernel.org/pub/scm/linux/kernel/git/sandeen/linux.git/log/?h=mount-api-uid-helper

Thanks,
-Eric

 Documentation/filesystems/mount_api.rst |    9 +++++++--
 fs/autofs/inode.c                       |   16 ++++------------
 fs/debugfs/inode.c                      |   16 ++++------------
 fs/efivarfs/super.c                     |   12 ++++--------
 fs/exfat/super.c                        |    8 ++++----
 fs/ext4/super.c                         |   22 ++++------------------
 fs/fs_parser.c                          |   34 ++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c                         |   12 ++++--------
 fs/hugetlbfs/inode.c                    |   12 ++++--------
 fs/isofs/inode.c                        |   16 ++++------------
 fs/ntfs3/super.c                        |   12 ++++--------
 fs/smb/client/fs_context.c              |   39 ++++++++++++---------------------------
 fs/tracefs/inode.c                      |   16 ++++------------
 include/linux/fs_parser.h               |    6 +++++-
 mm/shmem.c                              |   12 ++++--------
 15 files changed, 102 insertions(+), 140 deletions(-)


