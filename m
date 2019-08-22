Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0B6398B79
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2019 08:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfHVGht (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Aug 2019 02:37:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42939 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728480AbfHVGhs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 22 Aug 2019 02:37:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id i30so3228033pfk.9;
        Wed, 21 Aug 2019 23:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=w8zkc+hg1ldncUHCMP36879SboQhR2ebSLSzLuQQalg=;
        b=fCC4CME5OP8iD39VnZbgUC6+VHsDq/3kYX0AXl4Bkr3z3iQjaP6d2QtT8PvD9DnBo6
         NTd5BCa2WnLtj8mpV8bDRqk240AciNphFci4PqN3rVhTitFXnihroP6imgzFS2aTP7ko
         yaf/pObXlr6PVL8dBDOd5niq7UkBSouOueTGdFjPtjvymGx7f7rwm6QY+He7EqchcFy5
         hSn6aaQSRBZj5VFbUz5ntCTJsEg9YdclO2VqJC9U0rH94uyHHiGCBGVSlswIj7nCANMi
         l+JlkKL/o6D2hwV2lWhCV+wPs3s9IcBxikbwE11J5QZ/XkefeqYnWHt3fUzTxLL71xqU
         8pMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=w8zkc+hg1ldncUHCMP36879SboQhR2ebSLSzLuQQalg=;
        b=rfTS0hxL2s1uqARIpyZHqXfUy/RdWL48JYra9VKOxIupCQdWJV7X9/71pdeKgxM7jO
         uwP1OeN3gCtbHa3UgxFMcbqmsWIC0CUZk1etu+bXGSRQiFPxYnFp9fDCK9zQA9iVgFkX
         pnOXrHMxuS5ct7Rj4/oxjU1KxBQME2tG0/XLGrbAq6Epo1KoGw94dRvH/eCQROYdGnvO
         fmSqTz+PkXAokZP8olxqMmkHh2qZVAcaLsYItYGbVpIcb4/YPbDgk+GtXwsqE0p7bEie
         Mh9FBo27W62vP6qKCzsKwD6QSqZxFlnS7d1Bw9H0cPs/8s4xjZUVkDw+WJCpmaxKgz9p
         F6Sw==
X-Gm-Message-State: APjAAAXuAPvLNFLXh1ifQzKtuwF5g52v1IBkC/+1Xdy90lPe5LlNhg/B
        vXCrUBFU5lrN1ZXg1r259pQ=
X-Google-Smtp-Source: APXvYqwzTV/pvz4d7K8iOa4nlf+wlHkCX08B7MwQa1Rq8ffg7AjQtBVTPvDv4NMuVOOoiTWxNp6kmg==
X-Received: by 2002:a63:c246:: with SMTP id l6mr32706655pgg.210.1566455868053;
        Wed, 21 Aug 2019 23:37:48 -0700 (PDT)
Received: from LGEARND20B15 ([27.122.242.75])
        by smtp.gmail.com with ESMTPSA id e2sm26565941pff.49.2019.08.21.23.37.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 23:37:47 -0700 (PDT)
Date:   Thu, 22 Aug 2019 15:37:43 +0900
From:   Austin Kim <austindh.kim@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        austindh.kim@gmail.com
Subject: [PATCH] ext4: remove unreachable statement inside
 __es_insert_extent()
Message-ID: <20190822063743.GA36528@LGEARND20B15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

__es_insert_extent() never returns -EINVAL after BUG is executed.
So remove unreachable code.
---
 fs/ext4/extents_status.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index a959adc..7f97360 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -781,7 +781,6 @@ static int __es_insert_extent(struct inode *inode, struct extent_status *newes)
 			p = &(*p)->rb_right;
 		} else {
 			BUG();
-			return -EINVAL;
 		}
 	}
 
-- 
2.6.2

