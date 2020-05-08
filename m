Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E714A1CB90C
	for <lists+linux-ext4@lfdr.de>; Fri,  8 May 2020 22:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgEHUgu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 May 2020 16:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726811AbgEHUgt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 May 2020 16:36:49 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD86C061A0C
        for <linux-ext4@vger.kernel.org>; Fri,  8 May 2020 13:36:47 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id y24so12096509wma.4
        for <linux-ext4@vger.kernel.org>; Fri, 08 May 2020 13:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jguk.org; s=google;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language;
        bh=yiYnWdwVMNRbvDAdkbHNqQZiR7mhRoylwMcd4td5twM=;
        b=Q8/k3XHiWHegjlch8nyC43TxoiLeTZrGlrby5sxtSvu4+sSwa7ufv7Vsfh5X+7M/nW
         amjlrLCeXc4hWhXt7U7YASz8BRkBjDENpUnAU/YwSQ95ECz1xdg5Ht08Awi0jqpkSnj/
         HH+MJ+bf3oLUcCScdGIlYBPf/R6fmwFwBnlXoZrrAZlorG5Fpi66PTFnsKHC1F76skHb
         CNNNM0LuovtTQN16pPiQ8X0svD2xJRHWEhmgvAeg0vzoBQkpTjPSQCVgY5Ct/zSny8N1
         eQ6jFW2lW++enQjt70nJkV8MxMIbbS6rmCjcuZz28g3kvXW+HSSIf2JX6ju3DnxeVKjD
         I4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language;
        bh=yiYnWdwVMNRbvDAdkbHNqQZiR7mhRoylwMcd4td5twM=;
        b=K/xe9aOj6OI/kA5NhJ1WFWY0GuKM0qk8bUK/Lfa/N/qI7omh9OmZbxRGM19Pwsc7Nm
         KBfx99yNhc4LsnD7jRnWMnMViPq17Jm+L2X8m6koNrtYrGfIKzo2bpPEhEtlGHg0ydsz
         gvKsrCvboMjrtFMu59oN3UuwWAX10LN5CIGdsDdkAa/ttXZIujMd8yYPHU/nALof3cPs
         eRcM+tT7NeMULF/N8NB/714PFj7jXjux/Z6+vnqq6I5wWyij9i1xDgW7nBwuM2m6pmMa
         hSifbX5UwZAHud0gV+Kv1LyvEJguwZb2Ur9il5qIADIivUItraqEURiBohpF9RS+ivBn
         Hxng==
X-Gm-Message-State: AGi0PuZxVt+BwYscYxTvF5LPksq9+HjtEWAAQB4UfJunrGSo2PwTh6g4
        xMqrUrk3jZfqhsECrPUw1S2HiLHQRAg=
X-Google-Smtp-Source: APiQypL/KmlxeWpHgBaUA+kFc8xvqAZr94o5zzqf+U8WYG3NVm75QiudyJvbYt0vcZo5AmzxQzmI8A==
X-Received: by 2002:a7b:c7d2:: with SMTP id z18mr17585700wmk.109.1588970206224;
        Fri, 08 May 2020 13:36:46 -0700 (PDT)
Received: from [192.168.0.12] (cpc87281-slou4-2-0-cust47.17-4.cable.virginm.net. [92.236.12.48])
        by smtp.gmail.com with ESMTPSA id b23sm12297995wmb.26.2020.05.08.13.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 13:36:44 -0700 (PDT)
From:   Jonny Grant <jg@jguk.org>
Subject: [PATCH] /fs/ext4/ext4.h add a comment to ext4_dir_entry_2
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Message-ID: <5b9bc322-fe02-72cc-9aa7-a27b26894ce0@jguk.org>
Date:   Fri, 8 May 2020 21:36:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------FF13B4B108865069D1373BF3"
Content-Language: en-GB
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is a multi-part message in MIME format.
--------------FF13B4B108865069D1373BF3
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Please find attached patch for review.

2020-05-08  Jonny Grant  <jg@jguk.org>

	tests: comment ext4_dir_entry_2 file_type member

Cheers, Jonny

--------------FF13B4B108865069D1373BF3
Content-Type: text/x-patch; charset=UTF-8;
 name="ext4_ext4_dir_entry_2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ext4_ext4_dir_entry_2.patch"

--- linux/fs/ext4/ext4.h	2020-05-08 21:29:06.854506000 +0100
+++ linux/fs/ext4/ext4.h.new	2020-05-08 21:32:46.651631273 +0100
@@ -2050,7 +2050,7 @@ struct ext4_dir_entry_2 {
 	__le32	inode;			/* Inode number */
 	__le16	rec_len;		/* Directory entry length */
 	__u8	name_len;		/* Name length */
-	__u8	file_type;
+	__u8	file_type;		/* See file type macros EXT4_FT_* below */
 	char	name[EXT4_NAME_LEN];	/* File name */
 };
 

--------------FF13B4B108865069D1373BF3--
