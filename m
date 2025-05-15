Return-Path: <linux-ext4+bounces-7908-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F19CAB8477
	for <lists+linux-ext4@lfdr.de>; Thu, 15 May 2025 13:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EB401BA861D
	for <lists+linux-ext4@lfdr.de>; Thu, 15 May 2025 11:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9953297A45;
	Thu, 15 May 2025 11:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcG0urWq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C07910E5;
	Thu, 15 May 2025 11:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747306873; cv=none; b=dwMtg7et93ZyAfpfJTY2UIz8dbs6k3D2HvX1DJjI3OXMJ7ymcZ4BigNvinftUhA4Di7HUeKQF9stBFZzGoLfQrLcvTE2lB0qLqefN4OlOgTKUxFOXAFnl8qgVtHGR91ugw4ZvVMLJgWWAOWX7nL6jTJw5Y+xGNTi8pDhn4c6NNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747306873; c=relaxed/simple;
	bh=4DtxbdHPsRp2yoFWNNjLqWeO8cEgtzLfsnC6zJx88R0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eoXVES1fkZpemVnz85ZbAh3eCCsBRv5YivAzefDnacCjpW0stTE05h8jNpd44dX1XR0hvgkA6qLyEvwYp5lBWrE8485QWH3GXZaE5cOuPZ4EDQsUpd+SeF2pFa5za6AiIpfoz1t89qlrog3UmqIv855snjdZRniGeXOHoswXIPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcG0urWq; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7399838db7fso766949b3a.0;
        Thu, 15 May 2025 04:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747306871; x=1747911671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n5bk8crn1MS6mjcakRWlTLc0upfKXeQVW/07eSuBmwM=;
        b=VcG0urWq753z57smN/b+qdPyKTn+rsv/gZKP/jkvbuiQ6QWaiYebM6gSqH6Q/WLg1U
         HBky9RySXn4eN00CC3jqAlYkzi4SDpMHu7w+EPawUEyM9uhOnByZjWetm5g572W/IF0T
         YdlPZjf6OvqTBWw9og1gHnGOQeGK8keuDXiSRx0l3wHqMiIgIKNdmRljOp18rWZtFSI1
         2QwU203Y3yhzZN7wodLJrbj7ICQHjTsMa2NsEGk7OnVh1t2FycHIcQdu4BNnZ6Y+O5Ma
         F4vcHmsbeqJ+hUQIZNvt/Ch5UJqn7q76KkW75vvuRw6uBq8dhbFwsSZf8C/l5xhP7fca
         P5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747306871; x=1747911671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n5bk8crn1MS6mjcakRWlTLc0upfKXeQVW/07eSuBmwM=;
        b=tafswzCVRVmDb1f6J+nTiVsG5Ee3wcS4TKzLwb45pgj4RLnYxu1Cxc1mFDCVystOxA
         lyu+ZA7GTDsRvfLHc+VAThdRq3Mh2gpAlv1lV9fpgcvW4rP3/rT8PMtp0/+laQD4nDW+
         BN3SEb6+UBAeySxiD9HqNDC+S+3ySHjD6p3UO2RKlj37pTbn3lvWyuDhiEVz7LEdPoyq
         cd2ziU32LgJHnhOG3gbDJ/O0T9Z5zS0bfmkKIhrnKtLlF3uxZAP6AHHPnXIx7JPeYpJF
         of/7y8vkuALEqoNCn76Vz/q/VnzBaJIXbnQBVkcg22xvI12YA+TC+y3X85yC5Ia29y2h
         C9hw==
X-Forwarded-Encrypted: i=1; AJvYcCVvRfg2xXk6y+E5FwwfSkiZ5alj2ybseTk/tlDrZ+/uSYMyzr9ddaN4oqXN+LABrbWH1eNoz4PijZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHRCjnmCeBW+eTs7dUfKpK6+uASKW89a5ZwYT5ytqkoWzZRMWJ
	YEY9F2SIhNNRiKSCDKJ7KzoyQ5aE9ndFBHd9mAjjghIcu3nSsKm1+eh/FzkiSw==
X-Gm-Gg: ASbGncujUI4Zb97TKZK/zDyngY8nVkxbopZy2FU8vsaF4c59Tnax2ol/cwvRTe83QoT
	yV4Y1UEzxe8gyYmhzhnosdhj+59Uf73kwIiXjaKNlkae2R4PRyYMiI+U3HWGfU56Z2hxLrB7EcF
	zvizrdc+L03a3wlxsEU9kgQc3Wj7UbVQlDDX2DszGjLnQMDhLwHtzZw1XmQxOtwX2r9CJMavIoB
	ieC3ECQlHuLY0cFv4kVKaWOYWzl8jBhODYRnOawVEOxMndqx1GtMLsKp5CsPrFEk0n2aqt3Frfl
	e0eWvMSg0+Wy0zmn9R9PE+izQdii/osSdrXquxy+lIrrsvKWNAcqLt8=
X-Google-Smtp-Source: AGHT+IG9M5GDFFmf2o524GHS9HoirnkCLqvxy9ol7roMxczIqbVb6JQUVTKPxstvacVUimjoUvs7qA==
X-Received: by 2002:a05:6a00:6206:b0:732:5875:eb95 with SMTP id d2e1a72fcca58-742961c6c4bmr4358926b3a.4.1747306870659;
        Thu, 15 May 2025 04:01:10 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7423772752csm10733673b3a.45.2025.05.15.04.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 04:01:10 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	david@fromorbit.com,
	nirjhar.roy.lists@gmail.com
Subject: [PATCH v2 0/2] new: Improvements to new script
Date: Thu, 15 May 2025 11:00:15 +0000
Message-Id: <cover.1747306604.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a couple of improvements to the "new" script.
Patch-1/3 - Adds an optional name/email id parameter prompt to the new script while creating
 a new test file using the "new" file.
Patch 2/3 - Replace "status=0;exit 0" with _exit 0 in the skeleton file in "new".

[v1] -> v2
 - Added RB of Zorro in patch 2 of [v1]
 - Modified the prompt message for entering the author name (patch 1 of [v1])

[v1] https://lore.kernel.org/all/cover.1747123422.git.nirjhar.roy.lists@gmail.com/

Nirjhar Roy (IBM) (2):
  new: Add a new parameter (name/emailid) in the "new" script
  new: Replace "status=0; exit 0" with _exit 0

 new | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--
2.34.1


