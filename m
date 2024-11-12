Return-Path: <linux-ext4+bounces-5108-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B62C9C5FC4
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 19:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76591F257B0
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 18:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283C421A6E5;
	Tue, 12 Nov 2024 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="j18VGQM3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5070C21A4B6
	for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731434217; cv=none; b=ecHlorMlRAgcv6NTf3M4GJ03CJIZuMxlIu9XC88SyvbMODeNdqmLjcXBU+wmrITY3PvXS3nA4I3tb08t25khgbTVaI262h2WSIpYM5pXB6Cjic/CLYuX8h6lgK3SzXdz6Y8mWCnDGc4mISQKUiJTsTRypEVeRiRNLjv5va40dsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731434217; c=relaxed/simple;
	bh=6I0DlDU7r6h299w7wCYMACFg3R+68ox0OBCaPPO6OWw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wag4PhlXMdD0y8CC4OfFEH9pLH5xAnFx+yq/P2zQQGSwyPov2zcyHE/1immqOtpZaf3LBXimbLRM9ZNBeSKjWxiFaHOQ3olpOfqt889eOahya0t2a+gqBV4VnL1aJ6yvMXSG6TaOmb7LWpoSxkWin58p7YH/lK4RL+pUyQaOwQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=j18VGQM3; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ea85f7f445so59639187b3.0
        for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 09:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731434215; x=1732039015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SVlCssk7TvFYg+mPz0+epJww2XrJywW98H8fNg6oZ9s=;
        b=j18VGQM3VALd1FPSDSra8F/bETEhAgljXkXreIriBZwHMoZHqvsHqXh+DL/yfnASy2
         tazeYr4+Rt+6PDTeAQgPJDHSlyiWYiHAM3WTgDP07GCIRCeUr8sONmYt+apS1ZPZ0oGi
         3IKMK/QA8W32klu0VROVgGnI7jxko1c9dDY4fAGU+7TyiJQ8BNDJfcUGl4/WWqHSiM6b
         IDmrMZSC9vJ/1ye5B4f6RwoRUh4x8p1QqDxZIzOHuGFqmVytD4Qd7HqDG3aqbH5JQ/y1
         ag1CGDx1Ax2gxVHAYVR9iasn4GUpjuHUIH+FzApo9ydNwMmqNUYo6jyxKd5iZVisBRMz
         lXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731434215; x=1732039015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVlCssk7TvFYg+mPz0+epJww2XrJywW98H8fNg6oZ9s=;
        b=UjsNhL7SGTft84DyVp62VuTQdjgUGy/0Cb0P1Jy0bMlhkNvzKS1A31fZk7n97C5ymg
         RAV1KNY8Ut4FqsCtwG1NQZfez4rm2VpM28OmuYOecfYKn4aIt0KBMoBTKAPvozMeZvcW
         nGA4funpvWhGq6C7o6WL8PpvqTMWhxMgX2xclM1kHSAoo0WoPWRoYpp7+aGWnIbehPfy
         rhxow/740SgXyQL3djp9CFBCHtj38tU4PiZswTemex41aJPR4UqqvtJ99ZFl/xrJVLiy
         vc58hhxKoUQMVKVyWQytxEAuT5nwjdS9lm2pO9FVEyhCyJhtxDs34pd14nXmzBc72NqF
         bdWw==
X-Forwarded-Encrypted: i=1; AJvYcCWJ0w/xI6DvKm3ZZgexEusf6fYgWnj7q/BInNmBF25vJBUXXb8P7ccgENRjczjptNreaEC0AiKRmA5V@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3big8dP3bq6TMs3DKuUzUoOERZQBZxrICK/6Sl/gMVd/SoqHv
	tbsQQxE2CgX4EMrnrjeq3PateUnint142eKUVBtxwTJXLYCzW6uBECMgY3yVzvU=
X-Google-Smtp-Source: AGHT+IHRWQQqMmmNmJOTp/8rWDSoFWHv3EcV7+6jsx99WLy4Go67YPaRFk01hHzbJnpPfWcpjoX+9Q==
X-Received: by 2002:a05:690c:7448:b0:6dd:e837:3596 with SMTP id 00721157ae682-6eaddd9703amr170632707b3.14.1731434215357;
        Tue, 12 Nov 2024 09:56:55 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eace8f0c5dsm26584767b3.41.2024.11.12.09.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:56:54 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v7 17/18] btrfs: disable defrag on pre-content watched files
Date: Tue, 12 Nov 2024 12:55:32 -0500
Message-ID: <6d9ff819edb6df5583844c26169dc6ddd471316d.1731433903.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731433903.git.josef@toxicpanda.com>
References: <cover.1731433903.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We queue up inodes to be defrag'ed asynchronously, which means we do not
have their original file for readahead.  This means that the code to
skip readahead on pre-content watched files will not run, and we could
potentially read in empty pages.

Handle this corner case by disabling defrag on files that are currently
being watched for pre-content events.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index c9302d193187..1e5913f276be 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2635,6 +2635,15 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 			goto out;
 		}
 
+		/*
+		 * Don't allow defrag on pre-content watched files, as it could
+		 * populate the page cache with 0's via readahead.
+		 */
+		if (fsnotify_file_has_pre_content_watches(file)) {
+			ret = -EINVAL;
+			goto out;
+		}
+
 		if (argp) {
 			if (copy_from_user(&range, argp, sizeof(range))) {
 				ret = -EFAULT;
-- 
2.43.0


