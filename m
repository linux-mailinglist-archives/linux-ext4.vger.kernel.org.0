Return-Path: <linux-ext4+bounces-6531-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BE1A41177
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Feb 2025 21:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606AE16F3C1
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Feb 2025 20:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34D022D7B7;
	Sun, 23 Feb 2025 20:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OcfkEwUM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFC42153C1
	for <linux-ext4@vger.kernel.org>; Sun, 23 Feb 2025 20:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740341426; cv=none; b=V4/BTFnB+YoQf5sIJVWye212/taGmBCsA540S8BCJxezIeUinNyJxBhsS9NHO61oTl2ZPUgklYJUptzKl69oXKx800sg6BbQuct3ALYMty3CUyrW0oKAeBvBNyFz4khaNQHAt7vaQ6HTMGnun7Qpr82zWC5xL9RwRkog0kfr4fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740341426; c=relaxed/simple;
	bh=KDkGd+8EL5eBEFvtbZ+VanMKD6k6utNUpzhgO4nKSQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uxn9RcVkJcMvqcokqBmDJkSyoKaQUR5kWW+fSelASsmHfsiyv+sLg2Ocj9tPQllG67Ufshq9RR/iMgJBja4JBL4sLQmonskVzCAXEmsr7/S4qyPOZ7eLeZ/VMM4Nu9kQm14rHbWeLybjTj3ICZnE8zwkqUdQ8IdL+hKuQVDKVIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OcfkEwUM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740341423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KDkGd+8EL5eBEFvtbZ+VanMKD6k6utNUpzhgO4nKSQk=;
	b=OcfkEwUMeFPEVxm+h9VhZqi94jssg8ZmQSTRZuutdAbBWyGHJ4g2UgM/e9fW1ZesUwQ198
	Fj2uIndCpnhfAIEQesHA/wDzc7I6PncBzrYw3FSnlxOKZSVdWmdmjP/SVSAIaV3c5QqcTd
	p/akhxtik6PtNinFSVlKTPYnhw57dZk=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-4lEe3PJYPS2y0tZFkYphPw-1; Sun, 23 Feb 2025 15:10:22 -0500
X-MC-Unique: 4lEe3PJYPS2y0tZFkYphPw-1
X-Mimecast-MFC-AGG-ID: 4lEe3PJYPS2y0tZFkYphPw_1740341421
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8559d67a12dso329134039f.0
        for <linux-ext4@vger.kernel.org>; Sun, 23 Feb 2025 12:10:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740341421; x=1740946221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KDkGd+8EL5eBEFvtbZ+VanMKD6k6utNUpzhgO4nKSQk=;
        b=bwy+ya+BG6eqFrZMz+9FC76TvbjpMhjRr1bnaVdUq0yMEGrln3jLPQCExynp7vZKVi
         pMbYxVWcjgV4hrv+XHUHVHD+A8BojDcBShlo3BtX1XXtQGhxgYy/GqWXozQgRz43MHx0
         lxYps1WuCAWet1lcacHUzYaZJvo7sIusxCkrZjAeiwPUcfAp1BYSEJpAVm7bHw6FhYBM
         Z/CULdgP6dIfvqUJbYjULfHK4CAQaubmimtSvInFl2eiyAytzug0yllZFh6V/SM2UZ+F
         I1LDR3zjKXj2eC0xjSjo/5we0vRXuNQ5MJnAvNbsbMx/zeGhI9Ob4qgJztuZ3ppbMC68
         XfUA==
X-Gm-Message-State: AOJu0YxIMAMI+ao1i7L+YLmLVtJMvuziwZShTgmFwG25aZdAfXtGPjqc
	0sOBI2bt8uUZ+Fe7uao3nmizujdEovnVsnlm9+KhqrlrrXOstbhIz6zrikniKDV0NpXd6c9VrDZ
	EYM4uSXmQdViZJtMYMG4KkV5CFHxrW3+dqgnQVciI6fOxGhmjRLUeSQexWvw9fn2wgD8WWg==
X-Gm-Gg: ASbGncsAnvmOhxGfxjb0qqdKOURviQWrRrCZBJNIgPt16Q/zcFghrWeT8U4jUAN5j8g
	xh0eJXvKIBJpnetIa6NdmVaii/bY1sdBjxTWShmb63rjgaQQsLVT0ZndIL2T7b0c4ywC2d/VR6h
	/wYlo0JmM9F0iPV27ZJ05razJzIIDgv14U4dfDlCd9YPV5PUm5nicnjbPSNoeQbBy7GKXIawUzU
	OdPXMBYVtlz+YWc81f09AMsaazjOdUdrfqomzqeuColgxvNZ+PRxxUlFJip88fGbQzoo66XUvVV
	IABODxemN0JOLZHXz2rpiiLr3Icc5sGMsMG6f3SAok7zFTIXjNLHYqBnuXNcGdl/
X-Received: by 2002:a05:6602:6d05:b0:855:a283:8231 with SMTP id ca18e2360f4ac-855da9b189dmr1168939639f.1.1740341421226;
        Sun, 23 Feb 2025 12:10:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFc1BHJyQseC4OAj6ojD7o/hjAxRM8udwodcUFx+GBBAP69rlrHnKokZ/yifaAbn8xnnPBH6Q==
X-Received: by 2002:a05:6602:6d05:b0:855:a283:8231 with SMTP id ca18e2360f4ac-855da9b189dmr1168939339f.1.1740341420978;
        Sun, 23 Feb 2025 12:10:20 -0800 (PST)
Received: from fedora-rawhide.sandeen.net (97-116-166-216.mpls.qwest.net. [97.116.166.216])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-855b8cd2ab7sm215692039f.24.2025.02.23.12.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 12:10:20 -0800 (PST)
From: Eric Sandeen <sandeen@redhat.com>
To: jack@suse.com
Cc: linux-ext4@vger.kernel.org
Subject: [PATCH 0/2] ext2: convert to the new mount API
Date: Sun, 23 Feb 2025 13:57:39 -0600
Message-ID: <20250223201014.7541-1-sandeen@redhat.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First patch allows ext2_msg to take a NULL sb since we don't have
that during option parsing - ext4 does the same.

Second patch lets it take an fc instead; it strikes me as a little
messy and I won't be offended if it's not wanted. :)

Thanks,
-Eric


