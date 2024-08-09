Return-Path: <linux-ext4+bounces-3680-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B52594CABF
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2024 08:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7DD1C21A61
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2024 06:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4271816D321;
	Fri,  9 Aug 2024 06:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVR3fKEE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36626624;
	Fri,  9 Aug 2024 06:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723185975; cv=none; b=M3QhupHj9OKt390pufKOFhnfTUmxWxohnJ4gnXr7c3szt80ULc2noLKN2FyPMevX8R4OMxFE/T5YXFqLwfmnnVBiQgZAWYVCNiL90fKpH4cAe+zGkibzf7Wxy3KzPZVZmG3knefijpEzjWmkXr7cDytlkLwhDQ3cumnpEtt58NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723185975; c=relaxed/simple;
	bh=1joxv1ksnjmouaSqE1mNJ9XxLe97ama3DysLK+C65vc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cMJQ3d2WpDutAOr0zpYjqEMKsYXh8cYlFjhLio91RcXQ5lK0SBBBwTLaPEW8q7GL2LI8t5pzbhjpHf90S5feaw9/Z5OUOFPe67hOhPAstTP2+nerh2NTz8FUjkNDRkpmTN8d2LLTiC7Xt/nbjtePfBY4MiQhGFVVe5/fVki/J3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVR3fKEE; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2cb4b6ecb3dso1381875a91.3;
        Thu, 08 Aug 2024 23:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723185973; x=1723790773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MBw3XirkOExgZB4RgGpPUIQ5qcevCwgUYE5CGyoYQWY=;
        b=kVR3fKEEAUpAM/SPe7OrJuT5qVl6ZAmdnf6avkRmBBF99ruWct21wHjIfkVGNIS6zq
         TJqrFSqbk7vL1ZGByx2fz1IU7pfbqA+gtz4MtXQjCu8X8dVZviOvnDLAsHmW2gEF110p
         Fta+GMiDaASAk17hfzJ2ePO0Qn5cLr7Z5RqKmbl2f5404KDdRg8iOrTfniQ12m3JXf0c
         0iyJH6tg3zf+20sf2BGl1dmBnD3EGD6Mx5MoQiyjLKSkpyitsDUP7Ls9adpW9lYOzAkp
         5itm5XfebGpKjq/bKD39WcarBiDp2eu4Ta7eeZRcwOtUOgpEGCNQGqUEkN6Ptq1nwkZu
         qd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723185973; x=1723790773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MBw3XirkOExgZB4RgGpPUIQ5qcevCwgUYE5CGyoYQWY=;
        b=rCTmPsfqachIuBa8r6xXovyGzVZ6h+ZVxTF8pacbkoE/ladeeld5Po7gUNDVUFGvYA
         ioSYxWKjDqUNVcnwktgk3a/HxYq9miAqQKUMd3PQcQGKZmjmZDXxV2xyNVyPGKNJmbnO
         UL0GmTCJVCDNGHfUc2K09bb0FX7SZmnJ58HM4okwrWPxY8xZeC6Bpf4itsGb4MLiPp/D
         2U93Y13o8LcDsw1qObKAtOPcDn7D6snqe3eLDIXXYfOcRGbclDA/1kJCHm2wsHzFj1vg
         DIi6W3XzUyFZuPTO5+3xdhf9eL/2M9mLUAsYfVYC0IhE9wTyfep/u6dj/zMtx0nkbgtU
         iB2g==
X-Forwarded-Encrypted: i=1; AJvYcCUjOn5SoPGVAWUpfOqwfGbl/DPmzBBRptK6nxprug+9ol2zvRRKwiqGFXaumfs1RP0X2H+RPWFePk8Jsk3v2Iur5kWIC32NOt6TV9jg
X-Gm-Message-State: AOJu0Yy6DSy9+nDrxcxT0BuCzBgSA3i6hk7pePNCA+MGaR49OVEjRWHm
	ErcM4oaC29aFcqC8To8Ci9DQN6KGm+PvKp/IeHa+LQXCoRUr61Tc
X-Google-Smtp-Source: AGHT+IGo11IklYdTNRzaiPFFiAMhaWSDZTmBgpIxGPGxKt7MrujyKW32TDg/Mag2pAw2648iapApsA==
X-Received: by 2002:a17:90a:8d09:b0:2c9:755f:d4ae with SMTP id 98e67ed59e1d1-2d1e7f9a12bmr553039a91.8.1723185973205;
        Thu, 08 Aug 2024 23:46:13 -0700 (PDT)
Received: from localhost.localdomain ([163.53.18.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9db44e5sm2201491a91.46.2024.08.08.23.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 23:46:12 -0700 (PDT)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [RFC PATCH v2 0/2] Fix an error caused by improperly dirtied buffer 
Date: Fri,  9 Aug 2024 14:46:04 +0800
Message-Id: <20240809064606.3490994-1-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Hi all,

On an old kernel version(4.19, ext3, journal=data, pagesize=64k),
an assertion failure will occasionally be triggered by the line below:
---------
jbd2_journal_commit_transaction
{
...
J_ASSERT_BH(bh, !buffer_dirty(bh));
/*
* The buffer on BJ_Forget list and not jbddirty means
...
}
---------

The same condition may also be applied to the lattest kernel version.

This patch set fixes it by:
1.Trace the user data dirting in ext4_block_write_begin().(patch 1)
2.Replace the __block_write_begin with ext4_block_write_begin().(patch 2)
3.Remove some superfluous things.(patch 3)

But there is no patch 3. :p

Because the first two patch will have a restrained effect for ext4,
in that it works only when data = journal.
But for the patch 3, it is intended for removing the clear_buffer_new() 
and mark_buffer_dirty(), as suggested by Jan in [1]:

> From the part:
>                                 if (folio_test_uptodate(folio)) {
>                                         clear_buffer_new(bh);
>                                         set_buffer_uptodate(bh);
>                                         mark_buffer_dirty(bh);
>                                         continue;
>                                 }
>
> we can actually remove the clear_buffer_new() and mark_buffer_dirty() bits
> because they will be done by block_commit_write() or
> folio_zero_new_buffers() and they are superfluous and somewhat odd here
> anyway.
>
> And the call to folio_zero_new_buffers() from ext4_block_write_begin()
> needs to call ext4_journalled_zero_new_buffers() for inodes where data is
> journalled.
>

Specifically, assume we remove the clear_buffer_new() and mark_buffer_dirty(),
who will be reponsible for tracing/dirting it?
In data=journal:
ext4_journalled_write_end
   ext4_journalled_zero_new_buffers
       if (buffer_new(bh))
          if(!folio_test_uptodate(folio))
              write_end_fn
                 ext4_dirty_journalled_data(handle, bh);//mark dirty
          }
          clear_buffer_new(bh);//clear new
 
that means it will be dirtied only if the folio is not uptodate.

Maybe we should clear folio uptodate, too?
Things start to become a little scary now. 
So whether we should remove the mark_buffer_dirty() remains to be discussed.


-Shida.

[1] Version 1:
https://lore.kernel.org/linux-ext4/CANubcdVHbbq=WsTXU4EWAUPUby5--CLe5rf1GPzNPv+Y0a9VzQ@mail.gmail.com/T/#m19d3b9357f5dff050f75edc863e47f3cb018d778

Shida Zhang (2):
  ext4: fix a potential assertion failure due to improperly dirtied
    buffer
  ext4: Replace the __block_write_begin with ext4_block_write_begin

 fs/ext4/inode.c | 49 ++++++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

-- 
2.33.0


