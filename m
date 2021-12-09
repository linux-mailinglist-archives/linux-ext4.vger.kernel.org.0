Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F105446E74D
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Dec 2021 12:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbhLILOU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Dec 2021 06:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbhLILOU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Dec 2021 06:14:20 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E73C061746;
        Thu,  9 Dec 2021 03:10:46 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id g19so5103830pfb.8;
        Thu, 09 Dec 2021 03:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=kGppjqELGTf3I6AiiUMU40BOaJ9p9AixxnYCb5OENnU=;
        b=N2k+oYJBwPUvtYU39dFo3DZb3s9fXo0qNdz92x3EkGX4DBB0RBhaPJyP7UlMfEUkpv
         kGNZgEUQiaW6c/gTgvkfHTJEyYCja3HUheyvTQxJOsPwXl2jTsFCwJLNgFoWfWA6GLDX
         vJSI+P3FK7awZNf8wxcEd6SI0ag9L5JCSWr6LCyXNcfeT4wzaUcBZIj71bqo1AiWRgVr
         kwweJIujQ4+z38LiiLN18bEX1zLGvPzJRTxLy49Vdx91IQZ81ZM9ERpzq4ZtxCiLP8yF
         NspJKC2Yn+C2YmWCdypizJFEVrMokhlaZDC3w8xSCpxH8qBrkddkNtlOHcR58ytnPJ93
         tjmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=kGppjqELGTf3I6AiiUMU40BOaJ9p9AixxnYCb5OENnU=;
        b=SxNvyjMBeTE8gXxS3suyk6r+4w4mVKXgUmh2U1ZTA9xadQGGotX56QeRq5npthJKzm
         oY9v0SBOzTbNo/MgAm6CUUsKUhVbSZ+vVbb7tBqOpmzUb01jH3kMYrRi8s01fqdt8lqD
         2EyNiD94LRNIMSDRsdkI1otjyj3BkCnm2JRBzM5Bt1TzrYT8My0jtJskd0zJZ1U87I4X
         GzJTce0PIPwKx13pJAhNDM7rvO0J1F4lla7dYdr/Dl/Pio6ub3R1Rj2lSseGifh5rnQN
         l0OwtfbGevWjMhFBmKIWdq4LLwQ/e7oX4MHncYKo45lpP10fAfiS+ybcNkdddTZtBnJA
         1KIw==
X-Gm-Message-State: AOAM530kuz1PjDYU8nKzioh3Uw1yzADKxcCNg1NwKkqjrScZjOL7KHPH
        aCFSBPkli4SZAUsjJlY/8G+zet1Luws=
X-Google-Smtp-Source: ABdhPJz8n7oiHviyQKBKbzQXp1QHFa9hl5L0RnlVRblBuELCxkOBfQvBYU+qHaup8Fv5kZvw4DnNJg==
X-Received: by 2002:a63:f047:: with SMTP id s7mr34076089pgj.389.1639048246372;
        Thu, 09 Dec 2021 03:10:46 -0800 (PST)
Received: from [183.173.151.43] ([183.173.151.43])
        by smtp.gmail.com with ESMTPSA id n22sm207791pfu.2.2021.12.09.03.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 03:10:45 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] fs: ext4: possible ABBA deadlock in ext4_inline_data_truncate()
 and ext4_punch_hole()
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <03a92134-ce74-f586-59a0-baed436b275a@gmail.com>
Date:   Thu, 9 Dec 2021 19:10:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

My static analysis tool reports a possible ABBA deadlock in the ext4 
module in Linux 5.10:

ext4_inline_data_truncate()
   down_write(&EXT4_I(inode)->i_data_sem); --> Line 1895 (Lock A)
   ext4_xattr_ibody_get()
     ext4_xattr_inode_get()
       ext4_xattr_inode_iget()
         inode_lock(inode); --> Line 427 (Lock B)

ext4_punch_hole()
   inode_lock(inode); --> Line 4018 (Lock B)
   ext4_update_disksize_before_punch()
     ext4_update_i_disksize()
       down_write(&EXT4_I(inode)->i_data_sem); --> Line 3248 (Lock A)

When ext4_inline_data_truncate() and ext4_punch_hole() are concurrently 
executed, the deadlock can occur.

I am not quite sure whether this possible deadlock is real and how to 
fix it if it is real.
Any feedback would be appreciated, thanks :)

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>


Best wishes,
Jia-Ju Bai
