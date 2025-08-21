Return-Path: <linux-ext4+bounces-9551-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA759B30710
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 22:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95FA623CAE
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 20:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B533932B4;
	Thu, 21 Aug 2025 20:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="o3N0+ha3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33603932CC
	for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 20:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807695; cv=none; b=gRxkASk0XBEKW73cGykd481wHt+/0eh8vrsNPlbzs4slDoZhSFGW/g0VUT/UWJr3aoBPRefrZSsVgGBePQYmNPT87IpivRFaylwjOh1Luei05JtxN0Sr8AWOCj2l3sdnRa/n48BrIf0wVA9DQK12VGyatgI5521gg8kE1dtA0Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807695; c=relaxed/simple;
	bh=9eIXs22x+6CL7qvaQyYl91mn2xaK0DYu7NpRW3TBpJI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CingAfTvLIqhbyQtN6lHr+QEjbhz/EZ1ybxH1O2KKUBS+nEYeeAnsAbpFAGR164jrcN10Sq3TwtP7dtAfo/YCoCyklvQyKwoP/Y2l+o0loOGgyB1hKUyxh8UA1GV2IKrGCcuFlcI+INp65qqth0iaMQukhBXTcKBo+qyC3/yy/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=o3N0+ha3; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71d605c6501so13444037b3.3
        for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 13:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807693; x=1756412493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dz+9ZPRtHF20/Ye4ntcMEWPyYkBueHiqaZncIf/k5Cw=;
        b=o3N0+ha3+/uMD1MiRPxB6eePMtVkG73ouNrfxIn1vXl/Oqxr1VOIZbAdrU9uitWTML
         tkbHLfGfBz1FTPe5c1E9P4IfJW3F0KscoDgtl6gVQYHjTwiotaFkZ5K2cspHWwTeAFgK
         yycE7BClVG9Adrz29Wg3Y5uvFIy4i0c9JogHpVbyUgovwWSIKuGa6lSLgSoxTCkCmAkQ
         q4BDI76Kpxm22a0GNqWm0iWbePEb0VD8/R3AOUGIwqEGSgZ9LEOTQqSw/CtYLsraKjCa
         MaSTPddndEOD6/Bn5LpHeXQYb3uf/kyoNxmYlMlfrIw6x7MAaGi0JYULLQUqbOJibLPN
         mLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807693; x=1756412493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dz+9ZPRtHF20/Ye4ntcMEWPyYkBueHiqaZncIf/k5Cw=;
        b=o43SKNeEpV95BnYX4ktqThtAbE0RyABSHJ8kxzu9yoyJoSBTRRA6K+A3Yxn8SP2SuT
         V7lGko1yQjMH81MF5n9A3QCqP3iTSRdmNlcd9jIb7hIZ8/La3DdZUCy7RNFt6iX2Cdi+
         w3sG1ek5YYezfUaIcWlr83ZfC6OIeX39khXhAhVZr3hfZi9Qa8P9veVhJxXjFMUatONm
         U6hWe0dlNgzNO1nNvDGppylOvl0Z7juwOLExuT53FCDiNed4rE5qkTAOIy0EQgO4lhY+
         yvHbUKO21HBAe97OSafO/gS8Q1jkvDCupmN1qLZCWUUjS8AqdskAWuCd61ued790a9Gn
         7+Nw==
X-Forwarded-Encrypted: i=1; AJvYcCV8kSA/bxEI1pJ4vG838de+JMJ62mGryaukFWB5p51CxeDG/L2v501UJBKLPxM3K4Zm2uMlPCy3Q4Cj@vger.kernel.org
X-Gm-Message-State: AOJu0YxQDXpKaa8YBLVRI7dGSqJ62cAb8HVDFAM+e8q/rQKvXTW4sgay
	VkvyXqznh5//kLB/FhI5slvqldgvJ43Ei1ieUtOJbAQrjbEfGgvkvxd2Gc15SrEjki4=
X-Gm-Gg: ASbGncuNP45d426OZaBdSBOqmxHcatgBbdIDatheGHbo7OHc2cMLSh7xZR0B9QKNo5q
	C1I57P4dOCaPEBQFx7H80rmgI7wY3NSXT1X4WVX7qWCAPeaBtIeI4Hy0DQoanZF/+l9lHiX2NqP
	+1RE06eaXz27ntHIGJZPQibU27VeApcln4VmXHZMyAP/ObDqb/N3uq+390vN4W4Y6E5R47zldKJ
	Qodovz5U+H7i6VICsyJEp3bGBU1Ucc46dE1knMKpUpM0K3ONdO3dKo5Za11P8rJIYGKhllcXGgN
	R3YEFjKy+TunzONWVlAW/+XjUbJlU8jsO6FXcVvkfImvAJpqwGHQF7gOK6FjQVeyX9hytwNBhLC
	jgjpTWhmeZnd4+O5J9+wrMqUmGR1/LURjYso6Jx04EQe7WNyIuabp+Sx9B0x6KjIRYiZOlw==
X-Google-Smtp-Source: AGHT+IH3d4NO39oYjHUAQEiHon1LYMDlbEVVPoRdh8HJgQEduyc/E9u2KwocBbAXQxqvyeIIecSuHQ==
X-Received: by 2002:a05:690c:e21:b0:71e:7053:262 with SMTP id 00721157ae682-71fdc530cabmr5849657b3.26.1755807692625;
        Thu, 21 Aug 2025 13:21:32 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71fb0252d27sm16706807b3.12.2025.08.21.13.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:31 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 50/50] fs: add documentation explaining the reference count rules for inodes
Date: Thu, 21 Aug 2025 16:19:01 -0400
Message-ID: <e0bdfc839c71c8e7264e570125cc4573d9613df4.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we've made these changes to the inode, document the reference
count rules in the vfs documentation.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 Documentation/filesystems/vfs.rst | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 229eb90c96f2..5bfe7863a5de 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -457,6 +457,29 @@ The Inode Object
 
 An inode object represents an object within the filesystem.
 
+Reference counting rules
+------------------------
+
+The inode is reference counted in two distinct ways, an i_obj_count refcount and
+an i_count refcount. These control two different lifetimes of the inode. The
+i_obj_count is the simplest, think of it as a reference count on the object
+itself. When the i_obj_count reaches zero, the inode is freed.  Inode freeing
+happens in the RCU context, so the inode is not freed immediately, but rather
+after a grace period.
+
+The i_count reference is the indicator that the inode is "alive". That is to
+say, it is available for use by all the ways that a user can access the inode.
+Once this count reaches zero, we begin the process of evicting the inode. This
+is where the final truncate of an unlinked inode will normally occur.  Once
+i_count has reached 0, only the final iput() is allowed to do things like
+writeback, truncate, etc. All users that want to do these style of operation
+must use igrab() or, in very rare and specific circumstances, use
+inode_tryget().
+
+Every access to an inode must include one of these two references. Generally
+i_obj_count is reserved for internal VFS references, the s_inode_list for
+example. All file systems should use igrab()/lookup() to get a live reference on
+the inode, with very few exceptions.
 
 struct inode_operations
 -----------------------
-- 
2.49.0


