Return-Path: <linux-ext4+bounces-68-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBE97F35E1
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Nov 2023 19:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C77282C76
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Nov 2023 18:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A980487BC;
	Tue, 21 Nov 2023 18:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vaa9FAjA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6320CF9;
	Tue, 21 Nov 2023 10:29:05 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b8382b8f5aso411136b6e.0;
        Tue, 21 Nov 2023 10:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700591344; x=1701196144; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ncCIxcs/xVLPnGvcaXoyTXXdbTA4XUJvEc6jXEcdnbY=;
        b=Vaa9FAjAup+HrK4KOLSUUHaEtoaoqml+FaG8LkjqaI9oKAf+ME8OLGkrwiR5bojYPR
         NCAMzYjN5HLtXWaKKjPrHuF72/pIwjkJ7ngoBgM9f2PA+4hAG4MkpKV075X5BZlxjDnv
         C51C+X9bCEua1gSHu6UTGTXtDoqE2tw1MnR9cNWNlp4y32KGNREaK2G2wVuldJyYyX7y
         ZNdyfE4y1fUIWvsAG9ZV5JnXKBxlsiXsvwrw2BlWkk6LtmZJvzA3x+vzyJN3+ynUa5S6
         6HjYHAUpF5vraACCKTAQyhVuWCJx5UjzaINgPuUcWLo2nSZxmkV0cdNkiWDdj4Yh6Mbs
         Q4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700591344; x=1701196144;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ncCIxcs/xVLPnGvcaXoyTXXdbTA4XUJvEc6jXEcdnbY=;
        b=Z7LyYrZrD/zPueimgPYk+n01rJU15i+5HzWb63T1CdAy05dSVfpbsu5aLWWcsfTPx9
         1eIuCxLpgm+Qh3xwF56vbbagkzwZMiiYOLrpFmdtQSwdE2SBeqeJe5hFqB8PaBHSOvEr
         I8bPbbd5DLcGBMZpaa8mhxBEVbDVewL7WtXuVJYvOD9y744tXmAOoNEIWDDwv6+992+p
         hBN88cRvP/PzoWeqaKGkKsxXtRBVTxJDbpB6zb3jT8guurSaUdB77Rt82ME9MfZkk4bP
         C8s8fVH4hBg4bZFyNFkqu86YWYxagSSUCVtJAH+y2jKqDq/DiVqykW/yd2lO7Hs1nnqN
         CEEw==
X-Gm-Message-State: AOJu0YyXNpyNXS9Ods+ZKooOV7zXmG6gfPce4GPD0nrpnrBmqymHTHZp
	Efpevdl5boGr5srLEBZHtITOr0oFOnI=
X-Google-Smtp-Source: AGHT+IHlyuDisIhQj/U16OiyMIa+UvOVHhFklkEjm00h/DBpWhY2Hbw43NVFiuJhRteAolGAgujRjA==
X-Received: by 2002:a05:6808:8da:b0:3b6:4ee:49c8 with SMTP id k26-20020a05680808da00b003b604ee49c8mr94279oij.54.1700591344685;
        Tue, 21 Nov 2023 10:29:04 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id t5-20020a6564c5000000b005aa800c149bsm7049448pgv.39.2023.11.21.10.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 10:29:03 -0800 (PST)
Date: Tue, 21 Nov 2023 23:58:55 +0530
Message-Id: <87zfz7dkpk.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, oliver.sang@intel.com, Jan Kara <jack@suse.cz>
Subject: Re: [linus:master] [ext2]  bc943f4872: xfstests.generic.269.fail
In-Reply-To: <202311211653.3a9e8678-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

kernel test robot <oliver.sang@intel.com> writes:

> Hello,
>
> kernel test robot noticed "xfstests.generic.269.fail" on:
>

generic/269 is a ENOSPC with fsstress. There is a recent fix made to
this testcase [1]. Could it be that you are missing generic/269 fix in
your tree? xfstests recently got updated here [2].

[1]: https://lore.kernel.org/fstests/169687552545.3948976.16961989033707045098.stgit@frogsfrogsfrogs/

[2]: https://lore.kernel.org/fstests/5fbaeebad0ffc8fc6944b35631ebc117.Zorro%20Lang%20%3Czlang@kernel.org/

-ritesh

