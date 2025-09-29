Return-Path: <linux-ext4+bounces-10474-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E763BA7FD5
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Sep 2025 07:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E493AEC87
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Sep 2025 05:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4348E283130;
	Mon, 29 Sep 2025 05:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKS6uQUh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888732629D
	for <linux-ext4@vger.kernel.org>; Mon, 29 Sep 2025 05:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759123645; cv=none; b=fho+wXPy8juEC8gpMtNuW+tfRGdlA2gDrwCCYLwq+6A5jUoVPJFZaIbNRoz4TlAnB8L+sio/UvL2S25BS5z19ZRUg344QKjCGtYszCSbfrcpVJq9Yx5rYG5XBGJe2MkWxgtZKXPzu+E1+7wkfSpXfZQ9fMiPpELH08UMBNXKTVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759123645; c=relaxed/simple;
	bh=0NiOHakfTmoFWZh8rfV5EHJ+Dc5FlUDe4sVlxp/w39o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MlHt6hBQoPRtmJhFcAMTYloBDUgypj2spu+eo2hOyZmo8T+hqzLG621OFGxW/pUysba0YSNxsnXD2+3MmFrxWIZ4bNZq5AatHRN4Vjx3ODBEu+XWdDGLI9moqUSHlMr0XGJJcwTR8ZPGV/1/CD8rI7lWQm8uI+ASAwQ0s0ZseVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKS6uQUh; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27eed7bdfeeso36531995ad.0
        for <linux-ext4@vger.kernel.org>; Sun, 28 Sep 2025 22:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759123644; x=1759728444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cBoNC3hiqOU4l/l1DzdLcpvA7kcnMf+nX8xh76MMsns=;
        b=bKS6uQUhU/2FbUXOxy27meYOBu4hqsgcznRStH6jdJdKVAPkP8x0kfUfhsPC2nF5wE
         JP7cjaDYivOX5Jbho8bgFjAAiYkQsKAx2INn692LCkjMzgQMoXSgiWr5g+lgGv4/VZtR
         UHWhMFpMZl26Lg9a7weVxrdTzvtklLFPNLWaphdTQwMMm98l3E26c3YRfJ6EEjYAWREF
         ZXyhAfV56CQmer71XjpfO9TWCnibf7nqnGrIKh8+yIHmQgJJWX8vUm4rLIykK7XtPPPH
         CRocSiTFTeGN6Ov1nXD+qNL7Xhvdi4YOVcs9JAO9EE75/ka33qaQ1T6Ivddkk4W8HgLj
         ogKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759123644; x=1759728444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cBoNC3hiqOU4l/l1DzdLcpvA7kcnMf+nX8xh76MMsns=;
        b=ATDGPbPoiVp2NvhM2a5pOtJAnv7t9Gr6EAA5GrbfP+spRgSjc7JWfYZY7KoxMonAfA
         GisxwX6Jt/G/aTvnveJtgYdZoXKyZ+FRNF9fBdxapjkFd2/ifvN+98sT/vv4ah/FwECa
         g9jwgVfYcSUVF5UJL82c075Tr+698X7zJwsdTzuVjCNau/wkEUyWx3ZN2k3x8l2WFSzo
         aP9XMpi9RyP3nte3i9xsRkvgyM9ymOVmai4VozZKXSq2WV/1locjUQuCSSCl23W5SrQc
         O4QWdar8ithJMOKGSAWZdXiQje+Fj2/N6rBRzfwjh4+FSk3C7FSsCzu1P+gGPcCdM5/B
         BdBA==
X-Forwarded-Encrypted: i=1; AJvYcCU3VXLHb47B0ucx4ZFYlLTE/qcsqq2GdIFZphyvL1OaZYr3IQTqa1lra1budiEuJxi/XMhPbFXtvdqw@vger.kernel.org
X-Gm-Message-State: AOJu0YxWMU9I35Oe1D2W5lenqw6bi1GQar6j2hpZo/KLCvX5nq4fX0XM
	//0IeyN4YZTrWuxeHYq+zNcOIEgVaKNvOPgY3ocJ1doeAZ+iUfng76f9
X-Gm-Gg: ASbGncsCsVeO5rzsyNO1zvB0I6rkhw4yd6OtZ+uGkThHq3Vhi8AUUr7MwrHro3j59HP
	dP7ZFjCZjF7c0S8DcBQwI7wB0DrHvZvKejxtkADtnX3CtN6QNLE7jqKSwgFBRdO1IeDBca2HmJF
	5x2ZSGT3OYFFCECUQvIBAU0/IOBPkNhpOCINir3N6thTazmzm2iorwlOLe/ZbrKedrbMae8loWT
	UzvTumg4tYEwZownPNszlDzJsv10sE9GhFAfatLjTiLyMiefhfF/T+WumqCHln9GC7YV4eoDCcd
	cJlDlxvH8dQR6MNEQuQNl7JEViX35tY17ZrzPomvng2fGmbm16x9ySI8pVHft96jHPE9upLTjJL
	j4F8KrQkoQOCHIDqnTXPDORGof1yaR+jQ1CfThp+p4URrKLHBrCbgAzsBgWcFm4IWJhMNICYnCr
	cNQ86o1ksMIev2qQ==
X-Google-Smtp-Source: AGHT+IEx6UKs8efPkW1dX5lUxh0mkL22O8o1vZNeKLKlkfHQM7u0IeFx32nwKXg+SVd891dUgR2uzA==
X-Received: by 2002:a17:902:f60d:b0:267:fa8d:29a6 with SMTP id d9443c01a7336-27ed710a48dmr174142155ad.25.1759123643658;
        Sun, 28 Sep 2025 22:27:23 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:10a6:37a8:772f:4db1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d310csm119207755ad.10.2025.09.28.22.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 22:27:23 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: yi.zhang@huaweicloud.com
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: validate extent entries before caching in ext4_find_extent()
Date: Mon, 29 Sep 2025 10:57:18 +0530
Message-ID: <20250929052718.334986-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Zhang Yi,

You're correct that ext4_ext_check_inode() should catch this. I investigated and found why it doesn't:
[   18.824142] DEBUG: Validating inode 2 (no inline data)
[   18.835777] DEBUG: verity inode 15, inline=0, extents=1
[   18.836793] DEBUG: Skipping validation for inode 15 (has inline data)

The verity inode reports inline=0 when checking the flag directly, but ext4_has_inline_data() returns true at the validation check, causing validation to be skipped.

This corrupted filesystem has a verity file that somehow triggers the inline data check to return true, even though verity files should never have inline data. This allows the corrupted out-of-order extents to bypass validation.

My patch adds validation before caching extents, which catches such corruption regardless of why the inline data check fails. This provides necessary defense against corrupted filesystems at the point where extents are actually used.

