Return-Path: <linux-ext4+bounces-3145-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA8F92B9E0
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jul 2024 14:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE01E1C21FE0
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jul 2024 12:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFBB15A843;
	Tue,  9 Jul 2024 12:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ltux12fo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7B215539D
	for <linux-ext4@vger.kernel.org>; Tue,  9 Jul 2024 12:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720529221; cv=none; b=ou/9R4te9r9Iqx6NE3pssAPLDCpxsu1Gli+9e6cAYKUjSGwJxS+lYdaMaAaoYgRREIR+7Nlg+8P4KgUv/Gfjl+FkquQILc9Zn7Oxr0g72PZZn1X/MlpTL4/VQpMr7SJhNDLEBcnuwyXMKDRs/wOXP66Rh4FvHn9PjHegG4n7Tw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720529221; c=relaxed/simple;
	bh=hk0DHnKzawL33yfuSn5XZ72kwR1jS4MDyKOHPmXDiAM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=JLE+n6umq+NhweJamYQqZXYppvXMVwG/+tPJlA8MIxEiFTAl+1MHiSaozsHpecenupdAMygUeSt0/nk4YRkoY2DgA92LtCOXasV9qaXJqxayT7dcYYITyRp8Rca+Qi1NJkO6CrWA/1pbwTvHpsoRZclQVfo5mtIutopALKU8Od4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ltux12fo; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-65a14a92370so273707b3.3
        for <linux-ext4@vger.kernel.org>; Tue, 09 Jul 2024 05:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720529219; x=1721134019; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hk0DHnKzawL33yfuSn5XZ72kwR1jS4MDyKOHPmXDiAM=;
        b=Ltux12fob2Sn7K8bugSKSy7dlzDtZQxOVL9jKMKbE2vB5d8WLpbZeUkX3ZCMiExkib
         Y8WRT/20tvhUF3JNt+taUrQd4SZ2dswDeV7fS6diZyE0ZW5X3ZFYHGOdbT2Bw7tBodby
         E5UJczswq/8rfFweOgJd19F8XnSiLDv36CwlMRrvXrBIVMwpIL3O/xxrSC829eeYdFDK
         ewpwnsByGjDJxx2o3w6BkIFLB0X8d4TEeiIAH1GssbSPokq2cdaxGH29IH4tTtGNhUyy
         ih8dsEYhisI+SwcN8OP2JRb9dMa3NIJ2Ejryx1CHdBh+NvuLVqIj6xG4SpAWnZcd6p4z
         OwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720529219; x=1721134019;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hk0DHnKzawL33yfuSn5XZ72kwR1jS4MDyKOHPmXDiAM=;
        b=YtaQ8gGJosgWFgBfqmIMSMQM/8mxzFL8LnQPd4RY7mHhlTF2dpd+atRmgtkkz/VZbP
         Qdw0CyhjKufIEV6vtTOgtttd6IIF45CKwPMqwx1zToj0Ut0ETWfHQ5BRReQIdgY74h8N
         Hk72TMAunwnZSaKAISOnFds8nrx/SARcOmP9IazLEV1A8I7Odsduwlf47cBBH4yeLPlR
         pTlaLJkISgXoFyF8uOYuy6QIAfTvvCJjbyQyf1QN6CkkQNheACdZsW1iI51+BQJPuZik
         Q0q105Mlb+F1l0p1jHTgWvDuDhg1pKMfrlQs9yCaQQX1KVGyStkviIDrIP++F6WFntgP
         mcPg==
X-Gm-Message-State: AOJu0YwKhOPWg8EUadsvs6CZsyP31NYPuvRUrir6uqmZMk0AR1C9HLEQ
	7oW3+B+dPV8lvGtg7s6IE62hzq7mkp18tnTdQclQwygLWZQ7+1Y1NA27MWfPrbAYq7HL4sKWzSL
	Lw28hRU3DA8e5I1dxV+t/jzdDeRDg2U0vS3c=
X-Google-Smtp-Source: AGHT+IGC5Zx+eMvzPv8wCmIzQXZZHCF9uK53nCuD/C6NdkdbIvzzE4+pK2Gg8YVdZVnPDdD2SpKsYA5tQ3tI8NqeUtg=
X-Received: by 2002:a05:690c:6781:b0:650:ae55:9873 with SMTP id
 00721157ae682-658f08ce66cmr30891217b3.47.1720529219108; Tue, 09 Jul 2024
 05:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rohit Singh <rohitsd1409@gmail.com>
Date: Tue, 9 Jul 2024 18:16:48 +0530
Message-ID: <CAM70bNa8R5R37KFb=ThD4o7gTkna4goMmGho8tkqrCfZ9LBkGQ@mail.gmail.com>
Subject: Updating i_disksize without acquiring i_data_sem semaphore
To: linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello.
I am looking around ext4 code and I observed the following issue.

Within ext4_insert_range(), EXT4_I(inode)->i_disksize is being updated
without acquiring i_data_sem.

I have seen code where this operation is done after acquiring
i_data_sem such as in
ext4_update_i_disksize()

So, is this as expected or is it problematic?

Regards,
Rohit

