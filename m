Return-Path: <linux-ext4+bounces-9538-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4379EB306DA
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 22:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EC8F1CC8083
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 20:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A7737441E;
	Thu, 21 Aug 2025 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="2NtIPuIa"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D4A3743F0
	for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 20:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807675; cv=none; b=GsG0g2jFe1E/+95ZE+OMMPjtE2qqJUX6juj+YtNJtCvDSpArwpwAgnagxvDMgWfRQwYwuPBguuYzFOu7v0TOc6XkBDtVtAvdSiJsZSmXHTqLlkEy6zT4P4kl8p52KryDe8z6MN7QlM9RrBJ7al6vx8/bCHSMJzmOzZao95E29Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807675; c=relaxed/simple;
	bh=GaKmvGab+0a2RrIuxhv8XqHzko9SenWylGMpW6UIOW4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKT6Z3TGSwNv2ODkKdL9kjSFCMWkIABhYoVRGj22TDXcWnKsxuS7xPzyDweJ3cR+dGpyAcnUcsxO8cLWkNTSLD14g5SFoFvmNsGjsg5DWIx0H061Q6TxCbeo6LX1o+c/SLoOhGevqGJkUvhZrIhCGPMz4e7dKkITJXK9sRJI71E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=2NtIPuIa; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71e6f84b77eso12794477b3.2
        for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 13:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807673; x=1756412473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WTOjoTpV6m7hLv/F0NHjQx0Ply5AcqoXgmnK8+LDP5A=;
        b=2NtIPuIahlj40rQpQEwwwPynRRoG10AkG2ZL/kDa1GNaKwhT5sW4SpXQc2+lryfVd5
         6oAGbNi8r+AdgPSypvig7VKsuHw7HFwJ4RSIyqY/C8nqBBY4SRENCwjDdfor0lUTCykD
         IvPakHeceSjdXUp6f4sX38q/ZSEqtqgBRxcyoG+ko2yGi/WfxHeZfgD6EyqsUpWhxDqu
         moMCa9+VwqrsJLLs/DqLHB6/YjZmiHMgrVjNjUoBIqBg0wvuVjfQN/APwyw5Al7wdYIB
         T6ZdicSMOfkU3HF1LYy8egdu5FG32umMVhQtkMQj2sYyAz9snsx+kXfarhKb+5OercZR
         wQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807673; x=1756412473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTOjoTpV6m7hLv/F0NHjQx0Ply5AcqoXgmnK8+LDP5A=;
        b=bPc+tJ/vPbyWWaRvEnuH6ESnVo9JJm0ubc03CAxEAZ+0NbNEu3byrGZvVJaYYD6r4o
         2S8siukYObjzziT156kBditxxTf6JVjVQ2X3PaW1taXb7ZLAlez89AUwHo7I/OSgQfcM
         cFsloVZNNWs9FQqGS5G4EDhfBh7PyNAXztW1Zmi9BiFDeuJlAcOyZhcAICZx8rspz5v4
         ycSjVdUcbRu1d5lNLJg1IRY9aTd96sJLaOTzlkyMlJ8FQIXHQi3OABoLkl7EPRLzNSnf
         tSo220uc1FzRQgRkiWRHzKqb3xWmgPmXamZNJBGhMz7Gq03tNHUYNWYWyU+pCa2L82i4
         K01A==
X-Forwarded-Encrypted: i=1; AJvYcCWSfFgyvVEubyxbPS5o5+0Dx5TbaOP01DDvZF/4U15ZLIv+hn0l90+7mETmLSEOPPpEMdBtyYhdH1BK@vger.kernel.org
X-Gm-Message-State: AOJu0YwbcFMarZnJC6SYLvytolbd3JwOlqJZvwQg0feC/nKcvGmw3Em+
	KOPZxI0xeJ4ivPJQqyQpj1C4tHKWUxQuJOvs3HRDPHzIy+QnPt8jap8vIXSaFDFCDUo=
X-Gm-Gg: ASbGnctB5nNxX+LMoHHxcI6cFzk7bQcHJo2CGZGZ/+JfhoJTax7XMCbNG2YZ4uL1qnF
	z6j0qdlaEyLRiXYHsiXVZz7oyr2CkSCoZ03vxiJZCP+2b29vRsgVDnxrNeRESY1eVlsF5gWYvEE
	FfQN7snep0yVLn2Aj/G8qtUf5/DcT6jeVdkSRBndmFBeRXJbMHKNDRAZaJITV+FsxhxZZHqaqcw
	tjxFrKyhAZOVrnBNrBT4k5BhIRNWiS1veqcrnlXTPZ07n8qNbUwA67xkeWIGtXqSwsE7F7sRVnV
	PrpCRrVX+OM+JIoxmNsUoz8NnmdlTO3/+ohD9MtkR0XF3oqmHVCThHmOYwMEcmSKohWPwCMAqvO
	HqE+GY2DinfBnWTz3D7qevAaF5/h0ucSYPzXfE6+0mAb/igODpID3CNkDSfwMnPxwz7X/sQ==
X-Google-Smtp-Source: AGHT+IHgWhO0XZL2d+T13fQCGNTnfEWS9ecA9Ina0HETuoa+JmM/sUYXK320kf/CPFEnDhrEBPT2MA==
X-Received: by 2002:a05:690c:6d13:b0:71e:8165:990f with SMTP id 00721157ae682-71fdc316064mr7520287b3.24.1755807672210;
        Thu, 21 Aug 2025 13:21:12 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71fae034dc0sm17871437b3.74.2025.08.21.13.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:11 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 37/50] fs: remove I_WILL_FREE|I_FREEING check from dquot.c
Date: Thu, 21 Aug 2025 16:18:48 -0400
Message-ID: <109daa67d809b78526099377be7f9fef59608010.1755806649.git.josef@toxicpanda.com>
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

We can use the reference count to see if the inode is live.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/quota/dquot.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index df4a9b348769..90e69653c261 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1030,14 +1030,16 @@ static int add_dquot_ref(struct super_block *sb, int type)
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
-		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
+		if ((inode->i_state & I_NEW) ||
 		    !atomic_read(&inode->i_writecount) ||
 		    !dqinit_needed(inode, type)) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
+
+		if (!igrab(inode))
+			continue;
 		spin_unlock(&sb->s_inode_list_lock);
 
 #ifdef CONFIG_QUOTA_DEBUG
-- 
2.49.0


