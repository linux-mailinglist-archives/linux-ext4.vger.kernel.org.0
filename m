Return-Path: <linux-ext4+bounces-9340-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8BCB22E59
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Aug 2025 18:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA9B3A6A77
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Aug 2025 16:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3868E2FA0F8;
	Tue, 12 Aug 2025 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMBnaTl7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB03280018;
	Tue, 12 Aug 2025 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755017652; cv=none; b=GXMVsiLtfdC6d+xyd3C2aWiqqaBNBzFCFY3RLJcEuY2Dfa/uy1JrWq7uhB7g4Hb+SJfeIkkmoV4VA3b9OVNQpdQx3J86Dnkwa5/4SolRxVzbcDb4n1A79aESLnQ0eXGbfZvaUTOf7NGDRVIk+ef3ZalD/7ZBu87/lHKa6yJ2qDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755017652; c=relaxed/simple;
	bh=FMnY8Q5KvNSrxp5A0evPe/gyrxbVf6qxqvIJnxtc2Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pJvxQkCffhxxJzwoWY1KVl9mZyhD8Wmp6g4SUmTMRHhlkdsZwp+lMH0eusARpaFk0ozuJeWEypvvrl5JlTKXvhZyPHfM11ED6IGPQUN1T2oU9U7uwO6bMlOZpqiKONNTNuho57xxU78GB/DLCX49mD/PEAH5uZwMpLyfeX838sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMBnaTl7; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7430835eae1so40530a34.1;
        Tue, 12 Aug 2025 09:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755017650; x=1755622450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=axc3NlzEWDOXd+gEuNTDLEsYjSZ8XkkLcsbwtnhrv6k=;
        b=KMBnaTl7BzPDeHwZiIJnYijLAX7HgGg1IivZ6gu86eOC1Noq8wZxcuDkbiadjIXqUB
         gNsU8jWUDf6LkvKOJgoLXPhV5KZGEicrCuZoZ8RBW/8gN8Wpti+tmO1ORt7kBOh6QT96
         kwNM12m00FxDXLTy4r0aVAIlDss5PspjANjSG279s+qJCp8NR2RYHHVMqesg2ie4X8d9
         ob37zFGYS/b3awVBzbmJELZqp4pQyPrrc89GLYAEVSP3x9/9O5nce1GaduwByJ7cMVGS
         VbI8/Qn8ADpvdFPJyHjf+1Z/o2OgKiSSiJyu7eFQtUSrLmOTBxJizGjSGenWNpGcleCd
         8hZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755017650; x=1755622450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=axc3NlzEWDOXd+gEuNTDLEsYjSZ8XkkLcsbwtnhrv6k=;
        b=wST+QSt7YayBAM2KbE/UWNBjblp+pmzyEMAj8CQhiG3+EGPUUEzINIYZvUhwBgBcCw
         UOTjICMPqr1e0D1jXpCnRCGRyPDEEwOCeKKJmqVdh6PjiQZabNifbm4ZvQ07ur7jD/qE
         CXvtPMstgIJ+ylHuorfvsvlDoSrrDAxzJMYwzxxlVZQW4Dck16ooyFAqMbyDZpg2kwm+
         3M9RtzoYXuMIYcPMFSPwhQde8oLWNAXrWim7AmPhABKIvdvQ491geJ1oLpVvMVuB9Dfa
         0imAHq3z3Qc+b2ERtngnvra84/LeLdYN+ERdIrYbi5RA2cggrwOvO+h4vl7DzRihMthD
         ydJA==
X-Forwarded-Encrypted: i=1; AJvYcCUQP4gO1KEMhgNAlupK3+HbOUMCgQtIgxN1mor8pNv1WX3Tfx9/LtCZLL7ww+68JvV8yRrJTy/L6CgMIiom@vger.kernel.org, AJvYcCVMQvhNhdM/4jBtdi3Ev7gkP027SB8Pae6IutlEZuyf8+1hyHD7baosLbu3QaqbWE10SZGSXAjNDOit@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8k9vXneQvLXFSnUq9bv67Vh1w8zSXqeppwynKVFM+vOJAOxzP
	F3bKrylqI/bLhy5rc95f6yieMUnGfD8z1xD08t7vgTG07qqJjrNtgmTrtFzAbLC0tm8=
X-Gm-Gg: ASbGnctdiCLlzTD+Z6yVNCGvRIklNHc0LB08jyOuoXWRLH+7x+rrOL4i0vz6uWI4Fv9
	MZ9tVLqQitbMmPBpu7LIbzjbyo9qhh4MM4OYU2+TPBf6Te0KzND3Go8poSSnWMN4Gbn7wrwaerR
	Gq2KtAWP3x8Ah2vEcnK0UZC+kMkLHqp38jnVK32/irRkoKkucD7UKeQyEtzJzKs32by7u/31FH9
	+WcZAwhIitjdrrj26DggOyXe7DKhyKFVjYLzdVrZNcsU9JDTUiEtyDePKLTYYJTL+tG7zZupvaM
	X/xuN+6z90ls/juxZbCqANuVrlhqwgwrCAZgVCf2MikGfG7m8Jm9o8TZnak0JRESq9G0eLmyfsa
	TO4HLQQe6nHoIDKMOgjCRPRGy
X-Google-Smtp-Source: AGHT+IGqIkf2DXnXvaT7WN6+oWH9g364u3Q796J4JQ4J5bg8nShXhozWUpVTuQp+yHgae7i76C6gaA==
X-Received: by 2002:a05:6830:90e:b0:73e:9fea:f2a5 with SMTP id 46e09a7af769-7437498681emr198546a34.4.1755017650501;
        Tue, 12 Aug 2025 09:54:10 -0700 (PDT)
Received: from s-machine2.. ([2806:2f0:5501:d07c:56f9:3b9d:73c4:bab2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7436f96e0eesm318507a34.33.2025.08.12.09.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 09:54:10 -0700 (PDT)
From: Sergio Perez Gonzalez <sperezglz@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: Sergio Perez Gonzalez <sperezglz@gmail.com>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: remove branch to identical code ext4_init_new_dir()
Date: Tue, 12 Aug 2025 10:53:28 -0600
Message-ID: <20250812165331.8449-1-sperezglz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems unnecessary to use a branch, in the event of
error, to the same target label that would execute on
success.

Signed-off-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
---
 fs/ext4/namei.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index d83f91b62317..01f379f5fd04 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2984,8 +2984,6 @@ int ext4_init_new_dir(handle_t *handle, struct inode *dir,
 		return PTR_ERR(dir_block);
 	de = (struct ext4_dir_entry_2 *)dir_block->b_data;
 	err = ext4_init_dirblock(handle, inode, dir_block, dir->i_ino, NULL, 0);
-	if (err)
-		goto out;
 out:
 	brelse(dir_block);
 	return err;
-- 
2.43.0


