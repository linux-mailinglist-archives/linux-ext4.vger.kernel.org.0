Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AF74C3AC2
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Feb 2022 02:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbiBYBN3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Feb 2022 20:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236274AbiBYBN3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Feb 2022 20:13:29 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014961AA04C
        for <linux-ext4@vger.kernel.org>; Thu, 24 Feb 2022 17:12:58 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d17so3413458pfl.0
        for <linux-ext4@vger.kernel.org>; Thu, 24 Feb 2022 17:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=EMGY9dkaFdtPxmXDT9hYK1EhMVb3Jf1tKKXCRpDBmIs=;
        b=lGk2V6TddEvbdJjuCqdG5h3CJXLRJF4zZXa1QwVo22wTIUyLrS9cBylj6dmz2QD856
         EpekucLZe69VbzNWEkoy1BMHeMb+b+wEIvc5nviY1tXIUG8IRFhUg448ctstKCETVtNQ
         jYMzENoZ9JCdIGT5UiWHdCm9jzC1uwUL67P2SNzPFeAguVt/8aihOt6aFb5hms05zZNc
         nJS89QPEwCxMxo6LWVgMZjokoHz2gdy6ZpneMm6sMQ+8DwfmnRpnl5iRxKtkfThWCy/2
         FvUPzZjfgOTby/wbPVbXhvGeKfAjwJsa3Md0TsZt6l2U6Aur5Ip+Qj/32HVl46qv06By
         4t6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=EMGY9dkaFdtPxmXDT9hYK1EhMVb3Jf1tKKXCRpDBmIs=;
        b=pVyk8r+RRy3HBsevvQ9tIP8WoYH7saZ80Wh6fx8N6xx052U2LMKxRIMeiuTaW1dLN0
         2/+lhEkBIYSOHpK7ICS8JE+VYmP/piavpstflSN43SGrBKL+6DM4lQR8drhID8gP9OTF
         uicLAgwBs6DIvBTqDyAwK1onsNsJz/pTtz3AL3BEIQgoes3AmqjIeK4EB6r0R6yUzON9
         gCKBoGs3PiXlQMX1sn+GFXAseC/4ozDyqvMluz+yC+vjfiJr9WDGKebBBAgkZPLRl4t5
         N9uCkcQyGtntIslNJEEjCpQX16MB4D871wzUyjaCIyowHiNL+cR9zltPTXnDH9gYm50/
         GkrA==
X-Gm-Message-State: AOAM532PXkGfl/XJkx5D7Zg7rQ9kNvKIinGrL18ziS+JtxL75KIWtO2C
        zl70oywav5EWYGqf7Jq/kjmu9Q==
X-Google-Smtp-Source: ABdhPJwLli7/JD0XYI6jNy3txkgc+hAgR6D/KFbguhBaSA7gIZ9SYYaSYVDOde2HMR3a7n2sx8JRBA==
X-Received: by 2002:a62:586:0:b0:4e1:dc81:8543 with SMTP id 128-20020a620586000000b004e1dc818543mr5171194pff.0.1645751577425;
        Thu, 24 Feb 2022 17:12:57 -0800 (PST)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id h2-20020a056a00170200b004e0f0c0e13esm731478pfc.66.2022.02.24.17.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 17:12:56 -0800 (PST)
Message-ID: <48308b02-149b-1c47-115a-1a268dac6e24@linaro.org>
Date:   Thu, 24 Feb 2022 17:12:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: BUG in ext4_ind_remove_space
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


Hi,
Syzbot found an issue [1] in fallocate() that looks to me like a loss of precision.
The C reproducer [2] calls fallocate() and passes the size 0xffeffeff000ul, and
offset 0x1000000ul, which is then used to calculate the first_block and
stop_block using ext4_lblk_t type (u32). I think this gets the MSB of the size
truncated and leads to invalid calculations, and eventually his BUG() in
https://elixir.bootlin.com/linux/v5.16.11/source/fs/ext4/indirect.c#L1244
The issue can be reproduced on 5.17.0-rc5, but I don't think it's a new
regression. I spent some time debugging it, but could spot anything obvious.
Can someone have a look please.


[1] https://syzkaller.appspot.com/bug?id=b80bd9cf348aac724a4f4dff251800106d721331
[2] https://syzkaller.appspot.com/text?tag=ReproC&x=14ba0238700000

-- 
Thanks,
Tadeusz
