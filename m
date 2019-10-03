Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C15B6C9D71
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Oct 2019 13:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbfJCLe7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Oct 2019 07:34:59 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35942 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729741AbfJCLe6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Oct 2019 07:34:58 -0400
Received: by mail-pl1-f194.google.com with SMTP id j11so1392327plk.3
        for <linux-ext4@vger.kernel.org>; Thu, 03 Oct 2019 04:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YfMvwfleMXIJiuUDe83jEb4CHUSrNdjdWPZ/hSIRHEo=;
        b=c5Jj/0iVAZj+4fvzM89CtFvkKxlu2mWVNqmgzV8BdUYmGtAkvZq0ticEwaFRCSnW9G
         Ih+Vvzy/nK/nMcnSDurf3ueBQv0/JUGF3jO4lkNy09qHZGyGVBbJ1OjOCL0znFFwzbyC
         ojWK9cqAuQBFc2751iQHItiH/YIl4B/uISgcOz+WqmlBdxZurlQA7ybtwgReqvreLg/f
         Hj44ZEbip9vezRxIqs6MkCXKlg8jJZgSBDZxTLgbUKkgnLv468O3plBkvVlj5y6YIyQE
         tiLX7DSXqvW6D/GY3x+dQPHmCAZwZoIY85obEbXCrcKUQ1GagJjE83gW1LaKfhQgxolI
         civg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YfMvwfleMXIJiuUDe83jEb4CHUSrNdjdWPZ/hSIRHEo=;
        b=K9bz+5WJu+pi3lsfoqYvzFxO/NDz/vXhyk2GfNwGv6lBjYeY9pvscjord2Toi9y/bJ
         IXjlw6TGnfcdKQ4tUxGO2KhbvKKUxiLpnrcRVFUSRiRoAXh+4h89LKtJfqnxrSOKhr/M
         PLFep+c0sm8P/CutCgptMyY68Uv4RZrOQHkqfaqIulVD73xw5GDhzwHbpB0rNKAjNKcU
         TIBKE3KgF29TFB1rDpB3u0PUkkbqtP9lzWMg6ij0HexhZ7in1dXPeqRlMQkApuXQGuw8
         H0CwH+r2O7NR1BxnkfENGHbLpvi4M0jaCk0DHAdavuFQkvSv6z1ScQJAtF6wcUL7/ZUi
         e5LQ==
X-Gm-Message-State: APjAAAWO1JOjXkIkfKjBqChUoOOzgEGdpw/I63u0xIK1foSLETGS+6lU
        HDDjsqOWmbsOPy3y7vKOj2jc
X-Google-Smtp-Source: APXvYqyL6dLPffELsuXRAbZPy0iZDn14SONkUyo9LVYMlIJQhS7U0sQNAJqahY74W3zokQwLaU3bVw==
X-Received: by 2002:a17:902:d896:: with SMTP id b22mr8897779plz.140.1570102497827;
        Thu, 03 Oct 2019 04:34:57 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id c16sm2292377pja.2.2019.10.03.04.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 04:34:57 -0700 (PDT)
Date:   Thu, 3 Oct 2019 21:34:51 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: [PATCH v4 7/8] ext4: reorder map.m_flags checks in ext4_set_iomap()
Message-ID: <3551610e53aa1984210a4de04ad6e1a89f5bf0a3.1570100361.git.mbobrowski@mbobrowski.org>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1570100361.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

For iomap direct IO write code path changes, we need to accommodate
for the case where the block mapping flags passed to ext4_map_blocks()
will result in m_flags having both EXT4_MAP_MAPPED and
EXT4_MAP_UNWRITTEN bits set. In order for the allocated unwritten
extents to be converted properly in the end_io handler, iomap->type
must be set to IOMAP_UNWRITTEN, so we need to reshuffle the
conditional statement in order to achieve this.

This change is a no-op for DAX code path as the block mapping flag
passed to ext4_map_blocks() when IS_DAX(inode) never results in
EXT4_MAP_MAPPED and EXT4_MAP_UNWRITTEN being set at once.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
---
 fs/ext4/inode.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e133dda55063..63ad23ae05b8 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3420,10 +3420,20 @@ static int ext4_set_iomap(struct inode *inode, struct iomap *iomap, u16 type,
 		iomap->type = type;
 		iomap->addr = IOMAP_NULL_ADDR;
 	} else {
-		if (map->m_flags & EXT4_MAP_MAPPED) {
-			iomap->type = IOMAP_MAPPED;
-		} else if (map->m_flags & EXT4_MAP_UNWRITTEN) {
+		/*
+		 * Flags passed to ext4_map_blocks() for direct I/O
+		 * writes can result in map->m_flags having both
+		 * EXT4_MAP_MAPPED and EXT4_MAP_UNWRITTEN bits set. In
+		 * order for allocated extents to be converted to
+		 * written extents in the ->end_io handler correctly,
+		 * we need to ensure that the iomap->type is set
+		 * approprately. Thus, we need to check whether
+		 * EXT4_MAP_UNWRITTEN is set first.
+		 */
+		if (map->m_flags & EXT4_MAP_UNWRITTEN) {
 			iomap->type = IOMAP_UNWRITTEN;
+		} else if (map->m_flags & EXT4_MAP_MAPPED) {
+			iomap->type = IOMAP_MAPPED;
 		} else {
 			WARN_ON_ONCE(1);
 			return -EIO;
-- 
2.20.1

