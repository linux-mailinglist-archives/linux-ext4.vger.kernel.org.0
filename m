Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A2A44D3D8
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Nov 2021 10:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhKKJSC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Nov 2021 04:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhKKJSB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 Nov 2021 04:18:01 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B301C061766;
        Thu, 11 Nov 2021 01:15:13 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id s136so4665803pgs.4;
        Thu, 11 Nov 2021 01:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=beU5aceKFwABCb+3lwlQrV/S2P2+voj/+9eyjOHxJeU=;
        b=J0BFUNp5xhautFSFk7R4PYmbr7tLv9qR7LWifqzrBooIdpX8PPUHNtJSVlpVcJ6IBw
         ONNNwKHDpa+lg1LapTs7XtEDUPtMYaKVRJtGn77StI9TS4mKfDXNAa5jtlHOFj9o+jjm
         Dr5amyELLnF/B7DBxvTXE45G+PMbNmRtxdBRwLQX6Eoryt5Gubsa45H12oaLg+PWyVAn
         /Aj0E26pOMNCQwWzGJRRKIS/Cir4gGTFf3EdqT0D68XBLsqw8rWvIyqbgl4P4vzlw463
         l/3QO3OMEz9bJUtFka3OLRnWGrp94WEqZiIseyU3h7r1oitvWPgz4wdTbikIcELPireB
         fHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=beU5aceKFwABCb+3lwlQrV/S2P2+voj/+9eyjOHxJeU=;
        b=P17Ss9kNKs03E5Jaspt+0SdJXTr+itZjXh2FCnlnfA9rkjtym4LaSsBmQcl6Mo6/u6
         UWQOA0oIcs0bAg9hObMGJhZ0JIS1g0OjP+eVHe5nUV5y669ma5PvRb8ivd0XbW32zXqT
         0N+SWUWc58ahDlaB8266ix/LVYJKNrgFQKKbWAqhtOehhrXy168ko4VHUuMK/EgWDlKQ
         ip1zC5tAHT8gUktwNPQn550GWdLoWffi0w4zYo5i+oLaCywA4/kTOfG/XPWY4+3Lf0Fn
         Ir0M0t0V7txpomAZGfP/GesfpypJaqP5Zr3vrE1nlhZKKT57lT2qxUjbzNzLVA/Z7vWL
         d+0w==
X-Gm-Message-State: AOAM533Hv6Vrzwiv0dkGQo4yk3DG2xViQLYIrlXAIRsGKRA5j76rt+cy
        fdD/ke1BzltVEiH3obHtZAjSMVfdBjg=
X-Google-Smtp-Source: ABdhPJwTeyvV7Gxa5TTCqcl2O8VjlJyOLBxRwl2dRp4EzBnJBTW3sZXgGiIEPOWZHlQrO/pKibFxmw==
X-Received: by 2002:aa7:87c5:0:b0:4a0:25d0:d88c with SMTP id i5-20020aa787c5000000b004a025d0d88cmr5280902pfo.43.1636622112651;
        Thu, 11 Nov 2021 01:15:12 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p14sm1908707pjb.9.2021.11.11.01.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 01:15:12 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: luo.penghao@zte.com.cn
To:     Theodore Ts' <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ext4: Delete unused statements
Date:   Thu, 11 Nov 2021 09:15:07 +0000
Message-Id: <20211111091507.159465-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: luo penghao <luo.penghao@zte.com.cn>

The assignment statement is at the end of the function, and
local variables will not be used.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 fs/ext4/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0f06305..642cb76 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2285,7 +2285,6 @@ static int mpage_process_page(struct mpage_da_data *mpd, struct page *page,
 	} while (lblk++, (bh = bh->b_this_page) != head);
 
 	io_end_vec->size += io_end_size;
-	io_end_size = 0;
 	*map_bh = false;
 out:
 	*m_lblk = lblk;
-- 
2.15.2


