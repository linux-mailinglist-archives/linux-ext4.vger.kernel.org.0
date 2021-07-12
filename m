Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363A03C5F89
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Jul 2021 17:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbhGLPqN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Jul 2021 11:46:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52446 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbhGLPqK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Jul 2021 11:46:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A8C2322132;
        Mon, 12 Jul 2021 15:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626104601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X7pU2ek3/cmj0H8tjQ1+AqDwww25R7hx11P5k70j6k4=;
        b=Zq3UInR5tQGPnLK51Vp5UyO9pDG3cF+9KLivZRPeatYXBQbAtzMsPYXrVRLQ/TqlSW0A+J
        aplphWJs9mAyayCbq8K1Gi2we37juE7gTf+Gi62SWIVeoJLKVKKk6gZCIjaVqvcyaZHhvO
        8PID4TwDmIMKfjVM3slB59siFVu85iM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626104601;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X7pU2ek3/cmj0H8tjQ1+AqDwww25R7hx11P5k70j6k4=;
        b=TD/QSUYg5kCE1tz7G3SiKxMbYddknLbMJS4pRrU95goYO/EWXE0HtgrqSVkhWik7aioyYJ
        CfIuxm/4c003NXDw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 9C39EA3B95;
        Mon, 12 Jul 2021 15:43:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 89D731E13FD; Mon, 12 Jul 2021 17:43:21 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 1/9] ext2fs: Drop HAS_SNAPSHOT feature
Date:   Mon, 12 Jul 2021 17:43:07 +0200
Message-Id: <20210712154315.9606-2-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210712154315.9606-1-jack@suse.cz>
References: <20210712154315.9606-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1195; h=from:subject; bh=n1iExHGpYVafJ5jgl1/aOUMMUFRCZ3+54go3DhKLIHc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg7GML00qEEZjrU/D94te+EqGkjwtSDwO2l0QLam4q vbods5yJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYOxjCwAKCRCcnaoHP2RA2RerB/ 4sfVYYxO55Q/RD5LpeIdYHscBlEGGjAjl8UtzcjaiSOPaUtc5e6kMk7siRza7MEUQE7oZ6tGGrmD5d aw5ILUvfyMhBhW5m3bon5Hi6zweKAuqWZSKGNo6AFJEU3RHZEm77gR0mWUFuyuxKaJO2XKGu9mGqBd IIPaqUHrRm6P9eQloC+1DIGrccLn38hjtEWVA6vqkP/+CN80KnGDaXgiruQa6DlDsmbyo5Jl05xw7m JbfRH+DFDZDVd3smr0wmCLHlGzIdY71HwfWn+Mp/eJSAhpsOBioFpn/+YO6TUvMWs3JhBVSlDUNdtn 8GajuHTdhb1LdP2t9ujcS8DamWfdQu
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

It has never been implemented and is dead for quite some time and
unused AFAICT.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/ext2fs/ext2_fs.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/ext2fs/ext2_fs.h b/lib/ext2fs/ext2_fs.h
index e92a045205a9..6f1d5db4b482 100644
--- a/lib/ext2fs/ext2_fs.h
+++ b/lib/ext2fs/ext2_fs.h
@@ -825,7 +825,6 @@ struct ext2_super_block {
 #define EXT4_FEATURE_RO_COMPAT_GDT_CSUM		0x0010
 #define EXT4_FEATURE_RO_COMPAT_DIR_NLINK	0x0020
 #define EXT4_FEATURE_RO_COMPAT_EXTRA_ISIZE	0x0040
-#define EXT4_FEATURE_RO_COMPAT_HAS_SNAPSHOT	0x0080
 #define EXT4_FEATURE_RO_COMPAT_QUOTA		0x0100
 #define EXT4_FEATURE_RO_COMPAT_BIGALLOC		0x0200
 /*
@@ -926,7 +925,6 @@ EXT4_FEATURE_RO_COMPAT_FUNCS(huge_file,		4, HUGE_FILE)
 EXT4_FEATURE_RO_COMPAT_FUNCS(gdt_csum,		4, GDT_CSUM)
 EXT4_FEATURE_RO_COMPAT_FUNCS(dir_nlink,		4, DIR_NLINK)
 EXT4_FEATURE_RO_COMPAT_FUNCS(extra_isize,	4, EXTRA_ISIZE)
-EXT4_FEATURE_RO_COMPAT_FUNCS(has_snapshot,	4, HAS_SNAPSHOT)
 EXT4_FEATURE_RO_COMPAT_FUNCS(quota,		4, QUOTA)
 EXT4_FEATURE_RO_COMPAT_FUNCS(bigalloc,		4, BIGALLOC)
 EXT4_FEATURE_RO_COMPAT_FUNCS(metadata_csum,	4, METADATA_CSUM)
-- 
2.26.2

