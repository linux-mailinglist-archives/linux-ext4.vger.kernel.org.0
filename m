Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECEC6391285
	for <lists+linux-ext4@lfdr.de>; Wed, 26 May 2021 10:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbhEZIoi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 May 2021 04:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbhEZIog (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 May 2021 04:44:36 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E77C061574;
        Wed, 26 May 2021 01:43:05 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id t21so270725plo.2;
        Wed, 26 May 2021 01:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=bat8mnp8um60U9aMrOHnIWqznun1A+ow7zsGP3ztSDk=;
        b=Z2SJHq7Ty2i1/sKBiWlyO2nuYrwsgMLBjCAQ6aHAlX1wHr75ltYHA42JvbNZKqoJJ1
         ko3UugjHQrwYoDG6KI7vKUCsWLZ/WiSad6cfw17OMHAVgv/y1jhH0A104SpXFUmNTVhH
         pU87c3z/Wi6UVrquUWm2Rhb97k5TvJt3In//xYpNkh/W9lFynYO7HFhkvoh+kvfd2jKL
         gtUjvrPT2s4LQJDK+64ED1sNfiXn3/2jnr+rZZpjnNtgWMjJozf/tx3XSk2FPiHRvBsZ
         l6XWBNktiV2PdDwBMx9afSIUQ82gK/9hMCKttUCHa0r1cU1ZCfKrmkrcXUaAngalkUYE
         SgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=bat8mnp8um60U9aMrOHnIWqznun1A+ow7zsGP3ztSDk=;
        b=CWZfREIBeeKqPkNg9fl2IPI2CZ7bFqgqy3MC/0X6/W58Wh0cKGp01MiD1IU4oC37C9
         m6wVgrrP2gQzwwbVCHZUOv3vzHmLPbBZnjOYqwEq1+uGepfRfRswVhvrJTJITIX3hE6B
         KKccsnp7LLBD3OQ2Qdx6CISVvic3B22Vn0DdMFdb28iTwn8GIAytNi/dKHwy+HJxBzBx
         nqnm5Hw7PrE3hKtQZFticTyONLqsk1QDHeKtfECiOQ1O8cmRR0dvatWtFLdeu/6c9Bys
         9RXUqeU/YD9bvA6YKesMjJJ3QzxLKQCA5D4W0qchyimnE8UiIftBFvO/6PzwACt6xKFj
         U41g==
X-Gm-Message-State: AOAM530O/Wy44LrhIfmoDmxKD/w5lcCboK0s4P+G2EPQqRqNAOXm8Xov
        ggw5HosJw0rDOIs4OVl+MlE=
X-Google-Smtp-Source: ABdhPJw5oJjvwVuH9+xJ4IKOX6ssjnQH5r/GYwMnsYmSVWNN5bL62xTjkFMFGfSdYU94a1seE/p14w==
X-Received: by 2002:a17:90a:8809:: with SMTP id s9mr2778415pjn.189.1622018584675;
        Wed, 26 May 2021 01:43:04 -0700 (PDT)
Received: from jianchwadeMacBook-Pro.local ([103.112.79.203])
        by smtp.gmail.com with ESMTPSA id 125sm15085375pfg.52.2021.05.26.01.43.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 01:43:04 -0700 (PDT)
From:   Wang Jianchao <jianchao.wan9@gmail.com>
Subject: [PATCH V2 0/7] ext4: get discard out of jbd2 commit kthread
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        lishujin@kuaishou.com
Message-ID: <4d9d3aef-8e27-3e1c-0c0e-d19a87b251d4@gmail.com>
Date:   Wed, 26 May 2021 16:43:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi

This is the version 2 patch set that attempts to get discard out of the jbd2
commit kthread. When the user delete a lot data and cause discard flooding,
the jbd2 commit kthread can be blocked for very long time and then all of
the metadata operations are blocked due to no journal space.

This version patch is based on Ted's suggestion that free the blocks after
commit immediately and then use a background kworker to do the discard with
the fstrim fashion. The discard maybe slower than before but it doesn't matter
as the blocks has been freed back to mb allocator and nothing would be blocked.

There are 7 patches,

Patch 1 ~ 4, there are no functional changes in them, but just some preparation
for following patches

Patch 5 does the buddy cache get only after insert ext4_free_data successfully

Patch 6 get rid of the s_freed_data_list which carries ext4_free_data and iterate
free data rbtree to get ext4_free_data. This is also a preparation.

Patch 7 introduces a async kworker to do discard which implements the core idea
of this patch set.


Any comments are welcome ;)

Chagnes from V1:
 - free blocks back to mb allocator immediately after commit and do discard
   in fstrim fashion.

Wang Jianchao (7):
ext4: remove the 'group' parameter of ext4_trim_extent
ext4: add new helper interface ext4_try_to_trim_range()
ext4: add new helper interface ext4_insert_free_data
ext4: remove the repeated comment of ext4_trim_all_free
ext4: get buddy cache after insert successfully
ext4: use bb_free_root to get the free data entry
ext4: get discard out of jbd2 commit kthread context


 fs/ext4/balloc.c  |   2 +-
 fs/ext4/ext4.h    |   6 +-
 fs/ext4/mballoc.c | 434 ++++++++++++++++++++++++++++++++++++++++++++------------------------------------
 fs/ext4/mballoc.h |   3 -
 4 files changed, 241 insertions(+), 204 deletions(-)

