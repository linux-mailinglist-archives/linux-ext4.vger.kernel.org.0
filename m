Return-Path: <linux-ext4+bounces-9544-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7CDB306F8
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 22:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB79640EEE
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 20:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578573921B9;
	Thu, 21 Aug 2025 20:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ZVqFEs+e"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917AB392191
	for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807684; cv=none; b=f6d6+e+gtKQcRiyFRWMPR9Kb5EiwXxR7RIvC1EaGi3exa0mRaopm4CuBBLEF23g7o2DaZptYBQKzEPRhbC/16kzfoeQp+OPtSwUBvCKaH7U9yQftDU8FQvvu6tIhUM0Yv08AfAoB2n6EmQxEOatV79qLpcUH4zNrfE0aRoNqeE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807684; c=relaxed/simple;
	bh=dcsAxEHT5Jq2nRSpkM5+vx6RORRZ4KO+wi+OUDbhG0Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epWfTDXXq7PVuQu9U9m3ICs1cOcr2Pq0GLb2chhQAPPOhpJxA8xh6QG725JK59PoFL9XCoYNbSEygZ8RD2VRC7F+3w/rxd75AzN7krdDNMgPdZoIZAYWt8Qx7I6tMYLf0/cB86O9kbczmx4+hOlW+ahVFS2HKDRHgBFgD/sEPyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ZVqFEs+e; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71d6014810fso13121637b3.0
        for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 13:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807682; x=1756412482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AHd+4Vz7kPVwWP6qqpZo346lGeZ1ejCBP7K3x1LyEEE=;
        b=ZVqFEs+eobZcPj9ARVsRpslWn72Iw+ZUXKuvZju7FsVgDhzqU643uieOltl1O7cZ9C
         cq/+LQdBm/DnBUrUP42/QluTdzuCU6dgi/hlb7CFVHm8iBwcxVjikomxM/nmYpxwqQdD
         IOoKGaaBI+FnQ3yC3kJfMSPe7Hhu1kvwMXBuc2x12IiOi5Hv0ofo2RczRxI4W+JV2XJB
         I4qy8tzZXP1Pg5FLOBtGRTRA9ZVSDETwAspfSy4LW1R9P8S/k3PBLvLRGrOixfTIrLaE
         AjPc4K8gUu3srJXLTrWtFIcs2bCwNFHiAgM6Kg0wpI7EBu9pfxiHLFHCm/bSfXG7k12B
         TCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807682; x=1756412482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHd+4Vz7kPVwWP6qqpZo346lGeZ1ejCBP7K3x1LyEEE=;
        b=u3HHw0hJmURdZ871eOk5u9DStgIwUZPRs+HmUGzqa/GdCFS9025eOHzQmyWYE7xM0Z
         VigHg0X2qIYYv6YgEXOgrv/eR4rTJ9g4p7qoG2LeQ7ezoDRwKsDUeRhHM45+YKQvchcw
         PLLHG95JJuRs26mTKcelhslApvttl9lcZHhBtrkkjklGFOUnJs/nFwGh/CR2QvtzLiEo
         GYovRU6vw9NXPLJeTjKMMd6ooB2ao3YpG2HatV9wAXtgCkt8KbU4UDLfr3bZd980gwmS
         gJz/RxCD0X6FdtOrrmIu1I23BHrescj1XOaL4+KsjgMYo641eCqfzKPtvZxCe5RyQr9g
         HEJA==
X-Forwarded-Encrypted: i=1; AJvYcCWs2cK2Hj2wVyaVZvEE5xYUr6ajivrUK5gANgyX/g/PgOvSU3w+PQNILcuTkUjvWdK0nLoFOWNRdmwh@vger.kernel.org
X-Gm-Message-State: AOJu0Yx54HYU7IOM6DRywqx01AE5QMjMVR9tO4zBdOpITtQQHWUu/bOj
	6lCIM8eMwrLrZK/FZYjuidso79W1OXI4chTR1EI5569e0X/WfOR2lBL2a5C0X3sprEYHcciQUE7
	6ZDL0EVYImg==
X-Gm-Gg: ASbGnctgVen4YKelnd4plBLDEy20phzaSneCShxfUOztE5DVrUf0tVijuIe84NmpG6T
	DWUOi57GWMNWASaT/lwkm2Ss7uxKH9O8YiuBkAgsemJwWo6GQXvEJ0iLykkyflQLOHfuhLssq10
	QtYiayj7b33WdN64SJbrDFL9FRIlWyREeJGsAG3k1s4UpXa1+6rN9NKvET4Dz03tmJTjG3guj0+
	ZeFXa/Ho2t5s6YpeDvRSGRdDEyNWobufwYtxv23B4fNohxdOjejKXjJJz7yEhDPZp35uMwaVIsi
	6kgjseFbH5yEhJlUWOkWjaMBIYGenlt7QMykbMDN3dgLxU8e4ixdXzjpKk4NvgkWGK4vK7XTlDZ
	P8jTKFatYflMbg3jL5h7B5TI3L4hmH5K0zoHNblv6bYk9BNwdfevePbs0cazyYf8oYsGnvg==
X-Google-Smtp-Source: AGHT+IEzo0QXY9VIuY4baShzyB2YhjsCyUBZU5mUEwfUAhGbJD1bAOOlVU8KN48xmuT/FokHR6oSiw==
X-Received: by 2002:a05:690c:9a11:b0:71a:a9c:30de with SMTP id 00721157ae682-71fdc418f92mr7089417b3.41.1755807681418;
        Thu, 21 Aug 2025 13:21:21 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71f96ec62cfsm24521717b3.22.2025.08.21.13.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:20 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 43/50] ext4: remove reference to I_FREEING in inode.c
Date: Thu, 21 Aug 2025 16:18:54 -0400
Message-ID: <ed4673380176f640f0d33201387999207dc1426a.1755806649.git.josef@toxicpanda.com>
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

Instead of checking I_FREEING, simply check the i_count reference to see
if this inode is going away.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/ext4/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 7674c1f614b1..3950e19cf862 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -199,8 +199,8 @@ void ext4_evict_inode(struct inode *inode)
 	 * For inodes with journalled data, transaction commit could have
 	 * dirtied the inode. And for inodes with dioread_nolock, unwritten
 	 * extents converting worker could merge extents and also have dirtied
-	 * the inode. Flush worker is ignoring it because of I_FREEING flag but
-	 * we still need to remove the inode from the writeback lists.
+	 * the inode. Flush worker is ignoring it because the of the 0 i_count
+	 * but we still need to remove the inode from the writeback lists.
 	 */
 	if (!list_empty_careful(&inode->i_io_list))
 		inode_io_list_del(inode);
@@ -4581,7 +4581,7 @@ int ext4_truncate(struct inode *inode)
 	 * or it's a completely new inode. In those cases we might not
 	 * have i_rwsem locked because it's not necessary.
 	 */
-	if (!(inode->i_state & (I_NEW|I_FREEING)))
+	if (!(inode->i_state & I_NEW) && refcount_read(&inode->i_count) > 0)
 		WARN_ON(!inode_is_locked(inode));
 	trace_ext4_truncate_enter(inode);
 
-- 
2.49.0


