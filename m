Return-Path: <linux-ext4+bounces-10503-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4862CBACAD9
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Sep 2025 13:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D193BDA1D
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Sep 2025 11:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C532F6182;
	Tue, 30 Sep 2025 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0oI2xL0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030472F4A1D
	for <linux-ext4@vger.kernel.org>; Tue, 30 Sep 2025 11:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759231589; cv=none; b=O/XVnXX1IFsgvhmQNT1aN8iellrGSNOY5PcoLYpNF/LktQH6y8xn3FOAAY0p3UpueO7so1M1HlYdu+cD9ycAoJtBsLrq35I0CHxuKqoIr3jIz/EfSox19LIIbaU1uA4bs0zd9VgJS4Jdbu3snfRZKU2Nw+Fs8BRTP0egPV70r9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759231589; c=relaxed/simple;
	bh=88UnKCpF6MxQ1cu6WVwEGFyyE1Je9LgE7sckZgm0yd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z1Fb/Qed1isUnlvBtMdBJcWw1kHsqQZBFlMZevTM3Py8gB9Lu3phjafI6wpKa0CQmB7oQsSinWnWmOWt0vAGDLNOnR9s36PVDyXEzrGkgiD0kv1jIpWFnehlYe5gZsCqzDnyOjvBSFp2cchLUO1zbP0IMjy8BpUVV5r2g8vijrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0oI2xL0; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3381f041d7fso2831677a91.0
        for <linux-ext4@vger.kernel.org>; Tue, 30 Sep 2025 04:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759231587; x=1759836387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P9IwW8fBNe/WatIswEV5cRIvCyIrYoaIZmzkXfi+U+M=;
        b=F0oI2xL0HkN0oFd8A+AdajM+KDCrDoWFmU35Ns7KLLcRuMOwIdjYVnoSMVGWoZmrkU
         jrLyvDVpKNzbwkGSeSDKd7wOWpRxwzY5srk3ItsejvCO3zVZrza0W5+ZE59/9REkNVj9
         E96Bg319LqDmTekbhWGAk89hW76CXE2t6XANQak44khT/XbFhLjmAeCsuw0kZFYwLC3y
         lFuieXQHKR8JnElKIbo+KBLFkqOecm2olETwcAbSNkmwWTDhICHwR8T35ZXqJY5xb6jx
         sHzRDgrRHqCduwhJ4azet2WgVA8iohO4cBtCQAAWxwmVFKIL8gDZZcQ495DccpH6JSBa
         fJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759231587; x=1759836387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9IwW8fBNe/WatIswEV5cRIvCyIrYoaIZmzkXfi+U+M=;
        b=o+Oo8Ii134djbNuFul/uZotP3K7eMYemBfWrwge9HIN+Uob96YxsNNuqL/MWeOev8W
         AYfueqkc7tEJ1GZ1Jy/bIASwpi6v9iCYFEJe6wUbxNkXhUk5YVrygdB9xQceRFV9LJxX
         zQJ7dkqpDgvlMxpnQUcrC/zPAex3dP27znfkNJ3fLkgzyDydM4fekHZ50Oc5sEe1uQGV
         egfUDwapSUuNmwfcCvPdIRmJ5Aa1vxviyeqTO56yKa6+4+zA9lG95DWxDfknheGAMCX3
         Au0Dj9Ih3sq019lxZXpsYhLvwiDyUjqh2v0G2qJ9vGGnCjr2LA+K+GMaON46QrIYZFU1
         24Fg==
X-Gm-Message-State: AOJu0Yxij8v8o0Q/VhPxUyRqv5pqCxgmJAYLxDZ6LGHd9AVrGWJfL6K7
	z/HcBBzZeSQg0n1DN1GzIHkoZytEdiMFADjlZm6HXMGDfZEjk+iggL5c
X-Gm-Gg: ASbGncu6c5Ie507G3ikhi0sbsjNmm5zzw1gC7EVRRU2kASVMNfe/f6fAt6byePmeosS
	gGcYlQEARZ0mCTZVxdO9+CzU2X1rrNxXE7aFh+UNGGkEgn4LPK3RHbVLvOeejmYAZdv+EFHKXs4
	C5XU5hglmHl5Ii50qZ22vm+0N7HGTZDbZkIaifV3uXk6y6lcovGJePr9GdXRJ3D7+32c/M+B24t
	hh06hSkcG0N0Fk7HatsJkO9oW01iIJT70VVrQw6mpZVnsLBdd5b2NDaG7v5nyG14R4VxukahUDe
	BNyO3OkrM/jX9aCYLbReLVSM2/0WcITIAlMCMNBFhZvpCvkJuWnKhU8biNPoMMqJ38A+c4GZGLJ
	2Ar497XvGOiiIhaG0PpBYpWhkTqQC9dl/aWjG9Cazb3gq9y0d/LP00tpcSATxfPEc+yMIdoa5Nu
	iu/q1ao8AwTPcIIWM0GkBZbVdNHD8=
X-Google-Smtp-Source: AGHT+IEejJp7M8pvyHkDoEM8HxGwNSyE1S0ljFnpN2sGTpbOtXw3LhX7D7Pd5NxiL/nh4tbvz5Y2kQ==
X-Received: by 2002:a17:90b:1e02:b0:330:c522:6138 with SMTP id 98e67ed59e1d1-3383ab5884bmr4652896a91.8.1759231586947;
        Tue, 30 Sep 2025 04:26:26 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:91c7:6bc1:acf5:6b87])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c52eee5fsm13801582a12.0.2025.09.30.04.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 04:26:26 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	yi.zhang@huaweicloud.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ext4: detect invalid INLINE_DATA + EXTENTS flag combination
Date: Tue, 30 Sep 2025 16:56:20 +0530
Message-ID: <20250930112620.315028-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Zhang Yi,

Thank you for the clarification about checking flags directly versus 
ext4_has_inline_data() return value. You're absolutely right - since 
I'm checking the flags themselves which don't change after being set 
from disk, the check can and should be placed right after 
ext4_set_inode_flags().

I've sent v4 with the check moved to the earlier location as you 
suggested. This placement is indeed more logical - detecting invalid 
flag combinations immediately after reading them from disk.

The patch has been tested by syzbot and confirms it fixes the issue.

Thank you for your patience and thorough review that helped identify 
the proper fix for this issue.

Best regards,
Deepanshu

