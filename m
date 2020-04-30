Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCEC1C054F
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Apr 2020 20:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgD3Sxm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Apr 2020 14:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgD3Sxl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 30 Apr 2020 14:53:41 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5437C035494
        for <linux-ext4@vger.kernel.org>; Thu, 30 Apr 2020 11:53:41 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id 71so5914614qtc.12
        for <linux-ext4@vger.kernel.org>; Thu, 30 Apr 2020 11:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2pBREp5e/I8/ko671CpIgtMBV8fXR6QsUUzjXlMaVIs=;
        b=i7RnkvTpRlEKz90hCSCsLmG/vBg9oqv7AEE/eqQi4gHdhBKYM6DXnBQxcvc2EN5WCG
         F/L9oG4kwhXUhaI5C3BDT6JBtO9Rp9zGbWgj76Z+sg2eS7Zm1PugtwOLWS8eSoVYXUTi
         g9DBdcwV0qheZwfvy5Kf2iOWPFrKh153YBIQQkqOq2q5vgVvtH3MwyUpUdc2gGJG5pUc
         N865CvdlvI/zjNxhdcRcNcIIxHxp9YmDtoDLgo4PGg8h0EKbrjvsRJ9DwIWC1TUolEth
         935491dx2NRMR6IUrZdpam4vc+q+OHOZHE1KOloWkJ+V2E89o3vvMAwcohZj/u6aXMiB
         gn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2pBREp5e/I8/ko671CpIgtMBV8fXR6QsUUzjXlMaVIs=;
        b=UffrBcgV/doRky7hto9EX15bdkL3IWHD5fsArPADcbkpeSKOctBcgoX1GyBJWVd+Cw
         ddlPsND5bnSWouOAEBW0UvhzbJc/6R57uHRGpcUv+h8Vjed9dhZtC7VliPXMNnuxX8MR
         Ctkc4ROoN7KK6o96+6KzU5eFvYtVVuP+FmwFmZUolv03jrdpHb2Dmkxj15O1lvn3eAT8
         dCDkaBX3QBvUOy8HrRM2ZxY1pQNfyhr+V5YojwwlHoP+JxVB80HUVdwlbuL0l0N30ZEm
         NVr81aUAiQ+Z1rRywC6xZVHYsC1/OfCBMJjthGPqw2lGQWojzLmO+ypODDzK4yEB4dKR
         xkEw==
X-Gm-Message-State: AGi0PuaRiBrlbkrNleej39k9VttfE1McXBcISxxooviefeSno3gXn9d8
        u3+2/fkjZTW1McmY2hBfpmqTkmYU
X-Google-Smtp-Source: APiQypJ/tI81kw3Nvnr5pC/U3RCDCM+5tOxPhw/tpuQSZiXKGXKJcVorWrQ+WSkclE1tNhVgP/SWkg==
X-Received: by 2002:ac8:f10:: with SMTP id e16mr5098939qtk.89.1588272820807;
        Thu, 30 Apr 2020 11:53:40 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id u5sm695815qkm.116.2020.04.30.11.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 11:53:40 -0700 (PDT)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH 1/4] ext4: remove dead GET_BLOCKS_ZERO code
Date:   Thu, 30 Apr 2020 14:53:17 -0400
Message-Id: <20200430185320.23001-2-enwlinux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430185320.23001-1-enwlinux@gmail.com>
References: <20200430185320.23001-1-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There's no call to ext4_map_blocks() in the current ext4 code with a
flags argument that combines EXT4_GET_BLOCKS_CONVERT and
EXT4_GET_BLOCKS_ZERO.  Remove the code that corresponds to this case
from ext4_ext_handle_unwritten_extents().

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 fs/ext4/extents.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index f2b577b315a0..59a90492b9dd 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3826,14 +3826,6 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 	}
 	/* IO end_io complete, convert the filled extent to written */
 	if (flags & EXT4_GET_BLOCKS_CONVERT) {
-		if (flags & EXT4_GET_BLOCKS_ZERO) {
-			if (allocated > map->m_len)
-				allocated = map->m_len;
-			err = ext4_issue_zeroout(inode, map->m_lblk, newblock,
-						 allocated);
-			if (err < 0)
-				goto out2;
-		}
 		ret = ext4_convert_unwritten_extents_endio(handle, inode, map,
 							   ppath);
 		if (ret >= 0)
-- 
2.20.1

