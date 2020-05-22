Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD901DEB81
	for <lists+linux-ext4@lfdr.de>; Fri, 22 May 2020 17:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbgEVPJo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 May 2020 11:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729931AbgEVPJo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 May 2020 11:09:44 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4016C061A0E
        for <linux-ext4@vger.kernel.org>; Fri, 22 May 2020 08:09:43 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c11so1005624wrn.6
        for <linux-ext4@vger.kernel.org>; Fri, 22 May 2020 08:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jguk.org; s=google;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=QUOL86oCn4+k/Qe0jEh098tkL15cZQEYgAUAt8fMeUg=;
        b=HpqW0E2P8ndZzDy12Dl1vJsM9Je+p69doLK/kX9uhSiPEtmQRQa4kTem0DnBLh4+6x
         LCzffNoANwAFk6MWBzAOQvrazThYgVEITK1E+xZXmC92Ri2jZ3qx4K/w8jTacZK82z6d
         FhH07PkCaYg1PIDialmL8zP7IkXa5BcROdjIS/azF0+LGIN1N2SvmNvXESvRqv5mS0G4
         xU52wV46143mwyDUFY34qCv66Yr42d7UZCAurIjPIdopjxe1htZ12pNdh5zepaHjg50a
         bHFSKY6iQf/1rZBUb9/tJ0vknbYxA29E9rgdJwa446HGZOZoTK8CvrSbjKwvJBBN9yom
         AKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=QUOL86oCn4+k/Qe0jEh098tkL15cZQEYgAUAt8fMeUg=;
        b=GzP9632E9JeEymfRR7U/wvKfNneywekJAiV+WTRe5VOiqVx83YkO5A0G/hnvm6fB8r
         1bsfGXNX+kIwyZs3WHvjzCy8Q+QaOwxHcvG3hlAvfD06f7g1QRSb+dA4bH9qV6rFRUux
         1h5TMsdnXx+7C2pvZ9PuyUuvP4ajk5mKqwHIJFqFJ4n4bPvC///PmrHBFGyO98S2Y9ze
         1SPGbJ6AL0yG1Srzd5dO7NJnZR4CcmUm4TwVwlvzm7nc4/26rA8IIGcM1S5z2drrZG9X
         tZH3eV/clxr/ku8HxQo1qvwzl7KT/tCncQLywQrICYhEzp6wwgeI3X16ci55jJWSMmP5
         t4eQ==
X-Gm-Message-State: AOAM532y9ThrJXx5Yq/yVQgD4HFMk2Yafv8PUcGLJE+iaDlET3pKlUSn
        yqrt8kV4abnyWpJvns2tsaequFP8pS0=
X-Google-Smtp-Source: ABdhPJyCjgELtUPinr1bqVzoK7V5GVL0uf+4gRWAXcRZkZNcyR56oI5nf0zpFv/jmpBBtsT/yqQjPA==
X-Received: by 2002:a5d:67d2:: with SMTP id n18mr947370wrw.65.1590160182365;
        Fri, 22 May 2020 08:09:42 -0700 (PDT)
Received: from [192.168.0.12] (cpc87281-slou4-2-0-cust47.17-4.cable.virginm.net. [92.236.12.48])
        by smtp.gmail.com with ESMTPSA id z3sm10042623wrm.81.2020.05.22.08.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 08:09:41 -0700 (PDT)
From:   Jonny Grant <jg@jguk.org>
Subject: [PATCH] ext4: add comment for ext4_dir_entry_2 file_type member
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Andreas Dilger <adilger@dilger.ca>
Message-ID: <ad3290d5-86af-99c1-f9d5-cd1bab710429@jguk.org>
Date:   Fri, 22 May 2020 16:09:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

 From 4e9d768a0adb60698ba13e7b7522c15a4548332a Mon Sep 17 00:00:00 2001
From: Jonathan Grant <jg@jguk.org>
Date: Fri, 22 May 2020 16:07:58 +0100
Subject: [PATCH] add comment for ext4_dir_entry_2 file_type member

Signed-off-by: Jonathan Grant <jg@jguk.org>
---
  fs/ext4/ext4.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index ad2dbf6e4924..7a042896bab7 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2050,7 +2050,7 @@ struct ext4_dir_entry_2 {
  	__le32	inode;			/* Inode number */
  	__le16	rec_len;		/* Directory entry length */
  	__u8	name_len;		/* Name length */
-	__u8	file_type;
+	__u8	file_type;		/* See file type macros EXT4_FT_* below */
  	char	name[EXT4_NAME_LEN];	/* File name */
  };

-- 
2.17.1

