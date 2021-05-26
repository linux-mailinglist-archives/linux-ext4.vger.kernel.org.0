Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E634391283
	for <lists+linux-ext4@lfdr.de>; Wed, 26 May 2021 10:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhEZIo2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 May 2021 04:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbhEZIo1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 May 2021 04:44:27 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1328FC061574;
        Wed, 26 May 2021 01:42:57 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id a7so267653plh.3;
        Wed, 26 May 2021 01:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5RwlVOYSug509Gc2kX91BzKkmEP4KOrbTpcGxbCLpLE=;
        b=tEOtbEnzP+JICK+N7zH7511zB6UwkgugYwApCq3TelLIE9hrcmF6aomjk6+/u6XkrG
         6Jp5uuOhHvrqlBhcPHAMJEv1OdVXxv1A9GjcDOKHtQHZ1BN1nRD8qNGFWNrfcrV6hwF5
         7f6hn0iqPycFewZR6tw7py+RMSoOe6QipJkDo4EoEDSQn/phPbAaCinGvPm/MhQEMxQl
         YnEfM7Uz5M/hzUb4yDVuEuKNibNVxr8lRf3zOt21NHwgTIgmFr4OAdqPkm3WKZeXTpuO
         z36eHVqF5RoYfb4Q9b+Z7rkv4yClYO2UZjkUacQKv9FF8a9osbx4wW0X4iUnnfs8BmiK
         1jwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5RwlVOYSug509Gc2kX91BzKkmEP4KOrbTpcGxbCLpLE=;
        b=noH06DKTmqPnD6zVzub/rI0Env4Pa6N6A/7qrwTY2cteVc0JPjjPjT7pSBeoTdZsmZ
         mUyCSdz1fP2U+wK1cyejz5D/sA7jtoNXHPKY8vcSG7GMg2vDhdtRrphPALS41B/qcQRs
         DB2BVkc2V8sFLvpqu9l1KSfYz9Q2P6r/YtLs4+4vR1XaCZOjY+RzflzlgdAJ+2x6NE90
         0/S9szoeu//ijLCAi+fg3s+pVm+CDXERzCykFVogRqj8BcpH5FBm5dqVh5qo9zbioBjZ
         bsbG+QLWBXDf3MqJn0lNiKdowA9AoDItl1v6jhMkUqF5nzkjTuDCsg3H78GeBwizEBEK
         id0w==
X-Gm-Message-State: AOAM530wYu2qj3N4btm+ckcfZrybaJL42RWx98rWmBlt8noB5BZnaqnX
        ZVhCdqV9wae9C+fZuJl1c1etYWExmi8=
X-Google-Smtp-Source: ABdhPJxB2a1HvSyJn5znRWmhf5aOLrDu2VRWB2cRMzAOUPnfGYbLAAx4+qdpPffKLbJ0HAh0k/bE9w==
X-Received: by 2002:a17:90b:81:: with SMTP id bb1mr34570730pjb.167.1622018576567;
        Wed, 26 May 2021 01:42:56 -0700 (PDT)
Received: from jianchwadeMacBook-Pro.local ([154.48.252.66])
        by smtp.gmail.com with ESMTPSA id x184sm16801191pgb.36.2021.05.26.01.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 01:42:56 -0700 (PDT)
From:   Wang Jianchao <jianchao.wan9@gmail.com>
Subject: [PATCH V2 1/7] ext4: remove the 'group' parameter of ext4_trim_extent
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        lishujin@kuaishou.com
References: <164ffa3b-c4d5-6967-feba-b972995a6dfb@gmail.com>
Message-ID: <61eceb4c-6e5f-34d0-9317-a833d7c63b6f@gmail.com>
Date:   Wed, 26 May 2021 16:42:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <164ffa3b-c4d5-6967-feba-b972995a6dfb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Get rid of the 'group' parameter of ext4_trim_extent as we can get
it from the 'e4b'.

Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
---
 fs/ext4/mballoc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a02fadf..d81f1fd22 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5650,19 +5650,19 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
  * @sb:		super block for the file system
  * @start:	starting block of the free extent in the alloc. group
  * @count:	number of blocks to TRIM
- * @group:	alloc. group we are working with
  * @e4b:	ext4 buddy for the group
  *
  * Trim "count" blocks starting at "start" in the "group". To assure that no
  * one will allocate those blocks, mark it as used in buddy bitmap. This must
  * be called with under the group lock.
  */
-static int ext4_trim_extent(struct super_block *sb, int start, int count,
-			     ext4_group_t group, struct ext4_buddy *e4b)
+static int ext4_trim_extent(struct super_block *sb,
+		int start, int count, struct ext4_buddy *e4b)
 __releases(bitlock)
 __acquires(bitlock)
 {
 	struct ext4_free_extent ex;
+	ext4_group_t group = e4b->bd_group;
 	int ret = 0;
 
 	trace_ext4_trim_extent(sb, group, start, count);
@@ -5738,8 +5738,7 @@ static int ext4_trim_extent(struct super_block *sb, int start, int count,
 		next = mb_find_next_bit(bitmap, max + 1, start);
 
 		if ((next - start) >= minblocks) {
-			ret = ext4_trim_extent(sb, start,
-					       next - start, group, &e4b);
+			ret = ext4_trim_extent(sb, start, next - start, &e4b);
 			if (ret && ret != -EOPNOTSUPP)
 				break;
 			ret = 0;
-- 
1.8.3.1
