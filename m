Return-Path: <linux-ext4+bounces-1714-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D56881054
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Mar 2024 11:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6BCD1F2280B
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Mar 2024 10:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E698C3A1D3;
	Wed, 20 Mar 2024 10:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFVO4Am6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0777D38DDC;
	Wed, 20 Mar 2024 10:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710932318; cv=none; b=OCgHvFXGDCu+Pz5Y+aL1WVlmJUrimZHgx6rgtDD7e72W3gAF3CPAhjOhabO4DUT9AUc8OX4gAc6myzUczf4uGdXAHn0/0yXLlYHup4O/OJoQp0OSFRqlYUyLroJANj+OYXYEfIu5Lh/qZY45TQcWAEpCfC6bO3vPmayLiySNswU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710932318; c=relaxed/simple;
	bh=NrHb2CFRqof3i/addwK23EWw5EVOFMVDrvVmOmCO+EI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TLGBKPRyrbMGa6zxwhKVpHQzU22YIxinhNYNk8JAjPzVGOY13yfhMOTWsOuo9hPSae7HoxYv1OyJSrnGiLFkx1p/QM6Z0SUb+RCOy4w6hLwrJ8B2L0bDWiUeHgT7ZUBQc6upQq+EOE0oINLcLgPm1vvM/OjriUY6weghChYeNqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFVO4Am6; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a4789684abso3248490eaf.0;
        Wed, 20 Mar 2024 03:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710932316; x=1711537116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Do9aay9EN3cNWUtTUFIIa2Nce3BWyntrGQ3kKJblt4=;
        b=MFVO4Am6v8ktappiLpBVgAw3II2of0iSeTWfzAn4ivVYuTH7uZAIwn+S9rxFxTS6YF
         xYJfUKWZxedGVHIy4QP/8I2uM4u70N5u3lSqZilkXaxlLwKketbD+G9wTGttpK0Ij3e6
         xHOtfSmdrMBZJED/zvH+DFxSVEoU8L42USjR4dDo4Nb8uEUlFP3gvOColg4a1ExN8ErG
         lQaA956gMkhGNORHvGljWEZi/4Oyp371amtMovcKD+SGcGp93JRnaEka3tTgRrnJ8RH5
         jdW+cqe/cXHQfSsVJRiG+hsOM7RQffju5o3k1k3FtL9DHbYRrSLD302Qp+mhFlPcjKWR
         jqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710932316; x=1711537116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Do9aay9EN3cNWUtTUFIIa2Nce3BWyntrGQ3kKJblt4=;
        b=Bewv7jOWSkK7ABUF0JR9so/6c85voQx6IAbboAj84h4D/Ey4l7mgzVwDOPLoSKU/AF
         VXO6cX3buP4dlL1jGBya+VYUWXCMmD21PqZtpid2T2jTXt6cmG/yF+GtvB1HBGJSzlsj
         nlxI9JAXcFj27IH13RWO4s5JupK6xh3F2yYE0WayBNnlm7j7OSbtVtwkgxNowruWr4SK
         CyliqhO1/8St4OlQ4ek5CKKTfcpRYz2uJT2oOGuFtQK8mmaP94S2f0bakaHWCokqjKvP
         HwfqkXR74GigyS7WDa9vKfZP+FUzmJSnEkibwcDwizfrF0G9oGgbpGQYlRAO6xrpdB9z
         YxVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz789ygGOWoTLM19EVG3JsSB+FFPLkO0pNqGqu/3NpakvVyCMhetqSfqLjgNX8y2xteSXgyg6NDK9Huum2eApm6llg9plIvMLcMv8L
X-Gm-Message-State: AOJu0YzQ07XPxuvIhyuFJGCc2Ep7/90x60hhUXn4/Mxfpr6QVMOMUOS7
	BFilvSlMH/5xlVCpUKdsptJ5tkVDTassLX5prpPHvKxZE6N0fOus
X-Google-Smtp-Source: AGHT+IGmo1yECIqQxZ5oZ3rI03LGs5Y5DTj6sdkJ6C7HJe2LT7pYSBTalVUxnr+KC3igTWsnVs7gBw==
X-Received: by 2002:a05:6358:7e0f:b0:17e:c4e0:c153 with SMTP id o15-20020a0563587e0f00b0017ec4e0c153mr1825879rwm.26.1710932315867;
        Wed, 20 Mar 2024 03:58:35 -0700 (PDT)
Received: from pop-os.. ([115.145.179.137])
        by smtp.gmail.com with ESMTPSA id 22-20020a631056000000b005e17cad83absm10582241pgq.74.2024.03.20.03.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 03:58:35 -0700 (PDT)
From: Jongseok Kim <ks77sj@gmail.com>
To: tytso@mit.edu,
	jack@suse.com,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jongseok Kim <ks77sj@gmail.com>
Subject: [PATCH] ext4: remove checks for data=ordered and journal_async_commit options
Date: Wed, 20 Mar 2024 19:58:08 +0900
Message-Id: <20240320105808.1184826-1-ks77sj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Nov 25, 2014 at 04:56:15PM +0100, Jan Kara wrote:
> Option journal_async_commit breaks gurantees of data=ordered mode as it
> sends only a single cache flush after writing a transaction commit
> block. Thus even though the transaction including the commit block is
> fully stored on persistent storage, file data may still linger in drives
> caches and will be lost on power failure. Since all checksums match on
> journal recovery, we replay the transaction thus possibly exposing stale
> user data.
>
> To fix this data exposure issue, remove the possibility to use
> journal_async_commit in data=ordered mode.
>
> Signed-off-by: Jan Kara <jack@suse.cz>

In employing the journal_async_commit feature, the approach involves
slightly early submission of a request for a transaction commit block
without the inclusion of PREFLUSH and FUA. Instead, once all the blocks of
the transaction have been written, the journal device is flushed once.
This methodology, even under data=ordered mode, due to the procedure of
flushing the j_fs_dev, guarantees that the file data is permanently stored
by the time the commit block request is initiated.

This discussion pertains to scenarios where the file data device and
the journal device are distinct. If the devices are the same,
then all file data is written before the flush of the journal device,
making a single flush sufficient in this context.

Consequently, it remains entirely permissible to activate
the journal_async_commit option, even when operating in ordered mode.

Should my interpretation deviate in any manner,
I earnestly request your guidance and correction.

Signed-off-by: Jongseok Kim <ks77sj@gmail.com>
---
 fs/ext4/super.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index cfb8449c731f..2141c2eb4bf0 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4954,13 +4954,6 @@ static int ext4_load_and_init_journal(struct super_block *sb,
 		break;
 	}
 
-	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_ORDERED_DATA &&
-	    test_opt(sb, JOURNAL_ASYNC_COMMIT)) {
-		ext4_msg(sb, KERN_ERR, "can't mount with "
-			"journal_async_commit in data=ordered mode");
-		goto out;
-	}
-
 	set_task_ioprio(sbi->s_journal->j_task, ctx->journal_ioprio);
 
 	sbi->s_journal->j_submit_inode_data_buffers =
@@ -6510,13 +6503,6 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 			err = -EINVAL;
 			goto restore_opts;
 		}
-	} else if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_ORDERED_DATA) {
-		if (test_opt(sb, JOURNAL_ASYNC_COMMIT)) {
-			ext4_msg(sb, KERN_ERR, "can't mount with "
-				"journal_async_commit in data=ordered mode");
-			err = -EINVAL;
-			goto restore_opts;
-		}
 	}
 
 	if ((sbi->s_mount_opt ^ old_opts.s_mount_opt) & EXT4_MOUNT_NO_MBCACHE) {
-- 
2.34.1


