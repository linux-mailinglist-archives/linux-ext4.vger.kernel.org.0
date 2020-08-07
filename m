Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF13823EC89
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Aug 2020 13:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgHGLcZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Aug 2020 07:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgHGLcY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Aug 2020 07:32:24 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB1CC061574
        for <linux-ext4@vger.kernel.org>; Fri,  7 Aug 2020 04:32:24 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id h12so759395pgm.7
        for <linux-ext4@vger.kernel.org>; Fri, 07 Aug 2020 04:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Y2oNB6enO0dYMDW0ENdB0t+ep6PexpAV6isiHJCKLsw=;
        b=S1xOUh4Ua3H9x4JkOM0TGO0zzV5CSlu9SeHTl3/ZbARFpL5zn3UiPFmTyfka+Zlcqz
         vvy5ZDOyrGgkAlwSywOm1tIOFnFDWwrfLNKCcRS27UlP/Ni2HGcF553OkkwIuPS5FBPc
         sAC9rSImvduPXhOYJajqdEXg8LLm5RVVPcTRp8p6o+OXla0yVQqgledTdNOOZNUS7L4f
         UN9pZ3i1n1isyDWJhiIsuOWEbI+VXd8HNcnFQ7NXp1j4bTxaqVGy+3PmVAnel04wotpc
         NxPTNLaLpL3rcyzQbkHDl2tzLEYgK09vffw4TqGJb8PFJpuFaqmPmKq+rt9sfoLqqf6h
         4AlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Y2oNB6enO0dYMDW0ENdB0t+ep6PexpAV6isiHJCKLsw=;
        b=Z2Gzki4pETvFQJoaGgrPiKrjIk9ltK6Bd1pUieUwAHg/3uGY4BfXrmg/eQx/rvOjLO
         fgbFC37T5xJiaFusBm12Khp+fa8CZYvL8w/ozXZ2uwOkT7v3Nz6VQ1bCplwstasqibLd
         vjl4dM1aWHdT34XYcGgrvcvJ9eZ7r4qepb5/sxyVDBPJACafPiUBqHSOTEqBKeEmgFX4
         7A+Finf+m1Gz8VGJOGLGkyZGDejcJTVE851a/K8SX/haDvqVCmR2kPC5i1J5XmOcOrZc
         IW/CLHberLO6Igi01+BjJ1DCIss7vl0+ZX6cZK64bP7iLCox8njtiavPVO2I5ElgIIeR
         X/6A==
X-Gm-Message-State: AOAM530Bzk87045gqieKQKQu4gP8ohnFC6N/rMv2yZCgXkkvdTQ+DOvw
        /N0UAEmx6cxJNI6t7UTt3SeEFT0DUdY=
X-Google-Smtp-Source: ABdhPJxG045JQWV6sIZ+4XDvG8JO9HWsHvaN3k91g+CKRt3N05lBVTFpJWGkZZxID3poaTjpccqUbw==
X-Received: by 2002:a62:ea01:: with SMTP id t1mr5827174pfh.125.1596799942793;
        Fri, 07 Aug 2020 04:32:22 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.44])
        by smtp.gmail.com with ESMTPSA id s61sm11102678pjb.57.2020.08.07.04.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 04:32:22 -0700 (PDT)
To:     adilger.kernel@dilger.ca, tytso@mit.edu, linux-ext4@vger.kernel.org
From:   brookxu <brookxu.cn@gmail.com>
Subject: [PATCH v2] ext4: delete invalid ac_b_extent backup inside
 ext4_mb_use_best_found()
Message-ID: <0c77de22-c0d0-4c1b-645a-865bcd2edc0a@gmail.com>
Date:   Fri, 7 Aug 2020 19:32:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Delete invalid ac_b_extent backup inside ext4_mb_use_best_found(),
we have done this operation in ext4_mb_new_group_pa() and
ext4_mb_new_inode_pa().

Signed-off-by: Chunguang Xu <brookxu@tencent.com>

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 9b1c3ad..fb63e9f 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1704,10 +1704,6 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
 	ac->ac_b_ex.fe_logical = ac->ac_g_ex.fe_logical;
 	ret = mb_mark_used(e4b, &ac->ac_b_ex);
 
-	/* preallocation can change ac_b_ex, thus we store actually
-	 * allocated blocks for history */
-	ac->ac_f_ex = ac->ac_b_ex;
-
 	ac->ac_status = AC_STATUS_FOUND;
 	ac->ac_tail = ret & 0xffff;
 	ac->ac_buddy = ret >> 16;
@@ -1726,8 +1722,8 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
 	/* store last allocated for subsequent stream allocation */
 	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
 		spin_lock(&sbi->s_md_lock);
-		sbi->s_mb_last_group = ac->ac_f_ex.fe_group;
-		sbi->s_mb_last_start = ac->ac_f_ex.fe_start;
+		sbi->s_mb_last_group = ac->ac_b_ex.fe_group;
+		sbi->s_mb_last_start = ac->ac_b_ex.fe_start;
 		spin_unlock(&sbi->s_md_lock);
 	}
 	/*
-- 
1.8.3.1
