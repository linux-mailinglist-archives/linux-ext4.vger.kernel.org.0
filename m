Return-Path: <linux-ext4+bounces-10407-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51765B9D170
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Sep 2025 04:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0A81BC4C35
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Sep 2025 02:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10992E0927;
	Thu, 25 Sep 2025 02:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7Sbh+js"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322552DF718
	for <linux-ext4@vger.kernel.org>; Thu, 25 Sep 2025 02:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758765989; cv=none; b=T7HHBD+GXvdwbsTlbORc81qH+JhHYdtAMJKbJ4AVplGu4NsWcxxzXoTmU+Zxw9AKch1qlGe+OLirj95qO/KXl2I4SFUy4Bho3k6i7ghcJ3BYaOO/GkdqJXSnK16LFq+uqYGkeToyM4oGePXs0hWn2drZz3Q1ftHR7UpVtioqF68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758765989; c=relaxed/simple;
	bh=emM7Hbp4+t3hKY7RQRIqu3zLRsfIXIe2RIjkPWAHEoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C+DFIL7liwh3qbx3ch9e7bdwvSVtHiVlEwIg4OJU4WbOpqcYuRM76Apf0y76/d40qMZGwPJIIQKTQwTg8O0F7y62ADTlHFDrN5qtjPCBhs+v4BR/DHYsQj8YNf17hunZfhYgX8YN9uzlWRbsBS+xz0d/o297B8A/yd+Oww00zFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7Sbh+js; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77716518125so254487b3a.3
        for <linux-ext4@vger.kernel.org>; Wed, 24 Sep 2025 19:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758765987; x=1759370787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tU/TSL5LhuP/twx2wBHqp/4wp73W2M92Uj8iJaHRWWk=;
        b=R7Sbh+js3985Cv86XKX7c+hizRoRaZAEzHy6GBICDRCNZv4uMUNHxuBUWHzoGifbh5
         xi4QrAkQbXF/V534XDLVEnxZC/bg861LJkqaXEiaGkYa1NGUGXC0XBmqvajI7ne7nfV5
         eUeBYTektSS8tj1OQ/3HVJFERuurHDrXiwhW4ojsWCyya4y1k/lerQ2Yj+/W3DWxHTN3
         kvP0fbGrHUKEGDsDkdeuGDcpzYoKhSRAy/NFc5CpeTrRTN95YDgJ+h4S0hIaerdOCZEb
         EHaRbEu2evJmI5gWLODiE+g9jkX9n6k3mEAHz+R3mG3ziB32BWZFLIvRpwMEPoIwc8QQ
         gO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758765987; x=1759370787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tU/TSL5LhuP/twx2wBHqp/4wp73W2M92Uj8iJaHRWWk=;
        b=XT0yLaMeFnqV2QJQyT5G/plflbLxiE4Q/2Z1wDyzDK3fGAsMaBPVhPt1Iyu8uoiodW
         ReIvWpsIOwfmC6UzSW2/UoTnyC+lD1csEi8oArQ7vyaV9zAWIfhDl4SOa4rXfkGfUBwR
         S2Pvu6at39MeBC6ILtlLqrYfDMnSSye6JKbPRE/KaR5JgYXCfujTgE6wUXjX8KO0aEiw
         XvnvcuLck4L+lczAojpcoXdazZ+GcaQgBLx083BBG8TOBNBTYXgSAm8Jt0zeqDL+cMO8
         doxJ4G54lZ8iaCVjC1VNjeL624xtUX6GBb0gJp0LhYUgjFlNy01Zy+/1DArcLEHUl6sN
         B5Og==
X-Gm-Message-State: AOJu0YxkYGSHlE7IOD0qwrVt1hiIhl34MSSAIKGzp9JFGiCcl2nVB+G3
	sk6ejosAJIsWII7F6KOtyBK0KYTqQQmgq/sAZzXLDHBzCiRnYtaqRQq3
X-Gm-Gg: ASbGncv0NctVl37b6IasPxgrPvtYFEYkhhn7nPMpheDuszFSloUEc9N/QKzIWW0UQDz
	kRT0st5PyFxTrSunD7G6Iro3LWOoRz5Kvak5wVAKKSHXkX794JiixDX0LxPXdZL+GZuZd00Gq74
	/EdKOLfwuz2Y6Mgfi28V9wQ4EQyhHT/KrSFH82k36vnFmd+n8t5L5/lcxywKicXKkrLTCV/Ufc+
	PjD0mf0VddOSTwlYmTaGbjlxJUCaI2Qmfa4h3871Rhh4I5wD/nmiPx8WvbXT0vrbhi3wSBkipzJ
	Q/p9NduobMM+eK2qJ88jwrifmy1d7k8foMhO7tIk/BugBZlpok8aLrSgfWv6aAdwCNoV0/lD9FC
	BsjY7QmuRqD5E2RWgIRMzB8sT5OKvvFOl2STT5nA2dc1II5zl09XzEwWCi0EEgVY+BaBCVgqXgX
	H5mng=
X-Google-Smtp-Source: AGHT+IEGkxaZs777ffJyo9MgmjDEDAVLnqbymp9F87MoJbNqiIXjx0kxb58hxWECgzHw3b5fO4opNw==
X-Received: by 2002:a05:6a00:4654:b0:770:54e6:6c36 with SMTP id d2e1a72fcca58-780fcdc9112mr1994132b3a.7.1758765987402;
        Wed, 24 Sep 2025 19:06:27 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:87f5:62dc:5f13:5ae3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c27733sm394133b3a.95.2025.09.24.19.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:06:26 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: adilger.kernel@dilger.ca,
	tytso@mit.edu
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix allocation failure in ext4_mb_load_buddy_gfp
Date: Thu, 25 Sep 2025 07:36:21 +0530
Message-ID: <20250925020621.1268714-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hi Andreas,

Thank you for pointing out the fundamental issue with my approach. You're right that removing __GFP_NOFAIL creates a worse problem by potentially triggering filesystem errors.

I understand your suggestion about allowing the function to return errors so the caller can retry, but I need more specific guidance on the implementation approach.

Questions:

1. **Function signature change**: Should ext4_discard_preallocations() be changed from void to int to return error codes? This would require updating all 13+ callers I found.

2. **Caller modifications**: How should the various callers (ext4_truncate, ext4_clear_inode, ext4_release_file, etc.) handle allocation failures during memory pressure? Should they:
   - Retry the operation later?
   - Skip preallocation cleanup temporarily?
   - Handle it differently based on the calling context?

3. **Memory pressure detection**: Is checking (current->flags & PF_MEMALLOC) the right approach to detect when we're in memory reclaim context?

4. **Scope of changes**: Would you prefer:
   - A minimal fix that just handles the allocation failure gracefully?
   - A more comprehensive rework of the error handling throughout the preallocation discard path?

I want to make sure I understand the preferred approach before submitting v2, especially since this affects multiple call sites throughout the ext4 codebase.

Best regards,
Deepanshu

