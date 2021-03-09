Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04292332234
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Mar 2021 10:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhCIJkJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Mar 2021 04:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhCIJkH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Mar 2021 04:40:07 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102C3C06174A;
        Tue,  9 Mar 2021 01:40:07 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id mz6-20020a17090b3786b02900c16cb41d63so4872826pjb.2;
        Tue, 09 Mar 2021 01:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=bhy6FXnbh4g+JCSS127G4frcWWfQNf7o2VFHd7ec+k4=;
        b=UQyRFBWrNgIc49iey0If78H6OGf3xwlVT2o14ix/yYEElcXIbtMU973jPmL/uekbVQ
         F2JVve2TxxmlThx+UcfTRV4IWW8BMe/MsSckVe6eDpoeNY6298F27RAqJQrrW/x7F9DQ
         LhPzRGNMlQ1tIOIZ+jPmIVfL/AO3C4hyx3oRDys29+kUPVGoBDoNEK4GoBwD53jhJCr/
         aMF8uCpEz3VrmPDXvxxOsYftTBr0sQcIB03cawE/iVd69pF/ilyJ6IGbaJVrlYxyb2Vt
         WcnL3fFiUErUTF2cPQk6Loivu24WO9uEgJN0vFx9Of8mnP/1Gch+6r132IplCRiyXhoj
         EpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=bhy6FXnbh4g+JCSS127G4frcWWfQNf7o2VFHd7ec+k4=;
        b=jFc2goNWNPDHkL5SJx/+SwGCuUIk16jgxzPHsmGl3VMFVPnrvkZDpl8XCEu1F/0azh
         AXH6WD8+P79pmingikBk+kmvnD0r1lPQVBEdDLVs5MUEh2eQIvnKIAoHvhuqVX65PmfW
         3WsfUw+kCI24gkcWQfM+n3lVvwhPU4WhOxND77cOJq8U2z1VhEaYs7Oz2EPmYF9Uk8MP
         5aIlaCakib+U7FjU+NzCPGOK3TLItcQOwpmNcVdDgtZQSUUpUauySZAZ0YEW/WkQxRfW
         aRlmKmjyuEF3zhz3pRZLxotSAMt/hloX5yA0u/v6iCdGF/xBCh7ydA8oOw7SBQGTc9/G
         NGLQ==
X-Gm-Message-State: AOAM5333jHW2w5dk7QjS78HxWIlqT2Ki+XnC+V+U44+Gq0nLbnnUbhmQ
        2kyA5ulZDEwMYDhHH/RNDBvePxAxBqV6EW1U
X-Google-Smtp-Source: ABdhPJzjqvWZK8GONzQa8oMCqFW57cQCnPLHl8FZ4uQw+kxAoQjuPA7zlo8OwmtYX/bEsvYT82UoyA==
X-Received: by 2002:a17:902:70c7:b029:e3:71cf:33d2 with SMTP id l7-20020a17090270c7b02900e371cf33d2mr25117699plt.21.1615282806332;
        Tue, 09 Mar 2021 01:40:06 -0800 (PST)
Received: from [10.160.0.62] ([45.135.186.124])
        by smtp.gmail.com with ESMTPSA id a20sm1429627pfl.97.2021.03.09.01.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 01:40:05 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] Possible bug of missing error return code in
 __ext4_journalled_writepage()
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <7d7b3a16-74c3-1958-85df-fe6d10ed85be@gmail.com>
Date:   Tue, 9 Mar 2021 17:40:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In __ext4_journalled_writepage():
     ......
     inode_bh = ext4_journalled_write_inline_data(inode, len, page);
     if (inode_bh == NULL)
         goto out;
     ......
out:
     unlock_page(page);
out_no_pagelock:
     brelse(inode_bh);
     return ret;

When inode_bh is NULL, ret is not assigned with an error code like -ENOENT.
I wonder whether this is intentional? Or ret should be assigned with 
-ENOENT here?


Best wishes,
Jia-Ju Bai
